Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4234249F102
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jan 2022 03:33:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345400AbiA1CdW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Jan 2022 21:33:22 -0500
Received: from sonic304-28.consmr.mail.ne1.yahoo.com ([66.163.191.154]:36890
        "EHLO sonic304-28.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1345399AbiA1CdV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Jan 2022 21:33:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1643337201; bh=/cSZVpIWdwZi1PYpn0lCjvIRXg6J+AV3OaP9ReQtTxs=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=a0FkIa8a8uXgbcHd6UnP6fwhCuMU71fJL7bOCTuxrV19mQ0eZ1S2ckdIqGhSGmfrzl0Q5pMz+OD/kUhmETpaL+5IHYrF3yqWS0b4pZNP9dHjApvGpp4r4v105tUZDKWq22sIuAAL8gawQwxbRRtW13nOC+lFi9BIOgEZT1pJnv7OAc+rWGEwAp6vTTY6W/lI2YDnI7lsFPm2ihBGeaMzQOdt82gqbwD0K122GxD+J6CD/oQr5p6mDdZafTqndFxLa7ZfjaGPCI/3hygSMcArXo2n/ijyR8vIJ6+Pohnfc0iODdElD+m6HSi9REdp9eMZ4x3IzzrRiyhTgI5t8CMifQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1643337201; bh=7qu2IipBoen2f4kj3ctApYify76TCWSFj+VEvI5rf6M=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=NqnmElld4ygf6dTcUzISnkFPWOQb28dRTwQpTREq8u7gZEcX/uN4i9VLbcrUpyF3nN/cWX6AxVHoyeGSkQCC98QGzPm36tRZzH5MnH+8gWFu8ms+9Ka/Vm6NqHp5wGn+wfEqpwI+3VgY78I21YWIHLrgwNEfMg9cQtu7mBUF6+K+4Utbp4wjc000Tn9x+/nYZ3n5S8+3zpd8mlZJfBppQ0Y8snd1B//5PhHGVgTkU7yzVZzzLYyBz/h0b8yyISZv5XM9exVxZiT282c4q1oq3AoJR9Os4RFSBCPSx3kLeju2JWMTbSO0o64JlOXtMG4/JfzfPuxlMMp5ucXoxjVVwA==
X-YMail-OSG: UQi9EawVM1l.ueVdnHhxsBIQkvKue_8wsT1Xrb_FXesh_oXjgqgyOxlD.PDBkWA
 D9QPVh6nzMgtD2.R.nprzs07OM09o4ie3YSgpRUHLC3enOO6_ziD3uU8ld0cHcp9B_ZWXBNn_B6t
 dYa64w2AHzQxmloHmWX9X64CXXtoczmjkQ8ZfbBQWRLuSDlj5JRYGP425ZVxxT1HcU.7AIEQUACt
 F5J5a0NUKl3SyUI9lWdMvdvG4Neu7AbLGXm7mO_MvVG2iQMkp0Uu6bymuLowr29K5UvOtES11WeN
 EfopUDkbFS1l0B0Z6YtuHgzziAa3p7o.cmeVGp8FH.pkyPSCP38jsX720XoWbvVr4mapfFb7CBn0
 SPO8ujCAfxcW2LKzB.a8AY9J_7fuliFvjuG8nGGPWIM488wjZ0YcpxsgDk_PzhjRhjfnTTUdze9R
 K1hOkbIRF2DkgQr1AnF1lA3pVbTSFtEtI6p_VdeDrQdigB.JKC34x44HTCBHtPGtGe4o7q9KiAdr
 4chbXJRz82xAWDuqy6yonFBEgNHA2P6ZHtAyOJ1Nv2tzAXjfsSZa0w3yHCTKs3GIfh7ExrWZ7JW.
 DCDpQHNvjiVMwRMd8MbKDrTGRP3LWjnv.1D9ngckvJ.i3lyz_B7qPiPwMoLEDPhxfdlx2MFUOtJ3
 pLiVSjntoaL_jGOYOivkhiN8LbDwfF_f6FGcw_2uod02KoHVErBlvGk.2mCFLONYVcSxq8kJBBQQ
 IaAJnuC2TKAnDfPo66bMrfhOA2smiyxSBslcPcVfgzyoyMh_YpSP_wvrAPWMyDWaZSQpzkVfR2wU
 mLv.rCgDqTvVYaNYWqxgWKPMvyfC_TaAQab96f7Mla7B8T6K2dNjnk1rk.Kv7KT5ws3O6ComDWU6
 0aVHCM2QRxTqz0bPzV4LGEgEbNWdfCbyrt_Xo76uL62WqNJSP3ctjxxGwpNu5agAo7XJ.3mNOu1B
 CHn6PqaChm2_pjSPpWkhZ__0VCiHAMfjSn3KAF9og5n11k79Z1jAPPtJ5FIFjtxJ6z50uARLXk2G
 Y47YWMXsCYbchj_y1Szefje.Rk6yr9Ml8dmn.PH5v3UcECmBobieSvLaaLTZlLkNjgFPpmw90nAb
 lL2k5ONOPmL.Ym3GLObNNMrqaUNOI_MDkHYWF2hv52MNf.hSnW4aL6nTWjKDaB2HeTHmP7WJYDMX
 DxCfXMdlTHHWtMoQS3isN8VZP0mEY.Xt7vpp08er2._72FSsRqQJE6.6APfnrOkMceJjqz6pVhHV
 lZwLIGm8.JN3r2F0FMkXv3qF6c2K3jdxC2f4E0vBzo07J8L26blaj18hvFeAMuKttfdT73Kvhiq6
 x3sjM0cpyE7iJWb4wjyEQQatuzkgBoz0DbgKE7GiLmyq3DzDogZZZE38GiPim9MWl4JUhRfYjY2a
 Mv67x.gtplNy03hG23FiBPSInrn2Om0nBJfq17o7waO1ImNORI4rry5Se5uwd43KTW7bD.vf1G2T
 urHPlLBW0HnG6mZ0eA6JHyo0j2_tfw52dqrjUCscks9dCY0bc3jvzzmoYVvaGBl726rSyOrC06aA
 qB1U6a6ffPjyU_dQQHO7ko5uhBj29wtfZgc78vKIYK51Dik87rqNGJOkaJyore7dFam51d33n2rh
 wtfJlQPiH.3DR5_kUBuZY_GFGU_Zch6QFIsO4jd9NnpaxHdL_hnnwcmlvRvin5eB_jbMK9fTbX98
 g6Op_Or8d7eV6SM5FEHsCn80cPyTPPX_8y88mzYz5ofZn9LH7.0o.1VzBXohR.qXd.owNiBJScoU
 _EWMMFNSXLHLF03.Yk_X8cNEQN6hiSDlG6IlBp5kFq1w_9S86qkukCtt2CvuwxIJalcyLsijlEDa
 h3TRJXpc.DjSpVRaZs1OTcpnh0aIzmcW7D9NnT5385NC4Lfjf5Aa2R7oLMMTCuC6_xK2oQD3W_1S
 RyG2gGhCYX_DVgR.8Sb4uaAIKVXkPjRmmCc0bflUSvTgVPF4FxFaq9s_CiAbxhM8dgwR_0fKRwyY
 H.ED7G4DB50pHV_QwtzUtuRo4ZYISVR5ObFwkMsbj6.9sLyEL52DrsgyCRJd1D1OEaj83ga2_c8j
 ZQkLUuzkH7DNT0Bw.dZAPVfyH7qFdOjCEM9igOTesRX4uhu4xam5MgRbwnetix5xpzBN_2nKq8Yv
 Iic11zJaIv6M0n.UNzOOL78C_FGWKr74CUCa0Y54JKQGoRq.8NRFl2o0TYKASw3mryGQz_Wibn5J
 Fs3jzyBotT5nfrsI.fkq.Us_NWscm9trnrjXXUI8qh0jz5eMr
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.ne1.yahoo.com with HTTP; Fri, 28 Jan 2022 02:33:21 +0000
Received: by kubenode543.mail-prod1.omega.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 0491eab8b495d3df7698922337278a6a;
          Fri, 28 Jan 2022 02:33:19 +0000 (UTC)
Message-ID: <4405992a-8fad-f95a-b01b-f7a9412dd57f@schaufler-ca.com>
Date:   Thu, 27 Jan 2022 18:33:18 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2] LSM: general protection fault in legacy_parse_param
Content-Language: en-US
To:     Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        Christian Brauner <christian@brauner.io>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzbot <syzbot+d1e3b1d92d25abf97943@syzkaller.appspotmail.com>,
        David Howells <dhowells@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        selinux@vger.kernel.org, Casey Schaufler <casey@schaufler-ca.com>
References: <018a9bb4-accb-c19a-5b0a-fde22f4bc822.ref@schaufler-ca.com>
 <018a9bb4-accb-c19a-5b0a-fde22f4bc822@schaufler-ca.com>
 <20211012103243.xumzerhvhklqrovj@wittgenstein>
 <d15f9647-f67e-2d61-d7bd-c364f4288287@schaufler-ca.com>
 <CAHC9VhT=dZbWzhst0hMLo0n7=UzWC5OYTMY=0x=LZ97HwG0UsA@mail.gmail.com>
 <a19e0338-5240-4a6d-aecf-145539aecbce@schaufler-ca.com>
 <3daaf037-2e67-e939-805f-57a61d67f7b8@namei.org>
 <CAHC9VhSt+c6QksHef=kx3dN_ouVZG0_a6FERzXs2-uzKmyE_zg@mail.gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <CAHC9VhSt+c6QksHef=kx3dN_ouVZG0_a6FERzXs2-uzKmyE_zg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.19615 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 1/27/2022 5:44 PM, Paul Moore wrote:
> On Thu, Jan 27, 2022 at 12:46 PM James Morris <jmorris@namei.org> wrote:
>> On Thu, 27 Jan 2022, Casey Schaufler wrote:
>>
>>> The usual LSM hook "bail on fail" scheme doesn't work for cases where
>>> a security module may return an error code indicating that it does not
>>> recognize an input.  In this particular case Smack sees a mount option
>>> that it recognizes, and returns 0. A call to a BPF hook follows, which
>>> returns -ENOPARAM, which confuses the caller because Smack has processed
>>> its data.
>>>
>>> The SELinux hook incorrectly returns 1 on success. There was a time
>>> when this was correct, however the current expectation is that it
>>> return 0 on success. This is repaired.
>>>
>>> Reported-by: syzbot+d1e3b1d92d25abf97943@syzkaller.appspotmail.com
>>> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
>>
>> Acked-by: James Morris <jamorris@linux.microsoft.com>
> Looks good to me too, thanks Casey.  Since James' already ACK'd it, I
> went ahead and pulled this into selinux/next.

Works for me. It was either James' tree or the SELinux tree.
Going through the security tree may have made more sense because
the original problem was reported against Smack, but that tree
isn't very active.

>
>>> ---
>>>   security/security.c      | 17 +++++++++++++++--
>>>   security/selinux/hooks.c |  5 ++---
>>>   2 files changed, 17 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/security/security.c b/security/security.c
>>> index 3d4eb474f35b..e649c8691be2 100644
>>> --- a/security/security.c
>>> +++ b/security/security.c
>>> @@ -884,9 +884,22 @@ int security_fs_context_dup(struct fs_context *fc, struct
>>> fs_context *src_fc)
>>>        return call_int_hook(fs_context_dup, 0, fc, src_fc);
>>>   }
>>>
>>> -int security_fs_context_parse_param(struct fs_context *fc, struct
>>> fs_parameter *param)
>>> +int security_fs_context_parse_param(struct fs_context *fc,
>>> +                                 struct fs_parameter *param)
>>>   {
>>> -     return call_int_hook(fs_context_parse_param, -ENOPARAM, fc, param);
>>> +     struct security_hook_list *hp;
>>> +     int trc;
>>> +     int rc = -ENOPARAM;
>>> +
>>> +     hlist_for_each_entry(hp, &security_hook_heads.fs_context_parse_param,
>>> +                          list) {
>>> +             trc = hp->hook.fs_context_parse_param(fc, param);
>>> +             if (trc == 0)
>>> +                     rc = 0;
>>> +             else if (trc != -ENOPARAM)
>>> +                     return trc;
>>> +     }
>>> +     return rc;
>>>   }
>>>
>>>   int security_sb_alloc(struct super_block *sb)
>>> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
>>> index 5b6895e4fc29..371f67a37f9a 100644
>>> --- a/security/selinux/hooks.c
>>> +++ b/security/selinux/hooks.c
>>> @@ -2860,10 +2860,9 @@ static int selinux_fs_context_parse_param(struct
>>> fs_context *fc,
>>>                return opt;
>>>
>>>        rc = selinux_add_opt(opt, param->string, &fc->security);
>>> -     if (!rc) {
>>> +     if (!rc)
>>>                param->string = NULL;
>>> -             rc = 1;
>>> -     }
>>> +
>>>        return rc;
>>>   }
