Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1F643FF40B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Sep 2021 21:20:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347363AbhIBTVL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Sep 2021 15:21:11 -0400
Received: from sonic308-15.consmr.mail.ne1.yahoo.com ([66.163.187.38]:34968
        "EHLO sonic308-15.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1347357AbhIBTVC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Sep 2021 15:21:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1630610403; bh=5g1XEZzAWFktTaX29oZVU313MlCGCdyLEEo/HSTsE48=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject:Reply-To; b=qW949QlTlna5+NG2mn2w6JJdRr++EbWB3Kk++WWPtBbKAueU3SEgoJ1BPpQZUYiFsXI86t55rrgnpx//DQ9fUtifxzNtl0fknUAsdsE2fA3PmLFvBisBiakeU4DHccpu0HTiIazoVZqBVmFXDSZDK0LIUwupeGVk0P26hibC5Y9adszDLSgbNNnUtRucKcTZdsMWnLCoAE186Cke0zPKX0Ba3VMaiZE2Xr/ww+nVRU2KKDKTxgceSnkWJhqWSYvOvo4J3E4rqUIfEHhex6wryqi22cfqq/piv1hfhy65041MQR1UUP6gHt6BoWS6YI11k1zBuV2EpavezaM/W7h52w==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1630610403; bh=P03CqILEN5fj69nSRgrOpzWXwnXU2noUJzuka3keEQb=; h=X-Sonic-MF:Subject:To:From:Date:From:Subject; b=RDbxtUa2pbUj8Thl3veWFKo+1yNMzCaoDMw/FszeuICYvsl+uh5o2zKPaNsRi754zHL006fnm3JvnUIp210raYY0mvkXFQHbet9oIlc9j/3prnTF1sNjeA5aznMWGo2ylGg2Fku3gvbViajbIgL7pQce7RFEwSgiU8ylMFFNK/swvYRwsPZJfDc0n/FbRho4SYiao0RYCzMC/wWKSaG+C3/CmIqjsC6W8ZM05MBIaYOS0D2sPz1uAXEutQq6gI1E/JuOLLJdEeX9WtbwWqleuHMD5CPu/2Luqi5iQnr1RNJfFQRtEMl6Ls/+0ZSZQBiPsXKZtPruiN1METdAOR+OZg==
X-YMail-OSG: X1CwLN0VM1k2IDo.CcbEJiIffWj7OMv8WteW8UDfIGAxki3jwKDpwVw.K9a1oMa
 Mnh1oE.pyyTf.d_DzDx0bqDWipzXU6Oeh2J9n4viGEBwB48Owu3UPPj_zWsD67QWRdrBqggZPgWD
 wY9Xs8AJjpV7TZAuMfSOVvIAgiDL3T8PWVyuUmM21iJiSRSpEBrYKm4au2TayiFUvCcEdebohmuR
 grVZvtEHlqzDhgbUQdyPe0U1kH8LmIn2TQSxOa4iZYJ5ITUEsUl5oBtiXl3msAIjYV_jdfNXjoRZ
 Ln3bRoZwr5pUZ2ZWGH1fRVwhBYEyP1Erehma40v.VY.1bi1NL8Y402NKKjIPjJMKtYa6XglScaHm
 hqniefwSl3zPTVQjJ8AVx0JKi7MQuCbONebYPhvsnivcDNS1kzDZs8TcJU2bC9b3.8YZOVmlEeRo
 Ffl3z8N8PcQ_MkBbPCzZ2JNMwacpz6RpfdD.XM6C4WVNcwL44Gam.X2UIsKv7u1GClCbun6QN7kz
 EbWHsxHKCSIdR6WN1je1SNK41446FfQhR.8SD8t4ddYvdBLk1Iw6E9i2a4zEPW7En2cgNjkAkXm4
 YsP4i9JFC_PjB1KyorxsM1pSY2b3bd4RtiiQUHL9C.Nx3FmbEtR7VKKdiawnGLJlYzqFk3QNk4LL
 Cc7qU4oBAm41Xof6MZLzdTDCGwrUS8KUezK_eraydEd3uTOKyfNWCylsaEO93hIS22zEfH_enixQ
 h_gIcRZpsRnnDnBT4VYxJx3watFrx2X54YyrtG9cSJIjFvZ0No8N1z5Ud0Go198K91a8oedw7Q_8
 z5C1iDVImvJRjZXOgeHBkcODuknmc43Cfn9Fe9z63zFZCloXhNGGbtadHRhBdw8f6GYoadku2vgh
 lGeODFAx5Yn3BVjlWGL_MW9Cp6_N4fvjRWW4Ab66co1M0KmSRFwXwTjARag06OiXv9dREAHr7JSq
 ZVdQlslg1rHenkUYlfc_NMJUbe9HlUBbVbCXxk1vt2T1XooXguc9X5Qx1faYKyg0NHGhg4np.jPM
 vQHoeyqytoDIUd2ra2umtEMa3vH4tJHfh_c62BKhZbQR0GNsyeGSIfcQ7Uq4NBujmUO4yACSc44m
 ibnrg6Ikx6gP.iXKbGnRstTjUJbtaBGqgVBC2mltVpaXRXlBQQDKFcW9sTZ0KZlhn37IgHakM1vD
 oXvusc7E1QJEEXsaRcA06GTOHY_76VA5oefNOtQ7zz0eMQ9zO1y9FQmTDXedsyzDjgumAe2lo1k9
 LQmgKLeSZnXFVxg1b5uyneumfiqIskigye7p3X6p3F_eCqhNpCfUvubqIIAMN4gmMC6hcrd6C6lu
 .7X_C0CsiWh9Nb8JtrsYZTFx3a6Ph90AF6kEzzyErBWWFEV9.McxdfMye4jvXdjDeXaIA1ZDIV7m
 kHZGghT7At5XhxOdgbx5xrqW16yvezO6Rm4D7BGyFG6jLme5OevXy..BrqsFKzQj6e88wFVUZCSp
 FGIel4rn5ex5hHU3_Sa9qZZioIHYuD.Upnh08X9a5dnKg2wEl9akMX1wfQ.4ZAEhWoeyWApw_s2L
 xtXUvokqy6qkNvkyXMPMuVToGqbTb7EA_DSEAwKQE4mc6oT6VIMiuvm9_JVQcjoeyzFsjwicTEIL
 TEoIGfdeCdrAWVzRN9gwdKNkW4fysEJK4r6F.XTzVY3M8A2XpP_6zqKBdmHRsc5LAPaqFtc5aUHX
 eqhTBPtYeC9q6ZNzuF9a6gtG8qvSsGz.bpEVf8Vp5iv.UGyzZyAEpQfyPI8yvRRkjZY4PLF0tgb8
 XlBnbbsZiN638fmxKfGkO_e4c2SXEwWayBQvMqkOpOwCjI3T2R7d_Z22Q8OBMckTI1eL6n8iTgtv
 PdxhG1dI9mNFQ145uIrmO9UBcel.y2qkzAKDDSrGvzQTyGxYifO7sufUal2UhxJg_Hm.HFAb7HM1
 KT7TMimuFZpsKXFMHYBRJrWx7lDcJRiySyGAh8PulGr6seU0RFASnkSYPb4iln4azcj717bMQf1_
 gsRtcdlhUAH2Nmmi.1SKIIBgV_zQjx25WBrgPSRFt5vlyQOzPDf82Kn_F6KVxnl2wQ.n.pDWpFpi
 YX7SIwUdFF02MaVaDexWaSdnBgNQPqIpMlsR1UAdxi28kMqWaHtUPO_B0rKkpItmJDhEdxRIBD69
 tPfF7Lw4yyxOBzar4n.FtjGcTGs_b8rLDyzKjXl5qyqhORwGuowxxDmIDqIj1v27dfkQ7Y_cxu.3
 vDFTN.PYM94xJvuNohcqK9saTkHKyTMG2y7UbXsAMsqqix3aMG.zdhMhW_7GdWcT2RBHZLE..iPt
 GQJPr25p2ldq4RYsNiSdc6ntCT2bYLHAkSyJdcuMn5Jeq1Lut9FKSrBbZirZ5ZIPB9kdAVXKRly6
 dmWqOBIa68QYE.D8p8VaG
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.ne1.yahoo.com with HTTP; Thu, 2 Sep 2021 19:20:03 +0000
Received: by kubenode542.mail-prod1.omega.bf1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID aa6438e1d146c0c33dc71ca26432e3e5;
          Thu, 02 Sep 2021 19:19:57 +0000 (UTC)
Subject: Re: [PATCH v3 0/1] Relax restrictions on user.* xattr
To:     Vivek Goyal <vgoyal@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, virtio-fs@redhat.com,
        dwalsh@redhat.com, dgilbert@redhat.com,
        christian.brauner@ubuntu.com, casey.schaufler@intel.com,
        LSM <linux-security-module@vger.kernel.org>,
        selinux@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        Miklos Szeredi <miklos@szeredi.hu>, gscrivan@redhat.com,
        "Fields, Bruce" <bfields@redhat.com>,
        stephen.smalley.work@gmail.com, Dave Chinner <david@fromorbit.com>,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20210902152228.665959-1-vgoyal@redhat.com>
 <CAHc6FU4foW+9ZwTRis3DXSJSMAvdb4jXcq7EFFArYgX7FQ1QYg@mail.gmail.com>
 <YTEcYkAA2F1FhOvF@redhat.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <12b37acc-401a-4d44-085f-8f51077a0d10@schaufler-ca.com>
Date:   Thu, 2 Sep 2021 12:19:54 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YTEcYkAA2F1FhOvF@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Mailer: WebService/1.1.18924 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/2/2021 11:48 AM, Vivek Goyal wrote:
> On Thu, Sep 02, 2021 at 07:52:41PM +0200, Andreas Gruenbacher wrote:
>> Hi,
>>
>> On Thu, Sep 2, 2021 at 5:22 PM Vivek Goyal <vgoyal@redhat.com> wrote:
>>> This is V3 of the patch. Previous versions were posted here.
>>>
>>> v2: https://lore.kernel.org/linux-fsdevel/20210708175738.360757-1-vgo=
yal@redhat.com/
>>> v1: https://lore.kernel.org/linux-fsdevel/20210625191229.1752531-1-vg=
oyal@redhat.com/
>>>
>>> Changes since v2
>>> ----------------
>>> - Do not call inode_permission() for special files as file mode bits
>>>   on these files represent permissions to read/write from/to device
>>>   and not necessarily permission to read/write xattrs. In this case
>>>   now user.* extended xattrs can be read/written on special files
>>>   as long as caller is owner of file or has CAP_FOWNER.
>>>
>>> - Fixed "man xattr". Will post a patch in same thread little later. (=
J.
>>>   Bruce Fields)
>>>
>>> - Fixed xfstest 062. Changed it to run only on older kernels where
>>>   user extended xattrs are not allowed on symlinks/special files. Add=
ed
>>>   a new replacement test 648 which does exactly what 062. Just that
>>>   it is supposed to run on newer kernels where user extended xattrs
>>>   are allowed on symlinks and special files. Will post patch in
>>>   same thread (Ted Ts'o).
>>>
>>> Testing
>>> -------
>>> - Ran xfstest "./check -g auto" with and without patches and did not
>>>   notice any new failures.
>>>
>>> - Tested setting "user.*" xattr with ext4/xfs/btrfs/overlay/nfs
>>>   filesystems and it works.
>>>
>>> Description
>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>>
>>> Right now we don't allow setting user.* xattrs on symlinks and specia=
l
>>> files at all. Initially I thought that real reason behind this
>>> restriction is quota limitations but from last conversation it seemed=

>>> that real reason is that permission bits on symlink and special files=

>>> are special and different from regular files and directories, hence
>>> this restriction is in place. (I tested with xfs user quota enabled a=
nd
>>> quota restrictions kicked in on symlink).
>>>
>>> This version of patch allows reading/writing user.* xattr on symlink =
and
>>> special files if caller is owner or priviliged (has CAP_FOWNER) w.r.t=
 inode.
>> the idea behind user.* xattrs is that they behave similar to file
>> contents as far as permissions go. It follows from that that symlinks
>> and special files cannot have user.* xattrs. This has been the model
>> for many years now and applications may be expecting these semantics,
>> so we cannot simply change the behavior. So NACK from me.
> Directories with sticky bit break this general rule and don't follow
> permission bit model.

The sticky bit is a hack. It was introduced to stave off proposed
implementations of Access Control Lists, which it did successfully
for quite some time.

> man xattr says.
>
> *****************************************************************
> and access to user extended  attributes  is  re=E2=80=90
>        stricted  to  the  owner and to users with appropriate capabilit=
ies for
>        directories with the sticky bit set
> ******************************************************************
>
> So why not allow similar exceptions for symlinks and device files.

Limiting exceptions is usually a good thing. If every system mechanism
devolves into a heap of special cases it becomes very difficult to
describe your system semantics or the system security model.=20

> I can understand the concern about behavior change suddenly and
> applications being surprised. If that's the only concern we could
> think of making user opt-in for this new behavior based on a kernel
> CONFIG, kernel command line or something else.

That doesn't work in the world of distros. But you knew that.


>>> Who wants to set user.* xattr on symlink/special files
>>> -----------------------------------------------------
>>> I have primarily two users at this point of time.
>>>
>>> - virtiofs daemon.
>>>
>>> - fuse-overlay. Giuseppe, seems to set user.* xattr attrs on unprivil=
iged
>>>   fuse-overlay as well and he ran into similar issue. So fuse-overlay=

>>>   should benefit from this change as well.
>>>
>>> Why virtiofsd wants to set user.* xattr on symlink/special files
>>> ----------------------------------------------------------------
>>> In virtiofs, actual file server is virtiosd daemon running on host.
>>> There we have a mode where xattrs can be remapped to something else.
>>> For example security.selinux can be remapped to
>>> user.virtiofsd.securit.selinux on the host.
>>>
>>> This remapping is useful when SELinux is enabled in guest and virtiof=
s
>>> as being used as rootfs. Guest and host SELinux policy might not matc=
h
>>> and host policy might deny security.selinux xattr setting by guest
>>> onto host. Or host might have SELinux disabled and in that case to
>>> be able to set security.selinux xattr, virtiofsd will need to have
>>> CAP_SYS_ADMIN (which we are trying to avoid). Being able to remap
>>> guest security.selinux (or other xattrs) on host to something else
>>> is also better from security point of view.
>>>
>>> But when we try this, we noticed that SELinux relabeling in guest
>>> is failing on some symlinks. When I debugged a little more, I
>>> came to know that "user.*" xattrs are not allowed on symlinks
>>> or special files.
>>>
>>> So if we allow owner (or CAP_FOWNER) to set user.* xattr, it will
>>> allow virtiofs to arbitrarily remap guests's xattrs to something
>>> else on host and that solves this SELinux issue nicely and provides
>>> two SELinux policies (host and guest) to co-exist nicely without
>>> interfering with each other.
>> The fact that user.* xattrs don't work in this remapping scenario
>> should have told you that you're doing things wrong; the user.*
>> namespace seriously was never meant to be abused in this way.
> Guest's security label is not be parsed by host kernel. Host kernel
> will have its own security label and will take decisions based on
> that. In that aspect making use of "user.*" xattr seemed to make
> lot of sense

It doesn't make sense. For files, directories or anything. It's
freaking hazardous.

>  and we were wondering why user.* xattr is limited to
> regualr files and directories only and can we change that behavior.
>
>> You may be able to get away with using trusted.* xattrs which support
>> roughly the kind of daemon use I think you're talking about here, but
>> I'm not sure selinux will be happy with labels that aren't fully under=

>> its own control. I really wonder why this wasn't obvious enough.
> I guess trusted.* will do same thing. But it requires CAP_SYS_ADMIN
> in init_user_ns.

Right. That's because you're doing dangerous things.

>  And that rules out running virtiofsd unpriviliged

Right. That's because you're doing dangerous things.

> or inside a user namespace. Also it reduces the risk posted by
> virtiofsd on host filesystem due to CAP_SYS_ADMIN. That's why we
> were trying to steer clear of trusted.* xattr space.

Yeah, I get it. What's wrong with admitting that what you're
trying to do is dangerous, and that you have to be careful?

> Also, trusted.* xattr space does not work with NFS.

So, fix that?

>
> $ setfattr -n "trusted.virtiofs" -v "foo" test.txt
> setfattr: test.txt: Operation not supported
>
> We want to be able run virtiofsd over NFS mounted dir too.
>
> So its not that we did not consider trusted.* xattrs. We ran
> into above issues.
>
> Thanks
> Vivek
>

