Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AC1D7A961C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Sep 2023 19:00:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbjIUQ7B (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Sep 2023 12:59:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbjIUQ66 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Sep 2023 12:58:58 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 330C31BF3;
        Thu, 21 Sep 2023 09:58:16 -0700 (PDT)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38LE9mE2018510;
        Thu, 21 Sep 2023 14:29:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=Yy0yI59Efpe7RLEINYlKUWUJs23Yzz8vjzqIGYBM3HQ=;
 b=TStihSFQtA0J5Gy5oFSqiQxttN3qtdeCef4NJeG4F05rzlt6EiDFa7SVx+VMer40rQRX
 IhKhMe7KqSwfgaKmQEoC9AYH/GM/NDkLMw3ISraf90Qw2XEUxEcM72NGNDMJJXOoG6P2
 mtqY8VPK1wKpAj853mkc4plTwf/JuBffI7Ja8d/yEkkCA8mCFTKT3CzJHlxyftqPNMem
 bXzH3tIrs2P4/oj/NR5pbU4bHdjCbXGTLJyCk9pHph8MCToaRRQevrDWw7/P87j2+rQW
 epCFM/JNw5HCfUFqWjX849vzWo2g2EvoxZNj+0uC2O3Fg1qh4NLPsZ/6H0nLzprtvk4a RQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t82gj8hr5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Sep 2023 14:29:08 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38LESpYW015677;
        Thu, 21 Sep 2023 14:29:08 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t82gj8hqq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Sep 2023 14:29:08 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 38LDn7ku005855;
        Thu, 21 Sep 2023 14:29:07 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
        by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3t5q30bqk8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Sep 2023 14:29:07 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
        by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 38LET6mC7865038
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Sep 2023 14:29:06 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 78AE35805A;
        Thu, 21 Sep 2023 14:29:06 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BAE8158060;
        Thu, 21 Sep 2023 14:29:05 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTPS;
        Thu, 21 Sep 2023 14:29:05 +0000 (GMT)
Message-ID: <9bee07bd-5e72-0a82-c106-f9718f7942a8@linux.ibm.com>
Date:   Thu, 21 Sep 2023 10:29:05 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [syzbot] [integrity] [overlayfs] general protection fault in
 d_path
Content-Language: en-US
To:     Christian Brauner <brauner@kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>
Cc:     Jeff Layton <jlayton@kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        syzbot <syzbot+a67fc5321ffb4b311c98@syzkaller.appspotmail.com>,
        amir73il@gmail.com, linux-fsdevel@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-unionfs@vger.kernel.org, miklos@szeredi.hu,
        syzkaller-bugs@googlegroups.com
References: <000000000000259bd8060596e33f@google.com>
 <bed99e92-cb7c-868d-94f3-ddf53e2b262a@linux.ibm.com>
 <8a65f5eb-2b59-9903-c6b8-84971f8765ae@linux.ibm.com>
 <ab7df5e93b5493de5fa379ccab48859fe953d7ae.camel@kernel.org>
 <b16550ac-f589-c5d7-e139-d585e8771cfd@linux.ibm.com>
 <00dbd1e7-dfc8-86bc-536f-264a929ebb35@linux.ibm.com>
 <94b4686a-fee8-c545-2692-b25285b9a152@schaufler-ca.com>
 <d59d40426c388789c195d94e7e72048ef45fec5e.camel@kernel.org>
 <7caa3aa06cc2d7f8d075306b92b259dab3e9bc21.camel@linux.ibm.com>
 <20230921-gedanken-salzwasser-40d25b921162@brauner>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20230921-gedanken-salzwasser-40d25b921162@brauner>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: x9fu11qZJ74bkFfV-IjCW2a5r86jhO24
X-Proofpoint-ORIG-GUID: hAmx6y10V9_jFbcMStpmF5fGnxCAkw8A
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-21_12,2023-09-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 suspectscore=0 impostorscore=0 priorityscore=1501 mlxscore=0 clxscore=1015
 spamscore=0 bulkscore=0 adultscore=0 malwarescore=0 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309210122
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 9/21/23 07:48, Christian Brauner wrote:
> On Thu, Sep 21, 2023 at 07:24:23AM -0400, Mimi Zohar wrote:
>> On Thu, 2023-09-21 at 06:32 -0400, Jeff Layton wrote:
>>> On Wed, 2023-09-20 at 17:52 -0700, Casey Schaufler wrote:
>>>> On 9/20/2023 5:10 PM, Stefan Berger wrote:
>>>>> On 9/20/23 18:09, Stefan Berger wrote:
>>>>>> On 9/20/23 17:16, Jeff Layton wrote:
>>>>>>> On Wed, 2023-09-20 at 16:37 -0400, Stefan Berger wrote:
>>>>>>>> On 9/20/23 13:01, Stefan Berger wrote:
>>>>>>>>> On 9/17/23 20:04, syzbot wrote:
>>>>>>>>>> syzbot has bisected this issue to:
>>>>>>>>>>
>>>>>>>>>> commit db1d1e8b9867aae5c3e61ad7859abfcc4a6fd6c7
>>>>>>>>>> Author: Jeff Layton <jlayton@kernel.org>
>>>>>>>>>> Date:   Mon Apr 17 16:55:51 2023 +0000
>>>>>>>>>>
>>>>>>>>>>        IMA: use vfs_getattr_nosec to get the i_version
>>>>>>>>>>
>>>>>>>>>> bisection log:
>>>>>>>>>> https://syzkaller.appspot.com/x/bisect.txt?x=106f7e54680000
>>>>>>>>>> start commit:   a747acc0b752 Merge tag
>>>>>>>>>> 'linux-kselftest-next-6.6-rc2'
>>>>>>>>>> of g..
>>>>>>>>>> git tree:       upstream
>>>>>>>>>> final oops:
>>>>>>>>>> https://syzkaller.appspot.com/x/report.txt?x=126f7e54680000
>>>>>>>>>> console output:
>>>>>>>>>> https://syzkaller.appspot.com/x/log.txt?x=146f7e54680000
>>>>>>>>>> kernel config:
>>>>>>>>>> https://syzkaller.appspot.com/x/.config?x=df91a3034fe3f122
>>>>>>>>>> dashboard link:
>>>>>>>>>> https://syzkaller.appspot.com/bug?extid=a67fc5321ffb4b311c98
>>>>>>>>>> syz repro:
>>>>>>>>>> https://syzkaller.appspot.com/x/repro.syz?x=1671b694680000
>>>>>>>>>> C reproducer:
>>>>>>>>>> https://syzkaller.appspot.com/x/repro.c?x=14ec94d8680000
>>>>>>>>>>
>>>>>>>>>> Reported-by: syzbot+a67fc5321ffb4b311c98@syzkaller.appspotmail.com
>>>>>>>>>> Fixes: db1d1e8b9867 ("IMA: use vfs_getattr_nosec to get the
>>>>>>>>>> i_version")
>>>>>>>>>>
>>>>>>>>>> For information about bisection process see:
>>>>>>>>>> https://goo.gl/tpsmEJ#bisection
>>>>>>>>> The final oops shows this here:
>>>>>>>>>
>>>>>>>>> BUG: kernel NULL pointer dereference, address: 0000000000000058
>>>>>>>>> #PF: supervisor read access in kernel mode
>>>>>>>>> #PF: error_code(0x0000) - not-present page
>>>>>>>>> PGD 0 P4D 0
>>>>>>>>> Oops: 0000 [#1] PREEMPT SMP
>>>>>>>>> CPU: 0 PID: 3192 Comm: syz-executor.0 Not tainted
>>>>>>>>> 6.4.0-rc2-syzkaller #0
>>>>>>>>> Hardware name: Google Google Compute Engine/Google Compute Engine,
>>>>>>>>> BIOS Google 08/04/2023
>>>>>>>>> RIP: 0010:__lock_acquire+0x35/0x490 kernel/locking/lockdep.c:4946
>>>>>>>>> Code: 83 ec 18 65 4c 8b 35 aa 60 f4 7e 83 3d b7 11 e4 02 00 0f 84 05
>>>>>>>>> 02 00 00 4c 89 cb 89 cd 41 89 d5 49 89 ff 83 fe 01 77 0c 89 f0
>>>>>>>>> <49> 8b
>>>>>>>>> 44 c7 08 48 85 c0 75 1b 4c 89 ff 31 d2 45 89 c4 e8 74 f6 ff
>>>>>>>>> RSP: 0018:ffffc90002edb840 EFLAGS: 00010097
>>>>>>>>> RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000002
>>>>>>>>> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000050
>>>>>>>>> RBP: 0000000000000002 R08: 0000000000000001 R09: 0000000000000000
>>>>>>>>> R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
>>>>>>>>> R13: 0000000000000000 R14: ffff888102ea5340 R15: 0000000000000050
>>>>>>>>> FS:  0000000000000000(0000) GS:ffff88813bc00000(0000)
>>>>>>>>> knlGS:0000000000000000
>>>>>>>>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>>>>>>>> CR2: 0000000000000058 CR3: 0000000003aa8000 CR4: 00000000003506f0
>>>>>>>>> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>>>>>>>>> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>>>>>>>>> Call Trace:
>>>>>>>>>    <TASK>
>>>>>>>>>    lock_acquire+0xd8/0x1f0 kernel/locking/lockdep.c:5691
>>>>>>>>>    seqcount_lockdep_reader_access include/linux/seqlock.h:102 [inline]
>>>>>>>>>    get_fs_root_rcu fs/d_path.c:243 [inline]
>>>>>>>>>    d_path+0xd1/0x1f0 fs/d_path.c:285
>>>>>>>>>    audit_log_d_path+0x65/0x130 kernel/audit.c:2139
>>>>>>>>>    dump_common_audit_data security/lsm_audit.c:224 [inline]
>>>>>>>>>    common_lsm_audit+0x3b3/0x840 security/lsm_audit.c:458
>>>>>>>>>    smack_log+0xad/0x130 security/smack/smack_access.c:383
>>>>>>>>>    smk_tskacc+0xb1/0xd0 security/smack/smack_access.c:253
>>>>>>>>>    smack_inode_getattr+0x8a/0xb0 security/smack/smack_lsm.c:1187
>>>>>>>>>    security_inode_getattr+0x32/0x50 security/security.c:2114
>>>>>>>>>    vfs_getattr+0x1b/0x40 fs/stat.c:167
>>>>>>>>>    ovl_getattr+0xa6/0x3e0 fs/overlayfs/inode.c:173
>>>>>>>>>    ima_check_last_writer security/integrity/ima/ima_main.c:171
>>>>>>>>> [inline]
>>>>>>>>>    ima_file_free+0xbd/0x130 security/integrity/ima/ima_main.c:203
>>>>>>>>>    __fput+0xc7/0x220 fs/file_table.c:315
>>>>>>>>>    task_work_run+0x7d/0xa0 kernel/task_work.c:179
>>>>>>>>>    exit_task_work include/linux/task_work.h:38 [inline]
>>>>>>>>>    do_exit+0x2c7/0xa80 kernel/exit.c:871 <-----------------------
>>>>>>>>>    do_group_exit+0x85/0xa0 kernel/exit.c:1021
>>>>>>>>>    get_signal+0x73c/0x7f0 kernel/signal.c:2874
>>>>>>>>>    arch_do_signal_or_restart+0x89/0x290 arch/x86/kernel/signal.c:306
>>>>>>>>>    exit_to_user_mode_loop+0x61/0xb0 kernel/entry/common.c:168
>>>>>>>>>    exit_to_user_mode_prepare+0x64/0xb0 kernel/entry/common.c:204
>>>>>>>>>    __syscall_exit_to_user_mode_work kernel/entry/common.c:286 [inline]
>>>>>>>>>    syscall_exit_to_user_mode+0x2b/0x1d0 kernel/entry/common.c:297
>>>>>>>>>    do_syscall_64+0x4d/0x90 arch/x86/entry/common.c:86
>>>>>>>>>    entry_SYSCALL_64_after_hwframe+0x63/0xcd
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> do_exit has called exit_fs(tsk) [
>>>>>>>>> https://elixir.bootlin.com/linux/v6.4-rc2/source/kernel/exit.c#L867 ]
>>>>>>>>>
>>>>>>>>> exit_fs(tsk) has set tsk->fs = NULL [
>>>>>>>>> https://elixir.bootlin.com/linux/v6.4-rc2/source/fs/fs_struct.c#L103
>>>>>>>>> ]
>>>>>>>>>
>>>>>>>>> I think this then bites in d_path() where it calls:
>>>>>>>>>
>>>>>>>>>       get_fs_root_rcu(current->fs, &root);   [
>>>>>>>>> https://elixir.bootlin.com/linux/v6.4-rc2/source/fs/d_path.c#L285 ]
>>>>>>>>>
>>>>>>>>> current->fs is likely NULL here.
>>>>>>>>>
>>>>>>>>> If this was correct it would have nothing to do with the actual
>>>>>>>>> patch,
>>>>>>>>> though, but rather with the fact that smack logs on process
>>>>>>>>> termination. I am not sure what the solution would be other than
>>>>>>>>> testing for current->fs == NULL in d_path before using it and
>>>>>>>>> returning an error that is not normally returned or trying to
>>>>>>>>> intercept this case in smack.
>>>>>>>> I have now been able to recreate the syzbot issue with the test
>>>>>>>> program
>>>>>>>> and the issue is exactly the one described here, current->fs == NULL.
>>>>>>>>
>>>>>>> Earlier in this thread, Amir had a diagnosis that IMA is
>>>>>>> inappropriately
>>>>>>> trying to use f_path directly instead of using the helpers that are
>>>>>>> friendly for stacking filesystems.
>>>>>>>
>>>>>>> https://lore.kernel.org/linux-fsdevel/CAOQ4uxgjnYyeQL-LbS5kQ7+C0d6sjzKqMDWAtZW8cAkPaed6=Q@mail.gmail.com/
>>>>>>>
>>>>>>>
>>>>>>> I'm not an IMA hacker so I'm not planning to roll a fix here. Perhaps
>>>>>>> someone on the IMA team could try this approach?
>>>>>>
>>>>>> I have applied this patch here from Amir now and it does NOT resolve
>>>>>> the issue:
>>>>>>
>>>>>> https://lore.kernel.org/linux-integrity/296dae962a2a488bde682d3def074db91686e1c3.camel@linux.ibm.com/T/#m4ebdb780bf6952e7f210c55e87950d0cfa1d5eb0
>>>>>>
>>>>>>
>>>>> This seems to resolve the issue:
>>>>>
>>>>> diff --git a/security/smack/smack_access.c
>>>>> b/security/smack/smack_access.c
>>>>> index 585e5e35710b..57afcea1e39b 100644
>>>>> --- a/security/smack/smack_access.c
>>>>> +++ b/security/smack/smack_access.c
>>>>> @@ -347,6 +347,9 @@ void smack_log(char *subject_label, char
>>>>> *object_label, int request,
>>>>>          struct smack_audit_data *sad;
>>>>>          struct common_audit_data *a = &ad->a;
>>>>>
>>>>> +       if (current->flags & PF_EXITING)
>>>>> +               return;
>>>>> +
>>>> Based on what I see here I can understand that this prevents the panic,
>>>> but it isn't so clear what changed that introduced the problem.
>>>>
>>>>>          /* check if we have to log the current event */
>>>>>          if (result < 0 && (log_policy & SMACK_AUDIT_DENIED) == 0)
>>>>>                  return;
>>>>>
>>>>>
>>> Apparently, it's this patch:
>>>
>>>      db1d1e8b9867 IMA: use vfs_getattr_nosec to get the i_version
>> Yes, the syzbot was updated with that info.
>>
>>> At one time, IMA would reach directly into the inode to get the
>>> i_version and ctime. That was fine for certain filesystems, but with
>>> more recent changes it needs to go through ->getattr instead. Evidently,
>>> it's selecting the wrong inode to query when dealing with overlayfs and
>>> that's causing panics at times.
>>>
>>> As to why the above patch helps, I'm not sure, but given that it doesn't
>>> seem to change which inode is being queried via getattr, it seems like
>>> this is probably papering over the real bug. That said, IMA and
>>> overlayfs are not really in my wheelhouse, so I could be very wrong
>>> here.
>> The call to vfs_getattr_nosec() somehow triggers a call to
>> security_inode_getattr().  Without the call neither ovl_getattr() nor
>> smack_inode_getattr() would be called.
> ima_file_free()
> -> ima_check_last_writer()
>     -> vfs_getattr_nosec()
>        -> i_op->getattr() == ovl_getattr()
>           -> vfs_getattr()
>              -> security_inode_getattr()
> 	    -> real_i_op->getattr()
>
> is the callchain that triggers this.
>
> ima_file_free() is called in a very sensitive location: __fput() that
> can be called from task work when the process is already PF_EXITING.
>
> The ideal solution would be for ima to stop calling back into the
> filesystems in this location at all but that's probably not going to
> happen because I now realize you also set extended attributes from
> __fput():
>
>
> ima_check_last_writer()
> -> ima_update_xatt()
>     -> ima_fix_xattr()
>        -> __vfs_setxattr_noperm()
>
> The __vfs_setxattr_noperm() codepath can itself trigger
> security_inode_post_setxattr() and security_inode_setsecurity(). So
> those hooks are hopefully safe to be called with PF_EXITING tasks as
> well...

LSM inode_post_setxattr has two users, Smack and SELinux. Smack does not 
call smack_log/audit in this case. SELinux seems safe as well.

LSM inode_setsecurity has two users, Smack and SELinux. Smack does not 
call smack_log/audit in this case. SELinux seems safe as well.


>
> Imho, this is all very wild but I'm not judging.
>
> Two solutions imho:
> (1) teach stacking filesystems like overlayfs and ecryptfs to use
>      vfs_getattr_nosec() in their ->getattr() implementation when they
>      are themselves called via vfs_getattr_nosec(). This will fix this by
>      not triggering another LSM hook.
> (2) make all ->getattr() LSM hooks PF_EXITING safe ideally don't do
>      anything

Re (2): LSM's getattr should still make policy decision, right? So 
callers should be allowed to go to some depth into these functions but 
avoid calls deeper into smack_log (for example) that trigger the call path
   common_lsm_audit
    -> dump_common_audit_data
     -> audit_log_d_path via a->type LSM_AUDIT_DATA_PATH or 
LSM_AUDIT_DATA_FILE or  LSM_AUDIT_DATA_IOCTL_OP and then possibly run 
into current->fs == NULL in d_path.

To avoid audit_log_d_path being called the a->type should not be either 
one of the 3 mentioned above:

LSM_AUDIT_DATA_PATH: used by Smack & SELinux
LSM_AUDIT_DATA_FILE: used by SELinux
LSM_AUDIT_DATA_IOCTL: used by SELinux


The LSM getattr has users AppArmor, SELinux, Smack and Tomoyo.

Tomoyo: seems safe
SELinux:

selinux_inode_getattr
   -> path_has_perm  [ sets LSM_AUDIT_DATA_FILE !! ]
     -> inode_has_perm
      -> avc_has_perm
       -> avc_audit
         -> slow_avc_audit
           -> common_lsm_audit
            -> dump_common_audit_data
             -> audit_log_d_path
              -> d_path
               -> get_fs_root_rcu with current->fs = NULL

Smack: (the known path per this syzbot issue)

smack_inode_getattr   [ sets LSM_AUDIT_DATA_PATH !! ]
   -> smk_curacc
     -> smk_tskacc
       -> smack_log
        -> common_lsm_audit
          -> dump_common_audit_data
            -> audit_log_d_path
              -> d_path
               -> get_fs_root_rcu with current->fs = NULL

AppArmor:

apparmor_inode_getattr
   -> common_perm_cond
      -> common_perm
        -> aa_path_perm
           -> profile_path_perm
               -> aa_path_perm
                  -> aa_audit_file      [ sets LSM_AUDIT_DATA_TASK ]
                     -> aa_audit
                      -> aa_audit_msg
                        -> common_lsm_audit
                         -> dump_common_audit_data
                           -> DOES NOT call audit_log_d_path but calls 
task_tgid_nr(tsk)


So, SELinux and Smack would be affected. The common code path starts 
with common_lsm_audit and either a check for current->flags & PF_EXITING 
or a more fine-grained one like this here could be a solution for (2)

diff --git a/security/lsm_audit.c b/security/lsm_audit.c
index 849e832719e2..4f3570322851 100644
--- a/security/lsm_audit.c
+++ b/security/lsm_audit.c
@@ -445,6 +445,18 @@ void common_lsm_audit(struct common_audit_data *a,

         if (a == NULL)
                 return;
+
+       if (current->flags & PF_EXITING) {
+               /*
+                * Avoid running into audit_log_d_path -> d_path
+                * -> get_fs_root_rcu with current->fs = NULL
+                */
+               if (a->type == LSM_AUDIT_DATA_PATH ||
+                   a->type == LSM_AUDIT_DATA_FILE ||
+                   a->type == LSM_AUDIT_DATA_IOCTL_OP)
+                       return;
+       }
+
         /* we use GFP_ATOMIC so we won't sleep */
         ab = audit_log_start(audit_context(), GFP_ATOMIC | __GFP_NOWARN,
                              AUDIT_AVC);

