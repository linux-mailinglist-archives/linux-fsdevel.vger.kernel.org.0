Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E82B54F7508
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Apr 2022 06:58:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237570AbiDGFAn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Apr 2022 01:00:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237163AbiDGFAm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Apr 2022 01:00:42 -0400
X-Greylist: delayed 1946 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 06 Apr 2022 21:58:42 PDT
Received: from se1h-lax1.servconfig.com (se1h-lax1.servconfig.com [173.231.224.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC5581DB7E6
        for <linux-fsdevel@vger.kernel.org>; Wed,  6 Apr 2022 21:58:42 -0700 (PDT)
Received: from ecld309.inmotionhosting.com ([198.46.81.21])
        by se1-lax1.servconfig.com with esmtps (TLSv1.2:AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <broker2@muneshwers.com>)
        id 1ncJej-0005W8-LS; Thu, 07 Apr 2022 00:22:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=muneshwers.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        Message-ID:References:In-Reply-To:Reply-To:Subject:To:From:Date:MIME-Version:
        Sender:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=9/QrxG4h2nwiHwigMh27+L84D0ydURc2mLUXe98JDXo=; b=pc7EL2d/gp/QGNR2D3noud37El
        dOksSiW2k2eCVRUkj4C5/5vLy/RQRDtCX6SOCqEwPUg1Q6HC1WAwtUiN2Km9fyrwqdqIG9qhHS7N5
        mt36Sc4ynsElQ4Y7QTAOjKhoQ2ghIsDqMRHXPMeQE1EFgyyArueRFsDCZA+5v109Y97ODnLvKen7T
        VNy0xbcsgYzPz0Ra20t4h5vtIgPQo/AIbcuDzO/0Gmt0dfCUP74wTdq7ZiVSXI1ncxC6CDvz5208J
        h9tKarLJEdr2DvLKPdowmmfInAKwnZ11hCR+eQHS0mINJhw0ArWKBvWZvOUIAbxT/8qgtB+gTZhDb
        1X/PIoaA==;
Received: from [::1] (port=47714 helo=ecld309.inmotionhosting.com)
        by ecld309.inmotionhosting.com with esmtpa (Exim 4.94.2)
        (envelope-from <broker2@muneshwers.com>)
        id 1ncJXo-002OuS-BB; Thu, 07 Apr 2022 00:14:52 -0400
MIME-Version: 1.0
Date:   Thu, 07 Apr 2022 00:12:56 -0400
From:   Ukraine Needs Help <broker2@muneshwers.com>
To:     undisclosed-recipients:;
Subject: Support the people of Ukraine
Reply-To: Oleksandra-Iryna@activist.com
In-Reply-To: <6c59d1855bb504e98f7ca74cfaa8584e@muneshwers.com>
References: mid:4290 <44d7ccd6bede2798824d66b1bd6c7daa@chanofan.com>
 <5fc829c999fe4b45c878540b04fdf071@presidency.com>
 <944a7a1c7f978d3cc2c9da318a675ad6@totalhospital.com>
 <0fa73b5f7f95bb3a31aea07a8f4b1784@ukrainehelps.gov>
 <749444c4ffb0114b7e5a4149a7b00399@presidency.com>
 <4af43a9298dbfa4d09a5849d71b5e58a@ukrainehelps.org>
 <d7decf33455ce2a66e1b922ee175fd0e@muneshwers.com>
 <08311dac5fd8a00db75df782f8148cc6@muneshwers.com>
 <6a061002f988daf9cc5e12a93de36bc4@muneshwers.com>
 <53523f5e9aef4b2febd2d4accadff0c9@muneshwers.com>
 <bf25947bd30ae37f0b9392f4dec38f6b@muneshwers.com>
 <8060c3b3d18e19ea4ef15cd2de108864@muneshwers.com>
 <f7a13c914b5a5257a3a6dd0eddcdc26d@muneshwers.com>
 <6bf79a4425a6c2f1fac8ef34fff9fd04@muneshwers.com>
 <aaf96c71fabd2e2e531a83d4c3ba9ed6@muneshwers.com>
 <fa01c4166db07c7493fa72c77a27b87d@muneshwers.com>
 <acdced663001f9c5bf2772134aad8778@muneshwers.com>
 <e27db0e21bd76199ccdd9c82d8f7f72b@muneshwers.com>
 <4fe4e6b1f35057b7dbec178ec383aaff@muneshwers.com>
 <c33ab59d079b40c88138ef3f9c7fa313@muneshwers.com>
 <1c7b341c472134a651216631d02a73cd@muneshwers.com>
 <b34e0aab26b1f1206bbf2e795fcdc774@muneshwers.com>
 <28d74c19e433dec67b34af5320675ecc@muneshwers.com>
 <07e1a2f8ef15775823ad97f19b752298@muneshwers.com>
 <c7139fa76dea378d50d5bc428e9a23d1@muneshwers.com>
 <ce2726e868d8fcf17cc383ad3ac8d9b3@muneshwers.com>
 <6c59d1855bb504e98f7ca74cfaa8584e@muneshwers.com>
User-Agent: Roundcube Webmail/1.4.12
Message-ID: <ef9f78f7bd93b2c209f3d08b9da4ea19@muneshwers.com>
X-Sender: broker2@muneshwers.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Get-Message-Sender-Via: ecld309.inmotionhosting.com: authenticated_id: broker2@muneshwers.com
X-Authenticated-Sender: ecld309.inmotionhosting.com: broker2@muneshwers.com
X-Originating-IP: 198.46.81.21
X-SpamExperts-Domain: ecld309.inmotionhosting.com
X-SpamExperts-Username: 198.46.81.21
Authentication-Results: servconfig.com; auth=pass smtp.auth=198.46.81.21@ecld309.inmotionhosting.com
X-SpamExperts-Outgoing-Class: unsure
X-SpamExperts-Outgoing-Evidence: Combined (0.87)
X-Recommended-Action: accept
X-Filter-ID: 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
 OtEhdxekWDmK9g==
X-Report-Abuse-To: spam@se1-lax1.servconfig.com
X-Spam-Status: No, score=4.6 required=5.0 tests=BAYES_50,BITCOIN_SPAM_04,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_FORGED_REPLYTO,PDS_BTC_ID,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Greetings,

Trust you are well my friend.

We are soliciting support for the people of Ukraine as they witness the 
horrors of war and an increased displacement from their ancestral home.

We understand these are difficult and uncertain times, however as one of 
our compony principles to never leave anyone behind, we like to kindly 
solicit for your donation support to the women and children in Refugee 
war camp in Kyiv, Ukraine. I know it's hard to trust these days but you 
can do it out of love, kindness and support for humanitarian assistance 
in impacted communities in Ukraine and surrounding regions where 
Ukrainian refugees have fled.

Getting donations to people on ground in Ukraine is quite difficult due 
to the ongoing war and we have been advised that all donation should be 
done via Crypto Currency according to the Ukrainian ministry of defense.

Here are different wallet monitored for donation by verified Ukrainians 
on ground.

BTC: bc1q370ydpdk6euc4qfwntd34uvccyvl6myza059gu

Eth.: 0x9E7bB55e87AFfD04d5f5680430fF2098aBacFF36

USDT: B9QCqmfYhfbfQ5hkFJ815pLEFrD45MW78vX9KoNonaB6

PerfectMoney Name: Support Ukraine, ID: U33367369

We have team all over the world incase you want to donate via bank 
international or local transfer, also if you want to send via MoneyGram 
or Western Union, you can contact us via email to request for payment 
details.

Thank you.

Mrs Oleksandra Iryna (Muneshwers Kyiv)
Coordinator for humanitarian affair
Kharkov, Ukraine.

Contact: Oleksandra-Iryna@activist.com
