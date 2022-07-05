Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86E44566F40
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Jul 2022 15:33:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232410AbiGENdE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Jul 2022 09:33:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231756AbiGENcv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Jul 2022 09:32:51 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CB03275F9;
        Tue,  5 Jul 2022 05:54:08 -0700 (PDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 265CoTv1023375;
        Tue, 5 Jul 2022 12:53:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=hUl/45bmqvm0Ie1IQicTG8z/SbeXpBZq0vmQsUW5zB0=;
 b=bOg8Oc6XhVv/RcXXuI+/FrpnUwbHmgi3Mt4ojFrKOMLOvfdd6Xu/VIrmw49GuNjGAnAy
 ApweODpIin4fauASYzfw94hZpnxGhq7A2pdcPF6ZIaijycpVRnIEaqoxEgvP2d+rIpVC
 smCNoULebPPAfTLhxPPzAtfqtSn7Kc29/rjd1EZfOArU9apWVFXdjgawwB5oGfg9sQAE
 Hkvwmke8wx91AgZTKSt36p+lLuf4JO+h2/c3WX2YGB7HtVn2SaUGR80j1LuytGx0EBdn
 phfLwPktCLNBOP68kwbw1dTsuhhb9I156uMUb/NsKMJJbLz5YbmWoJ1n1xy/wfCAzpXL Aw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3h4nngr26e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Jul 2022 12:53:24 +0000
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 265Cot5W023991;
        Tue, 5 Jul 2022 12:53:24 GMT
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3h4nngr25d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Jul 2022 12:53:24 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 265Cph3v010179;
        Tue, 5 Jul 2022 12:53:22 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma05fra.de.ibm.com with ESMTP id 3h2dn8k0re-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Jul 2022 12:53:21 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 265CrJqV16384326
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 5 Jul 2022 12:53:19 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 78ACB11C054;
        Tue,  5 Jul 2022 12:53:19 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3A3C711C04A;
        Tue,  5 Jul 2022 12:53:17 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.211.104.119])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  5 Jul 2022 12:53:16 +0000 (GMT)
Message-ID: <c75858662b90592ae3f3ab57d4500381a28bafe5.camel@linux.ibm.com>
Subject: Re: [syzbot] possible deadlock in mnt_want_write (2)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     syzbot <syzbot+b42fe626038981fb7bfa@syzkalhler.appspotmail.com>,
        hdanton@sina.com, linux-fsdevel@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        miklos@szeredi.hu, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
Cc:     Hillf Danton <hdanton@sina.com>
Date:   Tue, 05 Jul 2022 08:53:15 -0400
In-Reply-To: <000000000000466f0d05e2d5d1d1@google.com>
References: <000000000000466f0d05e2d5d1d1@google.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ZnzO-zP-yCiMzt_lUwebWiGe-VAoLaAU
X-Proofpoint-GUID: xNSeOJtXL61rT7g0zfNHlE9gb83-5xEN
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-05_10,2022-06-28_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 mlxlogscore=999 mlxscore=0 phishscore=0 clxscore=1011
 priorityscore=1501 suspectscore=0 bulkscore=0 lowpriorityscore=0
 adultscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2207050054
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Thank you for the reproducer.  This seems to be a similar false
positive as was discussed:
https://lore.kernel.org/linux-unionfs/000000000000c5b77105b4c3546e@google.com/

thanks,

Mimi

On Sat, 2022-07-02 at 10:27 -0700, syzbot wrote:
> syzbot has found a reproducer for the following issue on:
> 
> HEAD commit:    089866061428 Merge tag 'libnvdimm-fixes-5.19-rc5' of git:/..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=11dd91f0080000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=75c9ff14e1db87c0
> dashboard link: https://syzkaller.appspot.com/bug?extid=b42fe626038981fb7bfa
> compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=167bafc0080000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11aad3e0080000
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+b42fe626038981fb7bfa@syzkaller.appspotmail.com
> 
> ======================================================
> WARNING: possible circular locking dependency detected
> 5.19.0-rc4-syzkaller-00187-g089866061428 #0 Not tainted
> ------------------------------------------------------
> syz-executor450/3829 is trying to acquire lock:
> ffff88807e574460 (sb_writers#4){.+.+}-{0:0}, at: mnt_want_write+0x3b/0x80 fs/namespace.c:393
> 
> but task is already holding lock:
> ffff888074de91a0 (&iint->mutex){+.+.}-{3:3}, at: process_measurement+0x7d2/0x1c10 security/integrity/ima/ima_main.c:260
> 
> which lock already depends on the new lock.
> 
> 
> the existing dependency chain (in reverse order) is:
> 
> -> #1 (&iint->mutex){+.+.}-{3:3}:
>        lock_acquire+0x1a7/0x400 kernel/locking/lockdep.c:5665
>        __mutex_lock_common+0x1de/0x26c0 kernel/locking/mutex.c:603
>        __mutex_lock kernel/locking/mutex.c:747 [inline]
>        mutex_lock_nested+0x17/0x20 kernel/locking/mutex.c:799
>        process_measurement+0x7d2/0x1c10 security/integrity/ima/ima_main.c:260
>        ima_file_check+0xe7/0x160 security/integrity/ima/ima_main.c:517
>        do_open fs/namei.c:3522 [inline]
>        path_openat+0x2705/0x2ec0 fs/namei.c:3653
>        do_filp_open+0x277/0x4f0 fs/namei.c:3680
>        do_sys_openat2+0x13b/0x500 fs/open.c:1278
>        do_sys_open fs/open.c:1294 [inline]
>        __do_sys_open fs/open.c:1302 [inline]
>        __se_sys_open fs/open.c:1298 [inline]
>        __x64_sys_open+0x221/0x270 fs/open.c:1298
>        do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>        do_syscall_64+0x2b/0x70 arch/x86/entry/common.c:80
>        entry_SYSCALL_64_after_hwframe+0x46/0xb0
> 
> -> #0 (sb_writers#4){.+.+}-{0:0}:
>        check_prev_add kernel/locking/lockdep.c:3095 [inline]
>        check_prevs_add kernel/locking/lockdep.c:3214 [inline]
>        validate_chain+0x185c/0x65c0 kernel/locking/lockdep.c:3829
>        __lock_acquire+0x129a/0x1f80 kernel/locking/lockdep.c:5053
>        lock_acquire+0x1a7/0x400 kernel/locking/lockdep.c:5665
>        percpu_down_read include/linux/percpu-rwsem.h:51 [inline]
>        __sb_start_write include/linux/fs.h:1699 [inline]
>        sb_start_write+0x4d/0x1a0 include/linux/fs.h:1774
>        mnt_want_write+0x3b/0x80 fs/namespace.c:393
>        ovl_maybe_copy_up+0x124/0x190 fs/overlayfs/copy_up.c:1078
>        ovl_open+0x106/0x2a0 fs/overlayfs/file.c:152
>        do_dentry_open+0x789/0x1040 fs/open.c:848
>        vfs_open fs/open.c:981 [inline]
>        dentry_open+0xc1/0x120 fs/open.c:997
>        ima_calc_file_hash+0x157/0x1cb0 security/integrity/ima/ima_crypto.c:557
>        ima_collect_measurement+0x3de/0x850 security/integrity/ima/ima_api.c:292
>        process_measurement+0xf87/0x1c10 security/integrity/ima/ima_main.c:337
>        ima_file_check+0xe7/0x160 security/integrity/ima/ima_main.c:517
>        do_open fs/namei.c:3522 [inline]
>        path_openat+0x2705/0x2ec0 fs/namei.c:3653
>        do_filp_open+0x277/0x4f0 fs/namei.c:3680
>        do_sys_openat2+0x13b/0x500 fs/open.c:1278
>        do_sys_open fs/open.c:1294 [inline]
>        __do_sys_open fs/open.c:1302 [inline]
>        __se_sys_open fs/open.c:1298 [inline]
>        __x64_sys_open+0x221/0x270 fs/open.c:1298
>        do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>        do_syscall_64+0x2b/0x70 arch/x86/entry/common.c:80
>        entry_SYSCALL_64_after_hwframe+0x46/0xb0
> 
> other info that might help us debug this:
> 
>  Possible unsafe locking scenario:
> 
>        CPU0                    CPU1
>        ----                    ----
>   lock(&iint->mutex);
>                                lock(sb_writers#4);
>                                lock(&iint->mutex);
>   lock(sb_writers#4);
> 
>  *** DEADLOCK ***
> 
> 1 lock held by syz-executor450/3829:
>  #0: ffff888074de91a0 (&iint->mutex){+.+.}-{3:3}, at: process_measurement+0x7d2/0x1c10 security/integrity/ima/ima_main.c:260
> 
> stack backtrace:
> CPU: 1 PID: 3829 Comm: syz-executor450 Not tainted 5.19.0-rc4-syzkaller-00187-g089866061428 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/29/2022
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0x1e3/0x2cb lib/dump_stack.c:106
>  check_noncircular+0x2f7/0x3b0 kernel/locking/lockdep.c:2175
>  check_prev_add kernel/locking/lockdep.c:3095 [inline]
>  check_prevs_add kernel/locking/lockdep.c:3214 [inline]
>  validate_chain+0x185c/0x65c0 kernel/locking/lockdep.c:3829
>  __lock_acquire+0x129a/0x1f80 kernel/locking/lockdep.c:5053
>  lock_acquire+0x1a7/0x400 kernel/locking/lockdep.c:5665
>  percpu_down_read include/linux/percpu-rwsem.h:51 [inline]
>  __sb_start_write include/linux/fs.h:1699 [inline]
>  sb_start_write+0x4d/0x1a0 include/linux/fs.h:1774
>  mnt_want_write+0x3b/0x80 fs/namespace.c:393
>  ovl_maybe_copy_up+0x124/0x190 fs/overlayfs/copy_up.c:1078
>  ovl_open+0x106/0x2a0 fs/overlayfs/file.c:152
>  do_dentry_open+0x789/0x1040 fs/open.c:848
>  vfs_open fs/open.c:981 [inline]
>  dentry_open+0xc1/0x120 fs/open.c:997
>  ima_calc_file_hash+0x157/0x1cb0 security/integrity/ima/ima_crypto.c:557
>  ima_collect_measurement+0x3de/0x850 security/integrity/ima/ima_api.c:292
>  process_measurement+0xf87/0x1c10 security/integrity/ima/ima_main.c:337
>  ima_file_check+0xe7/0x160 security/integrity/ima/ima_main.c:517
>  do_open fs/namei.c:3522 [inline]
>  path_openat+0x2705/0x2ec0 fs/namei.c:3653
>  do_filp_open+0x277/0x4f0 fs/namei.c:3680
>  do_sys_openat2+0x13b/0x500 fs/open.c:1278
>  do_sys_open fs/open.c:1294 [inline]
>  __do_sys_open fs/open.c:1302 [inline]
>  __se_sys_open fs/open.c:1298 [inline]
>  __x64_sys_open+0x221/0x270 fs/open.c:1298
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x2b/0x70 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x46/0xb0
> RIP: 0033:0x7faf98402749
> Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 31 16 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007faf9838e2f8 EFLAGS: 00000246 ORIG_RAX: 0000000000000002
> RAX: ffffffffffffffda RBX: 00007faf98491270 RCX: 00007faf98402749
> RDX: 0000000000000000 RSI: 000000000000000b RDI: 00000000200000c0
> RBP: 00007faf98458504 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0030656c69662f2e
> R13: 3d7269647265776f R14: 0079616c7265766f R15: 00007faf98491278
>  </TASK>
> 


