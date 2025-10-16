Return-Path: <linux-fsdevel+bounces-64329-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id AD325BE11F1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Oct 2025 02:39:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 32000351498
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Oct 2025 00:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58E6319CD1B;
	Thu, 16 Oct 2025 00:39:18 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6284C433C4;
	Thu, 16 Oct 2025 00:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760575157; cv=none; b=icj4fO09EBWu+xWdZxEQY4+kmaH1iaic9sxTgRbw6oSDUIsHMJD9vmTLv12LtLTdNWGr9ddcyekGiT7uYWUUqSFJXvAARurjTGFpxf6SGoldGy9qmsl6SY+rdF8yP8/fVfhPHIXQwJRsZT9Hjg4kqbf4qRaJFbgJKEZM9KgblRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760575157; c=relaxed/simple;
	bh=dia0WiQqSMsA7QalQ+w75C/rhHhdK+gNykgAm5x1cK8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QljXfd+aqh5IBXcL8MKWKJLaTUYSJRqTFhNCKO/GapcHmA2TJU+nqd3tYfeZpmw5M1cfKFbJ5U5KnCJ92naCisVkM5rmxeXVhp0NxUwG0Y/qgFsj6/R7OkfXY6v8aHmDbd7Z/mukzZr/3WCCnxqFKfWxKTT09xNoMXRWfe8aREo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-c2dff70000001609-f4-68f03ea9c3af
Date: Thu, 16 Oct 2025 09:38:59 +0900
From: Byungchul Park <byungchul@sk.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, kernel_team@skhynix.com,
	torvalds@linux-foundation.org, damien.lemoal@opensource.wdc.com,
	linux-ide@vger.kernel.org, adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org, mingo@redhat.com, peterz@infradead.org,
	will@kernel.org, tglx@linutronix.de, rostedt@goodmis.org,
	joel@joelfernandes.org, sashal@kernel.org, daniel.vetter@ffwll.ch,
	duyuyang@gmail.com, johannes.berg@intel.com, tj@kernel.org,
	tytso@mit.edu, willy@infradead.org, david@fromorbit.com,
	amir73il@gmail.com, kernel-team@lge.com, linux-mm@kvack.org,
	akpm@linux-foundation.org, mhocko@kernel.org, minchan@kernel.org,
	hannes@cmpxchg.org, vdavydov.dev@gmail.com, sj@kernel.org,
	jglisse@redhat.com, dennis@kernel.org, cl@linux.com,
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
Subject: Re: [PATCH v17 01/47] llist: move llist_{head,node} definition to
 types.h
Message-ID: <20251016003859.GA2948@system.software.com>
References: <20251002081247.51255-1-byungchul@sk.com>
 <20251002081247.51255-2-byungchul@sk.com>
 <2025100230-grafted-alias-22a2@gregkh>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025100230-grafted-alias-22a2@gregkh>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa2yLYRiGvd95pXxqeG0RSc1pgjnFI2SzxI8vRBCHBBEa+2jpio4xIio7
	YGatis3ajG6zrdY6rA6xg6kxsi1O21Qta03STUZnNsx50VaEf1fu+36vvD8ejpQ10RGcSrNH
	1GoUajkjoSTdQwqnXYz9oIzxNYyDLz/MJNivHyGgpyQLganTzMKLfj8Cn/MogoLXHhKuP/Ai
	aPYNhdSiKwxUtFey0JZjJMDmWAavSjopaDQUEpDbxUBO+WgwP2qmwaM/Q8Hl7ic01HtdNDhe
	1iGovl1PwVNnIw1X3rgJeFJ5iQa3oQPB6fedCKy9uTQ8sIwCY2cfCzfupCNoy35LQcvLKgQ1
	x9oJKLZ2B0x2FwP3PvsJaPB8ZMFlPM9AX/4ADelZ31iwPaPgRHoOBVd7SxlIa5sLl365EJjr
	vOyiGMF+zo6ET8WppHDP30MK3z8/Z4Tb/RZKaCjEQoXJwwppNa2sYHHsFa5ZowVH2XFGyOxu
	IYQ2VzUj+FpyCeFc/UrhTr6dXRG5XrIwQVSrkkXtjNjNEqWlVcfu8tL79UYzrUMVVCYK4zA/
	B3dkn2b+clHqRTLIFD8Bp2boQhuGn4Td7m+hPJyfjLvqWgO5hCN5cyS2PcoLFSP41dhlKws9
	kPLz8OPSAjo4kvGZCDtNVcSfYjiuz/OFRiQfjd0DXYGcC3AkLh3ggnEYPxufyslGQR7Jj8fO
	mw+JoAfz3jDsz80g/vx0DL5rdVMGxJv+05r+05r+aS2ILEMylSY5UaFSz5muTNGo9k/fsjPR
	gQKXVnLo54ZbqO/pqlrEc0g+RNpu7VHKaEVyUkpiLcIcKQ+XzjvoV8qkCYqUA6J25ybtXrWY
	VIsiOUo+Wjqrf1+CjN+m2CPuEMVdovZvS3BhETq0fGONfuvZMrckrXZahYczlBPv1iY3Zsw8
	+i5q/ti43cPyhp+J6j2p+bomfE1Bx1JD/LhtRT+b3xxu2q72ZiSaIx5OirLpR8UNaikuaR0c
	3ySZOPGac/HjIiNTPjU6PivWa1hSs/vXgYNALUALLujXjai8cXxujN5x3/uxw+SbootbLaeS
	lIqZ0aQ2SfEbtLR/WGUDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0yTdxTG83/vNOv22mH4h/rFGrNNI5u76HFuxsRs/OfE7MO8hJhIM9/Y
	BiikVYSZJYXaSdwi0KQltDILxNJRLAjqZKRLU0cdMgTEMUQuYjqxyGVBkCBQ9tJlmV9OnvN7
	nic5H45Aq2JssqA3nJCMBm2WhlMwiv07LVu8u/7WvdMd2gF9hUEG5maLGbjQUM9BcVMFC91+
	H4KRuWIE84suGqwtKwws28I8zC484GElEEbg6LHRUH+1kIJnjTEOnt6cQWAfjXBQHi1kYNrz
	PQLnYxcP0bZUmBxpZWFlaIyCP59PIPBEYhREgmcRLDsy4WJ1MweLnV00lNu7EVSNDtHwpFE2
	r4aHEQS8RRz8VXqNht7Iq3BvbpqDdvt3HEz2XKBgqpEDd1GAhUqXDYGlpoEDR2UTAy0Pf+ah
	5+kSBYMOGwW+pjQY8TxmoKO0mpLvk1NXksBVbqHk8YQC++VWChY8dTz8XjPIgMe8EVydvSw8
	8jp5WBrdCivuHAj7xngYKrEz4J/sYnfbEZm3nmdIXfN1iljvLnOk/od6RBZf2BCZvWShibVU
	Xm9OTNPkTPMpcqljgiMv5v7gSOC5myG3qzEp69xCWpxDPDnzywD/xYfpio+OSVn6PMn49q4M
	hc49YOZzh9n8EpuLNaMW5hxKELD4Pq6x/EivakbciC3fmuOcE9/A/f0LcZ4ovomjbQMyVwi0
	6FJjX2dF3Hhd/BL3+eriBaW4Hd+prWJXQyrxHMJBZyv1r7EGt1dE4iFa3IT7Y1GZC7JW49qY
	sIoTxPdwmeM8WtVrxQ04eP0WVYqUzpfazpfazv/bbkTXoUS9IS9bq8/6IMWUqSsw6PNTvsrJ
	bkLyV3q+WSq7gWZ7U0NIFJDmFeVD77ROxWrzTAXZIYQFWpOo3H56QqdSHtMWfC0Zc44aT2ZJ
	phBSC4wmSbn3kJShEo9rT0iZkpQrGf9zKSEh2Yz06o/Hwj/51207mHnfMv+o274vLRb9laf2
	7ymaPCvORAwzpGHzYTKcf6Rkj/ezULqQdHzntoB1fPzaukLz6Q2nbiWH1+B7qbql4N72T9M7
	mIuN+wY/ea3iLf/l6s/X51ahyh333x2/O9U19ez2oQN9bWWalLTh3Rm1M+vV/qTfYodvaBiT
	Trt1E200af8BW/SRTpEDAAA=
X-CFilter-Loop: Reflected

On Thu, Oct 02, 2025 at 10:24:41AM +0200, Greg KH wrote:
> On Thu, Oct 02, 2025 at 05:12:01PM +0900, Byungchul Park wrote:
> > llist_head and llist_node can be used by some other header files.  For
> > example, dept for tracking dependencies uses llist in its header.  To
> > avoid header dependency, move them to types.h.
> 
> If you need llist in your code, then include llist.h.  Don't force all

Eventually, I found out another way to avoid the dependency issue.
Thanks anyway for the feedback.

	Byungchul

> types.h users to do so as there is not a dependency in types.h for
> llist.h.
> 
> This patch shouldn't be needed as you are hiding "header dependency" for
> other files.
> 
> thanks,
> 
> greg k-h

