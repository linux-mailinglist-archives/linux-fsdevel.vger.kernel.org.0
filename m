Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 916F559AFF7
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Aug 2022 21:44:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230520AbiHTTmU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 20 Aug 2022 15:42:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbiHTTmT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 20 Aug 2022 15:42:19 -0400
Received: from wnew3-smtp.messagingengine.com (wnew3-smtp.messagingengine.com [64.147.123.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D604F2C662;
        Sat, 20 Aug 2022 12:42:18 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.west.internal (Postfix) with ESMTP id 4629C2B05A21;
        Sat, 20 Aug 2022 15:42:16 -0400 (EDT)
Received: from imap50 ([10.202.2.100])
  by compute3.internal (MEProxy); Sat, 20 Aug 2022 15:42:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        colorremedies.com; h=cc:content-type:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1661024535; x=1661028135; bh=0U1JLPcK55
        TWd7xgBsPnyw0MVtPI/0bLbJYv9Uwywcc=; b=jlW9wDB46vhDe8EJZB7MSB1zG9
        /R2J/6nolnr1Dh4cLiZA4ZAC5AYH3yt/2BBwIukAlZI55OGnvyEJh5jb6X0PXEF4
        Yr/NIi5iGiEi9SQH6ceA0OMVFs0ovERIJXUTNBRNMjc66KMkpgMM5hVSVOEAMYz8
        csuT+ZVlZ2yxFSLVCBK2uBM5lcuAhtw80PYJfs6Hj1QqePzoRU9jxtKmbCMLmHei
        6G5JQcMaKOB9eyvfuYUpfDjMChh+fhrF5wYdSino5yMtDo91zwSu9QMlmTga97wU
        0KqH7p9AbSQ/a/bz+3jV2PXBmT6BW13FhTW4fO7F/Ie8AMlCYAAPcVVPvN/Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:message-id:mime-version
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1661024535; x=
        1661028135; bh=0U1JLPcK55TWd7xgBsPnyw0MVtPI/0bLbJYv9Uwywcc=; b=F
        KTrQSCFnfdYuqTB4aFDl+kxii2dN1z6z77tOrXLcykmgVQ13Wz+UGQgtaZFw1vNK
        Xtw4zD4jVSMDfliQP0yE0QAIJA66loiqIuN4blz1Imiw8Gg/qTw8EntLI6jenh2J
        h5MLGS2jz2V4VB1RD3hswGVz+wnZVmq7zSfslOdCVtnttqvUbVxMrVknKvOsT0YJ
        gm6HJm9XNbC9Bj/kUwNx4HbsoM/IWTPXjg+ed7L4QJTN2Vj/Gc9/+Gtp9+CO+wyu
        RtYzpg8q4IVxgVu5zuMKCFhvI78WyT98yWpQaoa9hQmiIOBEUMdmLrPwBNBWJ+Yx
        8y2yRNsMs/b+4WuKCKt2Q==
X-ME-Sender: <xms:FzkBY6ICWv3Q33Zt6xyoXos-JgrNkMuwDnxCIhRNk5rhhc0n9TVPUw>
    <xme:FzkBYyLH_u46STHuLWY2eMuffycM4eCVwZh--ixC8ks6rw3J2fgx6Pq99vjGyOI7n
    ODMkxvKnadN0hDs49Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdeifedgudegvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enogfuuhhsphgvtghtffhomhgrihhnucdlgeelmdenucfjughrpefofgggkfffhffvufgt
    sehttdertderredtnecuhfhrohhmpedfvehhrhhishcuofhurhhphhihfdcuoehlihhsth
    hssegtohhlohhrrhgvmhgvughivghsrdgtohhmqeenucggtffrrghtthgvrhhnpeevuefh
    leefkeehhffggfelveefkeffieeljeffffethfeludeggeetveduledtleenucffohhmrg
    hinhepghhoohhglhgvrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomheplhhishhtshestgholhhorhhrvghmvgguihgvshdrtghomh
X-ME-Proxy: <xmx:FzkBY6utG7DI78XH6MGTo1wQHtRu2PJvx_rnq5bgAZ4L_epnRts79w>
    <xmx:FzkBY_b_V4KaayOGf9N1a29QYkxNf4kmaPndsqiy9ZjT3dmxnxnMEw>
    <xmx:FzkBYxbEehYdzQbFvzWcdIvXVumUjpEj64Am5KMqdziZVylEBKql0g>
    <xmx:FzkBYyC1cltcVkzaFkJ53CYEgDzJ0MzdF6-Wy5HSPqUHKvyJiyneHypsFlw>
Feedback-ID: i06494636:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 5C01D1700403; Sat, 20 Aug 2022 15:42:15 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-841-g7899e99a45-fm-20220811.002-g7899e99a
Mime-Version: 1.0
Message-Id: <73ea63fe-0c8e-412b-9fb2-94c08933180a@www.fastmail.com>
Date:   Sat, 20 Aug 2022 15:39:46 -0400
From:   "Chris Murphy" <lists@colorremedies.com>
To:     linux-kernel <linux-kernel@vger.kernel.org>,
        "Linux List" <linux-mm@kvack.org>,
        "Linux Devel" <linux-fsdevel@vger.kernel.org>
Subject: 6.0-rc1 BUG squashfs_decompress, and sleeping function called from invalid
 context at include/linux/sched/mm.h
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

Seeing the following on every boot with kernel 6.0-rc1, when booting a Fedora Rawhide Live ISO with qemu-kvm. Full dmesg at:

https://drive.google.com/file/d/15u38HZD9NSihIvz4P9M0W3dx6FZWq0MX/view?usp=sharing

Excerpt:

[   72.111934] kernel: BUG: sleeping function called from invalid context at include/linux/sched/mm.h:274
[   72.111960] kernel: in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 94, name: kworker/u6:5
[   72.111965] kernel: preempt_count: 1, expected: 0
[   72.111969] kernel: RCU nest depth: 0, expected: 0
[   72.111975] kernel: 4 locks held by kworker/u6:5/94:
[   72.111980] kernel:  #0: ffff9e87f4fc4d48 ((wq_completion)loop1){+.+.}-{0:0}, at: process_one_work+0x20b/0x600
[   72.112059] kernel:  #1: ffffb741c0b83e78 ((work_completion)(&worker->work)){+.+.}-{0:0}, at: process_one_work+0x20b/0x600
[   72.112079] kernel:  #2: ffff9e87f654ad50 (mapping.invalidate_lock#3){.+.+}-{3:3}, at: page_cache_ra_unbounded+0x69/0x1a0
[   72.112100] kernel:  #3: ffffd741bfa132f8 (&stream->lock){+.+.}-{2:2}, at: squashfs_decompress+0x5/0x1b0 [squashfs]
[   72.112122] kernel: Preemption disabled at:
[   72.112125] kernel: [<ffffffffc0605f1d>] squashfs_decompress+0x2d/0x1b0 [squashfs]
[   72.112139] kernel: CPU: 2 PID: 94 Comm: kworker/u6:5 Not tainted 6.0.0-0.rc1.20220818git3b06a2755758.15.fc38.x86_64 #1
[   72.112144] kernel: Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0 02/06/2015
[   72.112147] kernel: Workqueue: loop1 loop_workfn [loop]
[   72.112163] kernel: Call Trace:
[   72.112169] kernel:  <TASK>
[   72.112175] kernel:  dump_stack_lvl+0x5b/0x77
[   72.112190] kernel:  __might_resched.cold+0xff/0x13a
[   72.112202] kernel:  kmem_cache_alloc_trace+0x207/0x370
[   72.112217] kernel:  handle_next_page+0x76/0xe0 [squashfs]
[   72.112228] kernel:  squashfs_xz_uncompress+0x58/0x200 [squashfs]
[   72.112236] kernel:  ? __wait_for_common+0xab/0x1d0
[   72.112253] kernel:  squashfs_decompress+0xbd/0x1b0 [squashfs]
[   72.112268] kernel:  squashfs_read_data+0xe7/0x5a0 [squashfs]
[   72.112291] kernel:  squashfs_readahead+0x4cd/0xb60 [squashfs]
[   72.112306] kernel:  ? kvm_sched_clock_read+0x14/0x40
[   72.112310] kernel:  ? sched_clock_cpu+0xb/0xc0
[   72.112350] kernel:  read_pages+0x4a/0x390
[   72.112365] kernel:  page_cache_ra_unbounded+0x118/0x1a0
[   72.112386] kernel:  filemap_get_pages+0x3d0/0x6b0
[   72.112402] kernel:  ? lock_is_held_type+0xe8/0x140
[   72.112427] kernel:  filemap_read+0xb4/0x410
[   72.112437] kernel:  ? avc_has_perm_noaudit+0xd3/0x1c0
[   72.112452] kernel:  ? __lock_acquire+0x388/0x1ef0
[   72.112467] kernel:  ? avc_has_perm+0x37/0xb0
[   72.112488] kernel:  do_iter_readv_writev+0xfa/0x110
[   72.112511] kernel:  do_iter_read+0xeb/0x1e0
[   72.112525] kernel:  loop_process_work+0x6fb/0xad0 [loop]
[   72.112550] kernel:  ? lock_acquire+0xde/0x2d0
[   72.112576] kernel:  process_one_work+0x29d/0x600
[   72.112602] kernel:  worker_thread+0x4f/0x3a0
[   72.112615] kernel:  ? process_one_work+0x600/0x600
[   72.112619] kernel:  kthread+0xf2/0x120
[   72.112625] kernel:  ? kthread_complete_and_exit+0x20/0x20
[   72.112638] kernel:  ret_from_fork+0x1f/0x30
[   72.112676] kernel:  </TASK>

--
Chris Murphy
