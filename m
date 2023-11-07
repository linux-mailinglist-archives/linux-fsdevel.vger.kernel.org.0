Return-Path: <linux-fsdevel+bounces-2286-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 08C5F7E4737
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Nov 2023 18:40:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CCE04B20DC5
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Nov 2023 17:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2459334CE0;
	Tue,  7 Nov 2023 17:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="d8198OO/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E9A1347DD
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Nov 2023 17:40:00 +0000 (UTC)
Received: from sonic312-30.consmr.mail.ne1.yahoo.com (sonic312-30.consmr.mail.ne1.yahoo.com [66.163.191.211])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7124F129
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Nov 2023 09:39:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1699378797; bh=tBt60bDXg1DqrNe9NMPxzOTPoUq4uLMvRSkc+FjV4dc=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=d8198OO/iZETZOuIf2PZUqiZUZ9p1lo0mad1QBpFfqUZVNT8jx4ptmQCoP9bEQaSWCfPJ831FR5bQjTpQdH6uQPPJl61m0yQCHpKsgEgALYZ5kAgarWB3BIxdwMgSbg2TLsgC9RtlEFxqbJ7SVatv5+oePoIyq+SKlxQ0Rtzwo9XJBDVYwP8dk6vkENw8XUrYK27XpWJ9kWHv+TDQuhmEXb+y5+WfWHKH51krtOqBJm74ioLsRjUpfygSD0r6Jj1Um80I0LHUgkasJVl020cEXr6WaHBUwZDVOC9jUffH3wPjCXt/+9Ko0vexw+ZrFwmUup8o6Nl1+pIdrWpAQJNgA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1699378797; bh=WOubmKwgFxTqlfu77Z9l+rrRYZyfLqTwATZzCOEUYdQ=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=b1VGSmrwWwaB1tgD5GI7kjQfp/ujnfOv+DX1J+VY2gq0taJSITsz5ye+eCa1jjK1sW4VeS1HmIcpzg4iNVB8CYyKn+I4+y8lca16z3sqs9898ISanG8K6S/fQII4p/MiOysmBpVhHgLUROsD6kyeKBNBDabf0Ola594F/jjo04AgfSVpyNGk7nA6QAXc3CgnPg4wGChAKq0fQD/89+CD65DVAzY5FovLkiY8YwWgGvt4ersCRR6UZ5U09Iu6qFHO1aQw1PVI3ifx6JJ63j/yys+lCi2e6CgP/ZBTwpoo9MvoY+B9/97ZvR4bxfzbNvzMPnUMp1lCN2i+BjhUx6YnnA==
X-YMail-OSG: SFQyYJ0VM1kvUG3BWDEX8IHrV3f.bTLq_hdLmDzE5lZ71wrVTFkCpntr69jH4s1
 0NAjglFni_c0n7pPkAjy1q8hBvaOsKAfmgYZJxIVUCIk6n2lrleS_J0qDTfTiZlSckNmoMaFpQfC
 g8hDWm9J_9IECyGEvB8mq2u_jI6h91EEnzOdVQTr1hCtm6WmV6vnF6KEwdys07HMoOa.o.8_7CfW
 gH6ruNXu06LsHgZcdlSrzg8.qQKQuo2RhvIswkNsH2GS1FSf2PcLg6HBSfJQzOjoFSEhkNixSpVa
 zl5K_dOPEJNgYrtvW499gD6CjAZQ3RANOPtqJWzc6RQtadtNLGA1aogJyEeHJzxX4JQV7mR.ikgT
 vYWKvTICOIiHMyptC_szVntYwZnRo1V.Qslj7SwflzXG5aFfT_pwPoTanndFgEDbNkYQDY2Tq9VS
 L6FLcb7_cgTmZI8xstNybPPo2by3VimFqKUO2sVSroFy1s0zQV1aoUbCiFGtfaVko9OWlAUxfnGD
 SPq5MFnjIsuIj4wlfo7KZSIIWgfo969z5AiEXCepjlbeuWtbU2AaFrkxDzpl.VqfnZj7uPiJwfVW
 9EggHdla0QEMKEjBqLrQDWqu.JDdi87hRGUDFk_9zDZakSR8g_cux93hHLVMMvgrRdYMRC1Bl4k8
 Jv82LRIqgLH.Cgr05M1TnQ.mGN_vABEMJWJXz3xGyF7AgIKGEgptbfT.O7MfScvNtpVzwUbnJpvB
 bdhL7HUSo5Klv4fCnZgQgde99NGaiD_.jPauDGnMEkDmnofTVxzK.9ECFGzgK2CtGbvYCvCBsDBl
 Dwgh2bU.AZ4vi.tLtr6UUCmP_L7mUEnrwIt8QKmvPLjYCN5LdFXg9oDfLmnDjIGeAp.lAM.u.2np
 Htqpi8Ky1JWm_32FVaC6YlDh_Ekocce7IH4ZFF7DACUp8NbbU6v1HogrBcs82UUnhtSzXEOG5jfR
 fsgbYQCPwaqPgWWmKXMEN7IwgYA7Q6PdyfXd6z67ZpnlupqVGCcXaqk02qJ9TSB95FpD2_uVQZd6
 73jM4xtRa8oFNl4ltL4uV5EQvJ9id9Bm_1FE3O_qKLWyK_xiyOn0LyhN3L4RQ0fpzPmdlRdxzB4r
 5asXQa7h8CzpVMyMOBIExNt_Owlsmd8sEXqvdRuoaMHgXZSdrft6D_6pQb.K5g2ak533rKHwvX1x
 xVTRREUYZ4JDm0gKHp3QefrQ5mk98r7NYMGBVlTDl53DfQoQcLMEassGXnBQ59VrBm5ZcZ.2PrgE
 pZWb5oLupSL60lt9OFLi_nAgv_C0w9LNIved_WR3ffnsbr7r9U8NZhyUuILhLAhdgV3.EDo2TlA3
 FLnR2RMXC4AjD.mnwHxv8X31Ghdf2sdosarU5Wr3WLf.VgxkF_CUn0Jjb.KXAMSOImzJKbVhNgUg
 o9jjaNrclJtJLyXqt7S49.bJgIdkQ2nf0O9cKR2uab4UaoWnRGUJ6T5WWqsHq_caIySISOg7vt3q
 .FjeMD7pbiCOh_xa7S_Wm.Z72t2bZnS_fpdBAISRsWE5p.kBltf66YRjOHZnB0di01JIwlIVM7rq
 mqVBc4llsIlVyYt21cyoDdNS7nbca4X.GNOyF7UAxugWNQydHDRX6BsdewfoTl6pisNxbxMmy7uR
 e2P.mDfPgupY3M8l1w9_l.908CdzBxhesrW29WhoXhWiRsy_15sAnjmAnw6wg.3xRJlP2rffkFcj
 MldI3h5noa9XXQDZMDPkecK9u4v_2Nn_TVDvnh9l_.XxyigbIwMRRRCbWtnZjUPe1ZOur.aBWz1g
 0LNUCPmBOhqgb4lZyJ4Etzj0pSIxNB3B8PiDqHH7sJlqe6CDLWOtKpsGR3xhzMweKViHWH0cr6oW
 8eY5Cgoy3wivtMy_B05vCkh6HmM_u9UXfPBzqZ21xIOlLC_yaT28UX0KBGkshjCLjzbCowV88o5W
 BQiASpW9ED_sWNr87UR.qlPQMHKlyfO8hAJfRfh8u3n9rgonRtFntyD0QzFzYeqc6efQkjvmNbGd
 uEdbji6pBTCq_lasBF4jsvHMP5hYjKOOhuUhNmMthuHVnGUPszeykJZGRLFBilYhcLSohMWth1R4
 VvGyl3rTTVxb.b6dPCWnsy_JPFmMO_tlMQgB5EPJ.b_sstd7DIgxbvuQ5j2V3OUJtmKCOFZQd2HL
 xDJjudweCipUvnBJTaWTO6s3bSBmm6.xkrmnLoXUOKMWaMOZMU.xfRGfhVFc_JEnapWW5qkSEJ.m
 vyneY2xv9m74QENsQSfPAvbVz1tOuqCavFhB5Lox0zyt7c8ux3DUwaNJ2WwhSd5bOeLgeh1eyvsw
 5mY8-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: b0caf173-8b98-4db2-b24d-c9eb7b1886bb
Received: from sonic.gate.mail.ne1.yahoo.com by sonic312.consmr.mail.ne1.yahoo.com with HTTP; Tue, 7 Nov 2023 17:39:57 +0000
Received: by hermes--production-ne1-56df75844-8pvmk (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 1586259eb8feadc3eca5524add296fcb;
          Tue, 07 Nov 2023 17:39:55 +0000 (UTC)
Message-ID: <2901d529-55c4-4d3b-91fc-157e0f949959@schaufler-ca.com>
Date: Tue, 7 Nov 2023 09:39:54 -0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 13/23] security: Introduce file_pre_free_security hook
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
 Casey Schaufler <casey@schaufler-ca.com>
References: <20231107134012.682009-1-roberto.sassu@huaweicloud.com>
 <20231107134012.682009-14-roberto.sassu@huaweicloud.com>
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20231107134012.682009-14-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.21896 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 11/7/2023 5:40 AM, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
>
> In preparation for moving IMA and EVM to the LSM infrastructure, introduce
> the file_pre_free_security hook.
>
> IMA calculates at file close the new digest of the file content and writes
> it to security.ima, so that appraisal at next file access succeeds.
>
> LSMs could also take some action before the last reference of a file is
> released.
>
> The new hook cannot return an error and cannot cause the operation to be
> reverted.
>
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>

Acked-by: Casey Schaufler <casey@schaufler-ca.com>


> ---
>  fs/file_table.c               |  1 +
>  include/linux/lsm_hook_defs.h |  1 +
>  include/linux/security.h      |  4 ++++
>  security/security.c           | 11 +++++++++++
>  4 files changed, 17 insertions(+)
>
> diff --git a/fs/file_table.c b/fs/file_table.c
> index de4a2915bfd4..64ed74555e64 100644
> --- a/fs/file_table.c
> +++ b/fs/file_table.c
> @@ -385,6 +385,7 @@ static void __fput(struct file *file)
>  	eventpoll_release(file);
>  	locks_remove_file(file);
>  
> +	security_file_pre_free(file);
>  	ima_file_free(file);
>  	if (unlikely(file->f_flags & FASYNC)) {
>  		if (file->f_op->fasync)
> diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
> index 4f6861fecacd..5d0a09ead7ac 100644
> --- a/include/linux/lsm_hook_defs.h
> +++ b/include/linux/lsm_hook_defs.h
> @@ -173,6 +173,7 @@ LSM_HOOK(int, 0, kernfs_init_security, struct kernfs_node *kn_dir,
>  	 struct kernfs_node *kn)
>  LSM_HOOK(int, 0, file_permission, struct file *file, int mask)
>  LSM_HOOK(int, 0, file_alloc_security, struct file *file)
> +LSM_HOOK(void, LSM_RET_VOID, file_pre_free_security, struct file *file)
>  LSM_HOOK(void, LSM_RET_VOID, file_free_security, struct file *file)
>  LSM_HOOK(int, 0, file_ioctl, struct file *file, unsigned int cmd,
>  	 unsigned long arg)
> diff --git a/include/linux/security.h b/include/linux/security.h
> index c360458920b1..a570213693d9 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -395,6 +395,7 @@ int security_kernfs_init_security(struct kernfs_node *kn_dir,
>  				  struct kernfs_node *kn);
>  int security_file_permission(struct file *file, int mask);
>  int security_file_alloc(struct file *file);
> +void security_file_pre_free(struct file *file);
>  void security_file_free(struct file *file);
>  int security_file_ioctl(struct file *file, unsigned int cmd, unsigned long arg);
>  int security_mmap_file(struct file *file, unsigned long prot,
> @@ -1006,6 +1007,9 @@ static inline int security_file_alloc(struct file *file)
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
> index fe6a160afc35..331a3e5efb62 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -2724,6 +2724,17 @@ int security_file_alloc(struct file *file)
>  	return rc;
>  }
>  
> +/**
> + * security_file_pre_free() - Perform actions before releasing the file ref
> + * @file: the file
> + *
> + * Perform actions before releasing the last reference to a file.
> + */
> +void security_file_pre_free(struct file *file)
> +{
> +	call_void_hook(file_pre_free_security, file);
> +}
> +
>  /**
>   * security_file_free() - Free a file's LSM blob
>   * @file: the file

