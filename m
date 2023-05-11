Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A19A76FF816
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 May 2023 19:07:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238792AbjEKRGs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 May 2023 13:06:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbjEKRGr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 May 2023 13:06:47 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84932FA;
        Thu, 11 May 2023 10:06:45 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id CD5CB32008C3;
        Thu, 11 May 2023 13:06:44 -0400 (EDT)
Received: from imap50 ([10.202.2.100])
  by compute5.internal (MEProxy); Thu, 11 May 2023 13:06:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        colorremedies.com; h=cc:content-type:content-type:date:date:from
        :from:in-reply-to:message-id:mime-version:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1683824804; x=1683911204; bh=A5
        jTFtJOtctoZaxC3gTjHWmQRsjq8+d+7S7Z9ZyMZY8=; b=kUR9vThFK6NnPQWCgv
        si0KhvA4LvM7qfHTBtgyuOzVLZusvKggoSM9/8Ox6o6FKe6/USSgZbTvQK/t/Rgr
        Vd04+To7BxOPY38DNyOTEWCBa/bUh2tRgaiIIG5VBUjQsvZgLWryXq5BqJCdtSPT
        KAmyQWxxiBWX/jOcr7LSToHUENfGpXyZcdDzoGkBEyh32UNNHbmRhg2WN4UaiCRc
        sRMHjvmnFsHX/5cfWZw/lzXbEXHtRGgJBITNLf/GI/gBh4dCE7KElGAZQTH4NZPg
        S6ye08GV4py0G29GmkVBzn4RNodABb2qfpSCVtf/TjJHJgHYuCS/iQrbvtUa9Oky
        JNMg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1683824804; x=1683911204; bh=A5jTFtJOtctoZaxC3gTjHWmQRsjq8+d+7S7
        Z9ZyMZY8=; b=hSCBN13IeyVjF6iIdaRrgVfQnSHE1/Wi2jmQqFsgNTJzgtlvc3U
        5BRIDE8TineOa0odDSb7JQFhOpcziJiUI2HrhKRqI+OBFcBtMgxw923JRnhSMqSZ
        kbxOS7zdolEGp2oL8QBg6WvAwEZ7t0UUdqk1MAFnFwMWknYqjvBYXnQJkQxVNYJ/
        04hv5Vtp7sCU2gIe5ETRWGNTltS4/wE5IJG0Qh7bSreRyAM932CuV6Vsa8Ah0LrY
        f1KmILe8Qq6LHYnwzMto1bAcVibqWIlL2DU9b9oDwxtjQW7v3mFlBQd3rUAzgn64
        Yn0yyQgbzSyl9RlUfVDz4Go3WPVArSzXWGA==
X-ME-Sender: <xms:pCBdZFa9NvYswapJocfqu6ZX0M5Sn1E8FtTlD6GH9I35l20B3yGmFw>
    <xme:pCBdZMb9p2o_zmkgl7nxPI2k9KLD8O0iaoBhzgEdpRBvyjg2dkJ_3lotP7kcze7F8
    gx9mhRqYfVy9fJ4syM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeegkedguddutdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfffhffvufgtsehttdertderredtnecuhfhrohhmpedfvehhrhhi
    shcuofhurhhphhihfdcuoehlihhsthhssegtohhlohhrrhgvmhgvughivghsrdgtohhmqe
    enucggtffrrghtthgvrhhnpeeffeeltdejheefudetjedvleffvdevieegueegffdvffev
    ffevkeeivdfhkeeikeenucffohhmrghinheprhgvughhrghtrdgtohhmnecuvehluhhsth
    gvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheplhhishhtshestgholhho
    rhhrvghmvgguihgvshdrtghomh
X-ME-Proxy: <xmx:pCBdZH9Jb_UrRPk52bHxznXhJWps41v-UwZ64qxfgfCL1CvAlWEnLw>
    <xmx:pCBdZDrRYaQxyUjA5k3ZppLZ4_tgKoED3f0XPEbjNVDxUcUZUPDLBQ>
    <xmx:pCBdZAr2W0l6UpCdY_wLSqocw7QhLa_naA8K1UprNXJyx1TGlDRWTA>
    <xmx:pCBdZNAJSFBppXG1Z50bsRltM2fxuHkXaUY529LMuRXf4uoJU6-3Ng>
Feedback-ID: i06494636:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id F42061700168; Thu, 11 May 2023 13:06:43 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-415-gf2b17fe6c3-fm-20230503.001-gf2b17fe6
Mime-Version: 1.0
Message-Id: <715c18c5-ee46-41e1-a115-203c88335e50@app.fastmail.com>
Date:   Thu, 11 May 2023 13:06:22 -0400
From:   "Chris Murphy" <lists@colorremedies.com>
To:     "Btrfs BTRFS" <linux-btrfs@vger.kernel.org>,
        "Linux Devel" <linux-fsdevel@vger.kernel.org>,
        linux-block@vger.kernel.org,
        Linux-RAID <linux-raid@vger.kernel.org>
Subject: 6.2 series regression, transient stalls during write intensive workloads
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

kernel 6.2.14-300.fc38.x86_64

Summary: User with LSI MegaRAID SAS 2108 in raid5 with Btrfs is reporting transient (but reproducible) stalls about 10s at a time, during which time the system UI is unresponsive both CLI and GUI. PSI reports no memory or CPU pressure, but light IO pressure ~10%. Some blocked tasks are captured with sysrq+w. The IO scheduler is BFQ, changing to mq-deadline might relieve some of the stalls but is inconclusive because the problem still happens. The problem does not occur with kernel 6.1.18.

Downstream bug report:
regression - transient stalls during write-intensive workload (edit) 
https://bugzilla.redhat.com/show_bug.cgi?id=2193259

Attachment, output from "(cd /sys/kernel/debug/block/sda && find . -type f -exec grep -aH . {} \;)"
https://bugzilla-attachments.redhat.com/attachment.cgi?id=1962546

sysrq+w excerpt:

[21672.537148] sysrq: Show Blocked State
[21672.537553] task:worker          state:D stack:0     pid:9723  ppid:1      flags:0x00004002
[21672.537562] Call Trace:
[21672.537565]  <TASK>
[21672.537570]  __schedule+0x3cc/0x13e0
[21672.537585]  schedule+0x5d/0xe0
[21672.537590]  io_schedule+0x42/0x70
[21672.537595]  folio_wait_bit_common+0x13d/0x370
[21672.537605]  ? __pfx_wake_page_function+0x10/0x10
[21672.537611]  folio_wait_writeback+0x28/0x80
[21672.537618]  extent_write_cache_pages+0x3ac/0x540
[21672.537628]  extent_writepages+0x5a/0x120
[21672.537633]  ? __pfx_end_bio_extent_writepage+0x10/0x10
[21672.537637]  do_writepages+0xc0/0x1d0
[21672.537644]  ? hrtimer_cancel+0x11/0x20
[21672.537650]  filemap_fdatawrite_wbc+0x5f/0x80
[21672.537654]  __filemap_fdatawrite_range+0x58/0x80
[21672.537662]  start_ordered_ops.constprop.0+0x73/0xd0
[21672.537668]  btrfs_sync_file+0xbc/0x580
[21672.537672]  ? __seccomp_filter+0x333/0x500
[21672.537681]  __x64_sys_fdatasync+0x4b/0x90
[21672.537689]  do_syscall_64+0x5c/0x90
[21672.537696]  ? syscall_exit_to_user_mode+0x17/0x40
[21672.537701]  ? do_syscall_64+0x68/0x90
[21672.537704]  ? syscall_exit_to_user_mode+0x17/0x40
[21672.537708]  ? do_syscall_64+0x68/0x90
[21672.537712]  ? syscall_exit_to_user_mode+0x17/0x40
[21672.537715]  ? do_syscall_64+0x68/0x90
[21672.537718]  ? do_syscall_64+0x68/0x90
[21672.537722]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
[21672.537729] RIP: 0033:0x7f899579ae9c
[21672.537749] RSP: 002b:00007f78a57f9650 EFLAGS: 00000293 ORIG_RAX: 000000000000004b
[21672.537754] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f899579ae9c
[21672.537757] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000010
[21672.537759] RBP: 00007f78a57f9660 R08: 0000000000000000 R09: 0000000000000001
[21672.537761] R10: 0000000000000000 R11: 0000000000000293 R12: 000055d1291be230
[21672.537764] R13: 000055d128f6f1b0 R14: 000055d1287843d8 R15: 000055d128f6f218
[21672.537771]  </TASK>
[21699.524273] sysrq: Show Blocked State
[21715.167298] sysrq: Show Blocked State
[21715.167633] task:worker          state:D stack:0     pid:9723  ppid:1      flags:0x00004002
[21715.167639] Call Trace:
[21715.167642]  <TASK>
[21715.167647]  __schedule+0x3cc/0x13e0
[21715.167657]  ? __schedule+0x3d4/0x13e0
[21715.167662]  schedule+0x5d/0xe0
[21715.167665]  io_schedule+0x42/0x70
[21715.167668]  folio_wait_bit_common+0x13d/0x370
[21715.167676]  ? __pfx_wake_page_function+0x10/0x10
[21715.167680]  folio_wait_writeback+0x28/0x80
[21715.167685]  extent_write_cache_pages+0x3ac/0x540
[21715.167692]  extent_writepages+0x5a/0x120
[21715.167694]  ? ttwu_queue_wakelist+0xbf/0x110
[21715.167700]  ? __pfx_end_bio_extent_writepage+0x10/0x10
[21715.167703]  do_writepages+0xc0/0x1d0
[21715.167707]  ? __remove_hrtimer+0x39/0x90
[21715.167711]  filemap_fdatawrite_wbc+0x5f/0x80
[21715.167714]  __filemap_fdatawrite_range+0x58/0x80
[21715.167719]  start_ordered_ops.constprop.0+0x73/0xd0
[21715.167723]  btrfs_sync_file+0xbc/0x580
[21715.167726]  ? __seccomp_filter+0x333/0x500
[21715.167732]  __x64_sys_fdatasync+0x4b/0x90
[21715.167738]  do_syscall_64+0x5c/0x90
[21715.167743]  ? syscall_exit_to_user_mode+0x17/0x40
[21715.167747]  ? do_syscall_64+0x68/0x90
[21715.167749]  ? syscall_exit_to_user_mode+0x17/0x40
[21715.167751]  ? do_syscall_64+0x68/0x90
[21715.167753]  ? syscall_exit_to_user_mode+0x17/0x40
[21715.167755]  ? do_syscall_64+0x68/0x90
[21715.167757]  ? do_syscall_64+0x68/0x90
[21715.167760]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
[21715.167765] RIP: 0033:0x7f899579ae9c
[21715.167782] RSP: 002b:00007f78a57f9650 EFLAGS: 00000293 ORIG_RAX: 000000000000004b
[21715.167785] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f899579ae9c
[21715.167787] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000010
[21715.167789] RBP: 00007f78a57f9660 R08: 0000000000000000 R09: 0000000000000001
[21715.167790] R10: 0000000000000000 R11: 0000000000000293 R12: 000055d1291be230
[21715.167792] R13: 000055d128f6f1b0 R14: 000055d1287843d8 R15: 000055d128f6f218
[21715.167797]  </TASK>
[21715.167822] task:kworker/u48:5   state:D stack:0     pid:9080  ppid:2      flags:0x00004000
[21715.167826] Workqueue: writeback wb_workfn (flush-btrfs-1)
[21715.167830] Call Trace:
[21715.167832]  <TASK>
[21715.167833]  __schedule+0x3cc/0x13e0
[21715.167839]  schedule+0x5d/0xe0
[21715.167842]  io_schedule+0x42/0x70
[21715.167845]  blk_mq_get_tag+0x11a/0x2a0
[21715.167850]  ? __pfx_autoremove_wake_function+0x10/0x10
[21715.167855]  __blk_mq_alloc_requests+0x18e/0x2e0
[21715.167861]  blk_mq_submit_bio+0x2fb/0x5f0
[21715.167867]  __submit_bio+0xf5/0x180
[21715.167872]  submit_bio_noacct_nocheck+0x32e/0x370
[21715.167876]  ? submit_bio_noacct+0x71/0x4e0
[21715.167880]  btrfs_submit_bio+0x247/0x270
[21715.167887]  submit_one_bio+0xfa/0x120
[21715.167893]  submit_extent_page+0x15f/0x500
[21715.167898]  ? __pfx_page_mkclean_one+0x10/0x10
[21715.167905]  ? __pfx_invalid_mkclean_vma+0x10/0x10
[21715.167909]  __extent_writepage_io.constprop.0+0x273/0x590
[21715.167914]  ? writepage_delalloc+0x20/0x180
[21715.167918]  __extent_writepage+0x124/0x440
[21715.167922]  extent_write_cache_pages+0x15f/0x540
[21715.167927]  extent_writepages+0x5a/0x120
[21715.167930]  ? __pfx_end_bio_extent_writepage+0x10/0x10
[21715.167933]  do_writepages+0xc0/0x1d0
[21715.167936]  ? __pfx_stack_trace_consume_entry+0x10/0x10
[21715.167942]  __writeback_single_inode+0x3d/0x360
[21715.167945]  ? _raw_spin_lock+0x13/0x40
[21715.167950]  writeback_sb_inodes+0x1ed/0x4b0
[21715.167955]  __writeback_inodes_wb+0x4c/0xf0
[21715.167958]  wb_writeback+0x172/0x2f0
[21715.167962]  wb_workfn+0x357/0x510
[21715.167964]  ? __schedule+0x3d4/0x13e0
[21715.167969]  process_one_work+0x1c7/0x3d0
[21715.167974]  worker_thread+0x4d/0x380
[21715.167978]  ? __pfx_worker_thread+0x10/0x10
[21715.167981]  kthread+0xe9/0x110
[21715.167985]  ? __pfx_kthread+0x10/0x10
[21715.167988]  ret_from_fork+0x2c/0x50
[21715.167996]  </TASK>

full dmesg attachment
https://bugzilla-attachments.redhat.com/attachment.cgi?id=1962385


Thanks,



--
Chris Murphy
