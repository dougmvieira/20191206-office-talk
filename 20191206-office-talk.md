---
title: <small> High-frequency options market making </small>
author:
- <b> Office talk </b>
- Douglas Vieira
- Imperial College London
- Supervisors&colon; Prof Rama Cont and Dr Mikko Pakkanen
date: 6 December 2019
---


# Introduction

## Motivation

- Gap in the literature. Known papers in options market making:
    #. [@stoikov2009option],
    #. [@el2015stochastic],
    #. [@baldacci2019algorithmic].
  
- Focus on high-frequency regime for tractability

# Optimal market making review

## Overview

- Bid and ask quotes $S^\mathrm{ask}_t$ and $S^\mathrm{bid}_t$ are posted around
  a reference price

$$ dS_t = \mu dt + \sigma dW_t $$

- Trades at bid and ask prices are point processes $N^\mathrm{bid}$,
  $N^\mathrm{ask}$ with arrival rates

$$ \Lambda^\mathrm{bid}_t = \Lambda(S^\mathrm{ask}_t - S_t), \quad
   \Lambda^\mathrm{ask}_t = \Lambda(S^\mathrm{bid}_t - S_t) $$
$$ \Lambda(\delta) = Ae^{-k\delta} $$

## Optimisation problem

- Inventory and cash
$$ \begin{align}
dq_t & = dN^\mathrm{bid}_t - dN^\mathrm{ask}_t, \\
dX_t & = S^\mathcal{ask}_t dN^\mathrm{ask}_t - S^\mathcal{bid}_t dN^\mathrm{bid}_t.
\end{align} $$
 
- Market maker optimises CARA utility on terminal wealth with risk aversion
  parameter $\gamma$
$$ \mathbb E\left[ Y_T - \frac{1}{2} \gamma \int_0^T q_{t-}^2 d[S]_t \right], \quad
   Y_t = X_t + q_t S_t $$

## {data-background-iframe="20190226/skew_plot.html"}

## {data-background-iframe="20190226/spread_plot.html"}

## HJB equation

Optimal controls satisfy

<small>
$$ \begin{align*}
\delta^\mathrm{bid}(t, q, z) &
= \frac{1}{\kappa} - u(t, q + 1, z) + u(t, q, z), \\
\delta^\mathrm{ask}(t, q, z)
& = \frac{1}{\kappa} - u(t, q - 1, z) + u(t, q, z).
\end{align*} $$
</small>

where the value function satisfies the PIDE

<small>
$$ \begin{align}
( \partial_t + \mathcal L^S ) u + \mu q
& + \frac{A}{e \kappa} e^{ \kappa \left( u(t, q + 1, S) - u(t, q, S) \right) } \\
& + \frac{A}{e \kappa} e^{ \kappa \left( u(t, q - 1, S) - u(t, q, S) \right) }
= \frac{1}{2} \gamma \sigma^2 q^2, \\ 
& u(T, q, z) = 0
\end{align} $$
</small>

## Solutions

- Formula for exact solution available only in the single-asset case
- For the multi-asset,
  - Exact solution is described as a system of ODEs
  - Compact solutions exist for infinite horizon and small inventory/risk
    aversion


# Stochastic volatility

## Option representation

*Lemma* Let the market state process $(X_t)_{t\in[0,T]}$ be a continuous
semimartingale. Assume the existence of an ELMM $\mathbb Q$ where
$(X_t)_{t\in[0,T]}$ is a Markov process. Then, a no-arbitrage price process
$(C_t)_{t\in[0,T]}$ of an $\mathcal F_T$-measurable claim $f(X_T) \geq 0$ is
given by
$$  C_t = \varphi(t, X_t), \quad
    \varphi(t, x) = \mathbb E^{\mathbb Q}[f(X_{T - t}) \mid X_0 = x]. $$

If $\varphi$ is of class $\mathcal C^{1, 2}(U)$, then
$$  dC_t = \nabla_x\varphi(t, X_t)dX_t, \quad \forall t \in [0, T). $$

## Small time asymptotics

*Theorem* Let $X$ be a sufficiently integrable Itô diffusion, of the form

$$ dX_t = \mu_t dt + \sigma_t dW_t, $$

$$ \text{then } \frac{X_t - \tilde X_t}{\sqrt t} \xrightarrow{L^2} 0, \text{ as } t\to 0,$$

$$ \text{where } d\tilde X_t = \sigma_0 dW_t. $$

## Heston model simulation

## {data-background-iframe="20180528/heston.html"}

## Role of stochastic volatility

- Applying small time asymptotics to option prices,

$$ d\tilde C_t = \nabla_x\varphi(X_0) d\tilde X_t $$

- In particular, if the market state is $(S, V)$,

$$ d\tilde C_t = \Delta_0 d\tilde S_t + \mathcal{V}_0 d\tilde V_t$$

- Options still depend on volatility
  - Despite prices losing stochastic volatility
  - Volatility links different time scales
  
## Empirical analysis

- Approach
  #. Option representation gives option dynamics
  #. Small time asymptotics linearises option dynamics

- We obtain the linear model for options
$$ \begin{align}
C_{t+h} - C_t = & \Delta(S_{t+h} - S_t) \\
& + \mathcal{V}(V_{t+h} - V_t) + \epsilon_{t+h}.
\end{align} $$

## Recovering Greeks

- Microstructure effects don't bias Greeks estimation

- Role of stochastic volatility
  - Contributes to explaining option price changes
  - Enhance the explanatory power of the underlying price

- Vega is successfully recovered for the first time
  - Compare with [@abergel2012drives]

## Heston vs Empirical Delta for call options

## {data-background-image="20190716/compare_deltas_call.png" data-background-size=contain}

## Heston vs Empirical Vega for call options

## {data-background-image="20190716/compare_vegas_call.png" data-background-size=contain}


# High-frequency options market making
  
## Overview

- Incorporate stochastic volatility by using the model by [@fodra2013high]
- Develop extensions:
  #. Incorporate option dynamics
  #. Let the quotes be a function of, e.g., moneyness and time to expiry

## Options market making model

- Price dynamics
$$ dC_{t, p} = \Delta_{t, p} \cdot dS_t, \quad
   dS_t = \mu_t dt + \sigma_t dW_t, $$

- Trade dynamics ($n^\mathrm{ask}$ and $n^\mathrm{bid}$ intensities)

$$ \begin{align}
\lambda_t^\mathrm{bid}(dp) & = e^{-\kappa_{t, p} \delta_{t, p}^\mathrm{bid}} A_t(dp), \\
\lambda_t^\mathrm{ask}(dp) & = e^{-\kappa_{t, p} \delta_{t, p}^\mathrm{ask}} A_t(dp). 
\end{align} $$

## Options market making model (cont.)

- Inventory process

$$ q_t(dp) = \int_0^t n^\mathrm{bid}(ds \times dp)
           - \int_0^t n^\mathrm{ask}(ds \times dp), $$

- Cash process

$$ dX_t = \int_{\mathcal P} C^\mathcal{ask}_{t, p} n^\mathrm{ask}(dt \times dp) 
        - \int_{\mathcal P} C^\mathcal{bid}_{t, p} n^\mathrm{bid}(dt \times dp). $$

## Options market making model (cont.)

- Wealth process

$$ Y_t = X_t + \int_{\mathcal P} C_{t, p} q_t(dp) $$

- Maximisation criterion

$$ \mathbb E \left[ Y_T - \frac{1}{2} \gamma \int_{(0, T] \times \mathcal P^2} q_{t-}(dp)q_{t-}(dq)d[C_p, C_q]_t \right] $$

## Optimal mid-price

$$ \begin{align}
\frac{ C^\mathrm{bid}_{t, p} + C^\mathrm{ask}_{t, p}}{2} = 
   & \mathbb E \left[ C_{T, p} \mid \mathcal F_t \right]
   - \gamma (T - t) \Delta_{t, p} \cdot \sigma_t \sigma_t^\top g_t \\
   & + o(T - t) + O(\gamma^2),
\end{align} $$

$$ g_t = \int_{\mathcal P} \Delta_{s, p} q_t(dp). $$
     
## Optimal half-spread

$$ \begin{align}
\frac{ C^\mathrm{ask}_{t, p} - C^\mathrm{bid}_{t, p}}{2} = 
  & \frac{1}{\kappa_{t, p}}
  + \frac{1}{2} \gamma (T - t) \Delta_{t, p} \cdot \sigma_t \sigma_t^\top
    \Delta_{t, p} \\ & + o(T - t) + O(\gamma^2).
\end{align} $$

## Structure of options spreads

#. Spread does not depend on base trade activity
#. Assume $\kappa_{t, p}$ is constant in moneyness
#. Linear regression gives us $\kappa$ and $\gamma$

## {data-background-image="20191203/optimal_spread_rel.png" data-background-size=contain}

## Trade activity versus spreads

## {data-background-image="20191203/spread.png" data-background-size=contain}

## {data-background-image="20191203/trade_activity.png" data-background-size=contain}

# Conclusion

## Conclusion

- Stochastic volatility drives high-frequency options prices
- Small risk aversion gives explicit optimal quotes
- Optimal spreads compatible with data
- Small spreads imply higher trade activity 

## Thank you!

- Find this presentation and its source code at

<https://github.com/dougmvieira/presentations>

## References {.scrollable}
