Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F245B59C1BB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Aug 2022 16:38:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235393AbiHVOiN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Aug 2022 10:38:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233846AbiHVOiM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Aug 2022 10:38:12 -0400
Received: from sonic309-26.consmr.mail.ne1.yahoo.com (sonic309-26.consmr.mail.ne1.yahoo.com [66.163.184.152])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD0F12A256
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Aug 2022 07:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1661179090; bh=WsipJuAml6UdlCPh/Xk6akfSdQq5jBRM6G0AqL1GFXI=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=d9t7ePhuYUCWb407WFPhGB2Mq3aqORZKd36qOe8HEk1dCyBVOjxp2T+QomBhWZNiFhE0PD1dJfRBJ7Wz3/6Asv1ad3YxNO4wEdUgfa0+JYd+Yk1W88PPYJJnX3OkyPMf3vtMunaAu7xjOhy6inZ/ZrQVdpZLidaocbprdLBeWYLjUVyzfMj51UBB7MTU3yA7knVe3d6LBvdlmGWY6GyHjBgzS7YRvTWx4gKlf8lpl4nz518NdfE955gmKMkpMbUjcUmZi8CAJqzKJ5qYT79iJ3m7AivRjojmaisdQwp0v3gw6qCs1UwqMwPyv0lxzESkzTBxRw7B9UZO+ZRhdPl0sw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1661179090; bh=VuTMeEXfA6SPOWlEQTJv6dBRuXm7vVlWF2kjQDuu86Q=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=ITGN7eB2wxCLVW3oPB6R9I7VKN4TXrAUgvSBlFMOotox+aLTqAVbqDHUi321G9RKJqeJfEFenbsGQWa51T2Tg/eJIpOjDviVualcVJ4dU0lGuxU2ALOtvXsx7jJpZDYOfjFYcUReRAEFB5SYIu7q6+7XNiLgPtI/yLRCY4WLP5AktwZ7fOmr6e+Tc0wDicXzWbmbRoCgGlfX4TnSPss1PdnD54SzWbI9bPPCr7c5HDHCvgYfG7jMQI8EtqwFLhBbhOY9S3nx8SSBxHoXOBbGCr0DagUi1Ar6p90WAIkf3AlpyRoxJu2D3w5WM0GtBm8WVNIFmZ4iNwcvpIAX0Vtk/A==
X-YMail-OSG: neKmUncVM1munL3YUrvFGYRCEzQRucneCm7CTfo0.hHJ3H58Zo8uohDrSEhb954
 16kMIoYgqNn5Hc0Qy2BryEnHvk_vpeHUz.dJ9a6zl3db_b39nsCYs9kD3Rp0jLIW9rfZSkEAj_sj
 Ty23ftVps_WVNF04uBMSoqMAmWCuIzQci3c6Hrku0_s9PYxX_CewoiYgvqpWOCIR_4zVal3UqyKD
 8k4PewNi3rW3zaGBwomzN3AJBE9wJb3qqZZj4tHFpNMXzPitq9cnVuN_8nMCptl51Ig1_tPa5ofK
 snZaCFv_8cn1R9Zicpxfiq4G3VhpKdeMRhSnxVCMwAYBY65GqgtO9wlAHa8kjaSzWZYpl7Z9FsXN
 YRJXszYw8lSxe4_cK1W_RPBb4yqZYN7fUs7oR7IkMokXiMbGOCFE8uL9Qp7ysV5P4uSGFZ.4JRc_
 fj0yrznGJw823IxEJQPAvxmJc3SfZjbNUn5w00ZbC9RLp_hZkl64SkDLtdVDgKez7.rhVKfPSsiT
 G4Dm8HTxCp5PXo3S8DR2lq5fTKXnAN09ADliCGN5zKtBjVLuTTx5OLyaFF1zj2Me8WCd_TGBI1rY
 qKs22rXvchahuBQ_fkZhIOhqFIH05gwkUDWrsJdQkvrb0s2ZvYFhRxhTiygRyQEpEDBspwYmZGXm
 OENe2eubcBF8vZoa3LyXRJGoTok3OFG7P_tDyuUev5pQlaf41Sott566eo19WZ5Lbf3zY7.Qj_au
 .TL1t5thOWKmpMFs.fLJsO7T2JlkiOLnsUxiWGrMOEojAqIo1FsTnUszt3WWdJNC2FYEXRaZ4mnE
 3TTnBV7ANcJuG8cc7TwC23k.3wbVK0auT2bwGff9HLd2FQIkRNZ8Or6L9cHdgrALaW84YHb.6ih1
 .VEhWJ.Dv_K3CDA1iw5MmMgFIgi8N_arp8KByFMySrf6P6mqyOnJhkm2padOp6uxr2L0zMudUONu
 3cb2giyh427Hv.D2abTXjN5hHorG2_WIkA7yyW_XaesfDvVePOcWBxV5KIn9x7S1bPVuvBnvKgJJ
 QZib1PDXRSQz.1jyRKazH6DmGweohlIspPgVXlzaJURmptuOnK70i6H2_1d2__4SiNhdYcjj2Zlf
 gH.9W8n7_UHe1VrUcgngPw_NtLbhym0ivzhoIyfSF8UQ6JT2MoJKEdfX3RZdhUACv6JTKLmUr36S
 fPHSQP03ii1fIX9hyI4HCfBlQT2ojz0g2SyAi.GinQgRe4xMp4EmIBClvxHqU3oNusW7B7UI0VIP
 PUe0CwnYFPBiAjTmVP6S0QFBbNpmboKSatty6keoIAEPNnVuJh04Y5FZEBPyJA5QxGu1rhZThgEA
 kHjNnGGbAHO0vOrjIYLk7ViFT8EuTNsuCwqCqymmI54UL.AB.rrPUp4IlWY5aEE5ln89ox3wS5s1
 4yCVPbgBWVTmeZOVoMlFOcetPIO_efBvz_lKyd_MIrlYdsYTaDSA3B_SO8mbL00KYHPORLBfMs_E
 j0U6lRSqaZVwMStubcZ_H6ZZ5RQdIZmuOpSw7Q6kuhzFPKRUsqCbeSTcECroIl2twmlzjx113iZX
 TeIBNz7Bb6hfc41HgAGw7K2K9fCh.q2VaJklaycx81YWM06iUuHgtUxk1uDhTWmiToGh8ro8VxXO
 CqK0qOkpkpADs6ZSzMm1b3lbW9luoqdN56Of1sXMPmMOxOQhZ8kfWz25dIzprqAm7n5Ab4A_V0OH
 xHGdYPHEBCoIkmWe7KM0dxOt7HJutYnovmCLIj_jfdjrH1J80hGT.0W0ogbnl8athDHlsgMde7QY
 iiGYRVQ.vxHWvjKoIT9oxIFo7Okju0JieWVuA4c7CfRt.9Da_ergX9ZZfRRCTWlTPOGgpXQCR8k3
 p_gel1NETIuMCn.j1AnFnC8c4P5caUZsHMlURJYbJhNdSFWsjxRLlgHCkz6pyFMA1n7bczfOkqUq
 ggBA5nl.23D8JvjVXkJk9sD8IjVkUC39h8m07xXjzJ5UZAH1l97oe7Mjbnhw08MfU4_ZCAKMd_EV
 5lECS.D3KSsF0xtwedPQUKYAsbMisM.AgsjSpg0BoKooTyEBpURkVgjtepApZa8kUeOLbcNWCOHf
 BKFTffJT.LGNqwsBbkAKVEogEGpoGT6RFBcyes.QSH66Xjr._GFGSlWnJCXftnmEhtoMhyfYXpa_
 kzFs295Eobxh1jelMCywhEAGAa2wOqA__SCE_2R4B3PCnI8RwC5CaUDTqYBA_QB5W2n2JDAO4LJx
 xv5b77gOcyXrifxUG460OaBgtNa8_pcZqnXEQAw--
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.ne1.yahoo.com with HTTP; Mon, 22 Aug 2022 14:38:10 +0000
Received: by hermes--production-ne1-6649c47445-ptfbb (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 647d85add8f566901aeb89f00a3545b4;
          Mon, 22 Aug 2022 14:38:05 +0000 (UTC)
Message-ID: <80ac4695-e0bc-3ead-fa36-c705d7527866@schaufler-ca.com>
Date:   Mon, 22 Aug 2022 07:38:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: Subject: [PATCH 01/11] ->getprocattr(): attribute name is const
 char *, TYVM...
Content-Language: en-US
To:     Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
Cc:     linux-security-module@vger.kernel.org, casey@schaufler-ca.com
References: <YwEjnoTgi7K6iijN@ZenIV> <YwEjy6vaFHEVPwlz@ZenIV>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <YwEjy6vaFHEVPwlz@ZenIV>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.20560 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/20/2022 11:11 AM, Al Viro wrote:
> cast of ->d_name.name to char * is completely wrong - nothing is
> allowed to modify its contents.
>
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

Acked-by: Casey Schaufler <casey@schaufler-ca.com>

Thank you for the fix. Please feel free to submit this
directly.

> ---
>  fs/proc/base.c                | 2 +-
>  include/linux/lsm_hook_defs.h | 2 +-
>  include/linux/security.h      | 4 ++--
>  security/apparmor/lsm.c       | 2 +-
>  security/security.c           | 4 ++--
>  security/selinux/hooks.c      | 2 +-
>  security/smack/smack_lsm.c    | 2 +-
>  7 files changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/fs/proc/base.c b/fs/proc/base.c
> index 93f7e3d971e4..e347b8ce140c 100644
> --- a/fs/proc/base.c
> +++ b/fs/proc/base.c
> @@ -2728,7 +2728,7 @@ static ssize_t proc_pid_attr_read(struct file * file, char __user * buf,
>  		return -ESRCH;
>  
>  	length = security_getprocattr(task, PROC_I(inode)->op.lsm,
> -				      (char*)file->f_path.dentry->d_name.name,
> +				      file->f_path.dentry->d_name.name,
>  				      &p);
>  	put_task_struct(task);
>  	if (length > 0)
> diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
> index 806448173033..03360d27bedf 100644
> --- a/include/linux/lsm_hook_defs.h
> +++ b/include/linux/lsm_hook_defs.h
> @@ -253,7 +253,7 @@ LSM_HOOK(int, 0, sem_semop, struct kern_ipc_perm *perm, struct sembuf *sops,
>  LSM_HOOK(int, 0, netlink_send, struct sock *sk, struct sk_buff *skb)
>  LSM_HOOK(void, LSM_RET_VOID, d_instantiate, struct dentry *dentry,
>  	 struct inode *inode)
> -LSM_HOOK(int, -EINVAL, getprocattr, struct task_struct *p, char *name,
> +LSM_HOOK(int, -EINVAL, getprocattr, struct task_struct *p, const char *name,
>  	 char **value)
>  LSM_HOOK(int, -EINVAL, setprocattr, const char *name, void *value, size_t size)
>  LSM_HOOK(int, 0, ismaclabel, const char *name)
> diff --git a/include/linux/security.h b/include/linux/security.h
> index 1bc362cb413f..93488c01d9bd 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -461,7 +461,7 @@ int security_sem_semctl(struct kern_ipc_perm *sma, int cmd);
>  int security_sem_semop(struct kern_ipc_perm *sma, struct sembuf *sops,
>  			unsigned nsops, int alter);
>  void security_d_instantiate(struct dentry *dentry, struct inode *inode);
> -int security_getprocattr(struct task_struct *p, const char *lsm, char *name,
> +int security_getprocattr(struct task_struct *p, const char *lsm, const char *name,
>  			 char **value);
>  int security_setprocattr(const char *lsm, const char *name, void *value,
>  			 size_t size);
> @@ -1301,7 +1301,7 @@ static inline void security_d_instantiate(struct dentry *dentry,
>  { }
>  
>  static inline int security_getprocattr(struct task_struct *p, const char *lsm,
> -				       char *name, char **value)
> +				       const char *name, char **value)
>  {
>  	return -EINVAL;
>  }
> diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
> index e29cade7b662..f56070270c69 100644
> --- a/security/apparmor/lsm.c
> +++ b/security/apparmor/lsm.c
> @@ -614,7 +614,7 @@ static int apparmor_sb_pivotroot(const struct path *old_path,
>  	return error;
>  }
>  
> -static int apparmor_getprocattr(struct task_struct *task, char *name,
> +static int apparmor_getprocattr(struct task_struct *task, const char *name,
>  				char **value)
>  {
>  	int error = -ENOENT;
> diff --git a/security/security.c b/security/security.c
> index 14d30fec8a00..d8227531e2fd 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -2057,8 +2057,8 @@ void security_d_instantiate(struct dentry *dentry, struct inode *inode)
>  }
>  EXPORT_SYMBOL(security_d_instantiate);
>  
> -int security_getprocattr(struct task_struct *p, const char *lsm, char *name,
> -				char **value)
> +int security_getprocattr(struct task_struct *p, const char *lsm,
> +			 const char *name, char **value)
>  {
>  	struct security_hook_list *hp;
>  
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 79573504783b..c8168d19fb96 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -6327,7 +6327,7 @@ static void selinux_d_instantiate(struct dentry *dentry, struct inode *inode)
>  }
>  
>  static int selinux_getprocattr(struct task_struct *p,
> -			       char *name, char **value)
> +			       const char *name, char **value)
>  {
>  	const struct task_security_struct *__tsec;
>  	u32 sid;
> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> index 001831458fa2..434b348d8fcd 100644
> --- a/security/smack/smack_lsm.c
> +++ b/security/smack/smack_lsm.c
> @@ -3479,7 +3479,7 @@ static void smack_d_instantiate(struct dentry *opt_dentry, struct inode *inode)
>   *
>   * Returns the length of the smack label or an error code
>   */
> -static int smack_getprocattr(struct task_struct *p, char *name, char **value)
> +static int smack_getprocattr(struct task_struct *p, const char *name, char **value)
>  {
>  	struct smack_known *skp = smk_of_task_struct_obj(p);
>  	char *cp;
