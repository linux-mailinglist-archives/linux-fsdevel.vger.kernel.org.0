Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F4CF253C68
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Aug 2020 05:59:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbgH0D7s (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Aug 2020 23:59:48 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:4830 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726794AbgH0D7r (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Aug 2020 23:59:47 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f472f390001>; Wed, 26 Aug 2020 20:57:45 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Wed, 26 Aug 2020 20:59:47 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Wed, 26 Aug 2020 20:59:47 -0700
Received: from [10.2.53.36] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 27 Aug
 2020 03:59:42 +0000
Subject: Re: [bio] 37abbdc72e: WARNING:at_block/bio.c:#bio_release_pages
To:     kernel test robot <lkp@intel.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        "Ilya Dryomov" <idryomov@gmail.com>, Jens Axboe <axboe@kernel.dk>,
        Jeff Layton <jlayton@kernel.org>, <linux-xfs@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <ceph-devel@vger.kernel.org>, <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, <lkp@lists.01.org>,
        <ltp@lists.linux.it>
References: <20200827032518.GO4299@shao2-debian>
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <2d7d45b8-e271-87b2-f772-d1b2232fe351@nvidia.com>
Date:   Wed, 26 Aug 2020 20:59:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200827032518.GO4299@shao2-debian>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1598500665; bh=+FWH5O9plAx2YA/7/CTPyaQvsDP1bN7Fd3QNB/vKkOA=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=m7IuApWAH6QorQ1B/A53t+ZQioXeC51OPleIyKiBBSIQeqx6r6btSGqLe5OYT/xRa
         q0aiVhKco2L+zUHOuik21sCCi9lpLaD7th0UqbvYqV7Yxk5CuHxHdrZyYDPGmY2w99
         QcAVSChYiytbHpKYLlwH41eNLU7pnnR77Zf/fNs5Mhb6KekZZr9/h0A69FMAkiLwxm
         i8rM0eYVXte4X48P8iMmVlv5EhLeJvFYA5xAujWqeqAEbQBjrzFRIgXGZ0DU5sQHZU
         KSa8FD6EEqbctof9fPVIgJsFoTkWU0C6lBEFHf1WLRwqRkHphxDoiUOniVb8LAE6/B
         QO/WHC+GNJAZQ==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/26/20 8:25 PM, kernel test robot wrote:
...
> kern  :warn  : [   59.757746] ------------[ cut here ]------------
> kern  :warn  : [   59.758325] WARNING: CPU: 3 PID: 2581 at block/bio.c:955 bio_release_pages+0xd7/0xe0
> kern  :warn  : [   59.758952] Modules linked in: dm_mod netconsole btrfs blake2b_generic xor zstd_compress raid6_pq libcrc32c intel_rapl_msr sd_mod intel_rapl_common t10_pi x86_pkg_temp_thermal sg intel_powerclamp coretemp i915 intel_gtt drm_kms_helper kvm_intel kvm irqbypass crct10dif_pclmul crc32_pclmul crc32c_intel ghash_clmulni_intel syscopyarea rapl intel_cstate sysfillrect intel_uncore sysimgblt fb_sys_fops drm mei_me ipmi_devintf ahci libahci ipmi_msghandler libata mei joydev ie31200_edac video ip_tables
> kern  :warn  : [   59.761834] CPU: 3 PID: 2581 Comm: aiodio_sparse Not tainted 5.8.0-10182-g37abbdc72ec00 #1
> kern  :warn  : [   59.762559] Hardware name: Hewlett-Packard p6-1451cx/2ADA, BIOS 8.15 02/05/2013
> kern  :warn  : [   59.763295] RIP: 0010:bio_release_pages+0xd7/0xe0
> kern  :warn  : [   59.763983] Code: e1 89 d5 81 e2 ff 0f 00 00 c1 ed 0c 29 d1 48 c1 e5 06 48 03 28 eb 9c 48 8b 45 08 a8 01 75 c0 48 89 ef e8 8c f0 d2 ff eb b6 c3 <0f> 0b c3 66 0f 1f 44 00 00 0f 1f 44 00 00 41 54 31 c0 55 bd 00 10
> kern  :warn  : [   59.765596] RSP: 0000:ffffc90000124e68 EFLAGS: 00010246
> kern  :warn  : [   59.766339] RAX: 0000000000000a00 RBX: ffff888212c3f2a0 RCX: 0000000000000000
> kern  :warn  : [   59.767124] RDX: fffffffffff41387 RSI: 0000000000000000 RDI: ffff88821fae3000
> kern  :warn  : [   59.767950] RBP: ffff88821fae3000 R08: ffff88821f1d1c00 R09: 0000000000000000
> kern  :warn  : [   59.768726] R10: ffff88821f1d1a10 R11: ffff88821faab3b0 R12: 0000000040000001
> kern  :warn  : [   59.769513] R13: 0000000000000400 R14: 0000000000002c00 R15: 0000000000000000
> kern  :warn  : [   59.770294] FS:  00007fb0401ef740(0000) GS:ffff88821fb80000(0000) knlGS:0000000000000000
> kern  :warn  : [   59.771112] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> kern  :warn  : [   59.771908] CR2: 00007ffc3fc11000 CR3: 000000012477e006 CR4: 00000000001706e0
> kern  :warn  : [   59.772720] Call Trace:
> kern  :warn  : [   59.773466]  <IRQ>
> kern  :warn  : [   59.774200]  iomap_dio_bio_end_io+0x5f/0x100

ah, this is self-inflicted, because my new pin_user_page() (which is called
from iomap_dio_bio_end_io) doesn't set BIO_FOLL_PIN.

Obsolete, now that BIO_FOLL_PIN is not going to happen, but it's good to see
that the system isn't doing anything unexpected here.

thanks,
-- 
John Hubbard
NVIDIA

> kern  :warn  : [   59.774973]  blk_update_request+0x219/0x3c0
> kern  :warn  : [   59.775767]  scsi_end_request+0x29/0x140
> kern  :warn  : [   59.776538]  scsi_io_completion+0x7a/0x520
> kern  :warn  : [   59.777324]  blk_done_softirq+0x95/0xc0
> kern  :warn  : [   59.778098]  __do_softirq+0xe8/0x313
> kern  :warn  : [   59.778887]  asm_call_on_stack+0x12/0x20
> kern  :warn  : [   59.779662]  </IRQ>
> kern  :warn  : [   59.780435]  do_softirq_own_stack+0x39/0x60
> kern  :warn  : [   59.781217]  irq_exit_rcu+0xd2/0xe0
> kern  :warn  : [   59.782020]  common_interrupt+0x74/0x140
> kern  :warn  : [   59.782797]  ? asm_common_interrupt+0x8/0x40
> kern  :warn  : [   59.783594]  asm_common_interrupt+0x1e/0x40
> kern  :warn  : [   59.784359] RIP: 0033:0x5572c6b47f20
> kern  :warn  : [   59.785119] Code: 10 00 00 49 01 c4 44 39 fd 0f 8c a2 00 00 00 ba 00 10 00 00 4c 89 ee 44 89 f7 e8 ab f5 ff ff 85 c0 7e d7 89 c2 4c 89 eb eb 09 <48> 83 c3 01 83 ea 01 74 c7 44 0f be 03 45 84 c0 74 ee 83 fa 03 7e
> kern  :warn  : [   59.786952] RSP: 002b:00007ffc3fc0fed0 EFLAGS: 00000246
> kern  :warn  : [   59.787836] RAX: 0000000000001000 RBX: 00007ffc3fc11de1 RCX: 00007fb0403c950e
> kern  :warn  : [   59.788750] RDX: 00000000000000bf RSI: 00007ffc3fc10ea0 RDI: 0000000000000007
> kern  :warn  : [   59.789647] RBP: 00000000001b5c00 R08: 0000000000000000 R09: 00007ffc3fc0d6b7
> kern  :warn  : [   59.790550] R10: 0000000000000000 R11: 0000000000000246 R12: 000000000003e000
> kern  :warn  : [   59.791447] R13: 00007ffc3fc10ea0 R14: 0000000000000007 R15: 000000000003e000
> kern  :warn  : [   59.792356] ---[ end trace 1c52c540ed6c08e4 ]---
> 
> ...
