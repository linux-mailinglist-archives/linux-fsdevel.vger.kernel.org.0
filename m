Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F73D2DC6B9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Dec 2020 19:48:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732006AbgLPSry (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Dec 2020 13:47:54 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:40286 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728126AbgLPSrx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Dec 2020 13:47:53 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BGIduP7097052;
        Wed, 16 Dec 2020 18:47:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : references : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=Xr8yAw8/V8mkqXz0+iWuL/b/ysvEUbubY0zlp+7SudM=;
 b=FTpbDV5tlDmycn3h+k5CoK4fcGRpwnQnNeP7DsFp6KIARJDiuZXyYeoFmTh7XXe5AiJf
 TGgMHzw2g7ZMbMKhnTSS1vChoVjBO4P//dp4BwCMOL0auiRIzE1TpDs6gDE1QxFbrSVr
 US6sj9d96e4hZg/FCRnqdssHFXjNq27K0jpAL+v/CaDq1KeFBAZY5oanMKSwY33b4SGE
 vXPfJftZW/D65+kN6bj7k+KLl+CHGYogQYVogq1lFQWd1U3ucAvkEh/4419UD+o8qqIQ
 bQn+VIuDXKJqya8ED1X6lf0gVno38QdCXJdFWYmzLLJO5Ur7KZQSSWZDeLsswLIlxYN8 pQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 35ckcbj2nr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 16 Dec 2020 18:47:08 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BGIfVGv192259;
        Wed, 16 Dec 2020 18:47:08 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 35d7epw130-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Dec 2020 18:47:08 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0BGIl7gU000469;
        Wed, 16 Dec 2020 18:47:07 GMT
Received: from dhcp-10-159-155-197.vpn.oracle.com (/10.159.155.197)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 16 Dec 2020 10:47:06 -0800
Subject: Re: [PATCH RFC 0/8] dcache: increase poison resistance
From:   Junxiao Bi <junxiao.bi@oracle.com>
To:     Konstantin Khlebnikov <koct9i@gmail.com>
Cc:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-mm@kvack.org, Alexander Viro <viro@zeniv.linux.org.uk>,
        Waiman Long <longman@redhat.com>,
        Gautham Ananthakrishna <gautham.ananthakrishna@oracle.com>,
        matthew.wilcox@oracle.com
References: <158893941613.200862.4094521350329937435.stgit@buzz>
 <97ece625-2799-7ae6-28b5-73c52c7c497b@oracle.com>
 <CALYGNiN2F8gcKX+2nKOi1tapquJWfyzUkajWxTqgd9xvd7u1AA@mail.gmail.com>
 <d116ead4-f603-7e0c-e6ab-e721332c9832@oracle.com>
 <CALYGNiM8Fp=ZV8S6c2L50ne1cGhE30PrT-C=4nfershvfAgP+Q@mail.gmail.com>
 <04b4d5cf-780d-83a9-2b2b-80ae6029ae2c@oracle.com>
Message-ID: <4bcbd2e7-b5e3-6f45-51cf-8658f9c9009d@oracle.com>
Date:   Wed, 16 Dec 2020 10:46:46 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:78.0)
 Gecko/20100101 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <04b4d5cf-780d-83a9-2b2b-80ae6029ae2c@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9837 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 bulkscore=0
 suspectscore=0 adultscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012160117
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9837 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 priorityscore=1501 mlxscore=0 suspectscore=0 adultscore=0 phishscore=0
 malwarescore=0 impostorscore=0 lowpriorityscore=0 clxscore=1015
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012160117
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Konstantin,

How would you like to proceed with this patch set?

This patchset as it is already fixed the customer issue we faced, it 
will stop memory fragmentation causing by negative dentry and no 
performance regression through our test. In production workload, it is 
common that some app kept creating and removing tmp files, this will 
leave a lot of negative dentry over time, some time later, it will cause 
memory fragmentation and system run into memory compaction and not 
responsible. It will be good to push it to upstream merge. If you are 
busy, we can try push it again.

Thanks,

Junxiao.

On 12/14/20 3:10 PM, Junxiao Bi wrote:
> On 12/13/20 11:43 PM, Konstantin Khlebnikov wrote:
>
>>
>>
>> On Sun, Dec 13, 2020 at 9:52 PM Junxiao Bi <junxiao.bi@oracle.com 
>> <mailto:junxiao.bi@oracle.com>> wrote:
>>
>>     On 12/11/20 11:32 PM, Konstantin Khlebnikov wrote:
>>
>>     > On Thu, Dec 10, 2020 at 2:01 AM Junxiao Bi
>>     <junxiao.bi@oracle.com <mailto:junxiao.bi@oracle.com>
>>     > <mailto:junxiao.bi@oracle.com <mailto:junxiao.bi@oracle.com>>>
>>     wrote:
>>     >
>>     >     Hi Konstantin,
>>     >
>>     >     We tested this patch set recently and found it limiting 
>> negative
>>     >     dentry
>>     >     to a small part of total memory. And also we don't see any
>>     >     performance
>>     >     regression on it. Do you have any plan to integrate it into
>>     >     mainline? It
>>     >     will help a lot on memory fragmentation issue causing by
>>     dentry slab,
>>     >     there were a lot of customer cases where sys% was very high
>>     since
>>     >     most
>>     >     cpu were doing memory compaction, dentry slab was taking too
>>     much
>>     >     memory
>>     >     and nearly all dentry there were negative.
>>     >
>>     >
>>     > Right now I don't have any plans for this. I suspect such
>>     problems will
>>     > appear much more often since machines are getting bigger.
>>     > So, somebody will take care of it.
>>     We already had a lot of customer cases. It made no sense to leave so
>>     many negative dentry in the system, it caused memory fragmentation
>>     and
>>     not much benefit.
>>
>>
>> Dcache could grow so big only if the system lacks of memory pressure.
>>
>> Simplest solution is a cronjob which provinces such pressure by
>> creating sparse file on disk-based fs and then reading it.
>> This should wash away all inactive caches with no IO and zero chance 
>> of oom.
> Sound good, will try.
>>
>>     >
>>     > First part which collects negative dentries at the end list of
>>     > siblings could be
>>     > done in a more obvious way by splitting the list in two.
>>     > But this touches much more code.
>>     That would add new field to dentry?
>>
>>
>> Yep. Decision is up to maintainers.
>>
>>     >
>>     > Last patch isn't very rigid but does non-trivial changes.
>>     > Probably it's better to call some garbage collector thingy
>>     periodically.
>>     > Lru list needs pressure to age and reorder entries properly.
>>
>>     Swap the negative dentry to the head of hash list when it get
>>     accessed?
>>     Extra ones can be easily trimmed when swapping, using GC is to 
>> reduce
>>     perf impact?
>>
>>
>> Reclaimer/shrinker scans denties in LRU lists, it's an another list.
>
> Ah, you mean GC to reclaim from LRU list. I am not sure it could catch 
> up the speed of negative dentry generating.
>
> Thanks,
>
> Junxiao.
>
>> My patch used order in hash lists is a very unusual way. Don't be 
>> confused.
>>
>> There are four lists
>> parent - siblings
>> hashtable - hashchain
>> LRU
>> inode - alias
>>
>>
>>     Thanks,
>>
>>     Junxioao.
>>
>>     >
>>     > Gc could be off by default or thresholds set very high (50% of
>>     ram for
>>     > example).
>>     > Final setup could be left up to owners of large systems, which
>>     needs
>>     > fine tuning.
>>
