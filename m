Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C48F3562D6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Apr 2021 07:05:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348564AbhDGFGG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Apr 2021 01:06:06 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:5946 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1348549AbhDGFGF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Apr 2021 01:06:05 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 137551xe114656;
        Wed, 7 Apr 2021 01:05:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : reply-to : references : mime-version : content-type
 : in-reply-to; s=pp1; bh=OrgRZHYFZlChniisF6iTR17eINZ7lHWP98Ma2bfNQQU=;
 b=Yko7Gdhf+pVXGuE7M0Hdf5OyVAIW94zmjy/eIkeqitSihu9Ni3vV2wmo2eozEK23Pbem
 Y3ODj/Sv8qXvqGWSUvDZR6KPXfExFESXB1AyZhzClEXXfNEOnUKFvKSoMY0oGa7WPAKQ
 wm1/YhgByqQ8OMiRhNVi0EAo6mGlYQwdt1kR887JrVp4NKtIr+EJcIA1YsMu4eNWalDz
 twsXGEEw2QxFOnjbAFlLFUfhvF/0F2sSRhnX0+gW/Nj8VjYpCa2h+h+z/4N57hxpe+y3
 xbWNY8URYioaFKzDfrMCgFuVFPf1QdAkWftddo8SpaUYsLHFBHlP2pyvKnzeATD/CJpk xQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37rvpu4k6c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Apr 2021 01:05:51 -0400
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 137558Mb115501;
        Wed, 7 Apr 2021 01:05:51 -0400
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37rvpu4k5j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Apr 2021 01:05:51 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 1374vUbn024469;
        Wed, 7 Apr 2021 05:05:48 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma03fra.de.ibm.com with ESMTP id 37rvc1g67k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Apr 2021 05:05:48 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 13755kYb50200914
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 7 Apr 2021 05:05:46 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 11BAB42041;
        Wed,  7 Apr 2021 05:05:46 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3F3DC4203F;
        Wed,  7 Apr 2021 05:05:44 +0000 (GMT)
Received: from in.ibm.com (unknown [9.199.44.82])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed,  7 Apr 2021 05:05:44 +0000 (GMT)
Date:   Wed, 7 Apr 2021 10:35:41 +0530
From:   Bharata B Rao <bharata@linux.ibm.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        aneesh.kumar@linux.ibm.com, Kirill Tkhai <ktkhai@virtuozzo.com>,
        Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: High kmalloc-32 slab cache consumption with 10k containers
Message-ID: <20210407050541.GC1354243@in.ibm.com>
Reply-To: bharata@linux.ibm.com
References: <20210405054848.GA1077931@in.ibm.com>
 <20210406222807.GD1990290@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210406222807.GD1990290@dread.disaster.area>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: woqPOb8qaDZoSLmYEivOPUJqjy5xok68
X-Proofpoint-GUID: xAWX7i3K7F7e9phEpfWL3SIzatQq0l9_
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-04-07_03:2021-04-06,2021-04-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 clxscore=1011
 priorityscore=1501 malwarescore=0 mlxlogscore=999 spamscore=0 mlxscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104070035
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 07, 2021 at 08:28:07AM +1000, Dave Chinner wrote:
> On Mon, Apr 05, 2021 at 11:18:48AM +0530, Bharata B Rao wrote:
> > Hi,
> > 
> > When running 10000 (more-or-less-empty-)containers on a bare-metal Power9
> > server(160 CPUs, 2 NUMA nodes, 256G memory), it is seen that memory
> > consumption increases quite a lot (around 172G) when the containers are
> > running. Most of it comes from slab (149G) and within slab, the majority of
> > it comes from kmalloc-32 cache (102G)
> > 
> > The major allocator of kmalloc-32 slab cache happens to be the list_head
> > allocations of list_lru_one list. These lists are created whenever a
> > FS mount happens. Specially two such lists are registered by alloc_super(),
> > one for dentry and another for inode shrinker list. And these lists
> > are created for all possible NUMA nodes and for all given memcgs
> > (memcg_nr_cache_ids to be particular)
> > 
> > If,
> > 
> > A = Nr allocation request per mount: 2 (one for dentry and inode list)
> > B = Nr NUMA possible nodes
> > C = memcg_nr_cache_ids
> > D = size of each kmalloc-32 object: 32 bytes,
> > 
> > then for every mount, the amount of memory consumed by kmalloc-32 slab
> > cache for list_lru creation is A*B*C*D bytes.
> > 
> > Following factors contribute to the excessive allocations:
> > 
> > - Lists are created for possible NUMA nodes.
> > - memcg_nr_cache_ids grows in bulk (see memcg_alloc_cache_id() and additional
> >   list_lrus are created when it grows. Thus we end up creating list_lru_one
> >   list_heads even for those memcgs which are yet to be created.
> >   For example, when 10000 memcgs are created, memcg_nr_cache_ids reach
> >   a value of 12286.
> 
> So, by your numbers, we have 2 * 2 * 12286 * 32 = 1.5MB per mount.
> 
> So for that to make up 100GB of RAM, you must have somewhere over
> 500,000 mounted superblocks on the machine?
> 
> That implies 50+ unique mounted superblocks per container, which
> seems like an awful lot.

Here is how the calculation turns out to be in my setup:

Number of possible NUMA nodes = 2
Number of mounts per container = 7 (Check below to see which are these)
Number of list creation requests per mount = 2
Number of containers = 10000
memcg_nr_cache_ids for 10k containers = 12286
size of kmalloc-32 = 32 byes

2*7*2*10000*12286*32 = 110082560000 bytes = 102.5G

> 
> > - When a memcg goes offline, the list elements are drained to the parent
> >   memcg, but the list_head entry remains.
> > - The lists are destroyed only when the FS is unmounted. So list_heads
> >   for non-existing memcgs remain and continue to contribute to the
> >   kmalloc-32 allocation. This is presumably done for performance
> >   reason as they get reused when new memcgs are created, but they end up
> >   consuming slab memory until then.
> > - In case of containers, a few file systems get mounted and are specific
> >   to the container namespace and hence to a particular memcg, but we
> >   end up creating lists for all the memcgs.
> >   As an example, if 7 FS mounts are done for every container and when
> >   10k containers are created, we end up creating 2*7*12286 list_lru_one
> >   lists for each NUMA node. It appears that no elements will get added
> >   to other than 2*7=14 of them in the case of containers.
> 
> Yeah, at first glance this doesn't strike me as a problem with the
> list_lru structure, it smells more like a problem resulting from a
> huge number of superblock instantiations on the machine. Which,
> probably, mostly have no significant need for anything other than a
> single memcg awareness?
> 
> Can you post a typical /proc/self/mounts output from one of these
> idle/empty containers so we can see exactly how many mounts and
> their type are being instantiated in each container?

Tracing type->name in alloc_super() lists these 7 types for
every container.

3-2691    [041] ....   222.761041: alloc_super: fstype: mqueue
3-2692    [072] ....   222.812187: alloc_super: fstype: proc
3-2692    [072] ....   222.812261: alloc_super: fstype: tmpfs
3-2692    [072] ....   222.812329: alloc_super: fstype: devpts
3-2692    [072] ....   222.812392: alloc_super: fstype: tmpfs
3-2692    [072] ....   222.813102: alloc_super: fstype: tmpfs
3-2692    [072] ....   222.813159: alloc_super: fstype: tmpfs

> 
> > One straight forward way to prevent this excessive list_lru_one
> > allocations is to limit the list_lru_one creation only to the
> > relevant memcg. However I don't see an easy way to figure out
> > that relevant memcg from FS mount path (alloc_super())
> 
> Superblocks have to support an unknown number of memcgs after they
> have been mounted. bind mounts, child memcgs, etc, all mean that we
> can't just have a static, single mount time memcg instantiation.
> 
> > As an alternative approach, I have this below hack that does lazy
> > list_lru creation. The memcg-specific list is created and initialized
> > only when there is a request to add an element to that particular
> > list. Though I am not sure about the full impact of this change
> > on the owners of the lists and also the performance impact of this,
> > the overall savings look good.
> 
> Avoiding memory allocation in list_lru_add() was one of the main
> reasons for up-front static allocation of memcg lists. We cannot do
> memory allocation while callers are holding multiple spinlocks in
> core system algorithms (e.g. dentry_kill -> retain_dentry ->
> d_lru_add -> list_lru_add), let alone while holding an internal
> spinlock.
> 
> Putting a GFP_ATOMIC allocation inside 3-4 nested spinlocks in a
> path we know might have memory demand in the *hundreds of GB* range
> gets an NACK from me. It's a great idea, but it's just not a
> feasible, robust solution as proposed. Work out how to put the
> memory allocation outside all the locks (including caller locks) and
> it might be ok, but that's messy.

Ok, I see the problem and it looks like hard to get allocations
outside of those locks.

> 
> Another approach may be to identify filesystem types that do not
> need memcg awareness and feed that into alloc_super() to set/clear
> the SHRINKER_MEMCG_AWARE flag. This could be based on fstype - most
> virtual filesystems that expose system information do not really
> need full memcg awareness because they are generally only visible to
> a single memcg instance...

This however seems like a feasible approach, let me check on this.

Regards,
Bharata.
