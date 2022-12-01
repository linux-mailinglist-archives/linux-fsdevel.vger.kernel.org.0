Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 548DB63F450
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Dec 2022 16:40:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231655AbiLAPkh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Dec 2022 10:40:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231951AbiLAPkG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Dec 2022 10:40:06 -0500
Received: from mail1.bemta37.messagelabs.com (mail1.bemta37.messagelabs.com [85.158.142.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88B83B0DFC;
        Thu,  1 Dec 2022 07:39:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1669909163; i=@fujitsu.com;
        bh=i/3URNOZ368Pw6xPzvchMsC2+kciXbnOKZYhIhNvdcw=;
        h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
         In-Reply-To:Content-Type:Content-Transfer-Encoding;
        b=qOyInI2r0jGU9LS2jGOiLRilPVOpMsh+glA5L1I8hHHLBTg8pTYTaw6K/KnevrRt/
         ugcy0Lw7x1L878fKbbMC/M24lgY8/37zL9ADJgfxnV6Y4lVthQeHhins3doz3NJsHz
         6E10wH9sknpOoaLDYMrPnU/U2E3QSUFMF1+47RfaIDFkGyY+OlN+czHos/9uomW1rs
         f0ftPD1k5805nzqxtqMwKyWd9lHnLoyNGISviBFVoVNBsizHkNHWNLaRsamCHVbUcq
         s5iOnp44p3ZYtHpDd+GJzKXi1DDlzIVL+CK/jbLln5XRh0XLJeoXF1f64jHVETL61K
         9N2YLB/OKt8QQ==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrDKsWRWlGSWpSXmKPExsViZ8OxWXfVqY5
  kg6ULTC3mrF/DZjF96gVGiy3H7jFaXH7CZ7Fn70kWi8u75rBZ7Pqzg91i5Y8/rA4cHqcWSXgs
  3vOSyWPTqk42jxMzfrN4vNg8k9Hj8ya5ALYo1sy8pPyKBNaMBy3f2AumG1S8X/eTrYFxkXoXI
  xeHkMBGRonD65+zQjhLmCQuHvrLDOFsZpRY9/w5UxcjJwevgJ3EkWk/WEFsFgEVifV7j7JCxA
  UlTs58wgJiiwokS/T1z2QDsYUFLCTu7NvODGKLCARL7N25CGwDs8AGRok9W89DbWhnkth+6gM
  jSBWbgI7EhQV/waZyCmhI/FhxgR3EZgaatPjNQShbXqJ562ywqRICChLXjzVA2RUSs2a1MUHY
  ahJXz21insAoNAvJgbOQjJqFZNQCRuZVjGbFqUVlqUW6FnpJRZnpGSW5iZk5eolVuol6qaW6e
  flFJRm6hnqJ5cV6qcXFesWVuck5KXp5qSWbGIFRllKc4r6D8fiyP3qHGCU5mJREebX3dSQL8S
  Xlp1RmJBZnxBeV5qQWH2KU4eBQkuBN2QOUEyxKTU+tSMvMAUY8TFqCg0dJhFfyJFCat7ggMbc
  4Mx0idYrRmGNtw4G9zByT/lzbyyzEkpeflyolzht4HKhUAKQ0ozQPbhAsEV1ilJUS5mVkYGAQ
  4ilILcrNLEGVf8UozsGoJMzbewJoCk9mXgncvldApzABnRIp1gZySkkiQkqqgWm/yYKpV7Jlv
  lx9Njuj+e6z9Sn7i9JnqSVnGcwOeSrOyep38UL/JN4p93Qs/ixvF55cUWp+tD22kO1lbJtz9h
  PrSS++Cha3rmEvfn56/4Y1bc+4k/Pkb94qWJ1vy9Ml+ee+0Fl759z7F15rv/nuWjjnq+j+Dr5
  vUl3y+QdPar5tuPTnfov2FfV3xr8uvV2a1Z/AFKPLHRmrqRsS9+eYl/YPxteT57+Ov1TPNTuX
  NyP7HGdQ5a9NN6MO/lDjUUxNuVrIt9301BxVJYsS88ijdqbfPA9mfqg5stx+TQxP1oMFP3fp/
  332XtiSb1Xx3SMRLOainQWSHziO7vDf9VloTvDHS/1eyU9eSvCk3K9cYafEUpyRaKjFXFScCA
  D5xqr0vwMAAA==
X-Env-Sender: ruansy.fnst@fujitsu.com
X-Msg-Ref: server-21.tower-745.messagelabs.com!1669909162!280288!1
X-Originating-IP: [62.60.8.179]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.101.1; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 9106 invoked from network); 1 Dec 2022 15:39:22 -0000
Received: from unknown (HELO n03ukasimr04.n03.fujitsu.local) (62.60.8.179)
  by server-21.tower-745.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 1 Dec 2022 15:39:22 -0000
Received: from n03ukasimr04.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr04.n03.fujitsu.local (Postfix) with ESMTP id 4682915A;
        Thu,  1 Dec 2022 15:39:22 +0000 (GMT)
Received: from R01UKEXCASM126.r01.fujitsu.local (R01UKEXCASM126 [10.183.43.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr04.n03.fujitsu.local (Postfix) with ESMTPS id 38F46159;
        Thu,  1 Dec 2022 15:39:22 +0000 (GMT)
Received: from [10.167.201.5] (10.167.201.5) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.42; Thu, 1 Dec 2022 15:39:18 +0000
Message-ID: <bf1ef4da-de16-c6bb-7ef5-374c6ed197e2@fujitsu.com>
Date:   Thu, 1 Dec 2022 23:39:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 0/2] fsdax,xfs: fix warning messages
To:     "Darrick J. Wong" <djwong@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
        <nvdimm@lists.linux.dev>, <linux-fsdevel@vger.kernel.org>,
        <david@fromorbit.com>, <akpm@linux-foundation.org>
References: <1669301694-16-1-git-send-email-ruansy.fnst@fujitsu.com>
 <6386d512ce3fc_c9572944e@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <Y4bZGvP8Ozp+4De/@magnolia>
 <638700ba5db1_c95729435@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <Y4fGRurfXoFSBqMB@magnolia>
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
In-Reply-To: <Y4fGRurfXoFSBqMB@magnolia>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.167.201.5]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



在 2022/12/1 5:08, Darrick J. Wong 写道:
> On Tue, Nov 29, 2022 at 11:05:30PM -0800, Dan Williams wrote:
>> Darrick J. Wong wrote:
>>> On Tue, Nov 29, 2022 at 07:59:14PM -0800, Dan Williams wrote:
>>>> [ add Andrew ]
>>>>
>>>> Shiyang Ruan wrote:
>>>>> Many testcases failed in dax+reflink mode with warning message in dmesg.
>>>>> This also effects dax+noreflink mode if we run the test after a
>>>>> dax+reflink test.  So, the most urgent thing is solving the warning
>>>>> messages.
>>>>>
>>>>> Patch 1 fixes some mistakes and adds handling of CoW cases not
>>>>> previously considered (srcmap is HOLE or UNWRITTEN).
>>>>> Patch 2 adds the implementation of unshare for fsdax.
>>>>>
>>>>> With these fixes, most warning messages in dax_associate_entry() are
>>>>> gone.  But honestly, generic/388 will randomly failed with the warning.
>>>>> The case shutdown the xfs when fsstress is running, and do it for many
>>>>> times.  I think the reason is that dax pages in use are not able to be
>>>>> invalidated in time when fs is shutdown.  The next time dax page to be
>>>>> associated, it still remains the mapping value set last time.  I'll keep
>>>>> on solving it.
>>>>>
>>>>> The warning message in dax_writeback_one() can also be fixed because of
>>>>> the dax unshare.
>>>>
>>>> Thank you for digging in on this, I had been pinned down on CXL tasks
>>>> and worried that we would need to mark FS_DAX broken for a cycle, so
>>>> this is timely.
>>>>
>>>> My only concern is that these patches look to have significant collisions with
>>>> the fsdax page reference counting reworks pending in linux-next. Although,
>>>> those are still sitting in mm-unstable:
>>>>
>>>> http://lore.kernel.org/r/20221108162059.2ee440d5244657c4f16bdca0@linux-foundation.org
>>>>
>>>> My preference would be to move ahead with both in which case I can help
>>>> rebase these fixes on top. In that scenario everything would go through
>>>> Andrew.
>>>>
>>>> However, if we are getting too late in the cycle for that path I think
>>>> these dax-fixes take precedence, and one more cycle to let the page
>>>> reference count reworks sit is ok.
>>>
>>> Well now that raises some interesting questions -- dax and reflink are
>>> totally broken on 6.1.  I was thinking about cramming them into 6.2 as a
>>> data corruption fix on the grounds that is not an acceptable state of
>>> affairs.
>>
>> I agree it's not an acceptable state of affairs, but for 6.1 the answer
>> may be to just revert to dax+reflink being forbidden again. The fact
>> that no end user has noticed is probably a good sign that we can disable
>> that without any one screaming. That may be the easy answer for 6.2 as
>> well given how late this all is.
>>
>>> OTOH we're past -rc7, which is **really late** to be changing core code.
>>> Then again, there aren't so many fsdax users and nobody's complained
>>> about 6.0/6.1 being busted, so perhaps the risk of regression isn't so
>>> bad?  Then again, that could be a sign that this could wait, if you and
>>> Andrew are really eager to merge the reworks.
>>
>> The page reference counting has also been languishing for a long time. A
>> 6.2 merge would be nice, it relieves maintenance burden, but they do not
>> start to have real end user implications until CXL memory hotplug
>> platforms arrive and the warts in the reference counting start to show
>> real problems in production.
> 
> Hm.  How bad *would* it be to rebase that patchset atop this one?
> 
> After overnight testing on -rc7 it looks like Ruan's patchset fixes all
> the problems AFAICT.  Most of the remaining regressions are to mask off
> fragmentation testing because fsdax cow (like the directio write paths)
> doesn't make much use of extent size hints.
> 
>>> Just looking at the stuff that's still broken with dax+reflink -- I
>>> noticed that xfs/550-552 (aka the dax poison tests) are still regressing
>>> on reflink filesystems.
>>
>> That's worrying because the whole point of reworking dax, xfs, and
>> mm/memory-failure all at once was to handle the collision of poison and
>> reflink'd dax files.
> 
> I just tried out -rc7 and all three pass, so disregard this please.
> 
>>> So, uh, what would this patchset need to change if the "fsdax page
>>> reference counting reworks" were applied?  Would it be changing the page
>>> refcount instead of stashing that in page->index?
>>
>> Nah, it's things like switching from pages to folios and shifting how
>> dax goes from pfns to pages.
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git/commit/?h=mm-unstable&id=cca48ba3196
>>
>> Ideally fsdax would never deal in pfns at all and do everything in terms
>> of offsets relative to a 'struct dax_device'.
>>
>> My gut is saying these patches, the refcount reworks, and the
>> dax+reflink fixes, are important but not end user critical. One more
>> status quo release does not hurt, and we can circle back to get this all
>> straightened early in v6.3.
> 
> Being a data corruption fix, I don't see why we shouldn't revisit this
> during the 6.2 cycle, even if it comes after merging the refcounting
> stuff.
> 
> Question for Ruan: Would it be terribly difficult to push out a v2 with
> the review comments applied so that we have something we can backport to
> 6.1; and then rebase the series atop 6.2-rc1 so we can apply it to
> upstream (and then apply the 6.1 version to the LTS)?  Or is this too
> convoluted...?

It's fine to me.  V2 has been posted just now.  The big patch has been 
separated.


--
Thanks,
Ruan.

> 
>> I.e. just revert:
>>
>> 35fcd75af3ed xfs: fail dax mount if reflink is enabled on a partition
>>
>> ...for v6.1-rc8 and get back to this early in the New Year.
> 
> Hm.  Tempting.
> 
> --D
> 
>>>
>>> --D
>>>
>>>>> Shiyang Ruan (2):
>>>>>    fsdax,xfs: fix warning messages at dax_[dis]associate_entry()
>>>>>    fsdax,xfs: port unshare to fsdax
>>>>>
>>>>>   fs/dax.c             | 166 ++++++++++++++++++++++++++++++-------------
>>>>>   fs/xfs/xfs_iomap.c   |   6 +-
>>>>>   fs/xfs/xfs_reflink.c |   8 ++-
>>>>>   include/linux/dax.h  |   2 +
>>>>>   4 files changed, 129 insertions(+), 53 deletions(-)
>>>>>
>>>>> -- 
>>>>> 2.38.1
>>
>>
