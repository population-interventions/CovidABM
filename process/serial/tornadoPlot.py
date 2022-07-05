
import plotly.graph_objects as go
from plotly.offline import plot
from matplotlib import pyplot

import process.shared.utilities as util

def MakeExamplePlot():
	years = ['2017','2018','2019','2020','2021']
	sr1 = [228572, 265809, 259968,274150,365817]
	sr2=[141702, 163826, 162264,170143,212981]
	#convert sr1
	sr3 = [ -i for i in sr2 ]
	fig = go.Figure()
	fig.add_trace(
		go.Bar(
			y=years, x=sr1,
			base=0,
			marker_color='rgb(158,202,225)',
			name='Revenue',
			marker_line_color='rgb(8,48,107)',
			orientation='h',
			marker_line_width=1.5,
			opacity= 0.7,
			text = sr1,
			textposition='auto',
			texttemplate = "%{x:,s}(M$) "
		)
	)
	fig.add_trace(go.Bar(y=years, x=sr2,
		base=sr3,
		marker_color='crimson',
		name='COGS<br>(Cost of Goods Sold)',
		marker_line_color='red',
		orientation='h',
		marker_line_width=1.5,
		opacity= 0.7,
		text = sr3,
		textposition='auto',
		texttemplate = "%{x:,s}(M$) ")
	)
	fig.update_layout(
		height=500,
		margin=dict(t=50,l=10,b=10,r=10),title_text="Apple Inc Revenue & Expense from 2017 to 2021",
		title_font_family="sans-serif",
		#legend_title_text=’Financials’,
		title_font_size = 25,
		title_font_color="darkblue",
		title_x=0.5 #to adjust the position along x-axis of the title
	)
	fig.update_layout(
		barmode='overlay', 
		xaxis_tickangle=-45, 
		legend=dict(
			x=0.80,
			y=0.01,
			bgcolor='rgba(255, 255, 255, 0)',
			bordercolor='rgba(255, 255, 255, 0)'
		),
		yaxis=dict(
			title='Year',
			titlefont_size=16,
			tickfont_size=14
		),
		bargap=0.30
	)
	plot(fig)


def MakePlot(metric, plotData, median, saveDir=False, showBrowser=False):
	plotData = dict(sorted(
		plotData.items(),
		key=lambda item: abs(item[1]['value'][1] - item[1]['value'][0])))
	
	# Swap values that are out of order
	for k, v in plotData.items():
		if v['value'][1] < v['value'][0]:
			plotData[k]['value'] = [v['value'][1], v['value'][0]]
			plotData[k]['range'] = [v['range'][1], v['range'][0]]
	
	titles = [
		'{} ({} to {})'.format(
			k, util.RoundNumber(v['range'][0]), util.RoundNumber(v['range'][1]))
		for k, v in plotData.items()
	]
	sr1 = [d['value'][0] for d in plotData.values()]
	sr2=[d['value'][1] for d in plotData.values()]
	
	figTitle = "Sensitivity for {}".format(metric)
	
	#titles = ['2017','2018','2019','2020','2021']
	#sr1 = [228572, 265809, 259968,274150,365817]
	#sr2=[141702, 163826, 162264,170143,212981]
	#sr3=[141702, 163826, 162264,170143,212981]
	
	fig = go.Figure()
	fig.add_trace(
		go.Bar(
			y=titles, x=sr1 - median,
			base=median,
			marker_color='crimson',
			name='Lower quintile',
			marker_line_color='red',
			orientation='h',
			marker_line_width=1,
			opacity= 0.65,
			text = [util.RoundNumber(x) for x in sr1],
			textposition='auto',
		)
	)
	fig.add_trace(
		go.Bar(
			y=titles, x=sr2 - median,
			base=median,
			marker_color='rgb(158,202,225)',
			name='Upper quintile',
			marker_line_color='rgb(158,202,225)',
			orientation='h',
			marker_line_width=1,
			opacity= 0.7,
			text = [util.RoundNumber(x) for x in sr2],
			textposition='auto',
			textfont_color = 'rgba(0,0,0,255)',
		)
	)
	fig.update_layout(
		width=1800,
		height=1200,
		margin=dict(t=50,l=10,b=10,r=10),
		title_text=figTitle,
		title_font_family="sans-serif",
		#legend_title_text=’Financials’,
		title_font_size = 25,
		title_font_color="darkblue",
		title_x=0.5 #to adjust the position along x-axis of the title
	)
	fig.update_layout(
		barmode='overlay', 
		xaxis_tickangle=-45, 
		legend=dict(
			x=0.90,
			y=0.01,
			bgcolor='rgba(255, 255, 255, 0)',
			bordercolor='rgba(255, 255, 255, 0)'
		),
		yaxis=dict(
			title='Sensitivity',
			titlefont_size=16,
			tickfont_size=14
		),
		bargap=0.30
	)
	
	if saveDir:
		util.MakePath(saveDir + '/')
		fig.write_image('{}/{}_plot.png'.format(saveDir, metric))
	if showBrowser:
		plot(fig)
