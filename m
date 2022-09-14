Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 514495B8530
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Sep 2022 11:39:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbiINJjA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Sep 2022 05:39:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231623AbiINJih (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Sep 2022 05:38:37 -0400
Received: from mail3.bemta32.messagelabs.com (mail3.bemta32.messagelabs.com [195.245.230.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D5061D30D;
        Wed, 14 Sep 2022 02:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1663148294; i=@fujitsu.com;
        bh=innjE3mvg9WVMWJzn0D35+35BLJpTlYCkV//jqcaPTo=;
        h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
         In-Reply-To:Content-Type:Content-Transfer-Encoding;
        b=eWRfEpTdDCcjBYExPlWkki9pEX4dQ84IDqVrLIhElUaMXjQXqS/Xu1KLHEbpiswOZ
         WQqtQho3toovWzXIe02pKYbXt7iPQK2H2gq4v5I7f26uNQc8krUGr1hq3cQG2FB8AC
         QFo6WcoAcLbE/GEDQnI8GsZofQ9Ugflh3i6owAYCCEfGnXmsHuWiuSdtnfKDxDB0T3
         Xe72ZatvfhmeiylaNfGNaJmXyCIBvAC2I6x1mYs8DfeRc4DkywUYpHqBgBG+g5a7/w
         hHEikKkwbO8qaOLu+r8DeQfs2ZrhJJe3rLNuVOgtVmzITT5NqS7irFAchd//4WR0l7
         MQn6mRMAHZMYA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrDKsWRWlGSWpSXmKPExsViZ8MxSZd1oWK
  ywctGZYt3n6ssthy7x2hx+QmfxekJi5gs9uw9yWJxedccNotdf3awW6z88YfVgcPj1CIJj80r
  tDw2repk83ixeSajx/t9V9k8Pm+SC2CLYs3MS8qvSGDNeHl2I2vBd/6KjT2LWRoYm3i6GLk4h
  AS2MEocnveRHcJZziTReuw6I4SzjVFiz7oDzF2MHBy8AnYSh3uSuhg5OVgEVCUWbTjEBGLzCg
  hKnJz5hAXEFhVIkri64S4riC0s4CuxdlMfM4jNJuAoMW/WRjaQMSICeRLTFiuBjGcW+MAk0fP
  3NxPErgvMEnf33AZr5hSwl1g25xVYM7OAhcTiNwfZIWx5ieats8HiEgKKEm1L/rFD2BUSjdMh
  DpIQUJO4em4T8wRGoVlI7puFZNQsJKMWMDKvYrRKKspMzyjJTczM0TU0MNA1NDTVNdE1MrbUS
  6zSTdRLLdUtTy0u0TXUSywv1kstLtYrrsxNzknRy0st2cQIjLKUYpb3Oxib+n7qHWKU5GBSEu
  X98FUhWYgvKT+lMiOxOCO+qDQntfgQowwHh5IE7/65islCgkWp6akVaZk5wIiHSUtw8CiJ8Or
  NAUrzFhck5hZnpkOkTjEac5zfuX8vM8e82f/2Mwux5OXnpUqJ866cD1QqAFKaUZoHNwiWiC4x
  ykoJ8zIyMDAI8RSkFuVmlqDKv2IU52BUEub9OA9oCk9mXgncvldApzABnWJkLQ9ySkkiQkqqg
  UlM6q6KVGtzXo7vbLXDB/2mv1XRFLEuTpnhvN6v/v7cDYrmWyPTKndkl0kucZWoM7tfJXPdSU
  RIqHjyI+m9Pw0f7y95Nyt1dpmAQM4N77pnP389W1+m7Fxb6tVq8fWATMOjvIby4O8Z3w2nHWq
  qXDf91JrdVRnRc+Zs4NV73u7Q/jrolVFS+613shdlFHLVBY/z7+lW1i9ctnLzHZbW+gkfuRjs
  H/3gzup4LJ+hkn2k7/+PQGPJH4+Ka3tOSPeoy7JOfT37M++p7Rx69wrsC1pYO7qXX9ggnBK5w
  nZWlDOzyD3Tl8E2MaWOX7/mPjvCOzVX9qTE1e+XJpZcl8/6594Qa8fjduybN+sDxt/xSizFGY
  mGWsxFxYkAcPuL/L8DAAA=
X-Env-Sender: yangx.jy@fujitsu.com
X-Msg-Ref: server-10.tower-585.messagelabs.com!1663148293!213906!1
X-Originating-IP: [62.60.8.146]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.87.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 25920 invoked from network); 14 Sep 2022 09:38:13 -0000
Received: from unknown (HELO n03ukasimr02.n03.fujitsu.local) (62.60.8.146)
  by server-10.tower-585.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 14 Sep 2022 09:38:13 -0000
Received: from n03ukasimr02.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTP id 27CF01000CC;
        Wed, 14 Sep 2022 10:38:13 +0100 (BST)
Received: from R01UKEXCASM121.r01.fujitsu.local (R01UKEXCASM121 [10.183.43.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTPS id 1AAEB100078;
        Wed, 14 Sep 2022 10:38:13 +0100 (BST)
Received: from [10.167.215.54] (10.167.215.54) by
 R01UKEXCASM121.r01.fujitsu.local (10.183.43.173) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Wed, 14 Sep 2022 10:38:09 +0100
Message-ID: <76ea04b4-bad7-8cb3-d2c6-4ad49def4e05@fujitsu.com>
Date:   Wed, 14 Sep 2022 17:38:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] xfs: fail dax mount if reflink is enabled on a partition
From:   =?UTF-8?B?WWFuZywgWGlhby/mnagg5pmT?= <yangx.jy@fujitsu.com>
To:     Brian Foster <bfoster@redhat.com>,
        =?UTF-8?B?UnVhbiwgU2hpeWFuZy/pmK4g5LiW6Ziz?= 
        <ruansy.fnst@fujitsu.com>
CC:     "Darrick J. Wong" <djwong@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "david@fromorbit.com" <david@fromorbit.com>,
        "hch@infradead.org" <hch@infradead.org>
References: <20220609143435.393724-1-ruansy.fnst@fujitsu.com>
 <Yr5AV5HaleJXMmUm@magnolia>
 <74b0a034-8c77-5136-3fbd-4affb841edcb@fujitsu.com>
 <Ytl7yJJL1fdC006S@magnolia>
 <7fde89dc-2e8f-967b-d342-eb334e80255c@fujitsu.com>
 <YuNn9NkUFofmrXRG@magnolia>
 <0ea1cbe1-79d7-c22b-58bf-5860a961b680@fujitsu.com>
 <YusYDMXLYxzqMENY@magnolia>
 <dd363bd8-2dbd-5d9c-0406-380b60c5f510@fujitsu.com> <Yxs5Jb7Yt2c6R6eW@bfoster>
 <7fdc9e88-f255-6edb-7964-a5a82e9b1292@fujitsu.com>
In-Reply-To: <7fdc9e88-f255-6edb-7964-a5a82e9b1292@fujitsu.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.167.215.54]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM121.r01.fujitsu.local (10.183.43.173)
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2022/9/14 14:44, Yang, Xiao/杨 晓 wrote:
> On 2022/9/9 21:01, Brian Foster wrote:
>> Yes.. I don't recall all the internals of the tools and test, but IIRC
>> it relied on discard to perform zeroing between checkpoints or some such
>> and avoid spurious failures. The purpose of running on dm-thin was
>> merely to provide reliable discard zeroing behavior on the target device
>> and thus to allow the test to run reliably.
> Hi Brian,
> 
> As far as I know, generic/470 was original designed to verify
> mmap(MAP_SYNC) on the dm-log-writes device enabling DAX. Due to the
> reason, we need to ensure that all underlying devices under
> dm-log-writes device support DAX. However dm-thin device never supports
> DAX so
> running generic/470 with dm-thin device always returns "not run".
> 
> Please see the difference between old and new logic:
> 
>            old logic                          new logic
> ---------------------------------------------------------------
> log-writes device(DAX)                 log-writes device(DAX)
>              |                                       |
> PMEM0(DAX) + PMEM1(DAX)       Thin device(non-DAX) + PMEM1(DAX)
>                                            |
>                                          PMEM0(DAX)
> ---------------------------------------------------------------
> 
> We think dm-thin device is not a good solution for generic/470, is there
> any other solution to support both discard zero and DAX?

Hi Brian,

I have sent a patch[1] to revert your fix because I think it's not good 
for generic/470 to use thin volume as my revert patch[1] describes:
[1] 
https://lore.kernel.org/fstests/20220914090625.32207-1-yangx.jy@fujitsu.com/T/#u

With the revert, generic/470 can always run successfully on my 
environment so I wonder how to reproduce the out-of-order replay issue 
on XFS v5 filesystem?

PS: I want to reproduce the issue and try to find a better solution to 
fix it.

Best Regards,
Xiao Yang

> 
> BTW, only log-writes, stripe and linear support DAX for now.
