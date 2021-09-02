Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 088E33FF39A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Sep 2021 20:55:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347156AbhIBS4Y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Sep 2021 14:56:24 -0400
Received: from sonic308-15.consmr.mail.ne1.yahoo.com ([66.163.187.38]:41145
        "EHLO sonic308-15.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1347182AbhIBS4T (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Sep 2021 14:56:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1630608919; bh=0WOeJpk/zazIMthMyub2nCD0LfMvutspgWyuKpVKBQ8=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject:Reply-To; b=dm+1+cFX1mXKPPvenxSl5lSM0hXw7HZgEyBytyO34ugBwSbNWHENw/W4vnj3js5wy+ZFRFYxdZ7wQlgyfU60mRCp23Qa/ASY9c37dTfG6yVSjVBzy8eZSOJY24IRDDOCbYMRtsZUqVNi7TGXSFhM5UDi0b5HiTzoVo1UnUEYmRn9zYF6sBxaoNLe6SvQT5Lhn9E93PHm8ZzcgH7nOQszLR2rsgf4lQehRlUm9S3uMzyf7zAdFgXyFiOO0LP5U4efKRDmjiccgAGpM5gcIudCct6lyrs+VgfnqHIJ1Q204VQT+NkMrv0loFCvrWnHA+G2E85ziU4BkbkUQpnGYjgPGQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1630608919; bh=1Xtx0bDAJIi5P8PdlWEisRpQ9wjTIKOu/DTJPSYgtKo=; h=X-Sonic-MF:Subject:To:From:Date:From:Subject; b=LU+yKezY1IHcXtNVwjPDcUw/Wu1Ic5/gy5UZwFm7vyvxC4EhoZp8S0As8Wcws/HgfB7bhGOGqTHo3ATMSi53Z22m/gla9W0tYIZEPOxVGfeMnWn5B2pQchUHCXgmmPNUwlPnYK+Au7mUATi4qF1iMqd07M56d2c1zaL5+2huVFgxG4uDmwpIDCnJ8NTu7+xPQ6eSGm02ICTLbuXkP9PAsbKtzGwcCkCirzK+8ASAHz1K+TmATZnuSXdX4LMdFsrL26mnBMGj5FjoBUsvPZMxahWdWmIXgTIrw5RhdAIysKOzsrkc8mcrBQ70y1u/vIdeRWZ97QZczVBugCIvbM/pLg==
X-YMail-OSG: nPUKm7MVM1llNN5jCWhNCIAaOoOqRogcLaoS9aPriR00O3Jmahp97eDihP8HsQf
 l_AJxpya68H968tmfJsRMHkT5wjB68TPgWZkWmMlrnI0KKrPwlQCHoYnqzk76.D0chxk7gZgp4ga
 wV2c3prfn35qYKK6Qw5d4nAHSc_gFyUJCKhUN7OZBVuevxzEtFF3SIxAhod6sbZXFbFJ595ftuhZ
 NlLBk1pxEYTo_IgOTIc4pnFJOhD4_.7MDvHp1FLDH6sWz4T9JV08khSLGrdblKEXsH1AdfO_7KL0
 .BlHbJbQ9V2celSbBz77oH5royLYIamGWUIPu8QIfiwNOQO7duJRKuPdXrjQrYwifj8g8cBUQjfI
 OkciLChE_ubtl1L.GlJq7zziIIS3BeAvytL4MKF2U0OelmDxoOFzATM2H3o1oIN61t661kMhEiRt
 3UZSG3kbiWo8y0eklWnRzIgrr2XIcEoYujPeQzYJ8.EFtCeKuNpeWOEcqqtHodOCSffKqx5qm9dF
 3vj60h16B9bsD67pHo8I0oBtof15KKvN5ytg5L.hIuyB_u8wifgmuoG9OuZE3MQITih3wCrMA1D8
 GRJrYD4hI.Ijg3c1alL04TFAR.7YNSQ5JnHwxm1aN7CB6PjJI2TCyu1m_.yFf1RqkgHvKohnR1jc
 h_py9ZT1cturacEyZDRzP8jDpp.8OEifoTRbUFN5XTpIcSfFCfFU3tnCQmF4gu1w5Rw3UrzjLfy6
 cp6r2OZ.tt00tGqZTwNnQSPfWbXRd_S20y1eGZeXC_WrGRifO_5iRdoJDcqTmJNPMSmXo.O7k79R
 4y9VK6h270FC2jnfFEsNV5gvAFfhv_870pYkzk3Jmwb6vbHqVHxa7GaYTDklCww.WRoJclWiE0CO
 TeNCJzap1Q._SnRVY1RI9at_1_HVQtYLDo47C6_x2WHNXuT6XL9z44t25mD6o3zltceCgHu3vigh
 _PbR6M1Ayr0Lj94RkMFPe0JZjgI.JV_mnjnYqTWt7ppT0N2GMp5oFlu4_f3OajYKh5jlAQjvXecT
 dfSZ4JLfq4n_Aap8_BXc5V0dbIYhUVrdYMjogg9hdXQn5w_rTQPSsJ7P3Wj61.cEMSHUJBNyDJTP
 B5JELiWbI9xyGNMQxKoxIS9_3bFx9NJ5ArKZeacXv2qMgJRIXs5wdXWUDgobP0nNBWfnLU5TgFTr
 _QF7I7ReyC1CWy0IOX0p_AD7eJsYh7QdTORfYb8finBv3voxCsbu2JuWpVzpfwHFkGtIGC.QK5PZ
 ul.YIYs87p2bx_PsWVITJQ28a9IUY14lt8_3xVsZ5KNLbQcBodJ8zoL_sSIIqTl5uEEsoPJj0AHp
 DRKdiHNXSib2FBKuVXWN_ZfqOnNg586WHAJkqRmYu4tjKthURNi_7dsLmFLMbaxwSt.URbIkCFh2
 KJp3CLW8bgCr95goLct.So2l4bqu0si7P4amPLlz7KOrVxWuMpxfFSCI6T5IQ8Dt.fPn5Nbh_dtK
 eJrUJQ4.zuq2TupRaKMMbESCH7sAT1GQvXPU6viJDiBiS8VsFHRGhWeYg4uvTg_mrxRM.fGZ5K9M
 02zLrP3SSeNIfHjqgTUqLRLBC.1R.eDoeCX.bWEE320UjLC3IC0n2zgrMPODCCKeIWp0hcvvYeOa
 8jD8kopQ2jNaiA2BrpL7UmPhaz9do_tV.7c_v_3TfAHd5dsHOBH0M5ec.rtz_Tl4caa_sR.hh84J
 N0SJm.sAbCTX.voVXzanw42rmaldD2TQdQBRB1A8SLknSuHCaHAanZFImGp56Li7PwUPNzx8eSBE
 1ypaITgFQEqBDHWpCqeTUR3DuQR579xhmCTIa0wTm31vbRyXNVvADmtE.BRnj5xP76gTYoZZFr.J
 SGZEDHqdRaqamvin7azleh87.105W9cDOnJsBpFtQyq2gMdjmUF4Wk_njrPWAdFgrxTMH9amLzzI
 4SP.yoyzZ6ahqX9VrL.aKUWtT0zB1oqlsEJ7bvUiPbwgF076O6QlkMJxlXau.knlCC6zvJf0qH17
 EXnUnDau5mnbewdGhdeU65Wy8aqcyCLK4HiY.dE_cFiWwQ6Q23TttwCX9NRcAcjRX6uL6mrGxkev
 Y8oRKxNV.3YKGjMwGyQ8OCAPvh2uVMFYLlKaW3zsr6asAEf4mUb3eTrsfeKa.588nNfzR4cmiJti
 u5GFks7rlCTF.g2rn9DvQxl5dDo8GQnqLaIDrgMWou_FJjxodXvzba6NSU6WO9itD2lL3NuDR0FW
 fmEfAU8qsRYhjhfKGqWrVTT8SqlDu_8VotOaDvb6bg5kWRoVyz0KLfAAWCLmUjjr3RKKQplOudiP
 DIF_CJHtqVOngIZz4jJebtnBOJJnd.E_oj3bFd4JOwa.8ssSEbizp4hPY3iaVrsWUhWjqRq9ZpyI
 9HsryI.CvQED2hiskjyaIpCHGizUvaXwVef0O_SXNA1Xbq.GRDepHkiO6Ou3DkNpR_dVQW0jtHtr
 emt3aZChmrFcr
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.ne1.yahoo.com with HTTP; Thu, 2 Sep 2021 18:55:19 +0000
Received: by kubenode547.mail-prod1.omega.bf1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 13fdf96c7e3db0dad6d6bf59b80ecbdc;
          Thu, 02 Sep 2021 18:55:15 +0000 (UTC)
Subject: Re: [PATCH v3 0/1] Relax restrictions on user.* xattr
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, virtio-fs@redhat.com,
        dwalsh@redhat.com, dgilbert@redhat.com,
        christian.brauner@ubuntu.com, casey.schaufler@intel.com,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        tytso@mit.edu, miklos@szeredi.hu, gscrivan@redhat.com,
        bfields@redhat.com, stephen.smalley.work@gmail.com,
        agruenba@redhat.com, david@fromorbit.com,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20210902152228.665959-1-vgoyal@redhat.com>
 <79dcd300-a441-cdba-e523-324733f892ca@schaufler-ca.com>
 <YTEEPZJ3kxWkcM9x@redhat.com> <YTENEAv6dw9QoYcY@redhat.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <3bca47d0-747d-dd49-a03f-e0fa98eaa2f7@schaufler-ca.com>
Date:   Thu, 2 Sep 2021 11:55:11 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YTENEAv6dw9QoYcY@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Mailer: WebService/1.1.18924 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/2/2021 10:42 AM, Vivek Goyal wrote:
> On Thu, Sep 02, 2021 at 01:05:01PM -0400, Vivek Goyal wrote:
>> On Thu, Sep 02, 2021 at 08:43:50AM -0700, Casey Schaufler wrote:
>>> On 9/2/2021 8:22 AM, Vivek Goyal wrote:
>>>> Hi,
>>>>
>>>> This is V3 of the patch. Previous versions were posted here.
>>>>
>>>> v2:
>>>> https://lore.kernel.org/linux-fsdevel/20210708175738.360757-1-vgoyal=
@redhat.com/
>>>> v1:
>>>> https://lore.kernel.org/linux-fsdevel/20210625191229.1752531-1-vgoya=
l@redhat.co
>>>> +m/
>>>>
>>>> Changes since v2
>>>> ----------------
>>>> - Do not call inode_permission() for special files as file mode bits=

>>>>   on these files represent permissions to read/write from/to device
>>>>   and not necessarily permission to read/write xattrs. In this case
>>>>   now user.* extended xattrs can be read/written on special files
>>>>   as long as caller is owner of file or has CAP_FOWNER.
>>>> =20
>>>> - Fixed "man xattr". Will post a patch in same thread little later. =
(J.
>>>>   Bruce Fields)
>>>>
>>>> - Fixed xfstest 062. Changed it to run only on older kernels where
>>>>   user extended xattrs are not allowed on symlinks/special files. Ad=
ded
>>>>   a new replacement test 648 which does exactly what 062. Just that
>>>>   it is supposed to run on newer kernels where user extended xattrs
>>>>   are allowed on symlinks and special files. Will post patch in=20
>>>>   same thread (Ted Ts'o).
>>>>
>>>> Testing
>>>> -------
>>>> - Ran xfstest "./check -g auto" with and without patches and did not=

>>>>   notice any new failures.
>>>>
>>>> - Tested setting "user.*" xattr with ext4/xfs/btrfs/overlay/nfs
>>>>   filesystems and it works.
>>>> =20
>>>> Description
>>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>>>
>>>> Right now we don't allow setting user.* xattrs on symlinks and speci=
al
>>>> files at all. Initially I thought that real reason behind this
>>>> restriction is quota limitations but from last conversation it seeme=
d
>>>> that real reason is that permission bits on symlink and special file=
s
>>>> are special and different from regular files and directories, hence
>>>> this restriction is in place. (I tested with xfs user quota enabled =
and
>>>> quota restrictions kicked in on symlink).
>>>>
>>>> This version of patch allows reading/writing user.* xattr on symlink=
 and
>>>> special files if caller is owner or priviliged (has CAP_FOWNER) w.r.=
t inode.
>>> This part of your project makes perfect sense. There's no good
>>> security reason that you shouldn't set user.* xattrs on symlinks
>>> and/or special files.
>>>
>>> However, your virtiofs use case is unreasonable.
>> Ok. So we can merge this patch irrespective of the fact whether virtio=
fs
>> should make use of this mechanism or not, right?

I don't see a security objection. I did see that Andreas Gruenbacher
<agruenba@redhat.com> has objections to the behavior.


>>>> Who wants to set user.* xattr on symlink/special files
>>>> -----------------------------------------------------
>>>> I have primarily two users at this point of time.
>>>>
>>>> - virtiofs daemon.
>>>>
>>>> - fuse-overlay. Giuseppe, seems to set user.* xattr attrs on unprivi=
liged
>>>>   fuse-overlay as well and he ran into similar issue. So fuse-overla=
y
>>>>   should benefit from this change as well.
>>>>
>>>> Why virtiofsd wants to set user.* xattr on symlink/special files
>>>> ----------------------------------------------------------------
>>>> In virtiofs, actual file server is virtiosd daemon running on host.
>>>> There we have a mode where xattrs can be remapped to something else.=

>>>> For example security.selinux can be remapped to
>>>> user.virtiofsd.securit.selinux on the host.
>>> As I have stated before, this introduces a breach in security.
>>> It allows an unprivileged process on the host to manipulate the
>>> security state of the guest. This is horribly wrong. It is not
>>> sufficient to claim that the breach requires misconfiguration
>>> to exploit. Don't do this.
>> So couple of things.
>>
>> - Right now whole virtiofs model is relying on the fact that host
>>   unpriviliged users don't have access to shared directory. Otherwise
>>   guest process can simply drop a setuid root binary in shared directo=
ry
>>   and unpriviliged process can execute it and take over host system.
>>
>>   So if virtiofs makes use of this mechanism, we are well with-in
>>   the existing constraints. If users don't follow the constraints,
>>   bad things can happen.
>>
>> - I think Smalley provided a solution for your concern in other thread=

>>   we discussed this issue.
>>
>>   https://lore.kernel.org/selinux/CAEjxPJ4411vL3+Ab-J0yrRTmXoEf8pVR3x3=
CSRgPjfzwiUcDtw@mail.gmail.com/T/#mddea4cec7a68c3ee5e8826d650020361030209=
d6
>>
>>
>>   "So for example if the host policy says that only virtiofsd can set
>> attributes on those files, then the guest MAC labels along with all
>> the other attributes are protected against tampering by any other
>> process on the host."

You can't count on SELinux policy to address the issue on a
system running Smack. Or any other user of system.* xattrs,
be they in the kernel or user space. You can't even count on
SELinux policy to be correct. virtiofs has to present a "safe"
situation regardless of how security.* xattrs are used and
regardless of which, if any, LSMs are configured. You can't
do that with user.* attributes.


>>
>>  Apart from hiding the shared directory from unpriviliged processes,
>>  we could design selinux policy in such a way that only virtiofsd
>>  is allowed "setattr". That should make sure even in case of
>>  misconfiguration, unprivileged process is not able to change
>>  guest security xattrs stored in "user.virtiofs.security.selinux".
>>
>>  I think that sounds like a very reasonable proposition.
>>
>>>> This remapping is useful when SELinux is enabled in guest and virtio=
fs
>>>> as being used as rootfs. Guest and host SELinux policy might not mat=
ch
>>>> and host policy might deny security.selinux xattr setting by guest
>>>> onto host. Or host might have SELinux disabled and in that case to
>>>> be able to set security.selinux xattr, virtiofsd will need to have
>>>> CAP_SYS_ADMIN (which we are trying to avoid).
>>> Adding this mapping to virtiofs provides the breach for any
>>> LSM using xattrs.
>> I think both the points above answer this as well.
>>
>>>>  Being able to remap
>>>> guest security.selinux (or other xattrs) on host to something else
>>>> is also better from security point of view.
>>>>
>>>> But when we try this, we noticed that SELinux relabeling in guest
>>>> is failing on some symlinks. When I debugged a little more, I
>>>> came to know that "user.*" xattrs are not allowed on symlinks
>>>> or special files.
>>>>
>>>> So if we allow owner (or CAP_FOWNER) to set user.* xattr, it will
>>>> allow virtiofs to arbitrarily remap guests's xattrs to something
>>>> else on host and that solves this SELinux issue nicely and provides
>>>> two SELinux policies (host and guest) to co-exist nicely without
>>>> interfering with each other.
>>> virtiofs could use security.* or system.* xattrs instead of user.*
>>> xattrs. Don't use user.* xattrs.
>> So requirement is that every layer (host, guest and nested guest), wil=
l
>> have a separate security.selinux label and virtiofsd should be able
>> to retrieve/set any of the labels depending on access.
>>
>> How do we achieve that with single security.selinux label per inode on=
 host.
> I guess we could think of using trusted.* but that requires CAP_SYS_ADM=
IN
> in init_user_ns. And we wanted to retain capability to run virtiofsd
> inside user namespace too. Also we wanted to give minimum required
> capabilities to virtiofsd to reduce the risk what if virtiofsd gets
> compromised. So amount of damage it can do to system is minimum.
>
> So guest security.selinux xattr could potentially be mapped to.
>
> trusted.virtiofs.security.selinux
>
> nested guest selinux xattrs could be mapped to.
>
> trusted.virtiofs.trusted.virtiofs.security.selinux
>
> And given reading/setting trusted.* requires CAP_SYS_ADMIN, that means
> unpriviliged processes can't change these security attributes of a
> file.
>
> And trade-off is that virtiofsd process needs to be given CAP_SYS_ADMIN=
=2E
>
> Frankly speaking, we are more concerned about the security of host
> system (as opposed to something changing in file for guest). So while
> using "trusted.*" is still an option, I would think that not running
> virtiofsd with CAP_SYS_ADMIN probably has its advantages too. On host
> if we can just hide the shared dir from unpriviliged processes then
> we get best of both the worlds. Unpriviliged processes can't change
> anything on the shared file at the same time, possible damage by
> virtiofsd is less if it gets compromised.
>
> Thanks
> Vivek
>

