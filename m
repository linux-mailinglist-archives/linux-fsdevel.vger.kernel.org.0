Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52B933F9BD3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Aug 2021 17:41:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244479AbhH0PlP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 Aug 2021 11:41:15 -0400
Received: from sonic302-27.consmr.mail.ne1.yahoo.com ([66.163.186.153]:45219
        "EHLO sonic302-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231730AbhH0PlL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 Aug 2021 11:41:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1630078822; bh=RLSfOoMGxQBA/Q+l0oOfjINaN69QHvng+wec1rTGsfk=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject:Reply-To; b=drhmaT+Il9bkZTSb6KEMugJzFitA0vCF8YZZ8gVpoB0qgUvY8itfC9I1pnVsC54TghHyxJXfUQ52xmXnFzzv7MRXakr/Q7AHkD7j3lCewyFK6mpS7ey+VsmF2cmj8ajs3UGzRH0n0byteHLYmrA04n1ELBYEgwPA81qsMKWhe+VRanlAfl7tERN7tfiUhQ6b+OFgBRyj3OYe2kpb4+dFh0IH2CyVpyPZUBFPt2wTF3ev0y0dsHiSf2GrbMx+217ylaO67Toc/EoRp+FtekPl+uMsmC6Ofc3pBq5POnNnlfK+0Lc019JK+J//LSqK9kGxvs0Ky4pmZJEayQtKHMKxyw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1630078822; bh=D94bqPGl7AEF7XOQPgaZF/LHsD5C3S2nS21+M1kW6RT=; h=X-Sonic-MF:Subject:To:From:Date:From:Subject; b=nG2tv0R+UAZLHs0Tg8mEQGx0kzUHARmUbZCYygV1CnulS1gCzsMYwIFPjUw/rxEHUWwB2HZTaVLwfqg0Qb9NiKVe272xJyNJSW5DRAoPi6jS49o/t5oWoLtNRdhxF/5z2ockAJzMy9fikYGMK+yBdQ8e8hR891w04VZe4HL/gI1NVyV8f8Ik5GEHDfjSjplp++XlkOETW7f05OUVDaQjohyWhdn10VPad186SQ9LkaWbZrKR+vQsPErTuyEegrH5fGv/PL6n5E2Maws5xfOPFUzZgz9lgnzSQDtVAF22FtvOqhfiE/eATez1D5FPecAnwQjKb/UNfgqu6P0TCDspkQ==
X-YMail-OSG: QSPKJ_wVM1kftnzMNAAElIqqshKzX.4IMhSyEuu7HoJS8SjfEcn.CvTFAHaeUT7
 wTe06FwKE5j1Dp3AGdwMy_nzuyFFpcfP1SASaYAuJ1XmmqHD.eQ.Dmmle4iJv2nra2nOwA78ZyGY
 Xk6Gg3aRrpEsFd3gu6uOyDeNgMT8DUeaRFA6nZSnav9NgDXtGkwEhx_uExPbvnvMGUbTgoFSlD.h
 0i9N5Z1ObYAyXdGyNWsnbY7V3ZNvTLVhwMVKOnhPS.hxzps6xxLyLSdFbTTiKTbiAnHSjePyeN68
 6VTxOyqGUgUjRpy.UsMmwQ97Ku0jjGQ6t9_.ywT79kFxIle5Q8L7WUFTsxGfxm5U.vOg4svidzjt
 9_kUkKsbvMHulScXzmWYO4L5_fPzws4iVedwBPk5s9pHBzWHjNS0Go4Jil_I6J2UmqCK9AYyFhj7
 zaAUqFQDE3OII4SSV7lZ0k3uP2p3pd7CKum.oHFhiUYVspm3n.HAVfEVCVRIGBisYBXl36cK3g24
 uHjd2wHOM3n401Nj2Fd00RHqYL.RPRUI_RzihuCzN7V7jNdwb7N3ealoBtIHOW6zdyAJxpcH2kbB
 aDioOh9bDptXvMfvWfLECRCxdrzC_zXL5Irncwp4YXm41xqtQ1Sz57tqKtiKfERz3s5Zlz1l4nAW
 Ocpa4N3Lm88NY5n60Mo5Kg5Ip1NefHDwtXdbMgGShvZWgnN2zszBEonHNC1D8nLX3W8HptCbtEpX
 A1wRuNZeIh6O_..jA6QIQdlJV6DL0Enspcv9dCuFQyPi81ycH8aCSOXcycw4Vbstn4dG9DNbyHY3
 BxzNF5zIUwjzVM2gnnmbdWzFLOZ1loQSBEYtotbDcvCGMWISUomDtkGp5eA9gD3sp5RM3OkFPJ89
 abuDroy2OjTaNNn8nhlNrp6ovqxOoouJBji8jpuhYNh6xlhHE_NjoDXG40tNCTRgNrKUKijxu1N1
 F2CI92YacRKhZstVDLoTiw7Q3BgI9xO5o4aocVP8JmRDRzeJRCObapEYaeRYz0KwNXXOOo6t0GiZ
 1OsVdNbEfzyONrK7QVG.vPANAS75Q.OPSCV5wYMsvUWyRIjdtGXWeeMnBdwLnBH0v3XLmUd7Me9D
 GCwmJ1ULKLAn6CEUsZhdpPWw5QoZzGN_3jmePYL0Vuw6wUCPnUYUI_9jw7.EeCs1Hm_cliBrg4Qp
 4.FtB36Kf_rTCprB7dZ4Q2.XaXp_arR6ixohizfyC_f2Beub64p_bVnX5amBygcEKBIh6kcIZsx4
 gkT1v2jCcVQO__X_IBz3ZT_ayyns6oiiFppT2hTDmzaAM7IP0o0PavyIlojYjvDok2sKPVaqFcyw
 9OQ4TmFFG.SrFIqIsct5YT2vUhx5FYntHWAk0b0yzyD26RkTMKcxWj2Tw61jVqoXeakYaEJnSKRC
 I5JM0DpxmgL5Yv6jSCEEsnLcQ36wRGlB4rRBUpkD41sLYJy8HwIL6c5VOkvPaBpA4b1_0oiFEN6V
 61CK.LzqRsidoXzEkQkn_3kqj_OHMD4wR9KwzGLECsbxn5IXhnDH1UOB0tZbhygyA55IAN2W.Veu
 _PZPXhGb0JZojpF7_jQV2.ppmhPa7XAC_DeZC7ionwa0VSiaMsqwU86BwGWGgmMZ2ENK3sW6jCZ2
 AqluulGMKUtLy5DGBSkOi_aEyyaDELqNgIcmlxYpoRbekKU8bDWYbcdOCojhCbVG4kF1VuobEXsJ
 W0fTvr6FpTSA21f3ktNfFu1bhQBNe_pUQ7qbpswbG6fBYrHE.3_lFm8jbOygIeDy5RgGH6gRHiBa
 3jwZWdsftDCcGB2aMrppGf3vQJai_.iCOOSRDTTkjyuqinvYYq4gK4NbdgqS0sDmvrsU8kEQQb_q
 5vMB7b89YfhivsHS4KSjG9few0WeBS9gS9BxYv.yLk1v48IbJYStYsGB0HqZTBMmnsF1V5AFkYey
 _ju6DXpylilZTVywnIOoexFDv9e_VjEzdGj2Z8IuSbiOK55iiGje_akxjNOSmknU6p1sEKHi50jA
 Ew4TG4Gh4vUak6U1XIGca.qZ4PvSaqMNsHf02VDH1rhKt8bo0XunMRxKC9RHai4GjtWJN1esHPm5
 3NI0uNJ3e5OmKsSxBuYHDEi4uQlA.1lgQN6j8k5qPn8IOlNkC7qlAd4SIzG7_L0dbo43DbLurpHf
 I4Oh_d4zLG_mAAGuaMBJWImV0AyFmM5oJzuyYUmBooKSGvQjnJpmuNDKeTR9wA2_7y0omVGhfPKR
 wGs63ltmGQ3xakUeWWUpxKHSYEdd.sS76VyJUe2zM1duu6pgEVBhRuQcvsnMHNwXzsEFlYQLsyhI
 8efkc228AoNGtAI_WrlUi3EGHPVFwiZX9Iy8RvAYuGRzpNO9tB8AxyhcMi5BxPFk-
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.ne1.yahoo.com with HTTP; Fri, 27 Aug 2021 15:40:22 +0000
Received: by kubenode550.mail-prod1.omega.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID c87127f64d5633da122d83ac78847bb5;
          Fri, 27 Aug 2021 15:40:16 +0000 (UTC)
Subject: Re: [syzbot] general protection fault in legacy_parse_param
To:     Christian Brauner <christian.brauner@ubuntu.com>,
        Paul Moore <paul@paul-moore.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+d1e3b1d92d25abf97943@syzkaller.appspotmail.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        selinux@vger.kernel.org, David Howells <dhowells@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk,
        Casey Schaufler <casey@schaufler-ca.com>
References: <0000000000004e5ec705c6318557@google.com>
 <CACT4Y+YysFa1UzT6zw9GGns69WSFgqrL6P_LjUju6ujcJRTaeA@mail.gmail.com>
 <d11c276d-65a0-5273-d797-1092e1e2692a@schaufler-ca.com>
 <CAHC9VhSq88YjA-VGSTKkc4hkc_KOK=mnoAYiX1us6O6U0gFzAQ@mail.gmail.com>
 <CACT4Y+bj4epytaY4hhEx5GF+Z2xcMnS4AEg=JcrTEnWvXWFuGQ@mail.gmail.com>
 <CAHC9VhQLi+1r3BmSeQre+EEtEyvhSmmT-ABLjvzk0J-J9v9URw@mail.gmail.com>
 <20210827153041.z3jundji5usj3afj@wittgenstein>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <cda5e293-869c-8b7b-5da6-892bf901afc7@schaufler-ca.com>
Date:   Fri, 27 Aug 2021 08:40:15 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210827153041.z3jundji5usj3afj@wittgenstein>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Mailer: WebService/1.1.18924 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/27/2021 8:30 AM, Christian Brauner wrote:
> On Tue, Jul 06, 2021 at 08:50:44AM -0400, Paul Moore wrote:
>> On Mon, Jul 5, 2021 at 1:52 AM Dmitry Vyukov <dvyukov@google.com> wrote:
>>> On Sun, Jul 4, 2021 at 4:14 PM Paul Moore <paul@paul-moore.com> wrote:
>>>> On Sat, Jul 3, 2021 at 6:16 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>>>>> On 7/2/2021 10:51 PM, Dmitry Vyukov wrote:
>>>>>> On Sat, Jul 3, 2021 at 7:41 AM syzbot
>>>>>> <syzbot+d1e3b1d92d25abf97943@syzkaller.appspotmail.com> wrote:
>>>>>>> Hello,
>>>>>>>
>>>>>>> syzbot found the following issue on:
>>>>>>>
>>>>>>> HEAD commit:    62fb9874 Linux 5.13
>>>>>>> git tree:       upstream
>>>>>>> console output: https://syzkaller.appspot.com/x/log.txt?x=12ffa118300000
>>>>>>> kernel config:  https://syzkaller.appspot.com/x/.config?x=19404adbea015a58
>>>>>>> dashboard link: https://syzkaller.appspot.com/bug?extid=d1e3b1d92d25abf97943
>>>>>>> compiler:       Debian clang version 11.0.1-2
>>>>>>>
>>>>>>> Unfortunately, I don't have any reproducer for this issue yet.
>>>>>>>
>>>>>>> IMPORTANT: if you fix the issue, please add the following tag to the commit:
>>>>>>> Reported-by: syzbot+d1e3b1d92d25abf97943@syzkaller.appspotmail.com
>>>>>> +Casey for what looks like a smackfs issue
>>>>> This is from the new mount infrastructure introduced by
>>>>> David Howells in November 2018. It makes sense that there
>>>>> may be a problem in SELinux as well, as the code was introduced
>>>>> by the same developer at the same time for the same purpose.
>>>>>
>>>>>> The crash was triggered by this test case:
>>>>>>
>>>>>> 21:55:33 executing program 1:
>>>>>> r0 = fsopen(&(0x7f0000000040)='ext3\x00', 0x1)
>>>>>> fsconfig$FSCONFIG_SET_STRING(r0, 0x1, &(0x7f00000002c0)='smackfsroot',
>>>>>> &(0x7f0000000300)='default_permissions', 0x0)
>>>>>>
>>>>>> And I think the issue is in smack_fs_context_parse_param():
>>>>>> https://elixir.bootlin.com/linux/latest/source/security/smack/smack_lsm.c#L691
>>>>>>
>>>>>> But it seems that selinux_fs_context_parse_param() contains the same issue:
>>>>>> https://elixir.bootlin.com/linux/latest/source/security/selinux/hooks.c#L2919
>>>>>> +So selinux maintainers as well.
>>>>>>
>>>>>>> general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] PREEMPT SMP KASAN
>>>>>>> KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
>>>>>>> CPU: 0 PID: 20300 Comm: syz-executor.1 Not tainted 5.13.0-syzkaller #0
>>>>>>> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
>>>>>>> RIP: 0010:memchr+0x2f/0x70 lib/string.c:1054
>>>>>>> Code: 41 54 53 48 89 d3 41 89 f7 45 31 f6 49 bc 00 00 00 00 00 fc ff df 0f 1f 44 00 00 48 85 db 74 3b 48 89 fd 48 89 f8 48 c1 e8 03 <42> 0f b6 04 20 84 c0 75 0f 48 ff cb 48 8d 7d 01 44 38 7d 00 75 db
>>>>>>> RSP: 0018:ffffc90001dafd00 EFLAGS: 00010246
>>>>>>> RAX: 0000000000000000 RBX: 0000000000000013 RCX: dffffc0000000000
>>>>>>> RDX: 0000000000000013 RSI: 000000000000002c RDI: 0000000000000000
>>>>>>> RBP: 0000000000000000 R08: ffffffff81e171bf R09: ffffffff81e16f95
>>>>>>> R10: 0000000000000002 R11: ffff88807e96b880 R12: dffffc0000000000
>>>>>>> R13: ffff888020894000 R14: 0000000000000000 R15: 000000000000002c
>>>>>>> FS:  00007fe01ae27700(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
>>>>>>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>>>>>> CR2: 00000000005645a8 CR3: 0000000018afc000 CR4: 00000000001506f0
>>>>>>> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>>>>>>> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>>>>>>> Call Trace:
>>>>>>>  legacy_parse_param+0x461/0x7e0 fs/fs_context.c:537
>>>>>>>  vfs_parse_fs_param+0x1e5/0x460 fs/fs_context.c:117
>>>> It's Sunday morning and perhaps my mind is not yet in a "hey, let's
>>>> look at VFS kernel code!" mindset, but I'm not convinced the problem
>>>> is the 'param->string = NULL' assignment in the LSM hooks.  In both
>>>> the case of SELinux and Smack that code ends up returning either a 0
>>>> (Smack) or a 1 (SELinux) - that's a little odd in it's own way, but I
>>>> don't believe it is relevant here - either way these return values are
>>>> not equal to -ENOPARAM so we should end up returning early from
>>>> vfs_parse_fs_param before it calls down into legacy_parse_param():
>>>>
>>>> Taken from https://elixir.bootlin.com/linux/latest/source/fs/fs_context.c#L109 :
>>>>
>>>>   ret = security_fs_context_parse_param(fc, param);
>>>>   if (ret != -ENOPARAM)
>>>>     /* Param belongs to the LSM or is disallowed by the LSM; so
>>>>      * don't pass to the FS.
>>>>      */
>>>>     return ret;
>>>>
>>>>   if (fc->ops->parse_param) {
>>>>     ret = fc->ops->parse_param(fc, param);
>>>>     if (ret != -ENOPARAM)
>>>>       return ret;
>>>>   }
>>> Hi Paul,
>>>
>>> You are right.
>>> I almost connected the dots, but not exactly.
>>> Now that I read more code around, setting "param->string = NULL" in
>>> smack_fs_context_parse_param() looks correct to me (the fs copies and
>>> takes ownership of the string).
>>>
>>> I don't see how the crash happened...
>> FWIW, I poked around a bit too and couldn't see anything obvious
>> either, but I can't pretend to know as much about the VFS layer as the
>> VFS folks.  Hopefully they might have better luck.
> I'm not sure that's right.
> If the smack hook runs first, it will set
>
> param->string = NULL
>
> now the selinux hook runs. But the selinux param hook doesn't end up in
> selinux_add_opt() instead it will fail before
> opt = fs_parse(fc, selinux_fs_parameters, param, &result);
> which will return -ENOPARAM since it's not a selinux option subsequently
> causing the crash.
>
> Does that sound plausible?

No. You can't (currently) have both Smack and SELinux enabled at
the same time. If you're invoking both the Smack hook and the SELinux
hook you're doing somthing way wrong.

>
> Christian
