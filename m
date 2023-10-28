Return-Path: <linux-fsdevel+bounces-1488-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EB17F7DA83B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Oct 2023 19:22:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ADB17B20F6D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Oct 2023 17:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A4131798C;
	Sat, 28 Oct 2023 17:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b="NEf36SYo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 006092595;
	Sat, 28 Oct 2023 17:21:57 +0000 (UTC)
Received: from bee.tesarici.cz (bee.tesarici.cz [77.93.223.253])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34E39E1;
	Sat, 28 Oct 2023 10:21:56 -0700 (PDT)
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-4427-cc85-6706-c595.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:4427:cc85:6706:c595])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by bee.tesarici.cz (Postfix) with ESMTPSA id 1794B183AEA;
	Sat, 28 Oct 2023 19:21:48 +0200 (CEST)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=none dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tesarici.cz; s=mail;
	t=1698513709; bh=NjpBpPt/yrrzyUMwOnxT0t9fJ7lkHUICaTlDk7VnK5E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NEf36SYo3kQbCeEsdwZEo5Rs7ubi4rXjiy/HkeByeW5ZFg1NJ7jrkUSgWkxmg2M8k
	 B0u/D2sCM3DcHuuZDfcPU7EjnH661MAuSS0d/FyxcRCZoz24WCjCK0k1P8odl2097t
	 ZVT0E+8iYlsOBUWMC4fZaTpedbZzQ/CHY/uHKk5wgB1+rAceIGvg9nE6AeoAR5SMTy
	 VdPZ/XLtuodw43A4B+h4DkkMi1URAqTCzmC3/qWgJtpSG7UvnNZ/ye9sCmfnJIiYAE
	 BLpNDIscF2rgwyxelghhqIlUEu7ofl0My0JCMUOvGX60kRL5D6XzWCGs+fAiOUMIG4
	 77EOtdZarg36A==
Date: Sat, 28 Oct 2023 19:21:47 +0200
From: Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To: Suren Baghdasaryan <surenb@google.com>
Cc: Neil Brown <neilb@suse.de>, akpm@linux-foundation.org,
 kent.overstreet@linux.dev, mhocko@suse.com, vbabka@suse.cz,
 hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de,
 dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com,
 corbet@lwn.net, void@manifault.com, peterz@infradead.org,
 juri.lelli@redhat.com, ldufour@linux.ibm.com, catalin.marinas@arm.com,
 will@kernel.org, arnd@arndb.de, tglx@linutronix.de, mingo@redhat.com,
 dave.hansen@linux.intel.com, x86@kernel.org, peterx@redhat.com,
 david@redhat.com, axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org,
 nathan@kernel.org, dennis@kernel.org, tj@kernel.org, muchun.song@linux.dev,
 rppt@kernel.org, paulmck@kernel.org, pasha.tatashin@soleen.com,
 yosryahmed@google.com, yuzhao@google.com, dhowells@redhat.com,
 hughd@google.com, andreyknvl@gmail.com, keescook@chromium.org,
 ndesaulniers@google.com, vvvvvv@google.com, gregkh@linuxfoundation.org,
 ebiggers@google.com, ytcoode@gmail.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 bristot@redhat.com, vschneid@redhat.com, cl@linux.com, penberg@kernel.org,
 iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com, glider@google.com,
 elver@google.com, dvyukov@google.com, shakeelb@google.com,
 songmuchun@bytedance.com, jbaron@akamai.com, rientjes@google.com,
 minchan@google.com, kaleshsingh@google.com, kernel-team@android.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux.dev, linux-arch@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-modules@vger.kernel.org, kasan-dev@googlegroups.com,
 cgroups@vger.kernel.org
Subject: Re: [PATCH v2 06/39] mm: enumerate all gfp flags
Message-ID: <20231028192147.2a755c46@meshulam.tesarici.cz>
In-Reply-To: <CAJuCfpHS1JTRU69zFDAJjmMYR3K5TAS9+AsA3oYLs2LCs5aTBw@mail.gmail.com>
References: <20231024134637.3120277-1-surenb@google.com>
	<20231024134637.3120277-7-surenb@google.com>
	<20231025074652.44bc0eb4@meshulam.tesarici.cz>
	<CAJuCfpHS1JTRU69zFDAJjmMYR3K5TAS9+AsA3oYLs2LCs5aTBw@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 25 Oct 2023 08:28:32 -0700
Suren Baghdasaryan <surenb@google.com> wrote:

> On Tue, Oct 24, 2023 at 10:47=E2=80=AFPM Petr Tesa=C5=99=C3=ADk <petr@tes=
arici.cz> wrote:
> >
> > On Tue, 24 Oct 2023 06:46:03 -0700
> > Suren Baghdasaryan <surenb@google.com> wrote:
> > =20
> > > Introduce GFP bits enumeration to let compiler track the number of us=
ed
> > > bits (which depends on the config options) instead of hardcoding them.
> > > That simplifies __GFP_BITS_SHIFT calculation.
> > > Suggested-by: Petr Tesa=C5=99=C3=ADk <petr@tesarici.cz>
> > > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > > ---
> > >  include/linux/gfp_types.h | 90 +++++++++++++++++++++++++++----------=
--
> > >  1 file changed, 62 insertions(+), 28 deletions(-)
> > >
> > > diff --git a/include/linux/gfp_types.h b/include/linux/gfp_types.h
> > > index 6583a58670c5..3fbe624763d9 100644
> > > --- a/include/linux/gfp_types.h
> > > +++ b/include/linux/gfp_types.h
> > > @@ -21,44 +21,78 @@ typedef unsigned int __bitwise gfp_t;
> > >   * include/trace/events/mmflags.h and tools/perf/builtin-kmem.c
> > >   */
> > >
> > > +enum {
> > > +     ___GFP_DMA_BIT,
> > > +     ___GFP_HIGHMEM_BIT,
> > > +     ___GFP_DMA32_BIT,
> > > +     ___GFP_MOVABLE_BIT,
> > > +     ___GFP_RECLAIMABLE_BIT,
> > > +     ___GFP_HIGH_BIT,
> > > +     ___GFP_IO_BIT,
> > > +     ___GFP_FS_BIT,
> > > +     ___GFP_ZERO_BIT,
> > > +     ___GFP_UNUSED_BIT,      /* 0x200u unused */
> > > +     ___GFP_DIRECT_RECLAIM_BIT,
> > > +     ___GFP_KSWAPD_RECLAIM_BIT,
> > > +     ___GFP_WRITE_BIT,
> > > +     ___GFP_NOWARN_BIT,
> > > +     ___GFP_RETRY_MAYFAIL_BIT,
> > > +     ___GFP_NOFAIL_BIT,
> > > +     ___GFP_NORETRY_BIT,
> > > +     ___GFP_MEMALLOC_BIT,
> > > +     ___GFP_COMP_BIT,
> > > +     ___GFP_NOMEMALLOC_BIT,
> > > +     ___GFP_HARDWALL_BIT,
> > > +     ___GFP_THISNODE_BIT,
> > > +     ___GFP_ACCOUNT_BIT,
> > > +     ___GFP_ZEROTAGS_BIT,
> > > +#ifdef CONFIG_KASAN_HW_TAGS
> > > +     ___GFP_SKIP_ZERO_BIT,
> > > +     ___GFP_SKIP_KASAN_BIT,
> > > +#endif
> > > +#ifdef CONFIG_LOCKDEP
> > > +     ___GFP_NOLOCKDEP_BIT,
> > > +#endif
> > > +     ___GFP_LAST_BIT
> > > +};
> > > +
> > >  /* Plain integer GFP bitmasks. Do not use this directly. */
> > > -#define ___GFP_DMA           0x01u
> > > -#define ___GFP_HIGHMEM               0x02u
> > > -#define ___GFP_DMA32         0x04u
> > > -#define ___GFP_MOVABLE               0x08u
> > > -#define ___GFP_RECLAIMABLE   0x10u
> > > -#define ___GFP_HIGH          0x20u
> > > -#define ___GFP_IO            0x40u
> > > -#define ___GFP_FS            0x80u
> > > -#define ___GFP_ZERO          0x100u
> > > +#define ___GFP_DMA           BIT(___GFP_DMA_BIT)
> > > +#define ___GFP_HIGHMEM               BIT(___GFP_HIGHMEM_BIT)
> > > +#define ___GFP_DMA32         BIT(___GFP_DMA32_BIT)
> > > +#define ___GFP_MOVABLE               BIT(___GFP_MOVABLE_BIT)
> > > +#define ___GFP_RECLAIMABLE   BIT(___GFP_RECLAIMABLE_BIT)
> > > +#define ___GFP_HIGH          BIT(___GFP_HIGH_BIT)
> > > +#define ___GFP_IO            BIT(___GFP_IO_BIT)
> > > +#define ___GFP_FS            BIT(___GFP_FS_BIT)
> > > +#define ___GFP_ZERO          BIT(___GFP_ZERO_BIT)
> > >  /* 0x200u unused */ =20
> >
> > This comment can be also removed here, because it is already stated
> > above with the definition of ___GFP_UNUSED_BIT. =20
>=20
> Ack.
>=20
> >
> > Then again, I think that the GFP bits have never been compacted after
> > Neil Brown removed __GFP_ATOMIC with commit 2973d8229b78 simply because
> > that would mean changing definitions of all subsequent GFP flags. FWIW
> > I am not aware of any code that would depend on the numeric value of
> > ___GFP_* macros, so this patch seems like a good opportunity to change
> > the numbering and get rid of this unused 0x200u altogether.
> >
> > @Neil: I have added you to the conversation in case you want to correct
> > my understanding of the unused bit. =20
>=20
> Hmm. I would prefer to do that in a separate patch even though it
> would be a one-line change. Seems safer to me in case something goes
> wrong and we have to bisect and revert it. If that sounds ok I'll post
> that in the next version.

You're right. If something does go wrong, it will be easier to fix if
the removal of the unused bit is in a commit of its own.

Petr T

