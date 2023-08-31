Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AAE078F583
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Sep 2023 00:35:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347717AbjHaWfX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 31 Aug 2023 18:35:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234503AbjHaWfW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 31 Aug 2023 18:35:22 -0400
Received: from sonic310-31.consmr.mail.ne1.yahoo.com (sonic310-31.consmr.mail.ne1.yahoo.com [66.163.186.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8301610E0
        for <linux-fsdevel@vger.kernel.org>; Thu, 31 Aug 2023 15:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1693521307; bh=qpx/1Omnbfariy9MJRObP7itGpAn07JmCl6VBnj3SQQ=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=dBtdo8XNJ/HUEHXJj7Plv+fHE58e4nvGNr06Ck5P4UQo/3dBM2Vc3KaPqi+cGeC9Qy+ZrgRv40u/2CJ8i1JgK9lRQr4RpRCCeGB8uRBhYcQ0LgwMdW4YF5XPqQ2hnK+otC5tYoEAdBEwex8/gJw/fJ/ILdLu9Or2eV/z4xrWGzoiL2t/1lwKwicGqiPfR2flFZaEhub/dsTHCXVg95ReMqp8OnhS3eWpWJ/UYKovVDBqWuAxPc6TB5jMVQQZuEJR+l3pIZUQ9PtROXmGZe/BIlW7Nt+wV9B4LmZ3UdEaAynDnTW+Ubno2AUbhkrnt1IcoJOG1y6iL8Cl26m+4Md0xw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1693521307; bh=hAVJrE0VbDBCUwaPGUfL6Nw1TqdxpwD3iuvHUtPHtRh=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=SXNqbbg0sYZMh0M20Qdgc5zNiFltCsNdw5QX3xc21JntdNPh++SJez+vf84RwV2MRVEe0t16O4sedVvLTzrfL44j1CkySTy6bM+r77lCkmFgTiIbKtTwLH0PwpIsO6YsyvPToSwwRjE+gKT0wH5Jh67SAJVx7hnBofnpQ32eyQiHyEBXYiSOgFUA8jMwzmJi/I67L3q0YotkeLFAiu/VT3z1wglQQ65no3rhVxppQHEf4daxbBiKKD0vuYueTyryxn7FQ8bwQGD+lwcQMg6za3uQvMJlB1qvSiatMKZBU6RRsfL+dEmDcog/xHGVGrcdjHkg+F95biyckputzFrX7g==
X-YMail-OSG: eFLT.XYVM1ntK1HCxBpF_32zmKlZUf45fM7lMrOPV0rUykqN78MU1yDR8h4XysC
 9WxR5EVjbYOGcG37kx6gujmR1EADd4KAC71FVIRG77DABTvZnO60KdVHNwgs1ex5IHsGcL9BIJDw
 kSDQwBfxPCuZmhoR3mtqr0was9KWL6e7vu22eMX1nC7Qs6VrlzX2y_Vz53oDdJ8Z8RA08K.MAHR6
 PoJ3f7EbGDwr6fKcomG9qW02uKhbO4KdJHzBshC.4vXYpDSxb3frzAT6qEy82_NKFNvf2wseFmr5
 t4pegviuU5wdq1CUcv.Lm13q01ANNFSJgZ0N5m.ywRegiDdfbyxdtk2R9fdDAQNuTFCPo2wipkRZ
 zi2KUv96D6u6g9MgSg2fLCEi596MPBzsKPFuUJ_D1ty89Crq8KpkQsCKTyEQFqQuWgIDKfYRV63M
 LuS4V5v.jzIX4B6bfcBMwz6a8J5mFQqg6wyKFOKzRA.V_sopIlIa8ZvTjwY.GlMXGtSZ20dmZKKo
 lcrb3swwChBoCww9.emPtf96OxiTmKvQFMyQiSkuwAhTSghLHVCPOC8n.GQW14rvr_Cu36xhM4bA
 iB73KoybctE2ClreGMm4l5btEATK4WoaITNNDOu45m14yTBc_YyzvR0JAIVsjlCx7R0bY7.Ynx7p
 Tm50roDWtg5YLZKZONIVbEBNmiVM4VWdSsLRs_Mg74YxjW5wfVfDGmGjtocYTpT8tXgqjSrMBKN6
 WAInz.NUeFqkLsnFgtxxcgiDYERbI8ig8F7Xjrjw9_JfvQqwYlSwALSA3M.9duEFlgcuUwCwWp8T
 MkvjqYxAOBOmHv2HxZEIhpbuT9DEPlsuLbSftRKh253S9r1ReVjMEomltoQjTFr_6oqLQwdYBKa0
 kmg3ps8cH1RQqgEiFkUyOlELeV_wABxnVViM83HfIfX9Z9E29lHuwHsljcxrVQAgz2dLp1dLQDcy
 7NczZwuHH3HKwKyNUg5uaxomCBr5TUYMaXEaeu9SOAxew4w9umbyeYx9SmtNJANomVS5jtHquw.U
 5ewhnyzx5bshQIsdhV1rh_JcOprVh4Jg4.6PWmiBfezCVwV09tsLdb63S5aWAFw54f.TnUWSa9r_
 t4jWJuqAgLLxWgnamB0UWDE.VPI26fhf1EGJvQYz.G0rv47Yu24.1wbVUBaA.yxWaO.3pD5NboCX
 d6Nny5JGtU7QiAi9EjAHIhDF4bJPd0UYXeAkqq6QTWAHTEfjgfkM1F.70XlTexe8_8G5bJMgv6R_
 LgCS0.1ZsLwIq.3dt4Lafsx60A_Y_wCHkThWXlugPyDnzxJM_Ex8zg.JdVqRB_ZGx_A.isyLkjjK
 0nOt.c3n9Sy6ZGg2wb2TDBaEot4wYbXIOaPUtYavyApNEiTV9dnla04rz0LUvaAr3x99yTY2iu9Z
 t3ynODcqozbRFmie.kIsrCZQRO86hEF12m73SHazA8zb5gD_eftOAqTXNcOyWeIIeJYAS1c_qjHh
 XZe.c4TI_ZQInk48R_9zhmBz3tsUNAi_ZPqn.MA8xiiiTXeZoQRfvJNfrrlx9EBnBNeWDPI8k.Ma
 1OmQsuCK2EHayy.xic6lGML39Kb3Th_iYql0mI862mc00mrIDLaEsWGWl0mRLWJ01L9VpDuCSyti
 9o0QY4EO2pO3fVrXMMleLJclRWu9p_.zSvH0iSUlVAACpUFG4Eax_tMlLQD4db4zIW8Hxt86c.Nv
 qdMjbt84oZe8bc_Azj3uxaV_3926FGmeVrHSa5_QYA.C.ugtxHeAZoCD2LDmj_ZUSCDXMBWOoD2C
 7B1r8HWAM4S6NIDEF5hsericUhRZztMGHsInJOkYZ5igzIXoZ9gl.7mii.PpQYY7G9fCezmPt9CE
 cj53PK3a_Vunmt6nfsIjDdSiLXWJoQj8jyA9KS8pNukPzwMcK6Fr3XZlZbadyx_2Fe6Mvois_Epl
 clhXew_cDf09uJkTOQXgppu.UQu9rDJczRTwNHe5hDEuoqrIqFvWUyLdTpiHurpa_hHDuwx0zBZ8
 RsPEbNa8ubaaNyvKFDSV1.NIL2h5YbncPCfO1Q5qxosoITUVFf2VFNIAFX6JePr2iHuHwS5BKbEf
 jRNkyZQJhO6lPjFyMwnzAc1a8TTaqtVRGAwAQEbBeDy653d.5yENPE41urib3sYYYC3p.Du6XTcD
 ssOWtB1xuYuFDXj5wJeSwyPdomIf1Vh6h0L67Soer4p1.tOhKIgazrqPyvGPmnvbc6nv1cLIjY_L
 q.NsMbNa4bpS40DWHbD_3k0xknJEOmcldpjyFaqZPAm3UfAxocsKJoyBqwVPQ0NrhjfpCW1.mmw-
 -
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 1bcd2e94-c8a6-4e8c-9c66-9b32ce2eeca6
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.ne1.yahoo.com with HTTP; Thu, 31 Aug 2023 22:35:07 +0000
Received: by hermes--production-bf1-865889d799-7vf9r (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 0441e8015fea2030200b5cbbcdf0bbec;
          Thu, 31 Aug 2023 22:35:04 +0000 (UTC)
Message-ID: <421af0a0-5200-3ac0-f4e8-365596d90317@schaufler-ca.com>
Date:   Thu, 31 Aug 2023 15:34:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v2 16/25] security: Introduce path_post_mknod hook
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
        Casey Schaufler <casey@schaufler-ca.com>
References: <20230831104136.903180-1-roberto.sassu@huaweicloud.com>
 <20230831104136.903180-17-roberto.sassu@huaweicloud.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20230831104136.903180-17-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.21763 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/31/2023 3:41 AM, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
>
> In preparation for moving IMA and EVM to the LSM infrastructure, introduce
> the path_post_mknod hook.

Repeat of new LSM hook general comment:
Would you please include some explanation of how an LSM would use this hook?
You might start with a description of how it is used in IMA/EVM, and why that
could be generally useful.


>
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> ---
>  fs/namei.c                    |  5 +++++
>  include/linux/lsm_hook_defs.h |  3 +++
>  include/linux/security.h      |  9 +++++++++
>  security/security.c           | 19 +++++++++++++++++++
>  4 files changed, 36 insertions(+)
>
> diff --git a/fs/namei.c b/fs/namei.c
> index 7dc4626859f0..c8c4ab26b52a 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -4061,6 +4061,11 @@ static int do_mknodat(int dfd, struct filename *name, umode_t mode,
>  					  dentry, mode, 0);
>  			break;
>  	}
> +
> +	if (error)
> +		goto out2;
> +
> +	security_path_post_mknod(idmap, &path, dentry, mode_stripped, dev);
>  out2:
>  	done_path_create(&path, dentry);
>  	if (retry_estale(error, lookup_flags)) {
> diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
> index 797f51da3f7d..b1634b5de98c 100644
> --- a/include/linux/lsm_hook_defs.h
> +++ b/include/linux/lsm_hook_defs.h
> @@ -93,6 +93,9 @@ LSM_HOOK(int, 0, path_mkdir, const struct path *dir, struct dentry *dentry,
>  LSM_HOOK(int, 0, path_rmdir, const struct path *dir, struct dentry *dentry)
>  LSM_HOOK(int, 0, path_mknod, const struct path *dir, struct dentry *dentry,
>  	 umode_t mode, unsigned int dev)
> +LSM_HOOK(void, LSM_RET_VOID, path_post_mknod, struct mnt_idmap *idmap,
> +	 const struct path *dir, struct dentry *dentry, umode_t mode,
> +	 unsigned int dev)
>  LSM_HOOK(int, 0, path_truncate, const struct path *path)
>  LSM_HOOK(int, 0, path_symlink, const struct path *dir, struct dentry *dentry,
>  	 const char *old_name)
> diff --git a/include/linux/security.h b/include/linux/security.h
> index 7871009d59ae..f210bd66e939 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -1842,6 +1842,9 @@ int security_path_mkdir(const struct path *dir, struct dentry *dentry, umode_t m
>  int security_path_rmdir(const struct path *dir, struct dentry *dentry);
>  int security_path_mknod(const struct path *dir, struct dentry *dentry, umode_t mode,
>  			unsigned int dev);
> +void security_path_post_mknod(struct mnt_idmap *idmap, const struct path *dir,
> +			      struct dentry *dentry, umode_t mode,
> +			      unsigned int dev);
>  int security_path_truncate(const struct path *path);
>  int security_path_symlink(const struct path *dir, struct dentry *dentry,
>  			  const char *old_name);
> @@ -1876,6 +1879,12 @@ static inline int security_path_mknod(const struct path *dir, struct dentry *den
>  	return 0;
>  }
>  
> +static inline void security_path_post_mknod(struct mnt_idmap *idmap,
> +					    const struct path *dir,
> +					    struct dentry *dentry, umode_t mode,
> +					    unsigned int dev)
> +{ }
> +
>  static inline int security_path_truncate(const struct path *path)
>  {
>  	return 0;
> diff --git a/security/security.c b/security/security.c
> index 3e648aa9292c..56c1c1e66fd1 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -1702,6 +1702,25 @@ int security_path_mknod(const struct path *dir, struct dentry *dentry,
>  }
>  EXPORT_SYMBOL(security_path_mknod);
>  
> +/**
> + * security_path_post_mknod() - Update inode security field after file creation
> + * @idmap: idmap of the mount
> + * @dir: parent directory
> + * @dentry: new file
> + * @mode: new file mode
> + * @dev: device number
> + *
> + * Update inode security field after a file has been created.
> + */
> +void security_path_post_mknod(struct mnt_idmap *idmap, const struct path *dir,
> +			      struct dentry *dentry, umode_t mode,
> +			      unsigned int dev)
> +{
> +	if (unlikely(IS_PRIVATE(d_backing_inode(dir->dentry))))
> +		return;
> +	call_void_hook(path_post_mknod, idmap, dir, dentry, mode, dev);
> +}
> +
>  /**
>   * security_path_mkdir() - Check if creating a new directory is allowed
>   * @dir: parent directory
