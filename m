Return-Path: <linux-fsdevel+bounces-49087-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 34054AB7BE6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 05:01:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE3464A8125
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 03:01:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AB15290BA6;
	Thu, 15 May 2025 03:01:06 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4214269839;
	Thu, 15 May 2025 03:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747278065; cv=none; b=qysVOStKTHSd++IrEh3agHO50lgqtySNTLpZKzwP2CsTNcYlgWjq94MZdEosVIsYuB1hPY+P9v9fws2XkNwTSohzYjCWDHFaND9SI7kmEbQGPhhCy0DnqoIh03OWWYgm0fq30Qpr89cMjzlD36LFQodsgrrx+htTY3/RPyPzfhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747278065; c=relaxed/simple;
	bh=WMtRPrTV5SKlwbqCnRpNmAVaeiJHq6e0YXcmEs9v6gM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G5+cYgcxXXErKDNGnhfk9x8wV2DkGb4fyMG3kQwoqieu594EjJ794xtGQEOfPmZELRNtoEnzb9sSA0EkzAULgEpaQnfL3CdVrdQrdnPmsrcq2wt0UeAwd9rzcc49acTCUhIM3TvY/JN8soeT9lw64NDAPDRhvnDiqp1cTXusNhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-13-682558e73367
Date: Thu, 15 May 2025 12:00:50 +0900
From: Byungchul Park <byungchul@sk.com>
To: Waiman Long <llong@redhat.com>
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
	yskelg@gmail.com, yunseong.kim@ericsson.com, yeoreum.yun@arm.com,
	netdev@vger.kernel.org, matthew.brost@intel.com,
	her0gyugyu@gmail.com
Subject: Re: [PATCH v15 01/43] llist: move llist_{head,node} definition to
 types.h
Message-ID: <20250515030050.GB1851@system.software.com>
References: <20250513100730.12664-1-byungchul@sk.com>
 <20250513100730.12664-2-byungchul@sk.com>
 <5f412ff9-c6a3-4eb1-9c02-44d7c493327d@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5f412ff9-c6a3-4eb1-9c02-44d7c493327d@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA02SbUxTVxjHd+69vfe2WnYtOo+w+aHCZnBzQnA8SzZDsmU7ydhm4kwWt0SL
	XNe6Aq68CM4l5TUKkyBbYRQmtWyVYFUsxlQFZBhqOh1WCxUdoDI0QHlf2w0FXCkx88uTX57/
	//zO+XB4WlHGRvCatExRl6bSKlkZIxtfbn5j+PNo9aaH5RLw+w4xUHvGyoLr9EkE1nN5FIx0
	fgi3A2MInvxxg4YqgwvB8Qf9NJxzDCBobchnwT0UBt3+SRachlIWCurPsHDTO0dBX2UFBSdt
	H8M9yyMGrpWbKagaYaGmqoAKjmEKZi2NHFj00TDYYORg7kEsOAc8Emi9uwGqj/Wx0NLqZMBh
	H6TAfbGWhQHrUwl4S6ZoCJRFguvoEQmcmjCz4A1YaLD4Jzm41W6iwGF6CZoKg8LivxckcPVI
	OwXFv5yloPvOJQRth+5TYLN6WLjiH6Og2Wag4fGJTgSDZeMcFH0/y0FNXhmC0qJKBgr7NsOT
	f4M3/+yLhby6JgZOzXtQ4rvEesyKyJWxSZoUNu8nj/09LGkNmBjyuxmTC8Z+jhS23eWIyZZF
	mhtiSH3LCEWOz/glxNZ4mCW2mQqOlIx3U2Siq4vb+vIO2TspolaTLere3LJLpm50VDD7fg3L
	6fT10HpUs6wESXksxGP9+I/cMz5a5ZYsMiNE474KO73IrPAa7u2dDfFKQYn9sy6mBMl4Wqhc
	hi84pqnFIFz4DI9N94dEciEBm53uUEkhGBAuzR9lloIV2Fk9FGJaiMG9CyPBw3yQI/GJBX5x
	LRW24LbAvVBllbAOt5+/Si09ziPF1Y6DS7wG/9bQy5Qjwfic1fic1fi/1YToRqTQpGWnqjTa
	+I3q3DRNzsbd6ak2FPyllu/mvrCjGde2DiTwSLlc3l4UpVZIVNkZuakdCPO0cqX89t51aoU8
	RZV7QNSl79RlacWMDhTJM8rV8rjA/hSF8JUqU/xaFPeJumcpxUsj9EgkOZ9OuV9Izg9cb1o9
	H/uR95/3kwt++ivrh2tR2ydHrdtPh492vBr39sSu9w4nXg//oL9+TVwX3jN/48/zL+qmkg0p
	tZsuZ3ter9PefMuZ7ttb882X9rUJO3w9ez5Zsap4fdh0XkTCxcGknYneAweTpVGZzLf37S1J
	w3rV5qd1Q91rI+JfUTIZalVsDK3LUP0HPfruQ6EDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA02SbUxTZxTH8zz3tZWau47pjY1+qMMXFlFU4llc0CVm3Cxz0czERU1moze2
	k1ZtEekUB1KMg0mEBYhFsZZZCJThilNQSwhIsahYLSIqoBAyh60CjttZYbCWZZlfTn45//M7
	58thCeUYNY/VGdJEo0GTqqblpPzLtTnLnn8dp11x5dxikMZPkHCmzkmD75caBM5L2RiG21Lg
	YSiIYOLOXQJKi30Izg/0EXDJ04/AXXWMBv/QbOiSRmjwFufTkFNRR8O9wCSG3pIiDDWujfDU
	8TsJt07ZMZQO01BWmoMj5Q8MYUc1A46sOBissjIwOZAI3v5uClrPeilwP/4ITpf30nDd7SXB
	0zCIwX/1DA39zmkKAnmjBIQKVOArPElB7Ss7DYGQgwCHNMLA/WYbBo9tDly0RLYe/3OKgvaT
	zRiO//wrhq5H1xA0nXiGweXspqFVCmKodxUT8LayDcFgwUsGcn8MM1CWXYAgP7eEBEtvEky8
	iVw+O54I2ecuklD7dzdanyw4y51IaA2OEIKl/pDwVnpAC+6QjRQ67LzQaO1jBEvTY0awuQ4K
	9VXxQsX1YSycfy1Rgqv6B1pwvS5ihLyXXVh41dnJbJq/Tf7JbjFVly4alyfvlGurPUXk/guz
	M9rGHxBZqGxWHpKxPLeaLyz1U1EmuTi+t6iBiDLNLeZ7esIzHMupeSnsI/OQnCW4kll8o2cM
	R4P3uS18cKyPibKCW8Pbvf6ZISVXjPj8Yy/If4P3eO/poRkmuHi+Z2o4IrMRVvGVU2y0LeOS
	+abQ05mRD7iFfPPldnwKKazv2NZ3bOv/tg0R1ShWZ0jXa3SpSQmmvVqzQZeRsGuf3oUij+jI
	nCxsQOP+lBbEsUgdo2jO/VCrpDTpJrO+BfEsoY5VPPx2oVap2K0xfyca931jPJgqmlqQiiXV
	cxWfbxV3Krk9mjRxryjuF43/pZiVzctCGQ5WVT+Qu6UirSCY5V4w+mR95tYL4dCiUN9vgcwb
	n/o87WMbhj6eeF65Y/rQEfFNjP3A6Lru0a7bc/LL//rKeXWHbEVj50+fLf3+cswG87Tqi5WG
	joHDSVZ9x2CK8eaqmtrtCds23lh5WMJlC1TBJUH9UUtd+sRmySzLsQZxYEndajVp0moS4wmj
	SfMPr7iiAoQDAAA=
X-CFilter-Loop: Reflected

On Wed, May 14, 2025 at 08:14:26PM -0400, Waiman Long wrote:
> On 5/13/25 6:06 AM, Byungchul Park wrote:
> > llist_head and llist_node can be used by very primitives. For example,
> 
> I suppose you mean "every primitives". Right? However, the term "primitive"
> may sound strange. Maybe just saying that it is used by some other header
> files.

Thank you.  I will apply it.

	Byungchul
> 
> Cheers,
> Longman
> 
> > dept for tracking dependencies uses llist in its header. To avoid header
> > dependency, move those to types.h.
> > 
> > Signed-off-by: Byungchul Park <byungchul@sk.com>
> > ---
> >   include/linux/llist.h | 8 --------
> >   include/linux/types.h | 8 ++++++++
> >   2 files changed, 8 insertions(+), 8 deletions(-)
> > 
> > diff --git a/include/linux/llist.h b/include/linux/llist.h
> > index 2c982ff7475a..3ac071857612 100644
> > --- a/include/linux/llist.h
> > +++ b/include/linux/llist.h
> > @@ -53,14 +53,6 @@
> >   #include <linux/stddef.h>
> >   #include <linux/types.h>
> > -struct llist_head {
> > -	struct llist_node *first;
> > -};
> > -
> > -struct llist_node {
> > -	struct llist_node *next;
> > -};
> > -
> >   #define LLIST_HEAD_INIT(name)	{ NULL }
> >   #define LLIST_HEAD(name)	struct llist_head name = LLIST_HEAD_INIT(name)
> > diff --git a/include/linux/types.h b/include/linux/types.h
> > index 49b79c8bb1a9..c727cc2249e8 100644
> > --- a/include/linux/types.h
> > +++ b/include/linux/types.h
> > @@ -204,6 +204,14 @@ struct hlist_node {
> >   	struct hlist_node *next, **pprev;
> >   };
> > +struct llist_head {
> > +	struct llist_node *first;
> > +};
> > +
> > +struct llist_node {
> > +	struct llist_node *next;
> > +};
> > +
> >   struct ustat {
> >   	__kernel_daddr_t	f_tfree;
> >   #ifdef CONFIG_ARCH_32BIT_USTAT_F_TINODE
> 

