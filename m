Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AB2D3F8D48
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Aug 2021 19:49:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231801AbhHZRuU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Aug 2021 13:50:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:40442 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230306AbhHZRuT (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Aug 2021 13:50:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2043460BD3;
        Thu, 26 Aug 2021 17:49:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630000172;
        bh=lReqgclYIFAZnv3E1iu34NrB91WXtZu1iej15RQQIFY=;
        h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
        b=r0D1vkve2VQ3RChfzcruMmdh48kqLDSNBDHeNxpqyreG0SiFvvBPBEZXcNMeMpM4V
         xKmOyf19vxmVgId0s8j1S6dk3ONiMCTNbjyWAwywh5RaB8/DVSYcj5lY8zNK66Fqwj
         DM+C7qcur26iBGD/AuVh+n+wmIKVbhSNLYrMmu864cSnu1ufovsKqsMgNN9pxngI9e
         Yqg/MFnIOWz6aoFhpWSUJgM6Rdat8QlewEgNpNzzDo0WqGzDqBnX5fq/UEJOBN42+Z
         kN/dQbC6HhuSHaMK2M2rgo4HpMqGlkgd1ga5HgZYhkFo5ze+VKsFb+Op77+3vC7lJU
         MAgcdnTYcyxWA==
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id 35C6027C0054;
        Thu, 26 Aug 2021 13:49:30 -0400 (EDT)
Received: from imap2 ([10.202.2.52])
  by compute6.internal (MEProxy); Thu, 26 Aug 2021 13:49:30 -0400
X-ME-Sender: <xms:KNQnYRbEoqC2AAJaImc1Vw5QcEgu0SopcMT4DJSNNKYNerG7b3_DLg>
    <xme:KNQnYYZdt8GcaR_AaCPDHsQg4HkKuAXNV2JL4MmllmxjwMsQIvYGb77XMSvYiwLq2
    sUJJNq5u_FZRJFWaM4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudduuddgudduiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    nhguhicunfhuthhomhhirhhskhhifdcuoehluhhtoheskhgvrhhnvghlrdhorhhgqeenuc
    ggtffrrghtthgvrhhnpefghfeiueevhfeifeetudegkeeileekhedvieeivdehkeeuuedv
    teehkeetffdtheenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghnugihodhmvghsmhhtphgr
    uhhthhhpvghrshhonhgrlhhithihqdduudeiudekheeifedvqddvieefudeiiedtkedqlh
    huthhopeepkhgvrhhnvghlrdhorhhgsehlihhnuhigrdhluhhtohdruhhs
X-ME-Proxy: <xmx:KNQnYT-OAZybKXI6F724gh-LUdOb0dr15E-RIwztlsJ337AqLId4dQ>
    <xmx:KNQnYfqWbdsaiU1YFHpbNhsaC0mWqINVD1jje2bb0jht_w31NsUtqg>
    <xmx:KNQnYcqoCRpUNUvuz3K5AnhgbgEOJjGV8A2YUeXs8yKHDPEmqeS0JQ>
    <xmx:KtQnYZgBtHuX7-z5mgYkRwqe0tCfJRGmNbKHRvqN5HhW10CC3yEmuKXUYqg>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 6C0B3A038A7; Thu, 26 Aug 2021 13:49:28 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-1125-g685cec594c-fm-20210825.001-g685cec59
Mime-Version: 1.0
Message-Id: <b60e9bd1-7232-472d-9c9c-1d6593e9e85e@www.fastmail.com>
In-Reply-To: <CAHk-=wiJ0u33h2CXAO4b271Diik=z4jRt64=Gt6YV2jV4ef27g@mail.gmail.com>
References: <20210812084348.6521-1-david@redhat.com> <87o8a2d0wf.fsf@disp2133>
 <60db2e61-6b00-44fa-b718-e4361fcc238c@www.fastmail.com>
 <87lf56bllc.fsf@disp2133>
 <CAHk-=wgru1UAm3kAKSOdnbewPXQMOxYkq9PnAsRadAC6pXCCMQ@mail.gmail.com>
 <87eeay8pqx.fsf@disp2133> <5b0d7c1e73ca43ef9ce6665fec6c4d7e@AcuMS.aculab.com>
 <87h7ft2j68.fsf@disp2133>
 <CAHk-=whmXTiGUzVrTP=mOPQrg-XOi3R-45hC4dQOqW4JmZdFUQ@mail.gmail.com>
 <b629cda1-becd-4725-b16c-13208ff478d3@www.fastmail.com>
 <CAHk-=wiJ0u33h2CXAO4b271Diik=z4jRt64=Gt6YV2jV4ef27g@mail.gmail.com>
Date:   Thu, 26 Aug 2021 10:48:55 -0700
From:   "Andy Lutomirski" <luto@kernel.org>
To:     "Linus Torvalds" <torvalds@linux-foundation.org>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        "David Laight" <David.Laight@aculab.com>,
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

On Fri, Aug 13, 2021, at 5:54 PM, Linus Torvalds wrote:
> On Fri, Aug 13, 2021 at 2:49 PM Andy Lutomirski <luto@kernel.org> wrot=
e:
> >
> > I=E2=80=99ll bite.  How about we attack this in the opposite directi=
on: remove the deny write mechanism entirely.
>=20
> I think that would be ok, except I can see somebody relying on it.
>=20
> It's broken, it's stupid, but we've done that ETXTBUSY for a _loong_ t=
ime.

Someone off-list just pointed something out to me, and I think we should=
 push harder to remove ETXTBSY.  Specifically, we've all been focused on=
 open() failing with ETXTBSY, and it's easy to make fun of anyone openin=
g a running program for write when they should be unlinking and replacin=
g it.

Alas, Linux's implementation of deny_write_access() is correct^Wabsurd, =
and deny_write_access() *also* returns ETXTBSY if the file is open for w=
rite.  So, in a multithreaded program, one thread does:

fd =3D open("some exefile", O_RDWR | O_CREAT | O_CLOEXEC);
write(fd, some stuff);

<--- problem is here

close(fd);
execve("some exefile");

Another thread does:

fork();
execve("something else");

In between fork and execve, there's another copy of the open file descri=
ption, and i_writecount is held, and the execve() fails.  Whoops.  See, =
for example:

https://github.com/golang/go/issues/22315

I propose we get rid of deny_write_access() completely to solve this.

Getting rid of i_writecount itself seems a bit harder, since a handful o=
f filesystems use it for clever reasons.

(OFD locks seem like they might have the same problem.  Maybe we should =
have a clone() flag to unshare the file table and close close-on-exec th=
ings?)

>=20
> But you are right that we have removed parts of it over time (no more
> MAP_DENYWRITE, no more uselib()) so that what we have today is a
> fairly weak form of what we used to do.
>=20
> And nobody really complained when we weakened it, so maybe removing it
> entirely might be acceptable.
>=20
>               Linus
>=20
