Return-Path: <linux-fsdevel+bounces-2282-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5074B7E46F1
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Nov 2023 18:28:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 707061C20BBD
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Nov 2023 17:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B862E347BF;
	Tue,  7 Nov 2023 17:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="QFbYQV2I"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F23347AD
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Nov 2023 17:28:20 +0000 (UTC)
Received: from sonic312-30.consmr.mail.ne1.yahoo.com (sonic312-30.consmr.mail.ne1.yahoo.com [66.163.191.211])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6313DF
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Nov 2023 09:28:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1699378099; bh=Vuzh02cMvmcAtEzf3k3+FZYaX94n0h9qNSO3oBVGzmA=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=QFbYQV2IcWM2oEAs5AdocYBfsfFBYw7KsT5MEhgh29MY9D9XrAmER9Eb4bnIWT/uxO5Iwd06CD/0bN2qxbNeIiZFMDOYEMi1haksHOCiLVYYWbmLSauu0LAFJf83pZ9C9Hjw5VKjYcea+Sm8dFFpsnJiMgQadGRui306QYQRq/tQF/eVViV0Q4Gr+mwL+pk1hOLhO53cTzGSdZLY6ICxLZgIXW51rdO57GJ3pRTaW+O50qTGs0rfrLUJUBNy8IKt20I2RDpiOSRxT+jksCyHTuiHyua9wWfVk+0gUdfbbZGP1t9to4RnVOZyjruzuaPHQn2NixmtF9oU93aoheuL3w==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1699378099; bh=mk1w+Ieot6s9pQ4+PTm30Rrb2+y2xVwNYFApPgCcvm7=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=W+3qUTULl0NVnRToZZkjN/YBQ8BnHcGZL2jjZwkgGBYz5BLeJlbZWUzDtbvjh4ESyDCcyp9KBW+xUljiJ1kfNMF+tU4AmN/22GOOYvaPNI8T6LX0Arl7xhuf8nZwtsiyODi3guClC/Gbfr6ihUseSdf3YwjUZBgd0J1TgOSyMCBLCETCK/RDJ5K3bCZAz7zUzrN91qdW1FL9c3ZBkbipmTXQv8UEff7sTkKsOdKGutbA4FM2KnndbJ6GLn5KWHgKShZo/WFbAu0BMrFAshN71ROqzj7oJskT9MZsPi94VdFkKgAi05SXXVXnFFg8DBne486/Ok66Sfmmoh7kHbUxAQ==
X-YMail-OSG: 5NGy234VM1k22CfhqPa_orY2QON07wbqgEkO9N8zbm_Ox.wu9OAaOrHRfFjhZo2
 .P9oKdF1i4yHuiT1YMz8WLPS_M7GjiAFwyvDbBFEeJTmgDz_PIVHmkmoJP9oX_PFZq_UI.h0QPhU
 Wc2AsBWdjUCnDe2YOJsVkSI3rgDR6T7yd5W.rMj15BhA9h_Ljrr3nhK26E0JHaBe_G.5Xn_QyIwE
 liwNFEkA.voTU.zxcA5YjR0F1_P2ZafxvwAVJHF9LG4EoDsN5T44eRj28wvbbl5BPjnHPyXTX3ZH
 2LXM8Y5LNRdMolj3fcqfT4vhjB62sFLDOUA4EjqP3CX5WdvC7kTM40gJRbIwRMh4Q937c5fzvzUr
 JxO9tRefznbSjhbuLZUzPRvgwSEiegj1A7fjoHalSY_tgZHMZl42pG1xq4NL3Zr.uwYNnKpZqvKG
 ixRozRX1QKBu.E8qOhH6wSO8N6hpRLxUszyC_QirxB_smBKJZK4.jVwY_4I9S6vUQdcmt4ZLz0y8
 0iKc0RfBpiH8bTo0vCeXz7PDgkSxNy_8ytly4iZ_1_jTUkDmYjT4sazYF7RPRoq8Y7ne3LnAN1ON
 rBSZIWYsMj7Odh3GVaVs6ilVCmhStQvVGITmT9NgksuFVRBxGvh_ZCz37TGSXz4l9prvqDqTVA3C
 CS17Sik2hXSwuLDinnNSRnupA67x15z0olmuhl5hIj7IFKvYv6VxFtgO.J9JygH17.4RRSwTasRK
 yqGb1B9VMSSBm5A2SHP5HjsBWIQU11gPa.amB1Koje71oS2CWFSlpLPXJuhsCYb4tGxj8kxNcfcF
 6bgLTRaT1ImQY8Yrn6wXEOZRuarQokA5iKAwx_E2diC9tuWg9TbJglalJMCIxWmXv5YeU.TeSX71
 lLQQWUwyVUXxFXuLf7LEsjPqbE7sOVspqfr5sYBjBXobRdlFEucIAtYhD.ExmzPwrLzZ_VjS58zR
 YMpRkBwMHCBEfEwc0mvgGbsXKYcwNEMYhMG4wg5fTMZHm52kLzub4kso37uKl26KZeOsgQWtsi0g
 6C5N8wavcQ2oyQmvv1h38IX_ahayRRPVEDkmPYOx4eZEvx1V1dsiqaO3cVweWub7pahr51asdrJX
 IjRUOy9By3tZi.rLXFXwRiwhp93ujvnNTekRjcQ9FcgBm9frqRqCG.v48J_7j2CDq4BwUUxbH4GP
 F.9FsWD_awGepa_iKJ9xdCyc0Ffo0QqbkCE9YUr36mf2aNJ4REj979QXUw20vsd6wT_FgabOY0IG
 A48.wOzdshSEIDJXeMwiGgOIQZHnLyvZ3WC68_prYK4X7X5lc.Bg29viiTMXIlj_j2V.pV0cxiin
 bwJ95hGfSSaFRU.PDuwzk1gi7LP4WIhZyYHW.3_82yyFCvDjKDHiEnTJtfqNCvZswLL8Csr4pbLw
 Z6fLr3BhM_a1NPXynEgbkUBz0KvEFjFCSRFbHHaj6QFiBZdkBfu5_uWarszTVScjpIgSgWdBuEXL
 mpXtf4CQp.a9p9kWDhJ3mGHYdcTA.DQWVoR8f7pJVFA0WLkr1nsTuQzX7Ylttui8kq1M3W52yOla
 llLIYVDhsAej5WQaMdxVw_JU95CWrf_.RLY6tqUsQcnx4UHBfS6dCf9jc5ywATMtS4T80TB8UIi7
 hj7xCvwKcL2NBrq9oIYnsQlVCpXMBiQHQ874XrIrZWXcVa0kLkpBM3d8nWAjBXHt3zvMadk1TlWx
 ZAYn0yJHCm3L8xdlCi2YrjK567WlUCIdXLaKV_np.Asr6iAExqgNGlP0V_QR.wbfpknTfVIVqU3M
 nL6naw7Eh7T4mgeNnddm2zzq5sIg5iTddMU9BMQX0zDJIw5iPB.Yp5eIwdxc9uA2T7tfvVj0ykHt
 B6JmPMuxkHIyLBIn5G5KE7GfAHtWBMlcksQwx8PmJ9cWOHnmA_uAqP5oEKwMVMQTnBJo3MXRNciW
 Ty1xlVViGTUKovx8HECEPHi99qDU6rzaEeYv6qDfsq9Mc1tQhyYCw4rFWlB5yynim6.ynV4g_Js2
 XzgyU1g5uHj.n73K07OYNPRuidF22uX5IaDdfSBqu5u85JEZBdjiFRXOr_t6caEktZoQZ0.xYtLw
 oKtZFU9AGd108JQ5gqdfUSq3I_BnBQNcH6_JQDw7Pl_t8q63_UmrVaTRQg6S9vQ3FWLRGa9.a3tZ
 lxGrqAoBVYz5iL5TBtmW61ygPLhr2Z0kIO1KSkYBOGQGiZwdyAOcDdx6_XaJ5M.EUeITtyRXNwQn
 AeXLFJfIl2PW7tqYUMkf1nQPuuF_YyCZ9ngzuV5IDbe3wgX2VY8MqP9a8iSdhBv5VWHLo.lqnehw
 -
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 7b6bbd4e-a7ae-4325-b188-0332db778a84
Received: from sonic.gate.mail.ne1.yahoo.com by sonic312.consmr.mail.ne1.yahoo.com with HTTP; Tue, 7 Nov 2023 17:28:19 +0000
Received: by hermes--production-ne1-56df75844-sgvl5 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 852b5eafef80ced81f270152710c3028;
          Tue, 07 Nov 2023 17:28:17 +0000 (UTC)
Message-ID: <ef11b142-e5f2-4e75-86dc-554c93d78513@schaufler-ca.com>
Date: Tue, 7 Nov 2023 09:28:16 -0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 08/23] evm: Align evm_inode_post_setxattr() definition
 with LSM infrastructure
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
 <20231107134012.682009-9-roberto.sassu@huaweicloud.com>
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20231107134012.682009-9-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.21896 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 11/7/2023 5:39 AM, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
>
> Change evm_inode_post_setxattr() definition, so that it can be registered
> as implementation of the inode_post_setxattr hook.
>
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>

Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>


> ---
>  include/linux/evm.h               | 8 +++++---
>  security/integrity/evm/evm_main.c | 4 +++-
>  security/security.c               | 2 +-
>  3 files changed, 9 insertions(+), 5 deletions(-)
>
> diff --git a/include/linux/evm.h b/include/linux/evm.h
> index 7c6a74dbc093..437d4076a3b3 100644
> --- a/include/linux/evm.h
> +++ b/include/linux/evm.h
> @@ -31,7 +31,8 @@ extern int evm_inode_setxattr(struct mnt_idmap *idmap,
>  extern void evm_inode_post_setxattr(struct dentry *dentry,
>  				    const char *xattr_name,
>  				    const void *xattr_value,
> -				    size_t xattr_value_len);
> +				    size_t xattr_value_len,
> +				    int flags);
>  extern int evm_inode_removexattr(struct mnt_idmap *idmap,
>  				 struct dentry *dentry, const char *xattr_name);
>  extern void evm_inode_post_removexattr(struct dentry *dentry,
> @@ -55,7 +56,7 @@ static inline void evm_inode_post_set_acl(struct dentry *dentry,
>  					  const char *acl_name,
>  					  struct posix_acl *kacl)
>  {
> -	return evm_inode_post_setxattr(dentry, acl_name, NULL, 0);
> +	return evm_inode_post_setxattr(dentry, acl_name, NULL, 0, 0);
>  }
>  
>  int evm_inode_init_security(struct inode *inode, struct inode *dir,
> @@ -114,7 +115,8 @@ static inline int evm_inode_setxattr(struct mnt_idmap *idmap,
>  static inline void evm_inode_post_setxattr(struct dentry *dentry,
>  					   const char *xattr_name,
>  					   const void *xattr_value,
> -					   size_t xattr_value_len)
> +					   size_t xattr_value_len,
> +					   int flags)
>  {
>  	return;
>  }
> diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
> index 7fc083d53fdf..ea84a6f835ff 100644
> --- a/security/integrity/evm/evm_main.c
> +++ b/security/integrity/evm/evm_main.c
> @@ -730,6 +730,7 @@ bool evm_revalidate_status(const char *xattr_name)
>   * @xattr_name: pointer to the affected extended attribute name
>   * @xattr_value: pointer to the new extended attribute value
>   * @xattr_value_len: pointer to the new extended attribute value length
> + * @flags: flags to pass into filesystem operations
>   *
>   * Update the HMAC stored in 'security.evm' to reflect the change.
>   *
> @@ -738,7 +739,8 @@ bool evm_revalidate_status(const char *xattr_name)
>   * i_mutex lock.
>   */
>  void evm_inode_post_setxattr(struct dentry *dentry, const char *xattr_name,
> -			     const void *xattr_value, size_t xattr_value_len)
> +			     const void *xattr_value, size_t xattr_value_len,
> +			     int flags)
>  {
>  	if (!evm_revalidate_status(xattr_name))
>  		return;
> diff --git a/security/security.c b/security/security.c
> index ae3625198c9f..53793f3cb36a 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -2367,7 +2367,7 @@ void security_inode_post_setxattr(struct dentry *dentry, const char *name,
>  	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
>  		return;
>  	call_void_hook(inode_post_setxattr, dentry, name, value, size, flags);
> -	evm_inode_post_setxattr(dentry, name, value, size);
> +	evm_inode_post_setxattr(dentry, name, value, size, flags);
>  }
>  
>  /**

