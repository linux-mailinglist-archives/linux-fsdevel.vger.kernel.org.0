Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAF32355078
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Apr 2021 12:05:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241408AbhDFKFd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Apr 2021 06:05:33 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42478 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240979AbhDFKFd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Apr 2021 06:05:33 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 136A4bLg079159;
        Tue, 6 Apr 2021 06:05:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : reply-to : references : mime-version : content-type
 : in-reply-to; s=pp1; bh=+ZfHBXPQ8eP2kF5pGgf8pvqbQp9Jh8p52njku2OHvv8=;
 b=H8Mi/xl/Vb8+r2UUCElEWopvkQSmZoUGzDgudXy9q/hfUhuLJ+RdkPvJ6rEFrzG9ygEk
 MeZuMDJLRtEkER56QHmqxDi65AwtlJFeso/r7Qx0MWXMZN88FcRb6SQDfzdrCORwsZyK
 cAywhdIHkUK+91PErF5G8Hy5cwX+xYEt3uH2uY9IHX5ULwCdbGAfHhuxcPigaHD2oMSD
 biER2AhaKUG6YUsraiwyIk7OMLhghosn1ZD7tY+FURcPC5V/AR/36ELcb8geUSP4YXZJ
 xjF/el54dXHIbZmb6aZHBYNZpljyx5z9ttuE7/9Hk3EHlC8S3us381DJOFNeJlCzGXSL Zg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37q5dv5cjv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Apr 2021 06:05:21 -0400
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 136A556Y080453;
        Tue, 6 Apr 2021 06:05:19 -0400
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37q5dv5cht-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Apr 2021 06:05:18 -0400
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 136A1tFK003166;
        Tue, 6 Apr 2021 10:05:16 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma06fra.de.ibm.com with ESMTP id 37q3cf12b7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Apr 2021 10:05:16 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 136A5DaJ21692832
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 6 Apr 2021 10:05:13 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CF44411C066;
        Tue,  6 Apr 2021 10:05:13 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0AFD511C050;
        Tue,  6 Apr 2021 10:05:12 +0000 (GMT)
Received: from in.ibm.com (unknown [9.102.27.68])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue,  6 Apr 2021 10:05:11 +0000 (GMT)
Date:   Tue, 6 Apr 2021 15:35:09 +0530
From:   Bharata B Rao <bharata@linux.ibm.com>
To:     Yang Shi <shy828301@gmail.com>
Cc:     Kirill Tkhai <ktkhai@virtuozzo.com>, Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        aneesh.kumar@linux.ibm.com
Subject: Re: High kmalloc-32 slab cache consumption with 10k containers
Message-ID: <20210406100509.GA1354243@in.ibm.com>
Reply-To: bharata@linux.ibm.com
References: <20210405054848.GA1077931@in.ibm.com>
 <CAHbLzko-17bUWdxmOi-p2_MLSbsMCvhjKS1ktnBysC5dN_W90A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHbLzko-17bUWdxmOi-p2_MLSbsMCvhjKS1ktnBysC5dN_W90A@mail.gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: yMs0uwOTLyFEHBrzOUU3EdEX4ZoAYPQe
X-Proofpoint-ORIG-GUID: z7uIG8nzW1HuGuxbN4yZImD4h_UjY-ta
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-04-06_02:2021-04-01,2021-04-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 mlxlogscore=999 spamscore=0 lowpriorityscore=0 adultscore=0 phishscore=0
 impostorscore=0 suspectscore=0 clxscore=1011 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104030000
 definitions=main-2104060067
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 05, 2021 at 11:08:26AM -0700, Yang Shi wrote:
> On Sun, Apr 4, 2021 at 10:49 PM Bharata B Rao <bharata@linux.ibm.com> wrote:
> >
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
> 
> Yes, this is exactly what the current implementation does.
> 
> >
> > Following factors contribute to the excessive allocations:
> >
> > - Lists are created for possible NUMA nodes.
> 
> Yes, because filesystem caches (dentry and inode) are NUMA aware.

True, but creating lists for possible nodes as against online nodes
can hurt platforms where possible is typically higher than online.

> 
> > - memcg_nr_cache_ids grows in bulk (see memcg_alloc_cache_id() and additional
> >   list_lrus are created when it grows. Thus we end up creating list_lru_one
> >   list_heads even for those memcgs which are yet to be created.
> >   For example, when 10000 memcgs are created, memcg_nr_cache_ids reach
> >   a value of 12286.
> > - When a memcg goes offline, the list elements are drained to the parent
> >   memcg, but the list_head entry remains.
> > - The lists are destroyed only when the FS is unmounted. So list_heads
> >   for non-existing memcgs remain and continue to contribute to the
> >   kmalloc-32 allocation. This is presumably done for performance
> >   reason as they get reused when new memcgs are created, but they end up
> >   consuming slab memory until then.
> 
> The current implementation has list_lrus attached with super_block. So
> the list can't be freed until the super block is unmounted.
> 
> I'm looking into consolidating list_lrus more closely with memcgs. It
> means the list_lrus will have the same life cycles as memcgs rather
> than filesystems. This may be able to improve some. But I'm supposed
> the filesystem will be unmounted once the container exits and the
> memcgs will get offlined for your usecase.

Yes, but when the containers are still running, the lists that get
created for non-existing memcgs and non-relavent memcgs are the main
cause of increased memory consumption.

> 
> > - In case of containers, a few file systems get mounted and are specific
> >   to the container namespace and hence to a particular memcg, but we
> >   end up creating lists for all the memcgs.
> 
> Yes, because the kernel is *NOT* aware of containers.
> 
> >   As an example, if 7 FS mounts are done for every container and when
> >   10k containers are created, we end up creating 2*7*12286 list_lru_one
> >   lists for each NUMA node. It appears that no elements will get added
> >   to other than 2*7=14 of them in the case of containers.
> >
> > One straight forward way to prevent this excessive list_lru_one
> > allocations is to limit the list_lru_one creation only to the
> > relevant memcg. However I don't see an easy way to figure out
> > that relevant memcg from FS mount path (alloc_super())
> >
> > As an alternative approach, I have this below hack that does lazy
> > list_lru creation. The memcg-specific list is created and initialized
> > only when there is a request to add an element to that particular
> > list. Though I am not sure about the full impact of this change
> > on the owners of the lists and also the performance impact of this,
> > the overall savings look good.
> 
> It is fine to reduce the memory consumption for your usecase, but I'm
> not sure if this would incur any noticeable overhead for vfs
> operations since list_lru_add() should be called quite often, but it
> just needs to allocate the list for once (for each memcg +
> filesystem), so the overhead might be fine.

Let me run some benchmarks to measure the overhead. Any particular
benchmark suggestion?
 
> 
> And I'm wondering how much memory can be saved for real life workload.
> I don't expect most containers are idle in production environments.

I don't think kmalloc-32 slab cache memory consumption from list_lru
would be any different for real life workload compared to idle containers.

> 
> Added some more memcg/list_lru experts in this loop, they may have better ideas.

Thanks.

Regards,
Bharata.
