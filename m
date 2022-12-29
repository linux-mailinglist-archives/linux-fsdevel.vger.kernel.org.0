Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 365B7658A79
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Dec 2022 09:23:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233170AbiL2IXa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Dec 2022 03:23:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbiL2IX3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Dec 2022 03:23:29 -0500
Received: from mail1.bemta32.messagelabs.com (mail1.bemta32.messagelabs.com [195.245.230.2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFD7610A9;
        Thu, 29 Dec 2022 00:23:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1672302206; i=@fujitsu.com;
        bh=SUSAOyphF+B29lskscxDvTF3FQCewU2rscBGHhh6gm4=;
        h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
         In-Reply-To:Content-Type:Content-Transfer-Encoding;
        b=FjqWGmTuFguN7i+NUk81QEUGiW8CeKad7QUINXYTukOPyE5khuoATs0HniXwcpbn2
         lIkN8gSvbMAdrQ/XeLdJtQImFVu9vLIR2G/ZwnVNqrdfDnh+c2/L3yRMGlJr4r7JD0
         7wfU33sUye7vLx3sikmain6l+oR6dbBr3v0NMxuEDwKuUSvNbCysTYRQvipuN74MAQ
         nllZfIGy02JtktXivHkXnHSv9lOA6NPcs2yVK/kJCAO16fQKMCjZOoTnZSmqTcKD4i
         cjMmDbylN42AiqOHv1NgslfvuO3WOINBLNFhdiRivLOnRTLmD5jJ8s5iSwuhX9DYc4
         3dJ6bAH6hRHdA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrCKsWRWlGSWpSXmKPExsViZ8ORpFvjtzb
  Z4PkyfYs569ewWUyfeoHRYsuxe4wWl5/wWezZe5LF4vKuOWwWu/7sYLdY+eMPqwOHx6lFEh6L
  97xk8ti0qpPN48SM3yweLzbPZPT4vEkugC2KNTMvKb8igTXj0KuJjAWXJCru/rzC1MC4SLiLk
  YtDSGAjo0THw4ksEM5iJonLZ68yQzg7GCVeX/rG1MXIycErYCex9OgZMJtFQFXi8cMv7BBxQY
  mTM5+wgNiiAskSL45+YwSxhQWsJaaufczaxcjBISJQKnHqYxZImFmgWmLi3/NQ85sYJVafmsg
  MkmAT0JG4sOAvK4jNKeAp8WHlX2aIBguJxW8OskPY8hLNW2eDxSUElCR6G96zQtgVErNmtTFB
  2GoSV89tYp7AKDQLyXmzkIyahWTUAkbmVYxmxalFZalFuoYmeklFmekZJbmJmTl6iVW6iXqpp
  brlqcUluoZ6ieXFeqnFxXrFlbnJOSl6eaklmxiBEZZSzLZqB+OvZX/0DjFKcjApifJm2K1NFu
  JLyk+pzEgszogvKs1JLT7EKMPBoSTBG+YNlBMsSk1PrUjLzAFGO0xagoNHSYR3Hkiat7ggMbc
  4Mx0idYpRl2Ntw4G9zEIsefl5qVLivI6+QEUCIEUZpXlwI2CJ5xKjrJQwLyMDA4MQT0FqUW5m
  Car8K0ZxDkYlYd54H6ApPJl5JXCbXgEdwQR0xIdDK0GOKElESEk1MEm8KLrSwRd5fEkt370To
  hWHo/5HPZxkqnrqiLOTl0fbgbl7rnCtSVQR7bp39vjlDen8NrWLNe7v6phVsX4/5467lpYurr
  fvTxeW2TpRkNG961pboNDhKXe/uHH6GLIqiDi/27oiTdhj88Se2PDDBhNZU3adE2K/bfdO/g7
  jmsTQydwsZ24krJzLzZ6y9N/52SU7mBx00/PL1ylJzStme+PpeMnq5rzAlAnmWZXBnrPmri9T
  yhZmUp7zZ4IHg9Dhm1l1b25q/Kk2+smw5CK34NMnU+WqqiQvNDpH+kQ6rrlmJia1IO36FYv8r
  t7+68Y1l2NdV6nGme6eYhuhuHud2hkBuQkfryyceaGt3WLjOiWW4oxEQy3mouJEAD4S2ja3Aw
  AA
X-Env-Sender: ruansy.fnst@fujitsu.com
X-Msg-Ref: server-9.tower-587.messagelabs.com!1672302204!842!1
X-Originating-IP: [62.60.8.98]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.101.2; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 12139 invoked from network); 29 Dec 2022 08:23:24 -0000
Received: from unknown (HELO n03ukasimr03.n03.fujitsu.local) (62.60.8.98)
  by server-9.tower-587.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 29 Dec 2022 08:23:24 -0000
Received: from n03ukasimr03.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr03.n03.fujitsu.local (Postfix) with ESMTP id 517BD1B1;
        Thu, 29 Dec 2022 08:23:24 +0000 (GMT)
Received: from R01UKEXCASM126.r01.fujitsu.local (R01UKEXCASM126 [10.183.43.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr03.n03.fujitsu.local (Postfix) with ESMTPS id 4604B7B;
        Thu, 29 Dec 2022 08:23:24 +0000 (GMT)
Received: from [10.167.201.145] (10.167.201.145) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.42; Thu, 29 Dec 2022 08:23:20 +0000
Message-ID: <5bbe8d22-0cdb-9c6f-d568-c183c4bd7dbe@fujitsu.com>
Date:   Thu, 29 Dec 2022 16:23:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2 0/8] fsdax,xfs: fix warning messages
To:     Dan Williams <dan.j.williams@intel.com>, <djwong@kernel.org>,
        <david@fromorbit.com>, <akpm@linux-foundation.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
        <nvdimm@lists.linux.dev>, <linux-fsdevel@vger.kernel.org>
References: <1669908538-55-1-git-send-email-ruansy.fnst@fujitsu.com>
 <638aa4a298879_3cbe0294ba@dwillia2-xfh.jf.intel.com.notmuch>
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
In-Reply-To: <638aa4a298879_3cbe0294ba@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.167.201.145]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



在 2022/12/3 9:21, Dan Williams 写道:
> Shiyang Ruan wrote:
>> Changes since v1:
>>   1. Added a snippet of the warning message and some of the failed cases
>>   2. Separated the patch for easily review
>>   3. Added page->share and its helper functions
>>   4. Included the patch[1] that removes the restrictions of fsdax and reflink
>> [1] https://lore.kernel.org/linux-xfs/1663234002-17-1-git-send-email-ruansy.fnst@fujitsu.com/
>>
...
>>
>> This also effects dax+noreflink mode if we run the test after a
>> dax+reflink test.  So, the most urgent thing is solving the warning
>> messages.
>>
>> With these fixes, most warning messages in dax_associate_entry() are
>> gone.  But honestly, generic/388 will randomly failed with the warning.
>> The case shutdown the xfs when fsstress is running, and do it for many
>> times.  I think the reason is that dax pages in use are not able to be
>> invalidated in time when fs is shutdown.  The next time dax page to be
>> associated, it still remains the mapping value set last time.  I'll keep
>> on solving it.
> 
> This one also sounds like it is going to be relevant for CXL PMEM, and
> the improvements to the reference counting. CXL has a facility where the
> driver asserts that no more writes are in-flight to the device so that
> the device can assert a clean shutdown. Part of that will be making sure
> that page access ends at fs shutdown.

I was trying to locate the root cause of the fail on generic/388.  But 
since it's a fsstress test, I can't relpay the operation sequence to 
help me locate the operations.  So, I tried to replace fsstress with 
fsx, which can do replay after the case fails, but it can't reproduce 
the fail.  I think another important factor is that fsstress tests with 
multiple threads.  So, for now, it's hard for me to locate the cause by 
running the test.

Then I updated the kernel to the latest v6.2-rc1 and run generic/388 for 
many times.  The warning dmesg doesn't show any more.

How is your test on this case?  Does it still fail on the latest kernel? 
  If so, I think I have to keep on locating the cause, and need your advice.


--
Thanks,
Ruan.

> 
>> The warning message in dax_writeback_one() can also be fixed because of
>> the dax unshare.
>>
>>
>> Shiyang Ruan (8):
>>    fsdax: introduce page->share for fsdax in reflink mode
>>    fsdax: invalidate pages when CoW
>>    fsdax: zero the edges if source is HOLE or UNWRITTEN
>>    fsdax,xfs: set the shared flag when file extent is shared
>>    fsdax: dedupe: iter two files at the same time
>>    xfs: use dax ops for zero and truncate in fsdax mode
>>    fsdax,xfs: port unshare to fsdax
>>    xfs: remove restrictions for fsdax and reflink
>>
>>   fs/dax.c                   | 220 +++++++++++++++++++++++++------------
>>   fs/xfs/xfs_ioctl.c         |   4 -
>>   fs/xfs/xfs_iomap.c         |   6 +-
>>   fs/xfs/xfs_iops.c          |   4 -
>>   fs/xfs/xfs_reflink.c       |   8 +-
>>   include/linux/dax.h        |   2 +
>>   include/linux/mm_types.h   |   5 +-
>>   include/linux/page-flags.h |   2 +-
>>   8 files changed, 166 insertions(+), 85 deletions(-)
>>
>> -- 
>> 2.38.1
>>
>>
> 
> 
