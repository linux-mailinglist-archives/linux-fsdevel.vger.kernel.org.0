Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A73396AAA95
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 Mar 2023 15:59:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbjCDO7x (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 4 Mar 2023 09:59:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjCDO7w (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 4 Mar 2023 09:59:52 -0500
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFEADE3B4
        for <linux-fsdevel@vger.kernel.org>; Sat,  4 Mar 2023 06:59:49 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id C607B3200C12;
        Sat,  4 Mar 2023 09:59:46 -0500 (EST)
Received: from imap46 ([10.202.2.96])
  by compute3.internal (MEProxy); Sat, 04 Mar 2023 09:59:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=verbum.org; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1677941986; x=1678028386; bh=cT
        DnCz6YiZpbmxlW/eC2narWwqW+j+8wzPDExNaLIq8=; b=DRVy/6OeA/b3o2gPQe
        ZRE7A6M4plghI5q/t1tjujUnimZBUs7UhlB29Mk83VGbqb9E9dh2/axBpWlXqfsj
        nCe6BAd3BiubrwIXqnFKYpooiSby4JdtAqd5CH0E4tihBOKgj6xtalnyOYqJC9Lv
        FVTIkM7HL1YHzZ2KNG0bHyg4M62sB4Vb7XvQKFBCyDomFWU+Ib37HOoQXPRSz7Yq
        hTD4xl3R1aQgemR20+2TR82si7zOuWnVOZvzDXg8bfgO4GI7HaMypOUb047xBDTR
        6Gub/dCNOVK8J+6mA30ef3llVAtV4eCAdIcr6usve/SPuoowkmCtqzwViWbyNO2A
        NmiQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1677941986; x=1678028386; bh=cTDnCz6YiZpbm
        xlW/eC2narWwqW+j+8wzPDExNaLIq8=; b=Oyc+ArYrUU/j6i6shAsBaMjSbc1Zo
        Tw7Za4n2Ookufe96SOt3X85u6R8GU+XoVxlDEON9jwz1R6rrrYmlwpnpXPtEANMv
        Afjca7QNtpSNYSQzNh1nWnAFjDjPliu1Zo/JEGMs8qnoY08LgfCAXjXEZklAFd/h
        zwT6dW74fYNeLBmRryl2t0Uj3XiEPugqDVytRq0oHJNx69uyE7wn9tvZxwcRG/yU
        w/XIBykzrIR0JuZ7iBat1cBZUu1qXEULpTWlAEwF7PZYuMoTPnSmtSQnWzLkV1BM
        RPAdKhiiBRVJyu5HAp+40oPY7+/Vy2fFETQ1KewEX5Nww2aKPVQMQxkPw==
X-ME-Sender: <xms:4VwDZG_4GT4KQnY__hD2Aj7n9ryf3Pk8bDMaeX38qTQhHSG9i1aRlg>
    <xme:4VwDZGudjFaAmQ8v7alel3i0yWc-HM1DY1SZNguwy0_z3aKY9sAzz9-uUVMA3Pal9
    BnAQU4vTcLOo8uq>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvddtuddgieejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedfveho
    lhhinhcuhggrlhhtvghrshdfuceofigrlhhtvghrshesvhgvrhgsuhhmrdhorhhgqeenuc
    ggtffrrghtthgvrhhnpeethefhheejfeeufeelueffgeeigeeiteeuieekvefgteegffdu
    kefghfegkeelveenucffohhmrghinhepghhithhhuhgsrdgtohhmpdhfvgguohhrrghprh
    hojhgvtghtrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghi
    lhhfrhhomhepfigrlhhtvghrshesvhgvrhgsuhhmrdhorhhg
X-ME-Proxy: <xmx:4VwDZMCAUQ914E4NOFZQdNBAtHsuamlpMj_O7YPdeq9KWJ3qFZAuxQ>
    <xmx:4VwDZOe9QzWXUz4-6mcJpi3NzWoWEn2XfQfKnnvQLz-lGuuA24yPZA>
    <xmx:4VwDZLMprSln5zsd9qVV2BF83RRa6YC10nkunWI633HMMUinmyS02A>
    <xmx:4lwDZEgZYhU7OP7pAeq0Nmg5tLpBNCCPFfzxWyBCSj3XZXpQkpHNWg>
Feedback-ID: ibe7c40e9:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 78BCB2A20080; Sat,  4 Mar 2023 09:59:45 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-183-gbf7d00f500-fm-20230220.001-gbf7d00f5
Mime-Version: 1.0
Message-Id: <4782a0db-5780-4309-badf-67f69507cc81@app.fastmail.com>
In-Reply-To: <13e7205f-113b-ad47-417f-53b63743c64c@linux.alibaba.com>
References: <e84d009fd32b7a02ceb038db5cf1737db91069d5.camel@redhat.com>
 <CAL7ro1E7KY5yUJOLu6TY0RtAC5304sM3Lvk=zSCrqDrxTPW2og@mail.gmail.com>
 <ffe56605-6ef7-01b5-e613-7600165820d8@linux.alibaba.com>
 <13e7205f-113b-ad47-417f-53b63743c64c@linux.alibaba.com>
Date:   Sat, 04 Mar 2023 09:59:24 -0500
From:   "Colin Walters" <walters@verbum.org>
To:     "Gao Xiang" <hsiangkao@linux.alibaba.com>,
        "Alexander Larsson" <alexl@redhat.com>,
        lsf-pc@lists.linux-foundation.org
Cc:     linux-fsdevel@vger.kernel.org,
        "Amir Goldstein" <amir73il@gmail.com>,
        "Christian Brauner" <brauner@kernel.org>,
        "Jingbo Xu" <jefflexu@linux.alibaba.com>,
        "Giuseppe Scrivano" <gscrivan@redhat.com>,
        "Dave Chinner" <david@fromorbit.com>,
        "Vivek Goyal" <vgoyal@redhat.com>,
        "Miklos Szeredi" <miklos@szeredi.hu>
Subject: Re: [LSF/MM/BFP TOPIC] Composefs vs erofs+overlay
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On Fri, Mar 3, 2023, at 12:37 PM, Gao Xiang wrote:
> 
> Actually since you're container guys, I would like to mention
> a way to directly reuse OCI tar data and not sure if you
> have some interest as well, that is just to generate EROFS
> metadata which could point to the tar blobs so that data itself
> is still the original tar, but we could add fsverity + IMMUTABLE
> to these blobs rather than the individual untared files.

>   - OCI layer diff IDs in the OCI spec [1] are guaranteed;

The https://github.com/vbatts/tar-split approach addresses this problem domain adequately I think.

Correct me if I'm wrong, but having erofs point to underlying tar wouldn't by default get us page cache sharing or even the "opportunistic" disk sharing that composefs brings, unless userspace did something like attempting to dedup files in the tar stream via hashing and using reflinks on the underlying fs.  And then doing reflinks would require alignment inside the stream, right?  The https://fedoraproject.org/wiki/Changes/RPMCoW change is very similar in that it's proposing a modification of the RPM format to 4k align files in the stream for this reason.  But that's exactly it, then it's a new tweaked format and not identical to what came before, so the "compatibility" rationale is actually weakened a lot.



