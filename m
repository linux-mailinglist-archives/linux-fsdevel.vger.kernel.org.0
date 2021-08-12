Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80D493EA9E2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Aug 2021 20:02:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237254AbhHLSCf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Aug 2021 14:02:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:58740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235453AbhHLSCb (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Aug 2021 14:02:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E8CE960FED;
        Thu, 12 Aug 2021 18:02:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628791325;
        bh=SHuQM+8f293Vwgu1Bf0Mq+SZ5B7X8I7/R4G6PeUiInk=;
        h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
        b=V3vwAR50GFwnBdbOarqwagm6WuhzDnUThFl/bYs0aCl4BkOVABJU10aoQdVYLBjzP
         Fou+e6DvAnpAX44FAhDd03cxzdlPWs1XCsGLsX5lUVmMa4jrhTa7T1514dd6n2IGzC
         XOvSqL9L6N8q0ayOLd/5PyU2vpeItvrJsTl0r+G8uGECXlYOWMg09kERbT5Q8UxLGu
         ES+aVcZgdXozhIs+hjZ857vWXMxTS9nPggXKtJXpMEoNsESuCoBNHQYxbxAE5UtTOO
         V8WSqo+Y7y81KBbyMfsY84knZ1/HYAQnjwJdnplM4PUrfpZjls5FYJzy0SFVAiOZtN
         m4xU5dDmF6qbQ==
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id 1862527C0054;
        Thu, 12 Aug 2021 14:02:04 -0400 (EDT)
Received: from imap2 ([10.202.2.52])
  by compute6.internal (MEProxy); Thu, 12 Aug 2021 14:02:04 -0400
X-ME-Sender: <xms:GmIVYVzYYgvfcvfNB0VCsfDlOZxnCO77cAVASZJTxZ3qGDaheD686g>
    <xme:GmIVYVTjPiy6o8ZKVjcZlENb1sgoyVs-lHjb4WqJYkNQI8qtyeEqSbjvcXnStnBoL
    oAptp5foCrM8m47MqE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrkeefgdduudelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdetnhgu
    hicunfhuthhomhhirhhskhhifdcuoehluhhtoheskhgvrhhnvghlrdhorhhgqeenucggtf
    frrghtthgvrhhnpedthfehtedtvdetvdetudfgueeuhfdtudegvdelveelfedvteelfffg
    fedvkeegfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpegrnhguhidomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudduiedukeeh
    ieefvddqvdeifeduieeitdekqdhluhhtoheppehkvghrnhgvlhdrohhrgheslhhinhhugi
    drlhhuthhordhush
X-ME-Proxy: <xmx:GmIVYfWa1LdQSMmC0ycsXX_oKXx-UfeqHSKifJDScJ5D9TLPNYKx9A>
    <xmx:GmIVYXiEfd0PNUBWEmGnpcU9AUJkxBaImjzwOQ2hooQ8S3JQxId-AA>
    <xmx:GmIVYXD7WH4b1FflQJJymrhLD0KZTimFwbJ44wwcilKFCw7j4Aqz-g>
    <xmx:HGIVYZDqNy7RP2OYJ2Y-oR6lM2S547b3fbPLPc4iC67aYL4Ajobz6A>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 1614CA038A7; Thu, 12 Aug 2021 14:02:02 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-554-g53a5f93b7d-fm-20210809.002-g53a5f93b
Mime-Version: 1.0
Message-Id: <9fed831a-b311-4a23-8f3a-eb7ddff9b102@www.fastmail.com>
In-Reply-To: <87lf56bllc.fsf@disp2133>
References: <20210812084348.6521-1-david@redhat.com> <87o8a2d0wf.fsf@disp2133>
 <60db2e61-6b00-44fa-b718-e4361fcc238c@www.fastmail.com>
 <87lf56bllc.fsf@disp2133>
Date:   Thu, 12 Aug 2021 11:01:36 -0700
From:   "Andy Lutomirski" <luto@kernel.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     "David Hildenbrand" <david@redhat.com>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
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



On Thu, Aug 12, 2021, at 10:48 AM, Eric W. Biederman wrote:
> "Andy Lutomirski" <luto@kernel.org> writes:

> I had a blind spot, and Florian Weimer made a very reasonable request.
> Apparently userspace for shared libraires uses MAP_PRIVATE.
> 
> So we almost don't care if the library is overwritten.  We loose some
> efficiency and apparently there are some corner cases like the library
> being extended past the end of the exiting file that are problematic.
> 
> Given that MAP_PRIVATE for shared libraries is our strategy for handling
> writes to shared libraries perhaps we just need to use MAP_POPULATE or a
> new related flag (perhaps MAP_PRIVATE_NOW) that just makes certain that
> everything mapped from the executable is guaranteed to be visible from
> the time of the mmap, and any changes from the filesystem side after
> that are guaranteed to cause a copy on write.
> 
> Once we get that figured out we could consider getting rid of deny-write
> entirely.

Are all of the CoW bits in good enough shape for this to work without just immediately CoWing the whole file?  In principle, write(2) to a file should be able to notice that it needs to CoW some pages, but I doubt that this actually works.

--Andy
