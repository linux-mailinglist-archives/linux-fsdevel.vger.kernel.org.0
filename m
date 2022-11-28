Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B90DF639F60
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Nov 2022 03:16:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbiK1CQl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 27 Nov 2022 21:16:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbiK1CQh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 27 Nov 2022 21:16:37 -0500
Received: from mail1.bemta32.messagelabs.com (mail1.bemta32.messagelabs.com [195.245.230.2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E662FE7;
        Sun, 27 Nov 2022 18:16:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1669601794; i=@fujitsu.com;
        bh=TwTlIt2eIgARO/bxfsCvSmRj8m2zdwxth+ui333Yj8U=;
        h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
         In-Reply-To:Content-Type:Content-Transfer-Encoding;
        b=KPz5pnQvf10uuOe8wgQEfsy7xbbnkbso+vZ7YCRbInP0PQVi38EyCZ7m51PZirfUB
         Edr/wcp+kSRJBQsP89IONSiVwT+qr+wa+/tBZyyOYdEmeKFvjzL2iP/omDnUvdVFc3
         B91avo87U11HEVaMGU7KGVWzpJWa1l2egCUplZ3Nj6PBxoPHVQWsmgxWrTJ3km2auB
         OQzlm8iNSgfH51O2yt6ZH/Qxc4gLE0p3KU4n73BEuUue+q81dYn/bRvmnrds1ZV4T0
         RTeCl4AbhJ0MqH0EMSXE5MLaTjUoZJXQm+N+r/kHWl1WAmtXqi+TDskKZHGJd8+3wH
         UNVPzfz+27fNQ==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHKsWRWlGSWpSXmKPExsViZ8ORpMsg1ZJ
  scPC0tsX0qRcYLbYcu8docfkJn8WevSdZLC7vmsNmsevPDnaLlT/+sDqwe5xaJOGxeM9LJo9N
  qzrZPF5snsno8XmTXABrFGtmXlJ+RQJrxuHD8QW7+Cu+rd/M3MC4h6eLkYtDSGAjo8T31d/Zu
  xg5gZzFTBLz3ztDJLYxSqycs5UZJMErYCexrGMuK4jNIqAq0bN9GwtEXFDi5MwnYLaoQLJEX/
  9MNhBbWMBC4s6+7WC9IgKaEke+XWMCsZkF1jNKbOkUhFiWKHHgAUScTUBH4sKCv2DzOQU0JO5
  cecMMUW8hsfjNQXYIW16ieetssLiEgKJEw/05TBB2hcSsWW1QtprE1XObmCcwCs1Cct4sJKNm
  IRm1gJF5FaNZcWpRWWqRrqGhXlJRZnpGSW5iZo5eYpVuol5qqW55anGJrqFeYnmxXmpxsV5xZ
  W5yTopeXmrJJkZgJKUUM0zfwfhz2R+9Q4ySHExKorwLLzUlC/El5adUZiQWZ8QXleakFh9ilO
  HgUJLgVRdoSRYSLEpNT61Iy8wBRjVMWoKDR0mEdxULUJq3uCAxtzgzHSJ1itGYY23Dgb3MHJP
  +XNvLLMSSl5+XKiXOe1wMqFQApDSjNA9uECzZXGKUlRLmZWRgYBDiKUgtys0sQZV/xSjOwagk
  zDsLZApPZl4J3L5XQKcwAZ2ySbEJ5JSSRISUVAOTvTUzY4ad9u2ei3+cvbhVfz3l4pBcNql9I
  1vovD0Sq+4FHLfsjJAtnLwq7MupvyuKqhfEc3d5vWy6sPtQsMERPXEGscqLbu7Wxf++RDX9W2
  jOdDp1d16Rwd7043t2bDyxadHrt/e717RNZMnJvMpwlf9U5QKmNxO+i1/bPptJ0cnbevd78SL
  vef9/NdRnrXKYtvS3DE/m1Wpf4a/bGjrnGS3cE2z3PkTyJWukMk/3Qt+QeNW+vDWL9y8zeKZ4
  sOHgsdj0Sa218bfTuX8nMz0ubaqfp3T1RebZZNVNmiovHGuzWX2N5kyavONkoHXS48YvwnyT/
  nvIVdo81lxhc+ZOzvk3bw3vnT+wTV1g6QFjJZbijERDLeai4kQA45xWqrEDAAA=
X-Env-Sender: ruansy.fnst@fujitsu.com
X-Msg-Ref: server-19.tower-587.messagelabs.com!1669601792!191793!1
X-Originating-IP: [62.60.8.98]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.101.1; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 3126 invoked from network); 28 Nov 2022 02:16:32 -0000
Received: from unknown (HELO n03ukasimr03.n03.fujitsu.local) (62.60.8.98)
  by server-19.tower-587.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 28 Nov 2022 02:16:32 -0000
Received: from n03ukasimr03.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr03.n03.fujitsu.local (Postfix) with ESMTP id 5315F1AC;
        Mon, 28 Nov 2022 02:16:32 +0000 (GMT)
Received: from R01UKEXCASM126.r01.fujitsu.local (R01UKEXCASM126 [10.183.43.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr03.n03.fujitsu.local (Postfix) with ESMTPS id 47DA97B;
        Mon, 28 Nov 2022 02:16:32 +0000 (GMT)
Received: from [10.167.216.27] (10.167.216.27) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Mon, 28 Nov 2022 02:16:29 +0000
Message-ID: <113e8b0d-7349-94ac-c017-3624c34fe73b@fujitsu.com>
Date:   Mon, 28 Nov 2022 10:16:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 0/2] fsdax,xfs: fix warning messages
To:     "Darrick J. Wong" <djwong@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
        <nvdimm@lists.linux.dev>, <linux-fsdevel@vger.kernel.org>,
        <david@fromorbit.com>, <dan.j.williams@intel.com>
References: <1669301694-16-1-git-send-email-ruansy.fnst@fujitsu.com>
 <Y4OuntOVjId9FLzL@magnolia>
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
In-Reply-To: <Y4OuntOVjId9FLzL@magnolia>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.167.216.27]
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



在 2022/11/28 2:38, Darrick J. Wong 写道:
> On Thu, Nov 24, 2022 at 02:54:52PM +0000, Shiyang Ruan wrote:
>> Many testcases failed in dax+reflink mode with warning message in dmesg.
>> This also effects dax+noreflink mode if we run the test after a
>> dax+reflink test.  So, the most urgent thing is solving the warning
>> messages.
>>
>> Patch 1 fixes some mistakes and adds handling of CoW cases not
>> previously considered (srcmap is HOLE or UNWRITTEN).
>> Patch 2 adds the implementation of unshare for fsdax.
>>
>> With these fixes, most warning messages in dax_associate_entry() are
>> gone.  But honestly, generic/388 will randomly failed with the warning.
>> The case shutdown the xfs when fsstress is running, and do it for many
>> times.  I think the reason is that dax pages in use are not able to be
>> invalidated in time when fs is shutdown.  The next time dax page to be
>> associated, it still remains the mapping value set last time.  I'll keep
>> on solving it.
>>
>> The warning message in dax_writeback_one() can also be fixed because of
>> the dax unshare.
> 
> This cuts down the amount of test failures quite a bit, but I think
> you're still missing a piece or two -- namely the part that refuses to
> enable S_DAX mode on a reflinked file when the inode is being loaded
> from disk.  However, thank you for fixing dax.c, because that was the
> part I couldn't figure out at all. :)

I didn't include it[1] in this patchset...

[1] 
https://lore.kernel.org/linux-xfs/1663234002-17-1-git-send-email-ruansy.fnst@fujitsu.com/


--
Thanks,
Ruan.

> 
> --D
> 
>>
>> Shiyang Ruan (2):
>>    fsdax,xfs: fix warning messages at dax_[dis]associate_entry()
>>    fsdax,xfs: port unshare to fsdax
>>
>>   fs/dax.c             | 166 ++++++++++++++++++++++++++++++-------------
>>   fs/xfs/xfs_iomap.c   |   6 +-
>>   fs/xfs/xfs_reflink.c |   8 ++-
>>   include/linux/dax.h  |   2 +
>>   4 files changed, 129 insertions(+), 53 deletions(-)
>>
>> -- 
>> 2.38.1
>>
