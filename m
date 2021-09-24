Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 722B9417CA2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Sep 2021 22:54:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346428AbhIXUz6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Sep 2021 16:55:58 -0400
Received: from sonic309-27.consmr.mail.ne1.yahoo.com ([66.163.184.153]:39234
        "EHLO sonic309-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1346038AbhIXUz5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Sep 2021 16:55:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1632516863; bh=2woFotEMHv71j98qenWpmkaWqy+/WTwbJyQZJQVd9Rs=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject:Reply-To; b=RivMJnhQjrMDiW51z2FlNpwoTd9pfCexAmkldGpJ8l9CVXSdfQ2hKZQVxpRFgI1V87tFEQpGswY+BgN+BAactx4zZ7wE+E6Fh34oW45Xjb0wrryRtfIeLHFlegvZqTfqEFHfUf/BsVy7jDW8NFqbHzf6E8FsCueY6MzEeZzkK99sGCQQy75T2FoktwhRp9j6P2rKs/EEHCaCMwCi6/mRm+glCdj5wwCSw1xD8BptdWrzYpLj5cN8bD5H2L9hX7RHCCy5Ik5qhOaB7bTDC7YbMLewLt9Z0Mh7xL0c7JNLGM4umGt3JDPkWCPPgpjIfeygmsAnb3W9luNrkXMKPElTPA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1632516863; bh=htATPwz4iqAl6aZsKPMhpkTeidUw25ZbQOLIB6bGZPJ=; h=X-Sonic-MF:Subject:To:From:Date:From:Subject; b=YK0J7J51OZ1smv3cKgU1aXFS9i8S8Y2uaq2850Jyzl9qbod6lkzWaGm0ccrjmfclfr3fB14/rkgwcr2F2B55SGrzfFJ5v2T+KasiX0T1DlCG3GOUdpcU+kVbNMcnEPL/dMy9y1g6QyB8IhXQcbIkKgMN6tkoBb2Ugihw2XhMpULZCvqmKb8HwZjxUzpVCnvNOE2i6fHhGhhmawJBW24QiD+q90K1Jxv/fLpD89FR3GJQ8VvTL9u60JmYy982fGpjVdXhjUgpRQsl9/uSnBCSyrFbudcT7xiqiXXaEzAuv6Qy6Nh6ZyZkaE65Sh5VXeQwYKz0M+z6nps0prWlmIQAJA==
X-YMail-OSG: IrnTbdwVM1niljGgCCU0tT5ZZSUo6Wv38RfSyfDra4R_2_CDMcbCn4rv0VvxOpU
 7WYYQFA7y8UGhWVJkCaOcQajLruHPdS378BzBy6HL0vN8CJ1hHtxKPk121qbWu1.m69WOvMjBUqi
 LYovPQ16vFdp60gQDkeDGIyL.YMyOe2PDXIngxNp3DalbKcsfLuEWuBrJ19kXa2IRQBOSIXiq1kT
 F4jvAMvm0dmMgB0zhwS.CIhJsWr1PBTP0u_CQkjUnWO4WsvJcFfR.9_E9GnIiO1WmoK3HqGCizNe
 _oeHEbHJD2sJH7UwDfluVx4iMUwO3Cta6XmhEmJ4fY9fqo_t.ngJ45OhWPtSpbbRaI_S.rvr8eK0
 CzNDDqdWknUKutwjtHx2JOHWDLRLbvHs8YGpnQevjIlREkyHxdXe7r0E6pjYfSIBTMadW0sVxWb1
 tLaH.hRB5kV6fOSejLqHOqJgN.SG2R.gXmA5XCKjsdzgutahgtOjQhMi72lBT5A4P2dSGkUSTX16
 B2ivNMCtj3LjqexAB5ESMQ9yVf3pbCOATChYfpGfuwTWMHC.w9txohTKKyU_n6JfiyhCt.w663.5
 OF62NPFO38YjzBgS0nb_Dbo_gfSVPYMQsFZBPeBkq9DrUaNKHC7N2Mc.mbMkM5avCDHD8DJHl2YS
 E3ZGWA4SnT9IWlqtYG5yWWk3xlKVZ6_uj6uzhcE3ONWXhal3_9KcnftcaIBLVzJ7NM0NPrgdrpiT
 aL34.IafF9eu.Ry4shAu1MHCoe9Osbd5iqbC1rQwpuNAq7CulJ9iezNMJLk.UAxC0uXMCpxZ24Rf
 3Ek153hQjPYW3TH2tuzELTHCEh5XAP0UsHPI4b9svx6dMH24gn60rKVVJEdwoZrbpN89baiSPdp6
 3F9fW8F6ni2R9CKVI3XguenIti3CEAdu5BQh1nzTdKf8AWlkf_FmY3usuBMtU.I87U60Ulp8IXjK
 HqsqwAwDkhOXlOMzvkNCLayT61sReDgSZeq9A.10XBbTKKbBEStdoqcp2wz4fFinjQsowWvDWomn
 Oj7TUGbTQ1AXCc6c.6ZFTWHQD.neFv6OOb8m8HgzwTwxQrdHSJGzFG68fXO7VIOi1S.CGvorEe1T
 Nn789vPWr4beQRxD8kcH0bOssKDDcbno_faA7c8vEL_bpO4L6G2MQpjBO9zmHZcOx9MIXcjVK8T8
 If3cHwyuuXt90HbRpCM4nZ9oYQmP0CDe2Yw6NL4ZLGtmFjW7PPpPLyaowIPcpmyqeVCkXsWTs5Dg
 wFpxqD0NMUi2_tLW_TXXR3yBFcaQ0QzWEYJS5LbQPLcbRvhGyQ._Iw36OAa6h_XAIG8O18KBxHJP
 KRX.7_qXvcb.RjWz8D2rf9o8inAexI2bf1NkSVlno.elmMA4Pt6.lqLa7zxiec91.jpbsmr4OTh3
 6Vw3GPv8X6hbmz.qIyCOhIemwac.C6l5a0sru3woaZdg5NxiYcAvEJGR14dfAYsOVdfAWiBE0VHU
 .1H6UUf1RTU8eAgvhX8hlHU0ehUoEzdQMp2I7t7KVQWlT5Bk12SUxW7OItA1chJ.R5srbC47gCow
 CStVZyWEFC4Jvy89y6aTDv8zfDO3G9BL6PTX6K3Cwqd7mhnm1vsjk2kwsuy56F_Z48Y_CICrIXBF
 5_YPfpasjEH_tONwBZcv0Zwr.CsaTsYkdHEtLOR.Td3DvUaqVqxoWnpsXhtwbOLkKqsxE6PVoyyw
 1SxAXRIeC30XKcf.EQMCFrzv_Qowv1TglIayo2XNSbD5eWchuTKqsbojhmGCu1anFBK_AnsuwmGO
 r57hIbDfZ1nad50udu1sTcGZBQXckEcSP8SRfpf4ym3gLXqNFdHUReYr_kJffwK2dP9exi83qJ.A
 W_IsSw.Z0avrnQs1DCitAVX5AGXhOp2Yr0FEU8vI8fcDUHzdMfCOTk3RqIpsIl7WiD2Ui9dOTAAR
 kc4k_nBVyI4yPAkZC5la3n6nKC.6ScnySNO4Nv4tIeQgY9gnnhu_gPub_4LIsxglkqvlPFTQtNQM
 neU8F8KfkusiSx6kr_hU4XCMGzsq5vnjuScca3g7SQRaISbIDZw..5in7SuOPuplTIYIIZuulm2C
 7F6JZVQm0rVIUbn4.0ZuVlnOLcqCXDFiFkriLK.jMlrYRJxX6SaaFfVS0qBINBtpebTud7fnu4_C
 AJVTatloakvrOUUIvEmV63gjmzbPwa72ikYkvjIOYKcsWFTZNqEUQkYchvks.CnB9utz6x2yHCWy
 obsIaLx4frLQPKiBqYVFZypjHyJeli.EhsY7nmk_3OBpvr.fcmU8QdlvQtdZ5d6Pny0wfvXUbLq2
 nZv1gHjkCavM1Caz1jlJbIcIo4ozFSpWSqhrvj7avb8scKJ4kn_Pa4mMI9zhUSyw-
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.ne1.yahoo.com with HTTP; Fri, 24 Sep 2021 20:54:23 +0000
Received: by kubenode526.mail-prod1.omega.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 45c482c63dbc580e8c694645c4296290;
          Fri, 24 Sep 2021 20:54:21 +0000 (UTC)
Subject: Re: [PATCH 2/2] fuse: Send security context of inode on file creation
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, virtio-fs@redhat.com,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        chirantan@chromium.org, miklos@szeredi.hu,
        stephen.smalley.work@gmail.com, dwalsh@redhat.com,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20210924192442.916927-1-vgoyal@redhat.com>
 <20210924192442.916927-3-vgoyal@redhat.com>
 <a843a6d9-2e7a-768c-b742-fc190880b439@schaufler-ca.com>
 <YU4ypwtADWRn/A0p@redhat.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <f92a082e-c329-f079-6765-ac8b44e45ee4@schaufler-ca.com>
Date:   Fri, 24 Sep 2021 13:54:20 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YU4ypwtADWRn/A0p@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Mailer: WebService/1.1.19043 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/24/2021 1:18 PM, Vivek Goyal wrote:
> On Fri, Sep 24, 2021 at 12:58:28PM -0700, Casey Schaufler wrote:
>> On 9/24/2021 12:24 PM, Vivek Goyal wrote:
>>> When a new inode is created, send its security context to server alon=
g
>>> with creation request (FUSE_CREAT, FUSE_MKNOD, FUSE_MKDIR and FUSE_SY=
MLINK).
>>> This gives server an opportunity to create new file and set security
>>> context (possibly atomically). In all the configurations it might not=

>>> be possible to set context atomically.
>>>
>>> Like nfs and ceph, use security_dentry_init_security() to dermine sec=
urity
>>> context of inode and send it with create, mkdir, mknod, and symlink r=
equests.
>>>
>>> Following is the information sent to server.
>>>
>>> - struct fuse_secctx.
>>>   This contains total size of security context which follows this str=
ucture.
>>>
>>> - xattr name string.
>>>   This string represents name of xattr which should be used while set=
ting
>>>   security context. As of now it is hardcoded to "security.selinux".
>> Why? It's not like "security.SMACK64' is a secret.
> Sorry, I don't understand what's the concern. Can you elaborate a bit
> more.

Sure. Interfaces that are designed as special case solutions for
SELinux tend to make my life miserable as the Smack maintainer and
for the efforts to complete LSM stacking. You make the change for
SELinux and leave the generalization as an exercise for some poor
sod like me to deal with later.

> I am hardcoding name to "security.selinux" because as of now only
> SELinux implements this hook.

Yes. A Smack hook implementation is on the todo list. If you hard code
this in fuse you're adding another thing that has to be done for
Smack support.

>  And there is no way to know the name
> of xattr, so I have had to hardcode it. But tomorrow if interface
> changes so that name of xattr is also returned, we can easily get
> rid of hardcoding.

So why not make the interface do that now?

> If another LSM decides to implement this hook, then we can send
> that name as well. Say "security.SMACK64".

Again, why not make it work that way now, and avoid having
to change the protocol later? Changing protocols and interfaces
is much harder than doing them generally in the first place.

>>> - security context.
>>>   This is the actual security context whose size is specified in fuse=
_secctx
>>>   struct.
>> The possibility of multiple security contexts on a file is real
>> in the not too distant future. Also, a file can have multiple relevant=

>> security attributes at creation. Smack, for example, may assign a
>> security.SMACK64 and a security.SMACK64TRANSMUTE attribute. Your
>> interface cannot support either of these cases.
> Right. As of now it does not support capability to support multiple
> security context. But we should be easily able to extend the protocol
> whenever that supports lands in kernel.

No. Extending single data item protocols to support multiple
data items *hurts* most of the time. If it wasn't so much more
complicated you'd be doing it up front without fussing about it.

>  Say a new option
> FUSE_SECURITY_CTX_EXT which will allow sending multiple security
> context labels (along with associated xattr names).
>
> As of now there is no need to increase the complexity of current
> implementation both in fuse as well as virtiofsd when kernel
> does not even support multiple lables using security_dentry_init_securi=
ty()
> hook.

You're 100% correct. For your purpose today there's no reason to
do anything else. It would be really handy if I didn't have yet
another thing that I don't have the time to rewrite.

>
> Thanks
> Vivek
>
>>> This patch is modified version of patch from
>>> Chirantan Ekbote <chirantan@chromium.org>
>>>
>>> Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
>>> ---
>>>  fs/fuse/dir.c             | 114 ++++++++++++++++++++++++++++++++++++=
--
>>>  fs/fuse/fuse_i.h          |   3 +
>>>  fs/fuse/inode.c           |   4 +-
>>>  include/uapi/linux/fuse.h |  11 ++++
>>>  4 files changed, 126 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
>>> index d9b977c0f38d..439bde1ea329 100644
>>> --- a/fs/fuse/dir.c
>>> +++ b/fs/fuse/dir.c
>>> @@ -17,6 +17,9 @@
>>>  #include <linux/xattr.h>
>>>  #include <linux/iversion.h>
>>>  #include <linux/posix_acl.h>
>>> +#include <linux/security.h>
>>> +#include <linux/types.h>
>>> +#include <linux/kernel.h>
>>> =20
>>>  static void fuse_advise_use_readdirplus(struct inode *dir)
>>>  {
>>> @@ -456,6 +459,65 @@ static struct dentry *fuse_lookup(struct inode *=
dir, struct dentry *entry,
>>>  	return ERR_PTR(err);
>>>  }
>>> =20
>>> +static int get_security_context(struct dentry *entry, umode_t mode,
>>> +				void **security_ctx, u32 *security_ctxlen)
>>> +{
>>> +	struct fuse_secctx *fsecctx;
>>> +	void *ctx, *full_ctx;
>>> +	u32 ctxlen, full_ctxlen;
>>> +	int err =3D 0;
>>> +
>>> +	err =3D security_dentry_init_security(entry, mode, &entry->d_name, =
&ctx,
>>> +					    &ctxlen);
>>> +	if (err) {
>>> +		if (err !=3D -EOPNOTSUPP)
>>> +			goto out_err;
>>> +		/* No LSM is supporting this security hook. Ignore error */
>>> +		err =3D 0;
>>> +		ctxlen =3D 0;
>>> +	}
>>> +
>>> +	if (ctxlen > 0) {
>>> +		/*
>>> +		 * security_dentry_init_security() does not return the name
>>> +		 * of lsm or xattr to which label belongs. As of now only
>>> +		 * selinux implements this. Hence, hardcoding the name to
>>> +		 * security.selinux.
>>> +		 */
>>> +		char *name =3D "security.selinux";
>>> +		void *ptr;
>>> +
>>> +		full_ctxlen =3D sizeof(*fsecctx) + strlen(name) + ctxlen + 1;
>>> +		full_ctx =3D kzalloc(full_ctxlen, GFP_KERNEL);
>>> +		if (!full_ctx) {
>>> +			err =3D -ENOMEM;
>>> +			kfree(ctx);
>>> +			goto out_err;
>>> +		}
>>> +
>>> +		ptr =3D full_ctx;
>>> +		fsecctx =3D (struct fuse_secctx*) ptr;
>>> +		fsecctx->size =3D ctxlen;
>>> +		ptr +=3D sizeof(*fsecctx);
>>> +		strcpy(ptr, name);
>>> +		ptr +=3D strlen(name) + 1;
>>> +		memcpy(ptr, ctx, ctxlen);
>>> +		kfree(ctx);
>>> +	} else {
>>> +		full_ctxlen =3D sizeof(*fsecctx);
>>> +		full_ctx =3D kzalloc(full_ctxlen, GFP_KERNEL);
>>> +		if (!full_ctx) {
>>> +			err =3D -ENOMEM;
>>> +			goto out_err;
>>> +		}
>>> +	}
>>> +
>>> +	*security_ctxlen =3D full_ctxlen;
>>> +	*security_ctx =3D full_ctx;
>>> +out_err:
>>> +	return err;
>>> +}
>>> +
>>>  /*
>>>   * Atomic create+open operation
>>>   *
>>> @@ -476,6 +538,8 @@ static int fuse_create_open(struct inode *dir, st=
ruct dentry *entry,
>>>  	struct fuse_entry_out outentry;
>>>  	struct fuse_inode *fi;
>>>  	struct fuse_file *ff;
>>> +	void *security_ctx =3D NULL;
>>> +	u32 security_ctxlen;
>>> =20
>>>  	/* Userspace expects S_IFREG in create mode */
>>>  	BUG_ON((mode & S_IFMT) !=3D S_IFREG);
>>> @@ -517,6 +581,18 @@ static int fuse_create_open(struct inode *dir, s=
truct dentry *entry,
>>>  	args.out_args[0].value =3D &outentry;
>>>  	args.out_args[1].size =3D sizeof(outopen);
>>>  	args.out_args[1].value =3D &outopen;
>>> +
>>> +	if (fm->fc->init_security) {
>>> +		err =3D get_security_context(entry, mode, &security_ctx,
>>> +					   &security_ctxlen);
>>> +		if (err)
>>> +			goto out_put_forget_req;
>>> +
>>> +		args.in_numargs =3D 3;
>>> +		args.in_args[2].size =3D security_ctxlen;
>>> +		args.in_args[2].value =3D security_ctx;
>>> +	}
>>> +
>>>  	err =3D fuse_simple_request(fm, &args);
>>>  	if (err)
>>>  		goto out_free_ff;
>>> @@ -554,6 +630,7 @@ static int fuse_create_open(struct inode *dir, st=
ruct dentry *entry,
>>> =20
>>>  out_free_ff:
>>>  	fuse_file_free(ff);
>>> +	kfree(security_ctx);
>>>  out_put_forget_req:
>>>  	kfree(forget);
>>>  out_err:
>>> @@ -613,13 +690,15 @@ static int fuse_atomic_open(struct inode *dir, =
struct dentry *entry,
>>>   */
>>>  static int create_new_entry(struct fuse_mount *fm, struct fuse_args =
*args,
>>>  			    struct inode *dir, struct dentry *entry,
>>> -			    umode_t mode)
>>> +			    umode_t mode, bool init_security)
>>>  {
>>>  	struct fuse_entry_out outarg;
>>>  	struct inode *inode;
>>>  	struct dentry *d;
>>>  	int err;
>>>  	struct fuse_forget_link *forget;
>>> +	void *security_ctx =3D NULL;
>>> +	u32 security_ctxlen =3D 0;
>>> =20
>>>  	if (fuse_is_bad(dir))
>>>  		return -EIO;
>>> @@ -633,7 +712,29 @@ static int create_new_entry(struct fuse_mount *f=
m, struct fuse_args *args,
>>>  	args->out_numargs =3D 1;
>>>  	args->out_args[0].size =3D sizeof(outarg);
>>>  	args->out_args[0].value =3D &outarg;
>>> +
>>> +	if (init_security) {
>>> +		unsigned short idx =3D args->in_numargs;
>>> +
>>> +		if ((size_t)idx >=3D ARRAY_SIZE(args->in_args)) {
>>> +			err =3D -ENOMEM;
>>> +			goto out_put_forget_req;
>>> +		}
>>> +
>>> +		err =3D get_security_context(entry, mode, &security_ctx,
>>> +					   &security_ctxlen);
>>> +		if (err)
>>> +			goto out_put_forget_req;
>>> +
>>> +		if (security_ctxlen > 0) {
>>> +			args->in_args[idx].size =3D security_ctxlen;
>>> +			args->in_args[idx].value =3D security_ctx;
>>> +			args->in_numargs++;
>>> +		}
>>> +	}
>>> +
>>>  	err =3D fuse_simple_request(fm, args);
>>> +	kfree(security_ctx);
>>>  	if (err)
>>>  		goto out_put_forget_req;
>>> =20
>>> @@ -691,7 +792,7 @@ static int fuse_mknod(struct user_namespace *mnt_=
userns, struct inode *dir,
>>>  	args.in_args[0].value =3D &inarg;
>>>  	args.in_args[1].size =3D entry->d_name.len + 1;
>>>  	args.in_args[1].value =3D entry->d_name.name;
>>> -	return create_new_entry(fm, &args, dir, entry, mode);
>>> +	return create_new_entry(fm, &args, dir, entry, mode, fm->fc->init_s=
ecurity);
>>>  }
>>> =20
>>>  static int fuse_create(struct user_namespace *mnt_userns, struct ino=
de *dir,
>>> @@ -719,7 +820,8 @@ static int fuse_mkdir(struct user_namespace *mnt_=
userns, struct inode *dir,
>>>  	args.in_args[0].value =3D &inarg;
>>>  	args.in_args[1].size =3D entry->d_name.len + 1;
>>>  	args.in_args[1].value =3D entry->d_name.name;
>>> -	return create_new_entry(fm, &args, dir, entry, S_IFDIR);
>>> +	return create_new_entry(fm, &args, dir, entry, S_IFDIR,
>>> +				fm->fc->init_security);
>>>  }
>>> =20
>>>  static int fuse_symlink(struct user_namespace *mnt_userns, struct in=
ode *dir,
>>> @@ -735,7 +837,8 @@ static int fuse_symlink(struct user_namespace *mn=
t_userns, struct inode *dir,
>>>  	args.in_args[0].value =3D entry->d_name.name;
>>>  	args.in_args[1].size =3D len;
>>>  	args.in_args[1].value =3D link;
>>> -	return create_new_entry(fm, &args, dir, entry, S_IFLNK);
>>> +	return create_new_entry(fm, &args, dir, entry, S_IFLNK,
>>> +				fm->fc->init_security);
>>>  }
>>> =20
>>>  void fuse_update_ctime(struct inode *inode)
>>> @@ -915,7 +1018,8 @@ static int fuse_link(struct dentry *entry, struc=
t inode *newdir,
>>>  	args.in_args[0].value =3D &inarg;
>>>  	args.in_args[1].size =3D newent->d_name.len + 1;
>>>  	args.in_args[1].value =3D newent->d_name.name;
>>> -	err =3D create_new_entry(fm, &args, newdir, newent, inode->i_mode);=

>>> +	err =3D create_new_entry(fm, &args, newdir, newent, inode->i_mode,
>>> +			       false);
>>>  	/* Contrary to "normal" filesystems it can happen that link
>>>  	   makes two "logical" inodes point to the same "physical"
>>>  	   inode.  We invalidate the attributes of the old one, so it
>>> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
>>> index 319596df5dc6..885f34f9967f 100644
>>> --- a/fs/fuse/fuse_i.h
>>> +++ b/fs/fuse/fuse_i.h
>>> @@ -765,6 +765,9 @@ struct fuse_conn {
>>>  	/* Propagate syncfs() to server */
>>>  	unsigned int sync_fs:1;
>>> =20
>>> +	/* Initialize security xattrs when creating a new inode */
>>> +	unsigned int init_security:1;
>>> +
>>>  	/** The number of requests waiting for completion */
>>>  	atomic_t num_waiting;
>>> =20
>>> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
>>> index 36cd03114b6d..343bc9cfbd92 100644
>>> --- a/fs/fuse/inode.c
>>> +++ b/fs/fuse/inode.c
>>> @@ -1152,6 +1152,8 @@ static void process_init_reply(struct fuse_moun=
t *fm, struct fuse_args *args,
>>>  			}
>>>  			if (arg->flags & FUSE_SETXATTR_EXT)
>>>  				fc->setxattr_ext =3D 1;
>>> +			if (arg->flags & FUSE_SECURITY_CTX)
>>> +				fc->init_security =3D 1;
>>>  		} else {
>>>  			ra_pages =3D fc->max_read / PAGE_SIZE;
>>>  			fc->no_lock =3D 1;
>>> @@ -1195,7 +1197,7 @@ void fuse_send_init(struct fuse_mount *fm)
>>>  		FUSE_PARALLEL_DIROPS | FUSE_HANDLE_KILLPRIV | FUSE_POSIX_ACL |
>>>  		FUSE_ABORT_ERROR | FUSE_MAX_PAGES | FUSE_CACHE_SYMLINKS |
>>>  		FUSE_NO_OPENDIR_SUPPORT | FUSE_EXPLICIT_INVAL_DATA |
>>> -		FUSE_HANDLE_KILLPRIV_V2 | FUSE_SETXATTR_EXT;
>>> +		FUSE_HANDLE_KILLPRIV_V2 | FUSE_SETXATTR_EXT | FUSE_SECURITY_CTX;
>>>  #ifdef CONFIG_FUSE_DAX
>>>  	if (fm->fc->dax)
>>>  		ia->in.flags |=3D FUSE_MAP_ALIGNMENT;
>>> diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
>>> index 2fe54c80051a..777c773e143e 100644
>>> --- a/include/uapi/linux/fuse.h
>>> +++ b/include/uapi/linux/fuse.h
>>> @@ -986,4 +986,15 @@ struct fuse_syncfs_in {
>>>  	uint64_t	padding;
>>>  };
>>> =20
>>> +/*
>>> + * For each security context, send fuse_secctx with size of security=
 context
>>> + * fuse_secctx will be followed by security context name and this in=
 turn
>>> + * will be followed by actual context label.
>>> + * fuse_secctx, name, context
>>> + * */
>>> +struct fuse_secctx {
>>> +	uint32_t	size;
>>> +	uint32_t	padding;
>>> +};
>>> +
>>>  #endif /* _LINUX_FUSE_H */

