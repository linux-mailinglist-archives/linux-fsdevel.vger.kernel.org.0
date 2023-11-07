Return-Path: <linux-fsdevel+bounces-2289-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7000D7E4755
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Nov 2023 18:44:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1B95B20E75
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Nov 2023 17:44:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B329034CE3;
	Tue,  7 Nov 2023 17:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="THR5iFRX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89918347D2
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Nov 2023 17:44:34 +0000 (UTC)
Received: from sonic315-26.consmr.mail.ne1.yahoo.com (sonic315-26.consmr.mail.ne1.yahoo.com [66.163.190.152])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B2C2127
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Nov 2023 09:44:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1699379073; bh=XF2ovENoZ8vNbd9qkhvLyPZ2t/6ZyhhnDWXt7qkdMQ4=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=THR5iFRXTEZI8O8dCqFKS7YaO+5naVE/U0iTVMtzboHAdVkp+jlYBYQrKJ7EIXeMemExdT9W1XgBmF3xOSDQ3hirMwJmSct6ksb8q/gHhWs/neT9aQPGv7iOC4NWR6Aulw60LM7vaDbTXwukslWXcMPM0u9cs9lLR2lLF4bfAj1NJBW6fVHuNAdOzewFCIgvC27ltqrtVwj2ocgxE22NN53D2osjprvSI1T0AyDfY7rHVzgrJhT+IA2fiGvtdhKntV5wKupeUymAMOCA0Z+QleZW9+EL6x2gMTP0s0RVklfBNbss/dhAOMzJrylu7BHW4xHi9ZMcKy7efsUSEmKjLg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1699379073; bh=cs3lkR/z7keknqtQXjCrFkvejZ22GE3kwf+cUotD3PD=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=jQQcxZSk+i2FiGR9Bc/VrzqjdN9QrNTraSRfi9pXZRsr03gdLwuYBSCH0PWSRULBxn/76IJDwGzh+VbGi0L5rpgE57nLGbN9Xh+eJkvBiD85evNoT88fhk4x2Fl9lqfXnoSAmL6nATiqigw/Gcz+J5kfiFOMrjWgpKOGJnqK0GHSytx5WOP/Y14S6Oah7h58T1po3rSXTMGnxwTt226+yttL8SgJZwzXZ99TIiCSddeCFpOxxNylSp6OMdx+1R8oCHTEbjQb7sKdkjRHhzEnIKWHzzlT/oHJzqilr4mhN9NkwsNAMiszS0zv07YS/pTRgc0Vb25+ca8KGJpzuebB2g==
X-YMail-OSG: tFj432YVM1m45.xfiwenDa0xr.N4JZUQ6dgHPvkGTaQ.Kp2BzCMhA4e_oYzS5Re
 rnPMZ46wRKHzDT70rq.kmwK6Ljpgwxeajp8efucVXAcs17pmpCgfutm6fxygh3Q7vy7Azsp6qrT_
 Ob65fuX9D0IbEOlMcsSB55yTqvkdsWD0IVYiP17cqMZiz9.JaID1hkMbdoE9fH95pkAoUwkbYdou
 bos1EAQa4ftOA5ymXM_CPDQ8hwmRnXpSEJYZjcwF_vB.jLs5sV5rgQMM7ORKG_ku1b3g38rceqvV
 4YDc9D.de4TsKyF5pzmZEo97BuZp56MGB21_HgMlIbLskDNIxWdfkoDl.wTI5nO4XfXrd9.FkJmf
 nQt_DAyB7kbywq6WAjwvHEiP4fA1Sh8qcNiR4Rf2F7CNIYyPYSml.AehIDoEBJ1bIGgA6Z.bHK0J
 xBxpV0D4JaCo9BQlSMneA03HIReXvk6A10YN8zZlszh3vltNEEyBLWQeCt3VPQkdw07vAKhQzrcV
 yY.U21b5SmjzQ9MvxWxHQ4mwToWT99fbJ7jT6Cb_RQ3kV6_xyoOTT4XFJxzpIEzNyjM5q2G5fiFm
 492eKAK8HQYOXssNCymkgjFdovKaLIPB7cVAzLS7_OyLvEuyn1Wh.r9v8NBMWBc0gsCq5wzDHroR
 _HkA0uSD4h14O8nUtN24lNehFc070oj7Hh9DB.CEg.3GnyV2r1AbaYtFQSeNYE58guNzzHgtnpX0
 dzB8S1uBp.4sJ_VM7gZtTmKPUrUJ4MofwyZIch3YvLRZm5FttdIguQkVt.BjI9YZHKR6oNbkYcap
 dbe8vcEri.Kd0nb_EsBDpflAUxnjxv4QdeIy5IxEak0x9saDrFu5ki.wt3LQ_kgNitKRNHIa8Mcc
 sYuDLP42sZpU0BbGGv3e23dWqyzy6vULB0vD0VOPaIn9a4RWOWURU7gToJJN9n1rMe2cODVASCZf
 .BtFW1JlFKdxCRcLjRiA.DnqLLym_cLNUDS6VyWSd.soD5BazxfDlMU7GWE61WGr1Gs4qUSobnMr
 e1LqCDVYrw115XliB9Gj8Y7EHsYFANc6xV6yWvf2Sf2aoCSoLeSuYOPauvGWehhizIxFEn64yFIH
 OtEdVaeBHTHDdHxqUw4U3l5RzRfXP8ofCnZoXOZxaSsE6TzHt6D5kZn8xMtps_AsMbMd2Qo1aO80
 qKWFfHMk5urdHaW8r79stcpARtId17jDS7RdfcyN7ZmBaVe1O0rEbTZPMstYFXDwIkiHTViDs_UB
 DIQFAOK9KRzch2.3hrvK2bAr8zApqIaMQTWrglBqYy3XTOzaDBw0KjpqYp6lkXY0vFcYrve5O5LI
 i6KCsmafQtkln.os6Uj28OrMYPFKS98nyBjx8vxkZ5LNYw8ssZ9oO7.U.AuZ48XhNt5P6p81hPe_
 QJNKOuj4MhNo9VXMPJYGEdNm1wUuyR.ymbgteGK0faE1oUjxFD1cOQsBCTeczojEzvALhrAYeOmo
 2uKEGdbrJPEnc0Pjip67U5qnP.XWPO416D_bx9qt82p5MR6A5kEZcaEi3..kaTIoJiNZGLZVXmc3
 PmmCvRsT0lDENaYcWYc3AyAK9SdnCHOoVMGDYdZbK6kL7Hi_dnQM21aIusRUE6ISd3HRHbE4anBF
 26IzkRCAiv5W79OmsWY0t4UF6rawK6VzOsz1DXeJc0AyGPoB.UWzl6.3IRIB56eN5ogvambCCekk
 RHcgd36U0z_OmvtCsFEkIc8NEFWkEB6V9LmvQ6m4IFFm829ri6jaylIXV0IdAo6mCInwS.rJ4JOl
 HTKFcjg.MYgbEiO71ezCQcl1sRtQf6DMcOUnBDcfosw1PpXfR0AfLtK0AJFyQWFEUXzTbcMxZMB.
 y6JCW5fcV6Ygz9xs_0B4jXIAyaH5fdLG.LgTPNnhJ4fCaG6HB3cYvKLvaIIaG2hOzS0dLKHUUG_d
 _uij8k81SfOZMUNZQqcTwO._2EmtnAx1fT2pFqoT02jS5HxJccAMvLsFDRWjIRSpQiwhxVjQqI4T
 iArI1YZ.3xwc5mhexCJ0v1vjXoETUIMb34g_WYkhUs7Lpzt4C7oqXCiueDfo1EUu97navFkY4jZy
 KqZHtAnGc4rp5TkBb2o4yv4HC9FhYiyd_iVUOddWPzplrfNzCq4SpOSKklX8KhkBY8oQMdGtkKnJ
 cj8YXJAmuK5GJOBOC8z1OOH5lR6mel2._4TsHw2kid7yxWQp1MBrDjKHILoworfp.t6ceR71JZND
 ._BxKCga_MrvW2UtygwXwmWL4V_sVKaGZAT.VZA1BPN0WXPFzooGQIKHD5oA0wqW0pBR42xAkzlP
 u2TOQ
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 572f91dd-df15-4933-874c-d6127a7275e0
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.ne1.yahoo.com with HTTP; Tue, 7 Nov 2023 17:44:33 +0000
Received: by hermes--production-ne1-56df75844-jh4w4 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 75cf044ccb9b85620acbca5fc76be827;
          Tue, 07 Nov 2023 17:44:28 +0000 (UTC)
Message-ID: <be5c8855-c44c-4406-971c-2505a3fa0226@schaufler-ca.com>
Date: Tue, 7 Nov 2023 09:44:27 -0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 16/23] security: Introduce inode_post_set_acl hook
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
 <20231107134012.682009-17-roberto.sassu@huaweicloud.com>
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20231107134012.682009-17-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.21896 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 11/7/2023 5:40 AM, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
>
> In preparation for moving IMA and EVM to the LSM infrastructure, introduce
> the inode_post_set_acl hook.
>
> At inode_set_acl hook, EVM verifies the file's existing HMAC value. At
> inode_post_set_acl, EVM re-calculates the file's HMAC based on the modified
> POSIX ACL and other file metadata.
>
> Other LSMs could similarly take some action after successful POSIX ACL
> change.
>
> The new hook cannot return an error and cannot cause the operation to be
> reverted.
>
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>

Acked-by: Casey Schaufler <casey@schaufler-ca.com>


> ---
>  fs/posix_acl.c                |  1 +
>  include/linux/lsm_hook_defs.h |  2 ++
>  include/linux/security.h      |  7 +++++++
>  security/security.c           | 17 +++++++++++++++++
>  4 files changed, 27 insertions(+)
>
> diff --git a/fs/posix_acl.c b/fs/posix_acl.c
> index a05fe94970ce..58e3c1e2fbbc 100644
> --- a/fs/posix_acl.c
> +++ b/fs/posix_acl.c
> @@ -1137,6 +1137,7 @@ int vfs_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
>  		error = -EIO;
>  	if (!error) {
>  		fsnotify_xattr(dentry);
> +		security_inode_post_set_acl(dentry, acl_name, kacl);
>  		evm_inode_post_set_acl(dentry, acl_name, kacl);
>  	}
>  
> diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
> index ec5319ec2e85..6a671616196f 100644
> --- a/include/linux/lsm_hook_defs.h
> +++ b/include/linux/lsm_hook_defs.h
> @@ -157,6 +157,8 @@ LSM_HOOK(void, LSM_RET_VOID, inode_post_removexattr, struct dentry *dentry,
>  	 const char *name)
>  LSM_HOOK(int, 0, inode_set_acl, struct mnt_idmap *idmap,
>  	 struct dentry *dentry, const char *acl_name, struct posix_acl *kacl)
> +LSM_HOOK(void, LSM_RET_VOID, inode_post_set_acl, struct dentry *dentry,
> +	 const char *acl_name, struct posix_acl *kacl)
>  LSM_HOOK(int, 0, inode_get_acl, struct mnt_idmap *idmap,
>  	 struct dentry *dentry, const char *acl_name)
>  LSM_HOOK(int, 0, inode_remove_acl, struct mnt_idmap *idmap,
> diff --git a/include/linux/security.h b/include/linux/security.h
> index 0c85f0337a9e..d71d0b08e9fe 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -372,6 +372,8 @@ int security_inode_setxattr(struct mnt_idmap *idmap,
>  int security_inode_set_acl(struct mnt_idmap *idmap,
>  			   struct dentry *dentry, const char *acl_name,
>  			   struct posix_acl *kacl);
> +void security_inode_post_set_acl(struct dentry *dentry, const char *acl_name,
> +				 struct posix_acl *kacl);
>  int security_inode_get_acl(struct mnt_idmap *idmap,
>  			   struct dentry *dentry, const char *acl_name);
>  int security_inode_remove_acl(struct mnt_idmap *idmap,
> @@ -913,6 +915,11 @@ static inline int security_inode_set_acl(struct mnt_idmap *idmap,
>  	return 0;
>  }
>  
> +static inline void security_inode_post_set_acl(struct dentry *dentry,
> +					       const char *acl_name,
> +					       struct posix_acl *kacl)
> +{ }
> +
>  static inline int security_inode_get_acl(struct mnt_idmap *idmap,
>  					 struct dentry *dentry,
>  					 const char *acl_name)
> diff --git a/security/security.c b/security/security.c
> index ca650c285fd9..d2dbea54a63a 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -2350,6 +2350,23 @@ int security_inode_set_acl(struct mnt_idmap *idmap,
>  	return evm_inode_set_acl(idmap, dentry, acl_name, kacl);
>  }
>  
> +/**
> + * security_inode_post_set_acl() - Update inode security from posix acls set
> + * @dentry: file
> + * @acl_name: acl name
> + * @kacl: acl struct
> + *
> + * Update inode security data after successfully setting posix acls on @dentry.
> + * The posix acls in @kacl are identified by @acl_name.
> + */
> +void security_inode_post_set_acl(struct dentry *dentry, const char *acl_name,
> +				 struct posix_acl *kacl)
> +{
> +	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
> +		return;
> +	call_void_hook(inode_post_set_acl, dentry, acl_name, kacl);
> +}
> +
>  /**
>   * security_inode_get_acl() - Check if reading posix acls is allowed
>   * @idmap: idmap of the mount

