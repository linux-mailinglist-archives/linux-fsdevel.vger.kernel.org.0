Return-Path: <linux-fsdevel+bounces-69643-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7A0AC7F97F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Nov 2025 10:24:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEAA03A6EBD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Nov 2025 09:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D7892F60C1;
	Mon, 24 Nov 2025 09:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GFCQiqYK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F1B2F362C;
	Mon, 24 Nov 2025 09:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763975995; cv=none; b=pylL2ougsMyApxbJNoCNSCn9xwqFikN09xvlJYOYU4oYcP67swYFD5gFHc+yFLIEcKsafQe95NBPQvmKQsAtg2yPV3Xq5RRMDsNCB6KVmJkIWTrpnRw6j+kkEd3OIh+N866xAVW0xC/p0yvyGDltJRJviCjkoXqBe43g6A8xtMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763975995; c=relaxed/simple;
	bh=Uwsm69iJr36s6Dx79ksuQKNJ6J1krQHDg+amvtrWEWc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hQB/4QJaNArj7fr7klFHNhFXi32lreRq4MpJh3POBIjLbDVdC1nD3qABqz7WtSBfRYXFhGe2RjUCJS6is5HnOX2wmVTrDl+aDtb2PJmlpjrBYi9P/CPuDU1Cz1UR4TsZViHFR2MAvdkrgwCLleNxPQVJaJmLWoXSPVBFIoUn2iM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GFCQiqYK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96C39C19421;
	Mon, 24 Nov 2025 09:19:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763975995;
	bh=Uwsm69iJr36s6Dx79ksuQKNJ6J1krQHDg+amvtrWEWc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=GFCQiqYKon870o58vf/NYMJtPCbHtRI8ZICYKlyCfE81df7+gpBmxPj3EbeLSHO1X
	 1UvuSAoCl4U9xj6Jbr0HAdBbzo9o9t5GQOecPxtK3wA4xyMC4Ic2KM0oHSVCP64Y1D
	 SnlgxQcsPs0hTQcZV+GXo3/yHD5qNM1blQylkWVXWWjJUb6SwjTit+ANBY3Xiano1w
	 q3NY53RNpfjN5zI+iWgsCLWFCKSxdmkDazDpCnd4Vs9x9uuXIPFaTtWnsNyfBXhlMV
	 /r/Hldd8z7RlyZYsGRfELm50EShpyk1YO43/5Ie0fuREjfPoTOGwbFJtvub2RdD06r
	 WHP6KFE7wH66w==
Message-ID: <de15aca2-a27c-4a9b-b2bf-3f132990cd98@kernel.org>
Date: Mon, 24 Nov 2025 10:19:37 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC LPC2026 PATCH v2 00/11] Specific Purpose Memory NUMA Nodes
To: Gregory Price <gourry@gourry.net>, linux-mm@kvack.org
Cc: kernel-team@meta.com, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, cgroups@vger.kernel.org, dave@stgolabs.net,
 jonathan.cameron@huawei.com, dave.jiang@intel.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com,
 dan.j.williams@intel.com, longman@redhat.com, akpm@linux-foundation.org,
 lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
 rppt@kernel.org, surenb@google.com, mhocko@suse.com, osalvador@suse.de,
 ziy@nvidia.com, matthew.brost@intel.com, joshua.hahnjy@gmail.com,
 rakie.kim@sk.com, byungchul@sk.com, ying.huang@linux.alibaba.com,
 apopple@nvidia.com, mingo@redhat.com, peterz@infradead.org,
 juri.lelli@redhat.com, vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
 rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
 vschneid@redhat.com, tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com,
 kees@kernel.org, muchun.song@linux.dev, roman.gushchin@linux.dev,
 shakeel.butt@linux.dev, rientjes@google.com, jackmanb@google.com,
 cl@gentwo.org, harry.yoo@oracle.com, axelrasmussen@google.com,
 yuanchu@google.com, weixugc@google.com, zhengqi.arch@bytedance.com,
 yosry.ahmed@linux.dev, nphamcs@gmail.com, chengming.zhou@linux.dev,
 fabio.m.de.francesco@linux.intel.com, rrichter@amd.com,
 ming.li@zohomail.com, usamaarif642@gmail.com, brauner@kernel.org,
 oleg@redhat.com, namcao@linutronix.de, escape@linux.alibaba.com,
 dongjoo.seo1@samsung.com
References: <20251112192936.2574429-1-gourry@gourry.net>
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
In-Reply-To: <20251112192936.2574429-1-gourry@gourry.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

[...]

> 2) The addition of `cpuset.mems.sysram` which restricts allocations to
>     `mt_sysram_nodes` unless GFP_SPM_NODE is used.
> 
>     SPM Nodes are still allowed in cpuset.mems.allowed and effective.
> 
>     This is done to allow separate control over sysram and SPM node sets
>     by cgroups while maintaining the existing hierarchical rules.
> 
>     current cpuset configuration
>     cpuset.mems_allowed
>      |.mems_effective         < (mems_allowed ∩ parent.mems_effective)
>      |->tasks.mems_allowed    < cpuset.mems_effective
> 
>     new cpuset configuration
>     cpuset.mems_allowed
>      |.mems_effective         < (mems_allowed ∩ parent.mems_effective)
>      |.sysram_nodes           < (mems_effective ∩ default_sys_nodemask)
>      |->task.sysram_nodes     < cpuset.sysram_nodes
> 
>     This means mems_allowed still restricts all node usage in any given
>     task context, which is the existing behavior.
> 
> 3) Addition of MHP_SPM_NODE flag to instruct memory_hotplug.c that the
>     capacity being added should mark the node as an SPM Node.

Sounds a bit like the wrong interface for configuring this. This smells 
like a per-node setting that should be configured before hotplugging any 
memory.

> 
>     A node is either SysRAM or SPM - never both.  Attempting to add
>     incompatible memory to a node results in hotplug failure.
> 
>     DAX and CXL are made aware of the bit and have `spm_node` bits added
>     to their relevant subsystems.
> 
> 4) Adding GFP_SPM_NODE - which allows page_alloc.c to request memory
>     from the provided node or nodemask.  It changes the behavior of
>     the cpuset mems_allowed and mt_node_allowed() checks.

I wonder why that is required. Couldn't we disallow allocation from one 
of these special nodes as default, and only allow it if someone 
explicitly passes in the node for allocation?

What's the problem with that?

-- 
Cheers

David

