Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAA283BAA82
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 Jul 2021 00:17:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbhGCWTd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 3 Jul 2021 18:19:33 -0400
Received: from sonic314-27.consmr.mail.ne1.yahoo.com ([66.163.189.153]:45152
        "EHLO sonic314-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229557AbhGCWTc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 3 Jul 2021 18:19:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1625350617; bh=YbIv94o6C/dZEyYF2m240ieOzJImOpstAJQYnFn3Vi8=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject:Reply-To; b=md/DNpfAym2TpTgCFFyNSJ2VnLP3uQe7DaBsTriKRCWQUSP3uvlwhtbLOmbLyTZWvKmMYvZyV8u8OZ5PH5mNH+u+QQ4S85l507GaLk2ETBg0QC9kcXKNiohPCZmunJxAEGHrjiVqJGTZg1A1MFhv9nwn/LhWgb4P+Aa+GHqi8oGo66caY11Qe7GI0hbGLdEGjYNVh+EhkMBRZ9vJxK9vYU/2M7ypdhLKQbu0pi+XgHi6EKu0plR2hRIJmCbgvs7xBB9/EH/4EAulw1oLceZZuodMk/VztxLRZXjf4Y8ql1pFRW/4XTBhWuWBpJ5vt9GSOlyg0kZQTaMdsuJJ9tq4qA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1625350617; bh=FtVcvZXnyHGBUIDmE8GGLVCbvFd+1Ujd5i5hwkTZV6I=; h=X-Sonic-MF:Subject:To:From:Date:From:Subject; b=AzGz9JKKNTM8t2mqs8Q+gDCqP4OS9L1sh8Lictggw8kjgk6Sdzh04qm0apUKMJBbWGgggDXP5H6f45ADj89d0ekdIq5hZP7KuoLZVyBl/0CNCdixMTQxsFELi3H3urwAnv4Ay4KORS04+/Dg+mGMG8OYr1waSut+0CWotLrvMXK90ytXZlJnPmTN48PJitTsb/cMWC4jRLSoufwEWJ0TJyOHMCxgsCwNCv3owAp/Bs+Kxoxa9aHmWOenaLwES2ugS+kWtDk1mJbkk83iBJXPNC6PWFXxRL91Sx8IPcc7ahA/iSKVLCg0OChFz7/VnSwLOylH/2zINMjuwGHj2Ai90g==
X-YMail-OSG: y8D_UyoVM1nPit9zOl1Q6udbWmFCQVFW0APg.NmmM4bjfHvdoPQCatnFR9lBAdI
 AjMBk.xn6MhiKywjNq1NejNw_uxg_6PuXl8rWW1MIwMpNnCTlzAFSJDQ5flT.RKDZs.FQfEq1Lfa
 PGH7fydaPgWi971BtxQSMP8HnufmXA7RzUtlVvDuZlZaEhhYLv3BSaK.WPTFVcIALRbnB9aZNUHZ
 UwJVqEmZvgRCoTF8Zjb5sra22tuRrXkMTdauJXJMjG_rrVdlnfrpwQCH8xlQfDR7vY4vFEjUrqKM
 aNOEq5UUex00jX2eLZDd7tFsk0LnKwfT_L7KV.GeA50ae0ETC7qnftosgjSn_1weyH4r0ImF25Cs
 lubtxgFjIG1AQdtZ0RfKfMmDongqoNG_UoxojksaXDZXdOvdMXEmMYarRtrhKLJljuMdP3bya7ww
 n1rXzYVre8.IX16yjS8NoyUzoWBAzVfNwx37D6v9K7ieo9_Dnj4Xb67XwHhsi9DGHkFyQU3cBSwv
 DgvmBd8fy.qSOyHSuwKnKy6zPYT8ZvVm2kxP45KYKghOBSBskXLigkDA0SU5Uz5kcSKPX34CvwCi
 V_2ejBI99lR6hPJdsQpUfyDrKALIq7Y2YieLW2Gr7HWSuO3otaynegkiLuJBjNLuYXSfSLpfu8Rg
 xqHLeXWXMr23FCEdViF2INsCXAjB4bv.nA8gJi.ZvGIGHl81Tc81Iz4CL2siydfpyLzsFsuwHxWv
 y77Gc3YvLHE1IVQawQjNKYHw5ItC3.2FqDFtWlJRSc40yfgSSyeLnez_g6TPssvg7.nqS1glPUSf
 mhHxPAF2k7meEm6_C8TuNU.bMDErYtSNAa.AD7GVQGMYfsPC3sME6zDZ7cxn30rSdGJBFEZsMk0i
 yZK3A_UGk55UW4uOvNuVY3_EQh4T7pKBNtAH9qRIIVfyXRVeHuiE4x98p53uo_BJ_rM3G29jSHJ1
 RG0pvYt_pdttzS5SIj_njhfqXkr1p0qIVrBPgPJ.6cwlH3yPOVYyKdlh8V0CgnI1XN7DMZ5sjyoD
 TV3z7CE8JCiuoGW.9eH7I_Djo7P_RyxBaUJ1tnCrO7mHhq6DxhjkLQsySj7E9Ovq_.hFQXEU8ahX
 _R.6iSOYkAx9NZ8sC88s7x4Z30OeWs8CpPlmdRayEKiGZ0fRZm0u4MDK4ttx0bH0QEsJZubxvSV9
 6LlVq8le5gHoJ87C8C_s0N0mYP043AmOGQ9Jz2XTNrPc6B8_VP0GGqhNmIf45q2ZZIHb5i9vBnoH
 J7y4tQ.TErc1ZtqCSTiwDkMH0xdvIrRdU7MuW5h_H0_f6N8gaQTd_IEZ64xjxckmHznwbVH6zAwc
 u5jGE7X7jY9WXS0FEvXznjQH7xhubsYf.ENHs_CwaVzJqNJR_mqwBwlbvtEAL_dgzU6NlOYPoClp
 bQzhoul7mLGcvPhzxxzQk9qblxnSFzus_zstvZQMzyA1tF6u8WfQoeXmyH4ekKViieh2aP7j1gc5
 4_UMu3jFAF_SzkvA1phaAQ2tNqq0SCTNw1Y8oU58bo70qVvYGZS4SrY9XeAZSuzcp_hCJFV6WQtZ
 aj4kTKyk_.fIFEzQ1ahoMhTxv_1RvaKqzyo89C7w66nYEX9OGcFqR44VAwo9Cov6phoutXlezWqh
 V5JjONEbzYN.MlkeUsco3UdMrhsY3NkOEO9XTRrS6x45NMD.1YHoG.oQ.xAMlddpZZf48VTvZgZ9
 6C1obwqZRXefARC0f1ICbClvL2hvuv7N5WhqLOzUH_mNmA3Cxne8YDZfeMT93qMIOUx..Ph0PQbS
 A9UV2pc5yql6MfxDOsxfiZO9RqtFwXvz09jsQogSbY7VeobucHNFZO6caNLlcRqhdM0jR0uNg0Bt
 84gYzQXOV8zVVGHKRFw6YLTmE8cn2_7pDjgdV3_a_SCYDyqGuZEZ6efCX0q9jBC9kygF7WY_YJn_
 PS0lqeEzVqCnuZqZ1t07IFo6kYRPMLo20qlnDFd1qhwP245z4mtJqxKw39bMkYL6Mq7qw7cJbuiC
 WLxWgHvDq9E7s1FHk1oe.Lt3EXYzF8KJyaAhtQeqXp39g1oQbXDpo0yJnQH9S49KgrE6e_HBgB4Q
 0KH5XfzwoOlJ8UZ38QsxXRZ2H.px45FgQiVouXJDaxgt2vPHWaH3b2llwb0uQ6HAD5DLv7c3z7NO
 Tj7DmULm821.DHOfDzZcE.7V9AgVNd0uo3LCfd6_5S1IRWotVWStZSKQs11CWbN4LeIQhkQlBDyB
 6tCiMLS70TJ57aK4XJy_tgU6Hj7Ie0OtKiGqCT01ZRpNMbJZFR.3ti5Vn3IjCj.becwMKwVMLDQ4
 53W5.fB4EE99KXTbJrRu0gQz_sIwNptFZtg6euyXiHfgNdrNQvXta3cvq.n3UL2iMp2ERcZUTHIF
 s.RIZr83nTytg3v772S6U8n_T6ZWaRg4yyBrjM3IANOzzVNMH4L0yIruUTsFs0Nodi.xjZ7JG2gS
 U5Et10s1SKpsbuAHMo0uQZqjmDCZMGtdvjHPuPoJXGHem3FVmWoUpZk6KiRItHZZXU.v2l2zc64y
 .y7SYbJBgxb3FgJ.PfQU6PEhNpEQ.Q_TT0bT0.80dJoZy0xHZ07JvH9SA_1KLV_aNUx1Vk6AGnel
 plCWW98SrhRVy0DVz6QXMJqH7ePj8HrD0IgT55iZePAVKMr5p37Qa14unnASOLpYoRFlWjD1z_b_
 Adyw.tUZsJaszPJQAJhNtW2X3Mrhe4TtJLf5xWOaK6M4g5VNTe4rVQMwTtFn6a7mULYeLFClVR2X
 n1rxxhAZqMA99RPSnulZGYCsGtpQxi2OqA1MBQ8zjvbcnLwyUF0XWnT_6sJzZqn.QUctGnN_Nnr_
 EoPfOF1F_._5yo6tiU_uAN0Zz5v6uPhOfv05QPAi9qDLZg10pQYuKVtvv4ZWRfvVAs4ZgC84kZug
 HOxS2SBeidu3knd5Mb3.KJ9ZbZHw3FSsb_OwafyO4MShMxvuHVrkq8ifuMU.x_KoYmrLQREhShvL
 G1L7iXp5vUDelvA--
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.ne1.yahoo.com with HTTP; Sat, 3 Jul 2021 22:16:57 +0000
Received: by kubenode550.mail-prod1.omega.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 04e9081b04f56b473dc55d531f87a964;
          Sat, 03 Jul 2021 22:16:53 +0000 (UTC)
Subject: Re: [syzbot] general protection fault in legacy_parse_param
To:     Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+d1e3b1d92d25abf97943@syzkaller.appspotmail.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        selinux@vger.kernel.org, David Howells <dhowells@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
References: <0000000000004e5ec705c6318557@google.com>
 <CACT4Y+YysFa1UzT6zw9GGns69WSFgqrL6P_LjUju6ujcJRTaeA@mail.gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <d11c276d-65a0-5273-d797-1092e1e2692a@schaufler-ca.com>
Date:   Sat, 3 Jul 2021 15:16:51 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CACT4Y+YysFa1UzT6zw9GGns69WSFgqrL6P_LjUju6ujcJRTaeA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Mailer: WebService/1.1.18469 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/2/2021 10:51 PM, Dmitry Vyukov wrote:
> On Sat, Jul 3, 2021 at 7:41 AM syzbot
> <syzbot+d1e3b1d92d25abf97943@syzkaller.appspotmail.com> wrote:
>> Hello,
>>
>> syzbot found the following issue on:
>>
>> HEAD commit:    62fb9874 Linux 5.13
>> git tree:       upstream
>> console output: https://syzkaller.appspot.com/x/log.txt?x=12ffa118300000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=19404adbea015a58
>> dashboard link: https://syzkaller.appspot.com/bug?extid=d1e3b1d92d25abf97943
>> compiler:       Debian clang version 11.0.1-2
>>
>> Unfortunately, I don't have any reproducer for this issue yet.
>>
>> IMPORTANT: if you fix the issue, please add the following tag to the commit:
>> Reported-by: syzbot+d1e3b1d92d25abf97943@syzkaller.appspotmail.com
> +Casey for what looks like a smackfs issue

This is from the new mount infrastructure introduced by
David Howells in November 2018. It makes sense that there
may be a problem in SELinux as well, as the code was introduced
by the same developer at the same time for the same purpose.


>
> The crash was triggered by this test case:
>
> 21:55:33 executing program 1:
> r0 = fsopen(&(0x7f0000000040)='ext3\x00', 0x1)
> fsconfig$FSCONFIG_SET_STRING(r0, 0x1, &(0x7f00000002c0)='smackfsroot',
> &(0x7f0000000300)='default_permissions', 0x0)
>
> And I think the issue is in smack_fs_context_parse_param():
> https://elixir.bootlin.com/linux/latest/source/security/smack/smack_lsm.c#L691
>
> But it seems that selinux_fs_context_parse_param() contains the same issue:
> https://elixir.bootlin.com/linux/latest/source/security/selinux/hooks.c#L2919
> +So selinux maintainers as well.
>
>
>
>> general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] PREEMPT SMP KASAN
>> KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
>> CPU: 0 PID: 20300 Comm: syz-executor.1 Not tainted 5.13.0-syzkaller #0
>> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
>> RIP: 0010:memchr+0x2f/0x70 lib/string.c:1054
>> Code: 41 54 53 48 89 d3 41 89 f7 45 31 f6 49 bc 00 00 00 00 00 fc ff df 0f 1f 44 00 00 48 85 db 74 3b 48 89 fd 48 89 f8 48 c1 e8 03 <42> 0f b6 04 20 84 c0 75 0f 48 ff cb 48 8d 7d 01 44 38 7d 00 75 db
>> RSP: 0018:ffffc90001dafd00 EFLAGS: 00010246
>> RAX: 0000000000000000 RBX: 0000000000000013 RCX: dffffc0000000000
>> RDX: 0000000000000013 RSI: 000000000000002c RDI: 0000000000000000
>> RBP: 0000000000000000 R08: ffffffff81e171bf R09: ffffffff81e16f95
>> R10: 0000000000000002 R11: ffff88807e96b880 R12: dffffc0000000000
>> R13: ffff888020894000 R14: 0000000000000000 R15: 000000000000002c
>> FS:  00007fe01ae27700(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> CR2: 00000000005645a8 CR3: 0000000018afc000 CR4: 00000000001506f0
>> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>> Call Trace:
>>  legacy_parse_param+0x461/0x7e0 fs/fs_context.c:537
>>  vfs_parse_fs_param+0x1e5/0x460 fs/fs_context.c:117
>>  vfs_fsconfig_locked fs/fsopen.c:265 [inline]
>>  __do_sys_fsconfig fs/fsopen.c:439 [inline]
>>  __se_sys_fsconfig+0xba9/0xff0 fs/fsopen.c:314
>>  do_syscall_64+0x3f/0xb0 arch/x86/entry/common.c:47
>>  entry_SYSCALL_64_after_hwframe+0x44/0xae
>> RIP: 0033:0x4665d9
>> Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
>> RSP: 002b:00007fe01ae27188 EFLAGS: 00000246 ORIG_RAX: 00000000000001af
>> RAX: ffffffffffffffda RBX: 000000000056bf80 RCX: 00000000004665d9
>> RDX: 00000000200002c0 RSI: 0000000000000001 RDI: 0000000000000003
>> RBP: 00000000004bfcb9 R08: 0000000000000000 R09: 0000000000000000
>> R10: 0000000020000300 R11: 0000000000000246 R12: 000000000056bf80
>> R13: 00007ffd4bb7c5bf R14: 00007fe01ae27300 R15: 0000000000022000
>> Modules linked in:
>> ---[ end trace 5d7119165725bd63 ]---
>> RIP: 0010:memchr+0x2f/0x70 lib/string.c:1054
>> Code: 41 54 53 48 89 d3 41 89 f7 45 31 f6 49 bc 00 00 00 00 00 fc ff df 0f 1f 44 00 00 48 85 db 74 3b 48 89 fd 48 89 f8 48 c1 e8 03 <42> 0f b6 04 20 84 c0 75 0f 48 ff cb 48 8d 7d 01 44 38 7d 00 75 db
>> RSP: 0018:ffffc90001dafd00 EFLAGS: 00010246
>> RAX: 0000000000000000 RBX: 0000000000000013 RCX: dffffc0000000000
>> RDX: 0000000000000013 RSI: 000000000000002c RDI: 0000000000000000
>> RBP: 0000000000000000 R08: ffffffff81e171bf R09: ffffffff81e16f95
>> R10: 0000000000000002 R11: ffff88807e96b880 R12: dffffc0000000000
>> R13: ffff888020894000 R14: 0000000000000000 R15: 000000000000002c
>> FS:  00007fe01ae27700(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> CR2: 00000000004e4da0 CR3: 0000000018afc000 CR4: 00000000001506e0
>> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>>
>>
>> ---
>> This report is generated by a bot. It may contain errors.
>> See https://goo.gl/tpsmEJ for more information about syzbot.
>> syzbot engineers can be reached at syzkaller@googlegroups.com.
>>
>> syzbot will keep track of this issue. See:
>> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>>
>> --
>> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
>> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
>> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/0000000000004e5ec705c6318557%40google.com.
