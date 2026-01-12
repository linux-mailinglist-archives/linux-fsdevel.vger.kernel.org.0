Return-Path: <linux-fsdevel+bounces-73240-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 60990D134EB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 15:51:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 97E3A31180B1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 14:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C78E2BE026;
	Mon, 12 Jan 2026 14:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="ISRw3eQ3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EE1D278779
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 Jan 2026 14:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768228646; cv=none; b=nQ+FaywtK0HDlJrgyU3bThyPYp7RuVjKWAETa3vPSkjAfLyIqOhLKoa5VkZaKKn8m3pFK2mveYs8sILhZ6X6j2zQn6LSQd0V+UXKMNHAJyE2NV3IqklknzLt/Ywqfsdy9DkNCBKlRdWlUQTvh+kaIPbw33Uin/h9hzpSraH4qvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768228646; c=relaxed/simple;
	bh=DilEPTneOmTFbMyNlkIpsLNco3ZjJfus4tGIlOTsazM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aYZs4qMBWXRUvZ82VDvDOkx38o17Sa06FVMmurMgPALCRj8AMtK+W2Thydc2xWhQ/AbNttMT6tZ5LlFDoN2k1emI7TDYM9jjn6MP9I/54liH+SecB0J2mjybtUWbo3BfT/+kKD7VAZrxPKkLa9P1JWsVPzZ6Fe6kwtOJiNWVFGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=ISRw3eQ3; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4ffc0ddefc4so70363251cf.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Jan 2026 06:37:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1768228644; x=1768833444; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ePKfg8r3UOwlhimXXZYjI2/ALy+81ziytf6AS2OBizc=;
        b=ISRw3eQ3UlqQJ6eojBXBtqdMeRuhkZcik8a5bltrBSi+NIptCh85LNFDrrUSkHB1Ws
         ZFgSV9TXN4Baz4LXmP5pJc5qPPKpMs4AjhKKnrv/hyVkaI/SdkA1LdNwNjfyeopI2qT+
         H9XMbdixv+uakcB3CUimLSqe+ervS3aggpYVOGHwhP1g6BqnRNKw/aULp8IyRHUzYIBy
         2Pq4CSfB9p0byEBAp4N6Digiads7AeGvyREv8fGkx29wZUxhlQbazvMnWyPh4o+S0dW0
         /Wzjf6UXd2stSmytAG/5KwaLMAMyI02HkGzgZ4shDYc3XhETH8NyvNpNvhpq30+4Io5w
         v4CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768228644; x=1768833444;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ePKfg8r3UOwlhimXXZYjI2/ALy+81ziytf6AS2OBizc=;
        b=Ju3sGf5Z4wPwYYMSMJwWrlBlUd7c3PTp63wSVIZ5K6cLAdLLfTfTxSHux0FrqmkPej
         NY/zXNqPomdsdkkm+gRfRxAfGx5W1IHl4AN1Rr0l5LirxY7/umPNpQN+LLPJtKNMbTkr
         mpYtwuk3tGFwWH+9affFq7fhg9usq3hYTR5O6WIsI40I+oNjCWEK4aaWbe7Zeehw6akZ
         1zO8O14hUSLGSB4XRl4HQcV7vY8dKDQcNRQbhDWxd2XdILofMvWXpaXehoxprL26sK1y
         NHsBu5d5iDbsMMXgG9XiltMC1lkr4Di8Rl0+we4EJPO+07vFGn3DFMyNAqqbmBUKUJQv
         2ykw==
X-Forwarded-Encrypted: i=1; AJvYcCV8bCD/BcDMsMA9FFIicDAynUVW7GPinchts+6clgtC/TaA9coTI6GaFpB5rAUZ053Bm6zakynMabZQ9xQb@vger.kernel.org
X-Gm-Message-State: AOJu0Yzq/VcEWO/P9G/WGqF6AezPmINcBJkeVn14wkpiOGgDWYWdZvMQ
	DqXcPlrp0G48rWHXz/7Irve0kcbz+VO4tmz0yI6iS7f+u8xwiI/19xZ/CxqhnuxCWPE=
X-Gm-Gg: AY/fxX7oaGet+wZJE17E9oft6IkRWxELfZplijTzIHnwwSVHOhbaRbaw/rmHjp+Lqy+
	nAr63F6EYQHNTo4tXEg5I0qVs94NyxOTXGg/d98OX7ELtt5+dX6HR+opfPc6TZTulHyqSttApGR
	484qkr/ofHopFQrdxZba7kl+1ieMmGEptLE6Po7S5W02kXuXAJbjD+XRffDD+ZedwxE4DXhUfHw
	44NVfF4ZnV/AmH2ZF2hzss68y9qsxDvDVuFlHEpuH6NjQ8xBCOFM8d4gOrutJFbF2E80cJIG9zG
	uOhrBVbELwLCSgSrRCrkVkOW/RsbNlGasAkD4N3HmdMREhLUd/UVl1Xe5KeTz08t8Rs5WNn9I9A
	EMPXkrfP0SrKgtrcHMV3WlGJ3hkMw71pheAbE+7xXXnt4S8js+ZcXD5H1tno5efj4jRa9K41GP4
	4ULKhEvRD61zuyuw7ldzqTV2z4QusWxGAYKUFKW4dNHYNmPER5yz3FyKMVjmpKz6igLUtKQQ==
X-Google-Smtp-Source: AGHT+IHXS0x+KAi7JkxeJVuKKA6eSdMX4OQRz9CBqWxcGn/3UsudeSIPdlLgVjLY1N5m+ySFWtfoOg==
X-Received: by 2002:ac8:5a04:0:b0:4f4:d926:d64b with SMTP id d75a77b69052e-4ffb497b9d1mr281980781cf.48.1768228643971;
        Mon, 12 Jan 2026 06:37:23 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ffa8e3629dsm125755621cf.18.2026.01.12.06.37.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 06:37:23 -0800 (PST)
Date: Mon, 12 Jan 2026 09:36:49 -0500
From: Gregory Price <gourry@gourry.net>
To: Balbir Singh <balbirs@nvidia.com>
Cc: linux-mm@kvack.org, cgroups@vger.kernel.org, linux-cxl@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, kernel-team@meta.com,
	longman@redhat.com, tj@kernel.org, hannes@cmpxchg.org,
	mkoutny@suse.com, corbet@lwn.net, gregkh@linuxfoundation.org,
	rafael@kernel.org, dakr@kernel.org, dave@stgolabs.net,
	jonathan.cameron@huawei.com, dave.jiang@intel.com,
	alison.schofield@intel.com, vishal.l.verma@intel.com,
	ira.weiny@intel.com, dan.j.williams@intel.com,
	akpm@linux-foundation.org, vbabka@suse.cz, surenb@google.com,
	mhocko@suse.com, jackmanb@google.com, ziy@nvidia.com,
	david@kernel.org, lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com, rppt@kernel.org, axelrasmussen@google.com,
	yuanchu@google.com, weixugc@google.com, yury.norov@gmail.com,
	linux@rasmusvillemoes.dk, rientjes@google.com,
	shakeel.butt@linux.dev, chrisl@kernel.org, kasong@tencent.com,
	shikemeng@huaweicloud.com, nphamcs@gmail.com, bhe@redhat.com,
	baohua@kernel.org, yosry.ahmed@linux.dev, chengming.zhou@linux.dev,
	roman.gushchin@linux.dev, muchun.song@linux.dev, osalvador@suse.de,
	matthew.brost@intel.com, joshua.hahnjy@gmail.com, rakie.kim@sk.com,
	byungchul@sk.com, ying.huang@linux.alibaba.com, apopple@nvidia.com,
	cl@gentwo.org, harry.yoo@oracle.com, zhengqi.arch@bytedance.com
Subject: Re: [RFC PATCH v3 0/8] mm,numa: N_PRIVATE node isolation for
 device-managed memory
Message-ID: <aWUHAboKw28XepWr@gourry-fedora-PF4VCD3F>
References: <20260108203755.1163107-1-gourry@gourry.net>
 <6604d787-1744-4acf-80c0-e428fee1677e@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6604d787-1744-4acf-80c0-e428fee1677e@nvidia.com>

On Mon, Jan 12, 2026 at 10:12:23PM +1100, Balbir Singh wrote:
> On 1/9/26 06:37, Gregory Price wrote:
> > This series introduces N_PRIVATE, a new node state for memory nodes 
> > whose memory is not intended for general system consumption.  Today,
> > device drivers (CXL, accelerators, etc.) hotplug their memory to access
> > mm/ services like page allocation and reclaim, but this exposes general
> > workloads to memory with different characteristics and reliability
> > guarantees than system RAM.
> > 
> > N_PRIVATE provides isolation by default while enabling explicit access
> > via __GFP_THISNODE for subsystems that understand how to manage these
> > specialized memory regions.
> > 
> 
> I assume each class of N_PRIVATE is a separate set of NUMA nodes, these
> could be real or virtual memory nodes?
>

This has the the topic of a long, long discussion on the CXL discord -
how do we get extra nodes if we intend to make HPA space flexibly
configurable by "intended use".

tl;dr:  open to discussion.  As of right now, there's no way (that I
know of) to allocate additional NUMA nodes at boot without having some
indication that one is needed in the ACPI table (srat touches a PXM, or
CEDT defines a region not present in SRAT).

Best idea we have right now is to have a build config that reserves some
extra nodes which can be used later (they're in N_POSSIBLE but otherwise
not used by anything).

> > Design
> > ======
> > 
> > The series introduces:
> > 
> >   1. N_PRIVATE node state (mutually exclusive with N_MEMORY)
> 
> We should call it N_PRIVATE_MEMORY
>

Dan Williams convinced me to go with N_PRIVATE, but this is really a
bikeshed topic - we could call it N_BOBERT until we find consensus.

> > 
> >   enum private_memtype {
> >       NODE_MEM_NOTYPE,      /* No type assigned (invalid state) */
> >       NODE_MEM_ZSWAP,       /* Swap compression target */
> >       NODE_MEM_COMPRESSED,  /* General compressed RAM */
> >       NODE_MEM_ACCELERATOR, /* Accelerator-attached memory */
> >       NODE_MEM_DEMOTE_ONLY, /* Memory-tier demotion target only */
> >       NODE_MAX_MEMTYPE,
> >   };
> > 
> > These types serve as policy hints for subsystems:
> > 
> 
> Do these nodes have fallback(s)? Are these nodes prone to OOM when memory is exhausted
> in one class of N_PRIVATE node(s)?
> 

Right now, these nodes do not have fallbacks, and even if they did the
use of __GFP_THISNODE would prevent this.  That's intended.

In theory you could have nodes of similar types fall back to each other,
but that feels like increased complexity for questionable value.  The
service requested __GFP_THISNODE should be aware that it needs to manage
fallback.

> 
> What about page cache allocation form these nodes? Since default allocations
> never use them, a file system would need to do additional work to allocate
> on them, if there was ever a desire to use them. 

Yes, in-fact that is the intent.  Anything requesting memory from these
nodes would need to be aware of how to manage them.

Similar to ZONE_DEVICE memory - which is wholly unmanaged by the page
allocator.  There's potential for re-using some of the ZONE_DEVICE or
HMM callback infrastructure to implement the callbacks for N_PRIVATE
instead of re-inventing it.

> Would memory
> migration would work between N_PRIVATE and N_MEMORY using move_pages()?
> 

N_PRIVATE -> N_MEMORY would probably be easy and trivial, but could also
be a controllable bit.

A side-discussion not present in these notes has been whether memtype
should be an enum or a bitfield.

N_MEMORY -> N_PRIVATE via migrate.c would probably require some changes
to migration_target_control and the alloc callback (in vmscan.c, see
alloc_migrate_folio) would need to be N_PRIVATE aware.


Thanks for taking a look,
~Gregory

