Return-Path: <linux-fsdevel+bounces-63866-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B966ABD1145
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 03:19:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 793F74E9A43
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 01:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9F732163B2;
	Mon, 13 Oct 2025 01:18:53 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EE9712B94;
	Mon, 13 Oct 2025 01:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760318333; cv=none; b=bDM7T0hEccmgRdyWp8O0X0wVXZ+srvqFz/39G/Vc0y819R+SbGGjha40i8nSDSK5KNtXs7NDadPqVsmLa84w0LuRN8W2YdiWW//XtBLa2RKTfr1lw6JtAbkIaB8CkPFrr8PfZcM3mX055AJPEYcjbq1kmDDjgZ+xX9RXvD8MlYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760318333; c=relaxed/simple;
	bh=NiasNDnL7bI+RWAs1WgZxXifIHYVm8cB4osG/bTqMcU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QOIjkf/VpiYM60gfY8pp/Hjy6++5r5wMDYR3MEnfLMzR+aEBylmAG0LNN9Odhm29N3+onVQcHBSrLSumAy+hmIujg32cYJHz9KqdiPRSVs8Ur6dW1/ik9Tc4NmgH7nnhMv8tP1qANSz80oZYQLmF+xzdv5VEfgvl3N/hroRi5gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-c2dff70000001609-68-68ec4fde8eb0
Date: Mon, 13 Oct 2025 10:03:21 +0900
From: Byungchul Park <byungchul@sk.com>
To: Jonathan Corbet <corbet@lwn.net>
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
	matthew.brost@intel.com, her0gyugyu@gmail.com,
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
Subject: Re: [PATCH v17 28/47] dept: add documentation for dept
Message-ID: <20251013010321.GA52546@system.software.com>
References: <20251002081247.51255-1-byungchul@sk.com>
 <20251002081247.51255-29-byungchul@sk.com>
 <87ldlssg1b.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ldlssg1b.fsf@trenco.lwn.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0xTdxTH87v3d29vG2uuFcNvkCVbnTE04mMx5vyxqJuJuYQsumG2ZGbZ
	bqRZq7zWymvJljIKQzRbdQFCAWlRK0IR1iIoDoM0Y3alSmVox0ZR7AB5yKaUhzpYL2aZ/5x8
	8j0n3/PI4WhVDRvH6TOOag0ZYpqaVWDF9Cp74vC+Kd3WZ9cTIDJbgqG62clCiauSgb6LjQiG
	IyUIiq4sY5hd/F0Gy509CJ60LLEw6XmMoOJhAYYZxwkEy0NjFDjCSxSEu75B8E/5Eaitc7Pw
	zH+LBvv9IRrGW6J6a08IQX94NfwamWHBW3achelANQU1VacQFJ5pZiEw+ZyCRte74LPUUdEG
	LJT/EAtVFYVUNIxTUNZ0lYJFR4MMHKYNUOXvZ2Ck3hqdzJYJPY1jMhj6rgzDxelbDEyOnmKh
	3XRPBq7ffkJQ0hHB4HpwhwF78VkMlaf/YOHHTi+G/o5qFk60XGIg5FxmwFQ1H12+y8dA81iQ
	Al/PDQxe6wUM9+8FGXD7e2kIWv5E0PSoLnqGOQe9O1WYL/oWCw3uNkpwnnYiYfZcIS0UWaLk
	mZqhBbM7Vzjnm2KFp5EBVuics2HhlzoinPQnClesQzLBfG1QJthc2YK7XrM/8SPFW6naNH2O
	1rBl56cKnaczhLPOsHn14fdNqJgpRXKO8NuJwzeBShG3wkG7QZIxv4H0Pr3ESszyG0kwuEhL
	JTH8G2Ti2AelSMHR/Pl48v1ozUrNWn4XuTngRBIreSA1Ac8Kq3gzIn/3ii/0NcRbGcYS07yG
	BJceUpInzceT80ucJMv5TWTeMkJLvI5fT7rafqakXoQflZPqghB6MfIr5Hp9EFsQb33J1vqS
	rfV/WxuiG5BKn5GTLurTtm/W5Wfo8zYfykx3oejTOr58fvAyetyX0o14DqlXKXVXJ3UqRswx
	5qd3I8LR6hjlyeJxnUqZKuZ/oTVkfmLITtMau1E8h9WxyjfnclNV/GfiUe0RrTZLa/gvS3Hy
	OBNKTkjI3ZEd9478wrUHE0/yyre0epKTim6KC5rBvUnp9h3v/cVS3YrXFYMHYu4Gbnw+0n7Q
	vL+jaeOj2Nsfakwtx3et3rPPf/vjA1lfDx7L2Z3k7F//Vcrb87XimgLzApXcW7vXtGfAdji8
	ra3JuNblzeoThgMpr7XufHVhbGvKppCuvUKNjTpxm4Y2GMV/AZ3vxSmwAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA02SbUxbZRTHfe7Lc28bO68VtycjfrDuJRJBl+k8cUaXqNkNUXQz2Xxjrt2u
	tuGlyy3D4WLCWxFxaqlp2dp1MtgKgbJ1BRaRdEEaWbaBDJFRdYV1qQxGkaiwhgLFdsa4Lye/
	8z///8n5cHhaHWfX8obCIkku1OZrsJJR5mytyBx7Pap/ytWWBdfKehiYn6tm4PhZD4Zq3zEW
	rp5pRTA+X40gtuikwdy1wsCytY+DuYXfOFjx9yGwD1lp8HSUUfC3N4FhOvAXAls4gqFuqoyB
	WfcRBI4JJwdTP2yHmfFuFlZCtygYvRNF4I4kKIj0fIpg2Z4H3zS0Y1gcGKShznYVwclwiIZJ
	b3LY0TeGwN9cjuF3SycNw5FV8PP8LIZLts8xzAwdp+APL4b6cj8LLqcVQUXjWQx2l4+Brhvf
	cTA0vUTBdbuVglbfazDunmDgiqWBSt6XdJ1bA866CipZJimwtXVTsOBu4aC/8ToD7tL14BwY
	ZuFms4ODpfAmWKk3Ql/rLQ5CX9kYODMzyG6zITFm/pIRW9rPU6L5p2Usek54kLgYtyJx7nQF
	LZotyTYQnaXFyvaPxNNXoliMz49g0X+nnhEvNxCxdiBT7HKEOLHywq/cG8+9o3x+v5RvKJbk
	J1/Yq9QH/GPMgUZ8qDmysxRVsTWI54nwNAmelGuQgmeE9aQ/3olTjIWNJBhcoFOWNGEduf3Z
	rhqk5GmhKZ18PeG663lIeJH8OOJBKVYJQFxDgbusFioR+bNf+6/+ILl0LMKkmBYySDAxRaV2
	0kI6aUrwKVkhPEFilpt0ih8WHiM95y9SFqRy3JN23JN2/J+uR3QLSjMUFhdoDfnPZJny9CWF
	hkNZ+4wFPpT8SPcnS7Xfornh7b1I4JHmfpW+e1qvZrXFppKCXkR4WpOmqq2a1KtV+7UlH0uy
	8X35YL5k6kXpPKNZo8reLe1VCx9qi6Q8STogyf9NKV6xthS5r+VIl2U245eD0cAjh+/b4jWe
	em/j6Pe6dFfuznc/CDlWb6jLzlzep9PZSXlr7aPPvt0SfOXwjuwLqzdn9DpHXlLciK17tWkC
	F9U8MCX4ir2d4qqcPbmzm31HwqNuz+Dtl+UtRp05trVKEX/z8Q7YlgiVNOTKF0+95Qwf5dp0
	G77QMCa9dlMGLZu0/wCekX8tjQMAAA==
X-CFilter-Loop: Reflected

On Thu, Oct 02, 2025 at 11:36:16PM -0600, Jonathan Corbet wrote:
> Byungchul Park <byungchul@sk.com> writes:
> 
> > This document describes the concept and APIs of dept.
> >
> > Signed-off-by: Byungchul Park <byungchul@sk.com>
> > ---
> >  Documentation/dependency/dept.txt     | 735 ++++++++++++++++++++++++++
> >  Documentation/dependency/dept_api.txt | 117 ++++
> >  2 files changed, 852 insertions(+)
> >  create mode 100644 Documentation/dependency/dept.txt
> >  create mode 100644 Documentation/dependency/dept_api.txt
> 
> As already suggested, this should be in RST; you're already 95% of the
> way there.  Also, please put it under Documentation/dev-tools; we don't
> need another top-level directory for this.

Sure.  I will.  Thanks!

	Byungchul
> 
> Thanks,
> 
> jon

