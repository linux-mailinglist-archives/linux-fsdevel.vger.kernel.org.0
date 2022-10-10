Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83F515FA462
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Oct 2022 21:56:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbiJJT4Q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Oct 2022 15:56:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbiJJT4P (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Oct 2022 15:56:15 -0400
Received: from wnew1-smtp.messagingengine.com (wnew1-smtp.messagingengine.com [64.147.123.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F76B2A433;
        Mon, 10 Oct 2022 12:56:14 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.west.internal (Postfix) with ESMTP id 10B2C2B06B7D;
        Mon, 10 Oct 2022 15:56:09 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute3.internal (MEProxy); Mon, 10 Oct 2022 15:56:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1665431769; x=1665435369; bh=OmVrkyV7eb
        RAniQNae83Idny89aIU9Df0QWBCsfk6KE=; b=JNm+uyKxoucwEtoyKmec9bMOpb
        y12Xis5RpW/jjxp8Hfm7qdm2PN5XdMzNcNJBx6OO0pOHMDp4K00NHVc6HKrrOLKT
        YGOSlwZCDNwQoogvWcqyEtiwuSAUHDOhdQlBYY8Pj2A31q523BNxoR4VwvSC0cJS
        j6IJv/O/y7HUWnPH8CmFYvsDBvS1VtONHMV3NMFU6gOF8uax2+s7aW3ViDzZ1p7a
        R/P8BeBULT0cUNMI8lcfwoV61G08rOvpcRpLEC4Dxb8pymKfXROdzcwZJRPVEEUX
        WlXnz1Tosj30qlf6rAV7UBJQRDb0BPEODMnPgAxUbQajh3HoHAWgSp7tkjMQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1665431769; x=1665435369; bh=OmVrkyV7ebRAniQNae83Idny89aI
        U9Df0QWBCsfk6KE=; b=PQkHsoMEdaUsHl4egguO1a/yl/ZupKLf2bUv2UYnXXTl
        S7gvAJlItxcj2GI3cXGV8AHOFQ1MqL5C12GoU8nvpafTWEt1xie713xF6Yi5txJo
        ZCPofn7GDvUOkoir19j839VbtTsnEkP4V7o8ffjxBwGgcORZyc8IMHDALHUs6LXq
        mYqM8//y3Yw9JqoE+R7M3NlI4JuvIzdd95O49y2gZZCnTFLlAL51dE3+dYdxZNCe
        piVOfG+cfoByA9Z3bmtWy5yr4TJcqqBkxqv+Jc02GqNLKDcmBXcKD5GMdd2BQdat
        jhIp08+BSU7zEt/Mp3DaHoIsdz8X2k5yvH2tBE2xrg==
X-ME-Sender: <xms:2HhEY3cG-38t6Oj26Z1nO0FzqE2eXeldq6ZClijpPWCt_GpZNczhSg>
    <xme:2HhEY9PGWnVLaPEBnIkIAMqIX_WHcK0JxPrrTXkiUI2cixD9EVc9Eb3wkcNUOhRXU
    f4_TgHTLthnH3_-0CY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeejgedgudefjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedt
    keetffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:2HhEYwiSLMLEc-djuA0rCMqMe0yC51gddL88DZKFVKebtCCHX7WPIA>
    <xmx:2HhEY4_JcIxuGBMzqNeMUGQVKImS5MGZEbKoiKICZMU_mQRzVTZKFw>
    <xmx:2HhEYzsQNC_LchjovK1-RBGXQWb7bQXkCu1USVhjvIbIsdMyTEBnLQ>
    <xmx:2XhEY8GxMpPD5mtX2UxA95zodLRLuoXwJacF5HI75qeRyhEu189rmHmlUVY>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id B066EB60086; Mon, 10 Oct 2022 15:56:08 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1015-gaf7d526680-fm-20220929.001-gaf7d5266
Mime-Version: 1.0
Message-Id: <de56a142-5adc-4022-9ce0-ccca0698d010@app.fastmail.com>
In-Reply-To: <20221007201140.1744961-1-ndesaulniers@google.com>
References: <CAKwvOdkEied8hf6Oid0sGf0ybF2WqrzOvtRiXa=j7Ms-Rc6uBA@mail.gmail.com>
 <20221007201140.1744961-1-ndesaulniers@google.com>
Date:   Mon, 10 Oct 2022 21:55:47 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Nick Desaulniers" <ndesaulniers@google.com>,
        "Andrew Morton" <akpm@linux-foundation.org>
Cc:     "Alexander Viro" <viro@zeniv.linux.org.uk>,
        "Nathan Chancellor" <nathan@kernel.org>,
        "Tom Rix" <trix@redhat.com>, "Xiaoming Ni" <nixiaoming@huawei.com>,
        "Luis Chamberlain" <mcgrof@kernel.org>,
        "Andi Kleen" <ak@linux.intel.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        "Christoph Hellwig" <hch@lst.de>,
        "Eric Dumazet" <edumazet@google.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] fs/select: mark do_select noinline_for_stack for 32b
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 7, 2022, at 10:11 PM, Nick Desaulniers wrote:
> +#ifdef CONFIG_64BIT
> +#define noinline_for_stack_32b
> +#else
> +#define noinline_for_stack_32b noinline_for_stack
> +#endif
> +
> +noinline_for_stack_32b

I don't see much value in making it behave differently for 32 bit:
it doesn't reduce the total frame size on 32-bit machines but only
hides the warning. The bug you are working around also looks i386
specific (because of limited number of registers vs ubsan needing
a lot of them), so just make it a simple 'noinline_for_stack'.

      Arnd
