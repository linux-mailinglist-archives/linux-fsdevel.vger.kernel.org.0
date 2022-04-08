Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C62DF4F8E15
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Apr 2022 08:26:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235032AbiDHGBM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 Apr 2022 02:01:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiDHGBL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 Apr 2022 02:01:11 -0400
Received: from heian.cn.fujitsu.com (mail.cn.fujitsu.com [183.91.158.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7FDEF4CD42;
        Thu,  7 Apr 2022 22:59:07 -0700 (PDT)
IronPort-Data: =?us-ascii?q?A9a23=3AcjdB/KC7/4fbDRVW/zviw5YqxClBgxIJ4g17XOL?=
 =?us-ascii?q?fAQm81WwigjUFm2sXDDyPM6qDYWamft1+a4yxpBhSvsOAx9UxeLYW3SszFioV8?=
 =?us-ascii?q?6IpJjg4wn/YZnrUdouaJK5ex512huLocYZkHhcwmj/3auK79SMkjPnRLlbBILW?=
 =?us-ascii?q?s1h5ZFFYMpBgJ2UoLd94R2uaEsPDha++/kYqaT/73ZDdJ7wVJ3lc8sMpvnv/AU?=
 =?us-ascii?q?MPa41v0tnRmDRxCUcS3e3M9VPrzLonpR5f0rxU9IwK0ewrD5OnREmLx9BFrBM6?=
 =?us-ascii?q?nk6rgbwsBRbu60Qqm0yIQAvb9xEMZ4HFaPqUTbZLwbW9NljyPhME3xtNWqbS+V?=
 =?us-ascii?q?AUoIrbR3u8aVnG0FgknZ/YaoeWfeyfXXcu7iheun2HX6/lnEkA6FYMC/eNwG2t?=
 =?us-ascii?q?P6boTLzVlRhCIh8q3xryhQ+Vhj8hlK9PkVKsTs3cmz3fGDPIiQJnGWI3L48NV2?=
 =?us-ascii?q?HE7gcUmNerZYdtfbSdkbzzBZQFCPhEcD5dWtOuqmX75fBVbpUiTqK5x5HLcpCR?=
 =?us-ascii?q?027jgMNPfUt+HX8NYmgCfvG2u12D4BAwKcdma4Tmb+3mvwOjVkkvTXpweFbi93?=
 =?us-ascii?q?vprm0GIgGgSDgAGE1e2v5GRiEe4VpRUK1E8/TAnpqw/skesS7HVWxy+vW7BsAU?=
 =?us-ascii?q?QVsRdF8Uk5wyXjKnZ+QCUAi4DVDEpQNgnstImAD8nzFmEm/v3CjF19r6YU3SQ8?=
 =?us-ascii?q?vGTtzzaESwUK3ISID8KViMb7NT55oI+lBTCSpBkCqHdszFfMVkc2BjT9G5n2ep?=
 =?us-ascii?q?V1pVNis2GEZn8q2rEjvD0osQdv207hl6Y0z4=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3ATGLtuKg7gkn9+eaczY5+DH2LxHBQXj4ji2hC?=
 =?us-ascii?q?6mlwRA09TySZ//re/sjzsiWE8Qr5OUtQ/+xoV5PufZqxz+8Q3WBVB8bEYOCEgg?=
 =?us-ascii?q?WVxeNZgbcKqgeIc0aVm9K1l50QFpSWY+eRMbEVt7eY3OD1KbcdKce8gd2VrNab?=
 =?us-ascii?q?33FwVhtrdq0lyw94DzyQGkpwSBIuP+tDKLOsotpAuyG7eWkaKuCyBnw+VeDFoN?=
 =?us-ascii?q?HR0L38ZxpuPW9c1CC+ySOv9KXhEwWVmjMXUzZ0y78k9mTf1yzVj5/Ty82G9g?=
 =?us-ascii?q?=3D=3D?=
X-IronPort-AV: E=Sophos;i="5.88,333,1635177600"; 
   d="scan'208";a="123412027"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 08 Apr 2022 13:59:06 +0800
Received: from G08CNEXMBPEKD05.g08.fujitsu.local (unknown [10.167.33.204])
        by cn.fujitsu.com (Postfix) with ESMTP id B9BD64D17163;
        Fri,  8 Apr 2022 13:59:01 +0800 (CST)
Received: from G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) by
 G08CNEXMBPEKD05.g08.fujitsu.local (10.167.33.204) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Fri, 8 Apr 2022 13:59:02 +0800
Received: from [192.168.22.28] (10.167.225.141) by
 G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Fri, 8 Apr 2022 13:59:00 +0800
Message-ID: <7f13413d-e7a4-4ac2-46ad-1e1955fa42ee@fujitsu.com>
Date:   Fri, 8 Apr 2022 13:59:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v11 1/8] dax: Introduce holder for dax_device
To:     Dan Williams <dan.j.williams@intel.com>,
        "Darrick J. Wong" <djwong@kernel.org>
CC:     Jane Chu <jane.chu@oracle.com>,
        Christoph Hellwig <hch@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        Linux MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        david <david@fromorbit.com>, "Luck, Tony" <tony.luck@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
References: <CAPcyv4jAqV7dZdmGcKrG=f8sYmUXaL7YCQtME6GANywncwd+zg@mail.gmail.com>
 <4fd95f0b-106f-6933-7bc6-9f0890012b53@fujitsu.com>
 <YkPtptNljNcJc1g/@infradead.org>
 <15a635d6-2069-2af5-15f8-1c0513487a2f@fujitsu.com>
 <YkQtOO/Z3SZ2Pksg@infradead.org>
 <4ed8baf7-7eb9-71e5-58ea-7c73b7e5bb73@fujitsu.com>
 <YkR8CUdkScEjMte2@infradead.org> <20220330161812.GA27649@magnolia>
 <fd37cde6-318a-9faf-9bff-70bb8e5d3241@oracle.com>
 <CAPcyv4gqBmGCQM_u40cR6GVror6NjhxV5Xd7pdHedE2kHwueoQ@mail.gmail.com>
 <20220406203900.GR27690@magnolia>
 <CAPcyv4g9m13VGq9mFHHhd301jZk-OQC47MGpB9nU=erA0i2ZCg@mail.gmail.com>
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
In-Reply-To: <CAPcyv4g9m13VGq9mFHHhd301jZk-OQC47MGpB9nU=erA0i2ZCg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-yoursite-MailScanner-ID: B9BD64D17163.A0D3F
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@fujitsu.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



在 2022/4/8 9:38, Dan Williams 写道:
> [ add Mauro and Tony for RAS discussion ]
> 
> On Wed, Apr 6, 2022 at 1:39 PM Darrick J. Wong <djwong@kernel.org> wrote:
>>
>> On Tue, Apr 05, 2022 at 06:22:48PM -0700, Dan Williams wrote:
>>> On Tue, Apr 5, 2022 at 5:55 PM Jane Chu <jane.chu@oracle.com> wrote:
>>>>
>>>> On 3/30/2022 9:18 AM, Darrick J. Wong wrote:
>>>>> On Wed, Mar 30, 2022 at 08:49:29AM -0700, Christoph Hellwig wrote:
>>>>>> On Wed, Mar 30, 2022 at 06:58:21PM +0800, Shiyang Ruan wrote:
>>>>>>> As the code I pasted before, pmem driver will subtract its ->data_offset,
>>>>>>> which is byte-based. And the filesystem who implements ->notify_failure()
>>>>>>> will calculate the offset in unit of byte again.
>>>>>>>
>>>>>>> So, leave its function signature byte-based, to avoid repeated conversions.
>>>>>>
>>>>>> I'm actually fine either way, so I'll wait for Dan to comment.
>>>>>
>>>>> FWIW I'd convinced myself that the reason for using byte units is to
>>>>> make it possible to reduce the pmem failure blast radius to subpage
>>>>> units... but then I've also been distracted for months. :/
>>>>>
>>>>
>>>> Yes, thanks Darrick!  I recall that.
>>>> Maybe just add a comment about why byte unit is used?
>>>
>>> I think we start with page failure notification and then figure out
>>> how to get finer grained through the dax interface in follow-on
>>> changes. Otherwise, for finer grained error handling support,
>>> memory_failure() would also need to be converted to stop upcasting
>>> cache-line granularity to page granularity failures. The native MCE
>>> notification communicates a 'struct mce' that can be in terms of
>>> sub-page bytes, but the memory management implications are all page
>>> based. I assume the FS implications are all FS-block-size based?
>>
>> I wouldn't necessarily make that assumption -- for regular files, the
>> user program is in a better position to figure out how to reset the file
>> contents.
>>
>> For fs metadata, it really depends.  In principle, if (say) we could get
>> byte granularity poison info, we could look up the space usage within
>> the block to decide if the poisoned part was actually free space, in
>> which case we can correct the problem by (re)zeroing the affected bytes
>> to clear the poison.
>>
>> Obviously, if the blast radius hits the internal space info or something
>> that was storing useful data, then you'd have to rebuild the whole block
>> (or the whole data structure), but that's not necessarily a given.
> 
> tl;dr: dax_holder_notify_failure() != fs->notify_failure()
> 
> So I think I see some confusion between what DAX->notify_failure()
> needs, memory_failure() needs, the raw information provided by the
> hardware, and the failure granularity the filesystem can make use of.
> 
> DAX and memory_failure() need to make immediate page granularity
> decisions. They both need to map out whole pages (in the direct map
> and userspace respectively) to prevent future poison consumption, at
> least until the poison is repaired.
> 
> The event that leads to a page being failed can be triggered by a
> hardware error as small as an individual cacheline. While that is
> interesting to a filesystem it isn't information that memory_failure()
> and DAX can utilize.
> 
> The reason DAX needs to have a callback into filesystem code is to map
> the page failure back to all the processes that might have that page
> mapped because reflink means that page->mapping is not sufficient to
> find all the affected 'struct address_space' instances. So it's more
> of an address-translation / "help me kill processes" service than a
> general failure notification service.
> 
> Currently when raw hardware event happens there are mechanisms like
> arch-specific notifier chains, like powerpc::mce_register_notifier()
> and x86::mce_register_decode_chain(), or other platform firmware code
> like ghes_edac_report_mem_error() that uplevel the error to a coarse
> page granularity failure, while emitting the fine granularity error
> event to userspace.
> 
> All of this to say that the interface to ask the fs to do the bottom
> half of memory_failure() (walking affected 'struct address_space'
> instances and killing processes (mf_dax_kill_procs())) is different
> than the general interface to tell the filesystem that memory has gone
> bad relative to a device. So if the only caller of
> fs->notify_failure() handler is this code:
> 
> +       if (pgmap->ops->memory_failure) {
> +               rc = pgmap->ops->memory_failure(pgmap, PFN_PHYS(pfn), PAGE_SIZE,
> +                               flags);
> 
> ...then you'll never get fine-grained reports. So, I still think the
> DAX, pgmap and memory_failure() interface should be pfn based. The
> interface to the *filesystem* ->notify_failure() can still be
> byte-based, but the trigger for that byte based interface will likely
> need to be something driven by another agent. Perhaps like rasdaemon
> in userspace translating all the arch specific physical address events
> back into device-relative offsets and then calling a new ABI that is
> serviced by fs->notify_failure() on the backend.

Understood.  I'll do as your advise.  Thanks!


--
Ruan.


