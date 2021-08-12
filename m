Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 169DF3EA98D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Aug 2021 19:35:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236301AbhHLRgM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Aug 2021 13:36:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:46880 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236128AbhHLRgL (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Aug 2021 13:36:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3CA6B61019;
        Thu, 12 Aug 2021 17:35:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628789746;
        bh=GqM0ozz1NAbZTPXXCXnrXZsPDaDtj/gRbiXe7cyjPKI=;
        h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
        b=lb1ZrKzyJMkASIQ6Mjsqcmz5O8qiTtLxgjNp45e1X1QIHlNvfkul2k2tZG+GZ8lXD
         WtIwyX+HTWoey4ycNQBPDRUD1COGEmnvcoYFSlJ1TPHFrvZr3qC20rKRtwe408mRgj
         Qnsdn/8VLdkM34l6OVy//jvdV+0oVCj9DHSWpq1fx70x7D90PRt5FVqteJ/MrmMsDK
         anwZkAZNijM5Atw4wUHk9mQt5n6Hc6BSTmY6QxYeD8rP6yayEQQiOs1pbvfcVB8q05
         bhQjkbqN4Txy4IY7ErbkUwM2Cx/fZtINyEMMH2mr3sTZBBRXOk+V0/tvPNNBzVYAS/
         tZfE/rkXWAVjA==
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id 5DD9027C005A;
        Thu, 12 Aug 2021 13:35:44 -0400 (EDT)
Received: from imap2 ([10.202.2.52])
  by compute6.internal (MEProxy); Thu, 12 Aug 2021 13:35:44 -0400
X-ME-Sender: <xms:7lsVYUF_R0ay6wp_aqqI15lNkMd75Dha48oKVA_GkoSe_MZxFlDxTw>
    <xme:7lsVYdWwpx5apNIhQLasfUNDxUeQKumDekYjqubWNZUW6KO-nwKe1Ha8mBjdP3OTL
    Q_yHF5lSckG-xLpDuQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrkeefgdduudegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdetnhgu
    hicunfhuthhomhhirhhskhhifdcuoehluhhtoheskhgvrhhnvghlrdhorhhgqeenucggtf
    frrghtthgvrhhnpedthfehtedtvdetvdetudfgueeuhfdtudegvdelveelfedvteelfffg
    fedvkeegfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpegrnhguhidomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudduiedukeeh
    ieefvddqvdeifeduieeitdekqdhluhhtoheppehkvghrnhgvlhdrohhrgheslhhinhhugi
    drlhhuthhordhush
X-ME-Proxy: <xmx:7lsVYeIAAmjcPJGFtTu1VJSN5rjy1bon9dpp38u6SRmcFE3Endi2-Q>
    <xmx:7lsVYWHY4Cby2iEFUc9owbqxOPK50zCXpidfGgM6huJ2Sw_T8mhUMQ>
    <xmx:7lsVYaUL02OUOA_62YhG80HX7slhOYYLePfBY-LCc6Iw1v4WhbM5PA>
    <xmx:8FsVYVEa4wqU4F55nQRyFpfiVEfb1RhT_JVhAHBBIDH5TievSgQt1w>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 49C18A038A7; Thu, 12 Aug 2021 13:35:42 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-554-g53a5f93b7d-fm-20210809.002-g53a5f93b
Mime-Version: 1.0
Message-Id: <60db2e61-6b00-44fa-b718-e4361fcc238c@www.fastmail.com>
In-Reply-To: <87o8a2d0wf.fsf@disp2133>
References: <20210812084348.6521-1-david@redhat.com> <87o8a2d0wf.fsf@disp2133>
Date:   Thu, 12 Aug 2021 10:35:18 -0700
From:   "Andy Lutomirski" <luto@kernel.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>,
        "David Hildenbrand" <david@redhat.com>
Cc:     "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Al Viro" <viro@zeniv.linux.org.uk>,
        "Alexey Dobriyan" <adobriyan@gmail.com>,
        "Steven Rostedt" <rostedt@goodmis.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Arnaldo Carvalho de Melo" <acme@kernel.org>,
        "Mark Rutland" <mark.rutland@arm.com>,
        "Alexander Shishkin" <alexander.shishkin@linux.intel.com>,
        "Jiri Olsa" <jolsa@redhat.com>,
        "Namhyung Kim" <namhyung@kernel.org>,
        "Petr Mladek" <pmladek@suse.com>,
        "Sergey Senozhatsky" <sergey.senozhatsky@gmail.com>,
        "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>,
        "Rasmus Villemoes" <linux@rasmusvillemoes.dk>,
        "Kees Cook" <keescook@chromium.org>,
        "Greg Ungerer" <gerg@linux-m68k.org>,
        "Geert Uytterhoeven" <geert@linux-m68k.org>,
        "Mike Rapoport" <rppt@kernel.org>,
        "Vlastimil Babka" <vbabka@suse.cz>,
        "Vincenzo Frascino" <vincenzo.frascino@arm.com>,
        "Chinwen Chang" <chinwen.chang@mediatek.com>,
        "Michel Lespinasse" <walken@google.com>,
        "Catalin Marinas" <catalin.marinas@arm.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Huang Ying" <ying.huang@intel.com>,
        "Jann Horn" <jannh@google.com>, "Feng Tang" <feng.tang@intel.com>,
        "Kevin Brodsky" <Kevin.Brodsky@arm.com>,
        "Michael Ellerman" <mpe@ellerman.id.au>,
        "Shawn Anastasio" <shawn@anastas.io>,
        "Steven Price" <steven.price@arm.com>,
        "Nicholas Piggin" <npiggin@gmail.com>,
        "Christian Brauner" <christian.brauner@ubuntu.com>,
        "Jens Axboe" <axboe@kernel.dk>,
        "Gabriel Krisman Bertazi" <krisman@collabora.com>,
        "Peter Xu" <peterx@redhat.com>,
        "Suren Baghdasaryan" <surenb@google.com>,
        "Shakeel Butt" <shakeelb@google.com>,
        "Marco Elver" <elver@google.com>,
        "Daniel Jordan" <daniel.m.jordan@oracle.com>,
        "Nicolas Viennot" <Nicolas.Viennot@twosigma.com>,
        "Thomas Cedeno" <thomascedeno@google.com>,
        "Collin Fijalkovich" <cfijalkovich@google.com>,
        "Michal Hocko" <mhocko@suse.com>,
        "Miklos Szeredi" <miklos@szeredi.hu>,
        "Chengguang Xu" <cgxu519@mykernel.net>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
        linux-unionfs@vger.kernel.org,
        "Linux API" <linux-api@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v1 0/7] Remove in-tree usage of MAP_DENYWRITE
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On Thu, Aug 12, 2021, at 10:32 AM, Eric W. Biederman wrote:
> David Hildenbrand <david@redhat.com> writes:
> 
> > This series is based on v5.14-rc5 and corresponds code-wise to the
> > previously sent RFC [1] (the RFC still applied cleanly).
> >
> > This series removes all in-tree usage of MAP_DENYWRITE from the kernel
> > and removes VM_DENYWRITE. We stopped supporting MAP_DENYWRITE for
> > user space applications a while ago because of the chance for DoS.
> > The last renaming user is binfmt binary loading during exec and
> > legacy library loading via uselib().
> >
> > With this change, MAP_DENYWRITE is effectively ignored throughout the
> > kernel. Although the net change is small, I think the cleanup in mmap()
> > is quite nice.
> >
> > There are some (minor) user-visible changes with this series:
> > 1. We no longer deny write access to shared libaries loaded via legacy
> >    uselib(); this behavior matches modern user space e.g., via dlopen().
> > 2. We no longer deny write access to the elf interpreter after exec
> >    completed, treating it just like shared libraries (which it often is).
> > 3. We always deny write access to the file linked via /proc/pid/exe:
> >    sys_prctl(PR_SET_MM_EXE_FILE) will fail if write access to the file
> >    cannot be denied, and write access to the file will remain denied
> >    until the link is effectivel gone (exec, termination,
> >    PR_SET_MM_EXE_FILE) -- just as if exec'ing the file.
> >
> > I was wondering if we really care about permanently disabling write access
> > to the executable, or if it would be good enough to just disable write
> > access while loading the new executable during exec; but I don't know
> > the history of that -- and it somewhat makes sense to deny write access
> > at least to the main executable. With modern user space -- dlopen() -- we
> > can effectively modify the content of shared libraries while being
> > used.
> 
> So I think what we really want to do is to install executables with
> and shared libraries without write permissions and immutable.  So that
> upgrades/replacements of the libraries and executables are forced to
> rename or unlink them.  We need the immutable bit as CAP_DAC_OVERRIDE
> aka being root ignores the writable bits when a file is opened for
> write.  However CAP_DAC_OVERRIDE does not override the immutable state
> of a file.

If we really want to do this, I think we'd want a different flag that's more like sealed.  Non-root users should be able to do this, too.

Or we could just more gracefully handle users that overwrite running programs.

--Andy
