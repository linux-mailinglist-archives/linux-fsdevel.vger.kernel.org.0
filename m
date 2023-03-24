Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63B6B6C7685
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Mar 2023 05:20:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbjCXEUC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Mar 2023 00:20:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjCXEUB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Mar 2023 00:20:01 -0400
Received: from mail1.bemta37.messagelabs.com (mail1.bemta37.messagelabs.com [85.158.142.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B78423A72
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Mar 2023 21:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1679631597; i=@fujitsu.com;
        bh=QoSk5cd0BqHUsY/u1N/oQyosJhqZq47WDn7uQS+DbOM=;
        h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
         In-Reply-To:Content-Type:Content-Transfer-Encoding;
        b=aLGRlTPcMXkcd8LJAQCVqX40oyA8ZybnTI5pfSu/63W7l4kV+jBpJCQVoV+ELVIbJ
         L4MHpHEOVj3o6zBBsDxp9IVkcpiwq82BxBOtqKgBBm0nX+T5+ZUkElzoZ2vK0gzzW7
         sSGXoGrp3ySDq1ZAr+WnF3MlekP5L9OAOWo4jHSb2c2zchVgPNnByzZ3yks93FGmOZ
         0DAVtmZiiYL6ewjTJ3Mwr8eqfVtvxmtzkogL/y7MYRz/FhA8RnDrYBYRzDS09oysKc
         FupQPm2KN2FhSggfF2GE/qgoWzhOsFO/KXRGC6cRUGCupDdkduQYk1qZQDmTx0x1LE
         9VjFO57dorHog==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrEKsWRWlGSWpSXmKPExsViZ8ORpPtaRTb
  F4MVtE4s569ewWUyfeoHRYvb0ZiaLPXtPslis/PGH1eL3jzlsDmwem1doeSze85LJ48SM3ywe
  LzbPZPQ4s+AIu8fnTXIBbFGsmXlJ+RUJrBlnVvUzFpxSqTh5/T9zA+NK+S5GLg4hgY2MEv8b2
  hi7GDmBnCVMEk1/xSES2xgl3iz7xQyS4BWwk9j05SWYzSKgKtF6cxITRFxQ4uTMJywgtqhAss
  Sx861sILawgJ/E6lU9rCC2iICuxKrnu5hBhjILNDJKXJzZxgSx4TujxPWObrAONgEdiQsL/oJ
  1cAp4S6zu+ga2gVnAQmLxm4PsELa8RPPW2WBXSAgoSVz8eocVwq6QaJx+iAnCVpO4em4T8wRG
  oVlIDpyFZNQsJKMWMDKvYjQrTi0qSy3SNdZLKspMzyjJTczM0Uus0k3USy3VzcsvKsnQNdRLL
  C/WSy0u1iuuzE3OSdHLSy3ZxAiMqJTiRKEdjN96/+odYpTkYFIS5ZUIlU4R4kvKT6nMSCzOiC
  8qzUktPsQow8GhJMHrqiSbIiRYlJqeWpGWmQOMbpi0BAePkgivtBhQmre4IDG3ODMdInWK0Zh
  jbcOBvcwcGx4ASSGWvPy8VClx3gQpoFIBkNKM0jy4QbCkc4lRVkqYl5GBgUGIpyC1KDezBFX+
  FaM4B6OSMG+2MtAUnsy8Erh9r4BOYQI6xblGBuSUkkSElFQD0xL3Uv+Y9sNb02yfHd3w4srKP
  L1kkZo/3kWrM2p8hOMSdC/M+rlm59ocY/v6wCWx95mZ0hKWRv34GfPYuE2w6q51ktSv+gzLg5
  yvOBN33XuvmpB+ZPufM1qaAks9JL1L+5V6nS+mpaRPXjTNRvOH+KnAuV+dFrrrx7Lt/rytlUP
  xzcZpO77PcJE40fw5RidTf/FroYL9bM8fql9ebDShp4mzn0tuovvG6YsS11abbbi1riWj4paO
  4pyU/FjFBann1ml4xjOE2rL/uNtSOP0Lp/TNfvFFX5Rqs7W+LWucet062TjrxmWpa+FvXE5M2
  sZ5zunq+0zHhoCw1pogftYjdgl/Dk2ZtX/ivHaNzaeXKbEUZyQaajEXFScCANkKIqi1AwAA
X-Env-Sender: ruansy.fnst@fujitsu.com
X-Msg-Ref: server-3.tower-745.messagelabs.com!1679631595!658583!1
X-Originating-IP: [62.60.8.98]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.104.1; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 23174 invoked from network); 24 Mar 2023 04:19:55 -0000
Received: from unknown (HELO n03ukasimr03.n03.fujitsu.local) (62.60.8.98)
  by server-3.tower-745.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 24 Mar 2023 04:19:55 -0000
Received: from n03ukasimr03.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr03.n03.fujitsu.local (Postfix) with ESMTP id 2F5491B5;
        Fri, 24 Mar 2023 04:19:55 +0000 (GMT)
Received: from R01UKEXCASM121.r01.fujitsu.local (R01UKEXCASM121 [10.183.43.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr03.n03.fujitsu.local (Postfix) with ESMTPS id 23FE11AF;
        Fri, 24 Mar 2023 04:19:55 +0000 (GMT)
Received: from [192.168.50.5] (10.167.234.230) by
 R01UKEXCASM121.r01.fujitsu.local (10.183.43.173) with Microsoft SMTP Server
 (TLS) id 15.0.1497.42; Fri, 24 Mar 2023 04:19:52 +0000
Message-ID: <a34449ea-4571-2528-9047-f02079e47818@fujitsu.com>
Date:   Fri, 24 Mar 2023 12:19:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] fsdax: dedupe should compare the min of two iters' length
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     <linux-fsdevel@vger.kernel.org>, <nvdimm@lists.linux.dev>,
        <dan.j.williams@intel.com>, <willy@infradead.org>, <jack@suse.cz>
References: <1679469958-2-1-git-send-email-ruansy.fnst@fujitsu.com>
 <20230322161236.f90c21c8f668f551ee19d80b@linux-foundation.org>
 <0d219eb0-0f58-e667-0d86-be158ea2030f@fujitsu.com>
 <20230323151201.98d54f8d85f83c636568eacc@linux-foundation.org>
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
In-Reply-To: <20230323151201.98d54f8d85f83c636568eacc@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.167.234.230]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM121.r01.fujitsu.local (10.183.43.173)
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



在 2023/3/24 6:12, Andrew Morton 写道:
> On Thu, 23 Mar 2023 14:48:25 +0800 Shiyang Ruan <ruansy.fnst@fujitsu.com> wrote:
> 
>>
>>
>> 在 2023/3/23 7:12, Andrew Morton 写道:
>>> On Wed, 22 Mar 2023 07:25:58 +0000 Shiyang Ruan <ruansy.fnst@fujitsu.com> wrote:
>>>
>>>> In an dedupe corporation iter loop, the length of iomap_iter decreases
>>>> because it implies the remaining length after each iteration.  The
>>>> compare function should use the min length of the current iters, not the
>>>> total length.
>>>
>>> Please describe the user-visible runtime effects of this flaw, thanks.
>>
>> This patch fixes fail of generic/561, with test config:
>>
>> export TEST_DEV=/dev/pmem0
>> export TEST_DIR=/mnt/test
>> export SCRATCH_DEV=/dev/pmem1
>> export SCRATCH_MNT=/mnt/scratch
>> export MKFS_OPTIONS="-m reflink=1,rmapbt=1"
>> export MOUNT_OPTIONS="-o dax"
>> export XFS_MOUNT_OPTIONS="-o dax"
> 
> Again, how does the bug impact real-world kernel users?

The dedupe command will fail with -EIO if the range is larger than one 
page size and not aligned to the page size.  Also report warning in dmesg:

[ 4338.498374] ------------[ cut here ]------------
[ 4338.498689] WARNING: CPU: 3 PID: 1415645 at fs/iomap/iter.c:16 
iomap_iter+0x2b2/0x2c0
[ 4338.499216] Modules linked in: bfq ext4 mbcache jbd2 auth_rpcgss 
oid_registry nfsv4 algif_hash af_alg af_packet nft_reject_inet 
nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct nft_chain_nat 
iptable_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ip_set 
nf_tables nfnetlink ip6table_filter ip6_tables iptable_filter ip_tables 
x_tables nd_pmem nd_btt dax_pmem sch_fq_codel configfs xfs libcrc32c 
fuse [last unloaded: scsi_debug]
[ 4338.501419] CPU: 3 PID: 1415645 Comm: pool Kdump: loaded Tainted: G 
      W          6.1.0-rc4+ #118 242c3ad9724cd53a53c9a3b3cd3050ef1060e37a
[ 4338.502093] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 
Arch Linux 1.16.0-3-3 04/01/2014
[ 4338.502610] RIP: 0010:iomap_iter+0x2b2/0x2c0
[ 4338.502933] Code: 0d 63 6f ce 7e 0f 85 d0 fe ff ff e8 f4 ea cc ff e9 
c6 fe ff ff 0f 0b e9 a0 fe ff ff 0f 0b e9 a5 fe ff ff 0f 0b e9 85 fe ff 
ff <0f> 0b b8 fb ff ff ff e9 aa fe ff ff cc cc 0f 1f 44 00 00 48 8b 42
[ 4338.503963] RSP: 0018:ffffc9000317faa8 EFLAGS: 00010287
[ 4338.504318] RAX: 0000000000000178 RBX: ffffc9000317fba8 RCX: 
0000000000001000
[ 4338.504701] RDX: 0000000000000178 RSI: 0000000000399000 RDI: 
ffffc9000317fba8
[ 4338.505062] RBP: ffffffffa0321b30 R08: ffffc9000317fae0 R09: 
0000000000000000
[ 4338.505490] R10: 0000000000000004 R11: ffff888102577740 R12: 
ffffc9000317fd00
[ 4338.505956] R13: 0000000000399000 R14: 0000000000001000 R15: 
0000000000000000
[ 4338.506460] FS:  00007f57ce200640(0000) GS:ffff88817bd80000(0000) 
knlGS:0000000000000000
[ 4338.507126] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 4338.507490] CR2: 00007f57b4a00e88 CR3: 0000000153669002 CR4: 
00000000003706e0
[ 4338.507887] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 
0000000000000000
[ 4338.508288] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 
0000000000000400
[ 4338.508717] Call Trace:
[ 4338.508962]  <TASK>
[ 4338.509234]  dax_dedupe_file_range_compare+0xd9/0x210
[ 4338.509589]  __generic_remap_file_range_prep+0x2af/0x760
[ 4338.509942]  xfs_reflink_remap_prep+0xeb/0x240 [xfs 
4155ff90e551a4608ed7504e9f2aa737a690cfa3]
[ 4338.510505]  xfs_file_remap_range+0x83/0x320 [xfs 
4155ff90e551a4608ed7504e9f2aa737a690cfa3]
[ 4338.511118]  vfs_dedupe_file_range_one+0x196/0x1b0
[ 4338.511407]  vfs_dedupe_file_range+0x170/0x1e0
[ 4338.511719]  do_vfs_ioctl+0x48d/0x8f0
[ 4338.511975]  ? kmem_cache_free+0x2a1/0x460
[ 4338.512278]  ? do_sys_openat2+0x7d/0x150
[ 4338.512556]  __x64_sys_ioctl+0x40/0xa0
[ 4338.512829]  do_syscall_64+0x2b/0x80
[ 4338.513109]  entry_SYSCALL_64_after_hwframe+0x46/0xb0
[ 4338.513421] RIP: 0033:0x7f57ce50748f
[ 4338.513687] Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 10 
00 00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00 00 0f 
05 <89> c2 3d 00 f0 ff ff 77 18 48 8b 44 24 18 64 48 2b 04 25 28 00 00
[ 4338.514582] RSP: 002b:00007f57ce1ffbb0 EFLAGS: 00000246 ORIG_RAX: 
0000000000000010
[ 4338.515067] RAX: ffffffffffffffda RBX: 00007f57b4885870 RCX: 
00007f57ce50748f
[ 4338.515441] RDX: 00007f57b4885870 RSI: 00000000c0189436 RDI: 
000000000000000e
[ 4338.516300] RBP: 00007f57b486f648 R08: 0000000000000001 R09: 
00007f57b486f650
[ 4338.516694] R10: 0000000000000000 R11: 0000000000000246 R12: 
00007f57b486f650
[ 4338.517108] R13: 00007f57b486f610 R14: 00007f57b486f650 R15: 
00007f57b486f610
[ 4338.518781]  </TASK>
[ 4338.519037] ---[ end trace 0000000000000000 ]---

--
Thanks,
Ruan.

> 
> Thanks.
