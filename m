Return-Path: <linux-fsdevel+bounces-6935-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A22081E9E7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Dec 2023 21:14:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A0A9B2195B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Dec 2023 20:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70B9C4C90;
	Tue, 26 Dec 2023 20:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="nq3haQHF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sonic306-27.consmr.mail.ne1.yahoo.com (sonic306-27.consmr.mail.ne1.yahoo.com [66.163.189.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D391EAFE
	for <linux-fsdevel@vger.kernel.org>; Tue, 26 Dec 2023 20:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1703621653; bh=IHUwGfwpCqMhTIl4JOcWgsY38SgXrI/hU7d5FVNakY4=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=nq3haQHFal6+e57iqOiwQMyZ5aZnokJ9MRqzBMF2WKTeY/0J3C6buO4LjM5TwgDynEYmhAmB8Ooj8t0NEF0F6bf/CJ/q6Nz40FAD9ZA8U5iEl20oLyS1CxUzb8S1zPEN9Xl5ZCGLer+8n7OyKS4PDDJ4WgtLDOZ45OP14FzBdDxvHEb9LskS4Nf3oLyTc/eAafqeVPMGIcdCXBIyzD+Q3kCGtDFZ/CyOjBAY2XBAdIsmXhi4eKHfkfPvYNY2vAiMFbN2jd0wRaLERSvBRrehcCkFbP93HsO9pPS7VHpgMHg5Z8EsQ7Ldl3CJf20YQUE7xj8vhDv0HHeFKnqhbz7Fzg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1703621653; bh=kZzPuGoOfdG2dEslY4eXQ5tGlLq1Ex5EPaT1KEOCYe7=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=NKqstmgZ/cP5FgEEc/QdTPzMDWiFp0vhPFVsnFyDxoPqiTiGjUrBAGSnb6i2gQGLIrHLpWkQa7kezuyYsHPpe64LmMhm9yFgJ8PvQ7X3oXEyAEuabRzI8v+X0AmOULGIn0atud2rHj1KzOA+9nKqYHLZkBSoRROO1dV3GmtFVZadRejrpO3s9k9KcpBIZej2/t8RYPytJ8LopGilI97QF+2dpwFPYOxfHvvuM3p0vunTjo+wT7J/4XJfa34JEanB+1IjBsiwueO2nwcot5+F3f/W7PLBDaaJQbiC0hEX9ScWLA7iNEHnEeqIDlaf++oKwfTwoZznooQjJ7zPQJYYFw==
X-YMail-OSG: DxQl0XUVM1lJO.8UwfHV6ABnUx0OphozCOTR2LUNn7Krwquvw8nTSc1JI5dn283
 IGtZ2IexD5VJp8ag0MXlIjVm3XAhbyTi5EG.lIu68mEH86.wOg32C_UkR9tjjxOYNvKDJ.81mq.0
 YOdjTkjPeGX8OypYdCCdgFRrke9Oc92SWT.EB_DSxvHBfbDLZfxd9lfH0CPsmrDdOOQt7dQbI4ki
 _ghms0eIP16Fg5pAMBnSH6Pl22pe8IB0a19vL8HT6HIXgECV2KaugtkCKP.12zv4qigSSQcF0Llg
 SIz84ldqKIsxpTl64IOVs_.nDtDeqXndtcCYeiQnbHKXG.VMGMPbsn5tKFo0ZD7mfnmz__VdJTiH
 jfC6kvA8PHK0ekjWtd1ke_vTBDs1qq_zf_Suckwr8rC.WGmTXVqnlM.MOe.v4Vg_D2Y.izMsg3.J
 5M3W4zwckOURCS0mcrAhCh9UVTrG87QoxbuG1qNZ5hQkQnaD8BgcdT1r4jsv.uKom.pi_.T7nVhi
 RdMDlHmCWoG77CcjFmB2DS5v_JB0wwKSjGqiLDeoat1oalHfvo5ke7ZePtptYiEcd.su_RMJUFhc
 3bvBh7auepYgeB8puXub061rsCtbQfFxIeH4ToARBHXFCYMfSxhtL6Sbm6RM_zL7bXdadSBL6AHA
 l0S6DWBc7tmkz9SNotlcG8BaJd.MmEbtdKWT3yWDBMK2sYVI4MQNaGnD2AtW_Rz.YtaxefXEqunb
 SUOK9x0M1jNTX7AFSpsBRmHRzXXw9sc0kvzLzvP7R_NdBUgMMD0BtuEiHMCCIQzFrADnp8BGlHmT
 JUKyWp.CL3lCf7J0AI4NRsF9PHwY21zxRitX_4115qjKNd5tkJBozKEy1nMzhR6FuusojvIuT4rP
 cbY7YFL9QRTZanhFYdHduqqkwJ2KX6Hw5CauEs4eN7o5Xwt3sVYYhKm52VDxe6.197PTt0PIiVCZ
 g5tSYZeK0f.ZZPhfRyaWvJu0s_2USu3.DXK5yp4q.r1jb9Fx1NwUXjgrYgRJklzK6fNSTVjVQ8Q0
 D7xP3qxTitVu.ezxBsBe7M3EhgjoPZXRpFOJaFiJlXMdlTOyRf8eeKIwD_rtMPqxLhpgVBbzqdrT
 RYIQC4VeIBosUsu.3cwKnSlfBjWbqHj4QlkOm5l8vqYeQX9Jyvm0mbWtxJsqiBTtFs633LLYJCTN
 szx4SOHWuOv.LFUnYmzHQxyJoDanYQCXqm7VRCKt4f1AMCzHvgY1BFF9DWymA21VblYtImI2ltRT
 SoDHDQxqmdrRig3MdUdc5MncpOKtrbwxlmeairMc68xFNgnAxcv7wBoVx5rlojYrv23sZDcktT.W
 RE3JD0M2bfgUVlIPcbszESWloFqvGzMHJl8_OwKEf9ST.LcyZI1ccGQKPdCaTsTw89Y3Tg3PFV.n
 dDLwCL61wLgFUSjgJJ7BMtAgVwfhuXQlJ1XLVKMqqFNuGLtvxWhL_0qaNUeg42sNy3P8Rkt8KpnI
 FLObVRERCR0QEqP3N0bZIQBurcD9N8SH.ju_ZCQ5xF_SiU7t76DKK3gvdBM6XT2HFkvhEmnxcTKB
 YidM3iYTGIvyBVvacyyropZ_b7BM4eijpvRLMx9Ku.F1nbWxUoRmzULASonZpZVQ7JpOMtptTKwq
 ASTm5yxjcF6i91VZz1y7ROknYXKy4Klgyxmvm5eLB9XKefZbdxr7_lS8jTtY7HjL8DMTcZUGJ2aE
 81JsZkI.w2on1tCA8rCLpvU1HGXXhC_hg0PaiLELeaN.va3HcX2UQ.oN3e7qWzOWe4s2ewNBoNrA
 zdcY.fcc5lwbRn9DDKMm0Cj75llrSSCOGZ2smGCXOmf.PDOyA0HR0ddtGN9D9NPrQQGjkv4NqBGh
 EemeJofeELDRs4pRcurnbW1jINOxQd6tohYzlstp302_DLafSgYDpTRKgvSk5VIqpIW8d4gUaQhk
 vMfMR_E84sWGVLQV44sie_EmwlXlmIroaKiMCbYwmPSNAYin2PXSdwlAkZJoXOaTTCBeNg3AE6Ju
 tnaNcSrSZShYq2BSQN1YGlV8urCskuOaO6TDg0IAqKBjakSL7dpdCPXUVLV2hFQg9YtJ_oDGawYf
 gQ7iq6eQWpuIR0mJr1.2sp3EVZHTqzPABBpshoj5jCR3Q3RzTcdoJctB1wADkJ5TPz6.Czd7iv_l
 CvQW5KtZvv.wqTCVu6GTkVO_MfSaHRfdCdNjLwBq9kgwviuOiaAcYpm8ah54pZlAwD2ciRKULSz8
 GCOtrHtsmzUt0UAecFcIJUHhGSeK0ZkhxHHVzbj43d5onPiikP.aF59CiWw7D87I-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 93599be2-4b45-47c3-9ecd-349e444a195a
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ne1.yahoo.com with HTTP; Tue, 26 Dec 2023 20:14:13 +0000
Received: by hermes--production-gq1-6949d6d8f9-qkzts (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID b2ebb804f7a3e64cdd7665a015e52a8a;
          Tue, 26 Dec 2023 20:14:07 +0000 (UTC)
Message-ID: <42fcd014-733b-41b2-9c7b-658533cd01a3@schaufler-ca.com>
Date: Tue, 26 Dec 2023 12:14:05 -0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 19/24] ima: Move to LSM infrastructure
To: Mimi Zohar <zohar@linux.ibm.com>,
 Roberto Sassu <roberto.sassu@huaweicloud.com>, viro@zeniv.linux.org.uk,
 brauner@kernel.org, chuck.lever@oracle.com, jlayton@kernel.org,
 neilb@suse.de, kolga@netapp.com, Dai.Ngo@oracle.com, tom@talpey.com,
 paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
 dmitry.kasatkin@gmail.com, dhowells@redhat.com, jarkko@kernel.org,
 stephen.smalley.work@gmail.com, eparis@parisplace.org, shuah@kernel.org,
 mic@digikod.net
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nfs@vger.kernel.org, linux-security-module@vger.kernel.org,
 linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
 selinux@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Roberto Sassu <roberto.sassu@huawei.com>,
 Casey Schaufler <casey@schaufler-ca.com>
References: <20231214170834.3324559-1-roberto.sassu@huaweicloud.com>
 <20231214170834.3324559-20-roberto.sassu@huaweicloud.com>
 <c6c2d413f340d858e43aa3837abdf80cb8be9d84.camel@linux.ibm.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <c6c2d413f340d858e43aa3837abdf80cb8be9d84.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.21952 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 12/26/2023 10:14 AM, Mimi Zohar wrote:
> On Thu, 2023-12-14 at 18:08 +0100, Roberto Sassu wrote:
>> From: Roberto Sassu <roberto.sassu@huawei.com>
>>
>> Move hardcoded IMA function calls (not appraisal-specific functions) from
>> various places in the kernel to the LSM infrastructure, by introducing a
>> new LSM named 'ima' (at the end of the LSM list and always enabled like
>> 'integrity').
>>
>> Having IMA before EVM in the Makefile is sufficient to preserve the
>> relative order of the new 'ima' LSM in respect to the upcoming 'evm' LSM,
>> and thus the order of IMA and EVM function calls as when they were
>> hardcoded.
>>
>> Make moved functions as static (except ima_post_key_create_or_update(),
>> which is not in ima_main.c), and register them as implementation of the
>> respective hooks in the new function init_ima_lsm().
>>
>> A slight difference is that IMA and EVM functions registered for the
>> inode_post_setattr, inode_post_removexattr, path_post_mknod,
>> inode_post_create_tmpfile, inode_post_set_acl and inode_post_remove_acl
>> won't be executed for private inodes. Since those inodes are supposed to be
>> fs-internal, they should not be of interest of IMA or EVM. The S_PRIVATE
>> flag is used for anonymous inodes, hugetlbfs, reiserfs xattrs, XFS scrub
>> and kernel-internal tmpfs files.
>>
>> Conditionally register ima_post_path_mknod() if CONFIG_SECURITY_PATH is
>> enabled, otherwise the path_post_mknod hook won't be available.
> Up to this point, enabling CONFIG_SECURITY_PATH was not required.  By
> making it conditional on CONFIG_SECURITY_PATH, anyone enabling IMA will
> also need to enable CONFIG_SECURITY_PATH.  Without it, new files will
> not be tagged as a "new" file.
>
> Casey, Paul, how common is it today not to enable CONFIG_SECURITY_PATH?
> Will enabling it just for IMA be a problem?

Landlock, AppArmor and TOMOYO require it. Fedora enables Landlock and Ubuntu
enables AppArmor. I expect that, except for "minimal" distributions, you
won't get any push back. If a distribution is striving for minimal, it's not
going to use IMA.

It makes me wonder if eliminating CONFIG_SECURITY_PATH might not be a
rational alternative.


