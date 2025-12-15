Return-Path: <linux-fsdevel+bounces-71288-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AFF8CBC8B5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Dec 2025 06:15:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C53DA30125FD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Dec 2025 05:15:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFB413242A3;
	Mon, 15 Dec 2025 05:15:30 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75831322537;
	Mon, 15 Dec 2025 05:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765775730; cv=none; b=mNSPL2LGqvKGjxTG4kpBJfjUtXklu0MPf9tbvEwMS3yhMqA4k8a3D6h66UBg1DYwyGI0NNmww6VXQKu6R9sDUdcQBGpRjS5156Gh8E0Fq+aK58UYaFJIQZGogF6EIKD1xd4lcNBRXhuvjXpGLbTMDsF66wXy0iMNqJEnK2682jU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765775730; c=relaxed/simple;
	bh=axbVRlmpoqHXKy7D9DYTP2RH8Eh/CvptUY+r60J/TOg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=He6zUHzYCiKlaxCIrlTtOO7YsD6PqM2XRq4hDJkTx8Iisu2hGUN1PsE0B9A22AQWUXCXnmCkux1ut5t9EsRgHnaAwL8ajQQWGxHmSfMGIf7hptJzPJ6qzMTFFebRX7anPK4VZKNUNwsFCRkMO5/MStdP45aHiaEi8dReODr1Q/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-c2dff70000001609-de-693f996afb50
Date: Mon, 15 Dec 2025 14:15:17 +0900
From: Byungchul Park <byungchul@sk.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: linux-kernel@vger.kernel.org, kernel_team@skhynix.com,
	torvalds@linux-foundation.org, damien.lemoal@opensource.wdc.com,
	linux-ide@vger.kernel.org, adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org, mingo@redhat.com, peterz@infradead.org,
	will@kernel.org, tglx@linutronix.de, rostedt@goodmis.org,
	joel@joelfernandes.org, sashal@kernel.org, daniel.vetter@ffwll.ch,
	duyuyang@gmail.com, johannes.berg@intel.com, tj@kernel.org,
	tytso@mit.edu, willy@infradead.org, david@fromorbit.com,
	amir73il@gmail.com, gregkh@linuxfoundation.org, kernel-team@lge.com,
	linux-mm@kvack.org, akpm@linux-foundation.org, mhocko@kernel.org,
	minchan@kernel.org, hannes@cmpxchg.org, vdavydov.dev@gmail.com,
	sj@kernel.org, jglisse@redhat.com, dennis@kernel.org, cl@linux.com,
	penberg@kernel.org, rientjes@google.com, vbabka@suse.cz,
	ngupta@vflare.org, linux-block@vger.kernel.org,
	josef@toxicpanda.com, linux-fsdevel@vger.kernel.org, jack@suse.cz,
	dan.j.williams@intel.com, hch@infradead.org, djwong@kernel.org,
	dri-devel@lists.freedesktop.org, rodrigosiqueiramelo@gmail.com,
	melissa.srw@gmail.com, hamohammed.sa@gmail.com,
	harry.yoo@oracle.com, chris.p.wilson@intel.com,
	gwan-gyeong.mun@intel.com, max.byungchul.park@gmail.com,
	boqun.feng@gmail.com, longman@redhat.com, yunseong.kim@ericsson.com,
	ysk@kzalloc.com, yeoreum.yun@arm.com, netdev@vger.kernel.org,
	matthew.brost@intel.com, her0gyugyu@gmail.com, corbet@lwn.net,
	catalin.marinas@arm.com, bp@alien8.de, x86@kernel.org,
	hpa@zytor.com, luto@kernel.org, sumit.semwal@linaro.org,
	gustavo@padovan.org, christian.koenig@amd.com,
	andi.shyti@kernel.org, arnd@arndb.de, lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com, rppt@kernel.org, surenb@google.com,
	mcgrof@kernel.org, petr.pavlu@suse.com, da.gomez@kernel.org,
	samitolvanen@google.com, paulmck@kernel.org, frederic@kernel.org,
	neeraj.upadhyay@kernel.org, joelagnelf@nvidia.com,
	josh@joshtriplett.org, urezki@gmail.com,
	mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
	qiang.zhang@linux.dev, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	bsegall@google.com, mgorman@suse.de, vschneid@redhat.com,
	chuck.lever@oracle.com, neil@brown.name, okorniev@redhat.com,
	Dai.Ngo@oracle.com, tom@talpey.com, trondmy@kernel.org,
	anna@kernel.org, kees@kernel.org, bigeasy@linutronix.de,
	clrkwllms@kernel.org, mark.rutland@arm.com, ada.coupriediaz@arm.com,
	kristina.martsenko@arm.com, wangkefeng.wang@huawei.com,
	broonie@kernel.org, kevin.brodsky@arm.com, dwmw@amazon.co.uk,
	shakeel.butt@linux.dev, ast@kernel.org, ziy@nvidia.com,
	yuzhao@google.com, baolin.wang@linux.alibaba.com,
	usamaarif642@gmail.com, joel.granados@kernel.org,
	richard.weiyang@gmail.com, geert+renesas@glider.be,
	tim.c.chen@linux.intel.com, linux@treblig.org,
	alexander.shishkin@linux.intel.com, lillian@star-ark.net,
	chenhuacai@kernel.org, francesco@valla.it,
	guoweikang.kernel@gmail.com, link@vivo.com, jpoimboe@kernel.org,
	masahiroy@kernel.org, brauner@kernel.org,
	thomas.weissschuh@linutronix.de, oleg@redhat.com, mjguzik@gmail.com,
	andrii@kernel.org, wangfushuai@baidu.com, linux-doc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
	linaro-mm-sig@lists.linaro.org, linux-i2c@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-modules@vger.kernel.org,
	rcu@vger.kernel.org, linux-nfs@vger.kernel.org,
	linux-rt-devel@lists.linux.dev, 2407018371@qq.com, dakr@kernel.org,
	miguel.ojeda.sandonis@gmail.com, neilb@ownmail.net,
	bagasdotme@gmail.com, wsa+renesas@sang-engineering.com,
	dave.hansen@intel.com, geert@linux-m68k.org, ojeda@kernel.org,
	alex.gaynor@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
	lossin@kernel.org, a.hindborg@kernel.org, aliceryhl@google.com,
	tmgross@umich.edu, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v18 41/42] SUNRPC: relocate struct rcu_head to the first
 field of struct rpc_xprt
Message-ID: <20251215051517.GB49936@system.software.com>
References: <20251205071855.72743-1-byungchul@sk.com>
 <20251205071855.72743-42-byungchul@sk.com>
 <cd65b963dd4edade3afb2e7d27eb33af1c62682e.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cd65b963dd4edade3afb2e7d27eb33af1c62682e.camel@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0yTZxiG837nFko+OpivsOhSJXMaRBe3PMmM29yPfdkfl+3Hkrlk68Y3
	aTjVFtCaGMtJGauu0xRC67RF6JgrhnHY5NCIzBQZNC0QpTOwFsQKKbCNCKZIZf0gy/jz5M79
	3M99vT9ejlS2M2mcpqBI1BWo81SMnJLPJzoyc+ve0uw7P/gSjAenabhf2kvB3bEyCoJLVQjW
	3B4EAf8tElztpQTUzpZS8JfThMAatrEwH+ymIVaTC1fr2xiI1PzNwDOvj4Raix+BY3KChMXZ
	EIJ2z58I3E1lDDwyd5AwOp0ECy0M2MvcNAwPRRB8b7uIIPzATUBnqIuF4cgqAUFnmIJBc70E
	ZaDm5y1gqy0n4mOGAEtzNwFR53UWhq6NU+A0ZoDNO0rDVJOVhdXJ/bBmLwTPT49ZuDHvoyES
	vshAsP8sDb8aQyy4TGESqrqWKGh9eJ+GHvcABVWxJwg8N6cIGO26zICppYMGo+0pDf7eQRoa
	x4YJmAwFaGjzDpGwfCEdAuZHCC4thNHb2ULlSIwRXFdcSHjSWE4Klea4ahycY4SVpXuM4F62
	U8Lv9Vho+HqFEL7zZgqd1glWsLcWCxV35mmhrWm3cK1nlhAci0v0B5mfyA9mi3maElGXdehz
	ec5i+TirvfriyWj3diP6lq9GMg7zB3DFmoeuRty6dj/fJdkUn4HH7sUYSTP8KzgQiJJSJIXf
	iR8YNdVIzpG8ZRuem1mhpMwL/DHc0mkhJa3gAbtnbpFSSMnbEXbUuNiNRTIeqJtePyDjpatX
	RtZLST4d//Cc27C34/IO27ot4wU8+41BslP5Hbj3l35CqsT8ggw77/rIjedvxbebApQZJVs3
	EaybCNb/CdZNBDuiriOlpqAkX63JO7A3x1CgObn3y8L8VhT/y87Tq0dvokX/R32I55AqUeFv
	P6RR0uoSvSG/D2GOVKUoqgJxS5GtNpwSdYWf6YrzRH0fSuco1RbFa8snspX8MXWRmCuKWlH3
	35bgZGlGtGeX1p/00PJ0YLL49X9efTfhi/7pZhe7w3TYPJZwPulc8puhUpt4JrIno/qr2+Ej
	lcffSHy5Qryckko0RHs+ftw/fvTH0760DynXH+zUkRsOx05edkcbeC/fkDV3JrjNxDSMZA1/
	OnNB8U7dYdbrS0htvjQR5bfqi96P/aaVTXSaM1SUPke9fzep06v/BfYi22nHAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA02SbUxbZRTH89zn9t5LtcsFcTzZjDOdi2buReNMjlG3GZPxxDizxA/LFhOp
	2824AwppkVGNSqnName2rqZF2rG1KJVAHW/bFEldAxOdE0YZSMPLgKwyCEwMFrYWCrYsRr6c
	/M///M8v58MRcMaX3AZB1hZLOq0mX80pWeXbr5i2H6/cIz/fFdgKFvOnMDwaUcAfxiAL81EL
	C+ca/Bwk3N/zYGmuVMCvA+Us9FysRzA6b0Fwf9GNwdy6wkLC3slDNDbEg8OIYCXQicAZsmMI
	91zF4L9kZOCfxmUOpjvmEDjGIxxUTBlZmPV9gcA14eZh6udsuDfapoCVkbsMDCzMIPBFlhmI
	BE8iSDjz4EJ1S3Ld+TcHi103MVQ4ehB4x0cwzE2NIbjUeRtBoLacgz9tlzHciqyDvvlZDq47
	TnFwL3SOgb8aOfCUBxQQ+n0aQZXbjmBiMMCA6esGDpxVzSy0jv3IQ2h6iYFhp52B+ub9MOqb
	YOGGrZpJnptMNWWBu8LEJMskA47v2hiI+er4vTWI3jefZmldyxWGmnsTHPWf9yO6GLcjGq0x
	YWq2JduOmVlMP2s5QWtuzHA0Pt/P0cCCh6W/VRP6zedxhp7t2k5bXSP8gdcPK189KuXLJZJu
	5+4cZe6caZgvurC+NNa2qQydEa1IEIi4iwSWn7WiNIEVt5CB/gSX0pz4DAmHYzgVyRSfJoNl
	shUpBSw6niQzk3E2lXlMPEYaWx04pVUikMDkVZwKZYgeRLxOP/9wkE6uV0ZWF3ASunS+dxWK
	xY3k22Xhob2JmC67V+00kZKpU4aU/bi4mQSv/MLY0DrXGpBrDcj1P8i1BuRBbB3KlLUlBRo5
	/6Ud+rxcg1Yu3XGksKAZJV/V9/HS2R9Q9FZ2OxIFpH5UFW7bLWcoNCV6Q0E7IgJWZ6os4aSl
	OqoxfCjpCt/TfZAv6dvRRoFVZ6nePCjlZIjHNMVSniQVSbr/poyQtqEMXfvkq13vW2ZdQWuY
	dMefe6Ij54j13TdO9598ai5EFofEvvTgcPYd7519fnrxTJWye/Px2sOG17r3+uvWNyTe2jlo
	Gw9n5WiMRfv3NDnQOx/x3n1jL9tevG3sS1uY8Dy4+WDbCm1K9/Qe3PbIoWis9NqQ8W7Em1Vf
	LGsLa/UlP52wqVl9ruaFrVin1/wLMb4wZaYDAAA=
X-CFilter-Loop: Reflected

On Fri, Dec 05, 2025 at 04:27:52AM -0500, Jeff Layton wrote:
> On Fri, 2025-12-05 at 16:18 +0900, Byungchul Park wrote:
> > While compiling Linux kernel with DEPT on, the following error was
> > observed:
> >
> >    ./include/linux/rcupdate.h:1084:17: note: in expansion of macro
> >    ‘BUILD_BUG_ON’
> >    1084 | BUILD_BUG_ON(offsetof(typeof(*(ptr)), rhf) >= 4096);        \
> >         | ^~~~~~~~~~~~
> >    ./include/linux/rcupdate.h:1047:29: note: in expansion of macro
> >    'kvfree_rcu_arg_2'
> >    1047 | #define kfree_rcu(ptr, rhf) kvfree_rcu_arg_2(ptr, rhf)
> >         |                             ^~~~~~~~~~~~~~~~
> >    net/sunrpc/xprt.c:1856:9: note: in expansion of macro 'kfree_rcu'
> >    1856 | kfree_rcu(xprt, rcu);
> >         | ^~~~~~~~~
> >     CC net/kcm/kcmproc.o
> >    make[4]: *** [scripts/Makefile.build:203: net/sunrpc/xprt.o] Error 1
> >
> > Since kfree_rcu() assumes 'offset of struct rcu_head in a rcu-managed
> > struct < 4096', the offest of struct rcu_head in struct rpc_xprt should
> > not exceed 4096 but does, due to the debug information added by DEPT.
> >
> > Relocate struct rcu_head to the first field of struct rpc_xprt from an
> > arbitrary location to avoid the issue and meet the assumption.
> >
> > Reported-by: Yunseong Kim <ysk@kzalloc.com>
> > Signed-off-by: Byungchul Park <byungchul@sk.com>
> > ---
> >  include/linux/sunrpc/xprt.h | 9 ++++++++-
> >  1 file changed, 8 insertions(+), 1 deletion(-)
> >
> > diff --git a/include/linux/sunrpc/xprt.h b/include/linux/sunrpc/xprt.h
> > index f46d1fb8f71a..666e42a17a31 100644
> > --- a/include/linux/sunrpc/xprt.h
> > +++ b/include/linux/sunrpc/xprt.h
> > @@ -211,6 +211,14 @@ enum xprt_transports {
> >
> >  struct rpc_sysfs_xprt;
> >  struct rpc_xprt {
> > +     /*
> > +      * Place struct rcu_head within the first 4096 bytes of struct
> > +      * rpc_xprt if sizeof(struct rpc_xprt) > 4096, so that
> > +      * kfree_rcu() can simply work assuming that.  See the comment
> > +      * in kfree_rcu().
> > +      */
> > +     struct rcu_head         rcu;
> > +
> >       struct kref             kref;           /* Reference count */
> >       const struct rpc_xprt_ops *ops;         /* transport methods */
> >       unsigned int            id;             /* transport id */
> > @@ -317,7 +325,6 @@ struct rpc_xprt {
> >  #if IS_ENABLED(CONFIG_SUNRPC_DEBUG)
> >       struct dentry           *debugfs;               /* debugfs directory */
> >  #endif
> > -     struct rcu_head         rcu;
> >       const struct xprt_class *xprt_class;
> >       struct rpc_sysfs_xprt   *xprt_sysfs;
> >       bool                    main; /*mark if this is the 1st transport */
> 
> Seems fine to me.
> 
> Reviewed-by: Jeff Layton <jlayton@kernel.org>

Thank you, Jeff.

	Byungchul

