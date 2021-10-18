Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C1CD4322D5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Oct 2021 17:29:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231955AbhJRPbs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Oct 2021 11:31:48 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59440 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229696AbhJRPbr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Oct 2021 11:31:47 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19IE0N0S000432;
        Mon, 18 Oct 2021 11:29:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=rcJecVSV9JJG4iazj3f+iELtHVS0LVi684kZY28slOs=;
 b=mqH+feqf8Hb96BFOXyA67/YgYynP5NHv/Yz0TI8SovXpfs7dbpTqX5yYEPiyXPogaT0P
 XIOBrQIcRvyWtdt2hjI3WyYToW9m/suJxgrLX/uzoagEE8vvUh+rHqt+mMvlQ/xlbHtW
 +JoWWWm1rfgNOrYLz/V1QrddYcGU2oqmzltViA2wX9I1mMRYf6VcbrpoS7lSb9gEVo2k
 uoSRPOt/of8eYkRH7LDSDMWZA8vpRsfPMw0zk+Nl+rIeKederxDTHVeaRwLCldWIqQSl
 AQ2oSBa9SuSV5gyqXJL0b443IhkTH0lo70MC3WqoRL/Sh4qWWxR3JAq4Xa20Mr7zv8Uh +g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bs8vkvpra-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 18 Oct 2021 11:29:27 -0400
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 19IFMoTr011438;
        Mon, 18 Oct 2021 11:29:27 -0400
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bs8vkvpqc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 18 Oct 2021 11:29:26 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 19IFBYRa003805;
        Mon, 18 Oct 2021 15:29:24 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma03fra.de.ibm.com with ESMTP id 3bqpc96xx4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 18 Oct 2021 15:29:24 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 19IFNWP763111574
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Oct 2021 15:23:32 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1331811C050;
        Mon, 18 Oct 2021 15:29:22 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7FCD311C05C;
        Mon, 18 Oct 2021 15:29:17 +0000 (GMT)
Received: from [9.43.5.59] (unknown [9.43.5.59])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 18 Oct 2021 15:29:17 +0000 (GMT)
Message-ID: <b5f8505c-38d5-af6f-0de7-4f9df7ae9b9b@linux.ibm.com>
Date:   Mon, 18 Oct 2021 20:59:16 +0530
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
From:   Pratik Sampat <psampat@linux.ibm.com>
In-Reply-To: <YWirxCjschoRJQ14@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: olrr0wC6rZHl_pzXUHGZ6Zj92X7utMiM
X-Proofpoint-ORIG-GUID: 7JIhdfYuc3_3Tz8ordGqJ0m0G30qAnTY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-18_06,2021-10-18_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 mlxlogscore=999 bulkscore=0 clxscore=1015 suspectscore=0
 adultscore=0 phishscore=0 mlxscore=0 spamscore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110180093
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 15/10/21 3:44 am, Tejun Heo wrote:
> Hello,
>
> On Tue, Oct 12, 2021 at 02:12:18PM +0530, Pratik Sampat wrote:
>>>> The control and the display interface is fairly disjoint with each
>>>> other. Restrictions can be set through control interfaces like cgroups,
>>> A task wouldn't really opt-in to cpu isolation with CLONE_NEWCPU it
>>> would only affect resource reporting. So it would be one half of the
>>> semantics of a namespace.
>>>
>> I completely agree with you on this, fundamentally a namespace should
>> isolate both the resource as well as the reporting. As you mentioned
>> too, cgroups handles the resource isolation while this namespace
>> handles the reporting and this seems to break the semantics of what a
>> namespace should really be.
>>
>> The CPU resource is unique in that sense, at least in this context,
>> which makes it tricky to design a interface that presents coherent
>> information.
> It's only unique in the context that you're trying to place CPU distribution
> into the namespace framework when the resource in question isn't distributed
> that way. All of the three major local resources - CPU, memory and IO - are
> in the same boat. Computing resources, the physical ones, don't render
> themselves naturally to accounting and ditributing by segmenting _name_
> spaces which ultimately just shows and hides names. This direction is a
> dead-end.
>
>> I too think that having a brand new interface all together and teaching
>> userspace about it is much cleaner approach.
>> On the same lines, if were to do that, we could also add more useful
>> metrics in that interface like ballpark number of threads to saturate
>> usage as well as gather more such metrics as suggested by Tejun Heo.
>>
>> My only concern for this would be that if today applications aren't
>> modifying their code to read the existing cgroup interface and would
>> rather resort to using userspace side-channel solutions like LXCFS or
>> wrapping them up in kata containers, would it now be compelling enough
>> to introduce yet another interface?
> While I'm sympathetic to compatibility argument, identifying available
> resources was never well-define with the existing interfaces. Most of the
> available information is what hardware is available but there's no
> consistent way of knowing what the software environment is like. Is the
> application the only one on the system? How much memory should be set aside
> for system management, monitoring and other administrative operations?
>
> In practice, the numbers that are available can serve as the starting points
> on top of which application and environment specific knoweldge has to be
> applied to actually determine deployable configurations, which in turn would
> go through iterative adjustments unless the workload is self-sizing.
>
> Given such variability in requirements, I'm not sure what numbers should be
> baked into the "namespaced" system metrics. Some numbers, e.g., number of
> CPUs can may be mapped from cpuset configuration but even that requires
> quite a bit of assumptions about how cpuset is configured and the
> expectations the applications would have while other numbers - e.g.
> available memory - is a total non-starter.
>
> If we try to fake these numbers for containers, what's likely to happen is
> that the service owners would end up tuning workload size against whatever
> number the kernel is showing factoring in all the environmental factors
> knowingly or just through iterations. And that's not *really* an interface
> which provides compatibility. We're just piping new numbers which don't
> really mean what they used to mean and whose meanings can change depending
> on configuration through existing interfaces and letting users figure out
> what to do with the new numbers.
>
> To achieve compatibility where applications don't need to be changed, I
> don't think there is a solution which doesn't involve going through
> userspace. For other cases and long term, the right direction is providing
> well-defined resource metrics that applications can make sense of and use to
> size themselves dynamically.

I agree that major local resources like CPUs and memory cannot to be
distributed cleanly in a namespace semantic.
Thus the memory resource like CPU too does face similar coherency
issues where /proc/meminfo can be different from what the restrictions
are.

While a CPU namespace maybe not be the preferred way of solving
this problem, the prototype RFC is rather for understanding related
problems with this as well as other potential directions that we could
explore for solving this problem.

Also, I agree with your point about variability of requirements. If the
interface we give even though it is in conjunction with the limits set,
if the applications have to derive metrics from this or from other
kernel information regardless; then the interface would not be useful.
If the solution to this problem lies in userspace, then I'm all for it
as well. However, the intention is to probe if this could potentially be
solved in cleanly in the kernel.

>> While I concur with Tejun Heo's comment the mail thread and overloading
>> existing interfaces of sys and proc which were originally designed for
>> system wide resources, may not be a great idea:
>>
>>> There is a fundamental problem with trying to represent a resource shared
>>> environment controlled with cgroup using system-wide interfaces including
>>> procfs
>> A fundamental question we probably need to ascertain could be -
>> Today, is it incorrect for applications to look at the sys and procfs to
>> get resource information, regardless of their runtime environment?
> Well, it's incomplete even without containerization. Containerization just
> amplifies the shortcomings. All of these problems existed well before
> cgroups / namespaces. How would you know how much resource you can consume
> on a system just looking at hardware resources without implicit knowledge of
> what else is on the system? It's just that we are now more likely to load
> systems dynamically with containerization.

Yes, these shortcomings exist even without containerization, on a
dynamically loaded multi-tenant system it becomes very difficult to
determine what is the maximum amount resource that can be requested
before we hurt our own performance.
cgroups and namespace mechanics help containers give some structure to
the maximum amount of resources that they can consume. However,
applications are unable to leverage that in some cases especially if
they are more inclined to look at a more traditional system wide
interface like sys and proc.

>> Also, if an application were to only be able to view the resources
>> based on the restrictions set regardless of the interface - would there
>> be a disadvantage for them if they could only see an overloaded context
>> sensitive view rather than the whole system view?
> Can you elaborate further? I have a hard time understanding what's being
> asked.

The question that I have essentially tries to understand the
implications of overloading existing interface's definitions to be
context sensitive.
The way that the prototype works today is that it does not interfere
with the information when the system boots or even when it is run in a
new namespace.
The effects are only observed when restrictions are applied to it.
Therefore, what would potentially break if interfaces like these are
made to divulge information based on restrictions rather than the whole
system view?

Thanks
Pratik

