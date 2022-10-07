Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31EDE5F7272
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Oct 2022 03:05:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232444AbiJGBFu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Oct 2022 21:05:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231453AbiJGBFt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Oct 2022 21:05:49 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF110F250B
        for <linux-fsdevel@vger.kernel.org>; Thu,  6 Oct 2022 18:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1665104748; x=1696640748;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=pueaaqQCcatUTiGFsMlRm1mvaZDzz7r2NEvIMnNCLcY=;
  b=jfTFMNKsB5uuZdweLsoRrwjmSYez9nSGEJL03Emb13zHAHXG8HM2mmCW
   222qEPR9DRSTCjgUsr/2vK3fl29hP+5Sj08JnMlDNi5tNef8qEFYMzTU/
   mciQswyjZpngqUj0sJ+jTZ4BQXOI3k1NuONlD/Liyc+Q0YzBVaKlKiV5L
   NhWNcKkYLDLj6MUGHScRN0Rfatjk4hZDLKuBxJNa4FGFFoSs/EHR33AG8
   1A1U/mAXi1GbwDlcLmtCp+2+HANpZ832lisGyslq1GgS84bkX9t6EciFQ
   tOa5pEanlbxEJeD6mHYU4aZHbz5/veK4YocwMWd0dy5iQ+Nb4UQ2HClj3
   Q==;
X-IronPort-AV: E=Sophos;i="5.95,164,1661788800"; 
   d="scan'208";a="317484931"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 07 Oct 2022 09:05:46 +0800
IronPort-SDR: IrHgHiQcrIINZQKBnZS/lt4u5JUW7KmP0Byv2gz0LfS0xT4RXO/HnaApUqpWjSJjmhkH4WBh/3
 Bjjv2kx8U9gNA5DPxaKtHyfxADTR5FBEir03Es/cNhbsNTDqXQRzcdevzk/qPfd0CCzNTtcEvg
 1MEnORRpgO645kjp/ot9euvYKnCo9AGKeOhntRDfsT4HPQdBIWsX4Bk0BheQ7Rx0Sy+KDDqFMW
 Htj/62y4osMr2DsUyI1bqBLogwzPHEnEFK4nkJFVC+a7DABdZwoizyZCfJxUwsz4iByPc5eZNV
 LpnYb8+vt0Aomx/mCikdFQys
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Oct 2022 17:25:31 -0700
IronPort-SDR: zhsldG0S4DJbYGXx+1jZHzVe+maX0ss6cm/DEfluUBHId33vH3GhTzfpHwI5xAg6nayXUwajLL
 hVWUy7QnwSo6O0KN+LRZjzV939wFIZ9RJKeq8zlOjulhzVxj0XuNL2lPC6mh/2BLdpd34dcU8w
 +esb4q5heCm3VVBb/7im3vH2Rfo9z4lV15iYCD5RJOuokV0B7gnbpTbcHy2qhaYgl1UGxgRRmf
 X92k0OlFbOGZh0NNQ57pHuwLtEqxX2/amXAqzrry59eFp+r+qYpZSiC0kI5R05lpOWY7BuiUE/
 wfs=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Oct 2022 18:05:45 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Mk9953hdlz1Rwrq
        for <linux-fsdevel@vger.kernel.org>; Thu,  6 Oct 2022 18:05:45 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1665104744; x=1667696745; bh=pueaaqQCcatUTiGFsMlRm1mvaZDzz7r2NEv
        IMnNCLcY=; b=d4DrCSZY0TLHs4y2tKPHIhllYvs5MnQASNhd5oWS7DNSrnuN3Mp
        SMVrBXukTgvf6m25x1bP8FgKnaZjeioeN2M8DEAf2zAsppoRXaaY7TKpQiZ1yG34
        TyVQu+yPiyyOYLURoZxNDri+LwP0Du0zZspEQCMFZS3ztTJOc+gvHqX8jhzyttvz
        Vilj5SDbZM5amh3I9kFK1E7cay9nE0FCUoumkTjNwFwBqQYvGceivscf21T6Mixq
        o8J4lnlE1mv4PEHHkz0bRa3AWPul4IrxTskVnBc+dmBiiJkqH1t5JoBhVgP75FGy
        qKEdSL8NY1zlmkzxaEtVKln3qAawGWL2NVA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id X_zM-NAFF5ae for <linux-fsdevel@vger.kernel.org>;
        Thu,  6 Oct 2022 18:05:44 -0700 (PDT)
Received: from [10.225.163.106] (unknown [10.225.163.106])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Mk9936VzTz1RvLy;
        Thu,  6 Oct 2022 18:05:43 -0700 (PDT)
Message-ID: <45f1ee63-793d-2a13-90cc-2312b17dffaa@opensource.wdc.com>
Date:   Fri, 7 Oct 2022 10:05:42 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: soft lockup with pre-rc1
Content-Language: en-US
To:     Jeff Layton <jlayton@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-ide <linux-ide@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
References: <da0dd711f9820372e3afdf6fef7744cb31ada0ea.camel@redhat.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <da0dd711f9820372e3afdf6fef7744cb31ada0ea.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/7/22 02:33, Jeff Layton wrote:
> I pulled down Linus tree today and did some testing with some filesystem
> related patches. Running xfstests against ext4 in a VM, and I hit this:
> 
> [ 8947.343179] run fstests generic/224 at 2022-10-06 13:24:20
> [ 8948.435322] EXT4-fs (dm-1): mounted filesystem with ordered data mode. Quota mode: none.
> [ 8949.235839] EXT4-fs (dm-2): mounted filesystem with ordered data mode. Quota mode: none.
> [ 9017.622065] watchdog: BUG: soft lockup - CPU#2 stuck for 23s! [kworker/2:0:1145882]
> [ 9023.009230] Modules linked in: ext4(E) mbcache(E) jbd2(E) nft_fib_inet(E) nft_fib_ipv4(E) nft_fib_ipv6(E) nft_fib(E) nft_reject_inet(E) nf_reject_ipv4(E) nf_reject_ipv6(E) nft_reject(E) nft_ct(E) nft_chain_nat(E) nf_nat(E) nf_conntrack(E) nf_defrag_ipv6(E) nf_defrag_ipv4(E) rfkill(E) ip_set(E) nf_tables(E) nfnetlink(E) iTCO_wdt(E) intel_pmc_bxt(E) iTCO_vendor_support(E) joydev(E) intel_rapl_msr(E) i2c_i801(E) virtio_balloon(E) i2c_smbus(E) lpc_ich(E) intel_rapl_common(E) nfsd(E) auth_rpcgss(E) nfs_acl(E) lockd(E) grace(E) fuse(E) sunrpc(E) zram(E) xfs(E) crct10dif_pclmul(E) crc32_pclmul(E) crc32c_intel(E) ghash_clmulni_intel(E) virtio_gpu(E) virtio_dma_buf(E) drm_shmem_helper(E) serio_raw(E) virtio_net(E) drm_kms_helper(E) virtio_blk(E) net_failover(E) virtio_console(E) failover(E) drm(E) qemu_fw_cfg(E)
> [ 9023.081530] CPU: 2 PID: 1145882 Comm: kworker/2:0 Tainted: G            E      6.0.0+ #43
> [ 9023.085919] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.0-1.fc36 04/01/2014
> [ 9023.090747] Workqueue: events_freezable_power_ disk_events_workfn
> [ 9023.095155] RIP: 0010:__do_softirq+0xb5/0x401
> [ 9023.147050] Code: ff e8 6f db bc fe c7 44 24 1c 0a 00 00 00 48 c7 c7 c0 d2 87 ad e8 1b 9c be ff 65 66 c7 05 d1 0e a4 52 00 00 fb 0f 1f 44 00 00 <bb> ff ff ff ff 41 0f bc de 83 c3 01 0f 84 9a 00 00 00 48 c7 c5 c0
> [ 9023.158173] RSP: 0018:ffff888221909f80 EFLAGS: 00000296
> [ 9023.163217] RAX: 0000000000000002 RBX: ffff888107fb002c RCX: ffffffffac1cdc2d
> [ 9023.168569] RDX: dffffc0000000000 RSI: ffffffffad87d2c0 RDI: ffffffffada7f7e0
> [ 9023.173885] RBP: 0000000000000000 R08: 0000000000000000 R09: ffffffffafc01083
> [ 9023.179097] R10: fffffbfff5f80210 R11: 0000000000000000 R12: 0000000000000000
> [ 9023.184780] R13: 0000000000000000 R14: 0000000000000282 R15: ffff888107fb0000
> [ 9023.189955] FS:  0000000000000000(0000) GS:ffff888221900000(0000) knlGS:0000000000000000
> [ 9023.195329] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 9023.200380] CR2: 00007fba16a314e0 CR3: 0000000107882000 CR4: 00000000003506e0
> [ 9023.205569] Call Trace:
> [ 9023.209571]  <IRQ>
> [ 9023.213587]  __irq_exit_rcu+0x12a/0x190
> [ 9023.217664]  sysvec_apic_timer_interrupt+0x8a/0xb0
> [ 9023.221863]  </IRQ>
> [ 9023.225684]  <TASK>
> [ 9023.229384]  asm_sysvec_apic_timer_interrupt+0x16/0x20
> [ 9023.233485] RIP: 0010:_raw_spin_unlock_irqrestore+0x19/0x40
> [ 9023.237740] Code: c6 48 89 df e8 d8 54 fe fe 90 eb cc 0f 1f 44 00 00 0f 1f 44 00 00 e8 5a 4e fe fe 90 f7 c6 00 02 00 00 74 06 fb 0f 1f 44 00 00 <bf> 01 00 00 00 e8 ad 9a f8 fe 65 8b 05 16 a8 e2 52 85 c0 74 05 e9
> [ 9023.246961] RSP: 0018:ffff88810f9e7828 EFLAGS: 00000206
> [ 9023.251106] RAX: 0000000000000001 RBX: 0000000000000000 RCX: ffffffffacbdecee
> [ 9023.255535] RDX: dffffc0000000000 RSI: 0000000000000286 RDI: ffff888109e4d500
> [ 9023.259915] RBP: ffff88810a9d8000 R08: 0000000000000001 R09: ffff88810aa8894b
> [ 9023.264310] R10: ffffed1021551129 R11: fefefefefefefeff R12: 0000000000000286
> [ 9023.268834] R13: ffff88810a9d8010 R14: ffff8881013e0000 R15: ffff88810ab5a000
> [ 9023.273239]  ? ata_scsi_queuecmd+0x6e/0xb0
> [ 9023.277360]  ? _raw_spin_unlock_irqrestore+0xa/0x40
> [ 9023.281479]  ata_scsi_queuecmd+0x7a/0xb0
> [ 9023.285386]  scsi_queue_rq+0xb5c/0x13c0
> [ 9023.289449]  blk_mq_dispatch_rq_list+0x3e2/0xfc0
> [ 9023.293549]  ? blk_insert_cloned_request+0x330/0x330
> [ 9023.297646]  ? _raw_spin_lock+0x77/0xc0
> [ 9023.301593]  ? _raw_spin_lock_bh+0xc0/0xc0
> [ 9023.305485]  __blk_mq_sched_dispatch_requests+0x13b/0x1f0
> [ 9023.309609]  ? blk_mq_do_dispatch_ctx+0x340/0x340
> [ 9023.313581]  ? _raw_spin_lock_bh+0xc0/0xc0
> [ 9023.317304]  blk_mq_sched_dispatch_requests+0x82/0xb0
> [ 9023.320780]  __blk_mq_run_hw_queue+0x66/0xe0
> [ 9023.324965]  blk_mq_sched_insert_request+0x16f/0x1d0
> [ 9023.328294]  ? __alloc_pages_slowpath.constprop.0+0x1360/0x1360
> [ 9023.331757]  ? blk_mq_sched_bio_merge+0x180/0x180
> [ 9023.335040]  ? bio_add_pc_page+0x8a/0xb0
> [ 9023.339093]  blk_execute_rq+0x111/0x2c0
> [ 9023.343823]  ? blk_mq_get_sq_hctx+0x80/0x80
> [ 9023.348523]  __scsi_execute+0x13a/0x2b0
> [ 9023.353163]  sr_check_events+0x13e/0x420
> [ 9023.357071]  ? sr_packet+0x90/0x90
> [ 9023.359914]  ? __mod_timer+0x42a/0x5e0
> [ 9023.362727]  ? hibernation_snapshot+0x3e8/0x640
> [ 9023.365600]  ? console_emit_next_record.constprop.0+0x400/0x400
> [ 9023.368659]  cdrom_check_events+0x34/0x70
> [ 9023.371522]  disk_check_events+0x5d/0x180
> [ 9023.374430]  process_one_work+0x3d3/0x6a0
> [ 9023.377304]  worker_thread+0x8a/0x610
> [ 9023.380329]  ? process_one_work+0x6a0/0x6a0
> [ 9023.383202]  kthread+0x167/0x1a0
> [ 9023.385889]  ? kthread_complete_and_exit+0x20/0x20
> [ 9023.388668]  ret_from_fork+0x22/0x30
> [ 9023.391338]  </TASK>

Adding linux-block and linux-fsdevel, just in case.

Hmm... Weird. ATA changes for 6.1 are not merged yet, and none of them
touch ata_scsi_queue_cmd() or port locking anyway.

It looks like the ata lock is stuck, which may mean that some other
context is stuck in completion path ? Do you see any other task stuck in
ata code ?

> 
> Last commit in my tree is this:
> 
> 833477fce7a1 (origin/master) Merge tag 'sound-6.1-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound
> 
> I also have some filesystem related patches on top of this. inode-
>> i_version patches mostly -- nothing that should effect things at this
> level.
> 
> config is attached.

-- 
Damien Le Moal
Western Digital Research

