Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAAEF5F48D0
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Oct 2022 19:44:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbiJDRoT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Oct 2022 13:44:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbiJDRoQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Oct 2022 13:44:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C185B20BC9;
        Tue,  4 Oct 2022 10:44:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 643A1B808CF;
        Tue,  4 Oct 2022 17:44:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6BB8C433D6;
        Tue,  4 Oct 2022 17:44:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664905452;
        bh=yIqPJAQcHpJ7XOHtFGZweD/IVZbXnAYmQPNSpNVlUZo=;
        h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
        b=ldh4nLhLmF9nyGWDvyYqox+VLx3Bk7drBAgCeNkaEtCPx5ZaGM5bZcOdZnwHaGGxZ
         zRnxKWyuwM/UFHNMgpfwQzWQGMpxXngR/T1HW2KYfWN/gAq1xpNdFZ/LGHbnO6zP2q
         bYbMvhZz/USRbxjBRiblU9+jj/ZA2LbHQguAWWcGzynf/sScAYuSghxO6pCDPpr2k1
         aGKb1MWbwZrJsU5Rop+9lif5jBvc6RjPVQkkWCBwBSWCYNQgKRt26PmYFWaDz/T2Fa
         X4gP3R9nr0NIwwNv1Dtkp6JY0hF0nrDU2P8LElzor4XxmlDthmNB4mUWG5N7i4lKeX
         YQDJx3lPrySjA==
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id 8BD8C27C0054;
        Tue,  4 Oct 2022 13:44:09 -0400 (EDT)
Received: from imap48 ([10.202.2.98])
  by compute2.internal (MEProxy); Tue, 04 Oct 2022 13:44:09 -0400
X-ME-Sender: <xms:6XA8Y5100_xRzVDmUexrhiWmBbmU0XGQVTmmkyVHho1SaozfBI2ALA>
    <xme:6XA8YwHRf4_tD1WaP0D1YKQo8Xcn4JKaG3g4nvpc5goDtSc89Rffj2gkwGg14pnSN
    V8kbXO-H7dn9xTILsE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeeiuddguddujecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    nhguhicunfhuthhomhhirhhskhhifdcuoehluhhtoheskhgvrhhnvghlrdhorhhgqeenuc
    ggtffrrghtthgvrhhnpedvhfeuvddthfdufffhkeekffetgffhledtleegffetheeugeej
    ffduhefgteeihfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpegrnhguhidomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudduiedu
    keehieefvddqvdeifeduieeitdekqdhluhhtoheppehkvghrnhgvlhdrohhrgheslhhinh
    hugidrlhhuthhordhush
X-ME-Proxy: <xmx:6XA8Y547f3HOtOKu1COntzqReWKNb0ge5l3CPrm1IhyzN2XoVoSCVQ>
    <xmx:6XA8Y23CR-HctteJHsYEuAYJWwYXKSkgUK2iq3c6QYE_lVBd5nlrwA>
    <xmx:6XA8Y8F6-2JhNfOlJikvfJtsZm3brovSIyLoTzmAnNckq5JWpRGQpw>
    <xmx:6XA8Y-NiWyvMeX_c2K3IWNV0LUxOmVK6zii7U5-2PhF6dcJXc8WRrVIemXQ>
Feedback-ID: ieff94742:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 34B4931A0063; Tue,  4 Oct 2022 13:44:09 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1015-gaf7d526680-fm-20220929.001-gaf7d5266
Mime-Version: 1.0
Message-Id: <b8e86bd9-f8a1-4f37-8f1a-ae0b6209d922@app.fastmail.com>
In-Reply-To: <20221003222133.20948-5-aliraza@bu.edu>
References: <20221003222133.20948-1-aliraza@bu.edu>
 <20221003222133.20948-5-aliraza@bu.edu>
Date:   Tue, 04 Oct 2022 10:43:47 -0700
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
        rmancuso@bu.edu, "Daniel Bristot de Oliveira" <bristot@kernel.org>
Subject: Re: [RFC UKL 04/10] x86/entry: Create alternate entry path for system calls
Content-Type: text/plain
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On Mon, Oct 3, 2022, at 3:21 PM, Ali Raza wrote:
> If a UKL application makes a system call, it won't go through with the
> syscall assembly instruction. Instead, the application will use the call
> instruction to go to the kernel entry point. Instead of adding checks to
> the normal entry_SYSCALL_64 to see if we came here from a UKL task or a
> normal application task, we create a totally new entry point called
> ukl_entry_SYSCALL_64. This allows the normal entry point to be unchanged
> and simplifies the UKL specific code as well.
>
> ukl_entry_SYSCALL_64 is similar to entry_SYSCALL_64 except that it has to
> populate %rcx with return address manually (syscall instruction does that
> automatically for normal application tasks). This allows the pt_regs to be
> correct. Also, we have to push the flags onto the user stack, because on
> the return path, we first switch to user stack, then pop the flags and then
> return. Popping the flags would restart interrupts, so we dont want to be
> stuck on kernel stack when an interrupt hits. All this can be done with an
> iret instruction, but call/iret pair performans way slower than a call/ret
> pair.
>
> Also, on the entry path, we make sure the context flag i.e., in_user is set
> to 1 to indicate we are now in kernel context so any new interrupts dont
> have to go through kernel entry code again. This is normally done with the
> CS value on stack, but in UKL case that will always be a kernel value. On
> the way back, the in_user is switched back to 2 to indicate that now
> application context is being entered. All non-UKL tasks have the in_user
> value set to 0.


>
> The UKL application uses a slightly different value for CS, instead of
> 0x33, we use 0xC3. As most of the tests compare only the least significant
> nibble, they behave as expected. The C value in the second nibble allows us
> to distinguish between user space and UKL application code.

My intuition would be to try this the other way around.  Use an actual honest CS (specifically _KERNEL_CS) for pt_regs->cs.  Translate at the user ABI boundary instead.  After all, a UKL task is essentially just a kernel thread that happens to have a pt_regs area.


>
> Rest of the code makes sure the above mentioned in_user context tracking is
> done for all entry and exit cases i.e., for interrupts, exceptions etc.  If
> its a UKL task, if in_user value is 2, we treat it as an application task,
> and if it is 1, we treat it as coming from kernel context. We skip these
> checks if in_user is 0.

By "context tracking" are you referring to RCU?  Since a UKL task is essentially a kernel thread, what "entry" is there other than setting up pt_regs?

>
> swapgs_restore_regs_and_return_to_usermode changes also make sure that
> in_user is correct and then we iret back.
>
> Double fault handling is special case. Normally, if a user stack suffers a
> page fault, hardware switches to a kernel stack and pushes a frame onto the
> kernel stack. This switch only happens if the execution was in user
> privilege level when the page fault occurred. For UKL, execution is always
> in kernel level, so when the user stack suffers a page fault, no switch to
> a pinned kernel stack happens, and hardware tries to push state on the
> already faulting user stack. This generates a double fault. So we handle
> this case in the double fault handler by assuming any double fault is
> actually a user stack page fault. This can also be fixed by making all page
> faults go through a pinned stack using the IST mechanism. We have tried and
> tested that, but in the interest of touching as little code as possible, we
> chose this option instead.

Eww.  I guess this is a real problem, but eww.

