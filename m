Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ADB778F56E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Sep 2023 00:31:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345376AbjHaWbI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 31 Aug 2023 18:31:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240157AbjHaWbG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 31 Aug 2023 18:31:06 -0400
Received: from sonic309-27.consmr.mail.ne1.yahoo.com (sonic309-27.consmr.mail.ne1.yahoo.com [66.163.184.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C740E66
        for <linux-fsdevel@vger.kernel.org>; Thu, 31 Aug 2023 15:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1693521062; bh=s03qU1EPYaO4PcsqM7OOZRQKPrE+3wLRBq2scPo08MQ=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=e4axbn+ooC1WbiX816lg5j2tJcTXyazl96BudFVILQjSnv0R4+8BdF3VbegRYo9VCDVFBxJbbne2YGINlGnE6H0eEQae45Cs/pBMr7cSut+NjY3VKhouy+jFDBnmMk3KiOyR6BFoDrt9WPYBlYlEfrL6vvjFHVqq/IzHogldRDlQJZqJJ6EwDmAdDLlqU345V3LykEo4yvpPcL+SSNfm0V9RCkJhdO+vRHgggqNuOkRXsep93FAdsdLYp4hmtj7U+u6QDYaWaocCSczad0sFdqr35OXwGsYlnS7ieBEWZWx6KIdlSoSkP1oZsnR/osY3WRchD6xKHR1SjMLJiPj2aA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1693521062; bh=1Y1PmljuqGZVQQ+RjXhLC089ltG6mqsxjodSB8b1rI4=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=WahDngz4ORx3tuhYTS8FFATAD7z5OY5CtewkZ3BH7rCNRsM9fAqj6wgNZaFR4wPHig7Y3bJYsiL8yx9Ac6SQXhhzSynFehm/LEw5n0JfB/hjzxpgW1RVDi62zD3uLaJq68mwPLOk/voEs1TMpN+Cow13YBKzsUvBBXWP4SdDEMVJfjwwEncIxq/55ML4a0QEGvkq84ZPzPecy9WUqw2EEh/yr6KdR3oMDiMu9M+hH+/DpYzRkvy87ycVd4mA80WBatZMTZdxXFvLWllSV4KHIVxOQSXeJCDt9cPiZjS0AZQa+JuP8kZcep7WPhEkInXuaEmF9TWTth/fi0Z6U+GbXA==
X-YMail-OSG: 15hnpoAVM1kW.TsuLvEPgaEYarONH29t8nHBeNeHjvIFDCYpkwyxs6kU7T_mY9e
 1t0xoK.3FfdB8VufY2cDFCkKdKSDqZR.M9sD3co7Ss8bBKsxdWwF713qnDBCNPuPg7zQgUa_fkkK
 O_2zisBQGyJFrH2cbpxWBUp44HUv4GmRMSdwA9fGJkJNz25HhnvLzxm_mCzFFwwAXIFlBjxdD8je
 6U.qhJFPw_9yL0g922LboxoVCq4AkewZ.qzHDd24FxOUVa_PKfCcgQktmeY8uGjJoQJH0g0oU7BQ
 qhVS240HvVWEPCuNF1lpzsjI4AzrBS4wv0SkjK9CGZm7_Ihbe9lw6vm0BCYStXaMnjx142niux.k
 P1T35OEXuI8SijS_0zZegROkmstBKUpXQORAy8z341QPeO88xnutil88Zl33netwEvUfErQFtRYd
 _L1wrZ3kqWK11xuaWankMUpNJ22nkrBZQRSnTbOSChcO9UJHAxgdYGulxiPjdbHVdskrtXMcP8tz
 WB9Iw5ZXCJrsEhwncSEeBxZD3EbBqXqyYNSGKYWPsyjJmeYHTse0eFToR7cMhkr7N0lmqLW07VsK
 iSfO1rAU9o9S2sJsni7GkK2kvhl2r59YOK8s1EEUi3j9aN1sfV9LYE311yPo1iLiA9fl_BkNcdE9
 CB9Q8fa_jqC8dO.lEqNy886Vke78lN4LFfdNv43UlHpqfkZ8qyymiDjP1tCHTgyqMHxbHly_0GTQ
 QXdp2638f8K7M.kL2vnyhScHkgJakBaJQXBcE6SQIxEvrlu52K81cP69Lit8QvukinOsW0Chmowj
 sawQRsnL1Vr4RJjkuh6NcSDkrj3z36Q8xoM7U1oxAyoz3xpHiskIf35R0Hp.U0VlvuSp92cjRuNy
 V_aZ1Xubabu2lEtXWi5hdVo.3UbhtwqWNtf0Qi2ysVnZAZTKA5SygThlBhdExWRljM1nLERYbyvu
 4.IUXzh80fXJUfgvuT0O2_6MxjIPgPIxoMPuXUjDSok1ifG0ZluId7NDt3dCF9ce8NJEylX4a8BO
 kM8jSzColmPQl5OQ_k3uOz2.uPs7DLsG4f4KRxKeVhyczZOD3rywFoopoXE1dffhant13hc4yZuB
 CclggMazurB.ITUwnqGlCOBId1JHU7x5OdIxACmn9nkc4LsR2MiOc5k66D5Lmp1GKUn7s5p6WJMw
 oj1pHTkM2i5ZQg75epJtqnyDtfLqcX_H4wiEMrXY94JKj8bxbQub4PJZ_0s3pHaohf081vUY_SJR
 IhT7IvxHUU6LH5cpfG84s1RGgVYbrjja6BKgdxM_8DP.0kaVzWz96yBLVloi54EHIpMTuWdGJ9w4
 WhiKvRPia75vqamQtDsoZcXR7kklbmrWqdlsCNJJoo0vKBOELaOEmR057ecR.R_XIq16YMuu6hkN
 58ovsKI6YvbwJ2dHSQqEeAqfcFsQQk1vu6L5DmG90DJQ.SZS_BNKeSFv9mvpaRTe9xq3CbNdYz9h
 uTr.wR3a6By8u.xN288H7KTXGnte.XHLKoaayTqLnEwhdVjDSTAT6_3bUMZM1jDgLFEdUIXgV6WZ
 Z2VX82LUUg4t34f3MpP9KOXn5zgSw3pp58LLzVDYJhlp28.oVI9m_9EhCM4RQeyE_GUhKZMuc2Av
 YQ0zOos4cMj6Y0xs9zS6H0JIZIXcuEHgeFtvCkdSEXPMwWhLz8UzlnaL1mxDyV0Hw6h613NtHunm
 dSARAvfEnn2X2Y9uxsW70Ut4249vby5fdiVKeij3e6.R6BK1iVSFDtw.6onwmgSVkedr0NT_T0tj
 M5NTUdOEHc3_J6W_dBP5E1IO.e3OBac.1K_6o67MqlN10jG0hNUsXQKlSnF3ZG855BNTcadUBQzp
 jSaCpXBsrxQuWZ1KoDNylisawgXUJvXlczQkmqV_6awbnIiGElKqrHaauW1Q1IsbLF.vqcYgMtM6
 Cms3scFY24Z_PgNqh2hatttsWzazY2GYmo_slSR1wuFsemUmy84LuevPpY.lzSJyVxZ6rN4jqWhd
 mMwb.QwswKW8SUIaekIjYrLNMw3jsNxa5VcEa54Tz0HUZjGJGq5wxLhMBJpY_HDmWXtjOOv2bJvc
 N7QrMXHlLTM9waoVNctOYvMqbw2ocUYpOYHiS89VlU_m7PGUznm7uGI4I0n0QCTQ2CTm11biaeSU
 4doVAeepfOUAEbdf7IUlCpBPMwohIw3GZvISH9OgEjiH7WKbNY7KQZj25pP00gsrrWiaLYuQQpqm
 fHKotcMW2CEG73IUOGhca.XxxrnFZU2WgwYd_db2n.SSNSAKUPDNTSZbP927UYcJX44LAUk0-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 25b6638a-be32-488f-910b-fbcbbc466835
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.ne1.yahoo.com with HTTP; Thu, 31 Aug 2023 22:31:02 +0000
Received: by hermes--production-bf1-865889d799-sjjww (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID aefbc0a6450dcf793468959f28e0b194;
          Thu, 31 Aug 2023 22:30:56 +0000 (UTC)
Message-ID: <bd4a2d7e-3c00-9066-63ed-59027cc4fdb7@schaufler-ca.com>
Date:   Thu, 31 Aug 2023 15:30:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v2 13/25] security: Introduce inode_post_removexattr hook
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
 <20230831104136.903180-14-roberto.sassu@huaweicloud.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20230831104136.903180-14-roberto.sassu@huaweicloud.com>
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
> the inode_post_removexattr hook.

This applies to all new LSM hooks:

Would you please include some explanation of how an LSM would use this hook?
You might start with a description of how it is used in IMA/EVM, and why that
could be generally useful.

>
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
> ---
>  fs/xattr.c                    |  9 +++++----
>  include/linux/lsm_hook_defs.h |  2 ++
>  include/linux/security.h      |  5 +++++
>  security/security.c           | 14 ++++++++++++++
>  4 files changed, 26 insertions(+), 4 deletions(-)
>
> diff --git a/fs/xattr.c b/fs/xattr.c
> index e7bbb7f57557..4a0280295686 100644
> --- a/fs/xattr.c
> +++ b/fs/xattr.c
> @@ -552,11 +552,12 @@ __vfs_removexattr_locked(struct mnt_idmap *idmap,
>  		goto out;
>  
>  	error = __vfs_removexattr(idmap, dentry, name);
> +	if (error)
> +		goto out;
>  
> -	if (!error) {
> -		fsnotify_xattr(dentry);
> -		evm_inode_post_removexattr(dentry, name);
> -	}
> +	fsnotify_xattr(dentry);
> +	security_inode_post_removexattr(dentry, name);
> +	evm_inode_post_removexattr(dentry, name);
>  
>  out:
>  	return error;
> diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
> index 995d30336cfa..1153e7163b8b 100644
> --- a/include/linux/lsm_hook_defs.h
> +++ b/include/linux/lsm_hook_defs.h
> @@ -148,6 +148,8 @@ LSM_HOOK(int, 0, inode_getxattr, struct dentry *dentry, const char *name)
>  LSM_HOOK(int, 0, inode_listxattr, struct dentry *dentry)
>  LSM_HOOK(int, 0, inode_removexattr, struct mnt_idmap *idmap,
>  	 struct dentry *dentry, const char *name)
> +LSM_HOOK(void, LSM_RET_VOID, inode_post_removexattr, struct dentry *dentry,
> +	 const char *name)
>  LSM_HOOK(int, 0, inode_set_acl, struct mnt_idmap *idmap,
>  	 struct dentry *dentry, const char *acl_name, struct posix_acl *kacl)
>  LSM_HOOK(int, 0, inode_get_acl, struct mnt_idmap *idmap,
> diff --git a/include/linux/security.h b/include/linux/security.h
> index 820899db5276..665bba3e0081 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -374,6 +374,7 @@ int security_inode_getxattr(struct dentry *dentry, const char *name);
>  int security_inode_listxattr(struct dentry *dentry);
>  int security_inode_removexattr(struct mnt_idmap *idmap,
>  			       struct dentry *dentry, const char *name);
> +void security_inode_post_removexattr(struct dentry *dentry, const char *name);
>  int security_inode_need_killpriv(struct dentry *dentry);
>  int security_inode_killpriv(struct mnt_idmap *idmap, struct dentry *dentry);
>  int security_inode_getsecurity(struct mnt_idmap *idmap,
> @@ -919,6 +920,10 @@ static inline int security_inode_removexattr(struct mnt_idmap *idmap,
>  	return cap_inode_removexattr(idmap, dentry, name);
>  }
>  
> +static inline void security_inode_post_removexattr(struct dentry *dentry,
> +						   const char *name)
> +{ }
> +
>  static inline int security_inode_need_killpriv(struct dentry *dentry)
>  {
>  	return cap_inode_need_killpriv(dentry);
> diff --git a/security/security.c b/security/security.c
> index 764a6f28b3b9..3947159ba5e9 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -2354,6 +2354,20 @@ int security_inode_removexattr(struct mnt_idmap *idmap,
>  	return evm_inode_removexattr(idmap, dentry, name);
>  }
>  
> +/**
> + * security_inode_post_removexattr() - Update the inode after a removexattr op
> + * @dentry: file
> + * @name: xattr name
> + *
> + * Update the inode after a successful removexattr operation.
> + */
> +void security_inode_post_removexattr(struct dentry *dentry, const char *name)
> +{
> +	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
> +		return;
> +	call_void_hook(inode_post_removexattr, dentry, name);
> +}
> +
>  /**
>   * security_inode_need_killpriv() - Check if security_inode_killpriv() required
>   * @dentry: associated dentry
