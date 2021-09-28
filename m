Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2056941B20F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Sep 2021 16:25:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241216AbhI1O1Y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Sep 2021 10:27:24 -0400
Received: from sonic310-30.consmr.mail.ne1.yahoo.com ([66.163.186.211]:41693
        "EHLO sonic310-30.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241152AbhI1O1X (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Sep 2021 10:27:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1632839144; bh=3m+5YFeTr/P2Yd9ZVGrp4OTy/jiuyCH8wAFtywnm0k0=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject:Reply-To; b=e1nDsMh2wotuj1b5Mf0KEpKlQTaHvLycQs/lbWL2/t4eh36JI+GOqWEfGh5qIBFuzWrLhXhAuSI5QQOj1OViN34wzXf9bXumvBIHKOnmZw+wdhSoPGa7OEyB/Vp0LaMeJG+USF7i6VWIXi+mb2S/CvbuWmgIwpabiJ3YRKJawcG4OJ0BcWbv/UMcpAeApg4n684UJhiILziVoq4Ub1MOa/Nfcvgtr2ul6Ap0LM1+fujeeG4VT190Q+McUJWR9BluyU+vtEtekOz2SifWPExhC6+H8/n9WMtobzFRu5DzjRFIsIJL+iTc6vtJa7KqdVwI8HJKEqtQ+UuVOx5LSHNZhw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1632839144; bh=kV/d2P/kfs2Sioq+a4XvD9sBOfFUeGOZkHZnD74FX/S=; h=X-Sonic-MF:Subject:To:From:Date:From:Subject; b=HqAgb431AZTwb7yNHNodUKMHE/tacV/TybC9UdYi81gytg9/3vHZOO8amzT8v27HTT2AdX5BNOu26UyMqC2+yymPbwr5zN/hFAt6OMnNGDz0rP/Hbtrn+Q3apqMXP30KbfBTxqvBI0tJko2Buq01p9RKbamxkMiJ6Yx5xpXCQi80y/fZdnmDCEvseAd+B7/dC9Ui+6kRyiXYSk0CjJltWgZ3kI55eWmQjI+0WcyEr62F4HXOc6aHIbSMSsWmM+gl2zwdpMZzZU2fBbMQhZdbRwJtpl0+ZPx/AzPTLmkJ/t8LPvjKUqejFy3c9+din15yrpAGUywGjKxPJjxqqWUlog==
X-YMail-OSG: qYpV.6gVM1kpQJflnUBAqkyQlAc19N9BWcer0FacVk2VKgxpOb4u48SBl7PcTHl
 kMyIu_AdLBCvxJkPCerhD7AV9oCtSh3cmA_7mYKCNjPN.zfwWsvWUematFgQ58aELQe3BFxbEdPt
 pY.VB8.f0HUzTOCpfHWa6z65iZM90oVV56sppxWpKzvFnQKeiAvuNEKBSxF3HoScDo8EX5rnbenr
 qmm1wl2fxchP05zIK6.RD6i9bNgCn.6D708rhf.lxZTIoxTMUs8LC.UNXOTHRKJNVW3JbNTDJH_g
 z5EYNxpxo0XkRmiIoQ2VWWa8Kzl_bf.tz5nh44d4KVJUB_nkI98uYxbMr5btn1Atw985KzPnz0sZ
 .zqdeKHPGEcnppiAnQ5xdZ0hU2zKj_i9t1CGZiAdUN0FPB3MggrwcivySKBMGaMSQJXnyRPVQF2y
 dncEp1CVbtftuMaKA0NNvDiwav1W9D4QKGIyoQZ06nH5dFbhnIAIEJG6Nbn76Q_Wu80AR7UWy_La
 0aBXp_pbUht6SqlvI6xqmLAqynKcLeiSc9sVWwJsXP_Q8C3YfXtQ6_jhnsPF24S29jL8S3Ka_qv.
 eOeQZ._d0s5Ee_TAU2VmNHU1pgV_BEoEY.79R_z5Z2vUlrNeDr31isruszuu2P3e_MsU_cENgPUm
 LhNsRX3CBEMbJZdJAbIri9FpSBt3wxpbbvPkj6LDauTV3XKrLF86VriSm.o7gCpOIWb4X4VMO1c3
 xbudtm5fKQhT55lckBwwj3NRHq7u8ROAaQ.6L_ofbYNn1vD1dgWYJV46v6P7QMa1GpaSJkn1nBlL
 U2ADf0GGT.umicJFlE2skRK_.yQBCNEAeCk8T5cf2gOjm9h.GCXDIeVI7q2eq.18sxjt.ovA3trz
 VghXztMa9SLiKNQwGj53Nlx5lV3CyEID64nMTrgvDgCE7hPpOWMqnaG4WmMY4Zyk5_gmDd2dniMH
 .Z7n4CFuC9ZrmmP3KyrWCvwj74Zh4Hk4nuCI4l6J4ofks4Isbxt8ellNQrkqxbz3qBWoAlcsfcQY
 f5eWX9WvE6yWqGeG7mAulbSDPMQFtKPCMCEISPtZIVA6dTa48FxzMBcTkRwNk0AvI.stGhxximiw
 oNhpVhfUbIlIzau_orRNR9wDxpiqilORXwMtF9FMSBDgdlGZjgAPt9fkQY0q9BYoi_Pe7GestPjK
 dac4tY2I6q2tdX1Z5YpLpJQ26L.uwBrc6iaqzEb0raFm.aaDGb1py3N61l7UGyPzFbAU.4D6eXQF
 et8DTngvLWfYaxig2YK6tIOa8yvEPPSXPFFmHd6vFBkd8NahA6OVYdOJ377AY_nz82WPMmotq6TJ
 oVtWaJcmgZhYUoWNX_SxoKq8rE0N6Im5hiJCjZFDrMdKWM.HU7P2G2QTLftlw.8XEWpy_O83nGSh
 _MrUp0UVYBM42DAFIUXKx_eIccq2jFYoGuRGmkDOsgxk5TEF5zUqRwP0uQhERlwgjUy9iu_yv23S
 VwAtuZR0SxCpukXcej_Lg8n.pgrijQOFcJG3cend1f.bGdeXG4VCK3P47iNBjlaAOGDgDysVvsw_
 AO_mrZzZcpGgLvAcqm8wfUFuNsEsajrygECdYN.6l9d237ZnEVGCxLQLS.5SXb_dd0OhZpGum9Ze
 7HJUHW3Td4dJN5wg.2FRtKgYIS3.i.Z8Dnq6kQXmQVsQZN3VUwiC5ZblCuRwobAsOh3pjHUN8NtJ
 Jx0S_znCRMhzzmuICKfRCDWRwc9I0zwnwu7Q6sFZhDrd9eEj7I3HGCiMveqgbgXcVqeKG768gI32
 9Ux8nihV.dCmhGBCn.Ooy6J9cjhJamzDNOWBfyWb7alqajojT8SQ.wbcSInxX.OfR6xG5TP5Bbcz
 m3wTCBXsw3rOleyxwH3PXHbRvgICvrmAzFcG36ZwCkhuMgduXdB4orvMwF3t5F1J5FrhWoJ3EcUx
 dNxkd_ko_BSbsKX5wLqCRaHfEfhSkjEasBIc7FKn93DuGFMbe7pUPk0vhRRFxC7wPioBsJlEC2QJ
 kmSgY6WIzJRrYvhBWazge4v3_5VRRKdzvVSu_wt92eCUbMKa88vtPM06BSvrZSn2_S5.w3RzDpDF
 k.rHYw8DwkdDlhCpS8H3Pc8CU6rtuEJKINyoxxd9JKMZSNaCk3GQ21FIa1bSmw3t7yYCIhgUIWxK
 SjUzfNUf4k8FBoEK6w5ShijXf5lDeDhGeSYjT9rkdCeLHk3LShxTvDGK1xiUJQFSw5FVzi9Rk1nK
 MZCz_mxqu0VjrSxZcmrGGHZlJYhIdjQkcONbcUvtSBm7Wy0.Jsc6fI.JrvK4JCY1nJEFDrmn844H
 QwbDYSygB9g37N.ddH59976IwVVejy.ZjuLqU.BJKQFy80cA8a.nIkT74wUjRgA--
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.ne1.yahoo.com with HTTP; Tue, 28 Sep 2021 14:25:44 +0000
Received: by kubenode585.mail-prod1.omega.bf1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 05112cb5103ee75c0d2c47af794d4c10;
          Tue, 28 Sep 2021 14:25:39 +0000 (UTC)
Subject: Re: [PATCH 2/2] fuse: Send security context of inode on file creation
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     Colin Walters <walters@verbum.org>, linux-fsdevel@vger.kernel.org,
        virtio-fs@redhat.com, selinux@vger.kernel.org,
        LSM List <linux-security-module@vger.kernel.org>,
        chirantan@chromium.org, Miklos Szeredi <miklos@szeredi.hu>,
        stephen.smalley.work@gmail.com, Daniel J Walsh <dwalsh@redhat.com>,
        Casey Schaufler <casey@schaufler-ca.com>
References: <YU5gF9xDhj4g+0Oe@redhat.com>
 <8a46efbf-354c-db20-c24a-ee73d9bbe9d6@schaufler-ca.com>
 <YVHPxYRnZvs/dH7N@redhat.com>
 <753b1417-3a9c-3129-1225-ca68583acc32@schaufler-ca.com>
 <YVHpxiguEsjIHTjJ@redhat.com>
 <67e49606-f365-fded-6572-b8c637af01c5@schaufler-ca.com>
 <YVIZfHhS4X+5BNCS@redhat.com>
 <2e00fbff-b868-3a4f-ecc4-e5f1945834b8@schaufler-ca.com>
 <YVItb/GctH7PpL0f@redhat.com>
 <5d6230dc-bba5-a5c1-2c54-da5e6ecfbf2e@schaufler-ca.com>
 <YVMPYIKL2aUBIasK@redhat.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <0e17dcc8-1d81-7a8d-b5f0-82d91cd2a572@schaufler-ca.com>
Date:   Tue, 28 Sep 2021 07:25:37 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YVMPYIKL2aUBIasK@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Mailer: WebService/1.1.19076 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/28/2021 5:49 AM, Vivek Goyal wrote:
> On Mon, Sep 27, 2021 at 02:45:13PM -0700, Casey Schaufler wrote:
> [..]
>>>>> I see that NFS and ceph are supporting single security label at
>>>>> the time of file creation and I added support for the same for
>>>>> fuse.
>>>> NFS took that course because the IETF refused for a very long time
>>>> to accept a name+value pair in the protocol. The implementation
>>>> was a compromise.
>>>>
>>>>> You seem to want to have capability to send multiple "name,value,le=
n"
>>>>> tuples so that you can support multiple xattrs/labels down the
>>>>> line.
>>>> No, so I can do it now. Smack keeps multiple xattrs on filesystem ob=
jects.
>>>> 	security.SMACK64		- the "security label"
>>>> 	security.SMACK64EXEC		- the Smack label to run the program with
>>>> 	security.SMACK64TRANSMUTE	- controls labeling on files created
>>>>
>>>> There has been discussion about using additional attributes for thin=
gs
>>>> like socket labeling.
>>>>
>>>> This isn't hypothetical. It's real today.=20
>>> It is real from SMACK point of view but it is not real from=20
>>> security_dentry_init_security() hook point of view. What's equivalent=

>>> of that hook to support SMACK and multiple labels?
>> When multiple security modules support this hook they will
>> each get called. So where today security_dentry_init_security()
>> calls selinux_dentry_init_security(), in the future it will
>> also call any other <lsm>_dentry_init_security() hook that
>> is registered. No LSM infrastructure change required.
> I don't think security_dentry_init_security() can handle multiple
> security labels without change.
>
> int security_dentry_init_security(struct dentry *dentry, int mode,
>                                         const struct qstr *name, void *=
*ctx,
>                                         u32 *ctxlen)
> {
>         return call_int_hook(dentry_init_security, -EOPNOTSUPP, dentry,=
 mode,
>                                 name, ctx, ctxlen);
> }
>
> It can reutrn only one security context. So most likely you will have
> to add another hook to return multiple security context and slowly
> deprecate this one.

That hasn't been the approach to date. Have a look at the stacking patche=
s
I've been posting to see how the "interface_lsm" is being used.

> IOW, as of today security_dentry_init_security() can't return multiple
> security labels. In fact it does not even tell the caller what's the
> name of the xattr. So caller has no idea if this security label came
> from SELinux or some other LSM. So for all practical purposes this
> is a hook for getting SELinux label and does not scale to support
> other LSMs.

Yup. This is a case, like yours, where the developer from SELinux
could have created a general interface but instead decided that
it wasn't worth the bother. As a result I have to fix it for the
general case. Well, SELinux/RedHat doesn't care about stacking,
so I guess that's the way it goes.


>>>>> Even if I do that, I am not sure what to do with those xattrs at
>>>>> the other end. I am using /proc/thread-self/attr/fscreate to
>>>>> set the security attribute of file.
>>>> Either you don't realize that attr/fscreate is SELinux specific, or
>>>> you don't care, or possibly (and sadly) both.
>>> I do realize that it is SELinux specific and that's why I have raised=

>>> the concern that it does not work with SMACK.
>>>
>>> What's the "fscreate" equivalent for SMACK so that I file server can
>>> set it before creation of file and get correct context file?
>> The Smack attribute will be inherited from the creating process.
>> There is no way to generally change the attribute of a file on
>> creation. The appropriateness of such a facility has been debated
>> long and loud over the years. SELinux, which implements so varied
>> a set of "security" controls opted for it. Smack, which sticks much
>> more closely to an access control model, considers it too dangerous.
>> You can change the Smack label with setxattr(1) if you have
>> CAP_MAC_ADMIN.
> Ok, calling setxattr() after file creation will make the operation
> non-atomic. Will be good if it continues to be atomic.

That's a known downside. If you run the daemon with a Smack label that
is generally not accessible (easy to do) to the public you can do it
safely.


>> If you really want the file created with a particular
>> Smack label you can change the process Smack label by writing to
>> /proc/self/attr/smack/current on newer kernels and /proc/self/attr/cur=
rent
>> on older ones.
> I guess /proc/thread-self/attr/smack/current is the way to go in this
> context, when one wants to support SMACK.

Label flipping is pretty dangerous. I prefer the run-with-safe-label,
call setxattr() approach. It's explicit.


>>>>> https://listman.redhat.com/archives/virtio-fs/2021-September/msg001=
00.html
>>>>>
>>>>> How will this work with multiple labels. I think you will have to
>>>>> extend fscreate or create new interface to be able to deal with it.=

>>>> Yeah. That thread didn't go to the LSM mail list. It was essentially=

>>>> kept within the RedHat SELinux community. It's no wonder everyone
>>>> involved thought that your approach is swell. No one who would get
>>>> goobsmacked by it was on the thread.
>>> My goal is to support SELinux at this point of time. If you goal is
>>> to support SMACK, feel free to send patches on top to support that.
>> It helps to know what's going on before it becomes a major overhaul.
> Fair enough.
>
>>> I sent kernel patches to LSM list to make it plenty clear that this
>>> interface only supports single label which is SELinux. So there is
>>> no hiding here. And when I am supporting only SELinux, making use
>>> of fscreate makes perfect sense to me.
>> I bet it does.
>>
>>>>> That's why I think that it seems premature that fuse interface be
>>>>> written to deal with multiple labels when rest of the infrastructur=
e
>>>>> is not ready. It should be other way, instead. First rest of the
>>>>> infrastructure should be written and then all the users make use
>>>>> of new infra.
>>>> Today the LSM infrastructure allows a security module to use as many=

>>>> xattrs as it likes. Again, Smack uses multiple security.* xattrs tod=
ay.
>>> security_dentry_init_security() can handle that? If not, what's the
>>> equivalent.
>> Yes, it can.
> How? How will security_dentry_init_security() return multiple lables?
> It has parameters "u32 *ctxlen" and you can return only one. If you
> try to return multiple labels and return total length in "ctxlen",
> that does not help as you need to know length of individiual labels.
> So you need to know the names of xattrs too. Without that its not
> going to work.
>
> So no, security_dentry_init_security() can not handle multiple=20
> security labels (and associated names).=20

As I mentioned before, this is an example of why I don't want to
see yet another special-for-SELinux case.

>
> Vivek
>

