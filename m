Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B08B5A5BDC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Aug 2022 08:31:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbiH3Gbr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Aug 2022 02:31:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230181AbiH3Gbl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Aug 2022 02:31:41 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A99D67C75F
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Aug 2022 23:31:38 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 514D85C013F;
        Tue, 30 Aug 2022 02:31:35 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Tue, 30 Aug 2022 02:31:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rath.org; h=cc
        :content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1661841095; x=1661927495; bh=zf7fDwcJn7
        WQq9ptrk6vQ3Oilf6zxTV8H8hk70D5BqI=; b=e58Zb/gLO9PQ6EDsia+A+VBdJ0
        ehdK9ReS0MvLfIzZVOj5qOcDl/xNhDy25Ch59l4t6bJTYBW6v1JYQgkzNI1BmLdK
        CUi7hIIdroklr683emuuM+mUmVy8/DHbCkzZmjwBniVOR2hphCZJsnp9DyrfBBmJ
        rCMtg/qbPF7Ye3QMb2RXdb5hGnN3A6H1bFhJhiAgc8NeHENN2WXsV9UGwL+vMngW
        YIfNAJXrhxqgyu2S3cxO9SyAlYGEbQCbDFmz5qMFe0T8q0QIUAF0cAEbNp0JzbL3
        K74fi/7Brh7cqkmALXh/Pke+3xfATdylygySL23kDLWhwqmTPx2DivzqVFyA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:feedback-id:feedback-id:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1661841095; x=1661927495; bh=zf7fDwcJn7WQq9ptrk6vQ3Oilf6z
        xTV8H8hk70D5BqI=; b=QTj4+sUI3qHyJ2H8H2Fze/OSBuXyQJ/2oBF33tA4YKIW
        9ffmZq9K+tW/bCZrrw5kav5vy0OcFvfxg7T7Wh4v8glS+tlIsfnYXUlx4FWnbOuC
        vqqX7mOUHJHU/kD9uZMz1HxRKi6MAIR0IUXhAohSBHCjfHvs1QqiTdDAAtH5s85Y
        jdC+69MS/j7jwJQgsjUNyELHyhlZjDHL4e4P7PDiR3q0oVRYi4CQKLOS4DaNdF0r
        WvTF/+I8PMWRISWd8wZobKNufRosdefRfYMF5E8NUXFhygir6z0kEWB8CdZwe5Df
        gv3xMJeJ5VUx6rupx2rqoNPREHcoBwaXY8/P++M/eQ==
X-ME-Sender: <xms:xq4NY3RHR2R6ORPKgcLa0_k9gr500YSLrXia80HFwoSskWAKOOmIxQ>
    <xme:xq4NY4zAcXsZrPdKXi2KfWKNYrrG-3djSdmKuy_qhVPQXZjRgIIUkgDK0cJuuOz24
    JvkByFRtCOwNzjn>
X-ME-Received: <xmr:xq4NY80b3aJSUcB8HI-OpG5knH_qMBkhFIKaJuoVYwj1UGS_GzdhKKpqpajUlKdV8iuT8CTS4oo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdekvddguddtlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvffufffkfgggtgfgsehtqhdttddtreejnecuhfhrohhmpefpihhkohhl
    rghushcutfgrthhhuceopfhikhholhgruhhssehrrghthhdrohhrgheqnecuggftrfgrth
    htvghrnhepfeethffgjefhleekudeileduueffudevvdevfeekvedtveegveefjefgvdeu
    tdeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheppf
    hikhholhgruhhssehrrghthhdrohhrgh
X-ME-Proxy: <xmx:xq4NY3Bw_qq8HFpa_SAt---dEacfX6dicYHXx9ERpJwse4y_KZpZzg>
    <xmx:xq4NYwhE3moWoJgL64lvgdq72eiw-hSLmOq2-wzb5aCe5Fg6AG-xtA>
    <xmx:xq4NY7rDCFok2xhLbkb5t0CXZmp3fXJLDl39khn2Qp-gMdISF-F81g>
    <xmx:x64NY6b2JYg44_Z3aSBf9uX1aDztdvm5ebOERuRCnaaPiM-qK24u0w>
Feedback-ID: i53a843ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 30 Aug 2022 02:31:34 -0400 (EDT)
Received: from vostro.rath.org (vostro [192.168.12.4])
        by ebox.rath.org (Postfix) with ESMTPS id D5B7B7B6;
        Tue, 30 Aug 2022 06:31:32 +0000 (UTC)
Received: by vostro.rath.org (Postfix, from userid 1000)
        id B9F8A28791; Tue, 30 Aug 2022 07:31:31 +0100 (BST)
From:   Nikolaus Rath <Nikolaus@rath.org>
To:     nbd@other.debian.org,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        miklos <mszeredi@redhat.com>, Wouter Verhelst <w@uter.be>
Subject: Why do NBD requests prevent hibernation, and FUSE requests do not?
Mail-Copies-To: never
Mail-Followup-To: nbd@other.debian.org, Linux FS Devel
        <linux-fsdevel@vger.kernel.org>, miklos <mszeredi@redhat.com>, Wouter
        Verhelst <w@uter.be>
Date:   Tue, 30 Aug 2022 07:31:31 +0100
Message-ID: <87k06qb5to.fsf@vostro.rath.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

I am comparing the behavior of FUSE and NBD when attempting to hibernate
the system.

FUSE seems to be mostly compatible, I am able to suspend the system even
when there is ongoing I/O on the fuse filesystem.

With NBD, on the other hand, most I/O seems to prevent hibernation the
system. Example hibernation error:

  kernel: Freezing user space processes ...=20
  kernel: Freezing of tasks failed after 20.003 seconds (1 tasks refusing t=
o freeze, wq_busy=3D0):
  kernel: task:rsync           state:D stack:    0 pid:348105 ppid:348104 f=
lags:0x00004004
  kernel: Call Trace:
  kernel:  <TASK>
  kernel:  __schedule+0x308/0x9e0
  kernel:  schedule+0x4e/0xb0
  kernel:  schedule_timeout+0x88/0x150
  kernel:  ? __bpf_trace_tick_stop+0x10/0x10
  kernel:  io_schedule_timeout+0x4c/0x80
  kernel:  __cv_timedwait_common+0x129/0x160 [spl]
  kernel:  ? dequeue_task_stop+0x70/0x70
  kernel:  __cv_timedwait_io+0x15/0x20 [spl]
  kernel:  zio_wait+0x129/0x2b0 [zfs]
  kernel:  dmu_buf_hold+0x5b/0x90 [zfs]
  kernel:  zap_lockdir+0x4e/0xb0 [zfs]
  kernel:  zap_cursor_retrieve+0x1ae/0x320 [zfs]
  kernel:  ? dbuf_prefetch+0xf/0x20 [zfs]
  kernel:  ? dmu_prefetch+0xc8/0x200 [zfs]
  kernel:  zfs_readdir+0x12a/0x440 [zfs]
  kernel:  ? preempt_count_add+0x68/0xa0
  kernel:  ? preempt_count_add+0x68/0xa0
  kernel:  ? aa_file_perm+0x120/0x4c0
  kernel:  ? rrw_exit+0x65/0x150 [zfs]
  kernel:  ? _copy_to_user+0x21/0x30
  kernel:  ? cp_new_stat+0x150/0x180
  kernel:  zpl_iterate+0x4c/0x70 [zfs]
  kernel:  iterate_dir+0x171/0x1c0
  kernel:  __x64_sys_getdents64+0x78/0x110
  kernel:  ? __ia32_sys_getdents64+0x110/0x110
  kernel:  do_syscall_64+0x38/0xc0
  kernel:  entry_SYSCALL_64_after_hwframe+0x44/0xae
  kernel: RIP: 0033:0x7f03c897a9c7
  kernel: RSP: 002b:00007ffd41e3c518 EFLAGS: 00000293 ORIG_RAX: 00000000000=
000d9
  kernel: RAX: ffffffffffffffda RBX: 0000561eff64dd40 RCX: 00007f03c897a9c7
  kernel: RDX: 0000000000008000 RSI: 0000561eff64dd70 RDI: 0000000000000000
  kernel: RBP: 0000561eff64dd70 R08: 0000000000000030 R09: 00007f03c8a72be0
  kernel: R10: 0000000000020000 R11: 0000000000000293 R12: ffffffffffffff80
  kernel: R13: 0000561eff64dd44 R14: 0000000000000000 R15: 0000000000000001
  kernel:  </TASK>

(this is with ZFS on top of the NBD device).


As far as I can tell, the problem is that while an NBD request is
pending, the atsk that waits for the result (in this case *rsync*) is
refusing to freeze. This happens even when setting a 5 minute timeout
for freezing (which is more than enough time for the NBD request to
complete), so I suspect that the NBD server task (in this case nbdkit)
has already been frozen and is thus unable to make progress.

However, I do not understand why the same is not happening for FUSE
(with FUSE requests being stuck because the FUSE daemon is already
frozen). Was I just very lucky in my tests? Or are tasks waiting for
FUSE request in a different kind of state? Or is NBD a red-herring here,
and the real trouble is with ZFS?

It would be great if someone  could shed some light on what's going on.


Best,
-Nikolaus

--=20
GPG Fingerprint: ED31 791B 2C5C 1613 AF38 8B8A D113 FCAC 3C4E 599F

             =C2=BBTime flies like an arrow, fruit flies like a Banana.=C2=
=AB
