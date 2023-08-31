Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A20C78F568
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Sep 2023 00:29:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347683AbjHaW3H (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 31 Aug 2023 18:29:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344401AbjHaW3G (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 31 Aug 2023 18:29:06 -0400
Received: from sonic309-27.consmr.mail.ne1.yahoo.com (sonic309-27.consmr.mail.ne1.yahoo.com [66.163.184.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54CB0E76
        for <linux-fsdevel@vger.kernel.org>; Thu, 31 Aug 2023 15:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1693520942; bh=v6K6x6pP5pq2t8foyzYb/b3yS47OHliT7nnAWOYQZK4=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=H/6BZuBa6IS1rMFu3lNxuwtn4aOnx9SCHth4DH0AW1bBljHZJtl6GxvSd+qwfiROjMlsUrbP+JGoZfHnYL6j/iAynL7lziAYJMGjo3KnbYceZneM8ymMcrl8ES/31CsbMzP5xVNXmroOO1TfxgaGZshvAdjQZdv/JAwpHef+5DctpgYUYam2HzjTFtRO3zfxukQawRk8iVK5o0v0QkoLVxqQE9CCxDRqgvXXi/XpVHNXEmAl0ESb8clYGLxgcUD5Is1wkbjVqfZAxShuyjLhScEdboDQov6JzOk4n76XHpqyb2veRWVsNI8fYG2CT4fFTpPsGaYsXW7je4EQhr8v6A==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1693520942; bh=LmnGU5ZBvK7PZ/p4LDcGtHBehYaGrUjrIRcDXkuk5Y0=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=iQxJWO6kmPZKd31AMamlpPD16Ep8ypo/r+EEe0/5ZkpbZRDSTvar9g6PNFbNkH2XbCNG4jqqjZfBmO9y39rjxixhjX6ZCtufBuQvOxZNhO2BLo+yhbLfrk+KgftlO8KjJVQzdKzO3WRfY2dfTqAEoE3DN514mIW818tPvEcWMd/5bgjNHJ1l0ABiFQv7CHNCOoUP4dzdLdY6X181+dJA2utMpmy3+R5wUUgeg6wKgfw/lNwOPZzq6sGFupNnIxNM3PfQ1OM4bQf/JuoFoSNzAjpJ1x4OtykGxa1Xm3axGoG7w7OGWN31cM8STXdPp7WIseZfzYD8YKx3fm9zK2puog==
X-YMail-OSG: N73QA7gVM1kWM3D46sz.ItHF7ABxFA.xnYwxa7Nv_Ht2B6LeMAAtJU936IhSeR6
 A_tOmplW2DGHS2y.JBe1s4fLk_.._XGaTuoI.mpTnQiI6BgdnSihypxgA617bLjgTFCDzUcn.HMm
 ca8hMizqgrqqU4xJ9YaI2_Q7k2jTCv1CWSBYJZQeXwEpUlUX52igaFm0tnhvkiux8v6xRpr8sQIP
 GqQohBp0gQiQ6GfL8rKbND4E8x5YDQb8htn68FxWhhw1jzRksXwNAM335pEyU7HS3nUrABhH5GCD
 tYAOLC7FsYy_hdTHx0kpFfqd3tVv33PAY6JtQck.SWhftgFttzvmVpxinJ3qH_s1LQsZcMMq5LDi
 0FwVRQ5GvJLpVd6NXSrohHOObgnudKS7.ZZffquOH3NKtIE8JjPVDVkHi8mKqEicgNWZ2eVKIDCm
 _iNjj68MZPrySVQqsH1r7tKwevO4jvfLb0QPm4FKDOaZa3qUE_d6vmBFxMhko2jSzNp61noY7oAr
 E.k30Q8.mX4swJv7ysYJla9QOFbHtUQBBcyW59Jda25kQuT4EMlJHJBWOJOzXiHaHbab0AM7Duqr
 gOm0leLAmv.o6Rg1.CIY0WGpHq2ze9KD3Y2_vClQAWXQIyMGQELk_OH2lvvKj7TuLpBeveBRvIPe
 bMhaOdWuIToTUhFFtKLcTddO1UUwZfqGGbk_XIJb9xnv_u2hlVQr7XnxF5XKya0n_LqwfKuxuASo
 Mbkeij9xxaLOYsXNtb3WbG2LI0zvZUU56X2HO2qQlPQtaIlB6ShOUutKP1ck0W_DMQGSmgThQ1bk
 2x.Ga0RyyGk0.Sg0qHK.5lMxQ16cYWifbJwDrE7cX_lcoKn7_Ckou_WIJlC6LodtaMqqEx5hozBc
 DHFFecu2AgKiskIwqjmgeSWNdZpBP6y.USl6O6_8hQ2Y_B1KcVFRKy.wORp6tgiDxEarU2s6wRKd
 PgonU4JLtc7WZ8vW0G3sb9Fga04a7xLhID1.Qf0n2sQWZe.FQ4HyDnyj88J2s.iN5Rt.FDt_YIp9
 TlojaG2zMF8EOH_yZVnCIUDyH0BH_SEokxWw6.RB8NAm72trj_dprYFPCVYMQOviTjDtSULLKbuW
 p5FqQo7gmStkrKty4P60J6EXrHlqO7sj4a.WXOE9EHHEakOCHWm8HEi4Uzo6r8eGXQ03yZP7etzW
 3jeTrLRTARylIkG1CbVRryHcxvSNnMiUhw6wk8NCdKXc0AxN3zh2QBuV_1psA25EL85O4cYRVFNG
 R2HaF1y9xrEIL_TiPU5rf9xkcw.qZKhvjOxi_bvQ06E_LhCoRhrtgtGoX1p.3xFSWiNhj9yFeWmm
 UzkQnLf5QhvKL9tj4hibNsWF_ehSXSzGZjyWqTeu8uM1irwW8lEDjadunWLR9nIcpfmQdOT9VBXI
 1JupBmYiFgVj1s0NDnwUtlz_G3MapE5U6._zoIMpOkGxmju3QGX0xCN9jLKRqoY9DBsnka3K4ml2
 vBsbuRdQePlSK6_Y2lKAa1GSHBWeWZc_ygbFlq0ngXbW8HgHrm11PqNptub4Mp4MG68e2GcJ5Aml
 Y1R8SCUG707U9thtOSkMkkhjKuEJIyoGYXDZYPlXzax_EAda84Om8IO_6VuLC6KNDN4xXDzQve27
 HZOtjFheehhbUCsGTl4gRuM7k_qJiJKoI6r6tG3iH1T.q4ng13k7B9yFi_pD.zqzCeldN487J00Q
 th9tSPCLgDuhW_JqT.eLvTqLq7G3JMKwtNRarwxTIveZvUR69tlObCaXh0RLRzHPA8OyxRkizesT
 Ulfnk_5mmuQSJ7t3gFv8A.y7MJ68Zc72P_mSXGGQkbPY5sH7ziza5vh9F_Au3tH.q_1g_59zdDgT
 5aDSrvJoOaoT9EhHfK28eGBpJA4n5j1lkSKEefXWuCvdtrbMp7WSSvbK7oSq9AtR8pEf3P0WdQVZ
 GI4LmjcF0f1z4BdMT8V13l20sw47mhKdyjYSdoZ0dH0DqQ0yfijjN8V_nqBBNvw.ADK2YLh26AYr
 KR92JjMdCeXSYHdC9BnvUEQ16CI1_km1PP1qtqdbyVrUOXRMYWWnxWKurA6m7Bx6a0kKItyR62hT
 swdDYatH_ZUO1hdmQp6Qqyj5Ce0Pzg.iMFwTINLfHclj_Gqf9rvRzts.mF.NjN.BrgOCFuLLg9mX
 Zy2GQ2AJF1zA9c2U7eTb.TOYd5EJwl4zPBhwSdia8ieDPmoR3qQyVTkBdGW1DQQE5jlL_8FY8UmE
 LI6Y1TL6N9IvQFCAvGDqyaVShtFZsb5rSe9y9DmZ21MbT3VHm.U2C8.u8HV0V2vFY
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: c31f14af-8255-4d6a-9539-64505abd1b35
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.ne1.yahoo.com with HTTP; Thu, 31 Aug 2023 22:29:02 +0000
Received: by hermes--production-bf1-865889d799-cgv22 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 7bed110bc26c66b842d85614bd6f1485;
          Thu, 31 Aug 2023 22:29:00 +0000 (UTC)
Message-ID: <473b1279-5b29-9bf7-3609-6da2bd44c84b@schaufler-ca.com>
Date:   Thu, 31 Aug 2023 15:28:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v2 12/25] security: Introduce inode_post_setattr hook
Content-Language: en-US
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>,
        viro@zeniv.linux.org.uk, brauner@kernel.org,
        chuck.lever@oracle.com, jlayton@kernel.org, neilb@suse.de,
        kolga@netapp.com, Dai.Ngo@oracle.com, tom@talpey.com,
        zohar@linux.ibm.com, dmitry.kasatkin@gmail.com,
        paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
        dhowells@redhat.com, jarkko@kernel.org,
        stephen.smalley.work@gmail.com, eparis@parisplace.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        selinux@vger.kernel.org, Roberto Sassu <roberto.sassu@huawei.com>,
        Stefan Berger <stefanb@linux.ibm.com>,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20230831104136.903180-1-roberto.sassu@huaweicloud.com>
 <20230831104136.903180-13-roberto.sassu@huaweicloud.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20230831104136.903180-13-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.21763 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/31/2023 3:41 AM, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
>
> In preparation for moving IMA and EVM to the LSM infrastructure, introduce
> the inode_post_setattr hook.

Would you please include some explanation of how an LSM would use this hook?
You might start with a description of how it is used in IMA/EVM, and why that
could be generally useful.

>
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> ---
>  fs/attr.c                     |  1 +
>  include/linux/lsm_hook_defs.h |  2 ++
>  include/linux/security.h      |  7 +++++++
>  security/security.c           | 16 ++++++++++++++++
>  4 files changed, 26 insertions(+)
>
> diff --git a/fs/attr.c b/fs/attr.c
> index 431f667726c7..3c309eb456c6 100644
> --- a/fs/attr.c
> +++ b/fs/attr.c
> @@ -486,6 +486,7 @@ int notify_change(struct mnt_idmap *idmap, struct dentry *dentry,
>  
>  	if (!error) {
>  		fsnotify_change(dentry, ia_valid);
> +		security_inode_post_setattr(idmap, dentry, ia_valid);
>  		ima_inode_post_setattr(idmap, dentry, ia_valid);
>  		evm_inode_post_setattr(idmap, dentry, ia_valid);
>  	}
> diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
> index fdf075a6b1bb..995d30336cfa 100644
> --- a/include/linux/lsm_hook_defs.h
> +++ b/include/linux/lsm_hook_defs.h
> @@ -136,6 +136,8 @@ LSM_HOOK(int, 0, inode_follow_link, struct dentry *dentry, struct inode *inode,
>  LSM_HOOK(int, 0, inode_permission, struct inode *inode, int mask)
>  LSM_HOOK(int, 0, inode_setattr, struct mnt_idmap *idmap, struct dentry *dentry,
>  	 struct iattr *attr)
> +LSM_HOOK(void, LSM_RET_VOID, inode_post_setattr, struct mnt_idmap *idmap,
> +	 struct dentry *dentry, int ia_valid)
>  LSM_HOOK(int, 0, inode_getattr, const struct path *path)
>  LSM_HOOK(int, 0, inode_setxattr, struct mnt_idmap *idmap,
>  	 struct dentry *dentry, const char *name, const void *value,
> diff --git a/include/linux/security.h b/include/linux/security.h
> index dcb3604ffab8..820899db5276 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -355,6 +355,8 @@ int security_inode_follow_link(struct dentry *dentry, struct inode *inode,
>  int security_inode_permission(struct inode *inode, int mask);
>  int security_inode_setattr(struct mnt_idmap *idmap,
>  			   struct dentry *dentry, struct iattr *attr);
> +void security_inode_post_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
> +				 int ia_valid);
>  int security_inode_getattr(const struct path *path);
>  int security_inode_setxattr(struct mnt_idmap *idmap,
>  			    struct dentry *dentry, const char *name,
> @@ -856,6 +858,11 @@ static inline int security_inode_setattr(struct mnt_idmap *idmap,
>  	return 0;
>  }
>  
> +static inline void
> +security_inode_post_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
> +			    int ia_valid)
> +{ }
> +
>  static inline int security_inode_getattr(const struct path *path)
>  {
>  	return 0;
> diff --git a/security/security.c b/security/security.c
> index 2b24d01cf181..764a6f28b3b9 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -2124,6 +2124,22 @@ int security_inode_setattr(struct mnt_idmap *idmap,
>  }
>  EXPORT_SYMBOL_GPL(security_inode_setattr);
>  
> +/**
> + * security_inode_post_setattr() - Update the inode after a setattr operation
> + * @idmap: idmap of the mount
> + * @dentry: file
> + * @ia_valid: file attributes set
> + *
> + * Update inode security field after successful setting file attributes.
> + */
> +void security_inode_post_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
> +				 int ia_valid)
> +{
> +	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
> +		return;
> +	call_void_hook(inode_post_setattr, idmap, dentry, ia_valid);
> +}
> +
>  /**
>   * security_inode_getattr() - Check if getting file attributes is allowed
>   * @path: file
