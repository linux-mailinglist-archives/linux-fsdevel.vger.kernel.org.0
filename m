Return-Path: <linux-fsdevel+bounces-69187-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2436CC723AA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 06:14:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id E417E29DE6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 05:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 053B82E9726;
	Thu, 20 Nov 2025 05:14:24 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89347242D7D;
	Thu, 20 Nov 2025 05:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763615663; cv=none; b=nflZCYJUOm5Mz0jNwUcOlYYgkNugM4AaDleTFMt/Baqto0PuF1/IZ7UrBrHNGklkP8o0u5lbNAa844ipJnkKzvvGkDF7XQvjvvw2Yqz1Zi0tJROzfgi/C9fipX4bsrJZVRkVC0Bi0tFv1U/o38ZVzN882ilwIVlJ3JhcyYqpVmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763615663; c=relaxed/simple;
	bh=uUrpx+g526d5GVlYUAYE7oeVYDK91OLrSvMwSuOHD5o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cXJs4qlwaZhMeUPnBCnKdA7PNn/U4dda1kotzi/HyM0qW+JC3V90u7vUxxazeaJUq6ZV5J9m2fHxpCXo+A4OlzaBo8tKBHt+OMyeOuQeETJeV4mN+n3LNwf1wlNUDqk90GfUoWox816CvLbx3vjJ0WdbQlOpt+gI8m8YrgzgRvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-c2dff70000001609-90-691ea3a8ad9b
Date: Thu, 20 Nov 2025 14:14:11 +0900
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
Message-ID: <20251120051411.GA18291@system.software.com>
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
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sf1DTdRjH7/P9vR3Tb1PiEyvvWqcWHZhK9VTW5R9d3z/oxyneefVHfS++
	JzvHsIEoXD/IXBEJjSXrGKA7PAfClPUFtKFwiIIgcoAUfTXHWI0R4dIDBHUBbXRe/vd+nud1
	r+f54+FI7VEmkTOYciWzSTTqGTWlDsfVJJ84tsbw3HgwDqoa3QwUyRU0+O8UIZiPVJJg8S5R
	sGDrZmGprRuBfchGgrv5CwJmPIsMTF2YRlAeCDLgCFWyMNn1JoT9Z2lY8k0Q4AouEhDs+BrB
	gn03HK1pYiDSP0DCn55oq63uAAPj1hYShoMrIDxURcDfHgacB9poqK60RTdVyxR4x1pZuGG3
	EdAgvwV+V4iCHyYZsP+YAOUnzxJwz1XPQmX/MA2/1zmiJzqzobthggXfd+UUnAoP0DAVsjHg
	v/QVDfK1LgSzPwcIcB8KkSD/MUJDxZEbDJxr66VguLWKgUOeFhpG3Us0DHb00XC1YZCCxgmF
	gF7HCQqO/zpEwFypDgbLSmhQrOMIXHdusa9nCPOWUkqobzpNCJarC4zgPuJGQuS+DQmzx78k
	BYs1Wl64eYsUyvqTBa/DxwoH26+zglPeKxy8GKaFY+cmCeH61KuCXP8N827Se+otGZLRkCeZ
	N7z2oTqzxx1h9txes99yt50oRL0JxUjFYT4Vd3mqmQd59PL3bCxT/Frc4w0vZ4ZfjxXlHlmM
	OG41/zS+2bypGKk5kq/R4ZOXz9MxZhVvxHMXT7ExRsMDnvdsiTFa/i+EW6zNVIzR8I/g3org
	cib5JKwsThIxnuR1uHaRi7VV/Et4pMm2rIznn8Idpy8RMQ/mQyrcekZG/935GD5fp1BWxDse
	0joe0jr+1zoRWY+0BlNelmgwpqZk5psM+1M+ys6SUfRtXZ/+8/5PaHpweyfiOaSP0+zsfsKg
	pcW8nPysToQ5Ur9as3br4watJkPML5DM2R+Y9xqlnE6k4yh9gmbT3L4MLb9LzJV2S9Ieyfxg
	SnCqxEJ0eORjZfOKQEngZTrxjSn3lVEPXZG7Izv9Mx83+4J2bpV/pz3dLxeMlDWltEdg37ep
	136ZedGb1rcyvqekdl1Vde0noVdun1EKH33HVbryc/E3lfO+N9CoK5h5vjR587PTb/fdlaVt
	8aYx31jxgG5bEfNkF0S2pz2zQ1S2KumHe9L0VE6muDGJNOeI/wILdggfsgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0xTdxTH87v39t5Lt+qlsvBDHHE1RCMKaLbkuJnFRzJ+IRsx/qMxIdrI
	jRTKI61DWbJIhUaCZtbOQmhFOgiVQEUolYAGwkMroMhrY920MmbloWWYjYc8u5Zkmf+cfM/5
	fr4n54/D0/IVyWZelXlW1GQq1QpWykiTvsjfXV0ZpYp/+WwrjOjaGZibLWTgxh07C4WOUgkM
	1NUiGJ0rRLCwbKFB3+JnYNXo4mB28RkH/lYXguJBIw12p46Cf+rXWHjT9TcC05iXhZIpHQMz
	tisIzOMWDqYeJsD06H0J+D0TFPw670Ng865R4G2/hGC1OB3KKxpZWO7rp6HENIDgpzEPDZP1
	AdPpeoGgtfoiC68Md2kY9m6An+dmWOgxXWZhevAGBX/Vs2C92CqBMosRQX7lHRaKyxwMtPxx
	j4PBNysUPC82UlDr+AZGbeMMPDZUUIH7AlRDOFhK8qlAmaTAdPs+BYu2Gg6eVD5nwJYXDZa+
	YQn8WW3mYGVsD/itWeCqneDAc9XEQN10v+SACZEF/Q8MqWlsooh+aJUl9pt2RJaXjIjMVuXT
	RG8ItF2+GZoUNJ4jVY99LFma+4UlrfNWhvRWYHKtbzdpMXs4UtD2O3fk8xPS/SmiWpUjauK+
	PCVN7bYvs9lvo87r37VReagnvAiF8Fj4FL/o/ZELakaIxt0t0+uaFbZjt3uRLkI8HybswD7n
	3iIk5WmhIhLf7u2QBJlNghrPP6jjgoxMALxQvz/IyIXXCN81OJkgIxNCcU+pd13Twk7sXpui
	gjwtROJba3xwHCLswyONxvWVHwnbcHvTI8qAZOb30ub30ub/01ZE16AwVWZOhlKl/ixWm56a
	m6k6H3s6K8OBAj9p+37lWjOaHU7oRAKPFB/Kjrs+VsklyhxtbkYnwjytCJNFH9yikstSlLnf
	iZqsk5pv1aK2E0XyjCJclnhMPCUXzijPiumimC1q/nMpPmRzHtq7o2DoxPHYmeqy1IMDhzu2
	7DrXxI9uHLyZeCbu6aR1rFv/22H3oZdXbKFX9yUlNmx9p0s+etQfP+6oc0RsvP4qxZdY5CGf
	HCjsbiMRX+OIXULZyAdfdbAx7nju5K3QDeOHtkddb2Z8F/QdzTFpyZcMS5d9D9MMb8vLJywI
	zzvTdApGm6rcs5PWaJX/An0YZayPAwAA
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

Might be not as easy as I thought it'd be.  I need to think it more..

	Byungchul

> I hope it will be okay.  I just need to know the points in code where
> folios start/end being associated to their specific mappings.
> 
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

