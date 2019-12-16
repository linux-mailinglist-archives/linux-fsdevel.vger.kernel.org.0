Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7FE2312078F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Dec 2019 14:48:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728009AbfLPNsb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Dec 2019 08:48:31 -0500
Received: from mail1.bemta25.messagelabs.com ([195.245.230.71]:55638 "EHLO
        mail1.bemta25.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727579AbfLPNsa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Dec 2019 08:48:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ts.fujitsu.com;
        s=200619tsfj; t=1576504107; i=@ts.fujitsu.com;
        bh=WAoiOLVLnfRZHjvIM34WJoYjoSRik6RjAJThWwiCBpk=;
        h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:
         Content-Transfer-Encoding:Content-Type;
        b=jrCab8U7Sy0MExL0pvFBhIDrmnNm/SzwDfIQCGbMVfPfeMid4sALcf+JkHebFzCjg
         FVF3zVZkgDRSiDC1lUTAA3uD2WnIdAbI8CgZtw40yR3aEJ9AKRbq9M/skSnWEtfwmc
         dwMJIqA2ytR+EGhhO50Bk1/WdpjKYBarDd988fAYOCp5R/+seO4whf+iMiBfxfkhaR
         eVD1aSnj+rt55KMAs41zttgXIOkZ2L1C0W8uDEUnO/fH4YlKi/dIs/JN8rhY4iBC/K
         PhTklxPamdJicn/Xsaa5XnQSDkDv25Tu86/PIe7RdGc7ujggNzoAmp1J0IMqyLxVEO
         sXbDDT6eh02jg==
Received: from [46.226.52.199] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-7.bemta.az-b.eu-west-1.aws.symcld.net id 79/B1-22075-B2B87FD5; Mon, 16 Dec 2019 13:48:27 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrMIsWRWlGSWpSXmKPExsViZ8MRqqvW/T3
  W4O5kbYs9e0+yWFzeNYfNYlLnMTYHZo+WzdEenzfJBTBFsWbmJeVXJLBmTO9fwFLwUK7i2OUF
  rA2MtyW7GLk4hATmMEosu3GBEcKZzyhx9fYZpi5GTg42AQOJXa8OMXcxcnCICChKXH7vBBJmF
  nCUWDvjFwtIWFjARWLXjyyQMIuAqsSVRTeYQWxeAUOJTU+XsULYghInZz5hgWiVl+i43MgKYe
  tILNj9iW0CI/csJGWzkJTNQlK2gJF5FaNFUlFmekZJbmJmjq6hgYGuoaGRrqGlORCb6SVW6Sb
  ppZbqlqcWl+ga6iWWF+sVV+Ym56To5aWWbGIEhldKwdEjOxjffX2rd4hRkoNJSZQ35Oa3WCG+
  pPyUyozE4oz4otKc1OJDjDIcHEoSvGvav8cKCRalpqdWpGXmAEMdJi3BwaMkwhvTCZTmLS5Iz
  C3OTIdInWLU5Vj1f94iZiGWvPy8VClxXs4uoCIBkKKM0jy4EbC4u8QoKyXMy8jAwCDEU5BalJ
  tZgir/ilGcg1FJmLcIZBVPZl4J3KZXQEcwAR1h5PcN5IiSRISUVAOTQTHXDB7GsPyYHYWf7Py
  Xb2Dtjqy7crJC7NCc/P1pO4rDthXM5fXI56rbqKcl9lrhRQvXh6Ky/62N3658r5suech/po+K
  1yfbMzLVTHPn5z+z3P+XezWL/fy/+ZWhn/onLt4o1L/YYO3dNEOjL4dXffm+0+xKas96xWc8f
  Unn5CerObY03buW0GwasvbIM8Yd7gd2aiU2pn+a1bIok9txQQHr9m2qvvFf1fLzp7KxlGS/vP
  Fv4hMzveidDFIHlfczLprIuqpjxdOQqc98//36oRHta6oj7DZfz6CJY+/LqTmFEep2b9b+va9
  xYrFOzd3bX5ML71bP/BJ7sbfkzWVHu81arzoiHt1k/fCsudxAiaU4I9FQi7moOBEAyksHKDYD
  AAA=
X-Env-Sender: dietmar.hahn@ts.fujitsu.com
X-Msg-Ref: server-5.tower-287.messagelabs.com!1576504102!563365!1
X-Originating-IP: [62.60.8.85]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.44.22; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 31400 invoked from network); 16 Dec 2019 13:48:22 -0000
Received: from unknown (HELO mailhost4.uk.fujitsu.com) (62.60.8.85)
  by server-5.tower-287.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 16 Dec 2019 13:48:22 -0000
Received: from sanpedro.mch.fsc.net ([172.17.20.6])
        by mailhost4.uk.fujitsu.com (8.14.5/8.14.5) with SMTP id xBGDmGSC018441;
        Mon, 16 Dec 2019 13:48:16 GMT
Received: from amur.mch.fsc.net (unknown [10.172.102.15])
        by sanpedro.mch.fsc.net (Postfix) with ESMTP id D9A7A9D00C7C;
        Mon, 16 Dec 2019 14:48:07 +0100 (CET)
From:   Dietmar Hahn <dietmar.hahn@ts.fujitsu.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Al Viro <viro@ftp.linux.org.uk>
Subject: [PATCH] Fix a panic when core_pattern is set to "| prog..."
Date:   Mon, 16 Dec 2019 14:48:07 +0100
Message-ID: <2996767.y7E8ffpIOs@amur.mch.fsc.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

if the /proc/sys/kernel/core_pattern is set with a space between '|' and the
program and later a core file should be written the kernel panics.
This happens because in format_corename() the first part of cn.corename
is set to '\0' and later call_usermodehelper_exec() exits because of an
empty command path but with return 0. But no pipe is created and thus
cprm.file == NULL.
This leads in file_start_write() to the panic because of dereferencing
file_inode(file)->i_mode.

Thanks,
Dietmar.

[  432.431005] BUG: kernel NULL pointer dereference, address: 0000000000000020
[  432.431006] #PF: supervisor read access in kernel mode
[  432.431006] #PF: error_code(0x0000) - not-present page
[  432.431007] PGD 102ad73067 P4D 102ad73067 PUD 105b898067 PMD 0 
[  432.431010] Oops: 0000 [#1] SMP NOPTI
[  432.431012] CPU: 0 PID: 20114 Comm: a Kdump: loaded Tainted: G            E     5.5.0-rc2-10.g62d06a0-default+ #15
[  432.431013] Hardware name: FUJITSU SE SERVER SU310 M1/D3753-C1, BIOS V5.0.0.14 R1.12.0 for D3753-C1x                    07/22/2019
[  432.431020] RIP: 0010:do_coredump+0x7b8/0x1128
[  432.431021] Code: 00 48 8b bd 18 ff ff ff 48 85 ff 74 05 e8 60 04 fa ff 65 48 8b 04 25 c0 ab 01 00 48 8b 00 48 8b 4d a0 a8 04 0f 85 16 01 00 00 <48> 8b 51 20 0f b7 02 66 25 00 f0 66 3d 00 80 75 13 48 8b 7a 28 be
[  432.431022] RSP: 0018:ffffab39081dfcc0 EFLAGS: 00010246
[  432.431023] RAX: 0000000000004008 RBX: ffff8e77df3e6e80 RCX: 0000000000000000
[  432.431024] RDX: 0000000000000000 RSI: ffffab39081dfc90 RDI: 0000000000000000
[  432.431024] RBP: ffffab39081dfdf8 R08: 0000000000000000 R09: ffffab39081dfc18
[  432.431025] R10: ffff8e6fd9020000 R11: 0000000000000000 R12: ffff8e6fb16eb080
[  432.431026] R13: 0000000000000000 R14: ffffffff8f878400 R15: ffffffff8ff21860
[  432.431027] FS:  00007f8ad3468700(0000) GS:ffff8e6fdfe00000(0000) knlGS:0000000000000000
[  432.431027] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  432.431028] CR2: 0000000000000020 CR3: 000000105ef26002 CR4: 00000000007606f0
[  432.431028] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  432.431029] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  432.431029] PKRU: 55555554
[  432.431030] Call Trace:
[  432.431040]  get_signal+0x13c/0x860
[  432.431046]  ? __switch_to_asm+0x34/0x70
[  432.431047]  ? __switch_to_asm+0x40/0x70
[  432.431048]  ? __switch_to_asm+0x34/0x70
[  432.431055]  do_signal+0x36/0x630
[  432.431065]  ? finish_task_switch+0x7c/0x2a0
[  433.237753]  exit_to_usermode_loop+0x95/0x130
[  433.237755]  prepare_exit_to_usermode+0xa7/0xf0
[  433.237758]  ret_from_intr+0x2a/0x3a
[  433.237761] RIP: 0033:0x7f8ad2f05381
[  433.237763] Code: 4c 8b 85 28 fb ff ff 44 29 e8 48 98 49 39 c1 0f 87 a2 f7 ff ff 44 03 ad 20 fb ff ff e9 02 ec ff ff 31 c0 48 83 c9 ff 4c 89 d7 <f2> ae c7 85 28 fb ff ff 00 00 00 00 48 89 ce 48 f7 d6 4c 8d 4e ff
[  433.237763] RSP: 002b:00007fff72daa6a0 EFLAGS: 00010286
[  433.237764] RAX: 0000000000000000 RBX: 00007f8ad325b2a0 RCX: ffffffffffffffff
[  433.237765] RDX: 0000000000000010 RSI: 00007fff72daabf8 RDI: 0000000000000001
[  433.237765] RBP: 00007fff72daac30 R08: 00000000004005fa R09: 0000000000000073
[  433.237766] R10: 0000000000000001 R11: 0000000000000000 R12: 00000000004005f4
[  433.237766] R13: 0000000000000006 R14: 0000000000000000 R15: 00007fff72daac48


Signed-off-by: Dietmar Hahn <dietmar.hahn@ts.fujitsu.com>

---
 fs/coredump.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/coredump.c b/fs/coredump.c
index b1ea7dfbd149..106c1c5f542a 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -628,7 +628,7 @@ void do_coredump(const kernel_siginfo_t *siginfo)
 		char **helper_argv;
 		struct subprocess_info *sub_info;
 
-		if (ispipe < 0) {
+		if (ispipe < 0 || !*cn.corename) {
 			printk(KERN_WARNING "format_corename failed\n");
 			printk(KERN_WARNING "Aborting core\n");
 			goto fail_unlock;
-- 
2.16.4




