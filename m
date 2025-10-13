Return-Path: <linux-fsdevel+bounces-63867-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48270BD118B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 03:29:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F01433BBD65
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 01:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C1572327A3;
	Mon, 13 Oct 2025 01:29:07 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 206A629408;
	Mon, 13 Oct 2025 01:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760318947; cv=none; b=jHLlFOOvvmbU3tl9Sgd8ZltdJ3279SNotS11xw21knQLp1OYTOF2DhLFWos6WQHVDrplLhP+1itt3dm6E8yek/4cpQAwLZM7v8xTPmCQHacp0k2N//vHBfNZ9NOc3usMLy/qL0WGFwO3OvV5FM63M0GvR5VVIbyEX4XUC9gRPv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760318947; c=relaxed/simple;
	bh=pF3SfRA5dJFIspkqg6jyyfpkzqFi8q+zCIaQtyNC6+s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rm/z4HuNUrH2f0B2kqBDUe6r+12cXwaaglrAyQiO6JqXbmVIEu9hpTit23sH9/+JVMk06B+AQAdiYEaKamLaZQoOsLI39pJcUumjQWnyvXSdSysvKjUER/G0OU5VfOVHQTUCIkt0i77CI97gMMPXHittGKqebTc8OF9apttupF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-c2dff70000001609-c2-68ec55dc252c
Date: Mon, 13 Oct 2025 10:28:55 +0900
From: Byungchul Park <byungchul@sk.com>
To: Bagas Sanjaya <bagasdotme@gmail.com>
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
Subject: Re: [PATCH v17 28/47] dept: add documentation for dept
Message-ID: <20251013012855.GB52546@system.software.com>
References: <20251002081247.51255-1-byungchul@sk.com>
 <20251002081247.51255-29-byungchul@sk.com>
 <aN84jKyrE1BumpLj@archie.me>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aN84jKyrE1BumpLj@archie.me>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA02SbUxTZxTH89z79OltR8m1Q/dMsizrZCpGNicJZ4lxI2bb/WLmdDOZL5lV
	7tZmBVwLKMZtQIdj6BjUgFmLUiCtKEW0xSIvXRAipjgYyJjNtgLDgpJS2Rit7o2OYsz8cvLL
	+Z3zz/lwOFZZS1Zy2qwcUZ+l1qmIHMtDcbXr/e/OaF4KXpNBeL4EQ3Wzg8DghUYE9/+2sFDc
	FsUQ9fQiqBoyseBoKWTgj4sLBII9cwhm7ScQTF97E6L+OwzciswgsAcWGAh0fYGgps5FoPZX
	PwstvaMIPA1FBCbLL7MwHIiHH8KzBLyVxwmEhqoZsBZ5JHDaYkJgrG8mUHXaiaFtvF0Kv1SZ
	GGh0boUx+xSGG+V1DFhOGWPlLgOVTR0M2AuSYKLBLIWoNRv8X1di8I7+KIHglInA2PVjEmgt
	GJdCSXsYg/P2ovD8tA46PV4MvVcmGBhuryZw4uJlCYw6ohK42TiIofmOjwGv+RyG79ubJGC7
	NcSAq/87FiJlidB0r47AyXtTCIIROwv28Kz0tQzhfnEZFs673IzgOONAwrzNyArF5YvUMzPL
	Cp+7Dgm2GzNE+Cs8QgRPxIqFvjoqVPSvF9rMfqlgdeYKroZkob5zmtmWsku+KUPUafNE/Yub
	98k1ngcD+ODxhMMRixEVoPr4UiTjKJ9KLw0XsY+4ZqJbEmPMJ9FQ/7coxoRfTX2+P5dmEvg1
	1Ot6IC1Fco7lWxPpUMvtJfEk/yodGHEsLSh4oPOtNSg2pOQLER34qgU/FMuo95vAErN8MvUt
	TDOliFvkRHp2gYu1ZfxaOtYfIjFezj9Pu9zXmVgO5SdkdLTGRx5e+jS92uDD5Yg3PxZrfizW
	/H+sFbHnkVKblZep1upSUzT5WdrDKQeyM51o8XHtn/yz+wqaG9zRjXgOqeIUmo6gRilR5xny
	M7sR5VhVgqLi2F2NUpGhzj8i6rPf1+fqREM3SuSw6inFy5FDGUr+Q3WO+JEoHhT1jyzDyVYW
	oO1d6YWr38uJz68dc7exKfsr4LdcqanvhfDJwNFtPfXPOUD25Z5/daua3OkV75R8utn6wdaj
	e1rn3ni7L0224sKOLZ9VlenXXk3tcCx/xbbh401p44Nx0RXSI5bJZ2xpnvSQMrzKsLNsMvzz
	W1uWPUue2Lmx092794Ax8vrI7/6NN1OTxlXYoFFvSGb1BvV/O4WOPLQDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA02SbUxTZxTHfe69vffSUHLtSngUh0mNuhGBmWh2si2bn+aNi8ZoFqNmmTfz
	xjaUYlpXxYWEWtkYvqx0aZFWpULoDNSBpaiM1DR1q0Eo2oFKJtDhqoLQsYzyJhTWsizzy8nv
	nN/5J+fDYUl5QrKaVWuPiTqtoFHSUkq6631T3sCn46p3JhtWwSOjn4KpeAUFF5vdNFR4aiTw
	4McmBJGpCgQz8w4SytuXKEhYggzE554wYDUiWPIFEdjCFhLcXiMBky2LNIzd+RuBdThKQ/Wo
	kYIJ11kE9ucOBkZ/2Q6xSIcElgZfEPB4ehyBK7pIQNT/DYKErRBq61ppmA/dJ6Ha+gDBleFB
	EkZaktIbHELgu3qKhmfmNhJ6oxnQNzVBQ6f1DA2x8EUC/myhwXnKJ4FLDgsCU30zDbZLHgra
	f/+JgfDYAgEDNgsBTZ6dEHE9p6DLXEck70tuXc8CR7WJSJYRAqzXOgiYczUy0F0/QIGrbD04
	Qr0SeHrVzsDC8GZYchZDsOkFA4PfWaltNsTPlJ+n+MbWGwRf/muC5t2X3Yiff2VBfLzBRPLl
	5mR7Z3yC5E+3HucbusZp/tXUQ5r3TTsp/l4d5qtCeXy7fZDhT9/+jdn93gHpB4dFjdog6go+
	PCRV+WZ7qKNnFCemHSZUhuozKlEai7ktuPZpQJJiiluPY6HbKMU0txH398+RKVZwb+HO1lmm
	EklZkruZjcPeP5bFG9xHuOehezkg4wDHb9ai1JKcMyLcc85L/StW4s6a6DKTXC7uXxwlKhGb
	5Gz8wyKbGqdxb+NIKEanOJNbh/037hJmJLO/lra/lrb/n3YishEp1FpDkaDWbM3XF6pKtOoT
	+V8UF3lQ8ildpQtVt1C8d3sAcSxSpstUHWMquUQw6EuKAgizpFIhq/p6RCWXHRZKToq64s91
	X2pEfQBls5QyS7Zjn3hIzh0RjomFonhU1P1nCTZtdRny1e4xXT8y9MRW9RJrMrW33u14PNTd
	pzj4cYH35Q5DW9Ce2RxOLzDTipx9e3M/c3hItrt4Y9aKPZIN/q41+7e9uTUnbl678EhIK32m
	adty4ORfm2LpwmT27NkLBuf3gcim46Ur/TUVI4nRn2fOF+Wv+KTh2wtfhWN5fTmGtXczVlUO
	KSm9SticS+r0wj/gdz/3kAMAAA==
X-CFilter-Loop: Reflected

On Fri, Oct 03, 2025 at 09:44:28AM +0700, Bagas Sanjaya wrote:
> On Thu, Oct 02, 2025 at 05:12:28PM +0900, Byungchul Park wrote:
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
> What about writing dept docs in reST (like the rest of kernel documentation)?

Sorry for late reply, but sure.  I should and will.  Thank you!

> ---- >8 ----
> diff --git a/Documentation/dependency/dept.txt b/Documentation/locking/dept.rst
> similarity index 92%
> rename from Documentation/dependency/dept.txt
> rename to Documentation/locking/dept.rst
> index 5dd358b96734e6..7b90a0d95f0876 100644
> --- a/Documentation/dependency/dept.txt
> +++ b/Documentation/locking/dept.rst

However, I'm not sure if dept is about locking.  dept is about general
waits e.g. wait_for_completion(), wait_event(), and so on, rather than
just waits involved in typical locking mechanisms e.g. spin lock, mutex,
and so on.

[snip]

> > +
> > +   context X            context Y
> > +
			     /*
			      * Acquired A.
			      */
> > +                        mutex_lock A

			     /*
			      * Request something that will be handled
			      * through e.g. wq, deamon or any its own
			      * way, and then do 'complete B'.
			      */
			     request_xxx_and_complete_B();
        /*
	 * The request from
	 * context Y has been
	 * done.  So running
	 * toward 'complete B'.
	 */

	/*
	 * Wait for A to be
	 * released, but will
	 * never happen.
	 */
> > +   mutex_lock A <- DEADLOCK
			     /*
			      * Wait for 'complete B' to happen, but
			      * will never happen.
			      */
> > +                        wait_for_complete B <- DEADLOCK
	/*
	 * Never reachable.
	 */
> > +   complete B

			     /*
			      * Never reachable.
			      */
> > +                        mutex_unlock A
> > +   mutex_unlock A
> 
> Can you explain how DEPT detects deadlock on the second example above (like
> the first one being described in "How DEPT works" section)?

Sure.  I added the explanation inline above.  Don't hesitate if you have
any questions.  Thanks.

	Byungchul
> 
> Confused...
> 
> --
> An old man doll... just what I always wanted! - Clara

