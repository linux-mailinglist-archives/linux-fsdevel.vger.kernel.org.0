Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5F3A34F49C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Mar 2021 00:54:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233026AbhC3Wx4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Mar 2021 18:53:56 -0400
Received: from sonic308-15.consmr.mail.ne1.yahoo.com ([66.163.187.38]:45029
        "EHLO sonic308-15.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232884AbhC3Wxm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Mar 2021 18:53:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1617144822; bh=lUrqHqJqNkWVoM9OaqfWbDhIhnEBNdOBuP3Xj6s1JFA=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject:Reply-To; b=hlFjm+UfG4n6QAdMSmPk1GqshpmbzfGB/B+qDWC8gV2PO2vay4ig4XGzIBoOh1EZRwtBq/9Kye0oFhPx58TNMX42g6djFkCCmgcxJCqtWO9xQoqdsIid3wLtMX6hrvCURLGLFdE0cajzuEiO68M0tin8ymk1JIUrEcjXLbKl3gzeWhpovBhcwZ84LEtgWa+9p3jzdOdigdBBPG2aIslbRtiQywAVoAyBFzKjGZ0QhTHyl9IC6sLyublJOW7sLhFqqLXPm+R1yGkkS75A/xphSeQY/XsONuCv1/RmtDHcqvIQ2siMF7Lur5JEE5NW/t3wQ0BeR2wU3ykDr0mMX2jTLw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1617144822; bh=R6QzrZUwxqMvrHYoOrdwnMgf2ifNFqqj3kV/i+GSwCy=; h=X-Sonic-MF:Subject:To:From:Date:From:Subject; b=nxw12H7BxBAMcob44/wzyfdUUjhFi5eh28QfYsdeynJ4/Fq2PF7ms573gzsuLVMKkJXRkQlF5QoqYLYyW9TqnYOKXSfw5XdhcTODHGEMJjLVmdrJNucbsj5c4F+ea7TW24F/gztFDPNyvOhD4eiEvAkNkIol0I+QGWE7eBBcd07XwxLPwZTt5BXhBr4k+MrMDjRrBYX++4bv8ZZuLCbIN5D+SOmaimCI56WYz6y9HY6HACT0V4AHglDiTHY7MLofnJrFMqj7BOkKM78yI2vzrLPVvZi5rEBxy3TXyoj4AkJ5eI+j1nPSpgeT2TIP+NF80ewZ7D72650xSt6AAoskvA==
X-YMail-OSG: W5dEE7sVM1ko3wzmdkbFN6U_Mnh.XiX31ICf1mZJNsrku69QYS8M1D3fevdNEIh
 7OHIBpunrMonwDllfef2oee60W_ALdxUGmrivAI2QWxEvV0kKZIIwiqSUpJCdrd0APWLPalBq1yy
 6iz_jk485RFtpmEOM9IzHPyA3Ypv0nh4KYZocYqY3a0RlRx.nGWizCPm8EOeoj1IoY8X6tmnKzWU
 UzsvsmCXMdTX7XaaDNFkKWa6DD22N50xkmAAiqsoXbzyzT6IDgq9xCzcP4qrgTSK3eF5VuaYXAEC
 wgjJYG6NY._wucf3Ruf_e.iFf7P5kGj.wK759UE87p3Znbz3IKXrgIZrCct67vfeahPSgYEdrn20
 noxp01X7Ai.xL2ZVMaT5I0roSwfmEHhPrhfuTqTFjP.2tcDlYc0gHBtxIWecxV0Mm20Gxye2jBNK
 SeNE6pwmIaKluGa13zLAj7i6DFXtV98kClpjjxtdJta7hjPbQcHmvaNHix3bQyRi4mZHJyicwOnW
 G604wXn2YSwaiALUyHtF0NQIvCs9eS0UXO.ytRjw7FeZa5L82Fnz6JYMQnerQUW.NMcKvWtCYTuA
 OrYXeMlU0_adtU9D.YPYAqv5wUg1njnsjeTh9LcevbsypxThfNxR4XUzU6X.qcm5w9N6itq61UXf
 mFZuF08NTpaHZUVCUcrYp5SkVSQUS0vHBBTydLteYGrZqzH0887keZQTKmoFASixPXy1yYUU83u2
 cdBvJlUcQcQezJUhK.bUl.BMFgheGTYa4geZsbjeH.Blx7sm_s58czti6.La47k5_L031kVlwHbB
 AQZ9NY6WyysM9W4Udyn5n1WSfIbxDovaVmQZhKqIkyu7PCa_QXN5rR7oYAx0LPvIvYdeuqK_ciUl
 xCNVz.V6mkiOmqR41rxEX3cIViZcON.xi6nK3LOh_2YgjDeJJO_vYIIhMPvJUXqoqbcMmPdQf9Mi
 3u2miEE97rlGf_gMZGNa2GFzdFXK2uOPIWNpWtrLmMQlm55yA9noeIb97REWDKE2oWSgZvHHFQHk
 GWM6BGEnhFCEC01ctP6KeVe9xEicomszlrdEVJDgcIfafGDfeLg5HHu7fTboWkssKBOvFJeSdf8o
 0DhMWgjPadtZ3vxsyo2jwXiatbdps5Y3BcX2R7SuXPZCxa0McCM2WtvRMX6gSdNYd.Juz7PqhYM_
 pC4DIBiF0QsdSCf3zjvbvxBnmUyYBshCjvVRF7Z5lIkySB7aZpjBYltcdlVPI0rvaU1DJ0AJuGCB
 8qFRbRzl7FigJIQZ6r37BzG1jNKjOrPqE_9_NxIHHiFvZEhsvFlVMBgx3Fdlu8Ll8hICxs.LDJ_I
 jh8wzjLDCffLkivxRFGcibO2AxKIYE75nBcGV2UTzhP0hIygdfW6OOryc7Ssx9CeNZnOgA888Uf7
 zLXdkw53AnldlcMMXZLbBhxszwccalnJAs3j4TSXIDIAFcBrTNz39LLfyj1DjMT2YsbkuD7.KE5A
 iaaS41rH8VbGHXYDroWHCoKbYbpBxHRph4kTHiuyhZSjQ3D2d_EVSf8m1bhwV596cZNpBuBZANqb
 Y3tzW6oJSg5Am9Wp838PILLdn5GK5vQnqPDxcSFtCXCR14KpgFlZQ9AnUm0DNtqZ.I1LbBQH8gUN
 v22_iOlezaggZcCBfMroADYmwdF2aGU6VPXhGs8zDZa1mFAOWSckPCH4gxWxH5UJcSD5wPYI.Vga
 30bojsGgNqpiwph9704rB7Zh7BKmyjEqHcODFAIzVP6cKXAUHmwBZVCEs13VMPOzZbTuYd1lhkAM
 iaMonFfme8aSuxJmUJSG4rX.shRperm4.v_h3xS8ycuyUsJUI_h8moFof2yQb_Ff.na1Ptta3Y6t
 NemtiiWdFz6M3IFoDQh7fDC9Y8ZIpcGHHAbbgPlumQoyVwMOKZDirwYD3dwZRj_afLLaNcAEiPcK
 f_N4Qt_D1xRSP2re0GI0lCaksxs_2AZHjJjjRMCtsmls5RlqqPaSrVsFp5QMNXNOQ0U8bbvrzeck
 g8fPd.dAoj0_zWsHp5qwmu9g59fOiBC93X1sammw2BpukqWu428MoiRxUeQDH_lN63khIv4_1O4Y
 Dm.xpQMz1u0fZdj9oKM0Y4WFtDN4jvb7sbnO1vPZXnPE5_nE4M9nEsZZF9LOy_TZSmjzYCo6X_WM
 2tH8.SE2LlNVpmUVzXkKj028gpiFWT02npajna5I4_olo9iCdQjnbDJPAQFvUA.O3_yKjaG6pwJt
 ZN_Gfh11T0nkWVW.XxrZTETQADnE9w2XdcyZz0kru_NIsOmOnO_jIZiZpPMFFJEWho45S6tQTpSW
 BLGqNj0xxf4BNUdky.evXVpU9nqvqI3qMNOLtS_1jqPJ6fDK1fPr49Pv6nH4MFd7QFHh2rCL5zw_
 kVac5PSz5pEMkAT4bmPB4MKo660bN635cY2s.p5_JLb3qEj0jwEOIVZZBwWFTR4vzfAIqMwh.pbe
 BVg9rqg.X4oxvTuX.7UenX9HNZ5.lGKJb7c1N0zSeNBZOpBsnLzpL6WlGZxAPOa4Y2vkshqWjitI
 8cVOKp5vVNvm8ZUgXA2t8NGFYvCanyltt8PFgT02Iybtsgl2jKIbHTP6Rj6BSSl815d5NhcYK4Cs
 I9hCXPeEHyvK8bcDoMVHeeBYr3BUebtPiqGRytocmUz0X5Q.Nxlx7fERemb3joypZhG6nWSQxEaA
 u56AyNj4YqxI8RpgZdZXkEvzLOo3boqXoJRbDDWhQhIRbeTsK3rk4A2t_BQBNGYkYbGrYj2JaA95
 r_GOlQpttWLah_Y4AFa_QlFkq1BDW8KwqM2.OkNMaHNGU9KpiN2NMf9DLksA9dyxhiINscYXDzdf
 8375D0KZlWthcEIj23CO7bzZ7xlbjGXSD29JWAUDQmzUs5xBdA5yjG4HL8hFntr4Z1fBOVYT2kv0
 DFcLlYq.coeoZHGhGaLQ3zKI4eLH6TGENpZMwoXj9dJdu2IKC5a76dy3LjcJESM2eTP5zMM6NZX0
 8cJS_4sBq_MDA5JSZi2BQIw5V0CgAL91bOIzTekcLzDMSHLxbimYsWnlUzU336pgj7Euz2zqT4p_
 Vh7gPV3lQIKCTgSV0AzSkJZsdKJRT12.ngKyuwSXReoKfyHtyafkO5Ia_UK9orcZBLbymNc5gxGV
 UhETLF7VwG.TrN.6J9JwiWQ8YeaP9PEO4fh9MbgW27lBUuXuZoekPGLeeb6_iNKW.NwhAuQLqA0B
 uCM0DEFBhMpKUA1xxMWbVEdljCWIiVM36YDFwGVNSVvic96evoP24CimbozRsPkDB.F4wlUNXlJC
 E.i1LFke91v6ROtKJuDPkXNSkO5B8c.hI1ms3.33TnMtCo2OUfMR2R_uTPwz4VneO9VpvO56hUkp
 VE7BSYnUR_8IU57dJ2jGKU1NCH37JRaTnSnxg0Sxf_pbn8ow54hI2wUshtQJ8FQFqlf4HWutweeL
 jaGT1PJE1mreZR.ysIgLoQgR4lqzxY.EHcB2bTVZtSa7sKFwKuCIHeTWWFdR4PdxlvFBCXqHj1An
 pquhoooNPVntjsxURBaOW_RNAcFBgMj1sdHX3J1czECQld8SyMLomwTx6jnM4ByFko.UPaqnONP_
 itTziajZUdJ9W2zg9jEFJKsG6f05hjQ4.5sdvbVzb1aO6zMOv.4GBYwZryod6rjb.XNr5k6JAXcp
 fuoeqK5nK5Xe3qS6GU9L.R0Lz19Vlg_0dP9FsTRGpL_OEn2Ybz9wXJvOlqGhWNOm_TWEcP1AaEAt
 XCtq9Szd9NyAofnOt.4eAgu9cL5F2rm2MLBjMHPZ0te285Dj7lo_aSnV8TLXheLyWb0bFMKCoq8c
 G9QK3kEsSeWQaXhm2MQ24tnoa.cHJ7cyL8X3.jMupmRDR_cf0YzOkAYDZXPeIcKbd8mnplL1Rnt2
 uY4UGG_.puhIjwwG0jfKEpY8iJcA4GoewcJhhCk9h0Qwz_wFIuBxyMh4SWhg0kT1ERpPkSn07TIB
 E6AvHFMyyf8mx7tARK6QD1wVw3tb8_NvyhOYPsAVZk.ZtjzShKqeDBpdawa8xRlgDTGKbDn2Mxj_
 4f86nzCZtwPGepsD99MY-
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.ne1.yahoo.com with HTTP; Tue, 30 Mar 2021 22:53:42 +0000
Received: by kubenode555.mail-prod1.omega.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 3310f8e08f361ecdaf23f4e4d2eccc3c;
          Tue, 30 Mar 2021 22:53:37 +0000 (UTC)
Subject: Re: [PATCH v5 1/1] fs: Allow no_new_privs tasks to call chroot(2)
To:     =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>,
        Al Viro <viro@zeniv.linux.org.uk>,
        James Morris <jmorris@namei.org>,
        Serge Hallyn <serge@hallyn.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Christoph Hellwig <hch@lst.de>,
        David Howells <dhowells@redhat.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Jann Horn <jannh@google.com>,
        John Johansen <john.johansen@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        Kentaro Takeda <takedakn@nttdata.co.jp>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        kernel-hardening@lists.openwall.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@linux.microsoft.com>,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20210316203633.424794-1-mic@digikod.net>
 <20210316203633.424794-2-mic@digikod.net>
 <fef10d28-df59-640e-ecf7-576f8348324e@digikod.net>
 <85ebb3a1-bd5e-9f12-6d02-c08d2c0acff5@schaufler-ca.com>
 <b47f73fe-1e79-ff52-b93e-d86b2927bbdc@digikod.net>
 <77ec5d18-f88e-5c7c-7450-744f69654f69@schaufler-ca.com>
 <a8b2545f-51c7-01dc-1a14-e87beefc5419@digikod.net>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <2fcff3d7-e7ca-af3b-9306-d8ef2d3fb4fb@schaufler-ca.com>
Date:   Tue, 30 Mar 2021 15:53:37 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <a8b2545f-51c7-01dc-1a14-e87beefc5419@digikod.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Mailer: WebService/1.1.17936 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo Apache-HttpAsyncClient/4.1.4 (Java/11.0.9.1)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 3/30/2021 12:28 PM, Micka=C3=ABl Sala=C3=BCn wrote:
> On 30/03/2021 20:40, Casey Schaufler wrote:
>> On 3/30/2021 11:11 AM, Micka=C3=ABl Sala=C3=BCn wrote:
>>> On 30/03/2021 19:19, Casey Schaufler wrote:
>>>> On 3/30/2021 10:01 AM, Micka=C3=ABl Sala=C3=BCn wrote:
>>>>> Hi,
>>>>>
>>>>> Is there new comments on this patch? Could we move forward?
>>>> I don't see that new comments are necessary when I don't see
>>>> that you've provided compelling counters to some of the old ones.
>>> Which ones? I don't buy your argument about the beauty of CAP_SYS_CHR=
OOT.
>> CAP_SYS_CHROOT, namespaces. Bind mounts. The restrictions on
>> "unprivileged" chroot being sufficiently onerous to make it
>> unlikely to be usable.
> There is multiple use cases for these features.

All of which can be done using existing mechanism, best I can tell.


>>>> It's possible to use minimal privilege with CAP_SYS_CHROOT.
>>> CAP_SYS_CHROOT can lead to privilege escalation.
>> Not when used in conjunction with the same set of
>> restrictions you're requiring for "unprivileged" chroot.=20
> I'm talking about security with the principle of least privilege:

<RANT>
That is what CAP_SYS_CHROOT is all about. Identify the thing that
you want to do that violates policy. Provide an explicit override
for that policy. Control the use of that override in an orderly way.
Document how it works.

That is the whole intent of the capability mechanism. Don't introduce
baroque conditional behaviors based on environmental nuances.
</RANT>

>  when
> we consider that a process may be(come) malicious but should still be
> able to drop (more) accesses, e.g. with prctl(set_no_new_privs) *then*
> chroot()

How is that better than chroot() *then* drop CAP_SYS_CHROOT?


>>>> It looks like namespaces provide alternatives for all your
>>>> use cases.
>>> I explained in the commit message why it is not the case. In a nutshe=
ll,
>>> namespaces bring complexity which may not be required.
>> So? I can use a Swiss Army Knife to cut a string even though it
>> has a corkscrew.
> Complexity leads to (security) issues.

Yes. Explict use of CAP_SYS_CHROOT is simple.
Implicit use of NO_NEW_PRIVS is difficult to verify and track.

>  In secure systems, we want to
> reduce the attack surfaces. There is some pointers here:
> https://lwn.net/Articles/673597/

You've identified a clever hack to justify expanding when
chroot() could be done "safely" without using privilege.
Why not learn how to use the existing mechanism properly?
And teach the next set of people how to do the same?
I am under no delusion that we can tweak here and fiddle
there and make security all rainbows and unicorns. Mature
mechanisms that are general are safer than tangled heaps of
special cases that make individual projects easier.

>>>  When designing a
>>> secure system, we want to avoid giving access to such complexity to
>>> untrusted processes (i.e. more complexity leads to more bugs).
>> If you're *really* designing a secure system you can design it to
>> use existing mechanisms, like CAP_SYS_CHROOT!
> Not always. For instance, in the case of a web browser, we don't want t=
o
> give CAP_SYS_CHROOT to every users just because their browser could
> (legitimately) use it as a security sandbox mechanism.

We already have bunches of mechanisms, including userids, three flavors
of Mandatory Access Control, namespaces, seccomp and virtualization for
sandboxing. Do we really need to change a behavior that's been around for=

over 40 years?

>  The same
> principle can be applied to a lot of use cases, e.g. network services,
> file parsers, etc.
>
>>>  An
>>> unprivileged chroot would enable to give just the minimum feature to
>>> drop some accesses. Of course it is not enough on its own, but it can=20
be
>>> combined with existing (and future) security features.
>> Like NO_NEW_PRIVS, namespaces and capabilities!
>> You don't need anything new!
> If a process is compromised before chrooting itself and dropping
> CAP_SYS_CHROOT, then there is a bigger security issue than without
> CAP_SYS_CHROOT.

If a process is compromised before setting NO_NEW_PRIVS you
could say the same.=20


>>>> The constraints required to make this work are quite
>>>> limiting. Where is the real value add?
>>> As explain in the commit message, it is useful when hardening
>>> applications (e.g. network services, browsers, parsers, etc.). We don=
't
>>> want an untrusted (or compromised) application to have CAP_SYS_CHROOT=

>>> nor (complex) namespace access.
>> If you can ensure that an unprivileged application is
>> always run with NO_NEW_PRIVS you could also ensure that
>> it runs with only CAP_SYS_CHROOT or in an appropriate
>> namespace. I believe that it would be easier for your
>> particular use case. I don't believe that is sufficient.
> You can't always have this assertion, e.g. because a user may require t=
o
> run (legitimate) SETUID binaries=E2=80=A6
>
> For everyone following a defense in depth approach (i.e. multiple layer=
s
> of security), an unprivileged chroot is valuable.

If you need to run legitimate SETUID (or file capability enabled) binarie=
s
you can't use NO_NEW_PRIVS. You can use CAP_SYS_CHROOT, because capabilit=
ies
where designed to work with the UID mechanisms.

In any case, if you can get other people to endorse your change I'm not
all that opposed to it. I think it's gratuitous. It irks me that you're
unwilling to use the facilities that are available, and instead want to
complicate the security mechanisms and policy further. But, that hasn't
seemed to stop anyone before.
=C2=A0

>>>>> Regards,
>>>>>  Micka=C3=ABl
>>>>>
>>>>>
>>>>> On 16/03/2021 21:36, Micka=C3=ABl Sala=C3=BCn wrote:
>>>>>> From: Micka=C3=ABl Sala=C3=BCn <mic@linux.microsoft.com>
>>>>>>
>>>>>> Being able to easily change root directories enables to ease some
>>>>>> development workflow and can be used as a tool to strengthen
>>>>>> unprivileged security sandboxes.  chroot(2) is not an access-contr=
ol
>>>>>> mechanism per se, but it can be used to limit the absolute view of=20
the
>>>>>> filesystem, and then limit ways to access data and kernel interfac=
es
>>>>>> (e.g. /proc, /sys, /dev, etc.).
>>>>>>
>>>>>> Users may not wish to expose namespace complexity to potentially
>>>>>> malicious processes, or limit their use because of limited resourc=
es.
>>>>>> The chroot feature is much more simple (and limited) than the moun=
t
>>>>>> namespace, but can still be useful.  As for containers, users of
>>>>>> chroot(2) should take care of file descriptors or data accessible =
by
>>>>>> other means (e.g. current working directory, leaked FDs, passed FD=
s,
>>>>>> devices, mount points, etc.).  There is a lot of literature that d=
iscuss
>>>>>> the limitations of chroot, and users of this feature should be awa=
re=20
>> of
>>>>>> the multiple ways to bypass it.  Using chroot(2) for security purp=
oses
>>>>>> can make sense if it is combined with other features (e.g. dedicat=
ed
>>>>>> user, seccomp, LSM access-controls, etc.).
>>>>>>
>>>>>> One could argue that chroot(2) is useless without a properly popul=
ated
>>>>>> root hierarchy (i.e. without /dev and /proc).  However, there are
>>>>>> multiple use cases that don't require the chrooting process to cre=
ate
>>>>>> file hierarchies with special files nor mount points, e.g.:
>>>>>> * A process sandboxing itself, once all its libraries are loaded, =
may
>>>>>>   not need files other than regular files, or even no file at all.=

>>>>>> * Some pre-populated root hierarchies could be used to chroot into=
,
>>>>>>   provided for instance by development environments or tailored
>>>>>>   distributions.
>>>>>> * Processes executed in a chroot may not require access to these s=
pecial
>>>>>>   files (e.g. with minimal runtimes, or by emulating some special =
files
>>>>>>   with a LD_PRELOADed library or seccomp).
>>>>>>
>>>>>> Allowing a task to change its own root directory is not a threat t=
o the
>>>>>> system if we can prevent confused deputy attacks, which could be
>>>>>> performed through execution of SUID-like binaries.  This can be
>>>>>> prevented if the calling task sets PR_SET_NO_NEW_PRIVS on itself w=
ith
>>>>>> prctl(2).  To only affect this task, its filesystem information mu=
st=20
>> not
>>>>>> be shared with other tasks, which can be achieved by not passing
>>>>>> CLONE_FS to clone(2).  A similar no_new_privs check is already use=
d by
>>>>>> seccomp to avoid the same kind of security issues.  Furthermore, b=
ecause
>>>>>> of its security use and to avoid giving a new way for attackers to=20
get
>>>>>> out of a chroot (e.g. using /proc/<pid>/root, or chroot/chdir), an=

>>>>>> unprivileged chroot is only allowed if the calling process is not
>>>>>> already chrooted.  This limitation is the same as for creating use=
r
>>>>>> namespaces.
>>>>>>
>>>>>> This change may not impact systems relying on other permission mod=
els
>>>>>> than POSIX capabilities (e.g. Tomoyo).  Being able to use chroot(2=
) on
>>>>>> such systems may require to update their security policies.
>>>>>>
>>>>>> Only the chroot system call is relaxed with this no_new_privs chec=
k;=20
>> the
>>>>>> init_chroot() helper doesn't require such change.
>>>>>>
>>>>>> Allowing unprivileged users to use chroot(2) is one of the initial=

>>>>>> objectives of no_new_privs:
>>>>>> https://www.kernel.org/doc/html/latest/userspace-api/no_new_privs.=
html
>>>>>> This patch is a follow-up of a previous one sent by Andy Lutomirsk=
i:
>>>>>> https://lore.kernel.org/lkml/0e2f0f54e19bff53a3739ecfddb4ffa9a6dbd=
e4d.1327858005.git.luto@amacapital.net/
>>>>>>
>>>>>> Cc: Al Viro <viro@zeniv.linux.org.uk>
>>>>>> Cc: Andy Lutomirski <luto@amacapital.net>
>>>>>> Cc: Christian Brauner <christian.brauner@ubuntu.com>
>>>>>> Cc: Christoph Hellwig <hch@lst.de>
>>>>>> Cc: David Howells <dhowells@redhat.com>
>>>>>> Cc: Dominik Brodowski <linux@dominikbrodowski.net>
>>>>>> Cc: Eric W. Biederman <ebiederm@xmission.com>
>>>>>> Cc: James Morris <jmorris@namei.org>
>>>>>> Cc: Jann Horn <jannh@google.com>
>>>>>> Cc: John Johansen <john.johansen@canonical.com>
>>>>>> Cc: Kentaro Takeda <takedakn@nttdata.co.jp>
>>>>>> Cc: Serge Hallyn <serge@hallyn.com>
>>>>>> Cc: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
>>>>>> Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@linux.microsoft.com>
>>>>>> Reviewed-by: Kees Cook <keescook@chromium.org>
>>>>>> Link: https://lore.kernel.org/r/20210316203633.424794-2-mic@digiko=
d.net
>>>>>> ---
>>>>>>
>>>>>> Changes since v4:
>>>>>> * Use READ_ONCE(current->fs->users) (found by Jann Horn).
>>>>>> * Remove ambiguous example in commit description.
>>>>>> * Add Reviewed-by Kees Cook.
>>>>>>
>>>>>> Changes since v3:
>>>>>> * Move the new permission checks to a dedicated helper
>>>>>>   current_chroot_allowed() to make the code easier to read and ali=
gn
>>>>>>   with user_path_at(), path_permission() and security_path_chroot(=
)
>>>>>>   calls (suggested by Kees Cook).
>>>>>> * Remove now useless included file.
>>>>>> * Extend commit description.
>>>>>> * Rebase on v5.12-rc3 .
>>>>>>
>>>>>> Changes since v2:
>>>>>> * Replace path_is_under() check with current_chrooted() to gain th=
e same
>>>>>>   protection as create_user_ns() (suggested by Jann Horn). See com=
mit
>>>>>>   3151527ee007 ("userns:  Don't allow creation if the user is chro=
oted")
>>>>>>
>>>>>> Changes since v1:
>>>>>> * Replace custom is_path_beneath() with existing path_is_under().
>>>>>> ---
>>>>>>  fs/open.c | 23 +++++++++++++++++++++--
>>>>>>  1 file changed, 21 insertions(+), 2 deletions(-)
>>>>>>
>>>>>> diff --git a/fs/open.c b/fs/open.c
>>>>>> index e53af13b5835..480010a551b2 100644
>>>>>> --- a/fs/open.c
>>>>>> +++ b/fs/open.c
>>>>>> @@ -532,6 +532,24 @@ SYSCALL_DEFINE1(fchdir, unsigned int, fd)
>>>>>>  	return error;
>>>>>>  }
>>>>>> =20
>>>>>> +static inline int current_chroot_allowed(void)
>>>>>> +{
>>>>>> +	/*
>>>>>> +	 * Changing the root directory for the calling task (and its fut=
ure
>>>>>> +	 * children) requires that this task has CAP_SYS_CHROOT in its
>>>>>> +	 * namespace, or be running with no_new_privs and not sharing it=
s
>>>>>> +	 * fs_struct and not escaping its current root (cf. create_user_=
ns()).
>>>>>> +	 * As for seccomp, checking no_new_privs avoids scenarios where
>>>>>> +	 * unprivileged tasks can affect the behavior of privileged chil=
dren.
>>>>>> +	 */
>>>>>> +	if (task_no_new_privs(current) && READ_ONCE(current->fs->users) =
=3D=3D=20
>>>> 1 &&
>>>>>> +			!current_chrooted())
>>>>>> +		return 0;
>>>>>> +	if (ns_capable(current_user_ns(), CAP_SYS_CHROOT))
>>>>>> +		return 0;
>>>>>> +	return -EPERM;
>>>>>> +}
>>>>>> +
>>>>>>  SYSCALL_DEFINE1(chroot, const char __user *, filename)
>>>>>>  {
>>>>>>  	struct path path;
>>>>>> @@ -546,9 +564,10 @@ SYSCALL_DEFINE1(chroot, const char __user *, =
filename)
>>>>>>  	if (error)
>>>>>>  		goto dput_and_out;
>>>>>> =20
>>>>>> -	error =3D -EPERM;
>>>>>> -	if (!ns_capable(current_user_ns(), CAP_SYS_CHROOT))
>>>>>> +	error =3D current_chroot_allowed();
>>>>>> +	if (error)
>>>>>>  		goto dput_and_out;
>>>>>> +
>>>>>>  	error =3D security_path_chroot(&path);
>>>>>>  	if (error)
>>>>>>  		goto dput_and_out;
>>>>>>

