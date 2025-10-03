Return-Path: <linux-fsdevel+bounces-63335-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 54D1ABB5C40
	for <lists+linux-fsdevel@lfdr.de>; Fri, 03 Oct 2025 03:47:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2F8DA4E93BD
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Oct 2025 01:47:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFF1D285CBB;
	Fri,  3 Oct 2025 01:46:57 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E75B182B7;
	Fri,  3 Oct 2025 01:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759456017; cv=none; b=MR3J673XbVAQkNZJtDZHGx6Ohh9gxjtpoBSMnlD+to7ZASY1Lsn4lLgK4kRl5AzDdFaDU4GscO4PGvMF/MuqF1pZmZSh7U+oASAZupYInYOnpFOZ6txDyalXQ7Yrm0JQ5rNg6hEnMLZWGHxhlnSUuGRegiAK7s92HO6gRI6Xj5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759456017; c=relaxed/simple;
	bh=qSeKLacpwTszi2nIGhZR51FDuj9AbbAKRr2JI/VVMs8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XK0nKxHtP2+nS+dv0AOFpkRCimLKyvUu8zk4VlDBnvhmKxP18P+wSDVNmngbMvc14PS5YznjrDb1NsnB/GhXR01IFvVdoLBQnAvha61+jebOjnvSdc3MWfW3jaKRxJXEmWk9AvgZ0V8Z0nVz71Q6irgXZx5JRaWDVBORGeWUOKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-c2dff70000001609-83-68df2b06f003
Date: Fri, 3 Oct 2025 10:46:41 +0900
From: Byungchul Park <byungchul@sk.com>
To: Mark Brown <broonie@kernel.org>
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
	kevin.brodsky@arm.com, dwmw@amazon.co.uk, shakeel.butt@linux.dev,
	ast@kernel.org, ziy@nvidia.com, yuzhao@google.com,
	baolin.wang@linux.alibaba.com, usamaarif642@gmail.com,
	joel.granados@kernel.org, richard.weiyang@gmail.com,
	geert+renesas@glider.be, tim.c.chen@linux.intel.com,
	linux@treblig.org, alexander.shishkin@linux.intel.com,
	lillian@star-ark.net, chenhuacai@kernel.org, francesco@valla.it,
	guoweikang.kernel@gmail.com, link@vivo.com, jpoimboe@kernel.org,
	masahiroy@kernel.org, brauner@kernel.org,
	thomas.weissschuh@linutronix.de, oleg@redhat.com, mjguzik@gmail.com,
	andrii@kernel.org, wangfushuai@baidu.com, linux-doc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
	linaro-mm-sig@lists.linaro.org, linux-i2c@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-modules@vger.kernel.org,
	rcu@vger.kernel.org, linux-nfs@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH v17 09/47] arm64, dept: add support
 CONFIG_ARCH_HAS_DEPT_SUPPORT to arm64
Message-ID: <20251003014641.GF75385@system.software.com>
References: <20251002081247.51255-1-byungchul@sk.com>
 <20251002081247.51255-10-byungchul@sk.com>
 <a7f41101-d80a-4cee-ada5-9c591321b1d7@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a7f41101-d80a-4cee-ada5-9c591321b1d7@sirena.org.uk>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0yTZxTH97zv817orHlXJbxqlrjiosHJ5qLJMXFkt4QnWVyW+EXdB63w
	Zm3klhZBNpd1CFjdjTQrhorKRWrlqjQyqYLIpNp0pEUE6iytmKIQ6EiwxSCFriUz89vvec4/
	v3Nycnha0cCu5zV5hZI2T5WjZGVYFlpVv43bGlB/MP9QgJEfezFEwgYMNe0tLBg6qhnwtDUj
	CEQMCMq7YhiWjA4OwguPOIh1OxBUDRppeH5lmYXpP+cQmMaDLEz1Z0IocIOB2NgzCkbnZxBY
	gssUBHtPIrhQb2NhccBNwxmTB0G3tZSFicprNAwFV8ODyCwLocEaCk40tLPQ9djOweB0lAJf
	lZGCgOUpBldlPQVVV1Pg7JlJCkytNyhYsDRxYNG/C2cHhhh4YjVzEB3fDrHafBj7zYShLeRm
	wOkfYWD6qZGFwN0KBv7QP+ag42E/AoM9gqGu4iKG6vM+Fm52OzEYlsIIhuw1LPx85RoD/pZY
	fA+9LgbuN3swtD/zUuBy3MPgNF/G4La3Mh9nkxflv2LSZOukSPn9JZa0nG9BZPGlEZFw4wma
	lFfGn2W2YtLommFJl3mMI2U9f3OktuMoKbsTYojNmkYabk5RpG4uwny19YBsd7aUoymStO9n
	HJKpB0sXuYK/ZMc8pllKj/7hTqMkXhR2iFOdF/Ar9lkn2QRjYZNom3CtMCtsFr3eBTrBa4VU
	cfhFdzwv42mhboN4KdTOJAprhINi9PID6jTiebkAYvi6JpFRCNVI7Pm9b6WBXHhLdFYHV5gW
	0kTv8tRKnhbinmU+8Z0kfCL6f/JRCU6O9+rtvEslPKLgTxJne279N+g68bbViyuRYH5Na35N
	a/5fW4voJqTQ5BXlqjQ5O9LVJXmaY+lZ+bkdKH66lu+jX19Hc569fUjgkXKVnBT41QpGVaQr
	ye1DIk8r18oPWX1qhTxbVfKtpM0/qD2aI+n60AYeK1PkH84XZyuEb1SF0hFJKpC0r6oUn7Re
	j3Y23J4s+GzXGxdF99XCbaltEuKUpZG3R79w7M0cneh/s3n/e+mNWePpu6oOM1mtHL9xZM+X
	Qf/xT4ePfOfO/Gj/mmKdfUtyVtE9b/QH5Ray+tG+VM+5U0OgfL5Yu2dGMezM3DT5zpOBDDxH
	bfyl4pRt5M5s8uexc4zjVnNPaUaKvkSJdWrV9jRaq1P9C2cgzuy2AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA02SbUxTZxTH8zz3lWZ3u1aIN+CyrZOYQVCILjm+ZNmyZNwsmWHJ1MQPkwav
	trwU0moHJou82NigbrWjEFp1FWNF6KADIVRTJKgQRIQKKpFCwVSEyMsyCwRLYS2JmV9Ofuf5
	///nOR8OS8jDVDyr1hyXtBplroKWkbJ9e8pS6GS/KrXFmAhPSzpIWAgaSbjY6KTB2FRNwUBD
	PQL/ghHBUshGgMG9RkLY3MVAcHmEgTVPF4JKr5kA580SDG9cqzS8vvsvAstEgIaq6RIS5h3n
	EFgnbQxM30+HWf9tCtZGX2F4tjiDwBFYxRDoOIMgXJkDf9Y00xDq6yegyjKA4MrEKAFTroh4
	s2sMgae2lIaXphYCBgMfwtDCPA09lrM0zHovYphz0WAv9VBwyWZGUHa1kYbKS00kuMdvMeB9
	vYLBV2nGUN/0A/gdkyT0mmpwZL+I6+9NYKsqw5EyhcHy120My446Bh5e9ZHgKE4EW98gBS9q
	rQysTKTBmj0fuupfMTD6u4WEhtl+6msLEpcMv5FiXXMrFg2Pw7TovOxEYuitGYnBa2WEaDBF
	2rsz84R4uvkX8VrvDC2+XXhCi55FOyk+qBHEC30pots6yoin258zGbsPyfYekXLVekm7/atM
	mcpbGmIKHsoKByzzuBjNMeUohhX4nYKvdoqOMslvEZpf9q4zzW8VhoeXiSjH8p8LT5Y8ZDmS
	sQR/JUG4PttIRYWN/GFh5cYQLkcsy/EgBNvUUY+cr0ZCe0UnGfVw/AahpzqwzgSfJAyvTq/7
	CT4yZ5WNPsfw3whjZ304ynGRvzpau7EJcdb30tb30tb/03ZE1KFYtUafp1TnfrlNl6Mq0qgL
	t2Xl5zWhyFE6fl250IaCg+mdiGeR4gNOLBhTySmlXleU14kEllDEcpm1PpWcO6IsOilp8w9r
	T+RKuk6UwJKKTdz3B6VMOX9MeVzKkaQCSftOxWxMfDFqeZBR6jB+tHmLr15+NEt/p8HlDtt/
	SjgkFQZZf9a32VW70j499dgg9CyW/xg+9kf+uYz9Ns62nNJgfBTXbmoVXPFtk4/G732h43I8
	3rRPKkq2nk8t1uMDId+I0zxEfZcdY01N/vmf4ObCz3xSardbM3C+JVG93ZQxt+tj247LhILU
	qZRpSYRWp/wPOciOgZADAAA=
X-CFilter-Loop: Reflected

On Thu, Oct 02, 2025 at 12:39:31PM +0100, Mark Brown wrote:
> On Thu, Oct 02, 2025 at 05:12:09PM +0900, Byungchul Park wrote:
> > dept needs to notice every entrance from user to kernel mode to treat
> > every kernel context independently when tracking wait-event dependencies.
> > Roughly, system call and user oriented fault are the cases.
> > 
> > Make dept aware of the entrances of arm64 and add support
> > CONFIG_ARCH_HAS_DEPT_SUPPORT to arm64.
> 
> The description of what needs to be tracked probably needs some
> tightening up here, it's not clear to me for example why exceptions for
> mops or the vector extensions aren't included here, or what the
> distinction is with error faults like BTI or GCS not being tracked?

Thanks for the feedback but I'm afraid I don't get you.  Can you explain
in more detail with example?

JFYI, pairs of wait and its event need to be tracked to see if each
event can be prevented from being reachable by other waits like:

   context X				context Y

   lock L
   ...
   initiate event A context		start toward event A
   ...					...
   wait A // wait for event A and	lock L // wait for unlock L and
          // prevent unlock L		       // prevent event A
   ...					...
   unlock L				unlock L
					...
					event A

I meant things like this need to be tracked.

	Byungchul

