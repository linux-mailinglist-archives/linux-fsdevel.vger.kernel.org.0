Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35B257A9040
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Sep 2023 02:52:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbjIUAwv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Sep 2023 20:52:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjIUAwv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Sep 2023 20:52:51 -0400
Received: from sonic310-31.consmr.mail.ne1.yahoo.com (sonic310-31.consmr.mail.ne1.yahoo.com [66.163.186.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31FC7CC
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Sep 2023 17:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1695257563; bh=4XGo06nD0q/isxOKfCq4Ym72rZZ7e6gWq0DEFzk03H4=; h=Date:Subject:To:References:From:In-Reply-To:From:Subject:Reply-To; b=V+zrXVQGr7J8AWpa6D23UAf4y+v1/VXAiOGNGd2YACCzBaSmBh0rh40arcGSwgZF+FuHP8PyfHiuFpdKiBkgC6Ld2exJpN10JBRowzHKxSEPf2Uuy0RPZjpgwzjXFeCpJLaAnrf2wQy8wUHpLlLrqCvCXqfNGEe8vR8+oeq3ytUh2NZy7iQtyzoyT8QJsHI+BdnY8VzF3jBP/jCkVibaN0WiJVHiF4TSggYg62ZLmxSQ0UZoaz+HqsYg3Vg0ikUMJrMrizT92/VU8PfoVIe5u+lBUxq0IXqpA6AS4wG/gMbe1WxBQrCtrS3LQQaq2TSxQuXAFcDoTWJe0skkXqIaYA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1695257563; bh=iam1T9XBM6+E0i/8su4RtToizOC/WtiG2jDRIkfWkUj=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=hbSFqjgAKI42ffTYnDPuC9sJ011RWb8FxiTPRZK65fEfCq11yeICG7yDtPhU5eFzPMLabwnXg83TPPBcyXMnw5eBM+Plw3cRsxU7JkGn3/kQ9fkjcUlGPCDC9twjk767gIJdBGbyqxO21ymSDGJgFez+IqrHkk2ka6XC8x7nsKmHOdg1WwTuAKZ2zKsNJDJ5HhKgjzeWbSpm3g54VRCEDN4JsKn+mgCBXkhW76B9FpuqBrBx1D3RMorpBxtxMZ9U7Gb6dLnYAf69NEgM22eCXC1suKsAvmjMYTyBgjGHmsLsfCxjrQzZzGwe4UOjvXc76MuBdar2jGprmk/NfhwdRw==
X-YMail-OSG: _MMocIMVM1nYb7R4QLAC4w2BIwd0Mj9H3.YlYpHv8H7gqRZcQVKt8UX1WKa1Sux
 S5V9qMko7uDRh1KdmdFpFf2jaO__I_ZNF4BJ_HwpfO_FT4L2wA9b_qJTo51btqFOTs3oa4kkhANm
 mAqLN9nroObzC5t0.mjn9riQis2KFSG9AFyqeZulJF.EuAfsoT2y6TdU.WMF1xM4C3MNFY0hVSdb
 QHnpQ5xIHU6GBw1s7TLMqRgy9GHm8sNh7jGdj3Jm4VwHZaoTa6Y4uBpGDvHEI2jXyr3AMF_hI_Io
 huwHAJIK1uwDwuW91tr4pwz3YiVeYvMACJowEXOobO0v3GJ_1ciJcF6xu.6QD8iG2pA5hqHO4pXY
 Km.MlnJYNbr8DqeREIz3fTGHJB6z4gxjtzDL.X9cCHqp_byIaB8lUpQGgO3VAynVe8bEJK588_cV
 TG6Ho_8T9c9jhi._2WAjrF8GLwymaylBNoPOQPYnE76owqAIpGAh6EG6xVybOmsOdZp7p6TWEHp7
 1lR3yGKd6DsSa64fUQHzBa3OfAi_U0k_RdLTHXtHh1JzKMmh1tALpPsT6p1nIbOt7Hlz25Uxz_A0
 Of2fBZgBKbjRpqUwcQ.59jxrCgcvTW6cWR.p1dZbcby5ek4oN8PjpUtMBZme1amccBzIq82U5WeC
 if5UXAAXMdA6eFE0S3kmzzaUxL1qQlg.HbWKSLpGLfrn9zsd168fVPNrGAOGX6GOT4CBRxwn0CjP
 zQ.UPjyWAimrLGP3.QoLjvefi_wjeiKTVA7KZ_VzDl.TBdf4vPRjwQyXkpKcnzaOSrcFw6hf7a.V
 UgtcCcfajS7vIZW.IPQThNeJt970yl39I0Tb.uLJKPxuf60OTakZnRTQod0QQKhvbJq5XQrBWndd
 AllucZw0gPQQlVTXiPqBAG.rl2OdffnonUL_dsnQtgKAUNrUkJ.AxYfeznlHGhjOO2SAdyLkXdpO
 BpcqAtqzPgJKamFGNW3kTFSvGHOhR9XsxgeBgWys4DHX_N09BJh3vvdMZ9fkQLaeQ5j6Mc2du0VC
 PBJpDpkNE5HsjhOM3vbcxKfTx_WzqJVqa_bSIPQFVb0mZkFpU42PlcC3xEAd8.9Cip1GtnXqBEW4
 yZUmOKINlQNR0qQz0yFNRTjPr.LMXu7Dy3Tor3TtU7y.jpH5KzNivocsFU11kGXVQ7KzZj61ERnT
 movwNKlo9vj4nkwYLfdhytJJJTSHHnWux.o3l1BRuZSFtwmlNAssK3EoCS6xKVb2pUoUljoovuR8
 FR_wl1ei_xAdAEqj.0UjjNq0cNq3Pi3m8mhuHD_A4ClJRLpX6oJDSnk6XKi8jWPLuM1bOek8EoPI
 MW4GQOAk8_tdtl4ccDpyvVqZ.Q6bppLDN1hAOZx5VvxGm4fNIb9LAK3d2Mv8jqNKTpZulqbbXYn.
 IbGxzu2PAeb5Z4toKwVh80ejJxwUy1UD4RYByHn2dSjxSLGutQYAgYw_KMe0Zkm2H7w2LexxsuRX
 pijiuW9utPzFsJs0Yadn8F9q0CulKkYa6OMgKOldyUjN2vPnFVOpUDbIqzcGvCvxHQPktTaAmb0M
 XPTCZ338kkHerG0CXdCwuKv7QyKB0UF3XTq_m0xP0OBoAwek4WxUYcpM9tnTiANyLTyf14Jx6w3w
 ZHF6__sYbrGKThc8JLVsO8V5xG5SyNSDnkulRj5jb149.P5q2Vc5eHZ5X4i9RLDptXeFFv2XZkDD
 jBL0BgtKkppyHp_lb5ARfHnttInJt0RKnZwGmsenxA1JFuzxpcUCFLbI67Axa9J5XnorxVlAgHvU
 OnfG2wbtRbQq4wPuK5NFNUj.eI47C3KKtBcu_glnxCHHKDCCuJBFUPLKL7M4Pp5_QNbqd3KMtcPP
 2b_fQvLIM55p0PGW.Lg7KqaasVjSI.8gm2K28NrZQdv2TcMGBQqRz.OLCiUQe2t0oIseZF1ArTjN
 k1SHamfxVAKxK6J7eCBJHs.hgjkcA3g3SfwkMRDV50KP7HG40WzNBMaW.A1qmaTIZOmS8ed_NIej
 Q85MjDOr4iea0XQ4lcBe1SfyGne5fHlbMso7Ruikdn6W8jagGsmJCJm6b0eTcpHwBcZXVKdqHKmr
 A2n7O.ZIJcN2Ckz533G_tH3qLRkNInVrpfDVunf6FC4NL.uaJgR8h522BUejNQ5SYUzik6Yg62TI
 OMfQLY5LY1uZQOMmXlK33Wf2u5D0TXsCoflp2LmUN2wun4VGMTgrGs_JZjuxCvxESQFQ9zAZCg8G
 Lum_q.Ul5JwnhVqFj0Hulg90YvZrU_o68MvBtUbVHGWnW5X0XLgk__wkaDkFHVUCXyx7AeNWAdfM
 rLGEbBZiQ
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 69653b16-1ee4-4f28-8cda-9763ffaef2ae
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.ne1.yahoo.com with HTTP; Thu, 21 Sep 2023 00:52:43 +0000
Received: by hermes--production-bf1-678f64c47b-d5jmw (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 5dc4de451e33898f98cc3c5e7e5f6eb7;
          Thu, 21 Sep 2023 00:52:41 +0000 (UTC)
Message-ID: <94b4686a-fee8-c545-2692-b25285b9a152@schaufler-ca.com>
Date:   Wed, 20 Sep 2023 17:52:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [syzbot] [integrity] [overlayfs] general protection fault in
 d_path
Content-Language: en-US
To:     Stefan Berger <stefanb@linux.ibm.com>,
        Jeff Layton <jlayton@kernel.org>,
        syzbot <syzbot+a67fc5321ffb4b311c98@syzkaller.appspotmail.com>,
        amir73il@gmail.com, brauner@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        miklos@szeredi.hu, syzkaller-bugs@googlegroups.com,
        zohar@linux.ibm.com, Casey Schaufler <casey@schaufler-ca.com>
References: <000000000000259bd8060596e33f@google.com>
 <bed99e92-cb7c-868d-94f3-ddf53e2b262a@linux.ibm.com>
 <8a65f5eb-2b59-9903-c6b8-84971f8765ae@linux.ibm.com>
 <ab7df5e93b5493de5fa379ccab48859fe953d7ae.camel@kernel.org>
 <b16550ac-f589-c5d7-e139-d585e8771cfd@linux.ibm.com>
 <00dbd1e7-dfc8-86bc-536f-264a929ebb35@linux.ibm.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <00dbd1e7-dfc8-86bc-536f-264a929ebb35@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.21797 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/20/2023 5:10 PM, Stefan Berger wrote:
>
> On 9/20/23 18:09, Stefan Berger wrote:
>>
>> On 9/20/23 17:16, Jeff Layton wrote:
>>> On Wed, 2023-09-20 at 16:37 -0400, Stefan Berger wrote:
>>>> On 9/20/23 13:01, Stefan Berger wrote:
>>>>> On 9/17/23 20:04, syzbot wrote:
>>>>>> syzbot has bisected this issue to:
>>>>>>
>>>>>> commit db1d1e8b9867aae5c3e61ad7859abfcc4a6fd6c7
>>>>>> Author: Jeff Layton <jlayton@kernel.org>
>>>>>> Date:   Mon Apr 17 16:55:51 2023 +0000
>>>>>>
>>>>>>       IMA: use vfs_getattr_nosec to get the i_version
>>>>>>
>>>>>> bisection log:
>>>>>> https://syzkaller.appspot.com/x/bisect.txt?x=106f7e54680000
>>>>>> start commit:   a747acc0b752 Merge tag
>>>>>> 'linux-kselftest-next-6.6-rc2'
>>>>>> of g..
>>>>>> git tree:       upstream
>>>>>> final oops:
>>>>>> https://syzkaller.appspot.com/x/report.txt?x=126f7e54680000
>>>>>> console output:
>>>>>> https://syzkaller.appspot.com/x/log.txt?x=146f7e54680000
>>>>>> kernel config:
>>>>>> https://syzkaller.appspot.com/x/.config?x=df91a3034fe3f122
>>>>>> dashboard link:
>>>>>> https://syzkaller.appspot.com/bug?extid=a67fc5321ffb4b311c98
>>>>>> syz repro:
>>>>>> https://syzkaller.appspot.com/x/repro.syz?x=1671b694680000
>>>>>> C reproducer:
>>>>>> https://syzkaller.appspot.com/x/repro.c?x=14ec94d8680000
>>>>>>
>>>>>> Reported-by: syzbot+a67fc5321ffb4b311c98@syzkaller.appspotmail.com
>>>>>> Fixes: db1d1e8b9867 ("IMA: use vfs_getattr_nosec to get the
>>>>>> i_version")
>>>>>>
>>>>>> For information about bisection process see:
>>>>>> https://goo.gl/tpsmEJ#bisection
>>>>> The final oops shows this here:
>>>>>
>>>>> BUG: kernel NULL pointer dereference, address: 0000000000000058
>>>>> #PF: supervisor read access in kernel mode
>>>>> #PF: error_code(0x0000) - not-present page
>>>>> PGD 0 P4D 0
>>>>> Oops: 0000 [#1] PREEMPT SMP
>>>>> CPU: 0 PID: 3192 Comm: syz-executor.0 Not tainted
>>>>> 6.4.0-rc2-syzkaller #0
>>>>> Hardware name: Google Google Compute Engine/Google Compute Engine,
>>>>> BIOS Google 08/04/2023
>>>>> RIP: 0010:__lock_acquire+0x35/0x490 kernel/locking/lockdep.c:4946
>>>>> Code: 83 ec 18 65 4c 8b 35 aa 60 f4 7e 83 3d b7 11 e4 02 00 0f 84 05
>>>>> 02 00 00 4c 89 cb 89 cd 41 89 d5 49 89 ff 83 fe 01 77 0c 89 f0
>>>>> <49> 8b
>>>>> 44 c7 08 48 85 c0 75 1b 4c 89 ff 31 d2 45 89 c4 e8 74 f6 ff
>>>>> RSP: 0018:ffffc90002edb840 EFLAGS: 00010097
>>>>> RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000002
>>>>> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000050
>>>>> RBP: 0000000000000002 R08: 0000000000000001 R09: 0000000000000000
>>>>> R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
>>>>> R13: 0000000000000000 R14: ffff888102ea5340 R15: 0000000000000050
>>>>> FS:  0000000000000000(0000) GS:ffff88813bc00000(0000)
>>>>> knlGS:0000000000000000
>>>>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>>>> CR2: 0000000000000058 CR3: 0000000003aa8000 CR4: 00000000003506f0
>>>>> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>>>>> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>>>>> Call Trace:
>>>>>   <TASK>
>>>>>   lock_acquire+0xd8/0x1f0 kernel/locking/lockdep.c:5691
>>>>>   seqcount_lockdep_reader_access include/linux/seqlock.h:102 [inline]
>>>>>   get_fs_root_rcu fs/d_path.c:243 [inline]
>>>>>   d_path+0xd1/0x1f0 fs/d_path.c:285
>>>>>   audit_log_d_path+0x65/0x130 kernel/audit.c:2139
>>>>>   dump_common_audit_data security/lsm_audit.c:224 [inline]
>>>>>   common_lsm_audit+0x3b3/0x840 security/lsm_audit.c:458
>>>>>   smack_log+0xad/0x130 security/smack/smack_access.c:383
>>>>>   smk_tskacc+0xb1/0xd0 security/smack/smack_access.c:253
>>>>>   smack_inode_getattr+0x8a/0xb0 security/smack/smack_lsm.c:1187
>>>>>   security_inode_getattr+0x32/0x50 security/security.c:2114
>>>>>   vfs_getattr+0x1b/0x40 fs/stat.c:167
>>>>>   ovl_getattr+0xa6/0x3e0 fs/overlayfs/inode.c:173
>>>>>   ima_check_last_writer security/integrity/ima/ima_main.c:171
>>>>> [inline]
>>>>>   ima_file_free+0xbd/0x130 security/integrity/ima/ima_main.c:203
>>>>>   __fput+0xc7/0x220 fs/file_table.c:315
>>>>>   task_work_run+0x7d/0xa0 kernel/task_work.c:179
>>>>>   exit_task_work include/linux/task_work.h:38 [inline]
>>>>>   do_exit+0x2c7/0xa80 kernel/exit.c:871 <-----------------------
>>>>>   do_group_exit+0x85/0xa0 kernel/exit.c:1021
>>>>>   get_signal+0x73c/0x7f0 kernel/signal.c:2874
>>>>>   arch_do_signal_or_restart+0x89/0x290 arch/x86/kernel/signal.c:306
>>>>>   exit_to_user_mode_loop+0x61/0xb0 kernel/entry/common.c:168
>>>>>   exit_to_user_mode_prepare+0x64/0xb0 kernel/entry/common.c:204
>>>>>   __syscall_exit_to_user_mode_work kernel/entry/common.c:286 [inline]
>>>>>   syscall_exit_to_user_mode+0x2b/0x1d0 kernel/entry/common.c:297
>>>>>   do_syscall_64+0x4d/0x90 arch/x86/entry/common.c:86
>>>>>   entry_SYSCALL_64_after_hwframe+0x63/0xcd
>>>>>
>>>>>
>>>>> do_exit has called exit_fs(tsk) [
>>>>> https://elixir.bootlin.com/linux/v6.4-rc2/source/kernel/exit.c#L867 ]
>>>>>
>>>>> exit_fs(tsk) has set tsk->fs = NULL [
>>>>> https://elixir.bootlin.com/linux/v6.4-rc2/source/fs/fs_struct.c#L103
>>>>> ]
>>>>>
>>>>> I think this then bites in d_path() where it calls:
>>>>>
>>>>>      get_fs_root_rcu(current->fs, &root);   [
>>>>> https://elixir.bootlin.com/linux/v6.4-rc2/source/fs/d_path.c#L285 ]
>>>>>
>>>>> current->fs is likely NULL here.
>>>>>
>>>>> If this was correct it would have nothing to do with the actual
>>>>> patch,
>>>>> though, but rather with the fact that smack logs on process
>>>>> termination. I am not sure what the solution would be other than
>>>>> testing for current->fs == NULL in d_path before using it and
>>>>> returning an error that is not normally returned or trying to
>>>>> intercept this case in smack.
>>>> I have now been able to recreate the syzbot issue with the test
>>>> program
>>>> and the issue is exactly the one described here, current->fs == NULL.
>>>>
>>> Earlier in this thread, Amir had a diagnosis that IMA is
>>> inappropriately
>>> trying to use f_path directly instead of using the helpers that are
>>> friendly for stacking filesystems.
>>>
>>> https://lore.kernel.org/linux-fsdevel/CAOQ4uxgjnYyeQL-LbS5kQ7+C0d6sjzKqMDWAtZW8cAkPaed6=Q@mail.gmail.com/
>>>
>>>
>>> I'm not an IMA hacker so I'm not planning to roll a fix here. Perhaps
>>> someone on the IMA team could try this approach?
>>
>>
>> I have applied this patch here from Amir now and it does NOT resolve
>> the issue:
>>
>> https://lore.kernel.org/linux-integrity/296dae962a2a488bde682d3def074db91686e1c3.camel@linux.ibm.com/T/#m4ebdb780bf6952e7f210c55e87950d0cfa1d5eb0
>>
>>
>
> This seems to resolve the issue:
>
> diff --git a/security/smack/smack_access.c
> b/security/smack/smack_access.c
> index 585e5e35710b..57afcea1e39b 100644
> --- a/security/smack/smack_access.c
> +++ b/security/smack/smack_access.c
> @@ -347,6 +347,9 @@ void smack_log(char *subject_label, char
> *object_label, int request,
>         struct smack_audit_data *sad;
>         struct common_audit_data *a = &ad->a;
>
> +       if (current->flags & PF_EXITING)
> +               return;
> +

Based on what I see here I can understand that this prevents the panic,
but it isn't so clear what changed that introduced the problem.

>         /* check if we have to log the current event */
>         if (result < 0 && (log_policy & SMACK_AUDIT_DENIED) == 0)
>                 return;
>
>
