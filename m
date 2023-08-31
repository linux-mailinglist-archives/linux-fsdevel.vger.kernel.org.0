Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 736AF78F574
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Sep 2023 00:33:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347694AbjHaWde (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 31 Aug 2023 18:33:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236119AbjHaWde (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 31 Aug 2023 18:33:34 -0400
Received: from sonic317-39.consmr.mail.ne1.yahoo.com (sonic317-39.consmr.mail.ne1.yahoo.com [66.163.184.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61D07E65
        for <linux-fsdevel@vger.kernel.org>; Thu, 31 Aug 2023 15:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1693521210; bh=e70bISLuY6fb7J+z0kqSKLRiLDSz6GGBBOClneQup2E=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=fIjafN482tBGp4AfLJnh2MKXyHMGiXttv6o1606DmXCZCSlk3OadepjEZ9WY+NNLUFOS6cvyZM2OYrmN/siyd9xr4V4AHLz5rdkzYCYrHf7M/E33Q9V0OUVVDtaUnwvNWO8i1b0o/RCcpEQPuXjtiLzgzzSTw8Fbp+QWlsCs2zgc+vartYObSfZyYxc6Qsps9lT6LsSUyQRQjT6qEKrRRLnW6phbbfiJw7yQuUgSGvW5qsybKHwSFsmhmXlQl0KOMgNDI2u4/vt/ErUPUAykseQdVYbCga1dTviTt0mFIooGJCLOC6X7GOcTeuJq2V47b9+O3nPaxC1Gi8zq4bmBgg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1693521210; bh=PF32S8cVKFvmAaph02A9hH2vmQsdVxpbmYXtHwo3Z1s=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=YGLsSc/IrlYwOZtJAaA363aP3OlvLqEJJFOQoHp+Jove4Toqf9rwmwk0aXuAXDWXFeYi8zqERfI07vF9FWvhUINMukPCskC6qU6prwzBQ/QQvn+n24IwktsLJesw69zWLjxiX0JP4tTWs3uDXTjuF4IPSld8uWiRbYy/0GY2AXhSdMwyQklCLfNJ3ZLTDEuZwqhsjQX0N8/cX3WpyHND4yd8z5KY1A27Rkx1uXq2Q7W6s7/zwCxz9GK6x6oPvrv5E2DsohIEAC1pIoresfPcLQ5vgwTt9g87cHDSyfdqByllSvtHYwVIAclvTEVizFgmA2Gd9XeDavwr8OEr6WBvsg==
X-YMail-OSG: QbCFSPwVM1m0KzDasUhM.IXS5OHf6EczNyg2hRMzoJiRC7sc2Qu72JtINxAl_o3
 kdZ0vL.55gtf2gHEm2DQXETx3Zs7gbZ3Yb8cjgrEK4zpIRXpOzzJw2i5lV_bpelCV33JJxVdDRCP
 50NWHNDxF4DWOHvjZ_YwdoiJU0AWkM1X8UjlAI0n1AX_Qnh.cCk8fPCTPZ06ldVK2KuqZRorH7WK
 x3woP5zhhUMjjvq_0nFInLY05O8HksGnRUROyi.6kIacrRtJ0muFmj98uRGHUkkgmDNINBZFf6Xw
 ZGrX3J50OF8UTffFBI2vTguDwn1ML5ajk9SrpwKGE5xxWuC9hiW2PwbzfWRVnuJt52S3LBAAepE7
 hX2uW4DO52PJixD5hVDPh4pw1DOH1YWxOjKzqg.I2KZrdiplY3LXkrSLefxTsDizyqo967TWXgsS
 kt7MzxAklByG_8Tmy.LeZcgEbF51GMwYTIhIkY.xbeCz2BrszDHutm8okk9guesarG49K_yZWtIy
 eshhTt8._mYaINN.A76gSB5mx_Khq_1jx0XEgDzNvVdKPVljzG1KZf6o5sN9bTInNt6fyG8dBIb2
 fq1SXh8GVmBRXVXEwCL_iN6f68Tzv7EomIKtwzn2pR.8LE4NB9X7hoaVMs6EUscX0hDoFfg7qdeB
 8wnH3CpX0c1r_Yxxdr.RJ1Ot_PHWYxc4E6_JAb11RyGPNKUylECJd1ZRJMuWCEJL1v_6xHhzKFwP
 k9WNvfvwF9q3YeDQYLdU98EYSzCQgOOKc2DPujaTESTaQaTBZcuhsYHIV.97GLl4EI5HIDKsv4MU
 JGnwy1MVYZOeV1Fpha1lvDrg5NrFAyIP4o3V.cmfDbLgogs18AWT4zq9IC9eXqLdv2ZjxC0v.QTt
 5uxP.o1IXpMpsVguo4Au.Ra1fQXcpViCeCwToAAxoRs48DTEKFw.c.ewcVr9mvuxeULMwt63YfNJ
 lrmHmHfHISa6vXIvw6qD3OqDjBdkeDrG0fUPLMPOsENWYhT7R5SSFCDt5mVx0vSIyJ0FL8VHTueH
 MBw3Rutc0U_FXRPsJTcSOpOCAMXRCghR3EXxyf4qYgio6XzxWPhMtF9GW7l3A3hujVMVTdwsSygf
 lEV3EvyiEXbdv6nI2gIh_qi0f8K_NliAqKXJatSQaNKCLAhlGTu.Gs11MaLNkWP3knsTCTMhhF1W
 NsoarOgv5YA75c8lsJwXOBXdzMAlgKL4CFNUVB9Bn6osmpsB8jmN4eYjVhip4A1Btx0PGCe1vVA9
 gQjpTNTDPrbzue54aRr58EMbusyWbiMtWay0hpO572qeb9GU.mCZHXwzGF2T45BfVnOI2HQTKQ.g
 qkBbX4UiMGXbDMLB2MKIBJ6C1R_Nzq8575bWTgRTylhob7QLbk5q1jHNBbJbfzVKyWd5zLHil1pm
 OoTqelrdNfkeoeC2nk4Ozp26pmRysoZpNA7Lhok_S3Ej3h.8MuIZw9RoDPL9ZlojPK29P9SkY4hk
 OBPNJtopfXMEgVFFtTzBLljvr_8fbHv1K138IAmZZLxwAnUoaUQfaHcaLAPq5v2K9Gu3900aWzZO
 aJ_BcmRNlg3uIyTEfIvV1D49KpjSBKD3C5tMsrIQbj2FbiMpRHrgQZlZUsDWnrGntixsqO3wc0jy
 I1cDdudRLJYaCYzzIiq8ciTKGwhATRI3bwj3D8Rw1gq_uyUkaHbfscqvNB21v0dRT_4erMdD9B8C
 Y.XgBJHi0FLAZRolbQv8U90Tazv9Md0Ca4JSDWiC3YTNwR44UgUixEopZr43UJ_78pkLjGr95XSF
 sy_TpW4DU.v5w3pmA9G3r99dLc6iAe6h9e4sRtAA0MuwEG70dPatpvg6FdB69Y2rZ6J_mccbGvYm
 VCaMWvcsn6Roje318.B4fYDhL4Jw.0UD2mfxZiFWC0YC8W0ISAj3utnDfBGEACQ0sFro43oa.vSH
 muQAkPWM3coQHak2.jWDbhYDUCPOLXK80TXkNvahiJUnPJLDFtnfNPgMmBqOgwL1Tuspzg43Nt0d
 eHC_qX8nrMEnmBfy_7bO1SW6dNCqmcJUP_j4wkGgtgGYBsCz_zyxSFq8AeTN2.qo9V_XP8W6B_Ph
 HIHZAHwVILMpF9.SMyBXz9YlnJUmAQyU9Nq3r45zzdE0V7foDCmHXQIs_vRURUqQ7iigdmKiP7ef
 Dx6wLuOYPgye_iCwHiEx3KzO3hqkCs4g3nua8qc1VMHXsxWE.tVfVl2DRR32mv8F9Y1exJuu8Bhl
 .PkCmLjhFvfoDxOO50JdDQhYAIh6PeH6dxB1KI6bc3w--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 3a4dc40c-12bc-46c5-81bb-d0810b34db21
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.ne1.yahoo.com with HTTP; Thu, 31 Aug 2023 22:33:30 +0000
Received: by hermes--production-bf1-865889d799-7bb4c (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID a8e0777d67c5e3dfe11e628230291f30;
          Thu, 31 Aug 2023 22:33:24 +0000 (UTC)
Message-ID: <acb13c4f-8ecb-076c-f730-cb5e14e018af@schaufler-ca.com>
Date:   Thu, 31 Aug 2023 15:33:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v2 14/25] security: Introduce file_post_open hook
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
 <20230831104136.903180-15-roberto.sassu@huaweicloud.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20230831104136.903180-15-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.21763 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 8/31/2023 3:41 AM, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
>
> In preparation to move IMA and EVM to the LSM infrastructure, introduce the
> file_post_open hook. Also, export security_file_post_open() for NFS.

Repeat of new LSM hook general comment:
Would you please include some explanation of how an LSM would use this hook?
You might start with a description of how it is used in IMA/EVM, and why that
could be generally useful.

>
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
> ---
>  fs/namei.c                    |  2 ++
>  fs/nfsd/vfs.c                 |  6 ++++++
>  include/linux/lsm_hook_defs.h |  1 +
>  include/linux/security.h      |  6 ++++++
>  security/security.c           | 17 +++++++++++++++++
>  5 files changed, 32 insertions(+)
>
> diff --git a/fs/namei.c b/fs/namei.c
> index 1f5ec71360de..7dc4626859f0 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -3634,6 +3634,8 @@ static int do_open(struct nameidata *nd,
>  	error = may_open(idmap, &nd->path, acc_mode, open_flag);
>  	if (!error && !(file->f_mode & FMODE_OPENED))
>  		error = vfs_open(&nd->path, file);
> +	if (!error)
> +		error = security_file_post_open(file, op->acc_mode);
>  	if (!error)
>  		error = ima_file_check(file, op->acc_mode);
>  	if (!error && do_truncate)
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index 8a2321d19194..3450bb1c8a18 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -862,6 +862,12 @@ __nfsd_open(struct svc_rqst *rqstp, struct svc_fh *fhp, umode_t type,
>  		goto out_nfserr;
>  	}
>  
> +	host_err = security_file_post_open(file, may_flags);
> +	if (host_err) {
> +		fput(file);
> +		goto out_nfserr;
> +	}
> +
>  	host_err = ima_file_check(file, may_flags);
>  	if (host_err) {
>  		fput(file);
> diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
> index 1153e7163b8b..60ed33f0c80d 100644
> --- a/include/linux/lsm_hook_defs.h
> +++ b/include/linux/lsm_hook_defs.h
> @@ -188,6 +188,7 @@ LSM_HOOK(int, 0, file_send_sigiotask, struct task_struct *tsk,
>  	 struct fown_struct *fown, int sig)
>  LSM_HOOK(int, 0, file_receive, struct file *file)
>  LSM_HOOK(int, 0, file_open, struct file *file)
> +LSM_HOOK(int, 0, file_post_open, struct file *file, int mask)
>  LSM_HOOK(int, 0, file_truncate, struct file *file)
>  LSM_HOOK(int, 0, task_alloc, struct task_struct *task,
>  	 unsigned long clone_flags)
> diff --git a/include/linux/security.h b/include/linux/security.h
> index 665bba3e0081..a0f16511c059 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -403,6 +403,7 @@ int security_file_send_sigiotask(struct task_struct *tsk,
>  				 struct fown_struct *fown, int sig);
>  int security_file_receive(struct file *file);
>  int security_file_open(struct file *file);
> +int security_file_post_open(struct file *file, int mask);
>  int security_file_truncate(struct file *file);
>  int security_task_alloc(struct task_struct *task, unsigned long clone_flags);
>  void security_task_free(struct task_struct *task);
> @@ -1044,6 +1045,11 @@ static inline int security_file_open(struct file *file)
>  	return 0;
>  }
>  
> +static inline int security_file_post_open(struct file *file, int mask)
> +{
> +	return 0;
> +}
> +
>  static inline int security_file_truncate(struct file *file)
>  {
>  	return 0;
> diff --git a/security/security.c b/security/security.c
> index 3947159ba5e9..3e0078b51e46 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -2856,6 +2856,23 @@ int security_file_open(struct file *file)
>  	return fsnotify_perm(file, MAY_OPEN);
>  }
>  
> +/**
> + * security_file_post_open() - Recheck access to a file after it has been opened
> + * @file: the file
> + * @mask: access mask
> + *
> + * Recheck access with mask after the file has been opened. The hook is useful
> + * for LSMs that require the file content to be available in order to make
> + * decisions.
> + *
> + * Return: Returns 0 if permission is granted.
> + */
> +int security_file_post_open(struct file *file, int mask)
> +{
> +	return call_int_hook(file_post_open, 0, file, mask);
> +}
> +EXPORT_SYMBOL_GPL(security_file_post_open);
> +
>  /**
>   * security_file_truncate() - Check if truncating a file is allowed
>   * @file: file
