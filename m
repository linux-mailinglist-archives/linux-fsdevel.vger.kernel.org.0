Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B05B417C0D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Sep 2021 21:58:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348275AbhIXUAJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Sep 2021 16:00:09 -0400
Received: from sonic309-27.consmr.mail.ne1.yahoo.com ([66.163.184.153]:40044
        "EHLO sonic309-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1348271AbhIXUAI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Sep 2021 16:00:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1632513514; bh=1DHaIfCHZg7TNpNvaH16RK0FaUQf2OhODJMixX92qlg=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject:Reply-To; b=EHxLLktQcCsSp2p+5Y6g3K8o7/Io+0EmyPv7kzV0oEQQddBxrSPKIITtkfRuT6whZLC4APgINmMQbsjpQ1DQ1MHsObSWPZD/qG/f9+7rw+TFaK8bvYSu/Vnw3IMGFPpob8x149JY6vyufba8twAYClD9bfjeh9WcIHg3ql1LFJ3Gq9W8bLbhg1M9vpTvgTmEA7iLenQJRAaFZuDTtCV0AyMgs5vVRLrl9B9qBhb7Oc3pMZ7vTaq51qp+s+ihr/+NeBXNyH0BuLLnq3t9TfXf9mxYf5Hxx+0ZB5CJ+g4/RtAFbu3myxsKYAV+VXTK66rsAtc3vxQewuaQABP8gGNj0w==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1632513514; bh=zghY2GeNmPE4R9jXzKxW9th+YIHUtYzZCnGwDGp+TjJ=; h=X-Sonic-MF:Subject:To:From:Date:From:Subject; b=Pq1MWg826PLI0Ez9odg6m9z7n6fQbdR64vbJ3KP4XRaxp/HX5T4IIoxnCU3do6iuCKRjE7bbiXD/nRPmSGvFHIQQFO4gVwSiHx9gvaN77yJ1mqM0EHXHrwxM/29jHSYqeD0SIVsaOpmljEe729NGs4KB1DPZeRdkLfLlAepiBpNxnqSO7Fd1UVSCUoySIuMF2Nli30p+7bncmD8DwU/rXK7ET+G+TjbOtZebZmaniqdQfjNewr1EUzXi9vUnJlDgN0vIKOIqFF/fNx5gK/Jw61xD6hl81DdscQyyqDIe22nDWpPwZS9BJllhV8D1JYbplnOiWTDlIv2YLZ7CMjPYlg==
X-YMail-OSG: vfv_PasVM1lbFx4CKQanoj.xWUnJDR_GiQtSFQeu31vd3t3dPL0mPu1z0BkBMgl
 RJgWRt9KlMJrOaDpZakrmG3aN36aABdvp.KM.zG3EFa8NPsepCR6uCYDW0viky9gOlSMnu38tsms
 YZPoG9BDzEoEOcZBsEQWKDEyqvuUSb.59l7nr5GS6Uuh25ewuJ.sfURCVzACS5Yn3.sjPD3sbGIV
 fE.5yKoG5EQAJq3wJFiyKoytgwYqO.pEJZueBQRqbsJNo_cSa2KL1ToTXb0KQlCzxpoXYgFGDaat
 jVlrRP0Jq7OQ4SHFx_GYzAVUk66dd24XG1aiGQnOz3tT_AEV3rX1lGjpyJ3JJOn_FUjPbRZCmDCe
 fG2nBubmIn34vL7B81r07F5B44uwbu48T0ZTYL8E3CpTMfKZ_i0TfZjqHxEdKwWL2NYmHig1ykTW
 tL5Hk6cOj07DAm.xeTmrgd3qSMKTEVkz3i85rjn6WEczKkGSAgTEIvTkH9d4ecdzmGC0sXPa57tZ
 V5N7_8Igd1fIHg2SS6eIgbaTR05J7Az5Ic5LzfBHyFIosrzPjmjI9ej06XISB7WI08Uf5em9hJQ1
 ngdCCMevkwWIaYSBdn14bFRKqz4sni616tJ2SrTK6kL_nv5EtVJo1a3Ynn7tkflTFmB5NOOPVOtS
 hB5LQnn26tC5Ysv4LggDmzgS6eBtnaXdVKvTt5rn83SZpTz9IeFHIig9T1hkNV2RcrKezWg.U7OO
 tfnyx5FULi9Hx1pyx.KODl4K6k7YpGA4qA0wPn0u7IicFS2GFweQLInnG5zqhtgic2f8lOQLvWEi
 RoxoHgrGiQetopjYdLzhOXyH9lx.lZEyXQLSa.4CKjB42kg1kdC_Bn9XZienWERrL4iFwGB1Tqmb
 tlE4FCRFfPkZuhCh4SrNECNAG9ENsd.56amKhYSevatbidrYb3vO2S1H2kdfazXd8hEzrOMWSblP
 M.qmqK2FX4fR99dbnpAyg5NqtdGRYfl3pBMykJHzFQJliRw1qEOolO52kqQK0.UwaHLsuJDGelC3
 vrs78lZHUA3a65CSzAOxD7WRh6Q3YLf5DHN8hUI25kJZcWlSX73oIzhWRqSeRDAA5iEMYP8TTUru
 VCXq192XeN12FzIT5IJtVZlPrCZCRjqzDuMHAHgImETvPC5YPa5P5Kp_lyJfvTaVsyGKSU4I9Ey4
 TFvm_0YzHTUK8UhU58R.uJfVloS6xgIX7IsV9TbA6P7Scv7KHxo0fyDlMihwj8YiG1ifflAct27V
 N4g0SO.4Yq2DvhJO2MOFM6mERCus6a99yxdM6XQiYtI2.O6QBs7t4.VWxMm9ltOQRMXZI2pxzGfz
 euTinbgMBBzmUgvFOjQQrjxxr3z15g4GmsSOdz23xZ0Op40s8Ouk1RIkN9Ccb6uM09K_vrisZr4H
 gkQuI4sZH76J4KOQ4spxxvG7RCgZTKi.Uv_PbS166BR0VtEjfRWjlFuIMd00gOHT2Yg7Bj1SARAi
 N3Cyvi4tcmIX95pV90dLM.HfoRMdoD0shoBISzfDxDFMgsp9VjcvP9B1cV8S8fGUp6u0ukpisk3G
 jwQ7WMEYvyMCwf8JcqChMssVg4uM9RTqNjqIiEXzBwSGZCIFMPwXxqcY2FcsQK9Yt0EhnSYxTkec
 0nx1iw0UlvkcAIKOWauRdla44HcAx9..PZBuxpAyrXTu11rdzxZyD9eSuh.CmoZ80.s8FkRHmr._
 PHQGfUiLiSShi7zLRW4LWYHNUQ.D1myMRyDKfPufR5hnnciRrSKq.XJvRxAzdYPnZOeRS83P1yCW
 d2Ljl.OHqkQcPcFnuGgRtgW0H.fJN_c91PJRlJNH37CSLgKwZ.yrDtCuL7hyQK5utCucXeICGiM6
 _B4FU8aZ.cZfQ9Urd_IvTNnfkTAmmUTnD3qQKp6EwpF6y56DY2h3nghe938_BpzSqh.UkiYPSJD0
 vQr5wQzUEKsnusoug4W0K__lzPpt5YXnj16VVGQXxuWBeQeRxmS.lu21x_pRiTcwxpaJssmJdN2Q
 Vb.b0jWE8lLqgdxUWzObOz3eW0LGfA5mvn9JyUjVzhdccELCz2u0hA_JWktmzwYBJIDgV2R.6v5v
 .UbIp2F3VjrkCmcucoqu_z7oKU_Xo0bvvLXbsdMDm6vLC8fW_YOiyatcobQE_872kdQCtj8tHBQD
 DiCIKHjxq.nT_c_7gKl1RwurX5jIubZhxDvQniPtQjlQ0r9cRYJ5g5JwrO1tYqh7sQ_k1Rf32McG
 He0_h.x_WJGJuatF9JvbBnaCect0kQ0bLNSBtzwJzI5iW9ZtbnliwjXlw2buv._331hCwpYqY_mi
 4qgGIDCwYYUOetsthPL418j2U.Eh.iVmKpiLHSwzKrmz34mqPWrMKHiPLLizZ.R._uV2WhPY4S9f
 OFA--
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.ne1.yahoo.com with HTTP; Fri, 24 Sep 2021 19:58:34 +0000
Received: by kubenode548.mail-prod1.omega.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 114b7935b20447dbb09a5d7e17895187;
          Fri, 24 Sep 2021 19:58:29 +0000 (UTC)
Subject: Re: [PATCH 2/2] fuse: Send security context of inode on file creation
To:     Vivek Goyal <vgoyal@redhat.com>, linux-fsdevel@vger.kernel.org,
        virtio-fs@redhat.com, selinux@vger.kernel.org,
        linux-security-module@vger.kernel.org
Cc:     chirantan@chromium.org, miklos@szeredi.hu,
        stephen.smalley.work@gmail.com, dwalsh@redhat.com,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20210924192442.916927-1-vgoyal@redhat.com>
 <20210924192442.916927-3-vgoyal@redhat.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <a843a6d9-2e7a-768c-b742-fc190880b439@schaufler-ca.com>
Date:   Fri, 24 Sep 2021 12:58:28 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20210924192442.916927-3-vgoyal@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Mailer: WebService/1.1.19043 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/24/2021 12:24 PM, Vivek Goyal wrote:
> When a new inode is created, send its security context to server along
> with creation request (FUSE_CREAT, FUSE_MKNOD, FUSE_MKDIR and FUSE_SYML=
INK).
> This gives server an opportunity to create new file and set security
> context (possibly atomically). In all the configurations it might not
> be possible to set context atomically.
>
> Like nfs and ceph, use security_dentry_init_security() to dermine secur=
ity
> context of inode and send it with create, mkdir, mknod, and symlink req=
uests.
>
> Following is the information sent to server.
>
> - struct fuse_secctx.
>   This contains total size of security context which follows this struc=
ture.
>
> - xattr name string.
>   This string represents name of xattr which should be used while setti=
ng
>   security context. As of now it is hardcoded to "security.selinux".

Why? It's not like "security.SMACK64' is a secret.

> - security context.
>   This is the actual security context whose size is specified in fuse_s=
ecctx
>   struct.

The possibility of multiple security contexts on a file is real
in the not too distant future. Also, a file can have multiple relevant
security attributes at creation. Smack, for example, may assign a
security.SMACK64 and a security.SMACK64TRANSMUTE attribute. Your
interface cannot support either of these cases.

> This patch is modified version of patch from
> Chirantan Ekbote <chirantan@chromium.org>
>
> Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
> ---
>  fs/fuse/dir.c             | 114 ++++++++++++++++++++++++++++++++++++--=

>  fs/fuse/fuse_i.h          |   3 +
>  fs/fuse/inode.c           |   4 +-
>  include/uapi/linux/fuse.h |  11 ++++
>  4 files changed, 126 insertions(+), 6 deletions(-)
>
> diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
> index d9b977c0f38d..439bde1ea329 100644
> --- a/fs/fuse/dir.c
> +++ b/fs/fuse/dir.c
> @@ -17,6 +17,9 @@
>  #include <linux/xattr.h>
>  #include <linux/iversion.h>
>  #include <linux/posix_acl.h>
> +#include <linux/security.h>
> +#include <linux/types.h>
> +#include <linux/kernel.h>
> =20
>  static void fuse_advise_use_readdirplus(struct inode *dir)
>  {
> @@ -456,6 +459,65 @@ static struct dentry *fuse_lookup(struct inode *di=
r, struct dentry *entry,
>  	return ERR_PTR(err);
>  }
> =20
> +static int get_security_context(struct dentry *entry, umode_t mode,
> +				void **security_ctx, u32 *security_ctxlen)
> +{
> +	struct fuse_secctx *fsecctx;
> +	void *ctx, *full_ctx;
> +	u32 ctxlen, full_ctxlen;
> +	int err =3D 0;
> +
> +	err =3D security_dentry_init_security(entry, mode, &entry->d_name, &c=
tx,
> +					    &ctxlen);
> +	if (err) {
> +		if (err !=3D -EOPNOTSUPP)
> +			goto out_err;
> +		/* No LSM is supporting this security hook. Ignore error */
> +		err =3D 0;
> +		ctxlen =3D 0;
> +	}
> +
> +	if (ctxlen > 0) {
> +		/*
> +		 * security_dentry_init_security() does not return the name
> +		 * of lsm or xattr to which label belongs. As of now only
> +		 * selinux implements this. Hence, hardcoding the name to
> +		 * security.selinux.
> +		 */
> +		char *name =3D "security.selinux";
> +		void *ptr;
> +
> +		full_ctxlen =3D sizeof(*fsecctx) + strlen(name) + ctxlen + 1;
> +		full_ctx =3D kzalloc(full_ctxlen, GFP_KERNEL);
> +		if (!full_ctx) {
> +			err =3D -ENOMEM;
> +			kfree(ctx);
> +			goto out_err;
> +		}
> +
> +		ptr =3D full_ctx;
> +		fsecctx =3D (struct fuse_secctx*) ptr;
> +		fsecctx->size =3D ctxlen;
> +		ptr +=3D sizeof(*fsecctx);
> +		strcpy(ptr, name);
> +		ptr +=3D strlen(name) + 1;
> +		memcpy(ptr, ctx, ctxlen);
> +		kfree(ctx);
> +	} else {
> +		full_ctxlen =3D sizeof(*fsecctx);
> +		full_ctx =3D kzalloc(full_ctxlen, GFP_KERNEL);
> +		if (!full_ctx) {
> +			err =3D -ENOMEM;
> +			goto out_err;
> +		}
> +	}
> +
> +	*security_ctxlen =3D full_ctxlen;
> +	*security_ctx =3D full_ctx;
> +out_err:
> +	return err;
> +}
> +
>  /*
>   * Atomic create+open operation
>   *
> @@ -476,6 +538,8 @@ static int fuse_create_open(struct inode *dir, stru=
ct dentry *entry,
>  	struct fuse_entry_out outentry;
>  	struct fuse_inode *fi;
>  	struct fuse_file *ff;
> +	void *security_ctx =3D NULL;
> +	u32 security_ctxlen;
> =20
>  	/* Userspace expects S_IFREG in create mode */
>  	BUG_ON((mode & S_IFMT) !=3D S_IFREG);
> @@ -517,6 +581,18 @@ static int fuse_create_open(struct inode *dir, str=
uct dentry *entry,
>  	args.out_args[0].value =3D &outentry;
>  	args.out_args[1].size =3D sizeof(outopen);
>  	args.out_args[1].value =3D &outopen;
> +
> +	if (fm->fc->init_security) {
> +		err =3D get_security_context(entry, mode, &security_ctx,
> +					   &security_ctxlen);
> +		if (err)
> +			goto out_put_forget_req;
> +
> +		args.in_numargs =3D 3;
> +		args.in_args[2].size =3D security_ctxlen;
> +		args.in_args[2].value =3D security_ctx;
> +	}
> +
>  	err =3D fuse_simple_request(fm, &args);
>  	if (err)
>  		goto out_free_ff;
> @@ -554,6 +630,7 @@ static int fuse_create_open(struct inode *dir, stru=
ct dentry *entry,
> =20
>  out_free_ff:
>  	fuse_file_free(ff);
> +	kfree(security_ctx);
>  out_put_forget_req:
>  	kfree(forget);
>  out_err:
> @@ -613,13 +690,15 @@ static int fuse_atomic_open(struct inode *dir, st=
ruct dentry *entry,
>   */
>  static int create_new_entry(struct fuse_mount *fm, struct fuse_args *a=
rgs,
>  			    struct inode *dir, struct dentry *entry,
> -			    umode_t mode)
> +			    umode_t mode, bool init_security)
>  {
>  	struct fuse_entry_out outarg;
>  	struct inode *inode;
>  	struct dentry *d;
>  	int err;
>  	struct fuse_forget_link *forget;
> +	void *security_ctx =3D NULL;
> +	u32 security_ctxlen =3D 0;
> =20
>  	if (fuse_is_bad(dir))
>  		return -EIO;
> @@ -633,7 +712,29 @@ static int create_new_entry(struct fuse_mount *fm,=
 struct fuse_args *args,
>  	args->out_numargs =3D 1;
>  	args->out_args[0].size =3D sizeof(outarg);
>  	args->out_args[0].value =3D &outarg;
> +
> +	if (init_security) {
> +		unsigned short idx =3D args->in_numargs;
> +
> +		if ((size_t)idx >=3D ARRAY_SIZE(args->in_args)) {
> +			err =3D -ENOMEM;
> +			goto out_put_forget_req;
> +		}
> +
> +		err =3D get_security_context(entry, mode, &security_ctx,
> +					   &security_ctxlen);
> +		if (err)
> +			goto out_put_forget_req;
> +
> +		if (security_ctxlen > 0) {
> +			args->in_args[idx].size =3D security_ctxlen;
> +			args->in_args[idx].value =3D security_ctx;
> +			args->in_numargs++;
> +		}
> +	}
> +
>  	err =3D fuse_simple_request(fm, args);
> +	kfree(security_ctx);
>  	if (err)
>  		goto out_put_forget_req;
> =20
> @@ -691,7 +792,7 @@ static int fuse_mknod(struct user_namespace *mnt_us=
erns, struct inode *dir,
>  	args.in_args[0].value =3D &inarg;
>  	args.in_args[1].size =3D entry->d_name.len + 1;
>  	args.in_args[1].value =3D entry->d_name.name;
> -	return create_new_entry(fm, &args, dir, entry, mode);
> +	return create_new_entry(fm, &args, dir, entry, mode, fm->fc->init_sec=
urity);
>  }
> =20
>  static int fuse_create(struct user_namespace *mnt_userns, struct inode=
 *dir,
> @@ -719,7 +820,8 @@ static int fuse_mkdir(struct user_namespace *mnt_us=
erns, struct inode *dir,
>  	args.in_args[0].value =3D &inarg;
>  	args.in_args[1].size =3D entry->d_name.len + 1;
>  	args.in_args[1].value =3D entry->d_name.name;
> -	return create_new_entry(fm, &args, dir, entry, S_IFDIR);
> +	return create_new_entry(fm, &args, dir, entry, S_IFDIR,
> +				fm->fc->init_security);
>  }
> =20
>  static int fuse_symlink(struct user_namespace *mnt_userns, struct inod=
e *dir,
> @@ -735,7 +837,8 @@ static int fuse_symlink(struct user_namespace *mnt_=
userns, struct inode *dir,
>  	args.in_args[0].value =3D entry->d_name.name;
>  	args.in_args[1].size =3D len;
>  	args.in_args[1].value =3D link;
> -	return create_new_entry(fm, &args, dir, entry, S_IFLNK);
> +	return create_new_entry(fm, &args, dir, entry, S_IFLNK,
> +				fm->fc->init_security);
>  }
> =20
>  void fuse_update_ctime(struct inode *inode)
> @@ -915,7 +1018,8 @@ static int fuse_link(struct dentry *entry, struct =
inode *newdir,
>  	args.in_args[0].value =3D &inarg;
>  	args.in_args[1].size =3D newent->d_name.len + 1;
>  	args.in_args[1].value =3D newent->d_name.name;
> -	err =3D create_new_entry(fm, &args, newdir, newent, inode->i_mode);
> +	err =3D create_new_entry(fm, &args, newdir, newent, inode->i_mode,
> +			       false);
>  	/* Contrary to "normal" filesystems it can happen that link
>  	   makes two "logical" inodes point to the same "physical"
>  	   inode.  We invalidate the attributes of the old one, so it
> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> index 319596df5dc6..885f34f9967f 100644
> --- a/fs/fuse/fuse_i.h
> +++ b/fs/fuse/fuse_i.h
> @@ -765,6 +765,9 @@ struct fuse_conn {
>  	/* Propagate syncfs() to server */
>  	unsigned int sync_fs:1;
> =20
> +	/* Initialize security xattrs when creating a new inode */
> +	unsigned int init_security:1;
> +
>  	/** The number of requests waiting for completion */
>  	atomic_t num_waiting;
> =20
> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> index 36cd03114b6d..343bc9cfbd92 100644
> --- a/fs/fuse/inode.c
> +++ b/fs/fuse/inode.c
> @@ -1152,6 +1152,8 @@ static void process_init_reply(struct fuse_mount =
*fm, struct fuse_args *args,
>  			}
>  			if (arg->flags & FUSE_SETXATTR_EXT)
>  				fc->setxattr_ext =3D 1;
> +			if (arg->flags & FUSE_SECURITY_CTX)
> +				fc->init_security =3D 1;
>  		} else {
>  			ra_pages =3D fc->max_read / PAGE_SIZE;
>  			fc->no_lock =3D 1;
> @@ -1195,7 +1197,7 @@ void fuse_send_init(struct fuse_mount *fm)
>  		FUSE_PARALLEL_DIROPS | FUSE_HANDLE_KILLPRIV | FUSE_POSIX_ACL |
>  		FUSE_ABORT_ERROR | FUSE_MAX_PAGES | FUSE_CACHE_SYMLINKS |
>  		FUSE_NO_OPENDIR_SUPPORT | FUSE_EXPLICIT_INVAL_DATA |
> -		FUSE_HANDLE_KILLPRIV_V2 | FUSE_SETXATTR_EXT;
> +		FUSE_HANDLE_KILLPRIV_V2 | FUSE_SETXATTR_EXT | FUSE_SECURITY_CTX;
>  #ifdef CONFIG_FUSE_DAX
>  	if (fm->fc->dax)
>  		ia->in.flags |=3D FUSE_MAP_ALIGNMENT;
> diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
> index 2fe54c80051a..777c773e143e 100644
> --- a/include/uapi/linux/fuse.h
> +++ b/include/uapi/linux/fuse.h
> @@ -986,4 +986,15 @@ struct fuse_syncfs_in {
>  	uint64_t	padding;
>  };
> =20
> +/*
> + * For each security context, send fuse_secctx with size of security c=
ontext
> + * fuse_secctx will be followed by security context name and this in t=
urn
> + * will be followed by actual context label.
> + * fuse_secctx, name, context
> + * */
> +struct fuse_secctx {
> +	uint32_t	size;
> +	uint32_t	padding;
> +};
> +
>  #endif /* _LINUX_FUSE_H */

