Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75DA8436BBB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Oct 2021 22:04:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231924AbhJUUGN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Oct 2021 16:06:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:44782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230020AbhJUUGM (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Oct 2021 16:06:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3980561251;
        Thu, 21 Oct 2021 20:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634846635;
        bh=6wcMAPIuLrajjhebGQXqdPC04sfh6LeM6s1G6IwbmDo=;
        h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
        b=UF0Nep0XEdBF0LM9GoeKiRNKd/wpiEdDnvXUuZywx0P5uZ1fnDqYqdcYTQ0N5qeGJ
         DHfkYAV/ch05bpxv5c+gmwzQqDLf0umodqdHJaXK4kmjFDGOau6dHF2dTS7jeUGKJb
         5Txmj0ytHTJTJDLMqSmhhPskP/y6NI88ehRkLJdI7DG/NPfnqshhNnoEt/T4q3O+zh
         mU5IX0kutJ0dQmTnys1NHJyp0Dy3EgWZOZa1kldziNr2ZmTapOWOQ30s4D8Odza2YY
         0iotDf57X6QJHzwutdQS8As4whQZY3tg2dJWR8AN8E/LGZtceOFngpOc6FHn6Fwn7W
         fQKtx9rDY0VgQ==
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id 4DC3E27C0054;
        Thu, 21 Oct 2021 16:03:54 -0400 (EDT)
Received: from imap48 ([10.202.2.98])
  by compute6.internal (MEProxy); Thu, 21 Oct 2021 16:03:54 -0400
X-ME-Sender: <xms:qcdxYbiMTqQn4HSk6q_epceIccz0L_1UvyV87EFVaFIg785b2Z-LmQ>
    <xme:qcdxYYBWdRlEyzGhHXXf8z9Cb1zFw42JqdF6muPVQewPJiCtAifTncLOH2BEbxueB
    fepWttx6Wj_uhwf2TE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrvddviedgudegvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvufgtsehttdertderredtnecuhfhrohhmpedftehn
    ugihucfnuhhtohhmihhrshhkihdfuceolhhuthhosehkvghrnhgvlhdrohhrgheqnecugg
    ftrfgrthhtvghrnheptdfhheettddvtedvtedugfeuuefhtddugedvleevleefvdetleff
    gfefvdekgeefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homheprghnugihodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduudeiudek
    heeifedvqddvieefudeiiedtkedqlhhuthhopeepkhgvrhhnvghlrdhorhhgsehlihhnuh
    igrdhluhhtohdruhhs
X-ME-Proxy: <xmx:qcdxYbEsDfgAjUDtMcxcGuoptY-lMRArMcBLC5kWtPoLYDEGlijgRQ>
    <xmx:qcdxYYR50mlShwcXBJQJXp1adk2gxmrX8RbgfDnIRKyAlUajMw1-Qg>
    <xmx:qcdxYYwZvuFcsCrbTdxHmayn3ov-cTMSTp_skfWC2EMQuAZbe0ErwA>
    <xmx:qsdxYfmP2MMGkmr4dRhlEEwqeByj-8SOoeR3gSnxBw8_i69f_H64cQ>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id D117521E006E; Thu, 21 Oct 2021 16:03:53 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-1369-gd055fb5e7c-fm-20211018.002-gd055fb5e
Mime-Version: 1.0
Message-Id: <f4b83c21-4e73-45b6-ae3a-17659be512c0@www.fastmail.com>
In-Reply-To: <20211008235504.2957528-1-keescook@chromium.org>
References: <20211008235504.2957528-1-keescook@chromium.org>
Date:   Thu, 21 Oct 2021 13:03:33 -0700
From:   "Andy Lutomirski" <luto@kernel.org>
To:     "Kees Cook" <keescook@chromium.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Cc:     "Mark Rutland" <mark.rutland@arm.com>,
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



On Fri, Oct 8, 2021, at 4:55 PM, Kees Cook wrote:
> This makes sure that wchan contains a sensible symbol when a process is
> blocked. Specifically this calls the sleep() syscall, and expects the
> architecture to have called schedule() from a function that has "sleep"
> somewhere in its name. For example, on the architectures I tested
> (x86_64, arm64, arm, mips, and powerpc) this is "hrtimer_nanosleep":

Is this really better than admitting that the whole mechanism is nonsense and disabling it?

We could have a fixed string for each task state and call it a day.
