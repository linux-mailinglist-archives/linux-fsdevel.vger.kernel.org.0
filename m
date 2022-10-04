Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 233625F489B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Oct 2022 19:35:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbiJDRfu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Oct 2022 13:35:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229893AbiJDRew (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Oct 2022 13:34:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8B10219F;
        Tue,  4 Oct 2022 10:34:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9B702B81B62;
        Tue,  4 Oct 2022 17:34:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A185C433B5;
        Tue,  4 Oct 2022 17:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664904876;
        bh=xt+VIL6t43fmPXkuNJgq0nQY3LruRYVH4BY+ZSzLhRc=;
        h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
        b=nzaqJjOCiwWaWsQpttWO/rlBNk/BRHEz1C9+S63QfcYZgC0/ey9PfIeyL4HvjIGZZ
         lT/q/x6cIgtMHXFXVB5p/y6T8fbeh6c5BM43YHWRrqi7xMQcKBX2tzz11WZqrpd5uc
         srwkDrpWcoFnUoZHAwhjvjp4+BARCIHR/dJQWjR93+0qm6GN0DFvIJQEGMFfsfp4vO
         /NUmvg22Ioz8TATXH+zcTSPlWh0vmd7YDP+Kbho1vOVlrCcAJF+kPfwO/CycaKdlpd
         SLMieSpbVdHniXgDQsnMeP/OrelgMqUXbkj/a8e7D+iQxy6R2/muyM00f3pSxFbW/O
         i3nX1m1ezebuw==
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id A20C327C0054;
        Tue,  4 Oct 2022 13:34:33 -0400 (EDT)
Received: from imap48 ([10.202.2.98])
  by compute2.internal (MEProxy); Tue, 04 Oct 2022 13:34:33 -0400
X-ME-Sender: <xms:qW48Yx_F_agMMe1a3kKPV3HbVLZ3OoHQrPsQ2F0uEEHSFW_QIKw_OA>
    <xme:qW48Y1vksNVXvhynK6UnXMol_3Ka2hs2Q-XCsBAOQfZBVaaUDPh11n7JgrWe-dUWI
    KD0SILWZpUjy1KigWk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeeiuddguddugecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    nhguhicunfhuthhomhhirhhskhhifdcuoehluhhtoheskhgvrhhnvghlrdhorhhgqeenuc
    ggtffrrghtthgvrhhnpedvhfeuvddthfdufffhkeekffetgffhledtleegffetheeugeej
    ffduhefgteeihfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpegrnhguhidomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudduiedu
    keehieefvddqvdeifeduieeitdekqdhluhhtoheppehkvghrnhgvlhdrohhrgheslhhinh
    hugidrlhhuthhordhush
X-ME-Proxy: <xmx:qW48Y_BUv07KC7ZyYLTIKHki7kOTO8DXTypOSf28yiSoZ4mGO8rLsQ>
    <xmx:qW48Y1c26h9gxbcV4ZT2q_opRkXSnKx0R4cDCQin1e9zt81GCrsyHA>
    <xmx:qW48Y2MRA8pPWfsrJnCFbt9BKNmOfLCVV0tvQYKhrklsZLpnsqhgog>
    <xmx:qW48YwwkPKKtkxB9i-w2qO4AkEwlpdjweqx1N-3XaKOwbtCVqdFvaQ>
Feedback-ID: ieff94742:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 32F2E31A0062; Tue,  4 Oct 2022 13:34:33 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1015-gaf7d526680-fm-20220929.001-gaf7d5266
Mime-Version: 1.0
Message-Id: <40484dc2-8da3-486d-9c53-02ae23a50fbb@app.fastmail.com>
In-Reply-To: <20221003222133.20948-8-aliraza@bu.edu>
References: <20221003222133.20948-1-aliraza@bu.edu>
 <20221003222133.20948-8-aliraza@bu.edu>
Date:   Tue, 04 Oct 2022 10:34:12 -0700
From:   "Andy Lutomirski" <luto@kernel.org>
To:     "Ali Raza" <aliraza@bu.edu>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Cc:     "Jonathan Corbet" <corbet@lwn.net>, masahiroy@kernel.org,
        michal.lkml@markovi.net,
        "Nick Desaulniers" <ndesaulniers@google.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        "Dave Hansen" <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Kees Cook" <keescook@chromium.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Al Viro" <viro@zeniv.linux.org.uk>,
        "Arnd Bergmann" <arnd@arndb.de>, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        "Steven Rostedt" <rostedt@goodmis.org>,
        "Ben Segall" <bsegall@google.com>, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        "Paolo Bonzini" <pbonzini@redhat.com>, jpoimboe@kernel.org,
        linux-doc@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org,
        "the arch/x86 maintainers" <x86@kernel.org>, rjones@redhat.com,
        munsoner@bu.edu, tommyu@bu.edu, drepper@redhat.com,
        lwoodman@redhat.com, mboydmcse@gmail.com, okrieg@bu.edu,
        rmancuso@bu.edu
Subject: Re: [RFC UKL 07/10] x86/signal: Adjust signal handler register values and
 return frame
Content-Type: text/plain
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On Mon, Oct 3, 2022, at 3:21 PM, Ali Raza wrote:
> For a UKL thread, returning to a signal handler is not done with iret or
> sysret.  This means we need to adjust the way the return stack frame is
> handled for these threads.  When constructing the signal frame, we leave
> the previous frame in place because we will return to it from the signal
> handler.  We also leave space for pushing eflags and the return address.
> UKL threads will only use the __KERNEL_DS value in the ss register and 0xC3
> in the cs register.

This is unclear.  Are you taking about returning from the kernel fault code *to* the signal handler or are you talking about returning *from* the user signal hander to the user code that was running when the signal happened?

In any case, I don't see what this has to do with iret or sysret.  Surely UKL can use a sigreturn() just like regular Linux.

The part where a UKL thread has permission to return to a CPL0 context should be a separate patch.

--Andy
