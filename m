Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DA773B9DBD
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Jul 2021 10:51:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231153AbhGBIyA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Jul 2021 04:54:00 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38084 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230442AbhGBIyA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Jul 2021 04:54:00 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1628a4VU187202;
        Fri, 2 Jul 2021 04:51:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : content-type :
 content-transfer-encoding : mime-version : subject : message-id : date :
 cc : to; s=pp1; bh=4esvLlITfkW82/6YPDi50d0cKwCi0cdl2wCRc7W8wdE=;
 b=USnGOpu9H0gEH+d3tP0OlE1ptjD9pYHQQMA+pwCJu9HIJGe4/N471cW2sISLqSXWl9DP
 CM+5RpE8RbGQWvoTTd3dcXga3V2hh4gZMS4OyVnbWJWHlv/Eg2cMv1/LKIa9BMCAAuzz
 3LP3bmrIihqk1ywq9kH/KpiwQWnYBbOmyHQSFXqD5sq+cXulfiEBjCIlpzVZg4IXF0B3
 DTLLAFAOsjCVWsCbOTQav/Z96v7zepI1YccxkAtluXmBE1vXvYObgJkukhnpO/axqSkl
 cRFTpOjvN7jWND6yNlQA/MPLT+iKYJ1PguDW022jOUBBhEVBZ2GZGT9QbghjovkxvZ4j oA== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39hwbkkkam-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 02 Jul 2021 04:51:13 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1628lqq3014377;
        Fri, 2 Jul 2021 08:51:11 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma06ams.nl.ibm.com with ESMTP id 39h19bgs7m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 02 Jul 2021 08:51:11 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1628nTj116187768
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 2 Jul 2021 08:49:29 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 52E7E11C04A;
        Fri,  2 Jul 2021 08:51:09 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6261111C058;
        Fri,  2 Jul 2021 08:51:08 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.85.118.157])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  2 Jul 2021 08:51:08 +0000 (GMT)
From:   Sachin Sant <sachinp@linux.vnet.ibm.com>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.100.0.2.22\))
Subject: [powerpc][5.13.0-next-20210701] Kernel crash while running
 ltp(chdir01) tests
Message-Id: <26ACA75D-E13D-405B-9BFC-691B5FB64243@linux.vnet.ibm.com>
Date:   Fri, 2 Jul 2021 14:21:07 +0530
Cc:     linuxppc-dev@lists.ozlabs.org, yi.zhang@huawei.com, jack@suse.cz
To:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
X-Mailer: Apple Mail (2.3654.100.0.2.22)
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: jwwUx9Bm7fGDswCacIgLb5eMYpYV39sC
X-Proofpoint-ORIG-GUID: jwwUx9Bm7fGDswCacIgLb5eMYpYV39sC
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-02_01:2021-07-01,2021-07-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 clxscore=1011 priorityscore=1501 malwarescore=0
 adultscore=0 lowpriorityscore=0 spamscore=0 mlxscore=0 bulkscore=0
 phishscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2104190000 definitions=main-2107020048
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

While running LTP tests (chdir01) against 5.13.0-next20210701 booted on =
a Power server,
following crash is encountered.

[ 3051.182992] ext2 filesystem being mounted at =
/var/tmp/avocado_oau90dri/ltp-W0cFB5HtCy/lKhal5/mntpoint supports =
timestamps until 2038 (0x7fffffff)
[ 3051.621341] EXT4-fs (loop0): mounting ext3 file system using the ext4 =
subsystem
[ 3051.624645] EXT4-fs (loop0): mounted filesystem with ordered data =
mode. Opts: (null). Quota mode: none.
[ 3051.624682] ext3 filesystem being mounted at =
/var/tmp/avocado_oau90dri/ltp-W0cFB5HtCy/lKhal5/mntpoint supports =
timestamps until 2038 (0x7fffffff)
[ 3051.629026] Kernel attempted to read user page (13fda70000) - exploit =
attempt? (uid: 0)
[ 3051.629074] BUG: Unable to handle kernel data access on read at =
0x13fda70000
[ 3051.629103] Faulting instruction address: 0xc0000000006fa5cc
[ 3051.629118] Oops: Kernel access of bad area, sig: 11 [#1]
[ 3051.629130] LE PAGE_SIZE=3D64K MMU=3DRadix SMP NR_CPUS=3D2048 NUMA =
pSeries
[ 3051.629148] Modules linked in: vfat fat btrfs blake2b_generic xor =
zstd_compress raid6_pq xfs loop sctp ip6_udp_tunnel udp_tunnel libcrc32c =
rpadlpar_io rpaphp dm_mod bonding rfkill sunrpc pseries_rng xts =
vmx_crypto uio_pdrv_genirq uio sch_fq_codel ip_tables ext4 mbcache jbd2 =
sd_mod t10_pi sg ibmvscsi ibmveth scsi_transport_srp fuse [last =
unloaded: test_cpuidle_latency]
[ 3051.629270] CPU: 10 PID: 274044 Comm: chdir01 Tainted: G        W  OE =
    5.13.0-next-20210701 #1
[ 3051.629289] NIP:  c0000000006fa5cc LR: c008000006949bc4 CTR: =
c0000000006fa5a0
[ 3051.629300] REGS: c000000f74de3660 TRAP: 0300   Tainted: G        W  =
OE      (5.13.0-next-20210701)
[ 3051.629314] MSR:  800000000280b033 <SF,VEC,VSX,EE,FP,ME,IR,DR,RI,LE>  =
CR: 24000288  XER: 20040000
[ 3051.629342] CFAR: c008000006957564 DAR: 00000013fda70000 DSISR: =
40000000 IRQMASK: 0=20
[ 3051.629342] GPR00: c008000006949bc4 c000000f74de3900 c0000000029bc800 =
c000000f88f0ab80=20
[ 3051.629342] GPR04: ffffffffffffffff 0000000000000020 0000000024000282 =
0000000000000000=20
[ 3051.629342] GPR08: c00000110628c828 0000000000000000 00000013fda70000 =
c008000006957550=20
[ 3051.629342] GPR12: c0000000006fa5a0 c0000013ffffbe80 0000000000000000 =
0000000000000000=20
[ 3051.629342] GPR16: 0000000000000000 0000000000000000 00000000100555f8 =
0000000010050d40=20
[ 3051.629342] GPR20: 0000000000000000 0000000010026188 0000000010026160 =
c000000f88f0ac08=20
[ 3051.629342] GPR24: 0000000000000000 c000000f88f0a920 0000000000000000 =
0000000000000002=20
[ 3051.629342] GPR28: c000000f88f0ac50 c000000f88f0a800 c000000fc5577d00 =
c000000f88f0ab80=20
[ 3051.629468] NIP [c0000000006fa5cc] percpu_counter_add_batch+0x2c/0xf0
[ 3051.629493] LR [c008000006949bc4] =
__jbd2_journal_remove_checkpoint+0x9c/0x280 [jbd2]
[ 3051.629526] Call Trace:
[ 3051.629532] [c000000f74de3900] [c000000f88f0a84c] 0xc000000f88f0a84c =
(unreliable)
[ 3051.629547] [c000000f74de3940] [c008000006949bc4] =
__jbd2_journal_remove_checkpoint+0x9c/0x280 [jbd2]
[ 3051.629577] [c000000f74de3980] [c008000006949eb4] =
jbd2_log_do_checkpoint+0x10c/0x630 [jbd2]
[ 3051.629605] [c000000f74de3a40] [c0080000069547dc] =
jbd2_journal_destroy+0x1b4/0x4e0 [jbd2]
[ 3051.629636] [c000000f74de3ad0] [c00800000735d72c] =
ext4_put_super+0xb4/0x560 [ext4]
[ 3051.629703] [c000000f74de3b60] [c000000000484d64] =
generic_shutdown_super+0xc4/0x1d0
[ 3051.629720] [c000000f74de3bd0] [c000000000484f48] =
kill_block_super+0x38/0x90
[ 3051.629736] [c000000f74de3c00] [c000000000485120] =
deactivate_locked_super+0x80/0x100
[ 3051.629752] [c000000f74de3c30] [c0000000004bec1c] =
cleanup_mnt+0x10c/0x1d0
[ 3051.629767] [c000000f74de3c80] [c000000000188b08] =
task_work_run+0xf8/0x170
[ 3051.629783] [c000000f74de3cd0] [c000000000021a24] =
do_notify_resume+0x434/0x480
[ 3051.629800] [c000000f74de3d80] [c000000000032910] =
interrupt_exit_user_prepare_main+0x1a0/0x260
[ 3051.629816] [c000000f74de3de0] [c000000000032d08] =
syscall_exit_prepare+0x68/0x150
[ 3051.629830] [c000000f74de3e10] [c00000000000c770] =
system_call_common+0x100/0x258
[ 3051.629846] --- interrupt: c00 at 0x7fffa2b92ffc
[ 3051.629855] NIP:  00007fffa2b92ffc LR: 00007fffa2b92fcc CTR: =
0000000000000000
[ 3051.629867] REGS: c000000f74de3e80 TRAP: 0c00   Tainted: G        W  =
OE      (5.13.0-next-20210701)
[ 3051.629880] MSR:  800000000280f033 =
<SF,VEC,VSX,EE,PR,FP,ME,IR,DR,RI,LE>  CR: 24000474  XER: 00000000
[ 3051.629908] IRQMASK: 0=20
[ 3051.629908] GPR00: 0000000000000034 00007fffc0242e20 00007fffa2c77100 =
0000000000000000=20
[ 3051.629908] GPR04: 0000000000000000 0000000000000078 0000000000000000 =
0000000000000020=20
[ 3051.629908] GPR08: 0000000000000000 0000000000000000 0000000000000000 =
0000000000000000=20
[ 3051.629908] GPR12: 0000000000000000 00007fffa2d1a310 0000000000000000 =
0000000000000000=20
[ 3051.629908] GPR16: 0000000000000000 0000000000000000 00000000100555f8 =
0000000010050d40=20
[ 3051.629908] GPR20: 0000000000000000 0000000010026188 0000000010026160 =
00000000100288f0=20
[ 3051.629908] GPR24: 00007fffa2d13320 00000000000186a0 0000000010025dd8 =
0000000010055688=20
[ 3051.629908] GPR28: 0000000010024bb8 0000000000000001 0000000000000001 =
0000000000000000=20
[ 3051.630022] NIP [00007fffa2b92ffc] 0x7fffa2b92ffc
[ 3051.630032] LR [00007fffa2b92fcc] 0x7fffa2b92fcc
[ 3051.630041] --- interrupt: c00
[ 3051.630048] Instruction dump:
[ 3051.630057] 60000000 3c4c022c 38422260 7c0802a6 fbe1fff8 fba1ffe8 =
7c7f1b78 fbc1fff0=20
[ 3051.630078] f8010010 f821ffc1 e94d0030 e9230020 <7fca4aaa> 7fbe2214 =
7fa9fe76 7d2aea78=20
[ 3051.630102] ---[ end trace 83afe3a19212c333 ]---
[ 3051.633656]=20
[ 3052.633681] Kernel panic - not syncing: Fatal exception

5.13.0-next-20210630 was good. Bisect points to following patch:

commit 4ba3fcdde7e3
         jbd2,ext4: add a shrinker to release checkpointed buffers

Reverting this patch allows the test to run successfully.

Thanks
-Sachin

