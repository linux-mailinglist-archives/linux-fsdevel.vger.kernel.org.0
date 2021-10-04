Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 284FD42153D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Oct 2021 19:36:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235024AbhJDRiI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Oct 2021 13:38:08 -0400
Received: from sonic315-26.consmr.mail.ne1.yahoo.com ([66.163.190.152]:44216
        "EHLO sonic315-26.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234987AbhJDRiH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Oct 2021 13:38:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1633368978; bh=niPxADPRikeK5rxApUPmsD8xoirqtAp+hVaMB3iQuNM=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject:Reply-To; b=t7sbeDKtiDnLJJjTe4nQLwaWm3ggQOUp3uIKp8fsXn8yyJjSj58zfHOf1MN12cwJclIZGyHVRsJajnSUU9HCiYoo1iVZ6ddxmKb2QisX+IdZtbeMiaqW7Ts3WK5l0sXSECb2LNLwY0nOT9sMPR2NTBbF17mhv3STqz+F9s6RggKY1dtpwuHvp/Qt42bIvqQmSmLsTLa8fxxEMkGbVV8pgTFtDf2IkrdvIrmbtBKxnrbbSDikSF4n3GeagqD/Kf7Gefq/1dQR74wJsSu1GqDe1cEzPw2f6dC2WufYb5el3WzqD6E1yQkC+OuT6Bb6V1xE6yjShb7z3lAepbvvfLuzZA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1633368978; bh=VYkbrYaicX/o6VKu8GSIUlhWHraO5M7ljAlGpNm1xOk=; h=X-Sonic-MF:Subject:To:From:Date:From:Subject; b=lvuxACvfElZodFoMrszmd/YA5AQvc015ij4KpXDSDG9kyashj3Pv5yKVCU76N4yesgUE/YO0nbZnDsLZ2/qq+gTrSMEBAris96sFxQCOFEWAsjFWfkZU6Auu6FKromrQ+T9vnls+QR2kpY6SrgTRymd0mkQC6h3SXtYBA0sfxhyj8O87kSpXVSefc4zfKdD0ShxAr/zqUPItWEL6G1QrzsqR4/LkkQBH+vVp6Ay857HM0r5bYRThCYU0NMqiHAHTq4/S4zSYawpZmHLMXzD52eK7N/WcWvK5FhbY4l6UgRIOcOa2l9uHJPRuowbiaxQ7Hx95N4tz18Oxg4xdk91eWQ==
X-YMail-OSG: FBBy3kEVM1m3_xWgArH6NLjKO4dkOBALVJKPUSVae269z6fdfW4OsLp_eUEnYCe
 ykvMYdYPQwNi2.2LxM.JuZYMQbR8zV4AKPcIAlCe6I5xnssp80tLDzHso2TfuiboOAvyXMxNQxle
 1cFMDsLYd1vTS7080YnH8t5I200shhfIVFMKrUpyqEJg_StiNHy2AHVL_1zo6t39KnbseSxFEpuB
 kg6p6ABccg0SBIbNXSweITh2f5wkJ_ld6OWHqE.w1Tt.X6ZfZJHdl_SNstmm23h00ZCvj2X7BplX
 2ZV.JuY_bgwIUPoPWh7uTljit4djjcgUXFa9qu30vlUyPUnytVKEhRY3qRLCH29lFBc14x8QDJpL
 kZAAQmA0SAoVyewP7o_meJwr1BecdLC1ScF1WAUOpa6XE2iNa6vUbtZqzTW2jaj3c6mOG5Ev.3wJ
 NMje7TTy24lpktCZET1FxNHWVjhKL6O4YFcYmv20xtbdA_bhc4oroIGnPyTDL8lBn7B6cnSOvRvS
 7TrT8I8eRQdzhAZUhxMPRQkBahTPWvief83PLoItcCYRBaEdoHeL_SHe.AdakpmI1uuvaWwpQZP0
 5C0vP0Qd69pX6BpqxRnJ9lI22Mr8K2dgIUUCs1XhtxnkYfv3ph8RuneznuCPcHojht8Y_sS2_LIP
 Yt6vVOy4gMnQIknqT2Bc5GoAAQv9gxDP8cJ77cYW0pEYEoj4qthbBgpFUY8kCWXtypx3DXNGA6lU
 8Uc.oRYI3f7BEnQrxKd23ooIbK2o_MqAetWdyZ1IV9YQqODJwMYE764VvxhM39MbCflJD033znNW
 KC1d4g9aZTFTYfGprz7PYSwG01alodevTUGfBXW6h3IXFezO.hW7TY0zRu9ZrjNCOsMcGx_wY3.V
 DrmgUf5yYLdlwUB35IiCvfiMsbGzoc9yZVd4SoIDfu3tSF_vAV1.vRxq298VONG5zvsu6V2Ail5p
 iUZhoxSuHlplCcf1gP5CIjnqu35RviR_EHl647Zu8L7s.E8yZ3U0c3jzO4bzMv0Lf2A0SXyj77_p
 tMHSwQh8JtTPutTCezbwnvtePkWdpBWKv2fTYHBHBDTejoJkXjWkkA5AxSO44GldaCryPqD9dZMb
 HJwV33YBRLN.hvbZhDHsrYZY4RBAa3xMQlAQv5wuw5k__Z7KmpDkYf6a8zYjJUicCURGgq08NSDT
 z5ZHD_ZXc.DijqMKQTQxXXivF1lSwswAevUshGQ3KANGpj9BEyMroAxCNhO4yBdHKe.nvVR0R9yW
 IPudL4e4aqJGNXVDPgNd1s4TfsoO3frEUjdRw6rNFkdCmBJqnDkoQb9bfeYfjXAlZfeHBNmhekCm
 Dyio5etsSu.DnZXhk3VA.t9OhQ6IXCHhX__bFJa3XcV6DMD5k97kLr7x7YZTAzC9KRUazndHezsd
 wI7Za6AJlOqAVpmCqENtJ0FIRe_wY6PSVgT9HQ1jb2ljU0HbWAvzbRf_UBW26SFguMTfCqkSCZPc
 rF5t7UQBpnjFn..CPqI0Ocx89SXB.I.6.iz8kNrhwsBneCKX_aGYbPLkkKJidxtsJoszdJGI6R33
 bOmOnwIjMwvDoyoMio0llA.HDZXVY5mf3MfTwWMdheEFEXTDOV0K0_DNgpymaB17zrmeTyagrxhS
 VO02qe6nR7pDxVJ1lTDpjuSyLnOmcFMOJUc8cVKwYGfGf1f01HvwpWGWpnIvh0pyVbAaRPDUEgs9
 un.4XcXuFZZZjWD3EMcSZKk6QLQPKAdpwiHwilOpL3CiwCVVKwdRUEREXpedzB6hl8SHwA3NzfRR
 VCwFSsUWIrBeuClUFbIf2G_zb1ERsErl4M0ggrkLmVnDLFvR_L.I9CidzEJc3zJM2MWAaalvyLKw
 UGu.2p1K0KHP.Dd12vXDbxT099b5q9BVsgK4HbculM8mCEXuy6nO5WCsugST5YcevnfvLM9z5tU4
 zwFuLlCzFTAHrI_JSyNRKOokxe8SvTNEhPAD5JP1jbJH2tEOZV1nTUWDdZ9C2Ef_Wp7U0LP86jT1
 alGEvQu9OZI4ndLxkTAjFUXBSm0D_4vX4_4qt8E9SACMB0fIcpR.2D16ymb.7qby7mPTtnhSqL2a
 _6.3vCT2ONe0IH0tdigi8x5ymd5izv57pVAxPqGnr6C55uY7OLk6yaWbLMk29q4OiChOoWc4hwGi
 Ixksv5dJ24qit_J4p.YXKTlispSLlgYrYy7YYd1vSnTEgbqw1lNA4o48edi8aPDlLeVybhjI5ObX
 EkrM_OaNDfysBO1QyMEr8M88avfKTlK9xGQ3o02JnBnyaT2P1FIQjeJ2Jzbax85jQ6iOxmZKrlBn
 YM741tUxyUhHkasnS1R9tvO.CKBejO3BU1AR90uhFrHuoXFOnVMttExIIpBhQQzEQbq1zQ2CPCAv
 ySGJXbgmUiPdmOEzon_NlLfWXAQY2BipQOqR81.djy5MJvglkT9MtYtlyrO2dmnv1xdk.wTDhxdA
 -
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.ne1.yahoo.com with HTTP; Mon, 4 Oct 2021 17:36:18 +0000
Received: by kubenode522.mail-prod1.omega.ne1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID edd0b5e117b8446c7a6b7ebc3a80ae46;
          Mon, 04 Oct 2021 17:36:16 +0000 (UTC)
Subject: Re: [PATCH] security: Return xattr name from
 security_dentry_init_security()
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     Jeff Layton <jlayton@kernel.org>,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, virtio-fs@redhat.com,
        Miklos Szeredi <miklos@szeredi.hu>,
        Daniel J Walsh <dwalsh@redhat.com>, idryomov@gmail.com,
        ceph-devel@vger.kernel.org, linux-nfs@vger.kernel.org,
        bfields@fieldses.org, chuck.lever@oracle.com,
        stephen.smalley.work@gmail.com,
        Casey Schaufler <casey@schaufler-ca.com>
References: <YVYI/p1ipDFiQ5OR@redhat.com>
 <1583ffb057e8442fa7af40dabcb38960982211ba.camel@kernel.org>
 <06a82de9-1c3e-1102-7738-f40905ea9ee4@schaufler-ca.com>
 <7404892c92592507506038ef9bdcfc1780311000.camel@kernel.org>
 <a7ab4daf-e577-abcc-f4a0-09d7eb9c4cb7@schaufler-ca.com>
 <YVs2P1AcWkQ0Q0wq@redhat.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <ae32818f-95b1-6dce-1738-aac6f184c1c6@schaufler-ca.com>
Date:   Mon, 4 Oct 2021 10:36:15 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YVs2P1AcWkQ0Q0wq@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Mailer: WebService/1.1.19076 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/4/2021 10:13 AM, Vivek Goyal wrote:
> On Mon, Oct 04, 2021 at 09:39:44AM -0700, Casey Schaufler wrote:
>> On 10/4/2021 9:01 AM, Jeff Layton wrote:
>>> On Mon, 2021-10-04 at 08:54 -0700, Casey Schaufler wrote:
>>>> On 10/4/2021 8:20 AM, Jeff Layton wrote:
>>>>> On Thu, 2021-09-30 at 14:59 -0400, Vivek Goyal wrote:
>>>>>> Right now security_dentry_init_security() only supports single sec=
urity
>>>>>> label and is used by SELinux only. There are two users of of this =
hook,
>>>>>> namely ceph and nfs.
>>>>>>
>>>>>> NFS does not care about xattr name. Ceph hardcodes the xattr name =
to
>>>>>> security.selinux (XATTR_NAME_SELINUX).
>>>>>>
>>>>>> I am making changes to fuse/virtiofs to send security label to vir=
tiofsd
>>>>>> and I need to send xattr name as well. I also hardcoded the name o=
f
>>>>>> xattr to security.selinux.
>>>>>>
>>>>>> Stephen Smalley suggested that it probably is a good idea to modif=
y
>>>>>> security_dentry_init_security() to also return name of xattr so th=
at
>>>>>> we can avoid this hardcoding in the callers.
>>>>>>
>>>>>> This patch adds a new parameter "const char **xattr_name" to
>>>>>> security_dentry_init_security() and LSM puts the name of xattr
>>>>>> too if caller asked for it (xattr_name !=3D NULL).
>>>>>>
>>>>>> Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
>>>>>> ---
>>>>>>
>>>>>> I have compile tested this patch. Don't know how to setup ceph and=

>>>>>> test it. Its a very simple change. Hopefully ceph developers can
>>>>>> have a quick look at it.
>>>>>>
>>>>>> A similar attempt was made three years back.
>>>>>>
>>>>>> https://lore.kernel.org/linux-security-module/20180626080429.27304=
-1-zyan@redhat.com/T/
>>>>>> ---
>>>>>>  fs/ceph/xattr.c               |    3 +--
>>>>>>  fs/nfs/nfs4proc.c             |    3 ++-
>>>>>>  include/linux/lsm_hook_defs.h |    3 ++-
>>>>>>  include/linux/lsm_hooks.h     |    1 +
>>>>>>  include/linux/security.h      |    6 ++++--
>>>>>>  security/security.c           |    7 ++++---
>>>>>>  security/selinux/hooks.c      |    6 +++++-
>>>>>>  7 files changed, 19 insertions(+), 10 deletions(-)
>>>>>>
>>>>>> Index: redhat-linux/security/selinux/hooks.c
>>>>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>>>>> --- redhat-linux.orig/security/selinux/hooks.c	2021-09-28 11:36:03=
=2E559785943 -0400
>>>>>> +++ redhat-linux/security/selinux/hooks.c	2021-09-30 14:01:05.8691=
95347 -0400
>>>>>> @@ -2948,7 +2948,8 @@ static void selinux_inode_free_security(
>>>>>>  }
>>>>>> =20
>>>>> I agree with Al that it would be cleaner to just return the string,=
 but
>>>>> the call_*_hook stuff makes that a bit more tricky. I suppose this =
is a
>>>>> reasonable compromise.
>>>> call_int_hook() and call_void_hook() were introduced to reduce the m=
onotonous
>>>> repetition in the source. They are cosmetic and add no real value. T=
hey shouldn't
>>>> be a consideration in the discussion.
>>>>
>>>> There is a problem with Al's suggestion. The interface as used today=
 has two real
>>>> problems. It returns an attribute value without identifying the attr=
ibute. Al's
>>>> interface would address this issue. The other problem is that the in=
terface can't
>>>> provide multiple attribute+value pairs. The interface is going to ne=
ed changed to
>>>> support that for full module stacking. I don't see a rational way to=
 extend the
>>>> interface if it returns a string when there are multiple attributes =
to choose from.
>>>>
>>> Is that also a problem for the ctx parameter? In the case of full mod=
ule
>>> stacking do you get back multiple contexts as well?
>> That's a bigger discussion than is probably appropriate on this thread=
=2E
>> In the module stacking case the caller needs to identify which securit=
y
>> module's context it wants. If the caller is capable of dealing with
>> multiple attributes (none currently are, but they all assume that you'=
re
>> using SELinux and only support what SELinux needs) it will need to
>> do something different. We have chickens and eggs involved. The LSM
>> infrastructure doesn't need to handle it because none of its callers
>> are capable of dealing with it. None of the callers try, in part becau=
se
>> they have no way to get the information they would need, and in part
>> because they don't care about anything beyond SELinux. Ceph, for examp=
le,
>> is hard coded to expect "security.selinux".
>>
>> On further reflection, Al's suggestion could be made to work if the
>> caller identified which attribute its looking for.
> Or I could just add a parameter "const char *xattr_name" which identifi=
es
> which xattr caller is looking for.  (So no returning the name of xattr)=
=2E
> And this will simply return "int".
>
> Anyway, all the callers right now only expect "security.selinux". Those=

> who can deal with other xattrs, can pass it explicitly.

Labeled NFS was supposed to support Smack as well as SELinux.
To the best of my knowledge no one ever actually got that working.
But is was promised, and there's no obvious reason it shouldn't work.

> I feel current patch is better because caller can check anyway, what
> xattr name it got in return and reject it if it does not want to deal
> with it. No hardcoding of xattr names required.

There are a bunch of LSM hooks that I'd love to rip out and replace
with more rational interfaces. This is one. I doubt I'll have the
opportunity to do that in this lifetime. Any change that works is
OK with me. There's probably some amount of change that will be
necessary in the future, and neither of the proposals on the table
are unworkable.


