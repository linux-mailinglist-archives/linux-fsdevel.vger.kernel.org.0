Return-Path: <linux-fsdevel+bounces-2276-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F03707E46BB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Nov 2023 18:22:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CF9A1C20A64
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Nov 2023 17:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC802347AC;
	Tue,  7 Nov 2023 17:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="PdVBWiTL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A274A328DD
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Nov 2023 17:22:18 +0000 (UTC)
Received: from sonic304-27.consmr.mail.ne1.yahoo.com (sonic304-27.consmr.mail.ne1.yahoo.com [66.163.191.153])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D5F410A
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Nov 2023 09:22:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1699377737; bh=rS38ARgdEttTVVhi/AFCyj+0QJRHHebzLinEUr5CGRE=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=PdVBWiTL5xnQVD48djXxTcV1hZy+cz/IyPJRrqkHM+4ILaNArh+1k/otSvm8ZvEafyl8o88FFb6rVPvnv+oqhk0lM5+Al9Wam45HoOU3Xgc/ZuS83Fvz0zifcJwgVNVjOgiUXMUMs2zRmduPuCZn4kUUx7n9wSV4qc2ILF0YldbezY1gcjA+5rbkfuumezBc37q8hzJUgNYX82dpr/RT+pjBzVdUAGTZIeikKjBDkn2tO36EW5zD81tHy1W+eiA5cegHI2agF8ZCj+1AeP856wC7fHuqAAMrYjoMZmPHheppiwpf5Hr8fTHjen/4rS6U/963eHxOfUEwHaI/Hqus8A==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1699377737; bh=C8cyhk8oOCxwiLNUy1F+SDRLky9EFsBQ7gxFAKctakt=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=P99hsky8eM5e/UEeGICAqsOGQaKEaA8v74bbFRtu9fX+XZzJV3HUGB+aIw1ijFUCR7dpuDnMy4Gvjp6DrQWo9j73zQ78cT16Qh+VUNvX3yLVhXoIwcRqpnDhcgj5xNjm2p84D6xYQ0d1hoaPTeoYdXg1dLGQQxE4F8QHOBXa+HAAR/A+/TEt12KOCfoNi6kDQL1myjZV28UlAYzPh8vbcSKRYBGluHlygPvchm2CFjWekTVmaR0ZsTE4w/R9JI9icAJsbbEKUwGWzX9vr1zo1pVvr3L8ouiiCW4JjKNPYnAHua7E16yKmdv1dxoWCczc/YbZRjTIz+3n2DRMggNaNw==
X-YMail-OSG: gYFM_bQVM1nu7t50CxX.GxAWkCQGcAqP6xzY3QbKvFdgMqdzY9g4UU4Z8BJ6QUO
 .dkt55u3gUxE0i.a.GIISiIE7ISnhx.Y6WNsO_4K_HSf6ykAiAeHGjQK_9DXv2niwSLT4K4h22BX
 Sqg4CgjDKwUafXRyoo8J31xZCnRtB_QowRKOtEFP2mc6fvVtSEC.Icg2AtQ14kTLZvOWPxMMTOx9
 DiTfvsN8ae8jzKCa55gxfsG5HkqO2O97OduM2WL_LQr8e4TJhF_WC9t5q72dYhhxqK5P5spY7VOy
 1zIeFx88oF6TDYVpKKyXXjAImHO1Oi10b0ioc08kZfKnXr5N3cltMbWcPXq5lX3MfN3O8c8BQD8B
 RdTPU.QoIMwWboy2kC3icNXpA0binaLoydQqJrxOgRaIg6Jxt8efYBJNg_EAcWdNS0RHp7KigyYL
 LC9vQP9L34jzuLuPum3cmgZHeAVZ.Q65JiSavSo9qoo1yU_Y1O1JB4GdJxvdUUiGirFfqibkK2KR
 K9U4Pk0Y4yxndOsv7jL4kPzvuXMqGAaKe.2p2yzTyEyJVzCz1k7rvLKvz00sjK4nSNXNsXXndYSK
 RPSIeSGJRh81PpltItMmC3CufY__ubqofhLyVVQ1oMXuhvWGA5ewxcPrDxo9Gkop2xIuYZhnswhK
 hw_y5ZnhC3fpzSVZdRjZITSIM7XoX5N.3ACaMWuZeVh598jSlc1cZiO6xv8g3DDRnmtXhSFG7Iac
 pT8Fv5iPdtPiwPTMEc9U322ZJqj6sCuIt_6r_zAzYq5zOgYbSkgBPLwAX47pMl2rPyDaPpErtP4f
 2SzZECTUXnqwgQxrgFe7b4RZLVZwDhgB_SZvc58kizeOloDNjwa96GrrGmjtDqUoNgIgBJ_cdBLm
 1KpKky90YQqiKsUkUFNwkGzmTFWgrxJmrwm9ntx1F10uE9bmRhwgJsZ4LCWgx4oICYJxrpEwNu5N
 5Zwj.1hMAIvqb9Jg2gJOZiiR2MMmsIIsx65xww1BS2xxxKCNsk.Nn4yykDr5f9tevye6VUoDxXtP
 wfu5UFOaQwi90Ss0F_Vm0k0SluG.1Jssjm2BTXaflkKGxiy6L3S2A3naTAL0w5MfFNMEYuKZ0O0d
 n7WdcxGwsi5D3Xne7IQuvJBmUJfKXht3rAH4j_MEu_6qsAFq3RnmHmVyZ70abTTUUIQD4K_LpvYE
 dWaFJ7FLvcmWlGZOsNv08ExMIYm0gH78xAqKT4JMV5qlhO5H5LcJP_2EbJP9i9lPzOtMVo9jMTCV
 JyKfhuDMGsxCbFuPIai9wMgGmPFxne6wfcs_wTRdRzbt7noHr8qanN6d9_W0PIajzpv.R0YXwTb.
 5IFS3gmmEWmrIqxKlrZ7XZjXi.N1UQNIloINomajBgUxQMp.BW0BfCqApJJhQ4w9FSr1DebNJolm
 HmdpZyuukJ9UlmpexgQNa61o0yt5GglD9fWbz88VJJNo4b3lSkRCGy3noBiQBms6_DxaIl2DPOwc
 qLJVczyooz2DaSX3qof6D6LN7fNTIkdNgBZSd43sBbX9biinSSj4IMQy8PO4XXcC.4b9Zes2qrB1
 WQ7uBEKBt.yrIaF8DvUoPRIbY3kAqsbJi_9RowYZ0GmvVvKilz222dfmA_f7XuUeU3wodb3uzrZA
 fiZiFByDToJp005K_LPDKMZgbLZ_Rs5RE3X29Q_ZYnxcW4QQFzodRj5vF6iCQSeqiRzwAX0WsYRb
 RZ2UOF5T6_Mbdv5lW58YwUzi69Uado9VJgZQDAS4XI_Vwv0wblZfRiGGGJf1eiua_bW5vWeQiTDe
 zKqwLrN_2l3v0Zi3lO0mheBUw6UbC6i87yJtgDTnzQI_HC8q4I4E62nuyAKRj2bhKCSzeLAQF0oy
 5hBu8pfpKi_c4SR.rdAQ4gT7191f666VBHJr63NTHoJKXB7x5MRxjA40PfvwRCxYQW3dRE6ENTkJ
 .XOhHNa0E4R.D2pXdyaD9IAcWsn2Zmih7Hhkj9tZpRAVeDsPzbyPtiePChfPl4oyipoj97VSRMF1
 fNR7YYQZWTmR2Kf0QEf1OjYC.VYy1_1BkMhN3nNlrol068lPPRoMH0pPX8Soseig8NRUY5h3jGQe
 Ty5Y4.HSm2AHwIV2szOsnMpvpkZ2J1O51RWRM6o199b2idCvOQFWXqCbRoWPxpx_.mQSa0sfNFGk
 SRZDZ9xEtEnUO7Be036WwKbetSSlqkcUK7WddOVGP3buKg6TIwwFv2.8xSPZQ6X0b_m.RcJ7QVYK
 EufvNUQobtfpa0737SzuZd4jLKT.vANtiMiMCUDbEJ44EySAe.prtcQNdgKXm4GgayJOv
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 8c5180fa-950d-47fd-840f-8536e274ae07
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.ne1.yahoo.com with HTTP; Tue, 7 Nov 2023 17:22:17 +0000
Received: by hermes--production-ne1-56df75844-8k4lp (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID e1e2ab52efbb959fd95a219a55e86ac1;
          Tue, 07 Nov 2023 17:22:14 +0000 (UTC)
Message-ID: <972656de-8e5c-4900-a8ef-0510c6f121d8@schaufler-ca.com>
Date: Tue, 7 Nov 2023 09:22:13 -0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 02/23] ima: Align ima_file_mprotect() definition with
 LSM infrastructure
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
 <20231107134012.682009-3-roberto.sassu@huaweicloud.com>
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20231107134012.682009-3-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.21896 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 11/7/2023 5:39 AM, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
>
> Change ima_file_mprotect() definition, so that it can be registered
> as implementation of the file_mprotect hook.
>
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>

Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>

> ---
>  include/linux/ima.h               | 5 +++--
>  security/integrity/ima/ima_main.c | 6 ++++--
>  security/security.c               | 2 +-
>  3 files changed, 8 insertions(+), 5 deletions(-)
>
> diff --git a/include/linux/ima.h b/include/linux/ima.h
> index 910a2f11a906..b66353f679e8 100644
> --- a/include/linux/ima.h
> +++ b/include/linux/ima.h
> @@ -23,7 +23,8 @@ extern void ima_post_create_tmpfile(struct mnt_idmap *idmap,
>  extern void ima_file_free(struct file *file);
>  extern int ima_file_mmap(struct file *file, unsigned long reqprot,
>  			 unsigned long prot, unsigned long flags);
> -extern int ima_file_mprotect(struct vm_area_struct *vma, unsigned long prot);
> +extern int ima_file_mprotect(struct vm_area_struct *vma, unsigned long reqprot,
> +			     unsigned long prot);
>  extern int ima_load_data(enum kernel_load_data_id id, bool contents);
>  extern int ima_post_load_data(char *buf, loff_t size,
>  			      enum kernel_load_data_id id, char *description);
> @@ -84,7 +85,7 @@ static inline int ima_file_mmap(struct file *file, unsigned long reqprot,
>  }
>  
>  static inline int ima_file_mprotect(struct vm_area_struct *vma,
> -				    unsigned long prot)
> +				    unsigned long reqprot, unsigned long prot)
>  {
>  	return 0;
>  }
> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> index cc1217ac2c6f..b3f5e8401056 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -455,7 +455,8 @@ int ima_file_mmap(struct file *file, unsigned long reqprot,
>  /**
>   * ima_file_mprotect - based on policy, limit mprotect change
>   * @vma: vm_area_struct protection is set to
> - * @prot: contains the protection that will be applied by the kernel.
> + * @reqprot: protection requested by the application
> + * @prot: protection that will be applied by the kernel
>   *
>   * Files can be mmap'ed read/write and later changed to execute to circumvent
>   * IMA's mmap appraisal policy rules.  Due to locking issues (mmap semaphore
> @@ -465,7 +466,8 @@ int ima_file_mmap(struct file *file, unsigned long reqprot,
>   *
>   * On mprotect change success, return 0.  On failure, return -EACESS.
>   */
> -int ima_file_mprotect(struct vm_area_struct *vma, unsigned long prot)
> +int ima_file_mprotect(struct vm_area_struct *vma, unsigned long reqprot,
> +		      unsigned long prot)
>  {
>  	struct ima_template_desc *template = NULL;
>  	struct file *file;
> diff --git a/security/security.c b/security/security.c
> index d7b15ea67c3f..c87ba1bbd7dc 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -2819,7 +2819,7 @@ int security_file_mprotect(struct vm_area_struct *vma, unsigned long reqprot,
>  	ret = call_int_hook(file_mprotect, 0, vma, reqprot, prot);
>  	if (ret)
>  		return ret;
> -	return ima_file_mprotect(vma, prot);
> +	return ima_file_mprotect(vma, reqprot, prot);
>  }
>  
>  /**

