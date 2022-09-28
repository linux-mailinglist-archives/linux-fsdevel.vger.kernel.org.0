Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1B3E5EDF18
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Sep 2022 16:46:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234411AbiI1Oqf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Sep 2022 10:46:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233742AbiI1Oqe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Sep 2022 10:46:34 -0400
Received: from mail1.bemta37.messagelabs.com (mail1.bemta37.messagelabs.com [85.158.142.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 306008A1F4;
        Wed, 28 Sep 2022 07:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1664376390; i=@fujitsu.com;
        bh=u+LhVQV/HbjRTQHH0kNWrfjWcEe+JWhmErkOKYcsk2A=;
        h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
         In-Reply-To:Content-Type:Content-Transfer-Encoding;
        b=cHZSyB9HN2XOzMbef7pO8ZmUkUnhT0aHze6ztR798tcggyMuGtrnrxWwowhuCPaQJ
         ndjsmqaOwJkWx8Mljgy2X1GbFJQPSDyQrsK+2367LLB7A+f2qxj6N+2OaDKUdZ+mVd
         8jWT1TDptspIjbpb/msa90ySEYxDD5mVMfz99t7kuWKwGYGebIYshkF0DjVGZvbuuv
         XNgrQbcfFea2JfwvQXY0LbQEUHZKv+UVh4HuYv1NxEWMYVvhfaq8bevCYniQ02n3HE
         2o1vIEwgr/Mst5FLR0YbyPmUqPT3kElNSOTPCf4xTJFKqw8cC1xbWudshWLnYGexTU
         xYXQ8yyCFXiTg==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrDKsWRWlGSWpSXmKPExsViZ8ORpOsaZ5J
  s0NwhbDF96gVGiy3H7jFaXH7CZ7Fn70kWi8u75rBZ3Fvzn9Vi158d7BYrf/xhdeDwOLVIwmPx
  npdMHptWdbJ5bPo0id3jxeaZjB6fN8kFsEWxZuYl5VcksGYcPTWXrWCLa8XebyYNjJNNuxi5O
  IQENjJK9C5sYoVwljBJXLh5ignC2cIosW3PW6AMJwevgJ3E8dU7GEFsFgFViYNbtrNBxAUlTs
  58wgJiiwokS3ydepEJxGYT0JG4sOAvWK+wgKPEq6ktQL0cHCICvhIT9oWDzGcWWMcosXt5PyP
  c5kNrljGDNHAKWEs0rdwEtoBZwEJi8ZuD7BC2vETz1tlgNRICChKvvrQxQtgVErNmtTFB2GoS
  V89tYp7AKDQLyX2zkIyahWTUAkbmVYw2SUWZ6RkluYmZObqGBga6hoamupZmuoaWxnqJVbqJe
  qmlunn5RSUZuoZ6ieXFeqnFxXrFlbnJOSl6eaklmxiB0ZZSnHBwB+OKfb/0DjFKcjApifKWyp
  skC/El5adUZiQWZ8QXleakFh9ilOHgUJLgLQ0HygkWpaanVqRl5gAjHyYtwcGjJMLrFgqU5i0
  uSMwtzkyHSJ1itOdY23BgLzPHhgcg8uqVK0By6ux/+5mFWPLy81KlxHk/RwC1CYC0ZZTmwQ2F
  JapLjLJSwryMDAwMQjwFqUW5mSWo8q8YxTkYlYR5Q2KBpvBk5pXA7X4FdBYT0FkfmYxBzipJR
  EhJNTBt4GrtkFvJZnO4L3R6gvuOMMmelWfu/+zYEPg1qjhb0GZvfNb3A4s5Nmu572BiPmsj3s
  t/3qyJ6Y3PpzN1JQ1HGDqYknOvKJySyE7m8WW9cjvIxL6+K0s2x6DXhmNXzfakCrm1HAql3+Q
  4nXoiLjOt7rLW4TlzJ0rm58QjW90YXU79vbeMVzxm9b5zvewxq/ae5Jhfvbw38AXHFoZnZ6eZ
  Tn/2R0ZyRoCzj5OB/8mMx3V8NwKZmTL2Xn/3+u9bL717RitaBfyjZF0yRJ/xN1bqvH+/28JHc
  8Hb1xJsGyPsin+sEpw3eUFfpvcdHq9jq9/83n9khzu7L/9e0dp+bbY0z30TM94/U1KfKl29So
  mlOCPRUIu5qDgRAIEUzAXPAwAA
X-Env-Sender: ruansy.fnst@fujitsu.com
X-Msg-Ref: server-5.tower-728.messagelabs.com!1664376388!103507!1
X-Originating-IP: [62.60.8.98]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.87.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 10309 invoked from network); 28 Sep 2022 14:46:29 -0000
Received: from unknown (HELO n03ukasimr03.n03.fujitsu.local) (62.60.8.98)
  by server-5.tower-728.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 28 Sep 2022 14:46:29 -0000
Received: from n03ukasimr03.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr03.n03.fujitsu.local (Postfix) with ESMTP id 9A2A01AB;
        Wed, 28 Sep 2022 15:46:28 +0100 (BST)
Received: from R01UKEXCASM126.r01.fujitsu.local (R01UKEXCASM126 [10.183.43.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr03.n03.fujitsu.local (Postfix) with ESMTPS id 8E59A1AD;
        Wed, 28 Sep 2022 15:46:28 +0100 (BST)
Received: from [10.167.201.6] (10.167.201.6) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Wed, 28 Sep 2022 15:46:24 +0100
Message-ID: <2428b01d-afc7-7b33-1088-e34d68029e19@fujitsu.com>
Date:   Wed, 28 Sep 2022 22:46:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
Subject: Re: [RFC PATCH] xfs: drop experimental warning for fsdax
To:     Dave Chinner <david@fromorbit.com>,
        "Darrick J. Wong" <djwong@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
        <nvdimm@lists.linux.dev>, <linux-mm@kvack.org>,
        <linux-fsdevel@vger.kernel.org>, <dan.j.williams@intel.com>
References: <1663234002-17-1-git-send-email-ruansy.fnst@fujitsu.com>
 <20220919045003.GJ3600936@dread.disaster.area>
 <20220919211533.GK3600936@dread.disaster.area>
 <f10de555-370b-f236-1107-e3089258ebbc@fujitsu.com>
 <YzMeqNg56v0/t/8x@magnolia> <20220927235129.GC3600936@dread.disaster.area>
In-Reply-To: <20220927235129.GC3600936@dread.disaster.area>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.167.201.6]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
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



在 2022/9/28 7:51, Dave Chinner 写道:
> On Tue, Sep 27, 2022 at 09:02:48AM -0700, Darrick J. Wong wrote:
>> On Tue, Sep 27, 2022 at 02:53:14PM +0800, Shiyang Ruan wrote:
...
>>>
>>> I have tested these two mode for many times:
>>>
>>> xfs_dax mode did failed so many cases.  (If you tested with this "drop"
>>> patch, some warning around "dax_dedupe_file_range_compare()" won't occur any
>>> more.)  I think warning around "dax_disassociate_entry()" is a problem with
>>> concurrency.  Still looking into it.
>>>
>>> But xfs_dax_noreflink didn't have so many failure, just 3 in my environment:
>>> Failures: generic/471 generic/519 xfs/148.  I am thinking that did you
>>> forget to reformat the TEST_DEV to be non-reflink before run the test?  If
>>> so it will make sense.
> 
> No, I did not forget to turn off reflink for the test device:
> 
> # ./run_check.sh --mkfs-opts "-m reflink=0,rmapbt=1" --run-opts "-s xfs_dax_noreflink -g auto"
> umount: /mnt/test: not mounted.
> umount: /mnt/scratch: not mounted.
> wrote 8589934592/8589934592 bytes at offset 0
> 8.000 GiB, 8192 ops; 0:00:03.99 (2.001 GiB/sec and 2049.0850 ops/sec)
> wrote 8589934592/8589934592 bytes at offset 0
> 8.000 GiB, 8192 ops; 0:00:04.13 (1.936 GiB/sec and 1982.5453 ops/sec)
> meta-data=/dev/pmem0             isize=512    agcount=4, agsize=524288 blks
>           =                       sectsz=4096  attr=2, projid32bit=1
>           =                       crc=1        finobt=1, sparse=1, rmapbt=1
>           =                       reflink=0    bigtime=1 inobtcount=1 nrext64=0
> data     =                       bsize=4096   blocks=2097152, imaxpct=25
>           =                       sunit=0      swidth=0 blks
> naming   =version 2              bsize=4096   ascii-ci=0, ftype=1
> log      =internal log           bsize=4096   blocks=16384, version=2
>           =                       sectsz=4096  sunit=1 blks, lazy-count=1
> realtime =none                   extsz=4096   blocks=0, rtextents=0
> .....
> Running: MOUNT_OPTIONS= ./check -R xunit -b -s xfs_dax_noreflink -g auto
> SECTION       -- xfs_dax_noreflink
> FSTYP         -- xfs (debug)
> PLATFORM      -- Linux/x86_64 test3 6.0.0-rc6-dgc+ #1543 SMP PREEMPT_DYNAMIC Mon Sep 19 07:46:37 AEST 2022
> MKFS_OPTIONS  -- -f -m reflink=0,rmapbt=1 /dev/pmem1
> MOUNT_OPTIONS -- -o dax=always -o context=system_u:object_r:root_t:s0 /dev/pmem1 /mnt/scratch
> 
> So, yeah, reflink was turned off on both test and scratch devices,
> and dax=always on both the test and scratch devices was used to
> ensure that DAX was always in use.
> 
> 
>> FWIW I saw dmesg failures in xfs/517 and xfs/013 starting with 6.0-rc5,
>> and I haven't even turned on reflink yet:
>>
>> run fstests xfs/517 at 2022-09-26 19:53:34
>> XFS (pmem1): EXPERIMENTAL Large extent counts feature in use. Use at your own risk!
>> XFS (pmem1): Mounting V5 Filesystem
>> XFS (pmem1): Ending clean mount
>> XFS (pmem1): Quotacheck needed: Please wait.
>> XFS (pmem1): Quotacheck: Done.
>> XFS (pmem1): Unmounting Filesystem
>> XFS (pmem0): EXPERIMENTAL online scrub feature in use. Use at your own risk!
>> XFS (pmem1): EXPERIMENTAL Large extent counts feature in use. Use at your own risk!
>> XFS (pmem1): Mounting V5 Filesystem
>> XFS (pmem1): Ending clean mount
>> XFS (pmem1): Quotacheck needed: Please wait.
>> XFS (pmem1): Quotacheck: Done.
>> ------------[ cut here ]------------
>> WARNING: CPU: 1 PID: 415317 at fs/dax.c:380 dax_insert_entry+0x22d/0x320
>> Modules linked in: xfs nft_chain_nat xt_REDIRECT nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ip6t_REJECT nf_reject_ipv6 ipt_REJECT nf_reject_ipv4 xt_tcpudp ip_set_hash_ip ip_set_hash_net xt_set nft_compat ip_set_hash_mac ip_set nf_tables libcrc32c bfq nfnetlink pvpanic_mmio pvpanic nd_pmem dax_pmem nd_btt sch_fq_codel fuse configfs ip_tables x_tables overlay nfsv4 af_packet [last unloaded: scsi_d
>>
>> CPU: 1 PID: 415317 Comm: fsstress Tainted: G        W          6.0.0-rc7-xfsx #rc7 727341edbd0773a36b78b09dab448fa1896eb3a5
>> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.15.0-1 04/01/2014
>> RIP: 0010:dax_insert_entry+0x22d/0x320
>> Code: e0 48 83 c4 20 5b 5d 41 5c 41 5d 41 5e 41 5f c3 48 8b 58 20 48 8d 53 01 e9 62 ff ff ff 48 8b 58 20 48 8d 53 01 e9 4d ff ff ff <0f> 0b e9 6d ff ff ff 31 f6 48 89 ef e8 72 74 12 00 eb a1 83 e0 02
>> RSP: 0000:ffffc90004693b28 EFLAGS: 00010002
>> RAX: ffffea0010a20480 RBX: 0000000000000001 RCX: 0000000000000001
>> RDX: ffffea0000000000 RSI: 0000000000000033 RDI: ffffea0010a204c0
>> RBP: ffffc90004693c08 R08: 0000000000000000 R09: 0000000000000000
>> R10: ffff88800c226228 R11: 0000000000000001 R12: 0000000000000011
>> R13: ffff88800c226228 R14: ffffc90004693e08 R15: 0000000000000000
>> FS:  00007f3aad8db740(0000) GS:ffff88803ed00000(0000) knlGS:0000000000000000
>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> CR2: 00007f3aad8d1000 CR3: 0000000043104003 CR4: 00000000001706e0
>> Call Trace:
>>   <TASK>
>>   dax_fault_iter+0x26e/0x670
>>   dax_iomap_pte_fault+0x1ab/0x3e0
>>   __xfs_filemap_fault+0x32f/0x5a0 [xfs c617487f99e14abfa5deb24e923415b927df3d4b]
>>   __do_fault+0x30/0x1e0
>>   do_fault+0x316/0x6d0
>>   ? mmap_region+0x2a5/0x620
>>   __handle_mm_fault+0x649/0x1250
>>   handle_mm_fault+0xc1/0x220
>>   do_user_addr_fault+0x1ac/0x610
>>   ? _copy_to_user+0x63/0x80
>>   exc_page_fault+0x63/0x130
>>   asm_exc_page_fault+0x22/0x30
>> RIP: 0033:0x7f3aada7f1ca
>> Code: c5 fe 7f 07 c5 fe 7f 47 20 c5 fe 7f 47 40 c5 fe 7f 47 60 c5 f8 77 c3 66 0f 1f 84 00 00 00 00 00 40 0f b6 c6 48 89 d1 48 89 fa <f3> aa 48 89 d0 c5 f8 77 c3 66 66 2e 0f 1f 84 00 00 00 00 00 66 90
>> RSP: 002b:00007ffe47afa688 EFLAGS: 00010206
>> RAX: 000000000000002e RBX: 0000000000033000 RCX: 000000000000999c
>> RDX: 00007f3aad8d1000 RSI: 000000000000002e RDI: 00007f3aad8d1000
>> RBP: 0000558851e13240 R08: 0000000000000000 R09: 0000000000033000
>> R10: 0000000000000008 R11: 0000000000000246 R12: 028f5c28f5c28f5c
>> R13: 8f5c28f5c28f5c29 R14: 000000000000999c R15: 0000000000001c81
>>   </TASK>
>> ---[ end trace 0000000000000000 ]---
>> XFS (pmem0): Unmounting Filesystem
>> XFS (pmem1): EXPERIMENTAL online scrub feature in use. Use at your own risk!
>> XFS (pmem1): *** REPAIR SUCCESS ino 0x80 type probe agno 0x0 inum 0x0 gen 0x0 flags 0x80000001 error 0
>> XFS (pmem1): Unmounting Filesystem
>> XFS (pmem1): EXPERIMENTAL Large extent counts feature in use. Use at your own risk!
>> XFS (pmem1): Mounting V5 Filesystem
>> XFS (pmem1): Ending clean mount
>> XFS (pmem1): Unmounting Filesystem
> 
> Yup, that's the same as what I'm seeing.

Could you send me your kernel config (or other configs needed for the 
test)?  I still cannot reproduce this warning when reflink is off, even 
without this drop patch.  Maybe something different in config file?


PS: I specifically tried the two cases Darrick mentioned (on v6.0-rc6):

[root@f33 xfstests-dev]# mkfs.xfs -m reflink=0,rmapbt=1 /dev/pmem0.1 -f
meta-data=/dev/pmem0.1           isize=512    agcount=4, agsize=257920 blks
          =                       sectsz=4096  attr=2, projid32bit=1
          =                       crc=1        finobt=1, sparse=1, rmapbt=1
          =                       reflink=0    bigtime=1 inobtcount=1 
nrext64=0
data     =                       bsize=4096   blocks=1031680, imaxpct=25
          =                       sunit=0      swidth=0 blks
naming   =version 2              bsize=4096   ascii-ci=0, ftype=1
log      =internal log           bsize=4096   blocks=16384, version=2
          =                       sectsz=4096  sunit=1 blks, lazy-count=1
realtime =none                   extsz=4096   blocks=0, rtextents=0
[root@f33 xfstests-dev]# mkfs.xfs -m reflink=0,rmapbt=1 /dev/pmem0 -f
meta-data=/dev/pmem0             isize=512    agcount=4, agsize=257920 blks
          =                       sectsz=4096  attr=2, projid32bit=1
          =                       crc=1        finobt=1, sparse=1, rmapbt=1
          =                       reflink=0    bigtime=1 inobtcount=1 
nrext64=0
data     =                       bsize=4096   blocks=1031680, imaxpct=25
          =                       sunit=0      swidth=0 blks
naming   =version 2              bsize=4096   ascii-ci=0, ftype=1
log      =internal log           bsize=4096   blocks=16384, version=2
          =                       sectsz=4096  sunit=1 blks, lazy-count=1
realtime =none                   extsz=4096   blocks=0, rtextents=0
[root@f33 xfstests-dev]# ./check xfs/013 xfs/517
FSTYP         -- xfs (debug)
PLATFORM      -- Linux/x86_64 f33 6.0.0-rc6 #84 SMP PREEMPT_DYNAMIC Wed 
Sep 28 18:27:33 CST 2022
MKFS_OPTIONS  -- -f -m reflink=0,rmapbt=1 /dev/pmem0.1
MOUNT_OPTIONS -- -o dax -o context=system_u:object_r:root_t:s0 
/dev/pmem0.1 /mnt/scratch

xfs/013 127s ...  166s
xfs/517 66s ...  66s
Ran: xfs/013 xfs/517
Passed all 2 tests



--
Thanks,
Ruan.

> 
> Cheers,
> 
> Dave.
