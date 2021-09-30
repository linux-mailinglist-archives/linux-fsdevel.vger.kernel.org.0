Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32FA541E29E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Sep 2021 22:20:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347713AbhI3UWI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Sep 2021 16:22:08 -0400
Received: from sonic301-38.consmr.mail.ne1.yahoo.com ([66.163.184.207]:39137
        "EHLO sonic301-38.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1347746AbhI3UWH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Sep 2021 16:22:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1633033224; bh=yRNS+XIAmEfLJPvZ1zdMVmZLYm7h0+Tar1TrOaXMv3s=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject:Reply-To; b=i83nmD7rd9Pw2xebh9inLA/RW5HWgby2qt1s910GtSAVDckH/AmxmFkvw1Dm3SFR4PV/Z9XfC3aT12HLlHIqzP0rum3edzvJdH1FQh51o1SvQFf1F+ppELjb3+LCI1Ukk5SSuGa+bR4QTHy0LRy7LzCdzWZm4FUZJutpt7N9oGOM5NaXD8ysD+PgY9to7jGvktYbrnrewveCEbDW5UveTPuvXTUm4ilbYepNF0Tjy2GRcRGyI3VJpjANkscRydc/C8CoU9KLYvdDGnIxHJNWWuwMAnRfwoId+26Pi37PhyiI7/Oock67TA3wBtMhWabK+oZzc/treIVuSC6glr+EXA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1633033224; bh=sSWkLBrlfYVfz/stQTpUGZ+of45VTzuEe0rBpu9mlJZ=; h=X-Sonic-MF:Subject:To:From:Date:From:Subject; b=fIN10PhhpIvcdO/EMl4tfARe7v12znWER5mgNM3ISA1OXtcYNGVUatIEL5KQX5hfdWEQkl4w6F3ioFw6s9o9FBDfVInC4GbHt1vebBRoPAoL8oWoLhMEsZYtQM0iUJxSrTHswASgvsz7oJiFqPFdj7ul9COKsiLk/YIeos5l0W61WXfbd8ZgcIwnjeoS30462V23nMTsFuqd/MK0XRcKEaNdcZBbRgh2G58siOtf1xrL/jt/mbpZOv32fjz23WKwPMsm/hEag+7XPXUWCc6pCPWaKK9ctUkqzoRfyxIieOR6BywNV3w6QubeIynWWTC3mDR0YNvu1TMFj/kTH9v2cg==
X-YMail-OSG: EFxnAHIVM1l26aoBdncDHqYQQNKfIlluRY4ySoqsMpvh6zUsFXmNzKhQud_BpYU
 FCTUhv3vphGGB_saJzUXoRTrgDWttdWkUhJfyVVKRpYOZkoVKqu0UkZnMmmGN8XO6vSVR15iSosY
 qFpaNsuCnXwyL0ZJPZ_OwBkHkgn4ucL9kHyJnXyNWsQl85eHfA5y7LaLITNsksOgQHchXndzWRDZ
 BOctYXEEgre7j.UWBHFKi2zhKr6QftDkG1HEa5714N4p90qSTRL86vP7sVgviZsVtab7m5vRTwF3
 wBURG3OCyNDMRGLFAo3aQMVdS_I5ogMCj_59CTLcq8tyWhqSjttTMQSXgJja3KWZA.izmrQC9Waq
 iGlQddjAVi72n7Nieb43NLJQ3scI_5UKpw7kREjwG1ipElq_E2i9KVWW9oQw28i6eIgXofs4S_b7
 X1zsmFXrOb9aV.51daEjJEyRfumStQXcijie0Da9XI.vOCtM7zYV4PADoMCTfu9zDaGCrewC6XuR
 T_73KN0slb0wxr0j38gfiEbWk8AA1HlizqCwmO8vLIZUSU5S_X3zG6kUIlwBLQTc2OCKAOfsAAkN
 9HWNa3PBWn1XaZcp7GtNFBY4x3sSwL_.vyNBQHnW41vzlCyaNMCQOoGwgm1njSwj1VPWb6ku9Qgj
 domwQ2l503kd_QGJBlPiKozIWKifDus8ChpuvHAtOVjtHiXofrNtxMKRKk_2cttEQ0cURbCIrnos
 _fM8gtWryNv5TTzKpi_e7h9EvcTc2x79slyY6Lq2CtFdgdZ1tQkmduILfTBolAwF._JfdIuiVDGS
 2a8eBrg1b8kIywvMsAvZ7tBq1buncdfvjzJYBzxoqXh30ovL.s7xfnhXFzbZaDX72RILdgxPBJTx
 MEgipSDODcD_3M0vXHoib5oJ6remnpZi25Mt7qZsshJAFAyZ9oiWVKM2NeYRCl6ndQk4TFKlJIQe
 vGjLlVK3wK4wpLg7Oixudx3SwhTACaTnK5aaS.C6H5kb3jN27Ze6t2i_J6mJ_dudUhazIa_qNQAK
 aQ0VyDFfT74l8RZ3dJqtRPtGEspQc29nubUlw6OO_RBtCg_CXsCrI95T_OKOdag6C5w5dcRlsDtD
 JTMnbPOzG4FrNrIg6EqzvFCuI5InjvQR2ttMdErx_OYDF9IigBEBdoxEsm7nk92TWr4sRKGu6CUw
 6gXREyqMHSJdjGWULNS5t8jLlPkafkv9uRTfvrdw888wldgtnbNDiBq6QKXdXxB7Cp4mBrmQN8f5
 O2K2EZlC9Sz9FMn4H4.ouLq8nMlJy329YEMNa47z2MXF8wdsJfEKuudq5fnCv5AdJp1pYx2GWWRw
 72Ie4qxsLzRNPeHNRZgTRIrpRW3ttJQRvD0EBaon61c_9_6V4py6sIINT4OGXeyVfKqfeoKPB.F5
 tmn5fx0AsdNhSbdoQp9Qlj0maL0K1xpz20XnrsgP2cF6DTHKjDLQJTc1yhMGzMI6Gf48xpt1YnLb
 8sRcGL4MvWZnYGlNz_bm06no2JbKAWLig3oY6InhsQQ1lk4iNPU6bXmBBnddtkzhKK1shQ6SENPI
 EHwU_UmjokwCku5uW.1dJ.HqfP8VR8fKq4o9YRsUm4edV6Qgy4_hDSa5lTU.NuA5jVZngk9IUUt2
 XI1S7AkQjN_4vfWpH.BW23mOJP01IHuSsfDzD0hrMqB0p.a86i_eQ5K0UuaaaDwdgKX690fbHWmA
 nXruU4TrOILP6tnU2KM.wbzv2DoZwhX0tkSARtubJFTSlJjZyFbQ7cxaf8AKGgEo_bW.sVLHuWYr
 q_F2EjI3Y.ZwEfTaBkKpxySaF2fgDA4DHzXsXZsJGovZra769Kph11GDFZzlSj9MZqWCxDJ2lkN2
 5w63YHTbqnjFzm3I2ec_C_UkJy.AwG8koPuspnxMCju13QmM8eg8B5bh_TMEq0kPEFNUp3sVZuJQ
 iGrVpYDrAhBvJWEVtTEmgmOE33wz_h5KMdgcitMJCpEYnSqTHsYd8Yli9Pd8z4jYP2yRgLW3FcZr
 2Yogh7MhHua759Gb7hUO.Mhqz0CVSZeyLLN9mRPHosaA85KLBo8n9BsIxzXOHieTL7RAv66XbLGR
 mAWzcX1kqQICbp6zJgggd_59ViUwaUV6es8zH6x53Bu.67nABka7.YQgmtG2INy8KvkjyVwN2VFV
 bxZpSOxwb1fqKzaxGd.p1YggLCLA1UkWSqDSX8Bog7AqKe2FwxPopR1dh8Uqx99JaosBtiGc95yc
 iMZ98RATNt7EbJE.XVUJVfYD45O1wrK4632fV8rtvPzPK2EJS_ugsiMf9LBN_9qA1CSoKAWonSja
 hLPUjEFX7DQWuwwnZAj58y7Sq771urtuM2xZZKisJpFUK0_p.bPjcWQkBujo7wLEcm.WjSwoAz17
 IoL5WgBKzUUYnAHfX3ASaO84A25o-
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.ne1.yahoo.com with HTTP; Thu, 30 Sep 2021 20:20:24 +0000
Received: by kubenode522.mail-prod1.omega.ne1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 131a3f0a43c1f37da1d6ec227236d215;
          Thu, 30 Sep 2021 20:20:19 +0000 (UTC)
Subject: Re: [PATCH] security: Return xattr name from
 security_dentry_init_security()
To:     Vivek Goyal <vgoyal@redhat.com>,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, virtio-fs@redhat.com,
        Miklos Szeredi <miklos@szeredi.hu>,
        Daniel J Walsh <dwalsh@redhat.com>, jlayton@kernel.org,
        idryomov@gmail.com, ceph-devel@vger.kernel.org,
        linux-nfs@vger.kernel.org, bfields@fieldses.org,
        chuck.lever@oracle.com, stephen.smalley.work@gmail.com,
        Casey Schaufler <casey@schaufler-ca.com>
References: <YVYI/p1ipDFiQ5OR@redhat.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <a0d6e05c-6ec4-ff9b-954a-4974fb800de4@schaufler-ca.com>
Date:   Thu, 30 Sep 2021 13:20:18 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YVYI/p1ipDFiQ5OR@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Mailer: WebService/1.1.19076 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/30/2021 11:59 AM, Vivek Goyal wrote:
> Right now security_dentry_init_security() only supports single security=

> label and is used by SELinux only. There are two users of of this hook,=

> namely ceph and nfs.
>
> NFS does not care about xattr name. Ceph hardcodes the xattr name to
> security.selinux (XATTR_NAME_SELINUX).
>
> I am making changes to fuse/virtiofs to send security label to virtiofs=
d
> and I need to send xattr name as well. I also hardcoded the name of
> xattr to security.selinux.
>
> Stephen Smalley suggested that it probably is a good idea to modify
> security_dentry_init_security() to also return name of xattr so that
> we can avoid this hardcoding in the callers.
>
> This patch adds a new parameter "const char **xattr_name" to
> security_dentry_init_security() and LSM puts the name of xattr
> too if caller asked for it (xattr_name !=3D NULL).
>
> Signed-off-by: Vivek Goyal <vgoyal@redhat.com>

This is a reasonable step. It doesn't address the possibility
of multiple security attributes, but that's not a real issue today.
It will prevent ceph from using the wrong attribute should a
security module other than SELinux provide a hook.

> ---
>
> I have compile tested this patch. Don't know how to setup ceph and
> test it. Its a very simple change. Hopefully ceph developers can
> have a quick look at it.
>
> A similar attempt was made three years back.
>
> https://lore.kernel.org/linux-security-module/20180626080429.27304-1-zy=
an@redhat.com/T/

My, but I dislike reliving my old arguments.

> ---
>  fs/ceph/xattr.c               |    3 +--
>  fs/nfs/nfs4proc.c             |    3 ++-
>  include/linux/lsm_hook_defs.h |    3 ++-
>  include/linux/lsm_hooks.h     |    1 +
>  include/linux/security.h      |    6 ++++--
>  security/security.c           |    7 ++++---
>  security/selinux/hooks.c      |    6 +++++-
>  7 files changed, 19 insertions(+), 10 deletions(-)
>
> Index: redhat-linux/security/selinux/hooks.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- redhat-linux.orig/security/selinux/hooks.c	2021-09-28 11:36:03.5597=
85943 -0400
> +++ redhat-linux/security/selinux/hooks.c	2021-09-30 14:01:05.869195347=
 -0400
> @@ -2948,7 +2948,8 @@ static void selinux_inode_free_security(
>  }
> =20
>  static int selinux_dentry_init_security(struct dentry *dentry, int mod=
e,
> -					const struct qstr *name, void **ctx,
> +					const struct qstr *name,
> +					const char **xattr_name, void **ctx,
>  					u32 *ctxlen)
>  {
>  	u32 newsid;
> @@ -2961,6 +2962,9 @@ static int selinux_dentry_init_security(
>  	if (rc)
>  		return rc;
> =20
> +	if (xattr_name)
> +		*xattr_name =3D XATTR_NAME_SELINUX;
> +
>  	return security_sid_to_context(&selinux_state, newsid, (char **)ctx,
>  				       ctxlen);
>  }
> Index: redhat-linux/security/security.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- redhat-linux.orig/security/security.c	2021-08-16 10:39:28.518988836=
 -0400
> +++ redhat-linux/security/security.c	2021-09-30 13:54:36.367195347 -040=
0
> @@ -1052,11 +1052,12 @@ void security_inode_free(struct inode *i
>  }
> =20
>  int security_dentry_init_security(struct dentry *dentry, int mode,
> -					const struct qstr *name, void **ctx,
> -					u32 *ctxlen)
> +				  const struct qstr *name,
> +				  const char **xattr_name, void **ctx,
> +				  u32 *ctxlen)
>  {
>  	return call_int_hook(dentry_init_security, -EOPNOTSUPP, dentry, mode,=

> -				name, ctx, ctxlen);
> +				name, xattr_name, ctx, ctxlen);
>  }
>  EXPORT_SYMBOL(security_dentry_init_security);
> =20
> Index: redhat-linux/include/linux/lsm_hooks.h
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- redhat-linux.orig/include/linux/lsm_hooks.h	2021-06-02 10:20:27.717=
485143 -0400
> +++ redhat-linux/include/linux/lsm_hooks.h	2021-09-30 13:56:48.44019534=
7 -0400
> @@ -196,6 +196,7 @@
>   *	@dentry dentry to use in calculating the context.
>   *	@mode mode used to determine resource type.
>   *	@name name of the last path component used to create file
> + *	@xattr_name pointer to place the pointer to security xattr name
>   *	@ctx pointer to place the pointer to the resulting context in.
>   *	@ctxlen point to place the length of the resulting context.
>   * @dentry_create_files_as:
> Index: redhat-linux/include/linux/security.h
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- redhat-linux.orig/include/linux/security.h	2021-08-16 10:39:28.4849=
88836 -0400
> +++ redhat-linux/include/linux/security.h	2021-09-30 13:59:00.288195347=
 -0400
> @@ -317,8 +317,9 @@ int security_add_mnt_opt(const char *opt
>  				int len, void **mnt_opts);
>  int security_move_mount(const struct path *from_path, const struct pat=
h *to_path);
>  int security_dentry_init_security(struct dentry *dentry, int mode,
> -					const struct qstr *name, void **ctx,
> -					u32 *ctxlen);
> +				  const struct qstr *name,
> +				  const char **xattr_name, void **ctx,
> +				  u32 *ctxlen);
>  int security_dentry_create_files_as(struct dentry *dentry, int mode,
>  					struct qstr *name,
>  					const struct cred *old,
> @@ -739,6 +740,7 @@ static inline void security_inode_free(s
>  static inline int security_dentry_init_security(struct dentry *dentry,=

>  						 int mode,
>  						 const struct qstr *name,
> +						 const char **xattr_name,
>  						 void **ctx,
>  						 u32 *ctxlen)
>  {
> Index: redhat-linux/include/linux/lsm_hook_defs.h
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- redhat-linux.orig/include/linux/lsm_hook_defs.h	2021-07-07 11:54:59=
=2E673549151 -0400
> +++ redhat-linux/include/linux/lsm_hook_defs.h	2021-09-30 14:02:13.1141=
95347 -0400
> @@ -83,7 +83,8 @@ LSM_HOOK(int, 0, sb_add_mnt_opt, const c
>  LSM_HOOK(int, 0, move_mount, const struct path *from_path,
>  	 const struct path *to_path)
>  LSM_HOOK(int, 0, dentry_init_security, struct dentry *dentry,
> -	 int mode, const struct qstr *name, void **ctx, u32 *ctxlen)
> +	 int mode, const struct qstr *name, const char **xattr_name,
> +	 void **ctx, u32 *ctxlen)
>  LSM_HOOK(int, 0, dentry_create_files_as, struct dentry *dentry, int mo=
de,
>  	 struct qstr *name, const struct cred *old, struct cred *new)
> =20
> Index: redhat-linux/fs/nfs/nfs4proc.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- redhat-linux.orig/fs/nfs/nfs4proc.c	2021-07-14 14:47:42.732842926 -=
0400
> +++ redhat-linux/fs/nfs/nfs4proc.c	2021-09-30 14:06:02.249195347 -0400
> @@ -127,7 +127,8 @@ nfs4_label_init_security(struct inode *d
>  		return NULL;
> =20
>  	err =3D security_dentry_init_security(dentry, sattr->ia_mode,
> -				&dentry->d_name, (void **)&label->label, &label->len);
> +				&dentry->d_name, NULL,
> +				(void **)&label->label, &label->len);
>  	if (err =3D=3D 0)
>  		return label;
> =20
> Index: redhat-linux/fs/ceph/xattr.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- redhat-linux.orig/fs/ceph/xattr.c	2021-09-09 13:05:21.800611264 -04=
00
> +++ redhat-linux/fs/ceph/xattr.c	2021-09-30 14:14:59.892195347 -0400
> @@ -1311,7 +1311,7 @@ int ceph_security_init_secctx(struct den
>  	int err;
> =20
>  	err =3D security_dentry_init_security(dentry, mode, &dentry->d_name,
> -					    &as_ctx->sec_ctx,
> +					    &name, &as_ctx->sec_ctx,
>  					    &as_ctx->sec_ctxlen);
>  	if (err < 0) {
>  		WARN_ON_ONCE(err !=3D -EOPNOTSUPP);
> @@ -1335,7 +1335,6 @@ int ceph_security_init_secctx(struct den
>  	 * It only supports single security module and only selinux has
>  	 * dentry_init_security hook.
>  	 */
> -	name =3D XATTR_NAME_SELINUX;
>  	name_len =3D strlen(name);
>  	err =3D ceph_pagelist_reserve(pagelist,
>  				    4 * 2 + name_len + as_ctx->sec_ctxlen);
>

