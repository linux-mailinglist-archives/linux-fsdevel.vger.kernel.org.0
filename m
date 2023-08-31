Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3014378F58C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Sep 2023 00:35:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345983AbjHaWfv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 31 Aug 2023 18:35:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231271AbjHaWft (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 31 Aug 2023 18:35:49 -0400
Received: from sonic311-30.consmr.mail.ne1.yahoo.com (sonic311-30.consmr.mail.ne1.yahoo.com [66.163.188.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42500E66
        for <linux-fsdevel@vger.kernel.org>; Thu, 31 Aug 2023 15:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1693521339; bh=cH3RUuazZiO0DLttmnoHQUB/etzY50Gjb0VyP9sDJKY=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=euAUybG7+MmSGWj2ufbEhDywTfRPgU2f5tIm8J2dpgvmWXpwTUQY8op2FQwGMmqRJDDglXPx7+/rZekuyA/EOQ2ZiRItQikDrw1LUX8Vs+8pJj0rsYjpVMgVbtBylpjgfq4oisSzCu0W6AnkPshn2JwMUwr4CLVC52ssLVXelSED0UjRBMVt9ho23kyo0UPUpkq/uP3CthC2UoU+O0I6dHlVY7yVm2PrGtUr0gf2Dn9vHBUtH64Pt433fHQsu1M4+YjFUXuwLu+Cc7KnwamN7d91b1HzXg8LiybXfATaYHy0feF/FMXn2yrXYujUvdl49klc8bN8cTVKRxmsPrGfXQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1693521339; bh=Ftm/U9+eeSjpXCSU56mK8EDq6eBnDOPrb7DmDGx2mos=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=Odv+3eEYzkfCsi5OHiDcp9rRPpOsGAuLVCfk7iJihvP4Kfq7UJnjkJQ2Wn8XrhTnsdbW8dfzyA1Ra4IlWBXP583y2RDqQV6I4UJrYCiK7qMwTC68YI6jS3tzejEDl30x91fiP2uSs5mWoGFvJWObUDvHXEKuUANQxGthynB5ZIRMDj0Msg7sut7v+V936abG+QNJNgEAC0qJkC94MoO3RbiptlofqzZTN31U0oczdftBGoez/0OIw12nO0xxb8WIgV3ul9mnrwRa6mxYeNeQz/tbRPiUcRk1zvbOG4Fvg50bu+36Ca02K+6RjNcAAGhywClqPszV0LAnW9oUvQ3AUQ==
X-YMail-OSG: Y86W7ssVM1n7f15tjvS8PN1X7msRLkbh0vpA0S.LLtJCtVRtJw3v5PsA9945CXw
 Tem_9OeHPcHvd7fw.l5ohM.VcZQeyXmSSj.nR9u_1awDB8MVuFxlsT0TVadEwtNAHYlCy6I.AsMe
 55KCsWll7ob.ywNffxXJ8.XznUEbA0btBCn68jsc1xopYoOEqwfoFGuvPDbvtnMjNETwomkqOpTm
 rwr0ckuTfB4dyDh7zkwRWfBPOdm79Xu4CZjR2r09Vi61s0zfRbFSmhfHI0u0iQySdKFn2BjFC.mx
 2e3hYcmHwc5POJ1KL.kzN9zoEf.SEgKtw2Wn8ilbSzuRwG_31NKM.t2aEhnJA_PwZjyUuYlBmxF4
 uHFcg67_05xCo7BIZfT.1nGh2mCwuiEM2MKivXgcQpuUJQfn_rJ4KlmXLMqvbuS8C5ropJwKLVIp
 7AVf9JKc_sSeLl9uKzGn3nvyC_n5mt0lFqWYj011dBsfm5tGJ0Mg4JVUkqETuSuv2VYaDgDqJSn4
 pDZuL0kxonzuxEWq_YxtKXwUGxk6OenJgKcyb5NziC1cPlkyOIdrJB8AWoqL3eqE5OVa_mOpKp71
 B4DxjxswTs030URXxQL7p2l._ne3tLjS0OrK0tNiWBQMDPAuT1MSP4TbnzI_hpuynrbPTGDfX.6W
 VdZHDfIru8cZZkm8Ql2Gf6XIKW3E0JmLcPCYKO7ew2.2B4vpc3W4gih.G.e24OGzS5AWa852tlX0
 .4bVEcs6uMLpu0CAdDBC1aQbW_HbIr3eAP5GunUw4jiW.RcIjdleBIkYhgkfXKY7H.NfICJhqxMz
 9o3jCsj6Q0o_A2GyrJZ45x8tjogji2fy6b3G0TjnEPnIskham_cMgtnMS9MDHOODM0H9MmCoY4_S
 3uo0bF80vQwpbHH6UNVnWN5bkwK62jds8laaVrNSVI3oXsRjhDpUc1uezY5kejfuJ.KOj9zvd5lN
 bZNFj5IsyPRiwNOGBN0O8vqzLO4MOfkHeN56DgRrLXxQsfVPOSIglSW_LL2OPRBYCTUhCr1omtU_
 066RvvfzOhsZyxTWuK6uJwWvJLFew7xZSdcfJJDrnfY9DqYeKB3lIhnIKKShdWPd62wrNSeh6EY2
 X5q9xtqyskOQ8fOwLNhI1KKcKA9lWHbfrVlnZLiTM4CTf1WoL_EYMQQXy1Pql6GmI1_4qVjdrQPl
 DFlyPcOJWfBBXnX6Xwfy.DUA.cYryEhDAetUGdsMModMMwPH1mIrKJEYNR5YrMxCtPMLaC3rGAaD
 WtpI0NUwxBQWe.GoLcSQfX_sixH9sjrM8AM_mISD5XRiYccEqc3Ji9euC8ferVfk8ONJhQbRYSF3
 5ezm0terKuSX5PsuWCzCzFkEdL8NeGy.LQDwiaIJ6NR9GF6kVoFD6imNcbJugcUeHiRzj93zI1c_
 8zzZq8w68FH48KT9tIsbWRfUxqO_ahDIpSzrnpjaNZth4scNcQa5nI9rwsMRCBH_ovpM_T9vfiJp
 UfxXGF0EMUmsy5o1IVLv2qcD.Y9gH4tLa.k_7CL5LCwWuTYJ7psEBxK17jMTU2ed6XZa3QMHPHSW
 jomnnadki5kJkulYY2KOG.wTnjacqwQhIPYObvWwD4T.lmigtmyK8kXSiQDJvNrRbSRrIorjai2k
 HCI_1c.fuQIKW5mQZKnRqvp1r2UvYTPKKvVK3kUhID5Z9hgR5aqaB1s3qTMxTsv02j56BKqniGib
 wUk7X21NrTyizmrWrj.saJoN7Ymi2900WRuWZFi9ElHTh4TvOBo.6mT7VXXpsyyIvJ612j2B7eX_
 AtG5p_a_9_ACqdgCsmbkhJlE8FHZkj8Qs6VCjtlKLCK6M35YohfO5A_6Tnfjy9bS8tWscmnrjEw7
 HHUrbeOx3EVQUtilnoE6fVj2dtunBv7nW07tMEtp5MRIuMipro9XClGUSAX6NrUhs.lcdULsw9Fg
 tcwWC4geyGh_H1RdsPDFc3BJ57q42zSDvTvf6cFUtZNqnxP.GZGMlt_Myxw.p7KwiFGLJWz.ePiz
 ktX3Fb3BpkqUinjneHLzXV7WW4sAwJ1MxvhPQR1bQnBJjLB1K4Sr16lzGrVEluncSomItmSAVgRQ
 K5j1LK1XPSFowLMV8vRKvsuz1opp1doP8SxMu4sTn0XNKuFWOgIYJeOhy7QFIMPcXrXIzAT5Cv0P
 zwKDlBuG8SR9xO5Dt5onB.CbM0QvdeQJIaocFWSrn2szuF5WnRYB7jdUsRJlnwKWtNTrkUD3.iSr
 E0KpDQFL3C7sb6JokvF_c6SP8LMbnexBBe4CY45Li9xhKUmry_SHucWlZwbZ2ODpOfzFAbiO20LW
 G
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 4af33dee-e9e3-4bd9-a701-7875bbc650fb
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Thu, 31 Aug 2023 22:35:39 +0000
Received: by hermes--production-bf1-865889d799-5m62n (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID a04c43917fa64fd9ee76e27396465a3e;
          Thu, 31 Aug 2023 22:35:35 +0000 (UTC)
Message-ID: <0da757b6-d3a9-f030-57d7-3f9dc77ca7ae@schaufler-ca.com>
Date:   Thu, 31 Aug 2023 15:35:30 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v2 17/25] security: Introduce inode_post_create_tmpfile
 hook
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
 <20230831104136.903180-18-roberto.sassu@huaweicloud.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20230831104136.903180-18-roberto.sassu@huaweicloud.com>
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
> the inode_post_create_tmpfile hook.

Repeat of new LSM hook general comment:
Would you please include some explanation of how an LSM would use this hook?
You might start with a description of how it is used in IMA/EVM, and why that
could be generally useful.


>
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
> ---
>  fs/namei.c                    |  1 +
>  include/linux/lsm_hook_defs.h |  2 ++
>  include/linux/security.h      |  8 ++++++++
>  security/security.c           | 18 ++++++++++++++++++
>  4 files changed, 29 insertions(+)
>
> diff --git a/fs/namei.c b/fs/namei.c
> index c8c4ab26b52a..efed0e1e93f5 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -3700,6 +3700,7 @@ static int vfs_tmpfile(struct mnt_idmap *idmap,
>  		inode->i_state |= I_LINKABLE;
>  		spin_unlock(&inode->i_lock);
>  	}
> +	security_inode_post_create_tmpfile(idmap, dir, file, mode);
>  	ima_post_create_tmpfile(idmap, dir, file, mode);
>  	return 0;
>  }
> diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
> index b1634b5de98c..9ae573b83737 100644
> --- a/include/linux/lsm_hook_defs.h
> +++ b/include/linux/lsm_hook_defs.h
> @@ -121,6 +121,8 @@ LSM_HOOK(int, 0, inode_init_security_anon, struct inode *inode,
>  	 const struct qstr *name, const struct inode *context_inode)
>  LSM_HOOK(int, 0, inode_create, struct inode *dir, struct dentry *dentry,
>  	 umode_t mode)
> +LSM_HOOK(void, LSM_RET_VOID, inode_post_create_tmpfile, struct mnt_idmap *idmap,
> +	 struct inode *dir, struct file *file, umode_t mode)
>  LSM_HOOK(int, 0, inode_link, struct dentry *old_dentry, struct inode *dir,
>  	 struct dentry *new_dentry)
>  LSM_HOOK(int, 0, inode_unlink, struct inode *dir, struct dentry *dentry)
> diff --git a/include/linux/security.h b/include/linux/security.h
> index f210bd66e939..5f296761883f 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -338,6 +338,9 @@ int security_inode_init_security_anon(struct inode *inode,
>  				      const struct qstr *name,
>  				      const struct inode *context_inode);
>  int security_inode_create(struct inode *dir, struct dentry *dentry, umode_t mode);
> +void security_inode_post_create_tmpfile(struct mnt_idmap *idmap,
> +					struct inode *dir, struct file *file,
> +					umode_t mode);
>  int security_inode_link(struct dentry *old_dentry, struct inode *dir,
>  			 struct dentry *new_dentry);
>  int security_inode_unlink(struct inode *dir, struct dentry *dentry);
> @@ -788,6 +791,11 @@ static inline int security_inode_create(struct inode *dir,
>  	return 0;
>  }
>  
> +static inline void
> +security_inode_post_create_tmpfile(struct mnt_idmap *idmap, struct inode *dir,
> +				   struct file *file, umode_t mode)
> +{ }
> +
>  static inline int security_inode_link(struct dentry *old_dentry,
>  				       struct inode *dir,
>  				       struct dentry *new_dentry)
> diff --git a/security/security.c b/security/security.c
> index 56c1c1e66fd1..e5acb11f6ebd 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -1920,6 +1920,24 @@ int security_inode_create(struct inode *dir, struct dentry *dentry,
>  }
>  EXPORT_SYMBOL_GPL(security_inode_create);
>  
> +/**
> + * security_inode_post_create_tmpfile() - Update inode security field after creation of tmpfile
> + * @idmap: idmap of the mount
> + * @dir: the inode of the base directory
> + * @file: file descriptor of the new tmpfile
> + * @mode: the mode of the new tmpfile
> + *
> + * Update inode security field after a tmpfile has been created.
> + */
> +void security_inode_post_create_tmpfile(struct mnt_idmap *idmap,
> +					struct inode *dir,
> +					struct file *file, umode_t mode)
> +{
> +	if (unlikely(IS_PRIVATE(dir)))
> +		return;
> +	call_void_hook(inode_post_create_tmpfile, idmap, dir, file, mode);
> +}
> +
>  /**
>   * security_inode_link() - Check if creating a hard link is allowed
>   * @old_dentry: existing file
