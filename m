Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79DAC6AADA8
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 Mar 2023 01:43:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbjCEAnH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 4 Mar 2023 19:43:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbjCEAnG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 4 Mar 2023 19:43:06 -0500
Received: from sonic304-28.consmr.mail.ne1.yahoo.com (sonic304-28.consmr.mail.ne1.yahoo.com [66.163.191.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A2309EEC
        for <linux-fsdevel@vger.kernel.org>; Sat,  4 Mar 2023 16:43:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1677976982; bh=c/0lNBP+/tsveqP02aZ2MyLexROxi9EcIGV972ZqP8I=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=Sd6Wk5n2qE6Hz1cxB9cHhGfvorjhalrbbLfNx1wVSJtd1H8oHi1t932FmCzxzmP8n1qXZppZnvH2ro/X0bBffrs1rBNCW9PFKVFv0zGHqbzkCGuXjgvh2nHPt+21QRqZ+4cLhDA00Xnl0dWEojckMMQoX48WeG0gaolpvPM+uOru64r6Wx8VshY2k8BYKeqOhBTgzu+J21TXAaTZlJDyBASyqHZICgf6he0nJXEOLEcj2RGjJD1uc9HwCI20Mm0ePygfWh7IP3R4tvfqWEveUPvr98KfEAOpby0fC7zb3WKhn69/KB0tKLxU/3hFmp6R2LIVZuiu3F0hD1KcBkCbhQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1677976982; bh=qaP/Gn+pi/pUISzzvGjFLgPmL44qXXMSL42bJRRNXiK=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=LZ9LXsa4dO/VwMph+OoAnJ9doVVWL/qFY7whce+mQOGBJ1/Tj6AulhCuOty7ilNiDjfNiZDKSs3SIQs3qvQqw/F27ajH7qXk0ABGrT2bmW/8o3/CHXGu7SLHPom3NQSY/BFSZw02WMvjJoPigjtDHhucbHMHecHDNvVwup7AKASEhQIafY5YXq+wtwESE9f9SRpVDvVyo7NCWfZtuU4mDBtprNOgkJ2D8kLsepVrLbnEANszyiKn6VPWlZlPSER/9PWV20k7DmPnen03Ywe9x4VdR3Op/pK0HQcvnl9+PU0wRupthbPHyvSB1/Lg28TGgBQ1/Ar7XUPk2SuZsNw2aA==
X-YMail-OSG: _g98NLoVM1l8YJL5_0xVM9.y1ty0TcDe3rvrJ2HuFVeRcAaYPB4nwuF7kPgKGW4
 U90YSiH0SaBoSAIKUbWMPyQYSnrZdve3YRUyA6rQZCHpFPQpnCGqCADvGu5hqWLKL9bAAWlZ7JNc
 bze9h4z9n.LWyeWsPjNntoDW9nSYdb_pSwzdfraMyFsfLt39kQoQPWbomJAvPuqhyVlzTedRViQz
 ZZMNn0m2gzZA.fT67s6GOOe1BHDfYj30WI4wbkWS7sviPaeJiG0Cuwac1ld52g32LnqGcgDEP1HW
 JTfpOBpzygyzrPCBisZWVA7ruOyJL.yJz2kSccyPf1eDxrhlD57Kld7jixr4UDK__XQAaLSV6Xko
 BLEyGRHPN3KoZe7KYn5gmhzGzM1jsLLkxwIKe0mm2GSFL20MpWSsWIoRLvZk6FLV9EvRwoRf.odC
 BWgQ.SzdQqfUaeZN5XkquX3k.y0THkd7geTmRPIWTVxTfEqgziWR7z27O9YtsXKg2.Go3waXRcMH
 mmhcBqXuY2T.6dx6ffklVF.1bW52FXKokH9ykmbofgY0UYQ4eXlL9s8Qg94.KKJ.ylbJfmt_0xqj
 k6MiLEMuW2BnodizdaL8JzJJn3uo3dkLAcMZkLIMajMqRxNBcJcsJ3PKb1HYJo4JXPAJN8clM4ne
 Jo8jdvRpk7JHxAd.sc.gnSRgxKRRA8B5pBtdf0oJQbnWvcXjI4NtS0EMwJCmuSrzrvTy5hWsnZ65
 KbX7JsAYxGTPVnIOO4wWj4Vz3O8DsYWfw1mSakQyZ7WIeiSWwiHcn7a88CDZJorJ9XMwFeVBJdgK
 pYGgr5AFweLeKRCNxIzfvPnlR8BIU7mkHGxCUsJK68wpM509GDTvuQWEEE.ZOYOJmO0sfShETT3i
 EUvokofToslLcgQsX_UPvw_HHHOAIMrLQPgjHUhchrghoBn9YfkQz1YqWJo9SQ7A8JMljAtogZQt
 siOwieDQ1I4DxY0llOcgRW5XBwfQ3QqSwNwaYWRyJizZ63kpTKMVi3BBdFQF2IVOQS4wUdHWMpJA
 tj.VS6iHwIbIdAF4uqGq6vZgvD_oEg93WfBN8HIeLl_qmczqaEEmZ6PNw9ziPnMAgzZ8Cq0EHuNp
 cvQI0MnCT6gtTMrzHDvEq0mTMB.83OWRPeOy_JYbIFK8xFoPPNVxGey2t.f20o2CsCMs6vGv4AR4
 UZRF9qGynEzk_BTwBP5MqkC3nMpCOyY.SPGnmwLsv4TDDn5nUjXQEiHOjRmWU.6c4HY8RLgyh5cu
 1PnEQXy7cpPS2vScdR2scbnwjgFqi1F1ECUDvgoJoeIdDVaeWvNhi_4XuuDY6XIzXlBs0tGPqtYB
 ka0f1F3q_GtgnUARIkuZJb_oX1MzBo2KnPVZAUpo3vOorqfKN.QN8Y2U13JngFYWooAayunAnMmj
 9P356CVt47y5k9ZRYDA.VYULD05XnQyUx.D9cZUFTQ1HcJ04iwx17AoRDPJkn_FMR53bO7J3ikkg
 GYi_gz7Kf6OfYu55rNLiHPhtOY2pT678cf.R3hd7iefMw8qXdNBtXasmJXl0lUKeG73.vI7F2kKE
 Fi9iTaDjdkc9FXFhNpQwjq1NRy3xesbXpHWhbntdPR.rMOli7culvFOk_eFv4Qr9JjzaApzxsjnR
 rSbnC1j.XmGHwiiZmCI15zFlEyenfReR8VriHcRUbD52qJ7H4AouTixXlqC8ro_SobwrnbCqm21R
 tII_VzM8BT_Me49SLOjnzUnvEZAQKX9LQ3AqgwB94HMWEO0hZNpxvGq0DbZzBRwYlfAEPS8WRqIl
 OWUgHtX0dkgQpK1n68S3bE1wOpBOy6D1yU_bJykhtJ3WKvQvqV5X6NlGwD4iJlK0Cc5CC6xdkIpT
 1WSjUNZM_kFfoPecFeG6o68TnmoSEAR8n_yi3VbWzpky4Dsfty19gGBUgSyjzqThebpKimMS.IdZ
 WGoFIbcS8D0MO6cURzt7fXnStpJl4q0XoZ4p4gFO4zXdOISKfbOQxIzwAi3r7VLRNfuKAEK_YsY_
 0nJ1UjG7cBBi.reZ0i2X0Q8HygL548ufVvpM5IrwXhpj35Zc32qDU97P5lBEBYndWuau_GBmXDmy
 TgjIh0tvYNxIuJlQfam.9T4Qrl_DY8gEFPqkwAGttCY0E3A6wokS7V0JSeFrKiotwHbwAv4ylVBd
 u6EJBsZW3iaXZ994OrzHYfKHig_3bGExtAYeAWS0d.lVJbE_G_BCT4Lo7FMU1fiX7AANBaMN.qrw
 JOg8Z_uLSHPB1_1sZYoaEbJ._juNLjywfZI_vdaZorrc-
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.ne1.yahoo.com with HTTP; Sun, 5 Mar 2023 00:43:02 +0000
Received: by hermes--production-ne1-7688d778d7-vzmh7 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 4b8ae0134f60c74707d7cd3464201207;
          Sun, 05 Mar 2023 00:43:00 +0000 (UTC)
Message-ID: <b659481a-4f39-7dc5-8454-89f6cd32b02d@schaufler-ca.com>
Date:   Sat, 4 Mar 2023 16:42:59 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 13/28] security: Align inode_setattr hook definition with
 EVM
Content-Language: en-US
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>,
        viro@zeniv.linux.org.uk, chuck.lever@oracle.com,
        jlayton@kernel.org, zohar@linux.ibm.com, dmitry.kasatkin@gmail.com,
        paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
        dhowells@redhat.com, jarkko@kernel.org,
        stephen.smalley.work@gmail.com, eparis@parisplace.org,
        brauner@kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        selinux@vger.kernel.org, linux-kernel@vger.kernel.org,
        stefanb@linux.ibm.com, Roberto Sassu <roberto.sassu@huawei.com>,
        casey@schaufler-ca.com
References: <20230303181842.1087717-1-roberto.sassu@huaweicloud.com>
 <20230303181842.1087717-14-roberto.sassu@huaweicloud.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20230303181842.1087717-14-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.21221 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 3/3/2023 10:18 AM, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
>
> Add the idmap parameter to the definition, so that evm_inode_setattr() can
> be registered as this hook implementation.
>
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>

For the Smack bits:

Acked-by: Casey Schaufler <casey@schaufler-ca.com>

> ---
>  include/linux/lsm_hook_defs.h | 3 ++-
>  security/security.c           | 2 +-
>  security/selinux/hooks.c      | 3 ++-
>  security/smack/smack_lsm.c    | 4 +++-
>  4 files changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
> index 2e10945622a..4372a6b2632 100644
> --- a/include/linux/lsm_hook_defs.h
> +++ b/include/linux/lsm_hook_defs.h
> @@ -133,7 +133,8 @@ LSM_HOOK(int, 0, inode_readlink, struct dentry *dentry)
>  LSM_HOOK(int, 0, inode_follow_link, struct dentry *dentry, struct inode *inode,
>  	 bool rcu)
>  LSM_HOOK(int, 0, inode_permission, struct inode *inode, int mask)
> -LSM_HOOK(int, 0, inode_setattr, struct dentry *dentry, struct iattr *attr)
> +LSM_HOOK(int, 0, inode_setattr, struct mnt_idmap *idmap, struct dentry *dentry,
> +	 struct iattr *attr)
>  LSM_HOOK(int, 0, inode_getattr, const struct path *path)
>  LSM_HOOK(int, 0, inode_setxattr, struct mnt_idmap *idmap,
>  	 struct dentry *dentry, const char *name, const void *value,
> diff --git a/security/security.c b/security/security.c
> index df6714aa19d..f7fe252e9d3 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -2168,7 +2168,7 @@ int security_inode_setattr(struct mnt_idmap *idmap,
>  
>  	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
>  		return 0;
> -	ret = call_int_hook(inode_setattr, 0, dentry, attr);
> +	ret = call_int_hook(inode_setattr, 0, idmap, dentry, attr);
>  	if (ret)
>  		return ret;
>  	return evm_inode_setattr(idmap, dentry, attr);
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 3e4308dd336..b31ad6109b0 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -3104,7 +3104,8 @@ static int selinux_inode_permission(struct inode *inode, int mask)
>  	return rc;
>  }
>  
> -static int selinux_inode_setattr(struct dentry *dentry, struct iattr *iattr)
> +static int selinux_inode_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
> +				 struct iattr *iattr)
>  {
>  	const struct cred *cred = current_cred();
>  	struct inode *inode = d_backing_inode(dentry);
> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> index 598b398c62e..09cfd3c31dc 100644
> --- a/security/smack/smack_lsm.c
> +++ b/security/smack/smack_lsm.c
> @@ -1173,12 +1173,14 @@ static int smack_inode_permission(struct inode *inode, int mask)
>  
>  /**
>   * smack_inode_setattr - Smack check for setting attributes
> + * @idmap: idmap of the mount
>   * @dentry: the object
>   * @iattr: for the force flag
>   *
>   * Returns 0 if access is permitted, an error code otherwise
>   */
> -static int smack_inode_setattr(struct dentry *dentry, struct iattr *iattr)
> +static int smack_inode_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
> +			       struct iattr *iattr)
>  {
>  	struct smk_audit_info ad;
>  	int rc;
