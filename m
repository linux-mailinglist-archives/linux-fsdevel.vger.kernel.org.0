Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 453E8434933
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Oct 2021 12:44:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbhJTKrB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Oct 2021 06:47:01 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49490 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230059AbhJTKrA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Oct 2021 06:47:00 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19KAM0vJ030303;
        Wed, 20 Oct 2021 06:44:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=SD+SCg0skNn/G8bPIH66EtOVwTbj3NFy6mI+5VN/Q5s=;
 b=PZZppYkh/ARYtQF6DTllxaxC2TsLrFX66Zh88bWos3rMX2NYk5Q2jZsEAY7M5L7hsz90
 4MCfmaeeBUIQi8wDabhMjZ+GvPLNh9c4jqFmdvZXznQFyDNf4JHe2mSeA2PpiEKYmbMk
 WIiQFsuEUMBlsyB8tqoyfc4/NU9JtUM6sVrbr3KEUWKZdmyB7pxIuiZcB6s7mZf+Ga2N
 9NuKu1p7TIhplQ6/Jeivs8OGZj7XE2Dyyupj11TrgsAKScodKsFr5GRuTaj3xwyxGBmb
 LtZ+RXQkhbnGMAnAdGSekEDjtpJYMpiV4vFEcmdCkQj9wMnbFDszulmjpGpyx88Ud0RI JQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3btha10d6t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Oct 2021 06:44:37 -0400
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 19KAOWXh010381;
        Wed, 20 Oct 2021 06:44:36 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3btha10d5w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Oct 2021 06:44:36 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 19KAfbdo010873;
        Wed, 20 Oct 2021 10:44:34 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma06ams.nl.ibm.com with ESMTP id 3bqp0k3hmu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Oct 2021 10:44:33 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 19KAce5L58786244
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Oct 2021 10:38:40 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0E5F44C094;
        Wed, 20 Oct 2021 10:44:31 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0CEF04C092;
        Wed, 20 Oct 2021 10:44:27 +0000 (GMT)
Received: from [9.43.80.161] (unknown [9.43.80.161])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 20 Oct 2021 10:44:26 +0000 (GMT)
Message-ID: <77854748-081f-46c7-df51-357ca78b83b3@linux.ibm.com>
Date:   Wed, 20 Oct 2021 16:14:25 +0530
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
From:   Pratik Sampat <psampat@linux.ibm.com>
In-Reply-To: <YW2g73Lwmrhjg/sv@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: qofvCjSGBUthVgmc6TULavD9beXS2nWn
X-Proofpoint-GUID: BVgdVM-XcBH6D1Jw3sM_tkPAuXMRp7Sv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-20_04,2021-10-20_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 adultscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0
 clxscore=1015 spamscore=0 priorityscore=1501 mlxscore=0 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110200060
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 18/10/21 9:59 pm, Tejun Heo wrote:
> (cc'ing Johannes for memory sizing part)
>
> Hello,
>
> On Mon, Oct 18, 2021 at 08:59:16PM +0530, Pratik Sampat wrote:
> ...
>> Also, I agree with your point about variability of requirements. If the
>> interface we give even though it is in conjunction with the limits set,
>> if the applications have to derive metrics from this or from other
>> kernel information regardless; then the interface would not be useful.
>> If the solution to this problem lies in userspace, then I'm all for it
>> as well. However, the intention is to probe if this could potentially be
>> solved in cleanly in the kernel.
> Just to be clear, avoiding application changes would have to involve
> userspace (at least parameterization from it), and I think to set that as a
> goal for kernel would be more of a distraction. Please note that we should
> definitely provide metrics which actually capture what's going on in terms
> of resource availability in a way which can be used to size workloads
> automatically.
>
>> Yes, these shortcomings exist even without containerization, on a
>> dynamically loaded multi-tenant system it becomes very difficult to
>> determine what is the maximum amount resource that can be requested
>> before we hurt our own performance.
> As I mentioned before, feedback loop on PSI can work really well in finding
> the saturation points for cpu/mem/io and regulating workload size
> automatically and dynamically. While such dynamic sizing can work without
> any other inputs, it sucks to have to probe the entire range each time and
> it'd be really useful if the kernel can provide ballpark numbers that are
> needed to estimate the saturation points.
>
> What gets challenging is that there doesn't seem to be a good way to
> consistently describe availability for each of the three resources and the
> different distribution rules they may be under.
>
> e.g. For CPU, the affinity restrictions from cpuset determines the maximum
> number of threads that a workload would need to saturate the available CPUs.
> However, conveying the results of cpu.max and cpu.weight controls isn't as
> straight-fowrads.
>
> For memory, it's even trickier because in a lot of cases it's impossible to
> tell how much memory is actually available without trying to use them as
> active workingset can only be learned by trying to reclaim memory.
>
> IO is in somewhat similar boat as CPU in that there are both io.max and
> io.weight. However, if io.cost is in use and configured according to the
> hardware, we can map those two in terms iocost.
>
> Another thing is that the dynamic nature of these control mechanisms means
> that the numbers can keep changing moment to moment and we'd need to provide
> some time averaged numbers. We can probably take the same approach as PSI
> and load-avgs and provide running avgs of a few time intervals.

As you have elucidated, it doesn't like an easy feat to
define metrics like ballpark numbers as there are many variables
involved.

For the CPU example, cpusets control the resource space whereas
period-quota control resource time. These seem like two vectors on
different axes.
Conveying these restrictions in one metric doesn't seem easy. Some
container runtime convert the period-quota time dimension to X CPUs
worth of runtime space dimension. However, we need to carefully model
what a ballpark metric in this sense would be and provide clearer
constraints as both of these restrictions can be active at a given
point in time and can influence how something is run.

Restrictions for memory are even more complicated to model as you have
pointed out as well.

I would also request using this mail thread to suggest if there are
more such metrics which would be useful to expose from the kernel?
This would probably not solve the coherency problem but maybe it could
help entice the userspace applications to look at the cgroup interface
as there could be more relevant metrics that would help them tune for
performance.

>
>> The question that I have essentially tries to understand the
>> implications of overloading existing interface's definitions to be
>> context sensitive.
>> The way that the prototype works today is that it does not interfere
>> with the information when the system boots or even when it is run in a
>> new namespace.
>> The effects are only observed when restrictions are applied to it.
>> Therefore, what would potentially break if interfaces like these are
>> made to divulge information based on restrictions rather than the whole
>> system view?
> I don't think the problem is that something would necessarily break by doing
> that. It's more that it's a dead-end approach which won't get us far for all
> the reasons that have been discussed so far. It'd be more productive to
> focus on long term solutions and leave backward compatibility to the domains
> where they can actually be solved by applying the necessary local knoweldge
> to emulate and fake whatever necessary numbers.

Sure, understood. If the only goal is backward compatibility then its
best to let existing solutions help emulate and/or fake this
information to the applications.

Thank you again for all the feedback.

