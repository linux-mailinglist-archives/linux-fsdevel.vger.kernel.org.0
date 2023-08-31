Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 328A178F57B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Sep 2023 00:34:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347707AbjHaWec (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 31 Aug 2023 18:34:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234384AbjHaWeb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 31 Aug 2023 18:34:31 -0400
Received: from sonic309-27.consmr.mail.ne1.yahoo.com (sonic309-27.consmr.mail.ne1.yahoo.com [66.163.184.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5519EFB
        for <linux-fsdevel@vger.kernel.org>; Thu, 31 Aug 2023 15:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1693521267; bh=0kUIcr+EtnaNu0tSlhWaJav+ufadA0M1/6wfHmMuUTc=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=MzxgNdLxHlC6X8z7rg5JcO321DGGU05WgpyU8xA+WrTJCCQEi02JHgPBuwk9gMabO3w7R8cGY8+g3g2wJC7F8x1uDAH0E6pXKnc3TSXWxg2MTocC9wd3MZ1fKGmYPHUNyQ2Hmm3PY5TRY+DPLnvzGkdFgpPXVc1QRJby+e3XGdpxuADTcF5m/5aKuJHE/gEzkS6KO+xn60klv4w1PNF9rak0RQSQuPiDlxO6l1JxlRgWxNty4lMPCMEiXOl0fzcE9xqrL1ml7zSyuL22Cw3W/kP/TG/wS0eHvhUGLCWFYoJo5o0324PDqGIK4hUk2Yu19cx5MkKOL+MxLrFhMy762g==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1693521267; bh=AmaxF8kkmWW3JNmSvPsDWj3cliyujnUAiyTqhIp161b=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=KeU2jGBkdzgFK44EhWV895BCbapkaURvzKqyX8/Ke7NNXXtx0U0PBZmgN0fYy+GQ8DzonANYrmY5tOpIB02/1rpseqk9DhAkgOrHZy1zcOyVh3Jq+c8A4jsFkpXEnMd34/xdCF0f7YM35aAU0wchEaXERihQ4yiI/gwP41rG0YOkP4Y6xbQSJMsNVl0naNWiEgAiNSS6hgN9v4Ef5BcG45eb0HoEGhTt9/KCqYGJBp11nc1TukD5kJHkHYo3KTWrAyTMBe/mohDnCBdyrktv5hqKyEAbV9n0706nzaxtrP8Oll9FecTsRX5ntb4BZQ3i3DrVHoOYVj0Eu57GR8DoDw==
X-YMail-OSG: AQ_GsjUVM1ndZFReoUVHxEWtEWT3pxFwuZV6t8yehlUv6S65MH210E9NjrxF70r
 k.63n5V29koTk0rtkq6dJau3qOQi1v_kkLfz783_KsM3aoNMdqrXcNruHpmueSpXmp6gDXvUfAxe
 qyjaznLwDQfl4mZ6Z7GEL9OwbW5GupCJIYvFwlULyr03gklAxblwcSq99WFafhNJPz00ZENW3qVO
 UvC0912Z9vVVuYx5xj3uq8AQ91Ay7vlkcsdj3zkUlaVZiV4EzLycvZKB2S8CX.BxjRBjsfBrJAOB
 ss0qALjbZYbuAyDmcE8a7Ou7VQKPQPe2DCNwz639UZMQkFVOYVzfPjUQdq85tIw8O_VEhjJPqv1J
 LbkLH27ygtVcnuUlWYsRISlpZM4uwfG7ryXPbsR37S5Uo1Bb2eYtQSLQRRtauOChLy.iXWKwjyQu
 aFNAuydE9HBLSZwZOHFisaSaNTOjgqzJIHxOjOAcdwNDgGjgmvb71DtRaYNaJYB0A.08AzAieVgx
 _5bTyK0GgRywQ6OCZo0b_57ZrTJZXZ1Wh2qs5PxBDzUF9jFhDgSXCeQ9bCtbexinPEzJk5X1PYLB
 LGMSgFcKGVAPU2p5kWIRjHL0IobL1revexGZnxvML3Coa0WnFhwEugU_vQCjGwYyVCr2YzsWt8QZ
 DskjzHkGGCKEdBaFo0LF5RH6BG9yD8.Bmd9xSVvNekyBucz2Yqdqga2YpO6AJgJs__RzOuVYFL0.
 mVcZoA3BK6YpyjzmB20MlrWUIE2KwF8Hj7t8sOSjb0t29zshsTqNzMQHwl2vU_q1Y926x9tgG8XC
 JwFOtY.j9H_MkEjEG9devIbPFtyaSIDTsmsPD9yyCyCkvXHbUA6a7qHrqVdLV7IGVMNRJ4Nc4XsW
 D2IRgVZsw2HRYSCUnSMz2Tf4DqwgBEHJoCF8vX3Seh8WQGHL702xBIYgwhVQ7zXrr1oJuKlB2WJz
 vxyfTb5c.sK1Py89wHT1nNv8Q6F5f0ShhvoSMfGaBj0WxaKhjtU9C_XcJXZ4jbsQisRqetrkho9s
 Z2jGqdUekdm2dnq1QE1UOby2FZ2ZuIJPKhejgUqZSmLDYCl0ClZXvRyCXhKQGAQ7z.h5GuKktTSI
 TNNxzW5a8..vQ969JSAiiID8Ti3ShjK.SUfIikkKHgk8VcCLl2K_oCdiB8txu1plQSgBTWKDzhmD
 yrV9E.fS.X_pgMtXMSTQpe.cnaymE8Q0n13Ylz6fxtqik3eCYgjYr2VlBqL7shcaXCRn7Ysh0L15
 LyTnmYv_L36sruzD1o872CNecl02G2Ri.WX4F4r2TbOS11BVyOyJ9WrAoR06ETRR8ueraDdJr74x
 UI_OsI3raR7351L1XjqBW0rff5gfzKOUHeI2HNYlgkySEJtGHEwLKr50XMk7k3XUhO0STCefmMKU
 hvBzG7FyyD.zQmISpmsp9xMWOwZ_DdXA_yXjWsZFZHJJL00jkjqEe6oVeUBzKzuwIbnxjDYAqEi.
 _VYU96j.8cRDdr.Q38oreN6YqMkC4BL4fYHuKdg66i7ZkNthyimp7y8uN2Ul0HLrEeNjzf4djPxO
 yMKhMyLAb9vlv5hvAk.oJAOHPLy6EbfBLwXNkSGXzm_s37Oif7ySaviE2xqi6v9snsyfZcInbAVy
 EtPe96AHe4O7aexaKbNr.Z9jgWHhWJ4LUpItJlIcD9UBU8pcnrdRUxVJdSfM4ebH9JXTWZe0Qfpc
 VMFP1MkcWqHUnHzx6paThEFC3fIUliAj_DDC8NZfE8sYx43RAkOS2eFlrd0XXRaNAUJht7lyB3S7
 BABEVuKJgb7mXTUWIAfQ14XoAHvdOpc5P.GyyhUB8KarwFXnbJUNdov7rYP2d6B0gG1L3x7pHXcX
 dsfHU8unCQExznTmYTbPNUDafqOxDGryu8ZYqOVLWx1pDk.zJoN0hLRORbgSduqqE1iFGor_WU6m
 d6CXNXxui.ej8uNbaR6GaXs8CswXEAMlMqMMlR9jOK5.tDkXBy6KiTFH4NRDZ87jI1YO1tAd44dg
 BkNh81rl9KFsZw5lnTqh.aYMg7_BNlGIMejxJ8gHeZehGpXS3hDV0VHb.y_oVV.p27Va2XB4QrP6
 JE9scfxoe9NqhJmiR8pVV_wA1jnPYBC_YKgMAEtwB_G1_Wz6mDyZCYs83TiKQjby7ax4F5brT8Ln
 hJ0MgUmvz5VOSIkWM9_kZA3.6M9BwBH4EyMHihJHIxU7NNXRIuHRfhGEYb38CWWm_.aSVb4a8PzU
 PMKFxE0PAuZ51i0e4YpqiJ_RmzRp2T1Oj4eTfnKfS6tn6yPk3Kz5Ug7PlBp1LILONJzM-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 02441ef6-c3ea-4253-a80b-ea8b43c6bde1
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.ne1.yahoo.com with HTTP; Thu, 31 Aug 2023 22:34:27 +0000
Received: by hermes--production-bf1-865889d799-jmdc5 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 36872cb8032c2e32fe55009fed390179;
          Thu, 31 Aug 2023 22:34:22 +0000 (UTC)
Message-ID: <773cb7dc-2cd1-25f5-015e-72dc4fcc8d82@schaufler-ca.com>
Date:   Thu, 31 Aug 2023 15:34:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v2 15/25] security: Introduce file_pre_free_security hook
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
 <20230831104136.903180-16-roberto.sassu@huaweicloud.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20230831104136.903180-16-roberto.sassu@huaweicloud.com>
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
> the file_pre_free_security hook.

Repeat of new LSM hook general comment:
Would you please include some explanation of how an LSM would use this hook?
You might start with a description of how it is used in IMA/EVM, and why that
could be generally useful.

>
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
> ---
>  fs/file_table.c               |  1 +
>  include/linux/lsm_hook_defs.h |  1 +
>  include/linux/security.h      |  4 ++++
>  security/security.c           | 11 +++++++++++
>  4 files changed, 17 insertions(+)
>
> diff --git a/fs/file_table.c b/fs/file_table.c
> index fc7d677ff5ad..964e24120684 100644
> --- a/fs/file_table.c
> +++ b/fs/file_table.c
> @@ -375,6 +375,7 @@ static void __fput(struct file *file)
>  	eventpoll_release(file);
>  	locks_remove_file(file);
>  
> +	security_file_pre_free(file);
>  	ima_file_free(file);
>  	if (unlikely(file->f_flags & FASYNC)) {
>  		if (file->f_op->fasync)
> diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
> index 60ed33f0c80d..797f51da3f7d 100644
> --- a/include/linux/lsm_hook_defs.h
> +++ b/include/linux/lsm_hook_defs.h
> @@ -172,6 +172,7 @@ LSM_HOOK(int, 0, kernfs_init_security, struct kernfs_node *kn_dir,
>  	 struct kernfs_node *kn)
>  LSM_HOOK(int, 0, file_permission, struct file *file, int mask)
>  LSM_HOOK(int, 0, file_alloc_security, struct file *file)
> +LSM_HOOK(void, LSM_RET_VOID, file_pre_free_security, struct file *file)
>  LSM_HOOK(void, LSM_RET_VOID, file_free_security, struct file *file)
>  LSM_HOOK(int, 0, file_ioctl, struct file *file, unsigned int cmd,
>  	 unsigned long arg)
> diff --git a/include/linux/security.h b/include/linux/security.h
> index a0f16511c059..7871009d59ae 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -389,6 +389,7 @@ int security_kernfs_init_security(struct kernfs_node *kn_dir,
>  				  struct kernfs_node *kn);
>  int security_file_permission(struct file *file, int mask);
>  int security_file_alloc(struct file *file);
> +void security_file_pre_free(struct file *file);
>  void security_file_free(struct file *file);
>  int security_file_ioctl(struct file *file, unsigned int cmd, unsigned long arg);
>  int security_mmap_file(struct file *file, unsigned long prot,
> @@ -985,6 +986,9 @@ static inline int security_file_alloc(struct file *file)
>  	return 0;
>  }
>  
> +static inline void security_file_pre_free(struct file *file)
> +{ }
> +
>  static inline void security_file_free(struct file *file)
>  { }
>  
> diff --git a/security/security.c b/security/security.c
> index 3e0078b51e46..3e648aa9292c 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -2626,6 +2626,17 @@ int security_file_alloc(struct file *file)
>  	return rc;
>  }
>  
> +/**
> + * security_file_pre_free() - Perform actions before freeing a file's LSM blob
> + * @file: the file
> + *
> + * Perform actions before the file descriptor is freed.
> + */
> +void security_file_pre_free(struct file *file)
> +{
> +	call_void_hook(file_pre_free_security, file);
> +}
> +
>  /**
>   * security_file_free() - Free a file's LSM blob
>   * @file: the file
