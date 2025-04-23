// ignore_for_file: non_constant_identifier_names

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_crypto_senseier/controller/sense.dart';
import 'package:flutter_crypto_senseier/controller/user.dart';
import 'package:get/get.dart';

class CommonSense extends StatefulWidget {
  const CommonSense({super.key});

  @override
  State<CommonSense> createState() => CommonSenseState();
}
class CommonSenseState extends State<CommonSense> with SingleTickerProviderStateMixin {
  Timer? _timer;
  int _remainingTime = 10;
  late AnimationController _controller;
  late Animation<double> _animation;

  int get readIndex => SenseController.readIndex.value;
  bool get isReaded => SenseController.isReaded.value;
  
  @override
  void initState() {
    super.initState();
    if (isReaded) {
      setState(() => _remainingTime = 0);
    } else {
      _startTimer();
    }
  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _startTimer() {
    _controller = AnimationController(duration: Duration(seconds: 10), vsync: this)..forward();
    _animation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: _controller, curve: Curves.linear));
    if (_timer != null && _timer!.isActive) return;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_remainingTime > 0) {
          _remainingTime--;
        } else {
          _timer?.cancel();
          _timer = null;
        }
      });
    });
  }

  void _onFinish() {
    if (isReaded) return Get.back();
    SenseController.finishSense();
    UserController.increaseXP(20);
    showDialog(
      context: context,
      useSafeArea: false,
      builder: (_) => Material(
        color: Colors.black12,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              bottom: (MediaQuery.of(context).size.height - 327) / 2,
              child: Container(
                width: 323,
                height: 527,
                decoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage('assets/images/bg/well_done.png'), fit: BoxFit.cover)
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      height: 264,
                      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                      child: Column(
                        children: [
                          Text('You finish this common sense', style: TextStyle(color: Color(0xFF282B32), fontSize: 16, fontWeight: FontWeight.w500)),
                          SizedBox(height: 50),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset('assets/icons/xp.png', width: 32),
                              Text('+20', style: TextStyle(color: Color(0xFF282B32), fontSize: 16, fontWeight: FontWeight.w700))
                            ]
                          ),
                          Spacer(),
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: 54,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor: Color(0xFF4C1AE2),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                              ),
                              onPressed: () {
                                Get.back();
                              },
                              child: Text('Claim', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700))
                            ),
                          )
                          
                        ]
                      ),
                    )
                  ]
                )
              )
            )
          ],
        )
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(child: Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF1D4ED8), Color(0xFF4C1AE2)],
          stops: [0, 1], // 调整渐变范围
        ),
      ),
      child: Column(
        children: [
          AppBar(
            backgroundColor: Colors.transparent,
            leading: GestureDetector(
              onTap: () => Get.back(),
              child: Icon(Icons.close_rounded),
            ),
            iconTheme: IconThemeData(color: Colors.white),
            centerTitle: true,
            title: Text('Common Sense', style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold
            )),
          ),
          Expanded(child: Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.fromLTRB(16, 16, 16, MediaQuery.of(context).padding.bottom + 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Why invest in crypto?', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w700)),
                SizedBox(height: 16),
                Expanded(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    clipBehavior: Clip.none,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24)
                    ),
                    child: Stack(clipBehavior: Clip.none, children: [
                      CustomScrollView(slivers: [
                        SliverToBoxAdapter(child: Container(
                          padding: EdgeInsets.all(16),
                          child: SenseContent(),
                        ))
                      ]),
                      Positioned(top: -96, right: -32, child: Image.asset('assets/icons/sense_${readIndex+1}.png', width: 160))
                    ])
                  )
                ),
                FooterBtn()
              ]
            ),
          ))
        ],
      ),
    ));
  }

  Widget SenseContent() {
    List senseList = [Sense_1(), Sense_2(), Sense_3(), Sense_4(), Sense_5(), Sense_6(), Sense_7(),];
    return senseList[readIndex];
  }

  Widget TextTitle(text) {
    return Container(
      padding: EdgeInsets.only(bottom: 8),
      child: Text(text, style: TextStyle(color: Color(0xFF15171C), fontSize: 16, fontWeight: FontWeight.w700, height: 1.8)),
    );
  }
  Widget TextContent(text) {
    return Container(
      padding: EdgeInsets.only(bottom: 16),
      child: Text(text, style: TextStyle(color: Color(0xFF494D55), fontSize: 16, fontWeight: FontWeight.w500, height: 1.3)),
    );
  }
  Widget Sense_1() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextTitle('1. High Growth Potential'),
        TextContent('Many cryptocurrencies have shown explosive growth.'),
        TextContent('Bitcoin, for example, went from a few cents to tens of thousands of dollars in just over a decade.'),
        TextContent('Potential payoff: Early adopters of successful coins can see massive returns.'),
        TextTitle('2. Global and Borderless'),
        TextContent("Crypto isn't tied to any one country."),
        TextContent("You can send, receive, and store digital assets anywhere in the world — 24/7."),
        TextContent("Benefit: No banks, no borders, just direct access."),
        TextTitle('3. Decentralization and Control'),
        TextContent("When you invest in crypto, you're not relying on banks or governments."),
        TextContent("You hold your own keys, control your own funds, and take full responsibility."),
        TextContent("True ownership of your money — for better or worse."),
        TextTitle('4. Diversification'),
        TextContent("Crypto can act as a new asset class in your portfolio."),
        TextContent("It doesn’t always move with traditional markets like stocks or bonds."),
        TextContent("Smart investing: Some investors add crypto to reduce overall risk and boost returns."),
        TextTitle('5. Hedge Against Inflation'),
        TextContent("Certain cryptocurrencies like Bitcoin have limited supply."),
        TextContent("That makes them attractive when fiat currencies lose value due to inflation."),
        TextContent("Idea: A digital alternative to gold."),
        TextTitle('6. Innovation and Utility'),
        TextContent("Investing in crypto is also investing in future technology."),
        TextContent("From decentralized finance (DeFi) to NFTs, the space is growing fast."),
        TextContent("Support the future of money, art, gaming, and more."),
        TextTitle('7. Learning by Doing'),
        TextContent("Even small investments can help you understand how crypto works."),
        TextContent("Wallets, exchanges, and blockchain principles all become clearer with hands-on experience."),
        TextContent("Low-cost learning: Start small, gain knowledge."),
        TextContent("But Remember: It’s Risky!"),
        TextContent("Crypto is exciting but volatile."),
        TextContent("Before you invest, learn the risks — and never invest money you can’t afford to lose."),
      ],
    );
  }
  Widget Sense_2() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextTitle('What Does "Trending" Mean in Crypto?'),
        TextContent('In the crypto world, "trending tokens" are cryptocurrencies that are gaining sudden popularity or attention.'),
        TextContent('They might be trending because of price spikes, big news, social media hype, or rising trading volume.'),
        TextContent('Trending = Popular + Active'),
        TextContent('Why Are Tokens Trending?'),
        TextContent('There are a few reasons a token might trend:'),
        TextContent('Price Surge – A big upward move can attract attention.'),
        TextContent('News & Partnerships – Announcements, listings, or partnerships can drive hype.'),
        TextContent('Community Buzz – Trending on Twitter, Reddit, or TikTok can make a token go viral.'),
        TextContent('Price Crashes – Even sharp drops can cause a token to trend (not always in a good way!).'),
        TextTitle("Examples of Trending Tokens (Categories)"),
        TextContent('Here are some types of tokens that often trend:'),
        TextContent('1. Top Market Cap Coins'),
        TextContent('Tokens like Bitcoin (BTC) and Ethereum (ETH) often trend simply due to their influence and movement.'),
        TextContent('2. AI & Tech Tokens'),
        TextContent('Tokens related to artificial intelligence or cutting-edge tech projects (e.g., Render (RNDR), Fetch.ai (FET)).'),
        TextContent('3. DeFi Tokens'),
        TextContent('DeFi platforms like Uniswap (UNI) or Aave (AAVE) can trend when DeFi usage spikes.'),
        TextContent('4. NFT/Gaming Tokens'),
        TextContent('Games or NFT projects often bring attention to tokens like Immutable X (IMX) or Axie Infinity (AXS).'),
        TextContent('5. Meme Tokens'),
        TextContent('Tokens like DogeCoin (DOGE) or Pepe (PEPE) trend due to viral culture—even with no real use case!'),
        TextTitle("Should You Follow the Trend?"),
        TextContent('Trending tokens can be exciting — but be careful.'),
        TextContent('Price can drop quickly after a trend fades.'),
        TextContent('Some tokens trend due to hype or scams.'),
        TextContent("Always research before acting. Don't follow the crowd blindly."),
        TextContent('Pro Tip: Use trending tokens as a way to explore and learn, not as investment advice.'),
        TextContent('Where to Find Trending Tokens?'),
        TextContent('You can track trending tokens through:'),
        TextContent('Coin tracking apps like CoinMarketCap, CoinGecko'),
        TextContent('Crypto exchanges (many show “Top Gainers” or “Most Viewed”)'),
        TextContent('Social media platforms'),
        TextContent('Your own crypto learning app’s "Trending" section'),
      ],
    );
  }
  Widget Sense_3() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextTitle('What Is Cryptocurrency?'),
        TextContent('Cryptocurrency is a type of digital asset that uses cryptography for secure transactions.'),
        TextContent('Unlike traditional money, it operates on decentralized networks, mostly based on blockchain technology. The most popular cryptocurrencies include Bitcoin (BTC), Ethereum (ETH), and Ripple (XRP).'),
        TextContent('While cryptocurrencies were initially created as a new form of money, they are now also viewed as investment vehicles by many.'),
        TextTitle("How Is Crypto Used as an Investment Tool?"),
        TextContent("Cryptocurrency, much like stocks or bonds, has become a popular investment tool for people looking to grow their wealth or diversify their portfolios. But is it really a safe or effective investment? Let's break it down."),
        TextContent('1. Potential for High Returns'),
        TextContent('Cryptocurrencies are known for their high volatility — their prices can experience dramatic ups and downs in a short period of time.'),
        TextContent('Potential for gains: If you buy in at a lower price and the market surges, you can make a substantial profit.'),
        TextContent("Example: Bitcoin, for instance, has seen its value grow from just \$1 in 2011 to over \$60,000 in 2021."),
        TextContent('2. Risk Factor: Volatility'),
        TextContent('While the potential rewards are high, the risks are also significant.'),
        TextContent('Cryptocurrencies can fluctuate drastically in price within minutes, leading to potential losses as well as gains.'),
        TextContent('Example: Bitcoin, despite its long-term growth, has experienced sharp drops, including one of 30% within a week.'),
        TextContent('3. Long-Term Investment (HODL)'),
        TextContent('Many investors take a long-term approach, holding onto their assets in the hopes that over time, they will increase in value.'),
        TextContent('HODL (a term meaning "hold on for dear life") is common in the crypto community for long-term investors who believe in the future growth of cryptocurrencies.'),
        TextContent('Crypto can act as a store of value, like gold, with some believing that as the adoption of digital currency increases, the price will continue to grow.'),
        TextTitle('Is It a Safe Investment?'),
        TextContent('1. Security Issues'),
        TextContent('Unlike traditional investments, cryptocurrencies are stored in digital wallets, which are prone to hacking and theft if not properly secured.'),
        TextContent('Investors must use strong passwords and two-factor authentication to protect their holdings.'),
        TextContent('2. Lack of Regulation'),
        TextContent('The crypto market is still relatively unregulated, which exposes investors to potential fraud or scams. However, some countries are starting to put regulations in place to address these concerns.'),
        TextContent('3. Legal and Market Risk'),
        TextContent('Cryptocurrencies can be subject to government regulations that could change or restrict their use. In addition, cryptocurrencies are often susceptible to market manipulation and speculation, which can make them risky.'),
        TextContent('Crypto as Part of an Investment Portfolio'),
        TextContent('While crypto can offer significant growth potential, experts suggest it should be considered as part of a diversified portfolio.'),
        TextContent('Don’t put all your eggs in one basket: Like stocks or real estate, diversify your investment across different assets to spread the risk.'),
        TextContent('Investing in Crypto for Diversification: Some investors use crypto as a hedge against traditional investments like stocks or bonds.'),
        TextTitle('Key Takeaways'),
        TextContent('1. Cryptocurrency can be an investment tool, but it comes with high volatility and risks.'),
        TextContent('2. The potential for high returns is significant, but losses can happen quickly.'),
        TextContent('3. Crypto can be used as a long-term store of value or part of a diversified portfolio. Always ensure you understand the risks before investing.'),
      ],
    );
  }
  Widget Sense_4() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextTitle('What Is a Crypto Wallet?'),
        TextContent('A crypto wallet is a digital tool that lets you store, send, and receive cryptocurrencies.'),
        TextContent('Instead of holding physical coins, it stores your private keys — the passwords that give you access to your assets.'),
        TextTitle("Two Main Categories:"),
        TextContent('There are two broad types of wallets:'),
        TextContent('1. Hot Wallets (connected to the internet)'),
        TextContent('2. Cold Wallets (offline and more secure)'),
        TextTitle("Hot Wallets"),
        TextContent("These wallets are internet-connected and great for everyday use. They're convenient but more vulnerable to hacks."),
        TextContent('Types of Hot Wallets:'),
        TextContent('Mobile Wallets '),
        TextContent('Apps on your phone'),
        TextContent('Example: Trust Wallet, MetaMask'),
        TextContent('Great for on-the-go access'),
        TextContent('Desktop Wallets'),
        TextContent('Installed on your computer'),
        TextContent('Example: Exodus, Electrum'),
        TextContent('More features and full control'),
        TextContent('Web Wallets '),
        TextContent('Access via browser'),
        TextContent('Example: Coinbase, Binance'),
        TextContent('Easy to use but rely on third parties'),
        TextContent('Reminder: Hot wallets are user-friendly but keep only small amounts of crypto here.'),
        TextContent('Cold Wallets'),
        TextContent('These wallets are offline, offering maximum security. They’re ideal for long-term storage of large amounts.'),
        TextTitle("Types of Cold Wallets:"),
        TextContent('Hardware Wallets'),
        TextContent('Physical devices (USB-like)'),
        TextContent('Example: Ledger, Trezor'),
        TextContent('Immune to most online attacks'),
        TextContent('Paper Wallets'),
        TextContent('Printed private/public keys on paper'),
        TextContent('Very secure if stored safely'),
        TextContent('Risk of physical damage or loss'),
        TextContent('Air-Gapped Wallets '),
        TextContent('Stored on devices that never connect to the internet'),
        TextContent('Used by professionals for ultimate security'),
        TextContent('Pro Tip: Use cold wallets for savings, and hot wallets for spending.'),
      ],
    );
  }
  Widget Sense_5() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextTitle('What Is a Crypto Exchange?'),
        TextContent('A cryptocurrency exchange is a digital platform where users can buy, sell, or trade cryptocurrencies like Bitcoin, Ethereum, and many others.'),
        TextContent('Just like stock markets, exchanges act as marketplaces, but for digital assets.'),
        TextTitle("1. Centralized Exchanges (CEX)"),
        TextContent('Definition:'),
        TextContent('A centralized exchange is run by a company or organization that manages the platform.'),
        TextContent('Examples: Binance, Coinbase, Kraken'),
        TextContent('Features:'),
        TextContent('Easy to use (great for beginners)'),
        TextContent('High liquidity (lots of trading activity)'),
        TextContent('Support for fiat money (USD, EUR, etc.)'),
        TextContent('Requires KYC (identity verification)'),
        TextContent('Drawbacks:'),
        TextContent('You don’t control your private keys (“Not your keys, not your crypto”)'),
        TextContent('Can be hacked or go offline'),
        TextTitle("2. Decentralized Exchanges (DEX)"),
        TextContent('Definition:'),
        TextContent('A DEX allows users to trade crypto directly with one another, without a central authority.'),
        TextContent('Examples: Uniswap, PancakeSwap, SushiSwap'),
        TextContent('Features:'),
        TextContent('No sign-up or identity verification'),
        TextContent('You keep full control of your funds'),
        TextContent('Transparent and open-source'),
        TextContent('Drawbacks:'),
        TextContent('Requires a crypto wallet like MetaMask'),
        TextContent('Might have higher fees and slower speeds'),
        TextContent('Less beginner-friendly'),
        TextTitle("3. Hybrid Exchanges"),
        TextContent('Definition:'),
        TextContent('A hybrid exchange combines the ease of use of centralized exchanges with the security and privacy of decentralized ones.'),
        TextContent('Examples: Nash, Qurrex'),
        TextContent('Features:'),
        TextContent('Faster transactions'),
        TextContent('Enhanced privacy'),
        TextContent('Still under development, less common'),
        TextTitle("4. Simulated Exchanges (for learning)"),
        TextContent('Definition:'),
        TextContent('These are practice platforms or games where users can try trading with virtual money.'),
        TextContent('Examples: BitSimTrade, TradingView’s simulator'),
        TextContent('Features:'),
        TextContent('No real money involved'),
        TextContent('Great for learning'),
        TextContent('Risk-free environment'),
        TextContent('Fake exchanges'),
        TextContent('Airdrop scams'),
        TextContent('Phishing websites'),
        TextContent('Rug pulls (project creators vanish with funds)'),
        TextContent('Be cautious: Avoid “get-rich-quick” schemes on social media.'),
      ],
    );
  }
  Widget Sense_6() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextTitle('Definition'),
        TextContent("A gas fee is the transaction fee users pay to perform actions on a blockchain network, especially Ethereum."),
        TextContent("Think of it like paying a toll to use a busy highway. You're paying the network to process and validate your transaction."),
        TextContent("Why Is It Called “Gas”?"),
        TextContent("Just like cars need gas to move, blockchains need gas to power actions like:"),
        TextContent("Sending cryptocurrency"),
        TextContent("Minting or transferring NFTs"),
        TextContent("Using decentralized apps (dApps)"),
        TextContent("Deploying smart contracts"),
        TextTitle("How Does It Work?"),
        TextContent("When you make a transaction, it’s sent to the blockchain network. Miners (or validators) choose which transactions to confirm."),
        TextContent("To incentivize them, users offer gas fees. The higher the gas fee, the faster your transaction gets picked."),
        TextContent("What Affects the Gas Fee?"),
        TextContent("Gas fees aren’t fixed — they change constantly based on:"),
        TextContent("Network demand"),
        TextContent("More users = higher fees (like surge pricing)."),
        TextContent("Transaction complexity"),
        TextContent("Simple transfers use less gas. Smart contracts use more."),
        TextContent("Blockchain type"),
        TextContent("Ethereum usually has higher fees. Others like Solana or Polygon are cheaper"),
        TextContent("Gas Fee Components (Ethereum example)"),
        TextContent("Gas Limit: Max units of gas you're willing to spend"),
        TextContent("Gas Price: Amount you pay per unit (in gwei, a small ETH unit)"),
        TextContent("Total Gas Fee = Gas Limit × Gas Price"),
        TextContent("Example"),
        TextContent("You send ETH to a friend"),
        TextContent("Gas Limit: 21,000 units"),
        TextContent("Gas Price: 50 gwei"),
        TextContent("Fee = 21,000 × 50 = 1,050,000 gwei = 0.00105 ETH"),
        TextContent("What Happens If I Don’t Pay Enough?"),
        TextContent("Your transaction may be delayed or fail"),
        TextContent("You’ll still pay gas for failed transactions!"),
        TextTitle("Key Tips"),
        TextContent("Check the network status before big transactions"),
        TextContent("Use tools like Etherscan to estimate gas"),
        TextContent("Explore Layer 2 networks or alternative chains to save gas"),
        TextContent("Final Thought"),
        TextContent("Gas fees are the fuel of blockchain activity."),
        TextContent("Understanding them helps you make smarter and cheaper transactions in the crypto world."),
      ],
    );
  }
  Widget Sense_7() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextTitle('Cryptocurrency Risks Overview'),
        TextContent("Cryptocurrency has rapidly gained popularity as both a technology and an investment tool. "),
        TextContent("While it offers exciting opportunities for growth, it also comes with a unique set of risks. "),
        TextContent("Understanding these risks is crucial for anyone looking to get involved in the world of digital assets."),
        TextContent("In this article, we’ll break down the most significant risks associated with crypto investments."),
        TextTitle("1. Volatility"),
        TextContent("One of the most significant risks of cryptocurrency is its high volatility."),
        TextContent("Price fluctuations: The price of cryptocurrencies like Bitcoin and Ethereum can change dramatically in a matter of minutes or hours."),
        TextContent("Example: Bitcoin has seen swings of 20% or more within a single day. Such large movements can result in significant gains or losses."),
        TextContent("While this volatility presents opportunities for investors, it also means that you could lose a substantial portion of your investment if the market moves against you."),
        TextTitle("2. Lack of Regulation"),
        TextContent("Cryptocurrency operates in a largely unregulated market. This can lead to several risks:"),
        TextContent("Fraud and Scams: Without proper regulation, the crypto market can attract fraudulent schemes such as fake exchanges, fraudulent ICOs (Initial Coin Offerings), or Ponzi schemes."),
        TextContent("Market manipulation: The absence of regulation can also allow market manipulation by bad actors. Prices can be artificially inflated or deflated, making it difficult to trust the true value of a cryptocurrency."),
        TextContent("Government intervention: Governments in some countries have imposed or are considering restrictions on cryptocurrency, which can affect the market. If regulations tighten, cryptocurrencies could face legal hurdles."),
        TextTitle("3. Security Concerns"),
        TextContent("Cryptocurrencies are stored in digital wallets, which are susceptible to hacking and theft."),
        TextContent("Exchange hacking: Cryptocurrency exchanges (platforms where you buy and sell crypto) have been targeted by hackers in the past, leading to large-scale thefts."),
        TextContent("Wallet hacking: If you don't store your cryptocurrencies in a secure wallet, they can be stolen. Even hardware wallets (physical devices) are not completely immune to attacks."),
        TextContent("It is essential to use strong passwords, enable two-factor authentication, and follow best practices to secure your crypto holdings."),
        TextTitle("4. Loss of Private Keys"),
        TextContent("Unlike traditional bank accounts, cryptocurrency wallets are controlled by a private key—a piece of cryptographic information that proves ownership of your funds."),
        TextContent("Loss of private key: If you lose your private key, you lose access to your cryptocurrency. There is no way to recover it, as the system is decentralized and doesn't rely on a central authority."),
        TextContent("No customer support: Unlike banks or exchanges that can help you recover your account, crypto wallets provide no support for forgotten passwords or lost private keys."),
        TextTitle("5. Scams and Fraudulent Schemes"),
        TextContent("As the crypto market grows, scams and fraudulent schemes are also increasing."),
        TextContent("Ponzi schemes: Fraudulent investment schemes that promise high returns are common. These schemes pay returns to earlier investors with money from newer investors."),
        TextContent("Phishing: Phishing scams aim to trick users into revealing their private keys, login information, or other sensitive data."),
        TextContent('Fake tokens: Many fraudulent projects launch fake tokens with little or no value. These "pump-and-dump" scams inflate prices temporarily before the value crashes'),
        TextContent("It's crucial to research thoroughly and be cautious of anything that seems too good to be true."),
        TextTitle('6. Market Liquidity'),
        TextContent("While major cryptocurrencies like Bitcoin and Ethereum are highly liquid (easy to buy and sell), smaller or less known tokens may not be."),
        TextContent("Low liquidity: Cryptocurrencies with low trading volumes may be harder to sell when you need to. You might struggle to find a buyer at the price you want, or worse, you may not be able to sell at all."),
        TextContent("Market depth: The more liquid a market is, the less chance there is for large price swings. Smaller tokens can experience massive price fluctuations due to their limited trading volume."),
        TextTitle("7. Long-Term Viability"),
        TextContent("The future of many cryptocurrencies remains uncertain. While established coins like Bitcoin and Ethereum have gained widespread acceptance, newer projects might not survive in the long run."),
        TextContent("Technology risks: Some cryptocurrencies may be vulnerable to technological problems or security issues. For example, if a blockchain becomes outdated or hacked, it may lose its value."),
        TextContent("Regulatory risks: Governments may regulate or ban certain cryptocurrencies, which can lead to sudden price drops or the complete failure of a project."),
        TextTitle("How to Minimize Risks"),
        TextContent("Research: Always research any cryptocurrency before investing. Understand the project, its team, and its goals."),
        TextContent("Diversification: Don’t put all your funds into a single asset. Spread your investments across different cryptocurrencies and other assets to minimize risk."),
        TextContent("Secure your assets: Use secure wallets and platforms, enable two-factor authentication, and always back up your private keys."),
        TextContent("Avoid hype: Be wary of tokens or projects that promise huge returns in a short period. If it sounds too good to be true, it probably is."),
        TextTitle("Key Takeaways"),
        TextContent("Cryptocurrencies are highly volatile and can result in significant losses."),
        TextContent("The market is largely unregulated, which increases the risk of fraud, scams, and government intervention."),
        TextContent("Security issues, such as hacking and losing private keys, can lead to the total loss of your investment."),
        TextContent("Always do your research and consider diversification to reduce risk."),
      ],
    );
  }

  Widget FooterBtn() {
    return Container(
      width: MediaQuery.of(context).size.width - 64,
      height: 54,
      margin: EdgeInsets.only(top: 40, left: 16),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: Color.fromRGBO(21, 23, 28, 0.35),
        borderRadius: BorderRadius.circular(24)
      ),
      child: _remainingTime == 0 ? ElevatedButton(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Color(0xFF15171C),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          ),
          onPressed: _onFinish,
          child: Text('Finish', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700))
        ) : Stack(
        alignment: Alignment.center,
        children: [
          Positioned(left: 0, child: AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              return Container(
                width: (MediaQuery.of(context).size.width - 64) * _animation.value,
                height: 54,
                decoration: BoxDecoration(
                  color: Color(0xFF15171C),
                  borderRadius: BorderRadius.circular(24)
                ),
              );
            },
          )),
          Positioned(child: Text('${_remainingTime}s', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700)))
        ]
      ),
    );
  }
}