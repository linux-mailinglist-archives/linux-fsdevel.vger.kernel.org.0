Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D51E288819
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Oct 2020 13:54:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388236AbgJILyl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Oct 2020 07:54:41 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:52848 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732480AbgJILyk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Oct 2020 07:54:40 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 099BocOe079912;
        Fri, 9 Oct 2020 11:53:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=gC3p3SG+FOYjnql41FZPAxse6J88pzuXf0fi/UYfcFE=;
 b=Jtl7dgY4XPEm8DTdUcFPeLJSJEnIG9CUlxdDNhmpftpZj+ZN53wq3Uo9m7YGhAJcrMkg
 osRBeTCrsz+5makM+wcSscIeTidVW7vArJpjt26bmxz/zMY79SbytBAwrEjMZrcujcEE
 uqdgLKGqoN/1GpJkTFvtgBnPjB5x4C9FvGnwLx73G//xhkjMksMblxagD6ff9EZj8EUK
 QtNKQiljaQ6sJbp/qCTXiAl3t9uA+KMQJHlSPOE5cLURt1b+tFPwMj+YDL0r0xb5uK2Y
 NP4y42FMJ+G2v9/qHkVP/C5+vACRsti46QbUOK/itZss723T8mjoV6akW/5Tu2V6jMM4 cQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 342kvys2hm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 09 Oct 2020 11:53:20 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 099BpP3I156582;
        Fri, 9 Oct 2020 11:53:20 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 342gurbwfq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 09 Oct 2020 11:53:20 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 099BrEPL001428;
        Fri, 9 Oct 2020 11:53:14 GMT
Received: from [10.175.178.74] (/10.175.178.74)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 09 Oct 2020 04:53:14 -0700
Subject: Re: [PATCH 00/35] Enhance memory utilization with DMEMFS
To:     yulei zhang <yulei.kernel@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org, kvm <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
        Wanpeng Li <kernellwp@gmail.com>,
        Haiwei Li <lihaiwei.kernel@gmail.com>,
        Yulei Zhang <yuleixzhang@tencent.com>,
        akpm@linux-foundation.org, naoya.horiguchi@nec.com,
        viro@zeniv.linux.org.uk, Paolo Bonzini <pbonzini@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Jane Y Chu <jane.chu@oracle.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
References: <cover.1602093760.git.yuleixzhang@tencent.com>
 <bdd0250e-4e14-f407-a584-f39af12c4e09@oracle.com>
 <CACZOiM2qKhogXQ_DXzWjGM5UCeCuEqT6wnR=f2Wi_T45_uoYHQ@mail.gmail.com>
From:   Joao Martins <joao.m.martins@oracle.com>
Message-ID: <b963565b-61d8-89d3-1abd-50cd8c8daad5@oracle.com>
Date:   Fri, 9 Oct 2020 12:53:08 +0100
MIME-Version: 1.0
In-Reply-To: <CACZOiM2qKhogXQ_DXzWjGM5UCeCuEqT6wnR=f2Wi_T45_uoYHQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9768 signatures=668681
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 bulkscore=0 malwarescore=0 mlxscore=0 spamscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010090084
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9768 signatures=668681
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 clxscore=1015
 phishscore=0 spamscore=0 mlxlogscore=999 impostorscore=0
 priorityscore=1501 suspectscore=0 bulkscore=0 adultscore=0
 lowpriorityscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2010090084
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/9/20 12:39 PM, yulei zhang wrote:
> Joao, thanks a lot for the feedback. One more thing needs to mention
> is that dmemfs also support fine-grained
> memory management which makes it more flexible for tenants with
> different requirements.
> 
So as DAX when it allows to partition a region (starting 5.10). Meaning you have a region
which you dedicated to userspace. That region can then be partitioning into devices which
give you access to multiple (possibly discontinuous) extents with at a given page
granularity (selectable when you create the device), accessed through mmap().
You can then give that device to a cgroup. Or you can return that memory back to the
kernel (should you run into OOM situation), or you recreate the same mappings across
reboot/kexec.

I probably need to read your patches again, but can you extend on the 'dmemfs also support
fine-grained memory management' to understand what is the gap that you mention?

> On Fri, Oct 9, 2020 at 3:01 AM Joao Martins <joao.m.martins@oracle.com> wrote:
>>
>> [adding a couple folks that directly or indirectly work on the subject]
>>
>> On 10/8/20 8:53 AM, yulei.kernel@gmail.com wrote:
>>> From: Yulei Zhang <yuleixzhang@tencent.com>
>>>
>>> In current system each physical memory page is assocaited with
>>> a page structure which is used to track the usage of this page.
>>> But due to the memory usage rapidly growing in cloud environment,
>>> we find the resource consuming for page structure storage becomes
>>> highly remarkable. So is it an expense that we could spare?
>>>
>> Happy to see another person working to solve the same problem!
>>
>> I am really glad to see more folks being interested in solving
>> this problem and I hope we can join efforts?
>>
>> BTW, there is also a second benefit in removing struct page -
>> which is carving out memory from the direct map.
>>
>>> This patchset introduces an idea about how to save the extra
>>> memory through a new virtual filesystem -- dmemfs.
>>>
>>> Dmemfs (Direct Memory filesystem) is device memory or reserved
>>> memory based filesystem. This kind of memory is special as it
>>> is not managed by kernel and most important it is without 'struct page'.
>>> Therefore we can leverage the extra memory from the host system
>>> to support more tenants in our cloud service.
>>>
>> This is like a walk down the memory lane.
>>
>> About a year ago we followed the same exact idea/motivation to
>> have memory outside of the direct map (and removing struct page overhead)
>> and started with our own layer/thingie. However we realized that DAX
>> is one the subsystems which already gives you direct access to memory
>> for free (and is already upstream), plus a couple of things which we
>> found more handy.
>>
>> So we sent an RFC a couple months ago:
>>
>> https://lore.kernel.org/linux-mm/20200110190313.17144-1-joao.m.martins@oracle.com/
>>
>> Since then majority of the work has been in improving DAX[1].
>> But now that is done I am going to follow up with the above patchset.
>>
>> [1]
>> https://lore.kernel.org/linux-mm/159625229779.3040297.11363509688097221416.stgit@dwillia2-desk3.amr.corp.intel.com/
>>
>> (Give me a couple of days and I will send you the link to the latest
>> patches on a git-tree - would love feedback!)
>>
>> The struct page removal for DAX would then be small, and ticks the
>> same bells and whistles (MCE handling, reserving PAT memtypes, ptrace
>> support) that we both do, with a smaller diffstat and it doesn't
>> touch KVM (not at least fundamentally).
>>
>>         15 files changed, 401 insertions(+), 38 deletions(-)
>>
>> The things needed in core-mm is for handling PMD/PUD PAGE_SPECIAL much
>> like we both do. Furthermore there wouldn't be a need for a new vm type,
>> consuming an extra page bit (in addition to PAGE_SPECIAL) or new filesystem.
>>
>> [1]
>> https://lore.kernel.org/linux-mm/159625229779.3040297.11363509688097221416.stgit@dwillia2-desk3.amr.corp.intel.com/
>>
>>
>>> We uses a kernel boot parameter 'dmem=' to reserve the system
>>> memory when the host system boots up, the details can be checked
>>> in /Documentation/admin-guide/kernel-parameters.txt.
>>>
>>> Theoretically for each 4k physical page it can save 64 bytes if
>>> we drop the 'struct page', so for guest memory with 320G it can
>>> save about 5G physical memory totally.
>>>
>> Also worth mentioning that if you only care about 'struct page' cost, and not on the
>> security boundary, there's also some work on hugetlbfs preallocation of hugepages into
>> tricking vmemmap in reusing tail pages.
>>
>>   https://lore.kernel.org/linux-mm/20200915125947.26204-1-songmuchun@bytedance.com/
>>
>> Going forward that could also make sense for device-dax to avoid so many
>> struct pages allocated (which would require its transition to compound
>> struct pages like hugetlbfs which we are looking at too). In addition an
>> idea <handwaving> would be perhaps to have a stricter mode in DAX where
>> we initialize/use the metadata ('struct page') but remove the underlaying
>> PFNs (of the 'struct page') from the direct map having to bear the cost of
>> mapping/unmapping on gup/pup.
>>
>>         Joao
