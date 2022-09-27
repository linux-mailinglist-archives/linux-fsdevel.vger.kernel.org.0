Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B61955EBB02
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Sep 2022 08:53:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230170AbiI0Gxb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Sep 2022 02:53:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbiI0Gx3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Sep 2022 02:53:29 -0400
Received: from mail1.bemta37.messagelabs.com (mail1.bemta37.messagelabs.com [85.158.142.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A3879C220;
        Mon, 26 Sep 2022 23:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1664261606; i=@fujitsu.com;
        bh=yK1nJqacLKSnBPbpCxG30WNnRavYzcEhiUqR5c17txg=;
        h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
         In-Reply-To:Content-Type:Content-Transfer-Encoding;
        b=R23i5HjYUBhWfivtYdEPFNSJXwP/5LVQrprSz35FF2tqoL21Fka0rdLmyWQpDBpv8
         Hl7b0EuzmBfxgwZBNPGO01cu9b3joujpyLs0Xe0RbmWbWSlMFeEFQ2W6oT2Z1mzymF
         yva5839JelhKSUk+GASxfTChEROLDfQ7BngTzRkjxnsouJDN2ggPQK8rlGtFf9tzDv
         19Pa72Kx3rNV5wk5VjurfvRi+KibYaiC/0kqNVCfMHPL1IQlR5fsL9EeayJE7sZ0n5
         AUvfXv3vWq376H8IuMtButHCgxHV+2axHshlTbpWSwlIyAPiVAcjepOqm3cQ8ibthq
         gzrTw/ONYebcw==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNKsWRWlGSWpSXmKPExsViZ8ORpPt0rlG
  ywbN2JYvpUy8wWmw5do/R4vITPos9e0+yWFzeNYfN4t6a/6wWu/7sYLdY+eMPqwOHx6lFEh6L
  97xk8ti0qpPNY9OnSeweLzbPZPT4vEkugC2KNTMvKb8igTVj9o+LbAU3tCvWbd/E1sDYotrFy
  MUhJLCRUWJx83JWCGcJk8S706uZIZztjBLX77QDOZwcvAJ2Evubf7CD2CwCqhL7Js5mgogLSp
  yc+YQFxBYVSJb4OvUiWFxYwFHi1dQWRhBbREBNYtKkHWBDmQWOMEr8WN7CDrWOUeLk5EtgU9k
  EdCQuLPjLCmJzClhLTDw3AcxmFrCQWPzmIDuELS/RvHU20CQODgkBJYmZ3fEgYQmBConG6YeY
  IGw1iavnNjFPYBSaheS+WUgmzUIyaQEj8ypGm6SizPSMktzEzBxdQwMDXUNDU11LM11DY0O9x
  CrdRL3UUt28/KKSDF0gv7xYL7W4WK+4Mjc5J0UvL7VkEyMw3lKKE5p3MN7b90vvEKMkB5OSKG
  98j1GyEF9SfkplRmJxRnxRaU5q8SFGGQ4OJQnezllAOcGi1PTUirTMHGDsw6QlOHiURHg/zQB
  K8xYXJOYWZ6ZDpE4x6nJMnf1vP7MQS15+XqqUOO9MkBkCIEUZpXlwI2Bp6BKjrJQwLyMDA4MQ
  T0FqUW5mCar8K0ZxDkYlYd6Q2UBTeDLzSuA2vQI6ggnoCDs+fZAjShIRUlINTBP+7p64PKCpR
  SFwrvv9njVsdre+X7Pp+GE/Z0mQh/HyGc8+pFk7RZ+uCORZ5b15FVPGpQP1dsYmloKWn98dWh
  Amssa5ynLL+ctRPVOPNrwU3jjt4IpLJx/sMShNV1+gyst3dv7640sPN17jOukdyL9f27BwYaV
  Ft7WUk25+W3i3p5nh2rw1/7bIFajbs0RddNw4I2OrmoR9ru0TH6V5c5iSNxnf7uHpkd/p+5HH
  iMVBOpZxYeO+tZNeXk3pO3qmef8vma17NFilv3RPaOue5P9w8/lZ88+k14cW6CtFKtk9/KDR/
  1Zpd6/lBc6yHRG5ixZ3Czbr/2aPPM42O3LGM3vRLa7P9ty5r8e1Nab+qxJLcUaioRZzUXEiAE
  pCBay+AwAA
X-Env-Sender: ruansy.fnst@fujitsu.com
X-Msg-Ref: server-3.tower-745.messagelabs.com!1664261605!330972!1
X-Originating-IP: [62.60.8.98]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.87.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 2978 invoked from network); 27 Sep 2022 06:53:25 -0000
Received: from unknown (HELO n03ukasimr03.n03.fujitsu.local) (62.60.8.98)
  by server-3.tower-745.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 27 Sep 2022 06:53:25 -0000
Received: from n03ukasimr03.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr03.n03.fujitsu.local (Postfix) with ESMTP id DA53A1AD;
        Tue, 27 Sep 2022 07:53:24 +0100 (BST)
Received: from R01UKEXCASM121.r01.fujitsu.local (R01UKEXCASM121 [10.183.43.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr03.n03.fujitsu.local (Postfix) with ESMTPS id CEB661AB;
        Tue, 27 Sep 2022 07:53:24 +0100 (BST)
Received: from [192.168.22.78] (10.167.225.141) by
 R01UKEXCASM121.r01.fujitsu.local (10.183.43.173) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Tue, 27 Sep 2022 07:53:21 +0100
Message-ID: <f10de555-370b-f236-1107-e3089258ebbc@fujitsu.com>
Date:   Tue, 27 Sep 2022 14:53:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [RFC PATCH] xfs: drop experimental warning for fsdax
To:     Dave Chinner <david@fromorbit.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
        <nvdimm@lists.linux.dev>, <linux-mm@kvack.org>,
        <linux-fsdevel@vger.kernel.org>, <djwong@kernel.org>,
        <dan.j.williams@intel.com>
References: <1663234002-17-1-git-send-email-ruansy.fnst@fujitsu.com>
 <20220919045003.GJ3600936@dread.disaster.area>
 <20220919211533.GK3600936@dread.disaster.area>
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
In-Reply-To: <20220919211533.GK3600936@dread.disaster.area>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.167.225.141]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM121.r01.fujitsu.local (10.183.43.173)
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



在 2022/9/20 5:15, Dave Chinner 写道:
> On Mon, Sep 19, 2022 at 02:50:03PM +1000, Dave Chinner wrote:
>> On Thu, Sep 15, 2022 at 09:26:42AM +0000, Shiyang Ruan wrote:
>>> Since reflink&fsdax can work together now, the last obstacle has been
>>> resolved.  It's time to remove restrictions and drop this warning.
>>>
>>> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
>>
>> I haven't looked at reflink+DAX for some time, and I haven't tested
>> it for even longer. So I'm currently running a v6.0-rc6 kernel with
>> "-o dax=always" fstests run with reflink enabled and it's not
>> looking very promising.
>>
>> All of the fsx tests are failing with data corruption, several
>> reflink/clone tests are failing with -EINVAL (e.g. g/16[45]) and
>> *lots* of tests are leaving stack traces from WARN() conditions in
>> DAx operations such as dax_insert_entry(), dax_disassociate_entry(),
>> dax_writeback_mapping_range(), iomap_iter() (called from
>> dax_dedupe_file_range_compare()), and so on.
>>
>> At thsi point - the tests are still running - I'd guess that there's
>> going to be at least 50 test failures by the time it completes -
>> in comparison using "-o dax=never" results in just a single test
>> failure and a lot more tests actually being run.
> 
> The end results with dax+reflink were:
> 
> SECTION       -- xfs_dax
> =========================
> 
> Failures: generic/051 generic/068 generic/074 generic/075
> generic/083 generic/091 generic/112 generic/127 generic/164
> generic/165 generic/175 generic/231 generic/232 generic/247
> generic/269 generic/270 generic/327 generic/340 generic/388
> generic/390 generic/413 generic/447 generic/461 generic/471
> generic/476 generic/517 generic/519 generic/560 generic/561
> generic/605 generic/617 generic/619 generic/630 generic/649
> generic/650 generic/656 generic/670 generic/672 xfs/011 xfs/013
> xfs/017 xfs/068 xfs/073 xfs/104 xfs/127 xfs/137 xfs/141 xfs/158
> xfs/168 xfs/179 xfs/243 xfs/297 xfs/305 xfs/328 xfs/440 xfs/442
> xfs/517 xfs/535 xfs/538 xfs/551 xfs/552
> Failed 61 of 1071 tests
> 
> Ok, so I did a new no-reflink run as a baseline, because it is a
> while since I've tested DAX at all:
> 
> SECTION       -- xfs_dax_noreflink
> =========================
> Failures: generic/051 generic/068 generic/074 generic/075
> generic/083 generic/112 generic/231 generic/232 generic/269
> generic/270 generic/340 generic/388 generic/461 generic/471
> generic/476 generic/519 generic/560 generic/561 generic/617
> generic/650 generic/656 xfs/011 xfs/013 xfs/017 xfs/073 xfs/297
> xfs/305 xfs/517 xfs/538
> Failed 29 of 1071 tests
> 
> Yeah, there's still lots of warnings from dax_insert_entry() and
> friends like:
> 
> [43262.025815] WARNING: CPU: 9 PID: 1309428 at fs/dax.c:380 dax_insert_entry+0x2ab/0x320
> [43262.028355] Modules linked in:
> [43262.029386] CPU: 9 PID: 1309428 Comm: fsstress Tainted: G W          6.0.0-rc6-dgc+ #1543
> [43262.032168] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
> [43262.034840] RIP: 0010:dax_insert_entry+0x2ab/0x320
> [43262.036358] Code: 08 48 83 c4 30 5b 5d 41 5c 41 5d 41 5e 41 5f c3 48 8b 58 20 48 8d 53 01 e9 65 ff ff ff 48 8b 58 20 48 8d 53 01 e9 50 ff ff ff <0f> 0b e9 70 ff ff ff 31 f6 4c 89 e7 e8 84 b1 5a 00 eb a4 48 81 e6
> [43262.042255] RSP: 0018:ffffc9000a0cbb78 EFLAGS: 00010002
> [43262.043946] RAX: ffffea0018cd1fc0 RBX: 0000000000000001 RCX: 0000000000000001
> [43262.046233] RDX: ffffea0000000000 RSI: 0000000000000221 RDI: ffffea0018cd2000
> [43262.048518] RBP: 0000000000000011 R08: 0000000000000000 R09: 0000000000000000
> [43262.050762] R10: ffff888241a6d318 R11: 0000000000000001 R12: ffffc9000a0cbc58
> [43262.053020] R13: ffff888241a6d318 R14: ffffc9000a0cbe20 R15: 0000000000000000
> [43262.055309] FS:  00007f8ce25e2b80(0000) GS:ffff8885fec80000(0000) knlGS:0000000000000000
> [43262.057859] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [43262.059713] CR2: 00007f8ce25e1000 CR3: 0000000152141001 CR4: 0000000000060ee0
> [43262.061993] Call Trace:
> [43262.062836]  <TASK>
> [43262.063557]  dax_fault_iter+0x243/0x600
> [43262.064802]  dax_iomap_pte_fault+0x199/0x360
> [43262.066197]  __xfs_filemap_fault+0x1e3/0x2c0
> [43262.067602]  __do_fault+0x31/0x1d0
> [43262.068719]  __handle_mm_fault+0xd6d/0x1650
> [43262.070083]  ? do_mmap+0x348/0x540
> [43262.071200]  handle_mm_fault+0x7a/0x1d0
> [43262.072449]  ? __kvm_handle_async_pf+0x12/0xb0
> [43262.073908]  exc_page_fault+0x1d9/0x810
> [43262.075123]  asm_exc_page_fault+0x22/0x30
> [43262.076413] RIP: 0033:0x7f8ce268bc23
> 
> So it looks to me like DAX is well and truly broken in 6.0-rc6. And,
> yes, I'm running the fixes in mm-hotifxes-stable branch that allow
> xfs/550 to pass.

I have tested these two mode for many times:

xfs_dax mode did failed so many cases.  (If you tested with this "drop" 
patch, some warning around "dax_dedupe_file_range_compare()" won't occur 
any more.)  I think warning around "dax_disassociate_entry()" is a 
problem with concurrency.  Still looking into it.

But xfs_dax_noreflink didn't have so many failure, just 3 in my 
environment: Failures: generic/471 generic/519 xfs/148.  I am thinking 
that did you forget to reformat the TEST_DEV to be non-reflink before 
run the test?  If so it will make sense.


--
Thanks,
Ruan.

> 
> Who is actually testing this DAX code, and what are they actually
> testing on? These are not random failures - I haven't run DAX
> testing since ~5.18, and none of these failures were present on the
> same DAX test VM running the same configuration back then....
> 
> -Dave.
