Return-Path: <linux-fsdevel+bounces-2285-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3079C7E4722
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Nov 2023 18:35:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA60F281260
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Nov 2023 17:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C059347D3;
	Tue,  7 Nov 2023 17:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="Jx+8O2Ub"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D1E331584
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Nov 2023 17:35:08 +0000 (UTC)
Received: from sonic315-26.consmr.mail.ne1.yahoo.com (sonic315-26.consmr.mail.ne1.yahoo.com [66.163.190.152])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9EB6C0
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Nov 2023 09:35:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1699378507; bh=Y78C9oj/VyqFI932tuWgBG8pem3zGDoR/xbm8WGnhD0=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=Jx+8O2UbxM5J0J62pODB1jT7j0JP1SlsQCPrc4e8yig9VXFia6sP5PfX5JOdyRUi5E4Y3O2M5I+SqxM4PVnm8vwXm4bxj0Meozkz/96C6Y4TpnMVIW9CwSU0j+13FiXdETbDyqXnC6wWuhdsC0GiUfYiecm6J1utYDSCaaKLrxVD3qg+wQiSGmh7gEiScIErADeypb/0OYnshRfha1KIP/leNyDq/pZVgSstkTiKyRiyFYsUrSRkmDiEcaWQte3Ptc9aTetOq9/8E0rcz1MYmXOPrRlkYM3Loms0zQt7q0JNJhq5TpUV/W4njDJaNPBF79sV7ifIDz0ag2nraTNdLQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1699378507; bh=9PzmuWq4QpB3apzM5MKTBfgGD2BOB4XXrOCfD3PR1M/=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=RtwDermb5BpqGU2zQQZd2KtDINxJugWTDEs9CqX+/1LPDg89cmWqKYNXH5dzuYs/jyhrpH256Mbi6tD1Vv3deD0SfDNU61AScB3f4OJyAp54dYjnUCyg2sj+N7wVGp/aLiUJ3j9Z/smukn3+NCe1GrWrLX6eEjTJJ7S2I7cCLjpclMaSvymJZRZmr+bmfciU9l+rxm/wpIMuzM0ywg39N+eUagArqRvM36PRMgx4+UgqpTU5mNS4IbE3ZyaACLV28+2BWvML79HcwjN+D3MVvYgVBDKjO1i52TxtAcTzUuSrKXug4WtI8JlNvl8o412b5Pd/oeQ/UEztRAp5eL6ZFA==
X-YMail-OSG: 5Fm66MsVM1niqzWnrILX3c3OsT4vJPgnvYKab6lKD2JA1otQ6eplEU9Z3gvOMT7
 DtGq3__TB8fgvsEn8TdIEXIhZhbSQXyc92oHwvXTicmF3Vqr2SSxp5EQTUHcDIj_sItiGNJoCr9b
 Dej.I_m6UES4dfat_A3TZbL73wNouNg26aokX45qL1T0K0H72_jjyPhE0boOYS6tZ834yfoFvxLB
 AZhPGWNztLezpjAY12VSxSi6i0MZWzLueIamZ3.1oj7_9lyXyUXBjlg0vcitzOx1.NJ8jPTFlDfb
 GFHm4RgLtrdReJP1vocGH6r7pH.gyomMnhT42rfkON8Wr3v8saoBR58ZV9_s6ra67WWJgYM_3.2v
 Yj_mHs8i4Or92wx28doPlSe_vrUFqdpX8YP0DB7mjiZtocvf1_Uk6tCth.QtBGoMiR05PIhVA6WY
 lSpe5vqCFx.mO7K4lLlha_5BDLFSsbDqv6wNb9ntkxnIpX9rCOOdF9v6osu4XGdEnExj5PmRaiqy
 TBtMPXuv5KhIJ4MFi4vkKj3t1LRVVdL4SqP00ygopJely86zn7uHXc9j8xhrkdrBWCm_.pSnxR_x
 I3LV6QCb3vl425iHw5JcI.zfWhsfytLVq8i2fJCQ4EBwdelcWMjOoajRWCvEhloaGc.nyjtnF246
 3V5Ru6ByQhFGGpa4WitOGr.iLqxJII95OM01zvMKkKTuy80luRlY9JZuOztRIttxA68F.BRCFCZH
 MfrAZbiO9VWSJ4nmdv1.TURVZ_vp58mxOjkZBbXdDOV1mlHhtRwpt.nj23642WEnOVS2MoVnN3bw
 0P.I.rjl4aMB_SYWC_3jXBXpi6gwKlozUZ1yuQe4Enad3kwf0ariIFjyqL7xqc4qbq0TV9H9A3sj
 qPrygxuqAxDr.E4kxVAj3HoppO8C5_JW1FkucT7RSuQRkLLbYelnB0ZrQ1e3AkikiEPTWOPy4ZWU
 iOUi8WJrX1Xy4OTRhJo_6rHWhfigqjfnYFFAdP3F.PwtHIEjVllwVp6twegV88gbGDLFkYe6yspf
 Ul638IupeABYn9D6fHLIWmW3_VhlompMcOe_QcswCTBHYgsQLwnz1VLDsuWTOhjEzAnGa4D9YPeQ
 qt17NXHHJPuhBRIPfa.mIWpHof5vv2L.tWqghTrATACncmin4xcwXH99pB6vrxo83_d4oA6R90mX
 nbl64lHR.2gSKQndx6lrR284ZkCpIMbGA1S6DskeLxKLSpna6jSI5mzDGeuxIkyT8MBdzaehiwDm
 .oR1.TqtGRRqdD3YDhsY0SArvXxCMoK8P59WXNKHpFwMYKNpPQTwtJXkBOkdZuR3ejR9FOrd4vx3
 Ia0ifxGSXa4qYW3UBV7us4VS4i_JU1eFyNmot.8zZTtslmsLN6b9.PuKnJ2vzAZx8JYqtIyZKhIz
 BrkA4u1yoTUu2XSr4d.2JJKvrkiHpCKm0k5un7PIUQbd.mAuZqP0nn0KrDOeFn8TKIvQrexFXOWn
 DDgJNzwu7D8cQ9RKdE6Lg5nxNqxcJSa8EAKpi41fOoMe8nTRLB_7DaHZnl.Ws6Ex0nNQkA_gyka9
 3su82T1htWr9JqEmyElX6J4GylBYo2d14Oyud7xbbE2x.c1c8bpY2lF8cxzEhQIsJpH1Og_EgHjE
 94PSxo0m4dk2.3VpvCDPRxr1SWfDPLZ46FMy26y6pbHy1alzQb5Aj2KaMD2eqk2sFwyf3cMpzpAN
 kvBx40_SvqhHZS26fKj_VQZTWiaxyk_BddGywNSA0.qTPNu5B7YPa3hBJvjhnSiw6ZSQRf4HYjg1
 jgLXDeG2FNcctbY9pu5Lno6_Izcu60fGEbq.Rpknbt4RNEgRIcPowBY3VjyBlWX75qp53Ws1A3k_
 RqJR9qoQIEua2fry5DG8Atb2vlE6r66obd9uZOctA5Xyi0krfhzAfoExqhYgjXMWRxmxl6dZcMpZ
 DmE.Ymo8A2QAFPrqWGf0PYnWQFaRrD2uvh0vVXh6R2CnVSVpqwFsr1QVBqbIB.3puwwSHlxrwB0n
 .v7xq7J9Dkie34Md5Nyi7Q.8IFYVqkXHVsnqHBqwGSOqyLdTDEmWdipxlOZ9.ueZ_rKv3F_7s2BO
 PrKFDYM6YQohMlst4BwFEhFHywbomhR7lrjNgAOqkqaFJjrPFSN3F7GFZ2ulm9fEHLtMT07GVe_q
 epZj9RkEbcyCQOOwpv3gzvfeMJHcdrAUWpnp5WI0Oi29WPuCHJvQabFWH2gaSdmjcwRzOBqDoDwA
 f79l8vOpL0NZ01XxuoxWAAcM22raufezl9Vq8.se3dTtLOSFE2a42RxPgujjkjGNIlcHXnL5NHI1
 Ma.I-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 344b7760-5a64-47ef-87c3-206a96daf745
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.ne1.yahoo.com with HTTP; Tue, 7 Nov 2023 17:35:07 +0000
Received: by hermes--production-ne1-56df75844-8pvmk (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID b78d98002319548338914a54a3113a74;
          Tue, 07 Nov 2023 17:35:03 +0000 (UTC)
Message-ID: <a9438d45-7fc6-4a5f-899e-4551f0f672d6@schaufler-ca.com>
Date: Tue, 7 Nov 2023 09:35:02 -0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 12/23] security: Introduce file_post_open hook
Content-Language: en-US
To: Roberto Sassu <roberto.sassu@huaweicloud.com>, viro@zeniv.linux.org.uk,
 brauner@kernel.org, chuck.lever@oracle.com, jlayton@kernel.org,
 neilb@suse.de, kolga@netapp.com, Dai.Ngo@oracle.com, tom@talpey.com,
 paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
 zohar@linux.ibm.com, dmitry.kasatkin@gmail.com, dhowells@redhat.com,
 jarkko@kernel.org, stephen.smalley.work@gmail.com, eparis@parisplace.org,
 mic@digikod.net
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nfs@vger.kernel.org, linux-security-module@vger.kernel.org,
 linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
 selinux@vger.kernel.org, Roberto Sassu <roberto.sassu@huawei.com>,
 Stefan Berger <stefanb@linux.ibm.com>,
 Casey Schaufler <casey@schaufler-ca.com>
References: <20231107134012.682009-1-roberto.sassu@huaweicloud.com>
 <20231107134012.682009-13-roberto.sassu@huaweicloud.com>
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20231107134012.682009-13-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.21896 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 11/7/2023 5:40 AM, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
>
> In preparation to move IMA and EVM to the LSM infrastructure, introduce the
> file_post_open hook. Also, export security_file_post_open() for NFS.
>
> Based on policy, IMA calculates the digest of the file content and
> extends the TPM with the digest, verifies the file's integrity based on
> the digest, and/or includes the file digest in the audit log.
>
> LSMs could similarly take action depending on the file content and the
> access mask requested with open().
>
> The new hook returns a value and can cause the open to be aborted.
>
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>

Acked-by: Casey Schaufler <casey@schaufler-ca.com>


> ---
>  fs/namei.c                    |  2 ++
>  fs/nfsd/vfs.c                 |  6 ++++++
>  include/linux/lsm_hook_defs.h |  1 +
>  include/linux/security.h      |  6 ++++++
>  security/security.c           | 17 +++++++++++++++++
>  5 files changed, 32 insertions(+)
>
> diff --git a/fs/namei.c b/fs/namei.c
> index 71c13b2990b4..fb93d3e13df6 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -3620,6 +3620,8 @@ static int do_open(struct nameidata *nd,
>  	error = may_open(idmap, &nd->path, acc_mode, open_flag);
>  	if (!error && !(file->f_mode & FMODE_OPENED))
>  		error = vfs_open(&nd->path, file);
> +	if (!error)
> +		error = security_file_post_open(file, op->acc_mode);
>  	if (!error)
>  		error = ima_file_check(file, op->acc_mode);
>  	if (!error && do_truncate)
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index fbbea7498f02..b0c3f07a8bba 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -877,6 +877,12 @@ __nfsd_open(struct svc_rqst *rqstp, struct svc_fh *fhp, umode_t type,
>  		goto out;
>  	}
>  
> +	host_err = security_file_post_open(file, may_flags);
> +	if (host_err) {
> +		fput(file);
> +		goto out;
> +	}
> +
>  	host_err = ima_file_check(file, may_flags);
>  	if (host_err) {
>  		fput(file);
> diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
> index 88452e45025c..4f6861fecacd 100644
> --- a/include/linux/lsm_hook_defs.h
> +++ b/include/linux/lsm_hook_defs.h
> @@ -189,6 +189,7 @@ LSM_HOOK(int, 0, file_send_sigiotask, struct task_struct *tsk,
>  	 struct fown_struct *fown, int sig)
>  LSM_HOOK(int, 0, file_receive, struct file *file)
>  LSM_HOOK(int, 0, file_open, struct file *file)
> +LSM_HOOK(int, 0, file_post_open, struct file *file, int mask)
>  LSM_HOOK(int, 0, file_truncate, struct file *file)
>  LSM_HOOK(int, 0, task_alloc, struct task_struct *task,
>  	 unsigned long clone_flags)
> diff --git a/include/linux/security.h b/include/linux/security.h
> index 922ea7709bae..c360458920b1 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -409,6 +409,7 @@ int security_file_send_sigiotask(struct task_struct *tsk,
>  				 struct fown_struct *fown, int sig);
>  int security_file_receive(struct file *file);
>  int security_file_open(struct file *file);
> +int security_file_post_open(struct file *file, int mask);
>  int security_file_truncate(struct file *file);
>  int security_task_alloc(struct task_struct *task, unsigned long clone_flags);
>  void security_task_free(struct task_struct *task);
> @@ -1065,6 +1066,11 @@ static inline int security_file_open(struct file *file)
>  	return 0;
>  }
>  
> +static inline int security_file_post_open(struct file *file, int mask)
> +{
> +	return 0;
> +}
> +
>  static inline int security_file_truncate(struct file *file)
>  {
>  	return 0;
> diff --git a/security/security.c b/security/security.c
> index 8aa6e9f316dd..fe6a160afc35 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -2954,6 +2954,23 @@ int security_file_open(struct file *file)
>  	return fsnotify_perm(file, MAY_OPEN);
>  }
>  
> +/**
> + * security_file_post_open() - Evaluate a file after it has been opened
> + * @file: the file
> + * @mask: access mask
> + *
> + * Evaluate an opened file and the access mask requested with open(). The hook
> + * is useful for LSMs that require the file content to be available in order to
> + * make decisions.
> + *
> + * Return: Returns 0 if permission is granted.
> + */
> +int security_file_post_open(struct file *file, int mask)
> +{
> +	return call_int_hook(file_post_open, 0, file, mask);
> +}
> +EXPORT_SYMBOL_GPL(security_file_post_open);
> +
>  /**
>   * security_file_truncate() - Check if truncating a file is allowed
>   * @file: file

