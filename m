Return-Path: <linux-fsdevel+bounces-63907-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F35C2BD174F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 07:27:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6266C1897378
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 05:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60F472D24B5;
	Mon, 13 Oct 2025 05:27:35 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69D322D12F3;
	Mon, 13 Oct 2025 05:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760333254; cv=none; b=ipYCUmYbOI87Q5gWA5fXtd8GlDagmNqhOO5Cz5rY+ddUkb4+nC5+28B8AMuItzZ5yzMUkIMkknjULjIQkhrhX13qB7Mnog8L0tFKcY35OZGtPWIvNjD/JGwC+r7pEqltaRA8vZlD7+K3MBETtVvCAX2FStiW1iyl3Cb/Xj0Itfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760333254; c=relaxed/simple;
	bh=ndYgSHNbLnvyYLEcoIN3mUPNVlCWqqRkCrrregrceHU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QSoCN5bu9Q9sohdNSGFeRMpqBGlJiJVL6aVKZJoaEvwc3hXiPfIai9/91MgkZnQRIqoxIz+7h0L8GetNG0V5tu2LiycvOHOAbdaA3Nb5l3IMzQ3amatlSmRjys69o4+kexIt307PFQy894gO9cQWrAfyKthENAyGSBQDODI0LZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-c2dff70000001609-4e-68ec8dc17dc6
Date: Mon, 13 Oct 2025 14:27:24 +0900
From: Byungchul Park <byungchul@sk.com>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
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
	catalin.marinas@arm.com, bp@alien8.de, dave.hansen@linux.intel.com,
	x86@kernel.org, hpa@zytor.com, luto@kernel.org,
	sumit.semwal@linaro.org, gustavo@padovan.org,
	christian.koenig@amd.com, andi.shyti@kernel.org, arnd@arndb.de,
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com,
	rppt@kernel.org, surenb@google.com, mcgrof@kernel.org,
	petr.pavlu@suse.com, da.gomez@kernel.org, samitolvanen@google.com,
	paulmck@kernel.org, frederic@kernel.org, neeraj.upadhyay@kernel.org,
	joelagnelf@nvidia.com, josh@joshtriplett.org, urezki@gmail.com,
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
	linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH v17 35/47] i2c: rename wait_for_completion callback to
 wait_for_completion_cb
Message-ID: <20251013052724.GA9169@system.software.com>
References: <20251002081247.51255-1-byungchul@sk.com>
 <20251002081247.51255-36-byungchul@sk.com>
 <aOFNz2mKXCXUImwO@shikoro>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aOFNz2mKXCXUImwO@shikoro>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0xTdxjG8z93KiVnHYsHSObSjS3CdDcy3uxC2BLnyZLFLVuMww+usWc7
	DZeSokzmHIVOIE4d69KqLWq5FYQKtWUIYpNSR5UhsbVOu621EgpK1obEgJsXYD0sy/z2y/s+
	z/M+H14GV7RQ2YymYpegq1CVKSkZIUumt23wHUqILxvd6+B6nZeAln4HBYG+XgSxxSYES0Y/
	DSsePwJz0IiDY6AOA9NUnIJ5+0EEllkrDXNjmyEZGyFhJXobA3t8GYO4tzFlNZfCyTY3BQ8n
	r+BwxBRA0DoVxeGOM7Uc8N9E4Omup2Cm+SccQvEMGDd9R0Ey2IKBrd5DwnGrEYGhvZ8C83EX
	AcO3ztEQMRsx6HV9AOYza8F6xJDqcnoEg/v2Hhout0cIsOtzwToZSnWxacHfe5uG6PcmAvqS
	V0iIXWwg4az+Fg2u38YQLFybwsBxcBaHpnOLBHh+z4fWhg4Cjp2IUHDeM05A09ICAr31LxIC
	3gkSJvyXCBi3nCKg80YQA/fkZRzCzTOoWM33uAcxfv/VJYp3nHAg/uEDI+IXOg04fyExj/Od
	EwmKf7D4K8V77tkI/pc2jv9hcgM/bInSvM21m3d35/Ht5+cwvvXuIvlhfonsLbVQpqkWdC8V
	fSYTTV25lQlqT0ekhdajYfIASmM4toDTt4ZSzKxy/dUsaUywuVyj14kkptgXuHD4Pi5xJvsa
	5zBY6QNIxuDs2RwuODCNS94n2Z1c/7fPSShnC7lLoU2SXMHWcvM+26pVzj7BjR+LExLjbB4X
	Xp7DJDnO5nBdy4w0TktdejRzeLXYU+yznHfwIiZd4tibadyNyDT1b+MsbrQ7TDQj1vJYrOWx
	WMv/sTaE9yCFpqK6XKUpK9go1lRo9mzcqS13odTP2vc92j6E7gY+9iGWQcp0uTjyp6ggVdVV
	NeU+xDG4MlNeuDchKuRqVc1Xgk67Q7e7TKjyoRyGUK6Vv3rvS7WC/UK1SygVhEpB998WY9Ky
	9ah4bN03/cqC9w4XfRrrQxf+2LTlZM9pcfro0WtDSFQF3in+eqU5GXt9c3Ar8ebTzzjmMobw
	bV2fvLumoQTedv64Xxtqn21M3/bGmp8/qswYfT7TIA58vtdZV7tefNHaa3j/1J2/neFDwSxd
	4ai6dCsDWktUN7WvdLAjv+S6o7YoG6xKokpUvZKH66pU/wDSCxH1rwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA02SbUxTZxTH89znvtGs89JBeJTsS5FoNKAGDWdDDXGZ3G3ZwjeWfZmd3tgG
	KNpKJy7bgFJguDmoaYktzgpaGK3Q8aIWU9ZhYAISBWQjG8iYRSWWNZmgqbytd8kyv5z8zjn/
	X87z4eGxKsps4nX6E5JBrylQswpa8UGWOe2nb8Lanb7O7fBLWZCGpcVqGhravSxUd5xj4G6b
	B8HMUjWC58tODBb/Og2r1gEOFqO/c7AeGEBgH7Vi8HaVUfDUt8bCk5t/I7DNhliony+jIeL+
	GoHjoZOD+f4cWJi5wcD69CMKfn0WRuAOrVEQClYhWLXnw4XGThaWR+5gqLfdRXBxdhrDY19s
	2TVwH0GgpZyFudpuDOOhV+HeUoSFQdtpFhZGGyj4y8eCqzzAwHmnFYG5qZ0F+/kOGvx/9HAw
	+mSFgim7lQJPx/sw435Iw3BtIxV7Xyz1QxI4681UrDymwHblBgVRdysHt5umaHCXpoJzZJyB
	P1scHKzM7oJ1VxEMeB5xMP2tjYa2hTtMth2Jzy1naLG18yolWsZWWdH7nReJyy+sSFy8bMai
	pTbW3gxHsFjR+al4eTjMii+WJlgx8MxFi0ONRKwbSRP9jmlOrOj9jcvN+kix94hUoDNJhh37
	Dym0tubUY2H25KWpBq4U+ZkaxPNE2E3KxzbWoDieFlJJVdCHZGaFLWRyMoplThAyiNfs5GqQ
	gsfCtWQy2vUAy+5rwmHSXrFZRqWQSW6Nvy3HVcKXJNLn+ldVCvFk8FyIlhkL28jk2jwlx7GQ
	TJrXeHkcF7u0MneGkTlRSCHBqz9TtUjpeMl2vGQ7/rddCLeiBJ3eVKjRFexJN+ZrS/S6k+mH
	iwo7UOxDuj9fqbuOFsdz+pDAI/UrytyqsFbFaEzGksI+RHisTlBmfhYbKY9oSk5JhqKPDcUF
	krEPJfO0Okn5bp50SCUc1ZyQ8iXpmGT4b0vxcZtKkSQMx4ey2lN+zNqcGRlqPb0n+72pW/2J
	xWQuafmTia3piYO2poPJxyubo13dljfeDGrKh/QT+9LrXw9kzHyP83pRWPB9mLHwjidt0BPd
	kNvWk6ItrlN9sXMj17/Bn5BUme09W7y1J4dqOdv9YP9YnektYpltO8D64xsOMr2myq/UtFGr
	2bUNG4yafwCIKJ+/jAMAAA==
X-CFilter-Loop: Reflected

On Sat, Oct 04, 2025 at 06:39:43PM +0200, Wolfram Sang wrote:
> On Thu, Oct 02, 2025 at 05:12:35PM +0900, Byungchul Park wrote:
> > Functionally no change.  This patch is a preparation for DEPT(DEPendency
> > Tracker) to track dependencies related to a scheduler API,
> > wait_for_completion().
> >
> > Unfortunately, struct i2c_algo_pca_data has a callback member named
> > wait_for_completion, that is the same as the scheduler API, which makes
> > it hard to change the scheduler API to a macro form because of the
> > ambiguity.
> >
> > Add a postfix _cb to the callback member to remove the ambiguity.
> >
> > Signed-off-by: Byungchul Park <byungchul@sk.com>
> 
> This patch seems reasonable in any case. I'll pick it, so you have one
> dependency less. Good luck with the series!

Thanks, Wolfram Sang!

	Byungchul

> Applied to for-next, thanks!

