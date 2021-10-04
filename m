Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FAE0421447
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Oct 2021 18:39:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237254AbhJDQll (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Oct 2021 12:41:41 -0400
Received: from sonic315-26.consmr.mail.ne1.yahoo.com ([66.163.190.152]:33636
        "EHLO sonic315-26.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237104AbhJDQlh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Oct 2021 12:41:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1633365588; bh=a7iV5plvCSvco/VkhdYOk4i6CwBUUoL1+EGA/VqxJpE=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject:Reply-To; b=fK2WoVUSvON4B55BSpzR5q92QQvs6BEKq99SsENXTEOxrNyAhRz+y6swqFdemA51gMBjRKfWyfm+WWAGGJmVMAIgPUbiFpHDrDgG+HcX2WZFk0Bn8w+oc5W7krgXN9UGwCfnKWSMY4YKFlEVzLGLup1cIEMppWuWuBsk/XEwhzS1X4DEZUa+IjgyHrDGEmNKXgCJrqmIm2Sp/U0DRwFBfgXHtDQUGv558QWrfTnliFiGnfzsccjUZ4i+yctvEReOA6XuGfXsIYdHtR5PLKI8ajkvXcDT5qxiTuQJLs9XIuoHRt2mHff88YvcH23Ui2dzAnVGQHPytV7yYqDz5yvdYg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1633365588; bh=7LHKcYBnbK1FSu/J3UAZBdyQZ/D7sy1hbIhLQcw+0aZ=; h=X-Sonic-MF:Subject:To:From:Date:From:Subject; b=i4VYJVkFqK5z7u5prE0CI/kHnDVuZn2vMDnnJqxZ0dOJvDXbBVyFf+Q9IxUp2K/xkXKLC9Ep+VVnZKSCMY+jW6A87f8BgeOZhDXTsQDCSdePxmFsR44kvRMpLFTX0h6ZmGL0GaGMsBeJZwMAh2IVUlyR/BBeleXEDFBIi2AFdetdizaogk1hVzggwVaUZQoJ9nwSxB01hiSaXCAgmodGBsyKQy89VSEfrhd2Y0VCEL5T5aGEhTP7+MoBAkf/4sXDSCdq3nwB521mI6jxcvKWvwriebXAlYautgiYJRV8RbSCiRFp7Rm9z83c3iWDh4TxFXlZjFt35zfbGAo29vpCJQ==
X-YMail-OSG: xZTID10VM1mViedzn3ivEbQ9oPhCrCWNR3RUnJQub8f9Q5UnBloWfLz8daeOFnb
 bM_fqt_ypWH6m64uO6GetsgUGlIXM0TByolmoC43H6U.N46zoBFkDlyeZ2ex4IzcvfMRgwc5GHDK
 2JPBqDw0ZwFJtVclTMx_Y9yp19l.txWv2qCPWcHhq52kZttsFjHnONadzHfb49liLhaM8UjILl4S
 V3AfyLkCUO1umZarsQb1dsPmhEcl1xBaAijXj9DNovbqJ9cKVxKgSk1nR_CxBkcCR87.zwRs0WIO
 joiTL47nZTGsHMwRye1LNYyX0wZ0f1WV4OAOqrN_aNmyG1vOw6.jAxDrSFj.4i.B8O9ow3jqoySY
 EpBPnw6Cb7kPwI26WSUNAHHy4dTInSHXWqBL1z6pXlXzxsHpSPeaCODCGmDNaIkWuEyyBjCa_kgk
 YwsDdArlyA529JWSD5EJ_LkI4gllBe5vhvBsWoksUBHvXO3T8UHpxMaW0LJ3b9u9TWtadTRO1zqJ
 j1aQKMBq_XcLDWKY41heTY2u7QbtpsuIMbdaA2gVtyjOpiusxrMsWe8m.bWoL8srFCn3CNWGM2UY
 wo6Ot097VGz7ZekRJv5IEcbp212NiYq_Y5JVkxqAn845fioOkILgxOo5yxt6aTJ1IX0qlfaXJy9s
 JQLup_hw.Pt.4pPOS7aEaJcIModozKbJI8TNrpiXdDW13D1Fjgom2BqC6QCLa1SCxJNuP4i9lTeh
 FiB_IUUgJHdPskGwp3yD0FKvE66tWOy9TNmUVPM32RPvjNHgfrlBotRuqfjIH62yquibwLf1sqmB
 Qrh0VLfHIjsnZ7wE1GqjSg5V.oSNlrh.kI0fdwvwtwD43fOgzkUMBHGJ9RhiaJwgPyQDvyYGGIqW
 pR_cnCLEIEz3i51Cz8U0FG45b2gsjXpj.mSzHZQpsY6Vzoooz52mGxsXSd9p8g9yviTDtnW.Ws4o
 fjcArKTS06HPV3wM3fGRm7sQMu8bKullP6LJEsfux9G_1BjndpjpsMaHWTd1vyjq9R971Ccn4w2n
 GznOtUcMLAFhUiNpOEGP6c9RqISit1tWHjcCcLQPk7oXyhP4SgvRjRjQp_G0YfsMXjcQqkzifI40
 S.RTxf5qcP9_54Ca_Qm7su32rSM7qyTU1RRqz28Vy_Ys2r7Wn0LeZwZDiOqFcIstfhZRoVP8Nky5
 xtuvVzay0vtoXjUARcX9lhR9yE6.eeCV51k1mkQiuQRb3dYYD2FFV0xIQO8wxXiyyKIRDo7LPiGF
 VmBIFHuaz2.W6v29QxnZYmfP5YtP.kTQTaA0eBOTef2_.C16snFLF0TBPxGIJwbJyaTzw3FFRW9t
 4.R1QfV7YodMBPubZlqRTiGek_klF.SryIbFfLyOQ72_CxS50bvnovGI4vyqhwiYismRj_knwJ98
 v2opw38R6s2SZhFi70CtAM6CQ6jSLcpifUO3bzRBW2Qc.H9DZWQIU3TWht8ee3FsLBcvI2vR1sdv
 .eQuXt7GGyTviBVNfRhY2DP6ptIgsrB.H7wvEbduNKX6UQpuBtDzZmO9boYOKbyBpcBhXA8mciik
 GvP3M8spDEqyuB0Y19GvkWiN3pnB01MOjnI6R9LlCWIvw7XV0RTKY3yosFk4.OelIZAd_S2sApg3
 pfop0vBrVxaTWq1lc6vQNCRy_dX1uuU2id_OZMRZuwGrVT5s.FvQ3O6D2ibxKWdVY896f53b1xW1
 jajsXypvKT5J_8sodP2W0GwT6B2KgHv4BGiT2LEwDhseM1RC2DsOZTpDr851WBIZm3lJ__mZpS4e
 9dpU4h3gH0tEI9An.Ru9WO49BzsoRFHr8C3CkW2Uv_8rJ0atea66z_bhkRwy3DEqBQZIIDS9MBfb
 Rvz7U9yo6GK87korTbdHJTvfHuXHx21ibE9Rh6lXJp2ACj_h5pu4lbhrYbTeb772DmEKmokCLB4d
 _gtu.iGobJ7iXW_B2cUYTfvydhySq0KDKgE75VGfxd3GLqDqDm0_eUzwM2P2pQenQMC2iHg7IrGB
 cq5eb7uVcSjZyC6gtwaZzPN7_CklLBXNAgpe_rOHdbWKyDqYoar0ORV85OZa7BNgtDJS5Kr9SZno
 421BXagjfkw2dxk8gp92cqORDoNDHOkIoLrcbX_sgSAAMKkdNtI2zkkluknP68DsBPmhy0XSQDCM
 DnFxnDSgKmGtUSDAkUZpdyamBDWdDsLwAStnEiu70IEVczwqBBwQWjC8rY9D5M62NIOd5rSgRyY9
 ODjr0ziQxy8MFSrXkTJBvnvZ0YCQVntvvVqzhluyc1VzTK1MEw1qhaY.QTjgTSDUKHAFTobzgJrB
 D3VJVnQE20eUHjmXEcv3ZTRbE8ZV4AhewzdhEEWHXnY91xALkLblaDbCoJflPkv7t_GZXGVIuKnl
 .af.O21OFDgl1RbKu7VFWvfccDTpNOEERzeSpb5UvfABVCFQKHhy79UOYWLheZjxOQ_yLh5YNU4S
 meMZ5q29H
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.ne1.yahoo.com with HTTP; Mon, 4 Oct 2021 16:39:48 +0000
Received: by kubenode522.mail-prod1.omega.ne1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID deb54572e2524d030925a3958cf6bd0c;
          Mon, 04 Oct 2021 16:39:45 +0000 (UTC)
Subject: Re: [PATCH] security: Return xattr name from
 security_dentry_init_security()
To:     Jeff Layton <jlayton@kernel.org>, Vivek Goyal <vgoyal@redhat.com>,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, virtio-fs@redhat.com,
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
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <a7ab4daf-e577-abcc-f4a0-09d7eb9c4cb7@schaufler-ca.com>
Date:   Mon, 4 Oct 2021 09:39:44 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <7404892c92592507506038ef9bdcfc1780311000.camel@kernel.org>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Mailer: WebService/1.1.19076 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/4/2021 9:01 AM, Jeff Layton wrote:
> On Mon, 2021-10-04 at 08:54 -0700, Casey Schaufler wrote:
>> On 10/4/2021 8:20 AM, Jeff Layton wrote:
>>> On Thu, 2021-09-30 at 14:59 -0400, Vivek Goyal wrote:
>>>> Right now security_dentry_init_security() only supports single secur=
ity
>>>> label and is used by SELinux only. There are two users of of this ho=
ok,
>>>> namely ceph and nfs.
>>>>
>>>> NFS does not care about xattr name. Ceph hardcodes the xattr name to=

>>>> security.selinux (XATTR_NAME_SELINUX).
>>>>
>>>> I am making changes to fuse/virtiofs to send security label to virti=
ofsd
>>>> and I need to send xattr name as well. I also hardcoded the name of
>>>> xattr to security.selinux.
>>>>
>>>> Stephen Smalley suggested that it probably is a good idea to modify
>>>> security_dentry_init_security() to also return name of xattr so that=

>>>> we can avoid this hardcoding in the callers.
>>>>
>>>> This patch adds a new parameter "const char **xattr_name" to
>>>> security_dentry_init_security() and LSM puts the name of xattr
>>>> too if caller asked for it (xattr_name !=3D NULL).
>>>>
>>>> Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
>>>> ---
>>>>
>>>> I have compile tested this patch. Don't know how to setup ceph and
>>>> test it. Its a very simple change. Hopefully ceph developers can
>>>> have a quick look at it.
>>>>
>>>> A similar attempt was made three years back.
>>>>
>>>> https://lore.kernel.org/linux-security-module/20180626080429.27304-1=
-zyan@redhat.com/T/
>>>> ---
>>>>  fs/ceph/xattr.c               |    3 +--
>>>>  fs/nfs/nfs4proc.c             |    3 ++-
>>>>  include/linux/lsm_hook_defs.h |    3 ++-
>>>>  include/linux/lsm_hooks.h     |    1 +
>>>>  include/linux/security.h      |    6 ++++--
>>>>  security/security.c           |    7 ++++---
>>>>  security/selinux/hooks.c      |    6 +++++-
>>>>  7 files changed, 19 insertions(+), 10 deletions(-)
>>>>
>>>> Index: redhat-linux/security/selinux/hooks.c
>>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>>> --- redhat-linux.orig/security/selinux/hooks.c	2021-09-28 11:36:03.5=
59785943 -0400
>>>> +++ redhat-linux/security/selinux/hooks.c	2021-09-30 14:01:05.869195=
347 -0400
>>>> @@ -2948,7 +2948,8 @@ static void selinux_inode_free_security(
>>>>  }
>>>> =20
>>> I agree with Al that it would be cleaner to just return the string, b=
ut
>>> the call_*_hook stuff makes that a bit more tricky. I suppose this is=
 a
>>> reasonable compromise.
>> call_int_hook() and call_void_hook() were introduced to reduce the mon=
otonous
>> repetition in the source. They are cosmetic and add no real value. The=
y shouldn't
>> be a consideration in the discussion.
>>
>> There is a problem with Al's suggestion. The interface as used today h=
as two real
>> problems. It returns an attribute value without identifying the attrib=
ute. Al's
>> interface would address this issue. The other problem is that the inte=
rface can't
>> provide multiple attribute+value pairs. The interface is going to need=
 changed to
>> support that for full module stacking. I don't see a rational way to e=
xtend the
>> interface if it returns a string when there are multiple attributes to=
 choose from.
>>
> Is that also a problem for the ctx parameter? In the case of full modul=
e
> stacking do you get back multiple contexts as well?

That's a bigger discussion than is probably appropriate on this thread.
In the module stacking case the caller needs to identify which security
module's context it wants. If the caller is capable of dealing with
multiple attributes (none currently are, but they all assume that you're
using SELinux and only support what SELinux needs) it will need to
do something different. We have chickens and eggs involved. The LSM
infrastructure doesn't need to handle it because none of its callers
are capable of dealing with it. None of the callers try, in part because
they have no way to get the information they would need, and in part
because they don't care about anything beyond SELinux. Ceph, for example,=

is hard coded to expect "security.selinux".

On further reflection, Al's suggestion could be made to work if the
caller identified which attribute its looking for.
=A0

>>>>  static int selinux_dentry_init_security(struct dentry *dentry, int =
mode,
>>>> -					const struct qstr *name, void **ctx,
>>>> +					const struct qstr *name,
>>>> +					const char **xattr_name, void **ctx,
>>>>  					u32 *ctxlen)
>>>>  {
>>>>  	u32 newsid;
>>>> @@ -2961,6 +2962,9 @@ static int selinux_dentry_init_security(
>>>>  	if (rc)
>>>>  		return rc;
>>>> =20
>>>> +	if (xattr_name)
>>>> +		*xattr_name =3D XATTR_NAME_SELINUX;
>>>> +
>>>>  	return security_sid_to_context(&selinux_state, newsid, (char **)ct=
x,
>>>>  				       ctxlen);
>>>>  }
>>>> Index: redhat-linux/security/security.c
>>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>>> --- redhat-linux.orig/security/security.c	2021-08-16 10:39:28.518988=
836 -0400
>>>> +++ redhat-linux/security/security.c	2021-09-30 13:54:36.367195347 -=
0400
>>>> @@ -1052,11 +1052,12 @@ void security_inode_free(struct inode *i
>>>>  }
>>>> =20
>>>>  int security_dentry_init_security(struct dentry *dentry, int mode,
>>>> -					const struct qstr *name, void **ctx,
>>>> -					u32 *ctxlen)
>>>> +				  const struct qstr *name,
>>>> +				  const char **xattr_name, void **ctx,
>>>> +				  u32 *ctxlen)
>>>>  {
>>>>  	return call_int_hook(dentry_init_security, -EOPNOTSUPP, dentry, mo=
de,
>>>> -				name, ctx, ctxlen);
>>>> +				name, xattr_name, ctx, ctxlen);
>>>>  }
>>>>  EXPORT_SYMBOL(security_dentry_init_security);
>>>> =20
>>>> Index: redhat-linux/include/linux/lsm_hooks.h
>>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>>> --- redhat-linux.orig/include/linux/lsm_hooks.h	2021-06-02 10:20:27.=
717485143 -0400
>>>> +++ redhat-linux/include/linux/lsm_hooks.h	2021-09-30 13:56:48.44019=
5347 -0400
>>>> @@ -196,6 +196,7 @@
>>>>   *	@dentry dentry to use in calculating the context.
>>>>   *	@mode mode used to determine resource type.
>>>>   *	@name name of the last path component used to create file
>>>> + *	@xattr_name pointer to place the pointer to security xattr name
>>> It might be a good idea to also document the lifetime for xattr_name
>>> here. In particular you're returning a pointer to a static string, an=
d
>>> it would be good to note that the caller needn't free it or anything.=

>>>
>>>>   *	@ctx pointer to place the pointer to the resulting context in.
>>>>   *	@ctxlen point to place the length of the resulting context.
>>>>   * @dentry_create_files_as:
>>>> Index: redhat-linux/include/linux/security.h
>>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>>> --- redhat-linux.orig/include/linux/security.h	2021-08-16 10:39:28.4=
84988836 -0400
>>>> +++ redhat-linux/include/linux/security.h	2021-09-30 13:59:00.288195=
347 -0400
>>>> @@ -317,8 +317,9 @@ int security_add_mnt_opt(const char *opt
>>>>  				int len, void **mnt_opts);
>>>>  int security_move_mount(const struct path *from_path, const struct =
path *to_path);
>>>>  int security_dentry_init_security(struct dentry *dentry, int mode,
>>>> -					const struct qstr *name, void **ctx,
>>>> -					u32 *ctxlen);
>>>> +				  const struct qstr *name,
>>>> +				  const char **xattr_name, void **ctx,
>>>> +				  u32 *ctxlen);
>>>>  int security_dentry_create_files_as(struct dentry *dentry, int mode=
,
>>>>  					struct qstr *name,
>>>>  					const struct cred *old,
>>>> @@ -739,6 +740,7 @@ static inline void security_inode_free(s
>>>>  static inline int security_dentry_init_security(struct dentry *dent=
ry,
>>>>  						 int mode,
>>>>  						 const struct qstr *name,
>>>> +						 const char **xattr_name,
>>>>  						 void **ctx,
>>>>  						 u32 *ctxlen)
>>>>  {
>>>> Index: redhat-linux/include/linux/lsm_hook_defs.h
>>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>>> --- redhat-linux.orig/include/linux/lsm_hook_defs.h	2021-07-07 11:54=
:59.673549151 -0400
>>>> +++ redhat-linux/include/linux/lsm_hook_defs.h	2021-09-30 14:02:13.1=
14195347 -0400
>>>> @@ -83,7 +83,8 @@ LSM_HOOK(int, 0, sb_add_mnt_opt, const c
>>>>  LSM_HOOK(int, 0, move_mount, const struct path *from_path,
>>>>  	 const struct path *to_path)
>>>>  LSM_HOOK(int, 0, dentry_init_security, struct dentry *dentry,
>>>> -	 int mode, const struct qstr *name, void **ctx, u32 *ctxlen)
>>>> +	 int mode, const struct qstr *name, const char **xattr_name,
>>>> +	 void **ctx, u32 *ctxlen)
>>>>  LSM_HOOK(int, 0, dentry_create_files_as, struct dentry *dentry, int=
 mode,
>>>>  	 struct qstr *name, const struct cred *old, struct cred *new)
>>>> =20
>>>> Index: redhat-linux/fs/nfs/nfs4proc.c
>>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>>> --- redhat-linux.orig/fs/nfs/nfs4proc.c	2021-07-14 14:47:42.73284292=
6 -0400
>>>> +++ redhat-linux/fs/nfs/nfs4proc.c	2021-09-30 14:06:02.249195347 -04=
00
>>>> @@ -127,7 +127,8 @@ nfs4_label_init_security(struct inode *d
>>>>  		return NULL;
>>>> =20
>>>>  	err =3D security_dentry_init_security(dentry, sattr->ia_mode,
>>>> -				&dentry->d_name, (void **)&label->label, &label->len);
>>>> +				&dentry->d_name, NULL,
>>>> +				(void **)&label->label, &label->len);
>>>>  	if (err =3D=3D 0)
>>>>  		return label;
>>>> =20
>>>> Index: redhat-linux/fs/ceph/xattr.c
>>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>>> --- redhat-linux.orig/fs/ceph/xattr.c	2021-09-09 13:05:21.800611264 =
-0400
>>>> +++ redhat-linux/fs/ceph/xattr.c	2021-09-30 14:14:59.892195347 -0400=

>>>> @@ -1311,7 +1311,7 @@ int ceph_security_init_secctx(struct den
>>>>  	int err;
>>>> =20
>>>>  	err =3D security_dentry_init_security(dentry, mode, &dentry->d_nam=
e,
>>>> -					    &as_ctx->sec_ctx,
>>>> +					    &name, &as_ctx->sec_ctx,
>>>>  					    &as_ctx->sec_ctxlen);
>>>>  	if (err < 0) {
>>>>  		WARN_ON_ONCE(err !=3D -EOPNOTSUPP);
>>>> @@ -1335,7 +1335,6 @@ int ceph_security_init_secctx(struct den
>>>>  	 * It only supports single security module and only selinux has
>>>>  	 * dentry_init_security hook.
>>>>  	 */
>>>> -	name =3D XATTR_NAME_SELINUX;
>>>>  	name_len =3D strlen(name);
>>>>  	err =3D ceph_pagelist_reserve(pagelist,
>>>>  				    4 * 2 + name_len + as_ctx->sec_ctxlen);
>>>>
>>> Looks reasonable overall.
>>>
>>> Reviewed-by: Jeff Layton <jlayton@kernel.org>
>>>

