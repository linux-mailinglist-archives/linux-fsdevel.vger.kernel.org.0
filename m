Return-Path: <linux-fsdevel+bounces-2290-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B61A7E4764
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Nov 2023 18:45:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18A431C209E1
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Nov 2023 17:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B7D534CDB;
	Tue,  7 Nov 2023 17:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="MoMXgn/9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3304428E29
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Nov 2023 17:45:32 +0000 (UTC)
Received: from sonic302-28.consmr.mail.ne1.yahoo.com (sonic302-28.consmr.mail.ne1.yahoo.com [66.163.186.154])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E3EF170C
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Nov 2023 09:45:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1699379131; bh=NwU+RgVG8TKK4jDvSYrLBmaejPxFumVI0ipB6rLItm8=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=MoMXgn/9cHIj/8HgmWc39JZWg0keFe2hQJR7CmYj65PGIcGEellaeJxtb9NqdefUWIYtq+YhWJtqdBZ43QHK8KOZE0j1gdafe0nbaUmZXVaoYvGS7PsjbrdsElEKCr2hhal1F65UuBFliipqenDy8v/Tjp++qTQnjEc/MqPI/peZ4Pjp6zHheytA4+RIXONB5W9dJyHmDNX5YCjWUAzvo3tPx8eqDe/T9FnPUs1YE/uw+7bzSWQ+ym50VeAlwA9S6JOyKJgfW6H+LjA0f0bli18cgvkgs9W/cuDaHY0dzI8cWtPLJxEX+E5rXv3EjYDlMkcHXKhx2fO+Uoey25G78A==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1699379131; bh=V4p4hoo1U4EUhzDb7VxLUdaRGGoiBgIsgBN1l+wMu4R=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=Xtf4gmBXaWvc7aRXa1pddV/jJDw7z7XxJzf9Tm3AEGgXOyipCCGMNNWe7Ehi418dRjc+DDk+obBpTw3DQibImShdZ23HqJ0Koec65HO2iTgDUiYcIUBZABQoBRONOabEbqkcPGXI+FTiS5uCS4ewkaImpJC6u7uAzZ3LfBf7fj0BaOEAXEC+2bsZthAUVxoScn0qWDmuMBNvtYl5M2vTbvdLUk3qr/4S85W3mb1ODd5PabaIuJPHbfxrW+jWqdSsT0LuLTLCpPCsl0QMng250qSWCIpCmf9Xc3CuKUda2BlwbSHEIJDbxfccpbFlYsJhYcz8xooIcg6obOz0w9g3Gw==
X-YMail-OSG: 4uelLmwVM1nt1HAGqxoCmO359G7WFI9cx2sLJGdIw9D00PuE.cOXWJrEosXFCYe
 _DjoFjsrnwX7a5EFAURZslpA05von5myRRQfjKACXTsm6l_F7k7GP4sm8GEYFmtQA.HKQYDj7sjX
 _Wo03DlYaDIIGTi0TIE0spWNSXOmDI_oUtoNxm0JvB11b95R.cEHTuz8yho.wQjSt9fyGMkmmVZP
 bzE7v6h7SzBSVgQFuR9ILMz_pG.dk9wy54GZ4GnV48h6XqxSSmL.2xToZha8MHApi87pWxHVKUkm
 RZRVZjE4FYHcd4KMtfC26JIEu21i9UWkGNeOmmpEldMrCksLGkRPm2aTCIoe4FVd91cCm04noPas
 EV6VsY3d3_khjLwra0N_D0ojGBTjpYvXuro1EL7WbHBiVLMaPbiXiGA2oDqVygc3TgkaOYvc30JZ
 e0kZ1jh9Ce4LlFdHgn6kq6oD1QTJLBafl..QEFGxkdkvyDl2zKUwhkmFxoM_cpxvFEkdHBzUK6Dz
 iuCMDGekJOlGMMYrumUsDgkDQyv33ASzVnEiV4s8V8tlNUUZ9PxEFrdf0HVj_7zaWLf_4xS3U.F0
 XMXfVnZwNCkgGsqyfhs0bQywV1AhV36Fh4u5YGbCC92sR9mo3OkMlucPNu1XV2X9.9wtHSXrUz4O
 IKZBW5jy4u.Yg_M9MYyJk6i.LurTeecTHVi1BeM7uaxAE3a_Ljj.mR.T4wQDrhj3vVJJp7_YF307
 JlaKmFiPWN9SilmMKNqb9jQOPK7v9x2JX8_B5A9oVAUN8OyVrl9Py7vIFVaUTwWqFf63Z.YZVqhQ
 RM_8UuPWrA7pcaNY5ppGGIElm_o_93BwuO.6TglRzAO5IBEXkf.McOF4FRqJ4whBo7sCtxPQ2emV
 JmSi.eaaw8GwcwiHh6vsE4fnVbfurgd7io9vkRlVDqj6H0LfPMXCogri_aPeMNDiK8pgknLaobxH
 E6TswzEXxRZFcM7Lw_W6RdsPcfMrwaVhifJNErH_vsYfEmAY88IdqT9rq2ezQCt_mn7v4AWZCcZ1
 POfZh8E6ML_7AUVHxZlwPzUTd1HWkCFRwylmdaG3Z.eXA5a9iM1s3eca9.Z8hjWAvQAX1gEUIvOT
 _8ZpLLVp_ss0LaYdArn5viTyhvxCVOsXPNNpOhsA0olK5Fz0ManBJ9o5Ieweldf3xdoTJkaFwzo3
 81J2mDIrsCbC_qegBOHBKZh8wjoPwpMfrqsH2ZLfv0_9OLeJ0AcP26DIoFdvam41.z_ugvoToZIV
 CzWxQqBYD00FEsfonT_tbtQxwzRcIukvVSOGmCwdrwmKGra4_cjJgyF43r4Ssw92maFiRSboWK.W
 GaOQh9DMT1lFOLAZEygmklE5qyJP5d7M0LeuP0CarQ59Rcl_7nyZLdFftm.8fLrz5Ek8F1amEuSR
 S7I3yaMbNgGPPAe63WRCjoBorTwvaoPT4v5Upb_wf95mKiAQp9eLYuj0jYUQAFrB6wTgdVwM5KPV
 QwXNKp8XUK7TXpeiN1F3ti2sOtclEubmOsUvpi1ITqzgMZmpi75g0.CoAAz0VEk5h.MqvWnM3gs5
 TgZv1yySpK570VfugbsDRFV1dks8vLaNSAbUNZgqW4AO98PquQORlrc4To1hpqGTz7JulblaPiq3
 kxIyz0k4MDEROrYgqRpBW1WoFIpRm8s6iTcKKH4pQeXSZZ9WheWkhp_jOwWEn4AFKrEPp_DtCZyJ
 upUevLlypa_CIMi.Mh8vuPuT85uvA3YewFGkaD.GhjpKeiJjXuzOdVkq4VRqhJdWaljELv5q4.4P
 7jdHeSs9OdUGErxNZ5jEx2u9Jnw13_6wQFMe_6MQWNeO3Vc0p.b.M4P1fvFAblbD3REBUixuSSS7
 gOKL33I_j6UBqqAFXulsWnm6qGfrr4bGIuDZwlbEmlSHmRdS9jatXtZ67EEhVp2depWx6GliX6yH
 JahRD10ue0My2HHSDC3xa1je6zZ7_cyFgXKUqZbQXjBKh59GxX7_gwpl4Y4K6emOuRpNCumsFtRx
 6htGpv5NSuPnsKT32qGCHE_H178c9BbuRXr8JmgQLVZW8N_1J4bXeV.R_QAcVWNiqu.oEaQCpxx7
 GDsI5x14haJxEQzcRzvZM3MAbM4YjRP_7VxezCCujtaUaaimDUdZE9lhXvd9.EUYdoL8Cp92Jptu
 6dlQ_jmJvIHHhsQ4_JoalExsFoTEZOQUlxogKoLxwYZgVsxzFpLImN7Yycu2pguK7BJtS1i9bj.y
 cjPBbckePK2hy84Oi6P5KEHhaARS.ztTEf4Xn6GOfmyAAVnRyvKlBJZRerQKBnqeYUOdnJiK0kJP
 1JJbR
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 847fea1a-0c7c-4cf7-bb66-77cc3d5c55d5
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.ne1.yahoo.com with HTTP; Tue, 7 Nov 2023 17:45:31 +0000
Received: by hermes--production-ne1-56df75844-8rgn8 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID dfaa5d1dae8975599027f84a9858e3dc;
          Tue, 07 Nov 2023 17:45:25 +0000 (UTC)
Message-ID: <ee0773b4-74c2-425d-b4fb-db58688ebbfc@schaufler-ca.com>
Date: Tue, 7 Nov 2023 09:45:24 -0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 17/23] security: Introduce inode_post_remove_acl hook
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
 <20231107134012.682009-18-roberto.sassu@huaweicloud.com>
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20231107134012.682009-18-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.21896 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 11/7/2023 5:40 AM, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
>
> In preparation for moving IMA and EVM to the LSM infrastructure, introduce
> the inode_post_remove_acl hook.
>
> At inode_remove_acl hook, EVM verifies the file's existing HMAC value. At
> inode_post_remove_acl, EVM re-calculates the file's HMAC with the passed
> POSIX ACL removed and other file metadata.
>
> Other LSMs could similarly take some action after successful POSIX ACL
> removal.
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
>  include/linux/security.h      |  8 ++++++++
>  security/security.c           | 17 +++++++++++++++++
>  4 files changed, 28 insertions(+)
>
> diff --git a/fs/posix_acl.c b/fs/posix_acl.c
> index 58e3c1e2fbbc..e3fbe1a9f3f5 100644
> --- a/fs/posix_acl.c
> +++ b/fs/posix_acl.c
> @@ -1246,6 +1246,7 @@ int vfs_remove_acl(struct mnt_idmap *idmap, struct dentry *dentry,
>  		error = -EIO;
>  	if (!error) {
>  		fsnotify_xattr(dentry);
> +		security_inode_post_remove_acl(idmap, dentry, acl_name);
>  		evm_inode_post_remove_acl(idmap, dentry, acl_name);
>  	}
>  
> diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
> index 6a671616196f..2bf128f7cbae 100644
> --- a/include/linux/lsm_hook_defs.h
> +++ b/include/linux/lsm_hook_defs.h
> @@ -163,6 +163,8 @@ LSM_HOOK(int, 0, inode_get_acl, struct mnt_idmap *idmap,
>  	 struct dentry *dentry, const char *acl_name)
>  LSM_HOOK(int, 0, inode_remove_acl, struct mnt_idmap *idmap,
>  	 struct dentry *dentry, const char *acl_name)
> +LSM_HOOK(void, LSM_RET_VOID, inode_post_remove_acl, struct mnt_idmap *idmap,
> +	 struct dentry *dentry, const char *acl_name)
>  LSM_HOOK(int, 0, inode_need_killpriv, struct dentry *dentry)
>  LSM_HOOK(int, 0, inode_killpriv, struct mnt_idmap *idmap,
>  	 struct dentry *dentry)
> diff --git a/include/linux/security.h b/include/linux/security.h
> index d71d0b08e9fe..7cd7126f6545 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -378,6 +378,9 @@ int security_inode_get_acl(struct mnt_idmap *idmap,
>  			   struct dentry *dentry, const char *acl_name);
>  int security_inode_remove_acl(struct mnt_idmap *idmap,
>  			      struct dentry *dentry, const char *acl_name);
> +void security_inode_post_remove_acl(struct mnt_idmap *idmap,
> +				    struct dentry *dentry,
> +				    const char *acl_name);
>  void security_inode_post_setxattr(struct dentry *dentry, const char *name,
>  				  const void *value, size_t size, int flags);
>  int security_inode_getxattr(struct dentry *dentry, const char *name);
> @@ -934,6 +937,11 @@ static inline int security_inode_remove_acl(struct mnt_idmap *idmap,
>  	return 0;
>  }
>  
> +static inline void security_inode_post_remove_acl(struct mnt_idmap *idmap,
> +						  struct dentry *dentry,
> +						  const char *acl_name)
> +{ }
> +
>  static inline void security_inode_post_setxattr(struct dentry *dentry,
>  		const char *name, const void *value, size_t size, int flags)
>  { }
> diff --git a/security/security.c b/security/security.c
> index d2dbea54a63a..6eb7c9cff1e5 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -2413,6 +2413,23 @@ int security_inode_remove_acl(struct mnt_idmap *idmap,
>  	return evm_inode_remove_acl(idmap, dentry, acl_name);
>  }
>  
> +/**
> + * security_inode_post_remove_acl() - Update inode security after rm posix acls
> + * @idmap: idmap of the mount
> + * @dentry: file
> + * @acl_name: acl name
> + *
> + * Update inode security data after successfully removing posix acls on
> + * @dentry in @idmap. The posix acls are identified by @acl_name.
> + */
> +void security_inode_post_remove_acl(struct mnt_idmap *idmap,
> +				    struct dentry *dentry, const char *acl_name)
> +{
> +	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
> +		return;
> +	call_void_hook(inode_post_remove_acl, idmap, dentry, acl_name);
> +}
> +
>  /**
>   * security_inode_post_setxattr() - Update the inode after a setxattr operation
>   * @dentry: file

