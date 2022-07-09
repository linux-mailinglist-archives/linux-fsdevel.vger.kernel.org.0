Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8205D56C748
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Jul 2022 07:34:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbiGIFed (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 9 Jul 2022 01:34:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiGIFec (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 9 Jul 2022 01:34:32 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E76F089A81;
        Fri,  8 Jul 2022 22:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1657344868;
        bh=WQJYEsiTE2uKcSIa88wX9tDWIRA1dKUlveQY5EoYUgs=;
        h=X-UI-Sender-Class:Date:To:From:Subject;
        b=i0f0K89NqWgoVBjzdY0fafkvfiTGvnzO1NBRlwsgIxjkcgUoEEXWrZ4weTRrkxNcn
         NW7u3m50Mf3ZT2ET0FYDpzjY1iE7JOZ7z2SlWyvzh7nwaOxTzMWelpCqDXirKhFDiJ
         xqLxElJ2pwXTsJQv+cg9MNx25qGi07jE84yhZ51I=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.134.222]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MQ5vW-1nwtwh3iJU-00M0As; Sat, 09
 Jul 2022 07:34:27 +0200
Message-ID: <fe10a412-8a1b-d582-a80b-8832519e0314@gmx.de>
Date:   Sat, 9 Jul 2022 07:33:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        linux-parisc <linux-parisc@vger.kernel.org>
From:   Helge Deller <deller@gmx.de>
Subject: WARNING: CPU: 1 PID: 14735 at fs/dcache.c:365 dentry_free+0x100/0x128
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Bo1iDPqNzEIlDBTe7ZziPASjiqeLpZ4fTonwjaN0gNa3vU69Bie
 HQ3cYQhieH9i02VADN4ZB1FXOUF+Xmq+ncjsf6sSWYMBsI0cENrSB8ryMPcrM9DsXSwaTfR
 s5UC0OYqJu4hTMdgSiAbty9JITVNAiHatT/V7CLdhTZOmgf18fhWCh7bNDdRjlry8xDhqge
 7ABeW/1l72cr7vqZ3/iHA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:evpVDAfgM/k=:FCitVBuC0+fSEB/pYdIaol
 C2VDu+NHLSjtOnHcYgYLb11qp9eIGp355AD+JkfE80nspWX3hgrgoSNyzr8NES9eoMolfDp4q
 y1wZL59hvKW1KKOep1JsY3FnTDpRJDCzDMhp+YkO89F4M/p/hiKoGt6OL+H5HSy/FeYH/xyA3
 kCeqslt5v69IRM/N+dDlqgiRluA/wz+hLirJMycoUV4mqkMT6mTZn4Sxk1tPZBK4jZc85nlMp
 3fEmT3ah0r3Qhv+1ioAggISxeaQzdjYquLPtGoPyvvZof/K3dC+K7EBCJPBut77KDeWHzvWcD
 YY2p2UWOLt4z7q6IsPsQyrweGeVOV6v7x9jziQ52g4JQcCdPvduyu6mmIx9wBFlXWUPvwFO2k
 R1khYS6FtGbi0hkvWEAL1kAJuQJVKmUyST/EsQ8ka9QVpuvBWDjs/++Kjqrso0EgSxuGLFvRg
 ccDhjazA19+pBNorlqXJA7WxIvD/rk5l39Ls2rtQYvsavXOhLJqRxuC3mIopFwcs4dOis/iDw
 SYsBQl6aSeUigqK1ISuYPX2WUzp2Uful6bLZcyIa/Z72G7ImclTzPP8zUPcJFai83TC7pDGtQ
 YtZHscCJA3/u1E2LOuU96VVz+ymoULjx4S7B81xa4QPBsgWcXFmkPw9fZv4YP0JOHBrFwGMHG
 mtu/AwOIGZWdOR5eFXClKeHgFGQmxS8x1Qmb1QcCWZLHPw8ZLo5PGJhI8GHkEbR05bxlY+NbP
 905fUoI2df2wXaDVCjIbx5vOJpdLMFN4RmcO9sYy6qL6FNHmcIKjtBCWeVo5NvovVc42eACV4
 ulolLpRSco9tDFWhPwSzdlYBfvv/u4zmf7sORx7TuF60KbeEBenH1ChZrPr0hUQblgdyxFSnz
 7gA0DaVNyrDRboVqnQFBhqPBW0TijECn+/RW7gZ9fyswaktKkfRT5hei1zyX6+uZxZkyvUfJT
 y6HgNkeUTaG30Kx87NDAO9UrknbvNMVXYl6Zfq/cjxEnkFfEIiTBISspTZlcUTkLfyClgxYir
 SAue5kqn3FAMTMFpbluvOFFnGqckhdjThSAukwD6DCvfRDayWCGrd+Q6fJv2dAyEMx/hg060g
 TiFM6LijjqKX2LBMX1U2RPYG5cjQjcnNA85+7qEO0Wn0k+Ke6t6kMH48g==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On the debian buildd servers for the parisc architecture I'm facing
the following warning, after which it gets stuck so that I need to
reboot the server.
This happens rarely, but I can reproduce it after some time.
Filesystem is tmpfs.

I'm happy to add debug code if necessary...

Helge

[128321.224739] ------------[ cut here ]------------
[128321.283492] WARNING: CPU: 1 PID: 14735 at fs/dcache.c:365 dentry_free+=
0x100/0x128
[128321.371369] Modules linked in: dm_mod(E) ipt_REJECT(E) nf_reject_ipv4(=
E) xt_multiport(E) nft_compat(E) nf_tables(E) nfnetlink(E) ipmi_si(E) ipmi=
_devintf(E) sg(E) ipmi_msghandler(E) fuse(E) configfs(E) sunrpc(E) ip_tabl=
es(E) x_tables(E) autofs4(E) ext4(E) crc16(E) mbcache(E) jbd2(E) btrfs(E) =
blake2b_generic(E) xor(E) raid6_pq(E) zstd_compress(E) libcrc32c(E) crc32c=
_generic(E) sd_mod(E) t10_pi(E) crc64_rocksoft(E) crc64(E) crc_t10dif(E) c=
rct10dif_generic(E) ohci_pci(E) crct10dif_common(E) ata_generic(E) sata_si=
l(E) ehci_pci(E) pata_sil680(E) mptspi(E) mptscsih(E) ohci_hcd(E) mptbase(=
E) scsi_transport_spi(E) ehci_hcd(E) libata(E) scsi_mod(E) usbcore(E) e100=
0(E) usb_common(E) scsi_common(E)
[128322.103374] CPU: 1 PID: 14735 Comm: cc1plus Tainted: G            E   =
  5.18.9+ #27
[128322.195315] Hardware name: 9000/785/C8000
[128322.247318]
[128322.263314]      YZrvWESTHLNXBCVMcbcbcbcbOGFRQPDI
[128322.323316] PSW: 00001000000001101111000000001111 Tainted: G          =
  E
[128322.407315] r00-03  000000000806f00f 0000000239aa8700 000000004073be90=
 0000000239aa87a0
[128322.507313] r04-07  00000000410e1a00 000000411c8e3b40 0000000211715ad8=
 000000411c8e3b98
[128322.603314] r08-11  00000000410b8e80 0000000041147200 00000000000800e0=
 0000000041147200
[128322.699311] r12-15  0000000000000001 0000000010000000 0000000041147200=
 0000000041147200
[128322.795312] r16-19  000000411c8e3b98 0000000000000000 00000000415084d0=
 0000000002c55000
[128322.895311] r20-23  000000000800000f 000000004fb33600 000000000800000f=
 0000000211715b20
[128322.991311] r24-27  000000411c8e3bd0 000000411c8e3bd0 000000411c8e3b40=
 00000000410e1a00
[128323.087309] r28-31  00000000416bf9d8 0000000239aa8770 0000000239aa8820=
 000000000000cf14
[128323.187310] sr00-03  000000000500a800 0000000000000000 000000000000000=
0 000000000500a800
[128323.283324] sr04-07  0000000000000000 0000000000000000 000000000000000=
0 0000000000000000
[128323.383313]
[128323.399309] IASQ: 0000000000000000 0000000000000000 IAOQ: 000000004073=
b3d4 000000004073b3d8
[128323.503310]  IIR: 03ffe01f    ISR: 0000000010340400  IOR: 000003e6aa2a=
87a8
[128323.587306]  CPU:        1   CR30: 0000000212ff0ce0 CR31: ffffffffffff=
ffff
[128323.667328]  ORIG_R28: 0000000239aa8920
[128323.715307]  IAOQ[0]: dentry_free+0x100/0x128
[128323.771306]  IAOQ[1]: dentry_free+0x104/0x128
[128323.823305]  RP(r2): __dentry_kill+0x284/0x2e8
[128323.875347] Backtrace:
[128323.907319]  [<000000004073be90>] __dentry_kill+0x284/0x2e8
[128323.975309]  [<000000004073d6d8>] dput+0x334/0x5a8
[128324.031311]  [<0000000040726d94>] step_into+0x790/0xa88
[128324.095309]  [<0000000040728910>] path_openat+0x21c/0x1ba8
[128324.163310]  [<000000004072c018>] do_filp_open+0x9c/0x198
[128324.231310]  [<0000000040702320>] do_sys_openat2+0x14c/0x2a8
[128324.299309]  [<0000000040702c54>] compat_sys_openat+0x58/0xb8
[128324.367308]  [<0000000040303e30>] syscall_exit+0x0/0x10

after that:

[128324.451303] ---[ end trace 0000000000000000 ]---
[128345.511159] rcu: INFO: rcu_sched self-detected stall on CPU
[128345.511159] rcu:    0-...!: (5249 ticks this GP) idle=3D3c3/1/0x400000=
0000000002 softirq=3D35954078/35954078 fqs=3D54
[128345.511159]         (t=3D5250 jiffies g=3D33838821 q=3D175418)
[128345.511159] rcu: rcu_sched kthread starved for 5146 jiffies! g33838821=
 f0x0 RCU_GP_WAIT_FQS(5) ->state=3D0x0 ->cpu=3D1
[128345.511159] rcu:    Unless rcu_sched kthread gets sufficient CPU time,=
 OOM is now expected behavior.
[128345.511159] ...
[128345.511159]
[128345.511159] rcu: Stack dump where RCU GP kthread last ran:
[128345.511159] Task dump for CPU 1:
[128345.511159] task:cc1plus         state:R  running task     stack:    0=
 pid:14735 ppid: 14734 flags:0x00000014
[128345.511159] Backtrace:
[128345.511159]  [<000000004071f5c8>] __legitimize_path+0x7c/0x108
[128345.511159]  [<00000000407210d4>] lookup_fast+0x1c8/0x290
[128345.511159]  [<00000000407277b4>] walk_component+0x1e8/0x330
[128345.511159]  [<0000000040727be8>] link_path_walk.part.0.constprop.0+0x=
2ec/0x4d0
[128345.511159]  [<0000000040728844>] path_openat+0x150/0x1ba8
[128345.511159]  [<000000004072c018>] do_filp_open+0x9c/0x198
[128345.511159]  [<0000000040702320>] do_sys_openat2+0x14c/0x2a8
[128345.511159]  [<0000000040702c54>] compat_sys_openat+0x58/0xb8
[128345.511159]  [<0000000040303e30>] syscall_exit+0x0/0x10
[128345.511159]
