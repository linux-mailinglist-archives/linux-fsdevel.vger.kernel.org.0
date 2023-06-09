Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B543729FA9
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Jun 2023 18:09:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239945AbjFIQJq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Jun 2023 12:09:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231244AbjFIQJp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Jun 2023 12:09:45 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D80743588;
        Fri,  9 Jun 2023 09:09:42 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id EBB623200A1A;
        Fri,  9 Jun 2023 12:09:39 -0400 (EDT)
Received: from imap46 ([10.202.2.96])
  by compute3.internal (MEProxy); Fri, 09 Jun 2023 12:09:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=verbum.org; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1686326979; x=1686413379; bh=Rb
        dsvIkt0nmJa74EhZHGs64YUID7krXP85fNUcRwZck=; b=JDUyvs9raU9sf8zaW8
        Tdhj5gLyHa+eWT6v1HENETYAj/JIyL78hqWGUkpuIzVcPoSSmKEl5gewl095S4E2
        XqdEjpkeNIexgBBRWznAkGdCT/WaZq8vkxDwxsK3k60Q7FgDXuf3xfuIonqhEdjB
        o1NYQ0/jUw9s3VLaFcjpVAk48VVb93HQOQZXtCaAwBGzO75xVQ3pLAe7pahNYXP8
        4m8n1Q+Unn27E0Odzo3ZW1QasJYrsNkg56X9UY5Kqwm1lv25cJZoHNxKiEJnPvg5
        d9CU71qCM6SNmlFDlXrFMNK1DntY4Ne2g0tPjbt4GvCokOxCyT0koLiMUpOnBln1
        t0Vw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1686326979; x=1686413379; bh=RbdsvIkt0nmJa
        74EhZHGs64YUID7krXP85fNUcRwZck=; b=I1oVqqM89xsyuvoOzSZ28H0ef3tz9
        ZHQk7a2eIMnqDhuXVfGQ14ypnHhnpVYG7ywNl5NcfLJf8hw7vvACXShjRZibvAHd
        wlynqIpYugLRUoBmhVW7UCoSlKW1uqOPKgxdFCP/8FfNItZUyARfaJelErjDR4tb
        WtwOyERVbdhj2hD6Jqg+e+JQwN8jzmeN/xsPZADqp7P/4tdAj7pKWxT+xREoFoFH
        Q/H4lB3Kqrurl6RS3C1HlDkUFvGCkneEYKRRa5aJqcUf/+NdX6lPkkTuSFjFOWNs
        Eytl1aSZlSjoiuojOJskLuq82i87LKUUfFudKapJMRfGTRjNwhCmIpkwg==
X-ME-Sender: <xms:w06DZJzasDAHxod6kzGfF4J1vJi_hNXU6L367KjhuyjDQhPLSB6TTw>
    <xme:w06DZJRYe7dJCORgqM9D5Wu_KOcxnl79ezbcWAZvQAkylzXRni97I3BR39VN8usRK
    SSQjdc7pdtOCEJV>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgedtkedgleejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedfveho
    lhhinhcuhggrlhhtvghrshdfuceofigrlhhtvghrshesvhgvrhgsuhhmrdhorhhgqeenuc
    ggtffrrghtthgvrhhnpefhjedutdehtdfgueeuledtkeefkedvgfevieefudetkeehffej
    gfeiheehkeegteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpeifrghlthgvrhhssehvvghrsghumhdrohhrgh
X-ME-Proxy: <xmx:w06DZDUH6ugOlC6Q7QtG3fm30n-s9LW-YrzPmFR1OC83O06-Cm4Mlg>
    <xmx:w06DZLgb3k0X6Tb0Nw930qMmxxnjGkavqfoSx2Kp8YN28z02a3zjDA>
    <xmx:w06DZLDhXA7NfurIe4gXpUZCcjmcoS_255XCUs53s_cAI4kJFbLFAA>
    <xmx:w06DZON0YDXgv6oJBQnhMpLNcRy7TaBGYb839fcKkxpyfqzvSpmzPg>
Feedback-ID: ibe7c40e9:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 3705A2A20080; Fri,  9 Jun 2023 12:09:39 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-447-ge2460e13b3-fm-20230525.001-ge2460e13
Mime-Version: 1.0
Message-Id: <4229ded1-5c61-42fc-aaf9-50fc9c756885@betaapp.fastmail.com>
In-Reply-To: <20230605-fs-overlayfs-mount_api-v2-1-3da91c97e0c0@kernel.org>
References: <20230605-fs-overlayfs-mount_api-v2-0-3da91c97e0c0@kernel.org>
 <20230605-fs-overlayfs-mount_api-v2-1-3da91c97e0c0@kernel.org>
Date:   Fri, 09 Jun 2023 12:09:08 -0400
From:   "Colin Walters" <walters@verbum.org>
To:     "Christian Brauner" <brauner@kernel.org>,
        "Amir Goldstein" <amir73il@gmail.com>,
        "Miklos Szeredi" <miklos@szeredi.hu>
Cc:     linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org
Subject: Re: [PATCH v2 1/2] ovl: port to new mount api
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Cool work.  It will be interesting to do some performance testing on what does it actually look like to create ~500 or whatever overlayfs layers now that we can.

On Fri, Jun 9, 2023, at 11:41 AM, Christian Brauner wrote:
> 
> +static int ovl_init_fs_context(struct fs_context *fc)
> +{
> +	struct ovl_fs_context *ctx = NULL;
> +	struct ovl_fs *ofs = NULL;
> +
> +	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL_ACCOUNT);
> +	if (!ctx)
> +		goto out_err;

It looks to me like in this case, ofs will be NULL, then:

> +out_err:
> +	ovl_fs_context_free(ctx);
> +	ovl_free_fs(ofs);

And then we'll jump here and `ovl_free_fs` is not NULL safe.

I think the previous code was correct here as it just jumped directly to "out:".


(I've always wondered why there's no usage of __attribute__((cleanup)) in kernel code and in our userspace code doing that we have the free functions be no-ops on NULL which systematically avoids these bugs, but then again maybe the real fix is Rust ;) )
