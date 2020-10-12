Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9986328B351
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Oct 2020 13:01:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388020AbgJLLBJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Oct 2020 07:01:09 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:52094 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387706AbgJLLBI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Oct 2020 07:01:08 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09CAeuUv104186;
        Mon, 12 Oct 2020 10:59:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=mb38IA085msJPf3gFvtjrmF9NBFtVRnlOijm9ZWxvF0=;
 b=z3kKsMth4Qtystg74wgCgSdTaLPxkgl29g8CFmlTAku9jCMLAqFLjm6BhptUvNas0BlW
 rsyXxe4DfYrde7du+AH+CrXkqLs7ItRgvYmdZwqydt6b71T/WsBd2eA7fenG5WBYphiO
 KJ+sq8ERG9xrqZODbvYilAbc2C48Nw9+3ia01ksiL4OM9whLZ4EUDeLj/+uCyb2iDDd4
 vU2LaEiLsATKrpCwPsD2/MQIkVAl86CqKTjaP1hlOecwsJbz/lVoffdH+PwLOuoDRubl
 N6NNsGk0Ln0lFGdomt//yty2RseIfqTiN1uWTYrVNXzV6Q251tcV8wt34VWc4Vl3f7BM BA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 3434wkched-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 12 Oct 2020 10:59:50 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09CAtav8126988;
        Mon, 12 Oct 2020 10:59:50 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 343phkphjx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Oct 2020 10:59:50 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 09CAxigG027754;
        Mon, 12 Oct 2020 10:59:45 GMT
Received: from [10.175.201.106] (/10.175.201.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 12 Oct 2020 03:59:44 -0700
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
 <b963565b-61d8-89d3-1abd-50cd8c8daad5@oracle.com>
 <CACZOiM26GPtqkGyecG=NGuB3etipV5-KgN+s19_U1WJrFxtYPQ@mail.gmail.com>
From:   Joao Martins <joao.m.martins@oracle.com>
Message-ID: <98be093d-c869-941a-6dd9-fb16356f763b@oracle.com>
Date:   Mon, 12 Oct 2020 11:59:37 +0100
MIME-Version: 1.0
In-Reply-To: <CACZOiM26GPtqkGyecG=NGuB3etipV5-KgN+s19_U1WJrFxtYPQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9771 signatures=668681
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 adultscore=0
 bulkscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010120090
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9771 signatures=668681
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 mlxscore=0
 malwarescore=0 phishscore=0 suspectscore=0 impostorscore=0 clxscore=1015
 spamscore=0 priorityscore=1501 bulkscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010120089
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/10/20 9:15 AM, yulei zhang wrote:
> On Fri, Oct 9, 2020 at 7:53 PM Joao Martins <joao.m.martins@oracle.com> wrote:
>> On 10/9/20 12:39 PM, yulei zhang wrote:
>>> Joao, thanks a lot for the feedback. One more thing needs to mention
>>> is that dmemfs also support fine-grained
>>> memory management which makes it more flexible for tenants with
>>> different requirements.
>>>
>> So as DAX when it allows to partition a region (starting 5.10). Meaning you have a region
>> which you dedicated to userspace. That region can then be partitioning into devices which
>> give you access to multiple (possibly discontinuous) extents with at a given page
>> granularity (selectable when you create the device), accessed through mmap().
>> You can then give that device to a cgroup. Or you can return that memory back to the
>> kernel (should you run into OOM situation), or you recreate the same mappings across
>> reboot/kexec.
>>
>> I probably need to read your patches again, but can you extend on the 'dmemfs also support
>> fine-grained memory management' to understand what is the gap that you mention?
>>
> sure, dmemfs uses bitmap to track the memory usage in the reserved
> memory region in
> a given page size granularity. And for each user the memory can be
> discrete as well.
> 
That same functionality of tracking reserved region usage across different users at any
page granularity is covered the DAX series I mentioned below. The discrete part -- IIUC
what you meant -- is then reduced using DAX ABI/tools to create a device file vs a filesystem.

>>> On Fri, Oct 9, 2020 at 3:01 AM Joao Martins <joao.m.martins@oracle.com> wrote:
>>>>
>>>> [adding a couple folks that directly or indirectly work on the subject]
>>>>
>>>> On 10/8/20 8:53 AM, yulei.kernel@gmail.com wrote:
>>>>> From: Yulei Zhang <yuleixzhang@tencent.com>
>>>>>
>>>>> In current system each physical memory page is assocaited with
>>>>> a page structure which is used to track the usage of this page.
>>>>> But due to the memory usage rapidly growing in cloud environment,
>>>>> we find the resource consuming for page structure storage becomes
>>>>> highly remarkable. So is it an expense that we could spare?
>>>>>
>>>> Happy to see another person working to solve the same problem!
>>>>
>>>> I am really glad to see more folks being interested in solving
>>>> this problem and I hope we can join efforts?
>>>>
>>>> BTW, there is also a second benefit in removing struct page -
>>>> which is carving out memory from the direct map.
>>>>
>>>>> This patchset introduces an idea about how to save the extra
>>>>> memory through a new virtual filesystem -- dmemfs.
>>>>>
>>>>> Dmemfs (Direct Memory filesystem) is device memory or reserved
>>>>> memory based filesystem. This kind of memory is special as it
>>>>> is not managed by kernel and most important it is without 'struct page'.
>>>>> Therefore we can leverage the extra memory from the host system
>>>>> to support more tenants in our cloud service.
>>>>>
>>>> This is like a walk down the memory lane.
>>>>
>>>> About a year ago we followed the same exact idea/motivation to
>>>> have memory outside of the direct map (and removing struct page overhead)
>>>> and started with our own layer/thingie. However we realized that DAX
>>>> is one the subsystems which already gives you direct access to memory
>>>> for free (and is already upstream), plus a couple of things which we
>>>> found more handy.
>>>>
>>>> So we sent an RFC a couple months ago:
>>>>
>>>> https://lore.kernel.org/linux-mm/20200110190313.17144-1-joao.m.martins@oracle.com/
>>>>
>>>> Since then majority of the work has been in improving DAX[1].
>>>> But now that is done I am going to follow up with the above patchset.
>>>>
>>>> [1]
>>>> https://lore.kernel.org/linux-mm/159625229779.3040297.11363509688097221416.stgit@dwillia2-desk3.amr.corp.intel.com/
>>>>
>>>> (Give me a couple of days and I will send you the link to the latest
>>>> patches on a git-tree - would love feedback!)
>>>>
>>>> The struct page removal for DAX would then be small, and ticks the
>>>> same bells and whistles (MCE handling, reserving PAT memtypes, ptrace
>>>> support) that we both do, with a smaller diffstat and it doesn't
>>>> touch KVM (not at least fundamentally).
>>>>
>>>>         15 files changed, 401 insertions(+), 38 deletions(-)
>>>>
>>>> The things needed in core-mm is for handling PMD/PUD PAGE_SPECIAL much
>>>> like we both do. Furthermore there wouldn't be a need for a new vm type,
>>>> consuming an extra page bit (in addition to PAGE_SPECIAL) or new filesystem.
>>>>
>>>> [1]
>>>> https://lore.kernel.org/linux-mm/159625229779.3040297.11363509688097221416.stgit@dwillia2-desk3.amr.corp.intel.com/
>>>>
>>>>
>>>>> We uses a kernel boot parameter 'dmem=' to reserve the system
>>>>> memory when the host system boots up, the details can be checked
>>>>> in /Documentation/admin-guide/kernel-parameters.txt.
>>>>>
>>>>> Theoretically for each 4k physical page it can save 64 bytes if
>>>>> we drop the 'struct page', so for guest memory with 320G it can
>>>>> save about 5G physical memory totally.
>>>>>
>>>> Also worth mentioning that if you only care about 'struct page' cost, and not on the
>>>> security boundary, there's also some work on hugetlbfs preallocation of hugepages into
>>>> tricking vmemmap in reusing tail pages.
>>>>
>>>>   https://lore.kernel.org/linux-mm/20200915125947.26204-1-songmuchun@bytedance.com/
>>>>
>>>> Going forward that could also make sense for device-dax to avoid so many
>>>> struct pages allocated (which would require its transition to compound
>>>> struct pages like hugetlbfs which we are looking at too). In addition an
>>>> idea <handwaving> would be perhaps to have a stricter mode in DAX where
>>>> we initialize/use the metadata ('struct page') but remove the underlaying
>>>> PFNs (of the 'struct page') from the direct map having to bear the cost of
>>>> mapping/unmapping on gup/pup.
>>>>
>>>>         Joao
