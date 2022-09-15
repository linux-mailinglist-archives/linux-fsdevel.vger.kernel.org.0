Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3A6D5B9899
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Sep 2022 12:14:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbiIOKOy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Sep 2022 06:14:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbiIOKOw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Sep 2022 06:14:52 -0400
Received: from mail1.bemta37.messagelabs.com (mail1.bemta37.messagelabs.com [85.158.142.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 743ED2AC4A;
        Thu, 15 Sep 2022 03:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1663236887; i=@fujitsu.com;
        bh=5rA+LtPldd34XfUCE03AbLaVBytQ4Y6/eJyolwCDIJY=;
        h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
         In-Reply-To:Content-Type:Content-Transfer-Encoding;
        b=b484MohMz8TISWPQrZxHnaYLRSxUPK0M7fFX23RsU9Xu4OAy9Qpfl1YD64S7Efup9
         HSkzMBtIFe2sSmRnFnZ5yFrbTHL+alA6H+MvoyYbfrJj9ukxAiDDflf40SXKG1ngN9
         rIxVmZ6VoDOYi1wo9mgMf+uYVYAv9re9EO5bGs/+IMS5olI5gDat7v9qb6Fwadwm4/
         AysndWxnMywmWoYYizdFyn0e2wxLcp4B2fjwyU9raKZwj7Bu5upDsIHCHMdqeut6wb
         3wOAsWV3k/dToIr6NE0dF1oLQtRbzhWZFpio9mSEQRnS+95vtMXwI9rV3508Gp5Coc
         aZ0SeoJWRITmw==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrAKsWRWlGSWpSXmKPExsViZ8ORqCv2Wyn
  Z4N4OU4t3n6ssthy7x2hx+QmfxekJi5gs9uw9yWJxedccNotdf3awW6z88YfVgcPj1CIJj80r
  tDw2repk83ixeSajx/t9V9k8Pm+SC2CLYs3MS8qvSGDNWLz5LGNBi0bFq3lLGBsYP8t3MXJyC
  AlsYZRY1ejVxcgFZC9nkjj85BMjhLONUWLC76+sIFW8AnYS0/ffZQexWQRUJfquNUHFBSVOzn
  zCAmKLCiRJXN1wFywuLOArsXZTHzOILSLgI9FwZDsryFBmgUnMEqvnLGeB2LCDWeJZ9xmwDjY
  BR4l5szaygdicAhoSTa+uMYLYzAIWEovfHGSHsOUlmrfOBpsqIaAo0bbkHzuEXSHROP0QE4St
  JnH13CbmCYxCs5AcOAvJqFlIRi1gZF7FaJtUlJmeUZKbmJmja2hgoGtoaAqkjXQNTY31Eqt0E
  /VSS3Xz8otKMnQN9RLLi/VSi4v1iitzk3NS9PJSSzYxAqMtpTht5g7GLft+6R1ilORgUhLlvX
  pUKVmILyk/pTIjsTgjvqg0J7X4EKMMB4eSBC/fV6CcYFFqempFWmYOMPJh0hIcPEoivJVvgNK
  8xQWJucWZ6RCpU4zGHOd37t/LzDFv9r/9zEIsefl5qVLivIt+AJUKgJRmlObBDYIlpEuMslLC
  vIwMDAxCPAWpRbmZJajyrxjFORiVhHl7vgNN4cnMK4Hb9wroFCagU4ys5UFOKUlESEk1MJ37I
  jfh8WKW/Dkpk+6vOxBZus7IS2ZLTcOt/yvmzXS/NpupaF69+ZbvUau8PrwKczuw77BwlX+b5f
  93VTG1/79F8Fy/bPbrQ71J7RPZtdZFH7mySx39vlW84xG9d2ZqLOvslRl+W+Vqnd793e5Uwv5
  k6g+ZOOvzR1Y5CamKd3+OUTXwvjJnhknJzcvtK90LD7BeOVt58cWhjcv37mjoXbuwOJxh9ouy
  l6/UM6dve2Rru/hc35ypRWerd7fJyh2J1+ETX9W3S/2OWduSxNZdmVVdJXM+3JvkuFFS3HP/M
  97nR5V/2UY2fvXOqTj7PHN1d+mxHkd53Q8Zhzh+P9W87SN1lJ/h834WCY4XebnhprVKLMUZiY
  ZazEXFiQBFIIukwwMAAA==
X-Env-Sender: yangx.jy@fujitsu.com
X-Msg-Ref: server-10.tower-732.messagelabs.com!1663236886!10008!1
X-Originating-IP: [62.60.8.97]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.87.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 31016 invoked from network); 15 Sep 2022 10:14:46 -0000
Received: from unknown (HELO n03ukasimr01.n03.fujitsu.local) (62.60.8.97)
  by server-10.tower-732.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 15 Sep 2022 10:14:46 -0000
Received: from n03ukasimr01.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTP id 3BC87100194;
        Thu, 15 Sep 2022 11:14:46 +0100 (BST)
Received: from R01UKEXCASM121.r01.fujitsu.local (R01UKEXCASM121 [10.183.43.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTPS id 2F3B1100191;
        Thu, 15 Sep 2022 11:14:46 +0100 (BST)
Received: from [10.167.215.54] (10.167.215.54) by
 R01UKEXCASM121.r01.fujitsu.local (10.183.43.173) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Thu, 15 Sep 2022 11:14:39 +0100
Message-ID: <a6e7f4eb-0664-bbe8-98d2-f8386b226113@fujitsu.com>
Date:   Thu, 15 Sep 2022 18:14:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] xfs: fail dax mount if reflink is enabled on a partition
To:     "Darrick J. Wong" <djwong@kernel.org>,
        Brian Foster <bfoster@redhat.com>
CC:     =?UTF-8?B?UnVhbiwgU2hpeWFuZy/pmK4g5LiW6Ziz?= 
        <ruansy.fnst@fujitsu.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "david@fromorbit.com" <david@fromorbit.com>,
        "hch@infradead.org" <hch@infradead.org>
References: <Ytl7yJJL1fdC006S@magnolia>
 <7fde89dc-2e8f-967b-d342-eb334e80255c@fujitsu.com>
 <YuNn9NkUFofmrXRG@magnolia>
 <0ea1cbe1-79d7-c22b-58bf-5860a961b680@fujitsu.com>
 <YusYDMXLYxzqMENY@magnolia>
 <dd363bd8-2dbd-5d9c-0406-380b60c5f510@fujitsu.com> <Yxs5Jb7Yt2c6R6eW@bfoster>
 <7fdc9e88-f255-6edb-7964-a5a82e9b1292@fujitsu.com>
 <76ea04b4-bad7-8cb3-d2c6-4ad49def4e05@fujitsu.com> <YyHKUhOgHdTKPQXL@bfoster>
 <YyIBMJzmbZsUBHpy@magnolia>
From:   =?UTF-8?B?WWFuZywgWGlhby/mnagg5pmT?= <yangx.jy@fujitsu.com>
In-Reply-To: <YyIBMJzmbZsUBHpy@magnolia>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.167.215.54]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM121.r01.fujitsu.local (10.183.43.173)
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2022/9/15 0:28, Darrick J. Wong wrote:
> On Wed, Sep 14, 2022 at 08:34:26AM -0400, Brian Foster wrote:
>> On Wed, Sep 14, 2022 at 05:38:02PM +0800, Yang, Xiao/杨 晓 wrote:
>>> On 2022/9/14 14:44, Yang, Xiao/杨 晓 wrote:
>>>> On 2022/9/9 21:01, Brian Foster wrote:
>>>>> Yes.. I don't recall all the internals of the tools and test, but IIRC
>>>>> it relied on discard to perform zeroing between checkpoints or some such
>>>>> and avoid spurious failures. The purpose of running on dm-thin was
>>>>> merely to provide reliable discard zeroing behavior on the target device
>>>>> and thus to allow the test to run reliably.
>>>> Hi Brian,
>>>>
>>>> As far as I know, generic/470 was original designed to verify
>>>> mmap(MAP_SYNC) on the dm-log-writes device enabling DAX. Due to the
>>>> reason, we need to ensure that all underlying devices under
>>>> dm-log-writes device support DAX. However dm-thin device never supports
>>>> DAX so
>>>> running generic/470 with dm-thin device always returns "not run".
>>>>
>>>> Please see the difference between old and new logic:
>>>>
>>>>             old logic                          new logic
>>>> ---------------------------------------------------------------
>>>> log-writes device(DAX)                 log-writes device(DAX)
>>>>               |                                       |
>>>> PMEM0(DAX) + PMEM1(DAX)       Thin device(non-DAX) + PMEM1(DAX)
>>>>                                             |
>>>>                                           PMEM0(DAX)
>>>> ---------------------------------------------------------------
>>>>
>>>> We think dm-thin device is not a good solution for generic/470, is there
>>>> any other solution to support both discard zero and DAX?
>>>
>>> Hi Brian,
>>>
>>> I have sent a patch[1] to revert your fix because I think it's not good for
>>> generic/470 to use thin volume as my revert patch[1] describes:
>>> [1] https://lore.kernel.org/fstests/20220914090625.32207-1-yangx.jy@fujitsu.com/T/#u
>>>
>>
>> I think the history here is that generic/482 was changed over first in
>> commit 65cc9a235919 ("generic/482: use thin volume as data device"), and
>> then sometime later we realized generic/455,457,470 had the same general
>> flaw and were switched over. The dm/dax compatibility thing was probably
>> just an oversight, but I am a little curious about that because it should
> 
> It's not an oversight -- it used to work (albeit with EXPERIMENTAL
> tags), and now we've broken it on fsdax as the pmem/blockdev divorce
> progresses.
Hi

Do you mean that the following patch set changed the test result of 
generic/470 with thin-volume? (pass => not run/failure)
https://lore.kernel.org/linux-xfs/20211129102203.2243509-1-hch@lst.de/

> 
>> have been obvious that the change caused the test to no longer run. Did
>> something change after that to trigger that change in behavior?
>>
>>> With the revert, generic/470 can always run successfully on my environment
>>> so I wonder how to reproduce the out-of-order replay issue on XFS v5
>>> filesystem?
>>>
>>
>> I don't quite recall the characteristics of the failures beyond that we
>> were seeing spurious test failures with generic/482 that were due to
>> essentially putting the fs/log back in time in a way that wasn't quite
>> accurate due to the clearing by the logwrites tool not taking place. If
>> you wanted to reproduce in order to revisit that, perhaps start with
>> generic/482 and let it run in a loop for a while and see if it
>> eventually triggers a failure/corruption..?
>>
>>> PS: I want to reproduce the issue and try to find a better solution to fix
>>> it.
>>>
>>
>> It's been a while since I looked at any of this tooling to semi-grok how
>> it works.
> 
> I /think/ this was the crux of the problem, back in 2019?
> https://lore.kernel.org/fstests/20190227061529.GF16436@dastard/

Agreed.

> 
>> Perhaps it could learn to rely on something more explicit like
>> zero range (instead of discard?) or fall back to manual zeroing?
> 
> AFAICT src/log-writes/ actually /can/ do zeroing, but (a) it probably
> ought to be adapted to call BLKZEROOUT and (b) in the worst case it
> writes zeroes to the entire device, which is/can be slow.
> 
> For a (crass) example, one of my cloudy test VMs uses 34GB partitions,
> and for cost optimization purposes we're only "paying" for the cheapest
> tier.  Weirdly that maps to an upper limit of 6500 write iops and
> 48MB/s(!) but that would take about 20 minutes to zero the entire
> device if the dm-thin hack wasn't in place.  Frustratingly, it doesn't
> support discard or write-zeroes.

Do you mean that discard zero(BLKDISCARD) is faster than both fill 
zero(BLKZEROOUT) and write zero on user space?

Best Regards,
Xiao Yang
> 
>> If the
>> eventual solution is simple and low enough overhead, it might make some
>> sense to replace the dmthin hack across the set of tests mentioned
>> above.
> 
> That said, for a *pmem* test you'd expect it to be faster than that...
> 
> --D
> 
>> Brian
>>
>>> Best Regards,
>>> Xiao Yang
>>>
>>>>
>>>> BTW, only log-writes, stripe and linear support DAX for now.
>>>
>>
