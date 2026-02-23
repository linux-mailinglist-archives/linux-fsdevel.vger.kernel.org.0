Return-Path: <linux-fsdevel+bounces-77880-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IAgRDQ2km2mI4AMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77880-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 01:49:17 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E78C17102F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 01:49:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 21B1D303B7F1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 00:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2C711F30A9;
	Mon, 23 Feb 2026 00:47:39 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBDD01A3160;
	Mon, 23 Feb 2026 00:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771807659; cv=none; b=r2gTlsQTaAszrTBXAXrm/5IjaoX5DkFJTRjcNVA4cNKDhhikEzliR2bAQLEton4KI8YH1HUDwmV3ZN/eDcn+PPX2REiD1ep9GqGegrUycUGgz4X9ynuG0qFfxtmbN16XvfBQZ+ogYtCl5GJCOPVAsrtghboCd5Wv9NASXNkZd6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771807659; c=relaxed/simple;
	bh=9Rg2ovzdHFVJcpJOm3vuScJXDsF1IsJTiaRKGC5EjjE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CGrLhzwItaxXLe7TpMpDCUARs6cyxd3M9bleebK3gVvS8AKiq8tAO96PzeCV96zI0nJay3gnQSFf+IRS+Fo1eo2J++rTzEM/wPnQ9w+H5txmXd2hSrAo1vDpNFNFeVY4eHEMkra8Se9FxNT6JwdfXe3zIbXhOiC4a/tLo3Zy7ZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-c45ff70000001609-c0-699ba00d57c1
Date: Mon, 23 Feb 2026 09:32:07 +0900
From: Byungchul Park <byungchul@sk.com>
To: Dirk Behme <dirk.behme@gmx.de>
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
	jlayton@kernel.org, dan.j.williams@intel.com, hch@infradead.org,
	djwong@kernel.org, dri-devel@lists.freedesktop.org,
	rodrigosiqueiramelo@gmail.com, melissa.srw@gmail.com,
	hamohammed.sa@gmail.com, harry.yoo@oracle.com,
	chris.p.wilson@intel.com, gwan-gyeong.mun@intel.com,
	max.byungchul.park@gmail.com, boqun.feng@gmail.com,
	longman@redhat.com, yunseong.kim@ericsson.com, ysk@kzalloc.com,
	yeoreum.yun@arm.com, netdev@vger.kernel.org,
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
Subject: Re: [PATCH v18 31/42] dept: assign unique dept_key to each distinct
 wait_for_completion() caller
Message-ID: <20260223003207.GA44876@system.software.com>
References: <20251205071855.72743-1-byungchul@sk.com>
 <20251205071855.72743-32-byungchul@sk.com>
 <ab0b9f9c-3a05-42f3-b4a7-ddb6ab0d37a4@gmx.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab0b9f9c-3a05-42f3-b4a7-ddb6ab0d37a4@gmx.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0yTZxTH87x3GupeOpFHmS6pQROm9RKTHZdlMSbL3i9zW/xgoonayCs0
	QMUWuXiJXGokRATqSmc7sUCoRGpEFKmZdR2deIG6drjRlRasqWjDEMZaHOG2dsTMLyf//P45
	v5wPhyNl3zGrOJW6UNSolXlyRkJJxpObNkotZtXmke7NEBgJ0/B7uZOCWLSKgnlzNwsjsSoE
	0ZkhFgzlCBYdvQh8nh9JsN0qJ+DvjgUGxlxTCAyhMAOR+19A2HkWwVjDJAOz7l9IMBo8CJpC
	QRKmIs8Q3OodRuBoq2DgRV0XCaahwzAQXgZPYxMMvO5gwFLhoOGSWY9g1O8goLLlOgMNlzop
	8I7NERBo0BPQ3vkl9NU1E2CMxLsbaWA2VhLx8YoAw7UfCJixXmWhvyVAgbUsA563mViYC22B
	YK2BgrFRPQPRpyECbOdGSXD4P4KLjQEG7joeUVA1H0XQa39OwLmOLhqGbYs0eJx9NPza7qGg
	r/chBUPuWhZaB70EhJ754m19Db0jS3hz5jwl2BptSIi2VpKC688JUtDdLBYc0xZKeNyMhXr3
	RuGOKcgKk3/tF3T3/Kxg6Twm6H4ep4WbbZlCy90IITRNxeivN+yVfJol5qmKRM2mzw5Kcu58
	62IKLiSXDOpyy1CFpBolcZjfhofdV5i32VVhZasRx1F8Bh7xZicww6/HPt8MmcDLeTnuCuxI
	YJJvX4MHxksS+X0+F9+/Pf+fRcoDbg5H6Gok4WS8HmGv6wKxVKTgRxfD1NJyJvYtRIiEk+TT
	8ZUFLoGT+E+wq/sMncip/FrsvP2ASHgw70/Cw9bL5NKZK/FPbT6qDvGmd7Smd7Sm/7UWRF5F
	MpW6KF+pytumyClVq0oUh47kd6L4v1pPze2zoynP7h7Ec0ieLHVOmFQyWlmkLc3vQZgj5cul
	s7NxJM1Slh4XNUcOaI7lidoelM5R8jTp1uniLBmfrSwUc0WxQNS8bQkuaVUZWjYPGfu3qxST
	A2tOptt1J/4QK92DT/pTTm21N77Sr17dX7ryn49TB2vKdiZ7wydSUrdfvjYaXEx7WH84c12s
	etG4W63Y89X3ZEvsvWlF64ZvWPPn8NsHsQ/vvTz7+ugh5LfXnD94XL5zz5NdaM649vSKuuzp
	dcag9k3BrrQDxfLC2hVySpuj3JJJarTKfwENi1eBqwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA02SbUxTZxTH8zzP7e1tQ821YLjo4ofqYmIibmaa4yRK9mHe7P0TOr+MRq5y
	VyimVQZOYyk065hZsK4ltMoQtVugvpXXznQjNOAcM7ZWRzPBalaRhiJMWhmtpWtjlvnl5H/+
	//M7OR8OQ5RJyWpG1B4WdFp1lYqWU/KPdjRuyutwiG8MTJeA2XQCJsIRCfzRMERBIm6m4MwV
	Fw1px4AUzO42Cfw6bqTAf7kbQThhRrCYchAweTIUpC2jUogv3ZeCtQFBxjuKwBawEAj5fyHg
	6m3AsHB1mYYZ3zME1kcRGlqjDRTMOU8isE85pBAd2Q2z4esSyEw+wTD+PIbAGVnGEBn6CkHa
	poHvO3uyuG2ehtSt2wRarX4E5x5NEngWfYigd/QBAu+PRhoet/QRsN8/AMHICribmKPhpvUb
	GmYDZzA8vUpDh9ErgcDvMwjOOiwIpv70Ymg8f4UG21k3BZ6HP0khMPMCw4TNgqHb/SGEnVMU
	jLV04uzJ2alrheBobcTZMo3Beuk6LnUiftH0LcV39fRj3nQnTfOudhfiU0kL4uMXGwlvasm2
	vtgc4Zt6vuAvjsVoPpm4R/Pe5x0U/1snx1/4Oon5U7c28R77pPSTd/bJSyqEKrFW0G3eWS6v
	9Hznow+dzqsbb9IYkFHejGQMx77F+YxOaTNiGIp9nQsHDuZsmt3AhUJLJGcXsCqub6I0ZxO2
	ey0XnK3L6XxWw430p+mcVrDAdUaikmYkZ5SsBXEB32n8MljJ3WyLUC/hjVxoOYpzOwm7hvth
	mcnZMvZtzjdgkuT0KnYdN9R/A7cghf0V2v4Kbf+f7kCkCxWI2tpqtVi1tVivqazXinXF+2uq
	3Sj7kc7jL04Nonhw9zBiGaTKU8wXOUSlRF2rr68eRhxDVAWKVMouKhUV6vqjgq7mM92RKkE/
	jNYwlKpQ8d4eoVzJHlQfFjSCcEjQ/ZdiRrbagPJJHDyfip/vCZTtcpfn9cnW73C1/82Qnr1d
	wS+Xap7mG8rOtZaGmv7SJsvmNYsFI0Xr321P/bz1yMKqf1zFK/C1bbEwGZx+PCiDxPumtfqg
	v7332F3PvnuGGydjbQuWiqLeO2Mf6Oq2vLaue0vKf+Dj6Inthl0lhRHz9kyGFWMqSl+pfnMj
	0enV/wJlLv3cjQMAAA==
X-CFilter-Loop: Reflected
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-77880-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[gmx.de];
	DMARC_NA(0.00)[sk.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,skhynix.com,linux-foundation.org,opensource.wdc.com,dilger.ca,redhat.com,infradead.org,kernel.org,linutronix.de,goodmis.org,joelfernandes.org,ffwll.ch,gmail.com,intel.com,mit.edu,fromorbit.com,linuxfoundation.org,lge.com,kvack.org,cmpxchg.org,linux.com,google.com,suse.cz,vflare.org,toxicpanda.com,lists.freedesktop.org,oracle.com,ericsson.com,kzalloc.com,arm.com,lwn.net,alien8.de,zytor.com,linaro.org,padovan.org,amd.com,arndb.de,suse.com,nvidia.com,joshtriplett.org,efficios.com,linux.dev,suse.de,brown.name,talpey.com,huawei.com,amazon.co.uk,linux.alibaba.com,glider.be,linux.intel.com,treblig.org,star-ark.net,valla.it,vivo.com,baidu.com,lists.infradead.org,lists.linaro.org,lists.linux.dev,qq.com,ownmail.net,sang-engineering.com,linux-m68k.org,garyguo.net,protonmail.com,umich.edu];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[byungchul@sk.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_GT_50(0.00)[166];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.915];
	TAGGED_RCPT(0.00)[linux-fsdevel,renesas];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,system.software.com:mid,sk.com:email]
X-Rspamd-Queue-Id: 8E78C17102F
X-Rspamd-Action: no action

On Sun, Feb 15, 2026 at 07:42:05AM +0100, Dirk Behme wrote:
> On 05.12.25 08:18, Byungchul Park wrote:
> > wait_for_completion() can be used at various points in the code and it's
> > very hard to distinguish wait_for_completion()s between different usages.
> > Using a single dept_key for all the wait_for_completion()s could trigger
> > false positive reports.
> >
> > Assign unique dept_key to each distinct wait_for_completion() caller to
> > avoid false positive reports.
> >
> > While at it, add a rust helper for wait_for_completion() to avoid build
> > errors.
> >
> > Signed-off-by: Byungchul Park <byungchul@sk.com>
> > ---
> >  include/linux/completion.h | 100 +++++++++++++++++++++++++++++++------
> >  kernel/sched/completion.c  |  60 +++++++++++-----------
> >  rust/helpers/completion.c  |   5 ++
> >  3 files changed, 120 insertions(+), 45 deletions(-)
> >
> ...
> > diff --git a/rust/helpers/completion.c b/rust/helpers/completion.c
> > index b2443262a2ae..5bae5e749def 100644
> > --- a/rust/helpers/completion.c
> > +++ b/rust/helpers/completion.c
> > @@ -6,3 +6,8 @@ void rust_helper_init_completion(struct completion *x)
> >  {
> >       init_completion(x);
> >  }
> > +
> > +void rust_helper_wait_for_completion(struct completion *x)
> 
> Please add `__rust_helper`:

I will.  Thanks.

	Byungchul
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/rust/helpers/completion.c?h=next-20260213&id=1c7a6f48f7eeb3014584d2fc55fc67f0cbaeef69
> 
> Best regards
> 
> Dirk

