Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22A4A356B84
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Apr 2021 13:47:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351905AbhDGLrr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Apr 2021 07:47:47 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53890 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234728AbhDGLrr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Apr 2021 07:47:47 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 137BYXU1179695;
        Wed, 7 Apr 2021 07:47:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : reply-to : references : mime-version : content-type
 : in-reply-to; s=pp1; bh=kYzAsOk2ynDum0To7DEp6vjW2m9P2reJHZpRQVDhpfs=;
 b=P36F5kJvCTzg9uwUZJ610xL31K1O2ypTLOop6SKV0sViTrT9y8gAxGanr/Yf5AiHYZ1/
 BAgn0knDAZHme6l3x46kADfhhrMxmqjJlBfN0Ty/x/baW1E2ELKfS9iR5qMQMQPLM+ze
 m//s7+zinAPKihAtG4o1/o1a0gus60jjxxC6Y9Se/wNeEsT+U77O8a9oyURivb3WfWKg
 opMDC+D6VdEvJapw8AMg/q2tdo/rwe5i67S8FRZDJV1RSbk3p4LE9L7GZB52AOBKFKKt
 FwC0Ob4bcz311sj+QBKggmGSKzpVs4Is/q1sQyivIy/BmALiSXOGMcvBzWRyizmNKcPA UA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37s9fmd23d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Apr 2021 07:47:32 -0400
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 137Ba3a8190055;
        Wed, 7 Apr 2021 07:47:32 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37s9fmd22p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Apr 2021 07:47:32 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 137Bhle6023605;
        Wed, 7 Apr 2021 11:47:29 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma04ams.nl.ibm.com with ESMTP id 37rvbu8nyv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Apr 2021 11:47:29 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 137BlRDV23527786
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 7 Apr 2021 11:47:27 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4ED19AE058;
        Wed,  7 Apr 2021 11:47:27 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8A2B3AE051;
        Wed,  7 Apr 2021 11:47:25 +0000 (GMT)
Received: from in.ibm.com (unknown [9.199.44.82])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed,  7 Apr 2021 11:47:25 +0000 (GMT)
Date:   Wed, 7 Apr 2021 17:17:23 +0530
From:   Bharata B Rao <bharata@linux.ibm.com>
To:     Kirill Tkhai <ktkhai@virtuozzo.com>
Cc:     Dave Chinner <david@fromorbit.com>, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, aneesh.kumar@linux.ibm.com,
        Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: High kmalloc-32 slab cache consumption with 10k containers
Message-ID: <20210407114723.GD1354243@in.ibm.com>
Reply-To: bharata@linux.ibm.com
References: <20210405054848.GA1077931@in.ibm.com>
 <20210406222807.GD1990290@dread.disaster.area>
 <20210407050541.GC1354243@in.ibm.com>
 <c9bd1744-f15c-669a-b3a9-5a0c47bd4e1d@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c9bd1744-f15c-669a-b3a9-5a0c47bd4e1d@virtuozzo.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 3qAzuBCxVDP89FeleJ_iZWvOll0QR6yR
X-Proofpoint-GUID: bXt5-x0dTqMWZF6WRNEvWsgxGyonOZfp
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-04-07_07:2021-04-06,2021-04-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 adultscore=0 clxscore=1015 phishscore=0 priorityscore=1501 bulkscore=0
 malwarescore=0 spamscore=0 suspectscore=0 lowpriorityscore=0
 mlxlogscore=912 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104070080
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 07, 2021 at 01:07:27PM +0300, Kirill Tkhai wrote:
> > Here is how the calculation turns out to be in my setup:
> > 
> > Number of possible NUMA nodes = 2
> > Number of mounts per container = 7 (Check below to see which are these)
> > Number of list creation requests per mount = 2
> > Number of containers = 10000
> > memcg_nr_cache_ids for 10k containers = 12286
> 
> Luckily, we have "+1" in memcg_nr_cache_ids formula: size = 2 * (id + 1).
> In case of we only multiplied it, you would have to had memcg_nr_cache_ids=20000.

Not really, it would grow like this for size = 2 * id

id 0 size 4
id 4 size 8
id 8 size 16
id 16 size 32
id 32 size 64
id 64 size 128
id 128 size 256
id 256 size 512
id 512 size 1024
id 1024 size 2048
id 2048 size 4096
id 4096 size 8192
id 8192 size 16384

Currently (size = 2 * (id + 1)), it grows like this:

id 0 size 4
id 4 size 10
id 10 size 22
id 22 size 46
id 46 size 94
id 94 size 190
id 190 size 382
id 382 size 766
id 766 size 1534
id 1534 size 3070
id 3070 size 6142
id 6142 size 12286

> 
> Maybe, we need change that formula to increase memcg_nr_cache_ids more accurate
> for further growths of containers number. Say,
> 
> size = id < 2000 ? 2 * (id + 1) : id + 2000

For the above, it would only be marginally better like this:

id 0 size 4
id 4 size 10
id 10 size 22
id 22 size 46
id 46 size 94
id 94 size 190
id 190 size 382
id 382 size 766
id 766 size 1534
id 1534 size 3070
id 3070 size 5070
id 5070 size 7070
id 7070 size 9070
id 9070 size 11070

All the above numbers are for 10k memcgs.

Regards,
Bharata.
