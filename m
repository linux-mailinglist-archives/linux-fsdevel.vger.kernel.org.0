Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A01C2436EEC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Oct 2021 02:40:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232230AbhJVAmS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Oct 2021 20:42:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:37520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229512AbhJVAmR (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Oct 2021 20:42:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D0FB8610EA;
        Fri, 22 Oct 2021 00:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634863200;
        bh=YI8Zfk561ht2DkhBm2zzblKrdL784Q8av/3a0SxfxXc=;
        h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
        b=s8Cz1wmAB35qNsxrGaFdbqCdJHmaHNmBY2pu9w9cF7px4iooPgT50aUBBqr0YgYti
         eNuy0f/P8dUen5MvshVVNUF3rWomGVm4kNVvnFkizAJYu8MoBFIFJxNm2LnOpAzm94
         t0KDbnWohwGpy17FeraKvU9uCp/zKmFb9R3JMi6c3+rNdmZU3o1zaBcm/PdQWK7+Yr
         I7TVlGAmQ93n83hfV4xXpPo2aMVqDl9lvrmdUFuYtIsYXrpZvGaKhoU6hHMSJnbLMa
         Fq/S9QA/YBgC/0BO2ayXlhv6xgSNjgDiy/k2yt+4fWC2Wlhn3e7r5KHN5e3wwYHMm9
         Wd/ZWeNmR+qCw==
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id D859327C0054;
        Thu, 21 Oct 2021 20:39:58 -0400 (EDT)
Received: from imap48 ([10.202.2.98])
  by compute6.internal (MEProxy); Thu, 21 Oct 2021 20:39:58 -0400
X-ME-Sender: <xms:XghyYaxyvIKOMaP_EH57t97R9DagA-k4zckZYeJFEJsUbfuUBZqbHQ>
    <xme:XghyYWR3yR9ki283whP371kkLedZn54ouEqGvxF9blxpudAgAa4DQ5Qz6tuuyUZF2
    2uZIzjYrZZG7tlExWE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrvddvjedgfeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdetnhgu
    hicunfhuthhomhhirhhskhhifdcuoehluhhtoheskhgvrhhnvghlrdhorhhgqeenucggtf
    frrghtthgvrhhnpedthfehtedtvdetvdetudfgueeuhfdtudegvdelveelfedvteelfffg
    fedvkeegfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpegrnhguhidomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudduiedukeeh
    ieefvddqvdeifeduieeitdekqdhluhhtoheppehkvghrnhgvlhdrohhrgheslhhinhhugi
    drlhhuthhordhush
X-ME-Proxy: <xmx:XghyYcUFnEl3ZYBNKtdQR2ehojaCfY0HZV4td2aRVePURlGVXSAfaQ>
    <xmx:XghyYQjfHPFbgPewSmrYYDvhK5GCNIchFzVev0n3yMQb1wd5ryGiqg>
    <xmx:XghyYcDqT2FkHNmNQeQ_D8aXZVfoB4jf54T8n_jRIJ1A2ep91_N4Sg>
    <xmx:XghyYe3aG8ybYAbE99wvJynMxzQM6tFUCPxAymFtFRHStGMK_hzHPw>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 7512D21E006E; Thu, 21 Oct 2021 20:39:58 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-1369-gd055fb5e7c-fm-20211018.002-gd055fb5e
Mime-Version: 1.0
Message-Id: <08669c29-a19e-44a8-a53e-acfa773d4680@www.fastmail.com>
In-Reply-To: <202110211310.634B74A@keescook>
References: <20211008235504.2957528-1-keescook@chromium.org>
 <f4b83c21-4e73-45b6-ae3a-17659be512c0@www.fastmail.com>
 <202110211310.634B74A@keescook>
Date:   Thu, 21 Oct 2021 17:39:38 -0700
From:   "Andy Lutomirski" <luto@kernel.org>
To:     "Kees Cook" <keescook@chromium.org>
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Mark Rutland" <mark.rutland@arm.com>,
        "Shuah Khan" <shuah@kernel.org>,
        "Alexey Dobriyan" <adobriyan@gmail.com>,
        linux-kselftest@vger.kernel.org,
        "Josh Poimboeuf" <jpoimboe@redhat.com>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "Alexey Gladkov" <gladkov.alexey@gmail.com>,
        "Jann Horn" <jannh@google.com>,
        "Vito Caputo" <vcaputo@pengaru.com>,
        "Ingo Molnar" <mingo@redhat.com>, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        "Steven Rostedt" <rostedt@goodmis.org>,
        "Ben Segall" <bsegall@google.com>, mgorman@suse.de,
        bristot@redhat.com,
        "Christian Brauner" <christian.brauner@ubuntu.com>,
        amistry@google.com, Kenta.Tada@sony.com, legion@kernel.org,
        michael.weiss@aisec.fraunhofer.de,
        "Michal Hocko" <mhocko@suse.com>, deller@gmx.de,
        "Qi Zheng" <zhengqi.arch@bytedance.com>, me@tobin.cc,
        tycho@tycho.pizza, "Thomas Gleixner" <tglx@linutronix.de>,
        "Borislav Petkov" <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>,
        "Jens Axboe" <axboe@kernel.dk>, metze@samba.org,
        "Lai Jiangshan" <laijs@linux.alibaba.com>,
        "Dave Hansen" <dave.hansen@linux.intel.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        ohoono.kwon@samsung.com, kaleshsingh@google.com,
        yifeifz2@illinois.edu, linux-arch@vger.kernel.org,
        vgupta@kernel.org, "Russell King (Oracle)" <linux@armlinux.org.uk>,
        "Will Deacon" <will@kernel.org>, guoren@kernel.org,
        bcain@codeaurora.org, monstr@monstr.eu, tsbogend@alpha.franken.de,
        nickhu@andestech.com, jonas@southpole.se,
        "Michael Ellerman" <mpe@ellerman.id.au>,
        "Paul Walmsley" <paul.walmsley@sifive.com>, hca@linux.ibm.com,
        ysato@users.sourceforge.jp, davem@davemloft.net, chris@zankel.net,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] selftests: proc: Make sure wchan works when it exists
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On Thu, Oct 21, 2021, at 1:12 PM, Kees Cook wrote:
> On Thu, Oct 21, 2021 at 01:03:33PM -0700, Andy Lutomirski wrote:
>> 
>> 
>> On Fri, Oct 8, 2021, at 4:55 PM, Kees Cook wrote:
>> > This makes sure that wchan contains a sensible symbol when a process is
>> > blocked. Specifically this calls the sleep() syscall, and expects the
>> > architecture to have called schedule() from a function that has "sleep"
>> > somewhere in its name. For example, on the architectures I tested
>> > (x86_64, arm64, arm, mips, and powerpc) this is "hrtimer_nanosleep":
>> 
>> Is this really better than admitting that the whole mechanism is nonsense and disabling it?
>> 
>> We could have a fixed string for each task state and call it a day.
>
> I consider this to be "future work". In earlier discussions it came up,
> but there wasn't an obvious clean cost-free way to do this, so instead
> we're just fixing the broken corner and keeping the mostly working rest
> of it while cleaning up the weird edges. :)

True, but we have the caveat that wchan is currently broken, so in some sense we have an easier time killing it now as compared to later.  But if we don't have a fully-fleshed-out idea for how to kill it, then I'm fine with waiting.

>
> -- 
> Kees Cook
