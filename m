Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C70049BF89
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jan 2022 00:30:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234804AbiAYXa4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Jan 2022 18:30:56 -0500
Received: from sonic311-31.consmr.mail.gq1.yahoo.com ([98.137.65.212]:36836
        "EHLO sonic311-31.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234786AbiAYXa4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Jan 2022 18:30:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1643153455; bh=mt6Os+ex4HboKOjnfePGdHm2CnPL/fPe6MAxUKfF64Q=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=dGzwJodPMtm44gNB4cDbonvaKbj4SBWUb9wLWYZYbZzHZLmWidGxuwVVe3WqXUT4iZC5db+x5dPtqNjoDau1dPciKyxM84a6l8eiZkMS+TnRf933uh6kNIYccRUBJHjMUJpE7F45z88DfvFOrwzwuR8I7COxWYHurTTR4QYgtF06kolFeWQqltSt5My2GR1EpsPaJSxiMCEdXplWeLwiYLb453y671O1njAjBWT9F5ncYlsYm6h3Qi2zWKA/LhJtJylinmOYVbjk5K2P6dx2f7N/MuWUmD3+oACm4uVaSMNACm/386NoFT86YhHDW769wfQOwOLhuONt4Lwgm9DScA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1643153455; bh=UdJ0JcLgiLPdMSXpXH4pnCUt4MmgDAVYpj0NlvG3Q44=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=YmhM/uICU08Wi2gr6LFyi4XK+9/Ld9p4fCzYpdUwMgdWvj/doqA/AZMt318R+epKEGoZgllXhPPF3TtmRKdOZRpcWLW6pUJa/EySoQiUf/hlnmZPdW+aL8GjmA8PNRp0LSDFJGUoJwBPMBwmoGdJ5kkCcUES5fr3iLdsIF/NeKpnucpx2T9o69RL81469VKJblExnPdVdJUENrNX5rNKqkt16V/OOlDUwoYbSO4li/+J1ha0EHEvAUp1hKqCgh9pS9qN6Q2berm09WAHFYxX/97QQUoUtdsJbLXBmKzk53cwmXXGnRXB8/6anJhFS4LO4LKwybexzYx/WapGAsrNEg==
X-YMail-OSG: 2TiCowMVM1lVhEyaNbwk8Qbw02JdaAoeeX5RvPqTX9C2MCpaECm9AEKur2sFz4S
 ny9OZbsCsn6_ME3Gy5wjPIFtKkarwraMgOvW.9AmHM_sx2BRWyU.qYHhE3WjBy9UZ7Du_pNU2PM2
 IP8NCROn0ZDWHfVVRUfKIbep5GJ9wU.iWoOt00.IWOSgUPsC2M88dEK_iMo14TsAXyOFcE5xk4.N
 VrG5v_QoSEYBNqcyBwINYcSOXLc0nrimFLDgXYU8J3GMKHJPN4jUQ4LIw0VHOHfB5BwwUCYX1kvV
 qrhv3uHGOwzzjChGJDeds4Rhn5F29dWxCznOZbPQ2BCNZZhi2jX3.raAcD0R1FXJYA5MkREZyI1k
 Ymgr_CDx3XyceexDznhQHyPJrwUUSVs2SmJFErWX5vVnAi6haC8lNMBr0E_Mz5MdqO4mznRgar6R
 3spUGaguouGkFq43IoOtlSAqn7r4GxzaE_sOoa_11R_UH1EmTaPLq2jrQgLxLJ7TjH7mRriqExpf
 rxBcekZypRIVi6LITE87xBoUvjKGQMyI6WlZh_JhIJZovzpBwfsLZOs2Y7y4O8Dxpwi8ytvYEcu7
 imJ0vMvhH46epMqvDHVP0dOzFosdEgptJj352YE0iGQPLK8gqcRbkjYDOlN48UDL.QvTUg2UR.sA
 Odu0HiManz8i_WuoDJqDPE6xooYIJwq88iCxW8md2TIcQ4flc7lbYsfg6tDuacKVXVrMLiufCkUu
 mv3rD3.oADwN.g0ISorA9JJpUJM4bJNjsZww6NK2Q1r9rk8wELjswJi2XjHVABC2mbGNAWuPLUKp
 04vUWqHV8ueoZC99v9skqayPsL61.dnPM46HgynE_mxFecyKfV5FHLzqxWA8h1GCHTj320ky6eTP
 ClWc9RsVlxz1RDJKd.i.eLVjIOAZ8TcvMqRMvDKuURpHVuT5kwvxLiDQoEYEpgY9yfszlTf_.TAP
 .1r9AnM1YSH8VYNLkfMT3fx85A4HObmvBl.7C3k3SfKgXZ_v9ozV0mzpiOu3EbMMl_wF2TRL4VAk
 hj4p_Ro3l0dcbSlkSDMeRDH7GuiJ8oUZ2zk2KdJV9pfz8yaPvycojQP9OYU1SAmpfh0W8KR2K8ha
 ZXEftOL2z4Jnf3tY_VucRErX7i84iJUa4jEXw3Dt8NA._KFN9N00ShWlndceQ_.ZNStYtndt8GTo
 oY9zBopUpeg8YlzjHyOXMzVxgrYHj5Q8hNyofqU.xyx3Xg4bkTsokH2DGTZk5amzh30p8ZCmC_KG
 .fZObfFGVBGe8dJIukhVtzDVOQWVREkKUPC5Ke9X0RqpGGZrgwhLrWup6gdAhQnWeVYKU8fBtJWa
 ITtP3TOZVnQlQgRCpDC8OING74R2LXgxkWt7A03bMa_6cyWsSy8jF258RX.3gNxtyaF.hAynUQit
 XpxQV51dP9CzNgnpCS_3Gr7oSwV6sMx.7R5Wyz_4QW5y1CbMQ9aNbxopfTMKER05BUoyfkrZGAGK
 rzjp.f.jGT9yms5uXiAQksJ1kxXbqhaX_n0epTCUSqAJ.Y51Q40ITj3NMrgkRa4kwvxomeE5.4bD
 bBkME_m0ncfAkbx2RGc_Q9VA_D0SClVD4Dtuw7bLQYIitXmrJC9VNyDgveqRP25N0ynonNhBxl3M
 II_Z8rJwrxyxSVDBRcV4OwNzGhyT8Nb_L7.mOJXkYULtMJcrxEgci5vcDVoeInVRyQ2qiVJ.r4MH
 av7d01w3tDD3r_JOB.0jjKZ2FzOtlOkGoKYH1ZQCRsoVfHVW8p8Fk.0ejQP.MOoW4riW6Yv2FyYL
 cTSKGB69aZ3NOrn9CJ5KyaJUkY7cerjGUG5nA9BWA8QFQAXJEAe6.B_5kOSphK2834C2U2mEn17g
 sMjPJXHpPIW6o9GclbUj.loC6LMUgfVMicwn4RMFtaUvueFzfSeqfe45na4wi7jgcNAQfzKtQYkw
 VLzWASFGUiVm3jBFuOlieC01M6yUV2ENoLAlZ9GbdB..F5YATryNm2b6dwS218FnDkbqC3NREjF3
 12quZP1PZTB7.wpKoT8LS8vcontJi1lxpkU1sd0W6kF5QndxFr0tMzsMxINBGyhyk3W.xvZ9BCUH
 f9B_5U1Qk1mnUUKdwXBXPil9SveX7dQW5WfMBb8bEv09J012xJlLkqA28b7AjlrlKT4tAJHOpYMW
 ESeF59F.uFteAm5zYx5Bh2vTKAc0V2lnmM718EzJoG7i.e8ipiLRsHUNKrSPPei75qINfi.T9pqr
 GoQQq.U_yxBnRs6Km.41SMVuGwCLZQNpgBZOlSsYcJ4.qFSg5zioIwNrATus9QRi20DpgXV0I3TC
 7D2.PHop4tQ--
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.gq1.yahoo.com with HTTP; Tue, 25 Jan 2022 23:30:55 +0000
Received: by kubenode519.mail-prod1.omega.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 19f85b4be17a885447dad55a3f641d0b;
          Tue, 25 Jan 2022 23:30:49 +0000 (UTC)
Message-ID: <e046ab1e-0e59-afb2-ae28-fafa17ea8ddd@schaufler-ca.com>
Date:   Tue, 25 Jan 2022 15:30:48 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] LSM: general protection fault in legacy_parse_param
Content-Language: en-US
To:     Paul Moore <paul@paul-moore.com>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        Christian Brauner <christian@brauner.io>,
        James Morris <jmorris@namei.org>,
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
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <CAHC9VhT=dZbWzhst0hMLo0n7=UzWC5OYTMY=0x=LZ97HwG0UsA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.19615 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 1/25/2022 2:18 PM, Paul Moore wrote:
> On Tue, Oct 12, 2021 at 10:27 AM Casey Schaufler <casey@schaufler-ca.com> wrote:
>> On 10/12/2021 3:32 AM, Christian Brauner wrote:
>>> On Mon, Oct 11, 2021 at 03:40:22PM -0700, Casey Schaufler wrote:
>>>> The usual LSM hook "bail on fail" scheme doesn't work for cases where
>>>> a security module may return an error code indicating that it does not
>>>> recognize an input.  In this particular case Smack sees a mount option
>>>> that it recognizes, and returns 0. A call to a BPF hook follows, which
>>>> returns -ENOPARAM, which confuses the caller because Smack has processed
>>>> its data.
>>>>
>>>> Reported-by: syzbot+d1e3b1d92d25abf97943@syzkaller.appspotmail.com
>>>> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
>>>> ---
>>> Thanks!
>>> Note, I think that we still have the SELinux issue we discussed in the
>>> other thread:
>>>
>>>        rc = selinux_add_opt(opt, param->string, &fc->security);
>>>        if (!rc) {
>>>                param->string = NULL;
>>>                rc = 1;
>>>        }
>>>
>>> SELinux returns 1 not the expected 0. Not sure if that got fixed or is
>>> queued-up for -next. In any case, this here seems correct independent of
>>> that:
>> The aforementioned SELinux change depends on this patch. As the SELinux
>> code is today it blocks the problem seen with Smack, but introduces a
>> different issue. It prevents the BPF hook from being called.
>>
>> So the question becomes whether the SELinux change should be included
>> here, or done separately. Without the security_fs_context_parse_param()
>> change the selinux_fs_context_parse_param() change results in messy
>> failures for SELinux mounts.
> FWIW, this patch looks good to me, so:
>
> Acked-by: Paul Moore <paul@paul-moore.com>
>
> ... and with respect to the SELinux hook implementation returning 1 on
> success, I don't have a good answer and looking through my inbox I see
> David Howells hasn't responded either.  I see nothing in the original
> commit explaining why, so I'm going to say let's just change it to
> zero and be done with it; the good news is that if we do it now we've
> got almost a full cycle in linux-next to see what falls apart.  As far
> as the question of one vs two patches, it might be good to put both
> changes into a single patch just so that folks who do backports don't
> accidentally skip one and create a bad kernel build.  Casey, did you
> want to respin this patch or would you prefer me to submit another
> version?

I can create a single patch. I tried the combination on Fedora
and it worked just fine. I'll rebase and resend.

>
>>> Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
>>>
>>>>   security/security.c | 14 +++++++++++++-
>>>>   1 file changed, 13 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/security/security.c b/security/security.c
>>>> index 09533cbb7221..3cf0faaf1c5b 100644
>>>> --- a/security/security.c
>>>> +++ b/security/security.c
>>>> @@ -885,7 +885,19 @@ int security_fs_context_dup(struct fs_context *fc, struct fs_context *src_fc)
>>>>
>>>>   int security_fs_context_parse_param(struct fs_context *fc, struct fs_parameter *param)
>>>>   {
>>>> -    return call_int_hook(fs_context_parse_param, -ENOPARAM, fc, param);
>>>> +    struct security_hook_list *hp;
>>>> +    int trc;
>>>> +    int rc = -ENOPARAM;
>>>> +
>>>> +    hlist_for_each_entry(hp, &security_hook_heads.fs_context_parse_param,
>>>> +                         list) {
>>>> +            trc = hp->hook.fs_context_parse_param(fc, param);
>>>> +            if (trc == 0)
>>>> +                    rc = 0;
>>>> +            else if (trc != -ENOPARAM)
>>>> +                    return trc;
>>>> +    }
>>>> +    return rc;
>>>>   }
