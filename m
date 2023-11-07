Return-Path: <linux-fsdevel+bounces-2288-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F17007E474A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Nov 2023 18:43:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55B42B20E5B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Nov 2023 17:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D412734CCE;
	Tue,  7 Nov 2023 17:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="QjWQ7y90"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FCE130CFD
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Nov 2023 17:42:57 +0000 (UTC)
Received: from sonic316-26.consmr.mail.ne1.yahoo.com (sonic316-26.consmr.mail.ne1.yahoo.com [66.163.187.152])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCF23125
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Nov 2023 09:42:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1699378976; bh=1WaphqM6rO8w22f3mnZlJ7Yzb5LYbRVzb9tBA8f2rxs=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=QjWQ7y90JIu5hWfazHfSdopQP4nPKfBe7DYbrvZFPvo1gKyRRhG4wGeUQsgDOlMA6yG9Cx/POj+W5wf9Z2o0KLJeGu8+j7WAGbMwYlVhhZWr0qyN0etESj4MKrocTHZBNkPMWo50EA2n/rAwE9lrN0SVyaqOZ9Ei8mr1AC0As79JU+xIBdvxId44COh+G4Kzlb9jLHTJzN54LYilqY3sbCfEhn53WBFNOiD7zkcsOn1HjkjnpzqiFbtCclLacMqcA0hvI3ZS5E8W/dC3+z6iq6dvF0wsoR4oHY/sw0FFz4Q4YMYuu19psCh670LEP7x4mmdBbk/1VqHKzSMYdCMyow==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1699378976; bh=2gKGoJG6Ol7BuUtrUrDlirDOX0t23jGNdOjgsAIiDy/=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=QiIugrN3sZgxZfYHmAGYC5T5ScexMBEQ1P9QRh3O4XYJ4H29KKEPbMUnbFHj0ujGcQWwG8EmgHzEDGWxz9A1XGEtDwMfc2fmXHR2JX68ZcOeI/mvcys9dmI105fNHjTKnDCaSs1ACrcI21eXQqA3jRm6xJKEUTeE2jypu8UTRmacDcfUVfJh08paf8ZNSxS4NFeq3/XzVL6R4cWuB/dz3+v2IHqysNjdWQ9ARtjYC2bjmfLJqWnuuHDb12fbLCdu35HVZ17k+2fnStyj6Q16UbJwS46a3JdmVYW/QMA/A2UhWv5bBxc0eTCnJi6kjQLhgHPSgk0CujlAHBHWe0sOPA==
X-YMail-OSG: ay5RuRoVM1l76IuLNTd2CDX4gEL_r5AgTIex.99BbhA0PwkIctrrjbskBifUQ1Q
 Yb5o.cTtyjtYhJ1z0erjdhd0MddEwsXvv6N9frhL5nmc6ZfuQ2FExuOfxj.8TKC1Jr9PPNyxxfcP
 jjAj5c4q5j2So9b.3V3YzZRilZvoXefVKCBQvahVFR6hhGhugfX06olYD1LvpF61ZggJVqZfo0Si
 gW2J0e9WKe3IDlFkDGJxC_ZWefuOHG_7TqCg3LEyRoNOykEBmDYLYnh0iW6hTRHBu2317u6._UqJ
 932qS65zxWsONtJIeNU45P4OffY4u2HC6v5007Zzp1MNaJzVN5sHGqokKfpD85U6pizcOAfDCdJx
 AyOwZvQe0a.1kgryOaSTDC9B64oatAP68BrsT47cqxT0xc57OpQJD.qFHyYh0OigTiu7Az7_L8Cz
 oehvrRv.WcK43qigpg2f0f6DwfuCBrbz1qQVTKJCiYX8KzYKxL26IduShRKyBLV8eb7d1dIqb_pa
 jl..fsCXFAAupkuwPsZgnCmOcUhxFy6cpOXU1OgoP_kGGVSexNJLqyffpi9.KwjPaSLh4B17b0By
 NYUVdmneP5pEllXoQE2AlhTCaK_naqlDE2IcYqa5G13MeoC09XZL_wDHxE_jxaPPGU4aUvW42TNm
 Nv2MxSXPLfX78o9gCWSWcnAGDurftpKSkd_.sG7G7b5hBnkUeAumn1ZB2vLeLH6dqKiiq74LNPjg
 7w.lmKfozFdBGUjO_R7laAjVajzTrzeSqB9BWXyPWnd00a5Cl51Pp2Hjw6gvX0yopbWy4dk22NvT
 YM4RSMBrcfC5fuNnRWxYS7X7X1dkALJ_p34crXr.1TnXuch1bdj6pR5bwWE91sR6Etx8LTpV0sBN
 ohg7msQkOayra22Af7SiT_ceD0c6jpaZMaiGTEw2x2XeaZsdmdAq6yO4iWUuHLCIgSsVv2_XrZFT
 aAKB05dx8L_LzPS1aoLMXnpwl2Mjxq6JiBwPs4Mw5Z4sCQrzQSqrUOLGMwkQ1vneGHDyHVzFaOBg
 jmE0rmMd3mGI6ZCMHSJlP1L9vI5cDFwmMpp1U4BJQlAm64bZ8hAVqZR8I7dQasaqngyB.F1byTO9
 dpZH3hJ0ohXN.VJFH9g20yzWing_7OfF5gi0wCShiKgMPUI2rs7iySMITsFYVuw40Z9urptT.0SF
 CTtMjT_8fWgxDl9BvkwWNbZ6u.buUYdGFa.XM4Iopc5MCkCIP47hKD_3KRr4Of8ThZTh_Swpn4OY
 tZtusvshud088_WtmM_2tdHElnMdtnNrKt56OxDE.Jn_dNQ9OZ.9zX0RxPSK_G6tj2ca29QqBBH_
 z2Nmi2KihK8RTkKCaTSNbrnx0wJy.5IagP4KUsckVoV2jkLD9PmYfP56OjInCv7uBtNLaXVsOq1w
 UUlOn3bhVRVpm7W9GWDU7v2GUNh8mTYt2He1cd3KNt33cmb1qKuajNkFGSE8AgpU164l70cC3KwV
 cStfYOdTJuIhM9AIfR8JiL8OwKWZdCTlN15vwX99eIqL8LkEF98Weyz4zPhtpq3.wRh8ldwEHMOC
 txIZ5wPIjb53e5ZqPaLOh94tbIJTbv4EPj8tIIvlNImwUHXiUcn8B7If5Mr3Ai5x6Fw4R0eUNbq7
 w601mgrUUgAcuhorYpQDvJIrlfam9gFaQ2nQLGzymzJNSj1_cI_fXCMcUtpe772Vg1FY7lQqba_T
 UbVBq4tfvDxqSHPCpmDMDRMLh7C.VjBKSsDcYCxIfQdEW2ZUzN1FYZg401egSCqGz_3uTPnrk4dW
 42whGoCZGBn8z1FhqXiSXudg6RqcTcvlj17EErGWg0yJjLMs_DFLyLhxzzUQaXHj0NrcneWWAYCU
 xAsCJpttj4HSh9WN5FemPMEd89hCwFgx2leZvjvg0Zr7PxzWtwKydshJd9QUJ9wHzYVbOjwwrrFi
 E6tg8N9yiBfbVmZonjeI1TBAUTnEOTuIEA1jiWZARxtzjDLOEWCCJpPUT8ZYoy7i6EGWYqklq5Av
 4hT4nVN4_5eNuxGHd6h5DfxhGtcaPN.geBTAura6lBlEB_8mCk21toooWHrBpTHB_ib37LnPmXXz
 AY_yzTiylr6GCnYJ6XYnqUSXC4Y6hxoKCUvNokEEW0dMl.HJ8dcy5Em0pWuhu6mFJM_Eb7wsDjee
 OTTOUkCa7X1QSeH9VhdwK_upo7hLl_I.4ec75YyCGQKxCMWwpA86ozk9kzPupwqGwsO_RZixxKmE
 qZbWCRqoPpbuD.TP3u8wfWCgJeWq6Xmi91c_ctavhlQeBfd05bpt7K_nSf4kpbI6HK9Wx_eB6T7u
 siQ--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: d8356646-539e-4e85-9600-feaf27549e06
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.ne1.yahoo.com with HTTP; Tue, 7 Nov 2023 17:42:56 +0000
Received: by hermes--production-ne1-56df75844-8k4lp (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 3972b142a78c55ae3b07ff3d24b1ef7f;
          Tue, 07 Nov 2023 17:42:52 +0000 (UTC)
Message-ID: <7e2ce7e0-7b04-4953-9fbc-3cde20d8c89e@schaufler-ca.com>
Date: Tue, 7 Nov 2023 09:42:51 -0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 15/23] security: Introduce inode_post_create_tmpfile
 hook
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
 Casey Schaufler <casey@schaufler-ca.com>
References: <20231107134012.682009-1-roberto.sassu@huaweicloud.com>
 <20231107134012.682009-16-roberto.sassu@huaweicloud.com>
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20231107134012.682009-16-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.21896 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 11/7/2023 5:40 AM, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
>
> In preparation for moving IMA and EVM to the LSM infrastructure, introduce
> the inode_post_create_tmpfile hook.
>
> As temp files can be made persistent, treat new temp files like other new
> files, so that the file hash is calculated and stored in the security
> xattr.
>
> LSMs could also take some action after temp files have been created.
>
> The new hook cannot return an error and cannot cause the operation to be
> canceled.
>
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>

Acked-by: Casey Schaufler <casey@schaufler-ca.com>


> ---
>  fs/namei.c                    |  1 +
>  include/linux/lsm_hook_defs.h |  2 ++
>  include/linux/security.h      |  6 ++++++
>  security/security.c           | 15 +++++++++++++++
>  4 files changed, 24 insertions(+)
>
> diff --git a/fs/namei.c b/fs/namei.c
> index b7f433720b1e..adb3ab27951a 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -3686,6 +3686,7 @@ static int vfs_tmpfile(struct mnt_idmap *idmap,
>  		inode->i_state |= I_LINKABLE;
>  		spin_unlock(&inode->i_lock);
>  	}
> +	security_inode_post_create_tmpfile(idmap, inode);
>  	ima_post_create_tmpfile(idmap, inode);
>  	return 0;
>  }
> diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
> index e491951399f7..ec5319ec2e85 100644
> --- a/include/linux/lsm_hook_defs.h
> +++ b/include/linux/lsm_hook_defs.h
> @@ -121,6 +121,8 @@ LSM_HOOK(int, 0, inode_init_security_anon, struct inode *inode,
>  	 const struct qstr *name, const struct inode *context_inode)
>  LSM_HOOK(int, 0, inode_create, struct inode *dir, struct dentry *dentry,
>  	 umode_t mode)
> +LSM_HOOK(void, LSM_RET_VOID, inode_post_create_tmpfile, struct mnt_idmap *idmap,
> +	 struct inode *inode)
>  LSM_HOOK(int, 0, inode_link, struct dentry *old_dentry, struct inode *dir,
>  	 struct dentry *new_dentry)
>  LSM_HOOK(int, 0, inode_unlink, struct inode *dir, struct dentry *dentry)
> diff --git a/include/linux/security.h b/include/linux/security.h
> index 68cbdc84506e..0c85f0337a9e 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -344,6 +344,8 @@ int security_inode_init_security_anon(struct inode *inode,
>  				      const struct qstr *name,
>  				      const struct inode *context_inode);
>  int security_inode_create(struct inode *dir, struct dentry *dentry, umode_t mode);
> +void security_inode_post_create_tmpfile(struct mnt_idmap *idmap,
> +					struct inode *inode);
>  int security_inode_link(struct dentry *old_dentry, struct inode *dir,
>  			 struct dentry *new_dentry);
>  int security_inode_unlink(struct inode *dir, struct dentry *dentry);
> @@ -809,6 +811,10 @@ static inline int security_inode_create(struct inode *dir,
>  	return 0;
>  }
>  
> +static inline void
> +security_inode_post_create_tmpfile(struct mnt_idmap *idmap, struct inode *inode)
> +{ }
> +
>  static inline int security_inode_link(struct dentry *old_dentry,
>  				       struct inode *dir,
>  				       struct dentry *new_dentry)
> diff --git a/security/security.c b/security/security.c
> index 5eaf5f2aa5ea..ca650c285fd9 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -2013,6 +2013,21 @@ int security_inode_create(struct inode *dir, struct dentry *dentry,
>  }
>  EXPORT_SYMBOL_GPL(security_inode_create);
>  
> +/**
> + * security_inode_post_create_tmpfile() - Update inode security of new tmpfile
> + * @idmap: idmap of the mount
> + * @inode: inode of the new tmpfile
> + *
> + * Update inode security data after a tmpfile has been created.
> + */
> +void security_inode_post_create_tmpfile(struct mnt_idmap *idmap,
> +					struct inode *inode)
> +{
> +	if (unlikely(IS_PRIVATE(inode)))
> +		return;
> +	call_void_hook(inode_post_create_tmpfile, idmap, inode);
> +}
> +
>  /**
>   * security_inode_link() - Check if creating a hard link is allowed
>   * @old_dentry: existing file

