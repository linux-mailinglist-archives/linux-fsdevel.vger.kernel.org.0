Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADBAC70F542
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 May 2023 13:29:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbjEXL3M (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 May 2023 07:29:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbjEXL3H (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 May 2023 07:29:07 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF241B6;
        Wed, 24 May 2023 04:29:06 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 466F05C014E;
        Wed, 24 May 2023 07:29:06 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Wed, 24 May 2023 07:29:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1684927746; x=1685014146; bh=Dk
        ZDQE6py1T70Nun2afUAHBUj+DwKgk6UL7vXpX8QhQ=; b=OuajjyOEvj2z0UCkI7
        8yNJDmgeFVs1eUVzmQ5GKJRwZqwMPElMNUE273nEdCDnUINRM3t7yJJhhoepWyyK
        ZNuzVOznd/3/kzU7bo7e9/CMTcIQCV8yOTyjuVL01iN1JepJg4BYZdSRLIh+NDhU
        g7XzTMI4cmf32JyyTYBQ+bio/yi4mrDh7Lzm8hT9n0WC9D7GUtd96mWeGMFTl0i8
        3fFHMJY9cDQEIZmgCZx/KX1qRGGvjXPHL4DUsHr3oDKV9D5PqMfXlzWee2BnjwLa
        CjUMmPHhydmWWjBC9ZClY5PvoUit0s0rTV1PaGF20AvCk3Vo7aFcqIVGru+i6FqL
        mQtw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1684927746; x=1685014146; bh=DkZDQE6py1T70
        Nun2afUAHBUj+DwKgk6UL7vXpX8QhQ=; b=lap2AWzgSkO2/ftKQvEQc+TE2KWFr
        vYBw6aE/5tK9iGQTlFTT4ukU+WrSyq2QGdbrOnahz0DvuzzfLnNFmshvCKTsWF4O
        5oDoq+AkiaiBO+GCP1dt9MBpb5CFO6pMpwW2VhCNVnwXd2Y++/KHjWByWT1tU99n
        541mExHgts3zT2nzGQQ2aHHkd9m6do9IVPHHlUbYb3FoeCQLcYPPWxeCPh7AfHRe
        68sGTQ8VfV6h6CIeu0Os0A7ZpQ9gvppDyUgIYO3nmYahiz09b9qMBe5UXJMKRDky
        7dZ9N244N353p/qBaOTFO/G3IKA0CfOK/XuHLcpGQK2mPa/fiBDwH2RkA==
X-ME-Sender: <xms:AfVtZG3gsNWYMMiA6FxF_mm37tpjTSU1iLWP12Ipl_8HYeOPSLCjog>
    <xme:AfVtZJGYY5jLeejDyC9ymqGBvpF_7DzCDoDpwDb7sexJYVn5nEnjmYHWgawOVpQ_c
    k1diJvq5m53fBIswco>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeejhedgfeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepvdefjeevfefhvdevjeeuheefieetvdduheeludevtdefhfekleduhfdvjedt
    ieeinecuffhomhgrihhnpehlfihnrdhnvghtnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:AfVtZO6Thrhqy1bi8COkH1ttpx9Wv6hEGizb6gfpceRrO3bIWqX4aQ>
    <xmx:AfVtZH08gIKPotE-OJ0TC6eyCBRYqM0xkdLfMxJMF1JFjbEuCLwnaQ>
    <xmx:AfVtZJHTcSwXtAolEWFq8t-pSj9nw1RR7dnlwvLXPpcgYOT4LaPFzA>
    <xmx:AvVtZIB2wYixFc3Fyw7Jh-UW_3NDtXrNPix_kcGBHItHZek46ErRZw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id A7548B60086; Wed, 24 May 2023 07:29:05 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-441-ga3ab13cd6d-fm-20230517.001-ga3ab13cd
Mime-Version: 1.0
Message-Id: <dca09245-5b59-438b-b7d6-c65db7a84a85@app.fastmail.com>
In-Reply-To: <CA+G9fYvGM6a3wct+_o0z-B=k1ZBg1FuBBpfLH71ULihnTo5RrQ@mail.gmail.com>
References: <CA+G9fYvGM6a3wct+_o0z-B=k1ZBg1FuBBpfLH71ULihnTo5RrQ@mail.gmail.com>
Date:   Wed, 24 May 2023 13:28:45 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Naresh Kamboju" <naresh.kamboju@linaro.org>,
        "LTP List" <ltp@lists.linux.it>,
        "open list" <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, lkft-triage@lists.linaro.org,
        "Jeff Layton" <jlayton@kernel.org>
Cc:     chrubis <chrubis@suse.cz>, "Petr Vorel" <pvorel@suse.cz>,
        "Alexander Viro" <viro@zeniv.linux.org.uk>,
        "Christian Brauner" <brauner@kernel.org>,
        "Dan Carpenter" <dan.carpenter@linaro.org>,
        "Anders Roxell" <anders.roxell@linaro.org>
Subject: Re: LTP: syscalls: statx06.c:138: TFAIL: Modified time > after_time
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 24, 2023, at 12:48, Naresh Kamboju wrote:

>
> ...
>
> [ 1192.088987] loop0: detected capacity change from 0 to 614400
> tst_device.c:93: TINFO: Found free device 0 '/dev/loop0'
> tst_test.c:1093: TINFO: Formatting /dev/loop0 with ext4 opts='-I 256'
> extra opts=''
> mke2fs 1.46.5 (30-Dec-2021)
> [ 1192.337350] EXT4-fs (loop0): mounted filesystem
> dfe9283c-5d2f-43f8-840e-a2bbbff5b202 r/w with ordered data mode. Quota
> mode: none.
> tst_test.c:1558: TINFO: Timeout per run is 0h 05m 00s
>
> statx06.c:140: TPASS: Birth time Passed
> statx06.c:138: TFAIL: Modified time > after_time
> statx06.c:140: TPASS: Access time Passed
> statx06.c:140: TPASS: Change time Passed

I found a description in

https://lwn.net/ml/linux-kernel/20230503142037.153531-1-jlayton@kernel.org/

which indicates that this is expected. Added Jeff to Cc in case
I'm misreading his explanation.

     Arnd
