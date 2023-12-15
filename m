Return-Path: <linux-fsdevel+bounces-6238-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D1C9815201
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Dec 2023 22:41:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49C651C20BDD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Dec 2023 21:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AB85495C9;
	Fri, 15 Dec 2023 21:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="soRwR4Tb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sonic302-28.consmr.mail.ne1.yahoo.com (sonic302-28.consmr.mail.ne1.yahoo.com [66.163.186.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 595AA47F66
	for <linux-fsdevel@vger.kernel.org>; Fri, 15 Dec 2023 21:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1702676482; bh=1/ESIGcwLpGZVC5X2wR8bKtmXxMiwhmiGVSgfbFIMjc=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=soRwR4TbKW8qq83crBGFNFJZk6JSk1p1EdsjVI1AeVIJYjA3gcWB9/S7oG/To78oxR0y+zL7gI0ZWDZQERShJXik4REovFJwIrczmGi7rPxKLNINdQzVWJazFJjxhgh7SlJiiNk8mWFVvtOMC0yjhX++cA8PEYNlNfG1B6BQK7l/rG5Gz53sVZDCCvgTy969pejXNOqsJYt80GMLZsN1ZaO2CTA/vrGyZVwU0+zDoL4TmOzsWT+zAi/GIGX8k7Ln44kGOSvIVxxwYkbuL2j4ZVuLii/6GACWpouikQiZbcj7fB+t4Vwqpl0NOtTEgREadZw6UlRvQqLHi8wrtWvNpA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1702676482; bh=/n9PtqtMnVFYCeiPLx4nqLz+xzIBClbzNXAThbF5kn/=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=gXXYbMKSwsGUHS16vuvaQ/f83CwJk/ih/IQdNhWIqBphiIIhwOathhJ4spJ8N0OrqhBVvpCQKL73pOFyYD57M+T12BSiJOHAxTgXeNgRWiS0DS4xqvKlS7sLUXbaDNTN+SDzHZWoKLY6Mrd2fhVkTZezyk2X8MQpxHJjGR25YOtwsebj0/fxRieGdBc5KoTMXvobwHgLc3UVqSqhFyuS27fcI8wcVnaBre9EmrulitCA2iv89VeeokASSsyuNJ0m6jBVHMp3yQi7NYDjedsJIyzVlQiYvlJZ3E6yp/onsn0u079WE9Wer0CT4yc5L/tTgL9deZ1nXPT+gf8wmC209g==
X-YMail-OSG: D7Z.78wVM1kMAAl.AP4Ohbxq7pxxE2vCTH.TTDoOTWhJXFzHiIW8fzXM6EpjUZo
 H.Qr5dkmyEbmJL_lUjot9ivQl.FrTVUsdw3OPT4fvkUX7fqyKRD2rOgG7CmvSRoTJRwc5sQ78iWR
 nEVNGNzLp0hIv.O8VJXdhKPdSCdXF507Minl0Bx5jKXQrghr8vQNWlSWchWJ20jPVDkW6DKJyhBp
 4j9PiD_LJg9pqiY6TJLfLuwze6yxr2aH5X4JFLEfBShu_zyt4he6cb10DkENactrDlohkRCqnbIa
 ubJB6B6DacYgyqHMx._dO8hlMLKNz27t4QIGwx4v8.YK1gVZfXBaCDKxHvK.e36Zv9dfY4lrUxdG
 dHi8A1Th8oG6e4FKsfb7Qplnz13twPw7SsCP1jeiITHq60pJ.6Q5wePB.aYd5xxVYAhK6hRH0xXX
 17CySSdkeKqZZnocIVXaOY7UTMniRVuJKKCnzk7wKbB9_ryacVu1GzjpOX3DITelqOilnrU3XwZK
 uS3vsJpT1Mw2TE.RL2TdDV8EMSGUYWTBU1w3D3pVkrcfE88ecykkNLeom3F0SMCLO9uxny3kltb9
 w40zzhzclF.E9GolNWLGsN.XYtMbSa3G8xo0JDrDXP9Nyk1ZkjpPlvydOsdiBRZwk275Gh9xf_MX
 mzHzKy3YN5.0THByKKGqbZwfcbM03iDlxNUb26bbpZrcBJLLrjhJVDLOPcGOWMwS0oeFkmN9islb
 RyctHdCv1Pw.MG_f6yXZvt.C_uKODSLGS5V7EyhkeZGlgQCTdhZasGu.RInvnifDqPKRBBelxFw0
 Ne1IBjLG_D5FOPYAg3HT6CVICTiOHsxbM0c5RsLr2T4i76AQZeP01D3tKk1KXqVhlxs04ptdHOmI
 cZo4LOREk3zGmja5OEoeUVjpsqEnqrkZzamj0sWVE8wOsCL.4BJCRIahtgMu.xSUOlgcmBmWuMc4
 lGvPSqJ.xAqux73Ua0JqzI5_.oe_DdkpLfC0CSNOf.0of4trOLGJqj7zUgZSZMVN9hAh28THgn.7
 b3o4Yjim_lmXkIrLsOgHFFqKnq16HdmOhAW4N9t7ZesYCIOjk6Qc0VFg77i7IQtw2UsbjBDIcuTj
 NVwAf84qHQPKzsG1Uifz7ZAXNMR1RqUo92JUnEznBcHKnCd1t1gayQtVLJsOUoQDT3P0I4.AMhQU
 WYvSQY3018_Q3FBtUVq3zGeItDQ2eRrmbETeK3inIedg8pMSoPLuzWawakO0wUII0D1yeMaDp2Gm
 9RHgjBx6eBfe9ZwLs4jDwASiaHDlEAeUws6ZvmNIrlZGZpKDnBJCPclS_SI4_QZDCJmhFny.DdHr
 Y17AjBXTENldZbUp2vnqMh3w.6RusPC.rSwYxHDAk4eyA51JBpmAdefxd1lE5gBbSDAXaxXd2zNY
 WdEmOP.0c5m7YFxevi9SZksgaPUyo3.v1cd6lnhTyoQnrQWwyqA7iEwEtxSXHe3b_2XNxCqzcc5h
 WBJW0lR884XO8T8_e9Nhz4DIDkXxfaddG1rRUJh1XW7JpF9tJCYSbnpfBzn_B1wqUuDHigZYaVjx
 DfJia2SqAJuiY95XNznRbsPm0Kawct6H8xznHLR8Qa64SQTQlE_glAv9dmdEwP1ZPOksg6_xGALE
 izmuf.TNE41D7tUlZbHTlB2W2lLrzbN92tKXuH0HYAq44GlEq02JodJlsKl1GrwgM3aKJKKN3BHp
 Jz4pWRBpel6uyawoxJOwziScfcm2xIh_fSgM4iLxfz0OL_CS5QGeuQfYT0dMFHkwlkBhJXJ5iC9r
 kAa_9Y_nVJcqbkTfVNEwVfmNbEW5FDU157e2qaLLFFDF3hbO9TJAylO2Ecg.MXnHmcS4cS57l1Wy
 fxd9Vn0eIEfIXtae8YxVfcpq7u7V7blM2DdTREYTNd86Wuddqy7Xe7jOl9hp6PbQRM3EUyBRuDQD
 PCe1ivtejt5hja4IXWtI06NtOIH0vAG4_6ycAHILQHYOFZKC8pueA_som9PWxssj0eQKojWkphL1
 1vOLQuVl7G3AybsTXIjzXgc6sTitnb9_uExmEDN4QeAJkcAPZGWT3PNNDffArE.H76MX_kjHWILg
 5VI.aWlXFOa.B4Oh.OfpkxzQYWoWE2D35lyNLxlwiuTpUzhWdjoeJGlQp5ClkVltl3nF2oULUXsO
 FH4gLZXciyREFnl30wnSS94u6w0ZBVKaGNETz9Utpenp0JGVwdklafQokOmRf0gr4s8y9Ocv9vEh
 qOiNRPtHRWRmRsjtR6yFWmeyMfEChE3Ho5Q2PMWHC
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: e79f5337-3e62-4527-b030-e0a3b0d998cd
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.ne1.yahoo.com with HTTP; Fri, 15 Dec 2023 21:41:22 +0000
Received: by hermes--production-gq1-6949d6d8f9-bvfr7 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID fe5a77b47a76a7cd1cc4bf39259b4cdf;
          Fri, 15 Dec 2023 21:41:19 +0000 (UTC)
Message-ID: <a9a4f233-4867-41a1-8c1d-11d20226c491@schaufler-ca.com>
Date: Fri, 15 Dec 2023 13:41:18 -0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 13/24] security: Introduce file_release hook
Content-Language: en-US
To: Roberto Sassu <roberto.sassu@huaweicloud.com>, viro@zeniv.linux.org.uk,
 brauner@kernel.org, chuck.lever@oracle.com, jlayton@kernel.org,
 neilb@suse.de, kolga@netapp.com, Dai.Ngo@oracle.com, tom@talpey.com,
 paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
 zohar@linux.ibm.com, dmitry.kasatkin@gmail.com, dhowells@redhat.com,
 jarkko@kernel.org, stephen.smalley.work@gmail.com, eparis@parisplace.org,
 shuah@kernel.org, mic@digikod.net
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nfs@vger.kernel.org, linux-security-module@vger.kernel.org,
 linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
 selinux@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Roberto Sassu <roberto.sassu@huawei.com>,
 Casey Schaufler <casey@schaufler-ca.com>
References: <20231214170834.3324559-1-roberto.sassu@huaweicloud.com>
 <20231214170834.3324559-14-roberto.sassu@huaweicloud.com>
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20231214170834.3324559-14-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.21952 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 12/14/2023 9:08 AM, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
>
> In preparation for moving IMA and EVM to the LSM infrastructure, introduce
> the file_release hook.
>
> IMA calculates at file close the new digest of the file content and writes
> it to security.ima, so that appraisal at next file access succeeds.
>
> LSMs could also take some action before the last reference of a file is
> released.

You could make this more convincing with an example. Perhaps:

An LSM could implement an exclusive access scheme for files,
only allowing access to files that have no references.


>
> The new hook cannot return an error and cannot cause the operation to be
> reverted.
>
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> ---
>  fs/file_table.c               |  1 +
>  include/linux/lsm_hook_defs.h |  1 +
>  include/linux/security.h      |  4 ++++
>  security/security.c           | 11 +++++++++++
>  4 files changed, 17 insertions(+)
>
> diff --git a/fs/file_table.c b/fs/file_table.c
> index de4a2915bfd4..c72dc75f2bd3 100644
> --- a/fs/file_table.c
> +++ b/fs/file_table.c
> @@ -385,6 +385,7 @@ static void __fput(struct file *file)
>  	eventpoll_release(file);
>  	locks_remove_file(file);
>  
> +	security_file_release(file);
>  	ima_file_free(file);
>  	if (unlikely(file->f_flags & FASYNC)) {
>  		if (file->f_op->fasync)
> diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
> index e2b45fee94e2..175ca00a6b1d 100644
> --- a/include/linux/lsm_hook_defs.h
> +++ b/include/linux/lsm_hook_defs.h
> @@ -173,6 +173,7 @@ LSM_HOOK(int, 0, kernfs_init_security, struct kernfs_node *kn_dir,
>  	 struct kernfs_node *kn)
>  LSM_HOOK(int, 0, file_permission, struct file *file, int mask)
>  LSM_HOOK(int, 0, file_alloc_security, struct file *file)
> +LSM_HOOK(void, LSM_RET_VOID, file_release, struct file *file)
>  LSM_HOOK(void, LSM_RET_VOID, file_free_security, struct file *file)
>  LSM_HOOK(int, 0, file_ioctl, struct file *file, unsigned int cmd,
>  	 unsigned long arg)
> diff --git a/include/linux/security.h b/include/linux/security.h
> index c360458920b1..4c3585e3dcb4 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -395,6 +395,7 @@ int security_kernfs_init_security(struct kernfs_node *kn_dir,
>  				  struct kernfs_node *kn);
>  int security_file_permission(struct file *file, int mask);
>  int security_file_alloc(struct file *file);
> +void security_file_release(struct file *file);
>  void security_file_free(struct file *file);
>  int security_file_ioctl(struct file *file, unsigned int cmd, unsigned long arg);
>  int security_mmap_file(struct file *file, unsigned long prot,
> @@ -1006,6 +1007,9 @@ static inline int security_file_alloc(struct file *file)
>  	return 0;
>  }
>  
> +static inline void security_file_release(struct file *file)
> +{ }
> +
>  static inline void security_file_free(struct file *file)
>  { }
>  
> diff --git a/security/security.c b/security/security.c
> index fe6a160afc35..9aa072ca5a19 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -2724,6 +2724,17 @@ int security_file_alloc(struct file *file)
>  	return rc;
>  }
>  
> +/**
> + * security_file_release() - Perform actions before releasing the file ref
> + * @file: the file
> + *
> + * Perform actions before releasing the last reference to a file.
> + */
> +void security_file_release(struct file *file)
> +{
> +	call_void_hook(file_release, file);
> +}
> +
>  /**
>   * security_file_free() - Free a file's LSM blob
>   * @file: the file

