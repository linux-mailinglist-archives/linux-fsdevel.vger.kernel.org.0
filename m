Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2522E435C4A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Oct 2021 09:44:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229499AbhJUHqt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Oct 2021 03:46:49 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58300 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230385AbhJUHqt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Oct 2021 03:46:49 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19L7JnJS032012;
        Thu, 21 Oct 2021 03:44:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=uT4wjLPIFzFEl8waL4bVFZNbPI9aXaW6qIoccd8uwWI=;
 b=PCvLitr3hW5l+7lcPhGe/8CR/U6UXAwL2M1QTEvym95Tq+InQsB5zuAGQfjypEorIbeQ
 bqzhGC9crxX/i7nOwTgTWxeIppcaa9pMWuN5XK+liS2YKCQW9nXWYQRpQjOQNyNEqXIw
 JG1KDKMfYn1lgw571Zq0e8Vjow9bYTUzTlhCiE9f90LJU77DSREsyqS+6M1psCSQIb0t
 DI5Wver4FUvZX1OBHPVBESzPRsoAXBHCPLuqbb3Ote/6zvsndKITNM7LuM6v8StBM+yS
 8UGgiEiLsJFOZ/cCWgUSu2eAxsM25LXQlZcOPFsngxf4fRKtENVexxK+9ggi1zzIopr1 ZA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bu14yknmu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Oct 2021 03:44:19 -0400
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 19L7Q9Jl020050;
        Thu, 21 Oct 2021 03:44:18 -0400
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bu14yknmb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Oct 2021 03:44:18 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 19L7iCBE022910;
        Thu, 21 Oct 2021 07:44:16 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma02fra.de.ibm.com with ESMTP id 3bqpca8we7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Oct 2021 07:44:16 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 19L7iEkn56164676
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Oct 2021 07:44:14 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 026B452050;
        Thu, 21 Oct 2021 07:44:14 +0000 (GMT)
Received: from [9.43.57.91] (unknown [9.43.57.91])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 4DA1B5204F;
        Thu, 21 Oct 2021 07:44:11 +0000 (GMT)
Message-ID: <bd1811cc-0e04-9e44-0b46-02689ff9a238@linux.ibm.com>
Date:   Thu, 21 Oct 2021 13:14:10 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [RFC 0/5] kernel: Introduce CPU Namespace
Content-Language: en-US
To:     Tejun Heo <tj@kernel.org>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        bristot@redhat.com, christian@brauner.io, ebiederm@xmission.com,
        lizefan.x@bytedance.com, hannes@cmpxchg.org, mingo@kernel.org,
        juri.lelli@redhat.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, cgroups@vger.kernel.org,
        containers@lists.linux.dev, containers@lists.linux-foundation.org,
        pratik.r.sampat@gmail.com
References: <20211009151243.8825-1-psampat@linux.ibm.com>
 <20211011101124.d5mm7skqfhe5g35h@wittgenstein>
 <a0f9ed06-1e5d-d3d0-21a5-710c8e27749c@linux.ibm.com>
 <YWirxCjschoRJQ14@slm.duckdns.org>
 <b5f8505c-38d5-af6f-0de7-4f9df7ae9b9b@linux.ibm.com>
 <YW2g73Lwmrhjg/sv@slm.duckdns.org>
 <77854748-081f-46c7-df51-357ca78b83b3@linux.ibm.com>
 <YXBFVCc61nCG5rto@slm.duckdns.org>
From:   Pratik Sampat <psampat@linux.ibm.com>
In-Reply-To: <YXBFVCc61nCG5rto@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Gc_TayJknDDmKIXUNB03r6RBPa3r0NsN
X-Proofpoint-GUID: HLLSO8PhqTXa-MESQiD8vmVBt6EMpA0U
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-21_02,2021-10-20_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 clxscore=1015 spamscore=0 lowpriorityscore=0 mlxlogscore=999
 suspectscore=0 phishscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110210035
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello Tejun,


On 20/10/21 10:05 pm, Tejun Heo wrote:
> Hello,
>
> On Wed, Oct 20, 2021 at 04:14:25PM +0530, Pratik Sampat wrote:
>> As you have elucidated, it doesn't like an easy feat to
>> define metrics like ballpark numbers as there are many variables
>> involved.
> Yeah, it gets tricky and we want to get the basics right from the get go.
>
>> For the CPU example, cpusets control the resource space whereas
>> period-quota control resource time. These seem like two vectors on
>> different axes.
>> Conveying these restrictions in one metric doesn't seem easy. Some
>> container runtime convert the period-quota time dimension to X CPUs
>> worth of runtime space dimension. However, we need to carefully model
>> what a ballpark metric in this sense would be and provide clearer
>> constraints as both of these restrictions can be active at a given
>> point in time and can influence how something is run.
> So, for CPU, the important functional number is the number of threads needed
> to saturate available resources and that one is pretty easy.

I'm speculating, and please correct correct me if I'm wrong; suggesting
an optimal number of threads to spawn to saturate the available
resources can get convoluted right?

In the nginx example illustrated in the cover patch, it worked best
when the thread count was N+1 (N worker threads 1 master thread),
however different applications can work better with a different
configuration of threads spawned based on its usecase and
multi-threading requirements.

Eventually looking at the load we maybe able to suggest more/less
threads to spawn, but initially we may have to have to suggest threads
to spawn as direct function of N CPUs available or N CPUs worth of
runtime available?

> The other
> metric would be the maximum available fractions of CPUs available to the
> cgroup subtree if the cgroup stays saturating. This number is trickier as it
> has to consider how much others are using but would be determined by the
> smaller of what would be available through cpu.weight and cpu.max.

I agree, this would be a very useful metric to have. Having the
knowledge for how much further we can scale when we're saturating our
limits keeping in mind of the other running applications can possibly
be really useful not just for the applications itself but also for the
container orchestrators as well.

> IO likely is in a similar boat. We can calculate metrics showing the
> rbps/riops/wbps/wiops available to a given cgroup subtree. This would factor
> in the limits from io.max and the resulting distribution from io.weight in
> iocost's case (iocost will give a % number but we can translate that to
> bps/iops numbers).

Yes, that's a useful metric to expose this way as well.

>> Restrictions for memory are even more complicated to model as you have
>> pointed out as well.
> Yeah, this one is the most challenging.
>
> Thanks.
>
Thank you,
Pratik

