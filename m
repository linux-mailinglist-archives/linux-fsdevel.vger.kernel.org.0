Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B6E45F489E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Oct 2022 19:37:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbiJDRhq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Oct 2022 13:37:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbiJDRh2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Oct 2022 13:37:28 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 179806AA22;
        Tue,  4 Oct 2022 10:36:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B04DCB808CF;
        Tue,  4 Oct 2022 17:36:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F49DC433D7;
        Tue,  4 Oct 2022 17:36:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664904962;
        bh=kayiSIodoZR3mJ1pBQAy28WrEVULtTONXZgr/Z9D3es=;
        h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
        b=PUIU4GUyuHhT3A9BskdSWSh7FAcmtx2E8PXZrViNak6i8qa++6QJi1Ci0qtDR1rdz
         L5sZVo/A9qAg6VjphwERSIrk/LYnSins7Dxk8hc7gg1ZcnXZRbgOn9cL4/ePXvpyM0
         uG8R4Cr/dxrIicuBvK9dtRtRUBf7XcCuKFnjI1k+7zODgusivc2SVpQ3ACWWp3T5hQ
         QFZKroS87GdIyzrJqiaFs+9JNJm2FMspNauX29//NDF/s7yQjoFQIwtAUgcDwSex3+
         yt0SMr10IVG39obPfi+kuvGaFXURicLZK6Qn9Nm2nKH+F+1mmKAH/g4pZziS2/LbRO
         539Eil4yaf/0A==
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id 2BF7427C0054;
        Tue,  4 Oct 2022 13:36:00 -0400 (EDT)
Received: from imap48 ([10.202.2.98])
  by compute2.internal (MEProxy); Tue, 04 Oct 2022 13:36:00 -0400
X-ME-Sender: <xms:_248Y2iaVMYp4ZcjaKqODMyZi7X1kpotOw2I3SfWsD3ojAeOllgoGg>
    <xme:_248Y3BKlUS_nqOnCwDOeetE9FMsVVxmheqUtMmPvqM-qsxov82mm7AWtC5OeNtVM
    ASNclJcwTELl6ZxrIg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeeiuddguddugecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    nhguhicunfhuthhomhhirhhskhhifdcuoehluhhtoheskhgvrhhnvghlrdhorhhgqeenuc
    ggtffrrghtthgvrhhnpedvhfeuvddthfdufffhkeekffetgffhledtleegffetheeugeej
    ffduhefgteeihfenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfh
    hrohhmpegrnhguhidomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudduiedu
    keehieefvddqvdeifeduieeitdekqdhluhhtoheppehkvghrnhgvlhdrohhrgheslhhinh
    hugidrlhhuthhordhush
X-ME-Proxy: <xmx:_248Y-GpEQuYfOI2v8bXcVRPJgR66bz-MDYiK4We3lsmzWi5HZddEA>
    <xmx:_248Y_TmdJOhZiDydNh7dWGjl28rAPmFCSv55zePsHkfbLaAiXjh-g>
    <xmx:_248YzxSeY0bdlpVCrjO4ym2beljqBYsCWK31j3Zdl7hKbQFKfQsNw>
    <xmx:AG88Y5mMsDLWjH-k1QffzKh_ApQZYphNBQvYStUq4aT_t-hUwMz1zA>
Feedback-ID: ieff94742:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 80CC631A0062; Tue,  4 Oct 2022 13:35:59 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1015-gaf7d526680-fm-20220929.001-gaf7d5266
Mime-Version: 1.0
Message-Id: <20d483b6-da24-4ddc-b6d4-c0c23b8e5ea2@app.fastmail.com>
In-Reply-To: <20221003222133.20948-10-aliraza@bu.edu>
References: <20221003222133.20948-1-aliraza@bu.edu>
 <20221003222133.20948-10-aliraza@bu.edu>
Date:   Tue, 04 Oct 2022 10:35:38 -0700
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
Subject: Re: [RFC UKL 09/10] exec: Give userspace a method for starting UKL process
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
> From: Eric B Munson <munsoner@bu.edu>
>
> From: Eric B Munson <munsoner@bu.edu>
>
> The UKL process might depend on setup that is to be done by user space
> prior to its initialization.  We need a way to let userspace signal that it
> is ready for the UKL process to run. We will have setup a special name for
> this process in the kernel config and if this name is passed to exec that
> will start the UKL process. This way, if user space setup is required we
> can be sure that the process doesn't run until explicitly started.

This is just bizarre IMO.  Why is there one single UKL process?

How about having a way to start a UKL process and then, if desired, start *another* UKL process?  (And obviously there would be a security mode in which only a UKL process that is actually part of the kernel image can run or that only a UKL process with a hash that's part of the kernel image can run.)

--Andy
