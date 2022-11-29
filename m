Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F173F63C2C7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Nov 2022 15:38:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235709AbiK2OiM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Nov 2022 09:38:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235728AbiK2OiJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Nov 2022 09:38:09 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AB3231342;
        Tue, 29 Nov 2022 06:38:08 -0800 (PST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2ATEZdkl015287;
        Tue, 29 Nov 2022 14:38:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=d9peE2/EBWEH8PtdHYNnfQX3njOsZk0AJOhMJhFRVag=;
 b=h0QmXqLN6i1xxW2gvyxeHtEyyg6hP6CudaPdj6srHShNgkNhzMUpufN3105v95vLr1/O
 3nIaH5vlK+7l/Rnh6dsbdSfz1BynWNJzBr1eIhfD751YtKBv9yKe9PuGufRVtcQ+s/B+
 Af7ZgCnA2VB2hC3T/RBWGg8IQrkMIidVa8+PfuO/PqfHXOhRny9NxG09jERK088GhJv0
 jPlu/QbLi9Z9j8XY+N/liZc5j1/gfEKHSJfIsxtArBUMDBA0an0siYVIVl9MNF5dcB17
 +lScQDNPsxqjVkH7GGY5RYG74LsmqQiSBPz/fbZZzjMkf/9wJZ9Auny/LrJ4LpIfopQQ LA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3m5kysg1kr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Nov 2022 14:38:02 +0000
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2ATEa35d016090;
        Tue, 29 Nov 2022 14:38:02 GMT
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3m5kysg1jw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Nov 2022 14:38:02 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2ATE65XV026568;
        Tue, 29 Nov 2022 14:38:00 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma02fra.de.ibm.com with ESMTP id 3m3ae931v4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Nov 2022 14:38:00 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2ATEVUlX7078546
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Nov 2022 14:31:30 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2C86211C04C;
        Tue, 29 Nov 2022 14:37:58 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 54F3D11C04A;
        Tue, 29 Nov 2022 14:37:54 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.43.21.244])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue, 29 Nov 2022 14:37:54 +0000 (GMT)
Date:   Tue, 29 Nov 2022 20:07:50 +0530
From:   Ojaswin Mujoo <ojaswin@linux.ibm.com>
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org, Ritesh Harjani <riteshh@linux.ibm.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>, rookxu <brookxu.cn@gmail.com>,
        Ritesh Harjani <ritesh.list@gmail.com>
Subject: Re: [PATCH v2 7/8] ext4: Use rbtrees to manage PAs instead of inode
 i_prealloc_list
Message-ID: <Y4YZPreNi7QGPZLK@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
References: <cover.1665776268.git.ojaswin@linux.ibm.com>
 <8421bbe2feb4323f5658757a3232e4c02e20c697.1665776268.git.ojaswin@linux.ibm.com>
 <Y4V3OrSwxA8rZHyy@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y4V3OrSwxA8rZHyy@mit.edu>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: evA6rkDxW5W35BwI6zs2eTn_OKhp5aGv
X-Proofpoint-ORIG-GUID: r52zl2awYXPd4uQyeSBqivxQDJ2QySSk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-29_08,2022-11-29_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 clxscore=1015
 bulkscore=0 phishscore=0 mlxscore=0 lowpriorityscore=0 impostorscore=0
 adultscore=0 malwarescore=0 spamscore=0 suspectscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211290081
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 28, 2022 at 10:06:34PM -0500, Theodore Ts'o wrote:
> This commit (determined via bisecion) seems to be causing a reliable
> failure using the ext4/ext3 configuration when running generic/269:
> 
> % kvm-xfstests -c ext4/ext3 generic/269
>     ...
> BEGIN TEST ext3 (1 test): Ext4 4k block emulating ext3 Mon Nov 28 21:39:35 EST 2022
> DEVICE: /dev/vdd
> EXT_MKFS_OPTIONS: -O ^extents,^flex_bg,^uninit_bg,^64bit,^metadata_csum,^huge_file,^die
> EXT_MOUNT_OPTIONS: -o block_validity,nodelalloc
> FSTYP         -- ext4
> PLATFORM      -- Linux/x86_64 kvm-xfstests 6.1.0-rc4-xfstests-00018-g1c85d4890f15 #8492
> MKFS_OPTIONS  -- -F -q -O ^extents,^flex_bg,^uninit_bg,^64bit,^metadata_csum,^huge_filc
> MOUNT_OPTIONS -- -o acl,user_xattr -o block_validity,nodelalloc /dev/vdc /vdc
> 
> generic/269 23s ...  [21:39:35][    3.085973] run fstests generic/269 at 2022-11-28 215
> [   14.931680] ------------[ cut here ]------------
> [   14.931902] kernel BUG at fs/ext4/mballoc.c:4025!
> [   14.932137] invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
> [   14.932366] CPU: 1 PID: 2677 Comm: fsstress Not tainted 6.1.0-rc4-xfstests-00018-g19
> [   14.932756] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.0-debian-4
> [   14.933169] RIP: 0010:ext4_mb_pa_adjust_overlap.constprop.0+0x18e/0x1c0
> [   14.933457] Code: 66 54 8b 48 54 89 4c 24 04 e8 ae 92 9f 00 41 8b 46 40 85 c0 75 bc4
> [   14.934270] RSP: 0018:ffffc90003aeb868 EFLAGS: 00010283
> [   14.934499] RAX: 0000000000000000 RBX: 00000000000000fc RCX: 0000000000000000
> [   14.934830] RDX: 0000000000000001 RSI: ffffc90003aeb8d4 RDI: 0000000000000001
> [   14.935146] RBP: 0000000000000200 R08: 0000000000008000 R09: 0000000000000001
> [   14.935447] R10: 0000000000000001 R11: 0000000000000001 R12: 0000000000000103
> [   14.935744] R13: 0000000000000101 R14: ffff8880073370e0 R15: ffff888007337118
> [   14.936043] FS:  00007f94eda0b740(0000) GS:ffff88807dd00000(0000) knlGS:000000000000
> [   14.936390] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   14.936634] CR2: 000055ba905a0448 CR3: 000000001092c005 CR4: 0000000000770ee0
> [   14.936932] PKRU: 55555554
> [   14.937048] Call Trace:
> [   14.937190]  <TASK>
> [   14.937285]  ext4_mb_normalize_request.constprop.0+0x1e9/0x440
> [   14.937534]  ext4_mb_new_blocks+0x3a2/0x560
> [   14.937715]  ext4_alloc_branch+0x21e/0x350
> [   14.937892]  ext4_ind_map_blocks+0x322/0x750
> [   14.938076]  ext4_map_blocks+0x380/0x6e0
> [   14.938260]  _ext4_get_block+0xb2/0x120
> [   14.938426]  ext4_block_write_begin+0x13c/0x3d0
> [   14.938624]  ? _ext4_get_block+0x120/0x120
> [   14.938801]  ext4_write_begin+0x1c1/0x570
> [   14.938973]  generic_perform_write+0xcf/0x220
> [   14.939175]  ext4_buffered_write_iter+0x84/0x140
> [   14.939377]  do_iter_readv_writev+0xf0/0x150
> [   14.939562]  do_iter_write+0x80/0x150
> [   14.939722]  vfs_writev+0xed/0x1f0
> [   14.939871]  do_writev+0x73/0x100
> [   14.940016]  do_syscall_64+0x37/0x90
> [   14.940186]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> [   14.940403] RIP: 0033:0x7f94edb02da3
> [   14.940559] Code: 8b 15 f1 90 0c 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b8 0f 1f8
> [   14.941341] RSP: 002b:00007ffc5e82d0d8 EFLAGS: 00000246 ORIG_RAX: 0000000000000014
> [   14.941659] RAX: ffffffffffffffda RBX: 0000000000000036 RCX: 00007f94edb02da3
> [   14.941961] RDX: 0000000000000356 RSI: 000055ba901c1240 RDI: 0000000000000003
> [   14.942290] RBP: 0000000000000003 R08: 000055ba901cf240 R09: 00007f94edbccbe0
> [   14.942596] R10: 0000000000000080 R11: 0000000000000246 R12: 000000000000062a
> [   14.942902] R13: 0000000000000356 R14: 000055ba901c1240 R15: 000000000000b529
> [   14.943219]  </TASK>
> [   14.943326] ---[ end trace 0000000000000000 ]---
> 
> Looking at the stack trace it looks like we're hitting this BUG_ON:
> 
> 		spin_lock(&tmp_pa->pa_lock);
> 		if (tmp_pa->pa_deleted == 0)
> 			BUG_ON(!(start >= tmp_pa_end || end <= tmp_pa_start));
> 		spin_unlock(&tmp_pa->pa_lock);
> 
> ... in the inline function ext4_mb_pa_assert_overlap(), called from
> ext4_mb_pa_adjust_overlap().
> 
> The generic/269 test runs fstress with an ENOSPC hitter as an
> antogonist process.  The ext3 configuration disables delayed
> allocation, which means that fstress is going to be allocating blocks
> at write time (instead of dirty page writeback time).
> 
> Could you take a look?   Thanks!
Hi Ted,

Thanks for pointing this out, I'll have a look into this.

PS: I'm on vacation so might be a bit slow to update on this.

Regards,
Ojaswin
> 
> 						- Ted
