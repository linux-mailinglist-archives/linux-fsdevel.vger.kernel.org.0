Return-Path: <linux-fsdevel+bounces-69175-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 53822C71DD8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 03:34:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 571C828E0F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 02:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E3042DF12F;
	Thu, 20 Nov 2025 02:34:26 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7F0028725A;
	Thu, 20 Nov 2025 02:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763606065; cv=none; b=jYwr2+6wEACyI9/NLUcaLmsUifXbBN5ExkpJTnAy7p3OElohJhoQMm26cI68bu9bFpRCp+a2qJE05cD3EkQfWAaLYrFnQX9nPOuUlYG1HN6FbPXiY5dljp4orqw4Wi8XTBEnAx1IteB5BDMd3SMc11Ctbzlrxbh6eybJtMISwvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763606065; c=relaxed/simple;
	bh=/EG5zoBd9EOTX77N44tGF7qVruGgiPwa1ndxkUQivj4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PgHiAhW590Z/lBWCgyPPXJGPgD4WHwVEQ9rqpjRujQgMNOSi3o1ixJLMv9o3Sjhn5kEJnb04Sr4jvxstHh0AtvAVvjQo1mZ7HoYLUUhqDYLZNOdP2M0iiWxT/7zFNcP+MCglsJoU5B4KlbeLJBVaxEnjTyWB8nFRgOARRSGmEkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-c2dff70000001609-2b-691e7e2bd269
Date: Thu, 20 Nov 2025 11:34:13 +0900
From: Byungchul Park <byungchul@sk.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-kernel@vger.kernel.org, kernel_team@skhynix.com,
	torvalds@linux-foundation.org, damien.lemoal@opensource.wdc.com,
	linux-ide@vger.kernel.org, adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org, mingo@redhat.com, peterz@infradead.org,
	will@kernel.org, tglx@linutronix.de, rostedt@goodmis.org,
	joel@joelfernandes.org, sashal@kernel.org, daniel.vetter@ffwll.ch,
	duyuyang@gmail.com, johannes.berg@intel.com, tj@kernel.org,
	tytso@mit.edu, david@fromorbit.com, amir73il@gmail.com,
	gregkh@linuxfoundation.org, kernel-team@lge.com, linux-mm@kvack.org,
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
Subject: Re: [PATCH v17 44/47] dept: introduce APIs to set page usage and use
 subclasses_evt for the usage
Message-ID: <20251120023413.GA27403@system.software.com>
References: <20251002081247.51255-1-byungchul@sk.com>
 <20251002081247.51255-45-byungchul@sk.com>
 <20251119105312.GA11582@system.software.com>
 <aR3WHf9QZ_dizNun@casper.infradead.org>
 <20251120020909.GA78650@system.software.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251120020909.GA78650@system.software.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0yTZxTH8zzvhZeGJo/VzUeZxNQ1LjicGoxHsyxTE/N+MHGLH6Yz2fY6
	XqWzraRFLt5SMi6FTGxQRKqBKjoNl4ItsI1VVrkUmBcKibUhEFBuVi5Gbm4B2VqN0W///M4/
	v3M+HIFRdXMrBa0hWTYaJJ2aV7CKiagrcetOx2g33J/UwOyMhQWLs5gDn6MCQf+sBcF0zSIP
	Y81TCAofD/FQFMxg4b++UQxDnhwEry4cgdKrrhAv9CF4WhNCE12XMXgrRiPAMdHJwdhIAQ/9
	bdkc3O5ZB8UlvTy4b3eE1ryaQfBLTR0H5ksvOageDWDobKji4PqjLgwB6zCCbo89ZLJ/CHV/
	ZSFoO+PBkPP0Tx6yr93C0GgZwNBS/RsGZ6Wfh+bZcQznuu08+AtKeajoYqFwwcLDpYx8BJaW
	OQYyezfDPzWDHExaZ7gvN4gvs/JZsdxVj8XKkkokZrpSxT9sfRFiZmNPhGh3HhNdN2PFMncQ
	i87yXF7s9bt58Yq5kBFLOr4Wy/LPceKL4R5WfN74kP9q6beKzxNknTZFNn72xQ+KRKfXh5Ou
	rU6rH6xFZtRH81CkQEk8bX/QjN9m82AfykOCwBINLWnYEsY8WUsDgX+ZMF5GPqHjtZvykEJg
	yNVoWvX3HS7cWUp0dK7FERHOSgI0+94CFy6pyDNE66y17JvBEtpRPPQ6MySWBhaDOCxlSDS9
	sSiEcSTZSv2ugtfOD8ga6qlvw2EPJSOR1G8bQ2/uXEHv3AywVkRs72lt72lt77R2xJQjldaQ
	ope0uvj1iekGbdr6H4/qnSj0ab+eWjjwO5ry7W1CREDqKOU+7yqtipNSTOn6JkQFRr1Mqdn+
	kValTJDSj8vGo98bj+lkUxOKFlj1cuWmudQEFTksJctHZDlJNr6dYiFypRnFmN3zKfrvFpn9
	P1ONtVXxJK7o+s6z57c2Je0INGgk++Hc5ScPMKbLW27tCaYWKBOmUz8Nbvu4bCTHcbBMjo+K
	4TxM+oCr09F+l2TulpovVlWXnhq5kEzrY70d5iH98K6BE153Q5Rlx5nV/odFF0uHv2k9tPHQ
	s/m4OB/OOfiTQc2aEqWNsYzRJP0PGukI72UDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA01Se0xTZxTPd7/7orPLtbLxKZtxNUSjwc1Ns7NHli1b4MbEjWQm6jYzm3kj
	V0rBVhGWoMVaR5hzpVlLaFUYaEHAgm0lQwNBxDpUIo+JRKlYLSqTR6aAQ0pZ67LMf05+5/fK
	+ePwWBVmFvGybpek12m0alZBKz7/wJS8cu9i+S13H4K+glYaJicKaThSX8dCoaeUgS53LYLB
	yUIET2ecGMxNczTMWv0cTEzf4mCu2Y/A3m3FUOcroOBJQ4SFRxceI7AFQyyUDBfQMO46hMBx
	38nB8MVUGB08x8Bc4AEFN6ZGELhCEQpCrT8gmLVnQFmFl4WZzmsYSmxdCH4NBjA8bIiKPv9t
	BM3V+1kYspzB0Bt6Gf6YHGehw/YjC6PdRygYa2ChfH8zA0edVgSmynoW7Ec9NDTdOctB96Mw
	BQN2KwW1nvUw6LpPwxVLBRW9L+o6nQDOEhMVHQ8psJ06R8G0q4aDq5UDNLiMSeDs7GXgbrWD
	g3BwNcyVZ4G/9gEHgZ9tNLhHrzEf25D41HyYFmu8jZRo7pllxbpjdUiceWZF4sQJExbNluh6
	YWQciwe8e8QTV0ZY8dnkdVZsniqnxcsVRCzuTBabHAFOPNByk0t7/yvFh9skrZwj6d/8aKsi
	3ePvorKPL8ltvOdDRhQgRSiOJ8IaYrwXQEWI52khiRw7+26MZoVlpL9/GsfoeGE5GfG9XYQU
	PBYqEsmpy+eZmGeBoCVT7W4uhpUCkINXw0zMpBL+ROSMxUf/K8wnHaWh5xgLK0h/ZJiKlWIh
	kVRF+BgdJ7xH+rzW552vCEtJa+MlyoKUjhfSjhfSjv/T5QjXoHhZl5OpkbVrVxky0vN0cu6q
	77IyPSj6k678cPFvaKI3tQ0JPFLPU27yvy6rGE2OIS+zDREeq+OVSZ+8JquU2zR530v6rG/1
	u7WSoQ0l8rQ6Qbluo7RVJWzX7JIyJClb0v+nUnzcIiNKyZ6u+rL1SdpL2+mFZY9Nd/YuLZzB
	r1r+2jJl8q9sGUv5Zd+AuequbvGenp4kb9rp4oadBz/bfD5i2ZGivl6p34eHNm7QlG1u/+bv
	Hcaf3PX2ky1DN2/83rLzndS1h+xy8Ovx3QsWJuQOLEle193x6bxg/uHSLe1VYzg/f836NPfy
	6i/eUNOGdM3qFVhv0PwDJjjDWY8DAAA=
X-CFilter-Loop: Reflected

On Thu, Nov 20, 2025 at 11:09:09AM +0900, Byungchul Park wrote:
> On Wed, Nov 19, 2025 at 02:37:17PM +0000, Matthew Wilcox wrote:
> > On Wed, Nov 19, 2025 at 07:53:12PM +0900, Byungchul Park wrote:
> > > On Thu, Oct 02, 2025 at 05:12:44PM +0900, Byungchul Park wrote:
> > > > False positive reports have been observed since dept works with the
> > > > assumption that all the pages have the same dept class, but the class
> > > > should be split since the problematic call paths are different depending
> > > > on what the page is used for.
> > > >
> > > > At least, ones in block device's address_space and ones in regular
> > > > file's address_space have exclusively different usages.
> > > >
> > > > Thus, define usage candidates like:
> > > >
> > > >    DEPT_PAGE_REGFILE_CACHE /* page in regular file's address_space */
> > > >    DEPT_PAGE_BDEV_CACHE    /* page in block device's address_space */
> > > >    DEPT_PAGE_DEFAULT       /* the others */
> > >
> > > 1. I'd like to annotate a page to DEPT_PAGE_REGFILE_CACHE when the page
> > >    starts to be associated with a page cache for fs data.
> > >
> > > 2. And I'd like to annotate a page to DEPT_PAGE_BDEV_CACHE when the page
> > >    starts to be associated with meta data of fs e.g. super block.
> > >
> > > 3. Lastly, I'd like to reset the annotated value if any, that has been
> > >    set in the page, when the page ends the assoication with either page
> > >    cache or meta block of fs e.g. freeing the page.
> > >
> > > Can anyone suggest good places in code for the annotation 1, 2, 3?  It'd
> > > be totally appreciated. :-)
> > 
> > I don't think it makes sense to track lock state in the page (nor
> > folio).  Partly bcause there's just so many of them, but also because
> > the locking rules don't really apply to individual folios so much as
> > they do to the mappings (or anon_vmas) that contain folios.
> 
> Thank you for the suggestion!
> 
> Since two folios associated to different mappings might appear in the
> same callpath that usually be classified to a single class, I need to
> think how to reflect the suggestion.
> 
> I guess you wanted to tell me a folio can only be associated to a single
> mapping at once.  Right?  If so, sure, I should reflect it.
> 
> > If you're looking to find deadlock scenarios, I think it makes more
> > sense to track all folio locks in a given mapping as the same lock
> > type rather than track each folio's lock status.
> > 
> > For example, let's suppose we did something like this in the
> > page fault path:
> > 
> > Look up and lock a folio (we need folios locked to insert them into
> > the page tables to avoid a race with truncate)
> > Try to allocate a page table
> > Go into reclaim, attempt to reclaim a folio from this mapping
> > 
> > We ought to detect that as a potential deadlock, regardless of which
> > folio in the mapping we attempt to reclaim.  So can we track folio
> 
> Did you mean 'regardless' for 'potential' detection, right?
> 
> > locking at the mapping/anon_vma level instead?
> 
> Piece of cake.  Even though it may increase the number of DEPT classes,
> I hope it will be okay.  I just need to know the points in code where
> folios start/end being associated to their specific mappings.

Assuming that I understand what you meant correctly, I can use the
@mapping value in struct page as a second key in DEPT.  Of course, it
doesn't guarantee unique ids of the mappings for ever.  However, I think
it can be a good and quite simple start.

	Byungchul

> 	Byungchul
> 
> > ---
> > 
> > My current understanding of folio locking rules:
> > 
> > If you hold a lock on folio A, you can take a lock on folio B if:
> > 
> > 1. A->mapping == B->mapping and A->index < B->index
> >    (for example writeback; we take locks on all folios to be written
> >     back in order)
> > 2. !S_ISBLK(A->mapping->host) and S_ISBLK(B->mapping->host)
> > 3. S_ISREG(A->mapping->host) and S_ISREG(B->mapping->host) with
> >    inode_lock() held on both and A->index < B->index
> >    (the remap_range code)

