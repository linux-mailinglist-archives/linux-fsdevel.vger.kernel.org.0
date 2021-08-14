Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10B383EBF18
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Aug 2021 02:49:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235994AbhHNAuL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Aug 2021 20:50:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:56286 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235870AbhHNAuL (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Aug 2021 20:50:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8238260FBF;
        Sat, 14 Aug 2021 00:49:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628902183;
        bh=GbEcyKahqLyZSn3fvAE19yQmc43heTDUyKcIa187qpk=;
        h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
        b=kb8q3ES/OlUeFnGwm2nZ6coTdpkegt4bvJhthqi9fPoDOkqV/BAKtCt2Wo9LceHL8
         Xh20AAtd62BZyXezDObdVgMrdeIPR8EuPm2juAo8G537k0XDJW3oGtscPimgMilKOC
         uRgp0VaLAVymgtfXCdIAi5TNg4tlXd8hc6pc0EZEn21ZWww/0HI7wkr68PXh5ZFQbY
         FB93iMq9GwF0BLAqcIaiXPXC/m4w2qXfzcno9V3xfnp2S4U3/YoziI+iZbrQQiMTHO
         Rnjc6vqW0IgsdhYgO9jOZEzcDM1EO8KF3QQdZ62Zc5mYJxEVQVjnhIqERap0Hkr+Fp
         Jelj35wMNsqcA==
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id A065727C005B;
        Fri, 13 Aug 2021 20:49:41 -0400 (EDT)
Received: from imap2 ([10.202.2.52])
  by compute6.internal (MEProxy); Fri, 13 Aug 2021 20:49:41 -0400
X-ME-Sender: <xms:JBMXYTXxfuWiSKzvryH_9RTCO40HOqT71ZNZUwFgUsQK0CcavmF8Fw>
    <xme:JBMXYbltlF5FESSeFGhJaaqErC314ROQ_pWrcaMgNb1zIClxepsUIdX3Bgatb5gQe
    C_QK-H4ePMhvb-jCN8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrkeeigdefjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvufgtgfesthhqredtreerjeenucfhrhhomhepfdetnhgu
    hicunfhuthhomhhirhhskhhifdcuoehluhhtoheskhgvrhhnvghlrdhorhhgqeenucggtf
    frrghtthgvrhhnpedvleehjeejvefhuddtgeegffdtjedtffegveethedvgfejieevieeu
    feevuedvteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpegrnhguhidomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudduiedukeeh
    ieefvddqvdeifeduieeitdekqdhluhhtoheppehkvghrnhgvlhdrohhrgheslhhinhhugi
    drlhhuthhordhush
X-ME-Proxy: <xmx:JBMXYfZFsyuAMPvEx074easdJDwKTMwB1l00uLfYNJJcz3EkO6iKSQ>
    <xmx:JBMXYeU528M8Kaaq6SN5PVz21cP9-XOlmSxnInkrnyuySFEmwTJfxQ>
    <xmx:JBMXYdkou4uApxEP0lQpOD4gP91qgIDYF2Nd2FWEpbwJBFwfcmFoGA>
    <xmx:JRMXYWejkWN-pkak3K1ecWDAdujqAraJ6R83tFOKICNBh-AL6Fl0AFmV7Wo>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 17914A038A7; Fri, 13 Aug 2021 20:49:40 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-554-g53a5f93b7d-fm-20210809.002-g53a5f93b
Mime-Version: 1.0
Message-Id: <b629cda1-becd-4725-b16c-13208ff478d3@www.fastmail.com>
In-Reply-To: <CAHk-=whmXTiGUzVrTP=mOPQrg-XOi3R-45hC4dQOqW4JmZdFUQ@mail.gmail.com>
References: <20210812084348.6521-1-david@redhat.com> <87o8a2d0wf.fsf@disp2133>
 <60db2e61-6b00-44fa-b718-e4361fcc238c@www.fastmail.com>
 <87lf56bllc.fsf@disp2133>
 <CAHk-=wgru1UAm3kAKSOdnbewPXQMOxYkq9PnAsRadAC6pXCCMQ@mail.gmail.com>
 <87eeay8pqx.fsf@disp2133> <5b0d7c1e73ca43ef9ce6665fec6c4d7e@AcuMS.aculab.com>
 <87h7ft2j68.fsf@disp2133>
 <CAHk-=whmXTiGUzVrTP=mOPQrg-XOi3R-45hC4dQOqW4JmZdFUQ@mail.gmail.com>
Date:   Fri, 13 Aug 2021 17:49:19 -0700
From:   "Andy Lutomirski" <luto@kernel.org>
To:     "Linus Torvalds" <torvalds@linux-foundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     "David Laight" <David.Laight@aculab.com>,
        "David Hildenbrand" <david@redhat.com>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
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
        "linux-unionfs@vger.kernel.org" <linux-unionfs@vger.kernel.org>,
        "Linux API" <linux-api@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "<linux-fsdevel@vger.kernel.org>" <linux-fsdevel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        "Florian Weimer" <fweimer@redhat.com>,
        "Michael Kerrisk" <mtk.manpages@gmail.com>
Subject: Re: [PATCH v1 0/7] Remove in-tree usage of MAP_DENYWRITE
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On Fri, Aug 13, 2021, at 5:31 PM, Linus Torvalds wrote:
> On Fri, Aug 13, 2021 at 10:18 AM Eric W. Biederman
> <ebiederm@xmission.com> wrote:
> >
> > Florian Weimer, would it be possible to get glibc's ld.so implementa=
tion to use
> > MAP_SHARED?  Just so people reading the code know what to expect of =
the
> > kernel?  As far as I can tell there is not a practical difference
> > between a read-only MAP_PRIVATE and a read-only MAP_SHARED.
>=20
> There's a huge difference.
>=20
> For one, you actually don't necessarily want read-only. Doing COW on
> library images is quite common for things like relocation etc (you'd
> _hope_ everything is PC-relative, but no)
>=20
> So no. Never EVER use MAP_SHARED unless you literally expect to have
> two different mappings that need to be kept in sync and one writes the=

> other.
>=20
> I'll just repeat: stop arguing about this case. If somebody writes to
> a busy library, THAT IS A FUNDAMENTAL BUG, and nobody sane should care=

> at all about it apart from the "you get what you deserve".
>=20
> What's next? Do you think glibc should also map every byte in the user=

> address space so that user programs don't get SIGSEGV when they have
> wild pointers?
>=20
> Again - that's a user BUG and trying to "work around" a wild pointer
> is a worse fix than the problem it tries to fix.
>=20
> The exact same thing is true for shared library (or executable)
> mappings. Trying to work around people writing to them is *worse* than=

> the bug of doing so.
>=20
> Stop this completely inane discussion already.
>=20

I=E2=80=99ll bite.  How about we attack this in the opposite direction: =
remove the deny write mechanism entirely.

In my life, I=E2=80=99ve encountered -ETXTBUSY intermittently, and it in=
variably means that I somehow failed to finish killing a program fast en=
ough for whatever random rebuild I=E2=80=99m doing to succeed. It=E2=80=99=
s at best erratic =E2=80=94 it only applies for static binaries, and it =
has never once saved me from a problem I care about. If the program I=E2=
=80=99m recompiling crashes, I don=E2=80=99t care =E2=80=94 it=E2=80=99s=
 probably already part way through dying from an unrelated fatal signal.=
  What actually happens is that I see -ETXTBUSY, think =E2=80=9Cwait, th=
is isn=E2=80=99t Windows, why are there file sharing rules,=E2=80=9D the=
n think =E2=80=9Cwait, Linux has *one* half baked file sharing rule,=E2=80=
=9D and go on with my life. [0]

Seriously, can we deprecate and remove the whole thing?

[0] we have mandatory locks, too. Sigh.
