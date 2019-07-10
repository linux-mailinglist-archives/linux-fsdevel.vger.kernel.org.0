Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E6FD864D2E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jul 2019 22:10:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728237AbfGJUKM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Jul 2019 16:10:12 -0400
Received: from sonic314-27.consmr.mail.ne1.yahoo.com ([66.163.189.153]:37142
        "EHLO sonic314-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727490AbfGJUKL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Jul 2019 16:10:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1562789407; bh=MzgEzhT/uukMFv7yPzkEuV5+dzkRLkWm3YkXR86xyKk=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=CENfJGvpT0m8nGXuIW7m/cVQHnrWpgqxXI344PBF8P8P1eSdKJ6IIEpi8qufrqftF4KSlmdxEi8nDHGdjvOe5HIWhpoAlNwM1EbuDR9KcIxNgp4DC3Nnvd7+dZoJK7Y2NngNonPIQ8ye0Oq1XG7D3iTl0TDeefxHc1bEcP4KsiexuhFdV6OlMJuCd0MkB/0r6nw33wnnBONmiI/jR7Ak2dLy6zRo7YzMobrqpj2/7LrMzEcON6OClpyskJBsbytpQ6EDxQQWvIWZnqDOPu/GlDrQfT/021K3RsWywxvDoivqRMdUzSfhwIcrM/w1C7R1NOUSgrya/YSuf1ztTzwOPw==
X-YMail-OSG: dYdqq3QVM1nGZhh8HkYGmZ3FVtTzaTzTXw0wXaMujWZB_Lzadzw2evxC5eyLDat
 xNHbZRTwmNqWqWNKEyakkatni2zz7xLf.O0yIV_PbkwNmwxPkeBA7MVdfPN6Yy6w4Uyu5KizlAar
 Zw7V_DXGy8dRFSwXw90x2ppTlLIzoeZ1VSRsUc1cbQLR.scEolhyI0zkeLdeRvGu7LaIWg51kDTq
 sm7Ji3bxH_4Zij.xR8o0QRNgQLnrKTT.kInYVdssnFTtXqYqU9eBnndXSCKyivOoP1b.t3dpYHf5
 0xjkQWN.I3KUYdhz.0AGN6vuNlExE4XFOKnmY0cBROEvvyV1Om1IRh6UyN6kd14yrZaPelHdvjX7
 hjuINBAIh1QCTndb2cA9erVNEnK6zCZ60xEa9X0pOA3D3aeoliihLOGLbEIkz47LCJE6gQNrPnQC
 vuPfm7VTIViulZ5.yxz_2AWCFoSeAy.3et9Z_uqFOoAzmw.YyZ.AOz5hrj9v9qasIVu1ONTEyk7T
 tFeoW4QdNneqrP8s_iAVfA1xkZPsAfakvbxRPYVAMsoksb2BdlirSTfLp6QL_8pXAqFQWaGD9Ofx
 xGrI83knVQNSLNtZywsLtKpJL_5viDgnADi8CTIzDz7fTNRYRFH0x4EGQOXLUV5By89NSVURViui
 8hd21KL.blCzZM1Y1NxEnwIJ5ikHHhFU.7MwY30rdqZW161fkCfvstYPp4HphZG.eql2UNiEtMXN
 9.QQqKLUdYSh19hV_r3b2JtYwijYhG_gcD.5UxQLUIKuu73phb3dp0LBDl0AdZRL9hPYCcJc9gvi
 m1ruyFpBFw2sLdq9F2dH0ODnM09XAwgeyvb6_gnt1RI.dW3SipG_Zx5ckwNZQmbIbv_3dFqMUxoa
 MOe0PWLS91aaxXmniPmbkgYkmhhw0b7HmL528jiqviSph5zTvLIjzVBLokfWIWvuTrmlRBTU6DBG
 AfkDl_doApCoMVvs1auH5An.7Rypm7d0eNT.32vhXLJRdCKXLG0l19fuSXUkx_UUhPY_UaAkz.Iv
 c239EWLRhlQmVkSAsTGU0Hcq.FqSyWa_TBaKcUv1t_s8BHwjj45BxvvlXGdO_qNrwPm2dwNuJS1_
 oPs03xIkBmN7nu.Tw.7mFXoJCCtWyPkVBGONz0dZj24TPNlXT.xybGIHYpCmm.TRMIIUEp_JZBIP
 MJmllQZVN4Zuyo8wd5MejmFUysz5CawTYcf6kgfC2OlT2zaNW3heLvbVfIyW_L4M6MiQywlr3pRm
 VUQTkujf0tQZKt4qDLoAeE8s8VORg9mMvrPKcYPfeL1narDc-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.ne1.yahoo.com with HTTP; Wed, 10 Jul 2019 20:10:07 +0000
Received: by smtp415.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 5c5a0cb4af25d4479cf2f21c5c7f3409;
          Wed, 10 Jul 2019 20:10:06 +0000 (UTC)
Subject: Re: [RFC PATCH] fanotify, inotify, dnotify, security: add security
 hook for fs notifications
To:     Stephen Smalley <sds@tycho.nsa.gov>,
        Aaron Goidel <acgoide@tycho.nsa.gov>, paul@paul-moore.com
Cc:     selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, dhowells@redhat.com, jack@suse.cz,
        amir73il@gmail.com, jmorris@namei.org,
        linux-kernel@vger.kernel.org, casey@schaufler-ca.com
References: <20190710133403.855-1-acgoide@tycho.nsa.gov>
 <4fd98c88-61a6-a155-5028-db22a778d3c1@schaufler-ca.com>
 <8edfc3d7-9944-9aed-061b-b81f54ebddc3@tycho.nsa.gov>
From:   Casey Schaufler <casey@schaufler-ca.com>
Openpgp: preference=signencrypt
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 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
 abzjfg==
Message-ID: <cf77e582-b6d8-091c-f760-e349574e3224@schaufler-ca.com>
Date:   Wed, 10 Jul 2019 13:09:53 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <8edfc3d7-9944-9aed-061b-b81f54ebddc3@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/10/2019 11:39 AM, Stephen Smalley wrote:
> On 7/10/19 12:38 PM, Casey Schaufler wrote:
>> On 7/10/2019 6:34 AM, Aaron Goidel wrote:
>>> As of now, setting watches on filesystem objects has, at most, applie=
d a
>>> check for read access to the inode, and in the case of fanotify, requ=
ires
>>> CAP_SYS_ADMIN. No specific security hook or permission check has been=

>>> provided to control the setting of watches. Using any of inotify, dno=
tify,
>>> or fanotify, it is possible to observe, not only write-like operation=
s, but
>>> even read access to a file. Modeling the watch as being merely a read=
 from
>>> the file is insufficient.
>>
>> That's a very model-specific viewpoint. It is true for
>> a fine-grained model such as SELinux, but not necessarily
>> for a model with more traditional object definitions.
>> I'm not saying you're wrong, I'm saying that stating it
>> as a given assumes your model. You can do that all you want
>> within SELinux, but it doesn't hold when you're talking
>> about the LSM infrastructure.
>
> I think you'll find that even for Smack, merely checking read access to=
 the watched inode is insufficient for your purposes, because the watch p=
ermits more than just observing changes to the state of the inode.=C2=A0 =
The absence of a hook is a gap in LSM coverage, regardless of security mo=
del.=C2=A0 If you are just objecting to the wording choice, then I suppos=
e that can be amended to "is insufficient for SELinux" or "is insufficien=
t for some needs" or something.

More an objection to the assumption of model than anything else.
There are enough differing viewpoints on what is necessary and/or
sufficient that I wouldn't want the assumption to be a bone of
contention later on.

>
>> Have you coordinated this with the work that David Howells
>> is doing on generic notifications?
>
> We're following that work but to date it hasn't appeared to address dno=
tify/inotify/fanotify IIUC.=C2=A0 I think it is complementary; we are add=
ing LSM control over an existing kernel notification mechanism while he i=
s adding a new notification facility for other kinds of events along with=
 corresponding LSM hooks.=C2=A0 It is consistent in that it provides a wa=
y to control setting of watches based on the watched object.

All true. My hope is that LSM controls on notification mechanisms
have some sort of coordination. I'd rather have one hook that's used
in multiple places than yet another set of disparate hooks that do
mostly the same thing.

>
>>> Furthermore, fanotify watches grant more power to
>>> an application in the form of permission events. While notification e=
vents
>>> are solely, unidirectional (i.e. they only pass information to the
>>> receiving application), permission events are blocking. Permission ev=
ents
>>> make a request to the receiving application which will then reply wit=
h a
>>> decision as to whether or not that action may be completed.
>>
>> You're not saying why this is an issue.
>
> It allows the watching application control over the process that is att=
empting the access.=C2=A0 Are you just asking for that to be stated more =
explicitly?

Yes, that would be good.

>
>>> In order to solve these issues, a new LSM hook is implemented and has=
 been
>>> placed within the system calls for marking filesystem objects with in=
otify,
>>> fanotify, and dnotify watches. These calls to the hook are placed at =
the
>>> point at which the target inode has been resolved and are provided wi=
th
>>> both the inode and the mask of requested notification events. The mas=
k has
>>> already been translated into common FS_* values shared by the entiret=
y of
>>> the fs notification infrastructure.
>>>
>>> This only provides a hook at the point of setting a watch, and presum=
es
>>> that permission to set a particular watch implies the ability to rece=
ive
>>> all notification about that object which match the mask. This is all =
that
>>> is required for SELinux. If other security modules require additional=
 hooks
>>> or infrastructure to control delivery of notification, these can be a=
dded
>>> by them. It does not make sense for us to propose hooks for which we =
have
>>> no implementation. The understanding that all notifications received =
by the
>>> requesting application are all strictly of a type for which the appli=
cation
>>> has been granted permission shows that this implementation is suffici=
ent in
>>> its coverage.
>>
>> A reasonable approach. It would be *nice* if you had
>> a look at the other security modules to see what they
>> might need from such a hook or hook set.
>>
>>> Fanotify further has the issue that it returns a file descriptor with=
 the
>>> file mode specified during fanotify_init() to the watching process on=

>>> event. This is already covered by the LSM security_file_open hook if =
the
>>> security module implements checking of the requested file mode there.=

>>
>> How is this relevant?
>
> It is part of ensuring complete control over fanotify.=C2=A0 Some exist=
ing security modules (like Smack, for example) currently do not perform t=
his checking of the requested file mode and therefore are subject to this=
 privilege escalation scenario through fanotify.=C2=A0 A watcher that onl=
y has read access to the file can get a read-write descriptor to it in th=
is manner.=C2=A0 You may argue that this doesn't matter because fanotify =
requires CAP_SYS_ADMIN but even for Smack that isn't the same as CAP_MAC_=
OVERRIDE.

Yes, there's a difference in the assumptions security modules
make about the privilege escalation. Again the point is that
it isn't a good idea to include a single module's policy regarding
that in the argument for the generic hook. It's enough to explain
why SELinux needs it.

>
>>
>>> The selinux_inode_notify hook implementation works by adding three ne=
w
>>> file permissions: watch, watch_reads, and watch_with_perm (descriptio=
ns
>>> about which will follow). The hook then decides which subset of these=

>>> permissions must be held by the requesting application based on the
>>> contents of the provided mask. The selinux_file_open hook already che=
cks
>>> the requested file mode and therefore ensures that a watching process=

>>> cannot escalate its access through fanotify.
>>
>> Thereby increasing the granularity of control available.
>
> It isn't merely a question of granularity but also completeness and pre=
venting privilege escalation.

I was simply making an observation.

>
>>> The watch permission is the baseline permission for setting a watch o=
n an
>>> object and is a requirement for any watch to be set whatsoever. It sh=
ould
>>> be noted that having either of the other two permissions (watch_reads=
 and
>>> watch_with_perm) does not imply the watch permission, though this cou=
ld be
>>> changed if need be.
>>>
>>> The watch_reads permission is required to receive notifications from
>>> read-exclusive events on filesystem objects. These events include acc=
essing
>>> a file for the purpose of reading and closing a file which has been o=
pened
>>> read-only. This distinction has been drawn in order to provide a dire=
ct
>>> indication in the policy for this otherwise not obvious capability. R=
ead
>>> access to a file should not necessarily imply the ability to observe =
read
>>> events on a file.
>>>
>>> Finally, watch_with_perm only applies to fanotify masks since it is t=
he
>>> only way to set a mask which allows for the blocking, permission even=
t.
>>> This permission is needed for any watch which is of this type. Though=

>>> fanotify requires CAP_SYS_ADMIN, this is insufficient as it gives imp=
licit
>>> trust to root, which we do not do, and does not support least privile=
ge.
>>>
>>> Signed-off-by: Aaron Goidel <acgoide@tycho.nsa.gov>
>>> ---
>>> =C2=A0 fs/notify/dnotify/dnotify.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 | 14 +++++++++++---
>>> =C2=A0 fs/notify/fanotify/fanotify_user.c=C2=A0 | 11 +++++++++--
>>> =C2=A0 fs/notify/inotify/inotify_user.c=C2=A0=C2=A0=C2=A0 | 12 ++++++=
++++--
>>> =C2=A0 include/linux/lsm_hooks.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2 ++
>>> =C2=A0 include/linux/security.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 7 +++++++
>>> =C2=A0 security/security.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 5 +++++
>>> =C2=A0 security/selinux/hooks.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 22 ++++++++++++++++++++++
>>> =C2=A0 security/selinux/include/classmap.h |=C2=A0 2 +-
>>> =C2=A0 8 files changed, 67 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/fs/notify/dnotify/dnotify.c b/fs/notify/dnotify/dnotify.=
c
>>> index 250369d6901d..e91ce092efb1 100644
>>> --- a/fs/notify/dnotify/dnotify.c
>>> +++ b/fs/notify/dnotify/dnotify.c
>>> @@ -22,6 +22,7 @@
>>> =C2=A0 #include <linux/sched/signal.h>
>>> =C2=A0 #include <linux/dnotify.h>
>>> =C2=A0 #include <linux/init.h>
>>> +#include <linux/security.h>
>>> =C2=A0 #include <linux/spinlock.h>
>>> =C2=A0 #include <linux/slab.h>
>>> =C2=A0 #include <linux/fdtable.h>
>>> @@ -288,6 +289,16 @@ int fcntl_dirnotify(int fd, struct file *filp, u=
nsigned long arg)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto out_err;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> =C2=A0 +=C2=A0=C2=A0=C2=A0 /*
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * convert the userspace DN_* "arg" to the i=
nternal FS_*
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * defined in fsnotify
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 */
>>> +=C2=A0=C2=A0=C2=A0 mask =3D convert_arg(arg);
>>> +
>>> +=C2=A0=C2=A0=C2=A0 error =3D security_inode_notify(inode, mask);
>>> +=C2=A0=C2=A0=C2=A0 if (error)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto out_err;
>>> +
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* expect most fcntl to add new rather=
 than augment old */
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dn =3D kmem_cache_alloc(dnotify_struct=
_cache, GFP_KERNEL);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!dn) {
>>> @@ -302,9 +313,6 @@ int fcntl_dirnotify(int fd, struct file *filp, un=
signed long arg)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto out_err;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> =C2=A0 -=C2=A0=C2=A0=C2=A0 /* convert the userspace DN_* "arg" to the=
 internal FS_* defines in fsnotify */
>>> -=C2=A0=C2=A0=C2=A0 mask =3D convert_arg(arg);
>>> -
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* set up the new_fsn_mark and new_dn_=
mark */
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 new_fsn_mark =3D &new_dn_mark->fsn_mar=
k;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fsnotify_init_mark(new_fsn_mark, dnoti=
fy_group);
>>> diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/=
fanotify_user.c
>>> index a90bb19dcfa2..c0d9fa998377 100644
>>> --- a/fs/notify/fanotify/fanotify_user.c
>>> +++ b/fs/notify/fanotify/fanotify_user.c
>>> @@ -528,7 +528,7 @@ static const struct file_operations fanotify_fops=
 =3D {
>>> =C2=A0 };
>>> =C2=A0 =C2=A0 static int fanotify_find_path(int dfd, const char __use=
r *filename,
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct path *path, unsigned int flags)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct path *path, unsigned int flags, =
__u64 mask)
>>> =C2=A0 {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int ret;
>>> =C2=A0 @@ -567,8 +567,15 @@ static int fanotify_find_path(int dfd, co=
nst char __user *filename,
>>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* you can only watch an inode =
if you have read permissions on it */
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D inode_permission(path->dentry-=
>d_inode, MAY_READ);
>>> +=C2=A0=C2=A0=C2=A0 if (ret) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 path_put(path);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto out;
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +
>>> +=C2=A0=C2=A0=C2=A0 ret =3D security_inode_notify(path->dentry->d_ino=
de, mask);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 path_put(path)=
;
>>> +
>>> =C2=A0 out:
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
>>> =C2=A0 }
>>> @@ -1014,7 +1021,7 @@ static int do_fanotify_mark(int fanotify_fd, un=
signed int flags, __u64 mask,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto fput_and_=
out;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> =C2=A0 -=C2=A0=C2=A0=C2=A0 ret =3D fanotify_find_path(dfd, pathname, =
&path, flags);
>>> +=C2=A0=C2=A0=C2=A0 ret =3D fanotify_find_path(dfd, pathname, &path, =
flags, mask);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto fput_and_=
out;
>>> =C2=A0 diff --git a/fs/notify/inotify/inotify_user.c b/fs/notify/inot=
ify/inotify_user.c
>>> index 7b53598c8804..47b079f20aad 100644
>>> --- a/fs/notify/inotify/inotify_user.c
>>> +++ b/fs/notify/inotify/inotify_user.c
>>> @@ -39,6 +39,7 @@
>>> =C2=A0 #include <linux/poll.h>
>>> =C2=A0 #include <linux/wait.h>
>>> =C2=A0 #include <linux/memcontrol.h>
>>> +#include <linux/security.h>
>>> =C2=A0 =C2=A0 #include "inotify.h"
>>> =C2=A0 #include "../fdinfo.h"
>>> @@ -342,7 +343,8 @@ static const struct file_operations inotify_fops =
=3D {
>>> =C2=A0 /*
>>> =C2=A0=C2=A0 * find_inode - resolve a user-given path to a specific i=
node
>>> =C2=A0=C2=A0 */
>>> -static int inotify_find_inode(const char __user *dirname, struct pat=
h *path, unsigned flags)
>>> +static int inotify_find_inode(const char __user *dirname, struct pat=
h *path,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uns=
igned int flags, __u64 mask)
>>> =C2=A0 {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int error;
>>> =C2=A0 @@ -351,8 +353,14 @@ static int inotify_find_inode(const char =
__user *dirname, struct path *path, uns
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return error;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* you can only watch an inode if you =
have read permissions on it */
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error =3D inode_permission(path->dentr=
y->d_inode, MAY_READ);
>>> +=C2=A0=C2=A0=C2=A0 if (error) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 path_put(path);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return error;
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +=C2=A0=C2=A0=C2=A0 error =3D security_inode_notify(path->dentry->d_i=
node, mask);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (error)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 path_put(path)=
;
>>> +
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return error;
>>> =C2=A0 }
>>> =C2=A0 @@ -744,7 +752,7 @@ SYSCALL_DEFINE3(inotify_add_watch, int, fd=
, const char __user *, pathname,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (mask & IN_ONLYDIR)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 flags |=3D LOO=
KUP_DIRECTORY;
>>> =C2=A0 -=C2=A0=C2=A0=C2=A0 ret =3D inotify_find_inode(pathname, &path=
, flags);
>>> +=C2=A0=C2=A0=C2=A0 ret =3D inotify_find_inode(pathname, &path, flags=
, mask);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto fput_and_=
out;
>>> =C2=A0 diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hoo=
ks.h
>>> index 47f58cfb6a19..ef6b74938dd8 100644
>>> --- a/include/linux/lsm_hooks.h
>>> +++ b/include/linux/lsm_hooks.h
>>
>> Hook description comment is missing.
>>
>>> @@ -1571,6 +1571,7 @@ union security_list_options {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int (*inode_getxattr)(struct dentry *d=
entry, const char *name);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int (*inode_listxattr)(struct dentry *=
dentry);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int (*inode_removexattr)(struct dentry=
 *dentry, const char *name);
>>> +=C2=A0=C2=A0=C2=A0 int (*inode_notify)(struct inode *inode, u64 mask=
);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int (*inode_need_killpriv)(struct dent=
ry *dentry);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int (*inode_killpriv)(struct dentry *d=
entry);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int (*inode_getsecurity)(struct inode =
*inode, const char *name,
>>> @@ -1881,6 +1882,7 @@ struct security_hook_heads {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct hlist_head inode_getxattr;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct hlist_head inode_listxattr;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct hlist_head inode_removexattr;
>>> +=C2=A0=C2=A0=C2=A0 struct hlist_head inode_notify;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct hlist_head inode_need_killpriv;=

>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct hlist_head inode_killpriv;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct hlist_head inode_getsecurity;
>>> diff --git a/include/linux/security.h b/include/linux/security.h
>>> index 659071c2e57c..50106fb9eef9 100644
>>> --- a/include/linux/security.h
>>> +++ b/include/linux/security.h
>>> @@ -301,6 +301,7 @@ int security_inode_listsecurity(struct inode *ino=
de, char *buffer, size_t buffer
>>> =C2=A0 void security_inode_getsecid(struct inode *inode, u32 *secid);=

>>> =C2=A0 int security_inode_copy_up(struct dentry *src, struct cred **n=
ew);
>>> =C2=A0 int security_inode_copy_up_xattr(const char *name);
>>> +int security_inode_notify(struct inode *inode, u64 mask);
>>> =C2=A0 int security_kernfs_init_security(struct kernfs_node *kn_dir,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct kernfs_node *kn);
>>> =C2=A0 int security_file_permission(struct file *file, int mask);
>>> @@ -392,6 +393,7 @@ void security_inode_invalidate_secctx(struct inod=
e *inode);
>>> =C2=A0 int security_inode_notifysecctx(struct inode *inode, void *ctx=
, u32 ctxlen);
>>> =C2=A0 int security_inode_setsecctx(struct dentry *dentry, void *ctx,=
 u32 ctxlen);
>>> =C2=A0 int security_inode_getsecctx(struct inode *inode, void **ctx, =
u32 *ctxlen);
>>> +
>>
>> Please don't change whitespace unless it's directly adjacent to your c=
ode.
>>
>>> =C2=A0 #else /* CONFIG_SECURITY */
>>> =C2=A0 =C2=A0 static inline int call_lsm_notifier(enum lsm_event even=
t, void *data)
>>> @@ -776,6 +778,11 @@ static inline int security_inode_removexattr(str=
uct dentry *dentry,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return cap_inode_removexattr(dentry, n=
ame);
>>> =C2=A0 }
>>> =C2=A0 +static inline int security_inode_notify(struct inode *inode, =
u64 mask)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 return 0;
>>> +}
>>> +
>>> =C2=A0 static inline int security_inode_need_killpriv(struct dentry *=
dentry)
>>> =C2=A0 {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return cap_inode_need_killpriv(dentry)=
;
>>> diff --git a/security/security.c b/security/security.c
>>> index 613a5c00e602..57b2a96c1991 100644
>>> --- a/security/security.c
>>> +++ b/security/security.c
>>> @@ -1251,6 +1251,11 @@ int security_inode_removexattr(struct dentry *=
dentry, const char *name)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return evm_inode_removexattr(dentry, n=
ame);
>>> =C2=A0 }
>>> =C2=A0 +int security_inode_notify(struct inode *inode, u64 mask)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 return call_int_hook(inode_notify, 0, inode, mask=
);
>>> +}
>>> +
>>> =C2=A0 int security_inode_need_killpriv(struct dentry *dentry)
>>> =C2=A0 {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return call_int_hook(inode_need_killpr=
iv, 0, dentry);
>>> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
>>> index c61787b15f27..1a37966c2978 100644
>>> --- a/security/selinux/hooks.c
>>> +++ b/security/selinux/hooks.c
>>> @@ -92,6 +92,7 @@
>>> =C2=A0 #include <linux/kernfs.h>
>>> =C2=A0 #include <linux/stringhash.h>=C2=A0=C2=A0=C2=A0 /* for hashlen=
_string() */
>>> =C2=A0 #include <uapi/linux/mount.h>
>>> +#include <linux/fsnotify.h>
>>> =C2=A0 =C2=A0 #include "avc.h"
>>> =C2=A0 #include "objsec.h"
>>> @@ -3261,6 +3262,26 @@ static int selinux_inode_removexattr(struct de=
ntry *dentry, const char *name)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EACCES;
>>> =C2=A0 }
>>> =C2=A0 +static int selinux_inode_notify(struct inode *inode, u64 mask=
)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 u32 perm =3D FILE__WATCH; // basic permission, ca=
n a watch be set?
>>
>> We don't use // comments in the Linux kernel.
>>
>>> +
>>> +=C2=A0=C2=A0=C2=A0 struct common_audit_data ad;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 ad.type =3D LSM_AUDIT_DATA_INODE;
>>> +=C2=A0=C2=A0=C2=A0 ad.u.inode =3D inode;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 // check if the mask is requesting ability to set=
 a blocking watch
>>> +=C2=A0=C2=A0=C2=A0 if (mask & (FS_OPEN_PERM | FS_OPEN_EXEC_PERM | FS=
_ACCESS_PERM))
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 perm |=3D FILE__WATCH_WIT=
H_PERM; // if so, check that permission
>>> +
>>> +=C2=A0=C2=A0=C2=A0 // is the mask asking to watch file reads?
>>> +=C2=A0=C2=A0=C2=A0 if (mask & (FS_ACCESS | FS_ACCESS_PERM | FS_CLOSE=
_NOWRITE))
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 perm |=3D FILE__WATCH_REA=
DS; // check that permission as well
>>> +
>>> +=C2=A0=C2=A0=C2=A0 return inode_has_perm(current_cred(), inode, perm=
, &ad);
>>> +}
>>> +
>>> =C2=A0 /*
>>> =C2=A0=C2=A0 * Copy the inode security context value to the user.
>>> =C2=A0=C2=A0 *
>>> @@ -6797,6 +6818,7 @@ static struct security_hook_list selinux_hooks[=
] __lsm_ro_after_init =3D {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 LSM_HOOK_INIT(inode_getsecid, selinux_=
inode_getsecid),
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 LSM_HOOK_INIT(inode_copy_up, selinux_i=
node_copy_up),
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 LSM_HOOK_INIT(inode_copy_up_xattr, sel=
inux_inode_copy_up_xattr),
>>> +=C2=A0=C2=A0=C2=A0 LSM_HOOK_INIT(inode_notify, selinux_inode_notify)=
,
>>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 LSM_HOOK_INIT(kernfs_init_secur=
ity, selinux_kernfs_init_security),
>>> =C2=A0 diff --git a/security/selinux/include/classmap.h b/security/se=
linux/include/classmap.h
>>> index 201f7e588a29..0654dd2fbebf 100644
>>> --- a/security/selinux/include/classmap.h
>>> +++ b/security/selinux/include/classmap.h
>>> @@ -7,7 +7,7 @@
>>> =C2=A0 =C2=A0 #define COMMON_FILE_PERMS COMMON_FILE_SOCK_PERMS, "unli=
nk", "link", \
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "rename", "execute", "quotaon", "mount=
on", "audit_access", \
>>> -=C2=A0=C2=A0=C2=A0 "open", "execmod"
>>> +=C2=A0=C2=A0=C2=A0 "open", "execmod", "watch", "watch_with_perm", "w=
atch_reads"
>>> =C2=A0 =C2=A0 #define COMMON_SOCK_PERMS COMMON_FILE_SOCK_PERMS, "bind=
", "connect", \
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "listen", "accept", "getopt", "setopt"=
, "shutdown", "recvfrom",=C2=A0 \
>>
>

