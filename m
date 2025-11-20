Return-Path: <linux-fsdevel+bounces-69173-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 751B3C71C51
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 03:11:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BB3F14E43A7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 02:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4AD72773D3;
	Thu, 20 Nov 2025 02:09:28 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 684621DE3DC;
	Thu, 20 Nov 2025 02:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763604568; cv=none; b=Isfni3xDAXIpgyEEW2460j4u0ulf1xJlD3S6FLMzvNR31Hu7GUROolsJcJrSI4l0CoPpNBIIQIaFWfjNoqi9m7hekUeF6nGio9ysSoKcBT8vqNzYTdLn4ST7NtH7cDKraZR0YJHb6WAyRnSNRmhqCe80QpZiL4BeijmcD69B/Dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763604568; c=relaxed/simple;
	bh=QUgA1HX7B/qcO1RvgSuXmUmQCsyytJqwclA8xmQo11E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uqmTeN8IXLccaRcij+riy3sey2Kq/PuOPVvsP1u5dOfSOYyqTrUqxAIBaEDTRQFtXbgpClsanmlpnPpXKS/nQMIGq8bhKkw+0Rk5wtOoqs7RzrU/PUVE22S56OjynKh3R2JBAXdnZK1GJ/fZCBly1t+aJoZB0B0ltU7MV8K5wdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-c45ff70000001609-d3-691e784bff7b
Date: Thu, 20 Nov 2025 11:09:09 +0900
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
Message-ID: <20251120020909.GA78650@system.software.com>
References: <20251002081247.51255-1-byungchul@sk.com>
 <20251002081247.51255-45-byungchul@sk.com>
 <20251119105312.GA11582@system.software.com>
 <aR3WHf9QZ_dizNun@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aR3WHf9QZ_dizNun@casper.infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA02SfUxTZxSH89773tvbat214nwnzixdCAYCGwaTs2TZR2KyGxeTGTXZ1Gxr
	bCONBbEowpwJzOIa3AyytEALDDDU8qm0iraIUSa4jg/5cFIcDItYJVLMsC1BS12vZpn/nDw5
	v1+enD8ORyuq2bWcNuuQRp+l0ilZGZYFltemfJ63Xvu++UEKhIJGDJXnmlkwOioYGGxtQrDw
	3EpDkesFhuDiXxJ4ej7KwuPf5hGYfNMslM0UYnhi+wmBxW+VwEz3ZxCY7GDgxcRDCkbDswiW
	zPvh1zonC7W+CRo67T+w8KDkIg0j0yvAYzrJQmCokoK58yxUWUsRmKscGFz33BIYN5dSMGnz
	YzC3rQFr2XEqNh5RYGrpoGDR1iiBvjPjGGwFCWDtH2Eg4kuD1sAtBjx/32Hgsb+UhcmbJxi4
	VHBPAo6xbgTB2z4KjO4QBsf9WKXzbjJUVI+zcKXTg8G4FETQc3mKgsFrvQwMNw1iOPfQS4HH
	0oDhlruFgfrRIQqc/X00hE/FQ8tcHQu/zPnRJ2phoegUFhqd7ZRQNLzECs3VzUgI1h+nhaKS
	GBmcR4T63llWeBb6kxU6wzVYON2fIrgsExLBcPWuRKhxHBYMNwKM4LQnfZG8S/ahWqPT5mr0
	7330rSwj8qwGZzvW5Z0ZtVAFyPBmMZJyhE8npqrndDHiXnKf4Zi4xnwC6S12syKzfCLxehdf
	VuL4DWT2wsZiJONovi6etPxxnRE7q3gdCd9olYgs54FEG+xILCn4DkRun2hjXgUriadiGotM
	80nEG52hRCnNx5OzUU5cS2MnjNX9SIu8mn+XXGu/SYkewk9JSZOxgX5181vkut2LSxBveU1r
	eU1r+V9bg+hGpNBm5WaqtLr01Iz8LG1e6t4DmQ4U+1rbscjuy2h+cHsX4jmkXC7/sudtrYJR
	5ebkZ3YhwtHKOHnCp+u0Crlalf+dRn/gG/1hnSanC8VzWLlGvjF8RK3g96kOafZrNNka/X8p
	xUnXFqA9pxe+GkgdMMk8H38d/L6wxG+lEhPjElye5Ce/Lwtv7v75afvWZW0HQ+sjd5JdY6rs
	gZPbNpsn79PlZ8tz03dsP4hG3th0dVNoZeFO1l617cqUdJdid23a1M5K8s/Y0cjIOx/MRaXl
	3dSO3keBPb4tF9X01p4tR5tXDDvKhlZPuOcZJc7JUKUl0foc1b9rqkVSsQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sb0xbZRTGfe/73j80llwrsuvYNOmCkiVDIS4eJzH6aTdLtqgxcUGJa8aN
	3LQU1jIEsyVlpUJQJ5QUspbNWlxFYIy1SGSk2LFRMxjbKtOhDgFTYQQYyaRs0NLaG2Pcl5Pf
	Oc/znJwPh8OaOL2Vk40VksmoM2gZFVEdeNW6a1/VM/KLQ50F8EtNkEB0tZ5A2/luBup9p2i4
	2dOFYDpaj+BBzIXBNpAksGkPsbC6/jsLyUAIQUvYjqG7r4aCv3sTDCxevo/AMRthoHWhhsCK
	9zMEzjkXCwsje2F5epCG5NQ8BbfXlhB4IwkKIsE6BJstevjS42cgNn4DQ6vjJoKvZqcw3O1N
	iX2hPxAEOk4w8FfjdxgmIulwK7rCwFXHpwwsh9souNfLgPtEgIbTLjsCa/t5BlpO+wgMzFxk
	IbwYp+BOi52CLt9+mPbOERhr9FCp+1KuC1vA1WqlUuUuBY5zgxSseztZuNZ+h4DXkg2u8Qka
	/uxwshCfzYOkuwxCXfMsTH3hINCzfIN+3YHEB7aTROz091Oi7adNRuw+043E2IYdiatnrVi0
	Nabay0srWKz1fySeHVtixI3oz4wYWHMTcdQjiE3ju8QB5xQr1g79xr65p1BVUCwZ5ErJ9MJr
	h1Ql8Q03Kfdtq2q/7aQsqDazAXGcwL8kXKs93oDSOMJnC2MNFxmFGf55YXJyHSuWDD5HWOrL
	b0AqDvOeLOHc6CVa8TzJG4S1Kz2swmoehMS3HUgxafhBJNz65AL9r/CEcPVUhCiM+Z3CZGKB
	UpZiPkv4JsEp47TUCb966rDCT/E7hGD/j1QjUjsfSTsfSTv/T7sR7kQZsrGyVCcbduea9SXV
	Rrkq93BZqQ+lftJ7PN70PVqd2DuMeA5pH1cfDG2XNbSu0lxdOowEDmsz1NlvbJM16mJd9ceS
	qewD01GDZB5GWRzRblHve1c6pOE/1FVIekkql0z/qRSXttWCrhx772hBRWHmyz35+R7LTPMr
	6Q99b0dzFv30wPD8Y+k1Ujhel/t+buERlz6WbWwK0qEiOJPjj+lHdrxT2mxJPHvP5ZH3+0bn
	8GDeTODwyeofirZfPxI8WJ9sO0bfL+6zft1sGhop6Ch/eo9Fbb1kux7+fPfD/oTkKyKxt57L
	PKAl5hJd3k5sMuv+AScIleSPAwAA
X-CFilter-Loop: Reflected

On Wed, Nov 19, 2025 at 02:37:17PM +0000, Matthew Wilcox wrote:
> On Wed, Nov 19, 2025 at 07:53:12PM +0900, Byungchul Park wrote:
> > On Thu, Oct 02, 2025 at 05:12:44PM +0900, Byungchul Park wrote:
> > > False positive reports have been observed since dept works with the
> > > assumption that all the pages have the same dept class, but the class
> > > should be split since the problematic call paths are different depending
> > > on what the page is used for.
> > >
> > > At least, ones in block device's address_space and ones in regular
> > > file's address_space have exclusively different usages.
> > >
> > > Thus, define usage candidates like:
> > >
> > >    DEPT_PAGE_REGFILE_CACHE /* page in regular file's address_space */
> > >    DEPT_PAGE_BDEV_CACHE    /* page in block device's address_space */
> > >    DEPT_PAGE_DEFAULT       /* the others */
> >
> > 1. I'd like to annotate a page to DEPT_PAGE_REGFILE_CACHE when the page
> >    starts to be associated with a page cache for fs data.
> >
> > 2. And I'd like to annotate a page to DEPT_PAGE_BDEV_CACHE when the page
> >    starts to be associated with meta data of fs e.g. super block.
> >
> > 3. Lastly, I'd like to reset the annotated value if any, that has been
> >    set in the page, when the page ends the assoication with either page
> >    cache or meta block of fs e.g. freeing the page.
> >
> > Can anyone suggest good places in code for the annotation 1, 2, 3?  It'd
> > be totally appreciated. :-)
> 
> I don't think it makes sense to track lock state in the page (nor
> folio).  Partly bcause there's just so many of them, but also because
> the locking rules don't really apply to individual folios so much as
> they do to the mappings (or anon_vmas) that contain folios.

Thank you for the suggestion!

Since two folios associated to different mappings might appear in the
same callpath that usually be classified to a single class, I need to
think how to reflect the suggestion.

I guess you wanted to tell me a folio can only be associated to a single
mapping at once.  Right?  If so, sure, I should reflect it.

> If you're looking to find deadlock scenarios, I think it makes more
> sense to track all folio locks in a given mapping as the same lock
> type rather than track each folio's lock status.
> 
> For example, let's suppose we did something like this in the
> page fault path:
> 
> Look up and lock a folio (we need folios locked to insert them into
> the page tables to avoid a race with truncate)
> Try to allocate a page table
> Go into reclaim, attempt to reclaim a folio from this mapping
> 
> We ought to detect that as a potential deadlock, regardless of which
> folio in the mapping we attempt to reclaim.  So can we track folio

Did you mean 'regardless' for 'potential' detection, right?

> locking at the mapping/anon_vma level instead?

Piece of cake.  Even though it may increase the number of DEPT classes,
I hope it will be okay.  I just need to know the points in code where
folios start/end being associated to their specific mappings.

	Byungchul

> ---
> 
> My current understanding of folio locking rules:
> 
> If you hold a lock on folio A, you can take a lock on folio B if:
> 
> 1. A->mapping == B->mapping and A->index < B->index
>    (for example writeback; we take locks on all folios to be written
>     back in order)
> 2. !S_ISBLK(A->mapping->host) and S_ISBLK(B->mapping->host)
> 3. S_ISREG(A->mapping->host) and S_ISREG(B->mapping->host) with
>    inode_lock() held on both and A->index < B->index
>    (the remap_range code)

