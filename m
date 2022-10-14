Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E61B5FE787
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Oct 2022 05:19:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbiJNDTA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Oct 2022 23:19:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbiJNDSe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Oct 2022 23:18:34 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E89E1AF2C;
        Thu, 13 Oct 2022 20:18:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id E7F38CE1C9D;
        Fri, 14 Oct 2022 03:18:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8C47C433B5;
        Fri, 14 Oct 2022 03:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665717510;
        bh=XdPGgMOKnebM+bZev/ZKP6wiusPUf6c3wma5ZTnpm0o=;
        h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
        b=NxEBMe6pbFjKd5o5ykIa5BBRdhg0vXYTfKC2h/D5ORGx4SQhCcGSoE7R+BgRKqfFB
         Rylt70PtJEJ6PROIB3006reKSYCVr/UMrnreQvIlLB8Gtg9j4hrgG7Kfd1gTHVSMFD
         i4OuVq5ePV43QQA+lzCIkX4z4ODh2uWUl9poGO5vnpf7cD6e1gutexipao9jTzA1dE
         9SZ4HB8qoHNFI29le+vTlFj/Up3dUyUU2Oc8hcBk9m+WrPxanjr9r7+y/ehilr3Z4K
         XX2qYX0JEFAu5pJlnwAwPheP+kme30rgei6t5F6FvG2a+ivCnxv2LyQRoKnJTvkAjs
         FUg8zL6DGDsSA==
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id 7304527C0054;
        Thu, 13 Oct 2022 23:18:27 -0400 (EDT)
Received: from imap48 ([10.202.2.98])
  by compute2.internal (MEProxy); Thu, 13 Oct 2022 23:18:27 -0400
X-ME-Sender: <xms:AdVIYzOOj40fYDS1rOvXIoESyi161w0DmwR247bhjuKHqLFeT9OiDA>
    <xme:AdVIY99529hlGQo-8KK9C30W0jlvvwwm75Z23pVzj3dmAFAsNJ7f6r-P3PWWqRCOA
    Phzta6qNL1zttkMjs8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeekuddgieelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehn
    ugihucfnuhhtohhmihhrshhkihdfuceolhhuthhosehkvghrnhgvlhdrohhrgheqnecugg
    ftrfgrthhtvghrnhepgeejhfehkeejleffheetkefhtdduuedtieehheekgfekudeggfff
    udejuddufeeknecuffhomhgrihhnpegthhhrohhmihhumhdrohhrghenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrnhguhidomhgvshhmthhp
    rghuthhhphgvrhhsohhnrghlihhthidqudduiedukeehieefvddqvdeifeduieeitdekqd
    hluhhtoheppehkvghrnhgvlhdrohhrgheslhhinhhugidrlhhuthhordhush
X-ME-Proxy: <xmx:AdVIYySW5Tdj3xc9QCIj2mq3H0rlkZatHo_4MuZZWFFBYFhYq8rSyA>
    <xmx:AdVIY3uxuPeTfHWQd84oguwbXb3jq_lpHxPlgcluwo9B3Bp9AzVjRg>
    <xmx:AdVIY7fXv-y_hn4d5Su6ASkwBxzA9fYhaSJ9rz-aLpvt3ull2hzjEQ>
    <xmx:A9VIY5GVCHHHXumAGXj3B2GHtzhL21R2t0gobETwrTSxeyRxILj7NXJ9Hqc>
Feedback-ID: ieff94742:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 878A331A03F7; Thu, 13 Oct 2022 23:18:25 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1047-g9e4af4ada4-fm-20221005.001-g9e4af4ad
Mime-Version: 1.0
Message-Id: <2032f766-1704-486b-8f24-a670c0b3cb32@app.fastmail.com>
In-Reply-To: <CAG48ez0sEkmaez9tYqgMXrkREmXZgxC9fdQD3mzF9cGo_=Tfyg@mail.gmail.com>
References: <20221006082735.1321612-1-keescook@chromium.org>
 <20221006082735.1321612-2-keescook@chromium.org>
 <20221006090506.paqjf537cox7lqrq@wittgenstein>
 <CAG48ez0sEkmaez9tYqgMXrkREmXZgxC9fdQD3mzF9cGo_=Tfyg@mail.gmail.com>
Date:   Thu, 13 Oct 2022 20:18:04 -0700
From:   "Andy Lutomirski" <luto@kernel.org>
To:     "Jann Horn" <jannh@google.com>,
        "Christian Brauner" <brauner@kernel.org>
Cc:     "Kees Cook" <keescook@chromium.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Jorge Merlino" <jorge.merlino@canonical.com>,
        "Al Viro" <viro@zeniv.linux.org.uk>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Sebastian Andrzej Siewior" <bigeasy@linutronix.de>,
        "Andrew Morton" <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        "John Johansen" <john.johansen@canonical.com>,
        "Paul Moore" <paul@paul-moore.com>,
        "James Morris" <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        "Stephen Smalley" <stephen.smalley.work@gmail.com>,
        "Eric Paris" <eparis@parisplace.org>,
        "Richard Haines" <richard_c_haines@btinternet.com>,
        "Casey Schaufler" <casey@schaufler-ca.com>,
        "Xin Long" <lucien.xin@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        "Todd Kjos" <tkjos@google.com>,
        "Ondrej Mosnacek" <omosnace@redhat.com>,
        "Prashanth Prahlad" <pprahlad@redhat.com>,
        "Micah Morton" <mortonm@chromium.org>,
        "Fenghua Yu" <fenghua.yu@intel.com>,
        "Andrei Vagin" <avagin@gmail.com>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH 1/2] fs/exec: Explicitly unshare fs_struct on exec
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



On Thu, Oct 6, 2022, at 7:13 AM, Jann Horn wrote:
> On Thu, Oct 6, 2022 at 11:05 AM Christian Brauner <brauner@kernel.org> wrote:
>> On Thu, Oct 06, 2022 at 01:27:34AM -0700, Kees Cook wrote:
>> > The check_unsafe_exec() counting of n_fs would not add up under a heavily
>> > threaded process trying to perform a suid exec, causing the suid portion
>> > to fail. This counting error appears to be unneeded, but to catch any
>> > possible conditions, explicitly unshare fs_struct on exec, if it ends up
>>
>> Isn't this a potential uapi break? Afaict, before this change a call to
>> clone{3}(CLONE_FS) followed by an exec in the child would have the
>> parent and child share fs information. So if the child e.g., changes the
>> working directory post exec it would also affect the parent. But after
>> this change here this would no longer be true. So a child changing a
>> workding directoro would not affect the parent anymore. IOW, an exec is
>> accompanied by an unshare(CLONE_FS). Might still be worth trying ofc but
>> it seems like a non-trivial uapi change but there might be few users
>> that do clone{3}(CLONE_FS) followed by an exec.
>
> I believe the following code in Chromium explicitly relies on this
> behavior, but I'm not sure whether this code is in active use anymore:
>
> https://source.chromium.org/chromium/chromium/src/+/main:sandbox/linux/suid/sandbox.c;l=101?q=CLONE_FS&sq=&ss=chromium

Wait, this is absolutely nucking futs.  On a very quick inspection, the sharable things like this are fs, files, sighand, and io.    files and sighand get unshared, which makes sense.  fs supposedly checks for extra refs and prevents gaining privilege.  io is... ignored!  At least it's not immediately obvious that io is a problem.

But seriously, this makes no sense at all.  It should not be possible to exec a program and then, without ptrace, change its cwd out from under it.  Do we really need to preserve this behavior?

--Andy
