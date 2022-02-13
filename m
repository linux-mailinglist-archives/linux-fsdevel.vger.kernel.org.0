Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EB5A4B3BD5
	for <lists+linux-fsdevel@lfdr.de>; Sun, 13 Feb 2022 15:34:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236529AbiBMOen (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 13 Feb 2022 09:34:43 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236511AbiBMOen (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 13 Feb 2022 09:34:43 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47CB25F8C4;
        Sun, 13 Feb 2022 06:34:37 -0800 (PST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21DDx5UQ029940;
        Sun, 13 Feb 2022 14:34:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=0/mWjykeDvQHjBAUDiwDZccLK7VANuQtfTfov5zVoeQ=;
 b=ey6x0O6jb8cOdUeuYvSQvnjLdfY9Ls15A7HwEgkvu2CR9ZgdmHhSYvdK/WdZ9W+kA1XE
 h41p6ov3vzXFdebwoSDsAMsAfpSoL3L5ps5qkks+aWENwjxyhKzRjPaGXXUsGm99L7ny
 1j9ADhb1ex0ElJMPWkwt0VNzAkxCljBaLfFzwqAMEWCvP5Z2d8tsdKiu5yRVIQvcEOyl
 spDLKZ9duW6T2uPRHU4MGdgenZq94mV3c1nlUeZSPgr3C5GEBaRzWFkko3LSS3mvq5+J
 C+rvh60xBI5pDAGjjJ1M6QYARfInt4KJECVRq+17DKohRYdnpWWacl5X0rBUd2ZammlW Mg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3e73bhrd7j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 13 Feb 2022 14:34:21 +0000
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 21DERvKx026205;
        Sun, 13 Feb 2022 14:34:20 GMT
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3e73bhrd79-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 13 Feb 2022 14:34:20 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 21DEXrTh010639;
        Sun, 13 Feb 2022 14:34:18 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma04fra.de.ibm.com with ESMTP id 3e64h9eag5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 13 Feb 2022 14:34:18 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 21DEYGOt42271228
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 13 Feb 2022 14:34:16 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E66844C044;
        Sun, 13 Feb 2022 14:34:15 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DA0B74C040;
        Sun, 13 Feb 2022 14:34:13 +0000 (GMT)
Received: from localhost (unknown [9.43.64.124])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sun, 13 Feb 2022 14:34:12 +0000 (GMT)
Date:   Sun, 13 Feb 2022 20:04:10 +0530
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     syzbot <syzbot+a8e049cd3abd342936b6@syzkaller.appspotmail.com>
Cc:     djwong@kernel.org, fgheet255t@gmail.com, hch@infradead.org,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] WARNING in iomap_iter
Message-ID: <20220213143410.qdqxlixuzgtq56yl@riteshh-domain>
References: <000000000000f2075605d04f9964@google.com>
 <00000000000011f55805d7d8352c@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00000000000011f55805d7d8352c@google.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: WyJVjGNFhbaGhToKIApbY2xPE5vJzbbY
X-Proofpoint-GUID: I_GXi0zxWlhDIoSDpncX8FWN0uAAvBT-
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-13_05,2022-02-11_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 spamscore=0 priorityscore=1501 mlxlogscore=999 adultscore=0
 impostorscore=0 clxscore=1011 bulkscore=0 suspectscore=0
 lowpriorityscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2201110000 definitions=main-2202130099
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 22/02/12 12:41PM, syzbot wrote:
> syzbot has found a reproducer for the following issue on:
>
> HEAD commit:    83e396641110 Merge tag 'soc-fixes-5.17-1' of git://git.ker..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=11fe01a4700000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=88e0a6a3dbf057cf
> dashboard link: https://syzkaller.appspot.com/bug?extid=a8e049cd3abd342936b6
> compiler:       Debian clang version 11.0.1-2, GNU ld (GNU Binutils for Debian) 2.35.2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14f8cad2700000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=132c16ba700000

FYI - I could reproduce with above C reproduer on my setup 5.17-rc3.
I was also able to hit it with XFS <below stack shows that>

So here is some initial analysis on this one. I haven't completely debugged it
though. I am just putting my observations here for others too.

It seems iomap_dio_rw is getting called with a negative iocb->ki_pos value.
(I haven't yet looked into when can this happen. Is it due to negative loop
device mapping range offset or something?)

i.e.
(gdb) p iocb->ki_pos
$101 = -2147483648
(gdb) p /x iocb->ki_pos
$102 = 0xffffffff80000000
(gdb)

This when passed to ->iomap_begin() sometimes is resulting into iomap->offset
which is a positive value and hence hitting below warn_on_once in
iomap_iter_done().

		WARN_ON_ONCE(iter->iomap.offset > iter->pos)

1. So I think the question here is what does it mean when xfs/ext4_file_read_iter()
   is called with negative iocb->ki_pos value?
2. Also when can iocb->ki_pos be negative?

<Stack Track on XFS>
======================

[  998.417802] ------------[ cut here ]------------
[  998.420195] WARNING: CPU: 0 PID: 1579 at fs/iomap/iter.c:33
iomap_iter+0x301/0x320
[  998.424610] Modules linked in:
[  998.425683] CPU: 0 PID: 1579 Comm: kworker/u2:5 Tainted:
G        W         5.17.0-rc3+ #0
[  998.428085] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.13.0-1ubuntu1 04
[  998.430830] Workqueue: loop0 loop_rootcg_workfn
[  998.432300] RIP: 0010:iomap_iter+0x301/0x320
[  998.433647] Code: 89 f2 e8 72 f1 ff ff 65 ff 0d bb d0 ce 7e 0f 85 c4 fe ff ff
e8 2f 3e cdc
[  998.438518] RSP: 0018:ffffc90000c13b30 EFLAGS: 00010307
[  998.440490] RAX: 0000000000010000 RBX: ffffc90000c13bc0 RCX: 000000000000000c
[  998.442576] RDX: ffffffff80000000 RSI: 0000000000001000 RDI: 0000000000000000
[  998.444625] RBP: ffffc90000c13b50 R08: 0000000000000003 R09: ffff88814ceb9b00
[  998.446768] R10: ffff88815122e000 R11: 000000000000000f R12: ffffffff82657c90
[  998.453038] R13: ffffc90000c13be8 R14: ffffc90000c13c30 R15: ffffffff82657c90
[  998.455533] FS:  0000000000000000(0000) GS:ffff88852bc00000(0000)
knlGS:0000000000000000
[  998.458136] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  998.460069] CR2: 00007ffff4443000 CR3: 0000000105e7e000 CR4: 00000000000006f0
[  998.462447] Call Trace:
[  998.463108]  <TASK>
[  998.464510]  __iomap_dio_rw+0x25b/0x840
[  998.466005]  iomap_dio_rw+0xe/0x30
[  998.467476]  xfs_file_dio_read+0xb9/0xf0
[  998.469044]  xfs_file_read_iter+0xc1/0xe0
[  998.470623]  lo_rw_aio+0x27a/0x2a0
[  998.472042]  loop_process_work+0x2c7/0x8c0
[  998.473621]  ? finish_task_switch+0xbc/0x260
[  998.475232]  ? __switch_to+0x2cf/0x480
[  998.476832]  loop_rootcg_workfn+0x1b/0x20
[  998.478431]  process_one_work+0x1b7/0x380
[  998.479958]  worker_thread+0x4d/0x380
[  998.481440]  ? process_one_work+0x380/0x380
[  998.482992]  kthread+0xff/0x130
[  998.484420]  ? kthread_complete_and_exit+0x20/0x20
[  998.486122]  ret_from_fork+0x22/0x30
[  998.487616]  </TASK>
[  998.488199] ---[ end trace 0000000000000000 ]---


-ritesh

>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+a8e049cd3abd342936b6@syzkaller.appspotmail.com
>
> ------------[ cut here ]------------
> WARNING: CPU: 1 PID: 10 at fs/iomap/iter.c:33 iomap_iter_done fs/iomap/iter.c:33 [inline]
> WARNING: CPU: 1 PID: 10 at fs/iomap/iter.c:33 iomap_iter+0x7ca/0x890 fs/iomap/iter.c:78
> Modules linked in:
> CPU: 1 PID: 10 Comm: kworker/u4:1 Not tainted 5.17.0-rc3-syzkaller-00247-g83e396641110 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> Workqueue: loop0 loop_rootcg_workfn
> RIP: 0010:iomap_iter_done fs/iomap/iter.c:33 [inline]
> RIP: 0010:iomap_iter+0x7ca/0x890 fs/iomap/iter.c:78
> Code: e8 3b 81 83 ff eb 0c e8 34 81 83 ff eb 05 e8 2d 81 83 ff 44 89 e8 48 83 c4 40 5b 41 5c 41 5d 41 5e 41 5f 5d c3 e8 16 81 83 ff <0f> 0b e9 9e fe ff ff e8 0a 81 83 ff 0f 0b e9 d0 fe ff ff e8 fe 80
> RSP: 0018:ffffc90000cf73c8 EFLAGS: 00010293
> RAX: ffffffff82022d4a RBX: ffffffff80000000 RCX: ffff888011fe9d00
> RDX: 0000000000000000 RSI: ffffffff80000000 RDI: 00000fff80000000
> RBP: 00000fff80000000 R08: ffffffff82022be1 R09: ffffed100fd4dc19
> R10: ffffed100fd4dc19 R11: 0000000000000000 R12: ffffc90000cf75c8
> R13: 1ffff9200019eebe R14: 1ffff9200019eeb9 R15: ffffc90000cf75f0
> FS:  0000000000000000(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007fbf80df2b88 CR3: 000000007e8f6000 CR4: 00000000003506e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  __iomap_dio_rw+0xa8e/0x1e00 fs/iomap/direct-io.c:589
>  iomap_dio_rw+0x38/0x80 fs/iomap/direct-io.c:680
>  ext4_dio_read_iter fs/ext4/file.c:77 [inline]
>  ext4_file_read_iter+0x52f/0x6c0 fs/ext4/file.c:128
>  lo_rw_aio+0xc75/0x1060
>  loop_handle_cmd drivers/block/loop.c:1846 [inline]
>  loop_process_work+0x6a4/0x22b0 drivers/block/loop.c:1886
>  process_one_work+0x850/0x1130 kernel/workqueue.c:2307
>  worker_thread+0xab1/0x1300 kernel/workqueue.c:2454
>  kthread+0x2a3/0x2d0 kernel/kthread.c:377
>  ret_from_fork+0x1f/0x30
>  </TASK>
>
