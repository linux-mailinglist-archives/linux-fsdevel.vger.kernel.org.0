Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09798409CAA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Sep 2021 21:05:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241048AbhIMTGh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Sep 2021 15:06:37 -0400
Received: from sonic315-27.consmr.mail.ne1.yahoo.com ([66.163.190.153]:33537
        "EHLO sonic315-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241172AbhIMTGc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Sep 2021 15:06:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1631559916; bh=ILECwW5ren/MGKfqCoYL9+k73hXJyn37sJEe2dYHUCQ=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject:Reply-To; b=ZG/CVg9gJvs5sSYmG/734Sd7kFZOCifpIP1rmDRnoI8VJ9agvYNz3gEnqDQPiofRrNWifuEt0GHXcDbO31AO9HjAJyqPkYTh83a48k2OPE2PNtlQ+DO256IIRbHQZp6bBBxjVF6jP7MG0TAI24rn0aDIFHx/QycrzTeutux7RmuC2zwqnmdSJ+rIofrvPc2cg5QXnecKaW0jyKChbYXMW9Z6asNd2AcOwYxIEqnnKdF43R/XiJpBmWkiQblLjXsqKzHp9UqpNct6DWO0qadEu5CxK7MbianNw7tGbHagwu711jBTbHh0djrQ/A8nq4DywalWan4PIbNw8uZpwDqpGA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1631559916; bh=w0FtQl3ZEiE1T6KAtKkct5NiwWf51nt1Ky2cm29MwT2=; h=X-Sonic-MF:Subject:To:From:Date:From:Subject; b=DA72gt6oXUyPZfaumHUp5BkAcPZeQUrOkFoRuMBMEKOXRvxUqRqQGnVQGKuAzvjZOvP04cAYoJKByOARyp+kPlbft772f/1cXxUh7a4r7kIqHWidv+J1SfCtIzhQhrlr4ZhyKV7rVxVQPTGSRlNhR58izFeAePU+v4Im/1JvYLfY5Rf+Rc0MH1tDZYLv7SS4bC8O11iS0lKzQB/C5tiE8hPfW70VP5t3rhk3yu8IsNIkBVGyLvHgMaDzYWJvR1ZO31ehSX8mJOZGClp1EFARO+5NArRMl+ELkORgjpx55FDxm4UQlbtAx6YSg32L5AckytCUsaiouyPHZAg9OQiSJg==
X-YMail-OSG: v85bTmQVM1keGlFjJ03iltGozWxqdEteUOnBgdwtwKJLVib98QWSj9Qc0JhSSQG
 mcVBkDwsPPPQyMSycJqBLearMweQmnmrv2Q3Kw6fX6xGEp9AH9E1WaiXgGTblW.ZPYI8QZV.8MwA
 dqRgdR52XM.ZGcdDuLZZckPn6Mjn.2d7MjlzLyd8UXPcsR_I_DGmGblg33W4boQsNsnfyysm9v7d
 igcM704i0aDbW47Y6zAcKlF6jYq7Fw1UjdLUzobuydsyKOSBz75dwBWyBAxFg9HyeLpkpWrAuMQZ
 8UHGcvrzXdTgYncMIFc1OLn7JWQsuSFSgBYuPt1aIU9X1yXzAyVOEnsT7iMf4kR4.GxNpkVDEXJG
 QXtZkAQ48m14FeLElSNNbF9rqsVT1zLM7lsZGz7XT3wMDEO0zB2O3RV1kBxWQ.Ugvd2zjhU0EX1p
 ZN.mZSJI6ywN.YA80t95B8Tviol8AJDABKWczpjtmMm99Y.vPmXHjXaj.NC_hXzMVaw0WrNzZm5R
 XTA9ppkdXJjw3g14y0HzOlWnDpBN44juEt6mbxXzOm8F0ZTA5K.gMt9nfYMF.xnNwV3In.2izePG
 xH8oOsFsaMT.rB22zEYYfu1uHEuB28kJIx9AJtLN6ZPtDYNj4tXMGiepFoPzXjB4ahu_ksXTMP6y
 fcyfA_wMkTVrGG7a93dKZCHdc1LSntlJ8qOa2SL4kdwbL..qZVbcPHzaPdWundC207mRGeQIVD1c
 RhgedrMrWYf6EFkwBCar.5StdhYmODuy1yJDW2UAotRWxSbVT5GkAxqpBUvdMXyiJhH.y1z2PTOi
 eP_l8s.Imw6uIKvr3xoVAKhWOtA7CwmuIb0XuRXL.ByEju38BN4qkuSCKaAiEe1SAL8JkwrOixBR
 GsQ5p1qLNHN70DdsqsIVAZFlAzXkvVMGoR3bkYMjP0LpGVa5lnQZwP3Jn5iCQDE7x2ZjcHxV3a7g
 zHCMZZecC2Fq1a6kkkv0_1GNIoeWQF0q78cS3XosxcxizKkI.if.6I0KCurlMtqIEIlze9O1O0Ne
 kvkEtsHZj.LO3A.BgGZLS82t8wzapRKcAnSaqNX2WWpnJ4iLsQOWlcJg74ddk_tV9xaJykdUtx.u
 u1eyNlWLRrfJxbZgu0nopgV4VhiPq7uGsZYz0o2iHXZQ8e0BpiJ0PIjdcUUgqU.PeGI1o3CDzuIo
 AnKlSm6Vo1aI67K9uQsFdCHE_P6bdDxTUb0We1q_.03ATaMB8ordIpIOmkSJUHGoJtOlBMeDqUaR
 Vy3Bo4WiH8BQdgO7q34G8f9n3tg0KrtZLGwXJd22.u7ryDcfRBBHBG9Bs3sJzJl8YxG2JK_AHI5x
 lnrXbp7Cz17xV2zmwhCrecuF95Tbf4iW6ShvuRH7O3j3LSMiHxz3M7ox7a1rZxY8bOUQ3cUp0TOk
 FfVEKbBVyLdlssN5TPK1W34iWZwrhPCsHiQ9jpOP64qgeMFTy.HZOuZGEgXhnQKrc8x_DBo_2yUu
 vCbb0I3qmKC5aUdann9nMfU56thKmrSVS4zwhPgCypzcP9X9npoObB52hzSTd9SH4RrUevG3Xrh_
 mm3QItVQoINHc8_UDntB8PMvGNhoMfuQpKRdolaJeyNmRhW2q7A9Ar9KPeJW_ZCaarSE9UGLgzxo
 m3vA_LgVsVOv2BzR6LKP.kOvCDvEexV.ea2WAYzMUc5hG4sv43g3PDDSonQO4P8e6zcKo.ZUGigj
 chvF5ybnibv7l0CCz_YXBUZIdKdR1pYgP5vqc5EAKdRGFYrKlu0eP3z2CEUJpviuyed6ltjhmqty
 92qpXuMVcZ6vVufSh0FtWdtbbdVoT3geQN90bhgszeJw5_cknKd3rhi_a2vzVqSr23Iae810QB0i
 HezPqoiqKGquuybWMjr_kGEkh2E57UDE6HB51Z1TtFio8XKOY9_Qz41wFgc7shIxeBU6U5FFC1Nh
 COBOr0BaI7eIe9JEVMX3Ic7NVzAHBM4O3CzmE79h.egDMV7x9LemGZIVzduXEP7nBjR9NGi_NCRt
 Hd4w8VOxj3sRqGMHGg8pcHWqeyV5WhRb0Y6XPACtB4VWKv1xKaOIDRIic57AEcajD7nvF97gWP91
 owttWSL_9DqXd_bhraHtVZZE.17J2sOQNlIhgYyRkQffnCihms_Bv3TN9VQ96KrtoyMZ8VFYCYP6
 LbbKhwdqvvOpMs5c3aLsioJEdPBjLBG0BOKyLJmE5E7O2whwVSGB8vG4q52T8yibv7HkXT5ckimx
 ED.XGLEQ6cP1NUBBZzH9xF5aIavpwPNxxz3JAd7mR_kr00Q1BrDcML55ZiArLs8D.CvQK5mNwWT3
 v4b1Yn.UJI40_BBXNzoENta6kNf7TDq92GxCEgDrxazTkZ7cjVCDJV8zjny9VaA--
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.ne1.yahoo.com with HTTP; Mon, 13 Sep 2021 19:05:16 +0000
Received: by kubenode520.mail-prod1.omega.bf1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 5d8047ec98cff2b6ea5744cf3bb39ae1;
          Mon, 13 Sep 2021 19:05:11 +0000 (UTC)
Subject: Re: [PATCH v3 0/1] Relax restrictions on user.* xattr
To:     "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc:     Vivek Goyal <vgoyal@redhat.com>, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtio-fs@redhat.com, dwalsh@redhat.com,
        christian.brauner@ubuntu.com, casey.schaufler@intel.com,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        tytso@mit.edu, miklos@szeredi.hu, gscrivan@redhat.com,
        bfields@redhat.com, stephen.smalley.work@gmail.com,
        agruenba@redhat.com, david@fromorbit.com,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20210902152228.665959-1-vgoyal@redhat.com>
 <79dcd300-a441-cdba-e523-324733f892ca@schaufler-ca.com>
 <YTEEPZJ3kxWkcM9x@redhat.com> <YTENEAv6dw9QoYcY@redhat.com>
 <3bca47d0-747d-dd49-a03f-e0fa98eaa2f7@schaufler-ca.com>
 <YTEur7h6fe4xBJRb@redhat.com>
 <1f33e6ef-e896-09ef-43b1-6c5fac40ba5f@schaufler-ca.com>
 <YTYr4MgWnOgf/SWY@work-vm>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <496e92bf-bf9e-a56b-bd73-3c1d0994a064@schaufler-ca.com>
Date:   Mon, 13 Sep 2021 12:05:07 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YTYr4MgWnOgf/SWY@work-vm>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Mailer: WebService/1.1.19013 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/6/2021 7:55 AM, Dr. David Alan Gilbert wrote:
> * Casey Schaufler (casey@schaufler-ca.com) wrote:
>> On 9/2/2021 1:06 PM, Vivek Goyal wrote:
>>>  If LSMs are not configured,
>>> then hiding the directory is the solution.
>> It's not a solution at all. It's wishful thinking that
>> some admin is going to do absolutely everything right, will
>> never make a mistake and will never, ever, read the mount(2)
>> man page.
> That is why we run our virtiofsd with a sandbox setup and seccomp; and
> frankly anything we can or could turn on we would.

That doesn't address my concern at all. Being able to create an
environment in which a feature can be used safely does not make
the feature safe.


> So why that's not a solution and only relying on CAP_SYS_ADMIN is the
> solution. I don't understand that part.

Sure you do. If you didn't, you wouldn't be so concerned about
requiring CAP_SYS_ADMIN. You're trying hard to avoid taking the
level of responsibility that running with privilege requires.
To do that, you're introducing a massive security hole, a backdoor
into the file system security attributes.

>> It comes back to your design, which is fundamentally flawed. You
>> can't store system security information in an attribute that can
>> be manipulated by untrusted entities. That's why we have system.*
>> xattrs. You want to have an attribute on the host that maps to a
>> security attribute on the guest. The host has to protect the attribute=

>> on the guest with mechanisms of comparable strength as the guest's
>> mechanisms.
> Can you just explain this line to me a bit more:=20
>> Otherwise you can't trust the guest with host data.
> Note we're not trying to trust the guest with the host data here;
> we're trying to allow the guest to store the data on the host, while
> trusting the host.

But you can't trust the host! You're allowing unprivileged processes
on the host to modify security state of the guest.

>> It's a real shame that CAP_SYS_ADMIN is so scary. The capability
>> mechanism as implemented today won't scale to the hundreds of individu=
al
>> capabilities it would need to break CAP_SYS_ADMIN up. Maybe someday.
>> I'm not convinced that there isn't a way to accomplish what you're
>> trying to do without privilege, but this isn't it, and I don't know
>> what is. Sorry.
>>
>>> Also if directory is not hidden, unprivileged users can change file
>>> data and other metadata.
>> I assumed that you've taken that into account. Are you saying that
>> isn't going to be done correctly either?
>>
>>>  Why that's not a concern and why there is
>>> so much of focus only security xattr.
>> As with an NFS mount, the assumption is that UID 567 (or its magically=

>> mapped equivalent) has the same access rights on both the server/host
>> and client/guest. I'm not worried about the mode bits because they are=

>> presented consistently on both machines. If, on the other hand, an
>> attribute used to determine access is security.esprit on the guest and=

>> user.security.esprit on the host, the unprivileged user on the host
>> can defeat the privilege requirements on the guest. That's why.
> We're OK with that;

I understand that. I  am  not  OK  with  that.

>  remember that the host can do wth it likes to the
> guest anyway

We're not talking about "the host", we're talking about an
unprivileged user on the host.

>  - it can just go in and poke at the guests RAM if it wants
> to do something evil to the guest.
> We wouldn't suggest using a scheme like this once you have
> encrypted/protected guest RAM for example (SEV/TDX etc)
>
>>>  If you were to block modification
>>> of file then you will have rely on LSMs.
>> No. We're talking about the semantics of the xattr namespaces.
>> LSMs can further constrain access to xattrs, but the basic rules
>> of access to the user.* and security.* attributes are different
>> in any case. This is by design.
> I'm happy if you can suggest somewhere else to store the guests xattr
> data other than in one of the hosts xattr's - the challenge is doing
> that in a non-racy way, and making sure that the xattr's never get
> associated with the wrong file as seen by a guest.

I'm sorry, but I've got a bunch of other stuff on my plate.
I've already suggested implementing xattr namespaces a'la user
namespaces, but I understand that is beyond the scope of your
current needs, and has its own set of dragons.

>>>  And if LSMs are not configured,
>>> then we will rely on shared directory not being visible.
>> LSMs are not the problem. LSMs use security.* xattrs, which is why
>> they come up in the discussion.
>>
>>> Can you please help me understand why hiding shared directory from
>>> unprivileged users is not a solution
>> Maybe you can describe the mechanism you use to "hide" a shared direct=
ory
>> on the host. If the filesystem is mounted on the host it seems unlikel=
y
>> that you can provide a convincing argument for sufficient protection.
> Why?

Because 99-44/100% of admins out there aren't as skilled at "hiding"
data as you are. Many (I almost said "most". I'm still not sure which.)
of them don't even know how to use mode bits correctly.

>  What can a guests fs mounted on the host, under one of the
> directories that's already typically used for container fs's do - it's
> already what fileservers, and existing container systems do.
>
> Dave
>
>
>
>>>  (With both LSMs configured or
>>> not configured on host). That's a requirement for virtiofs anyway.=20
>>> And if we agree on that, then I don't see why using "user.*" xattrs
>>> for storing guest sercurity attributes is a problem.
>>>
>>> Thanks
>>> Vivek
>>>

