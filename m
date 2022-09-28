Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C90C5EE1F3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Sep 2022 18:34:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233216AbiI1QeN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Sep 2022 12:34:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233804AbiI1QeL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Sep 2022 12:34:11 -0400
Received: from sonic304-27.consmr.mail.ne1.yahoo.com (sonic304-27.consmr.mail.ne1.yahoo.com [66.163.191.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75E1B53D38
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Sep 2022 09:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1664382849; bh=7GD3XaQSzZc6R1JMtZJ+V4XWK83doEoxRcgUzn26FoY=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=GeKJ6iekUkiXl4J4supPFhaiBhTiHoatvkVFLcpJkxdhc3JuM58+EUdfY/9vMu4A/3Vgsc3Ja+r+Kc4RGEtuxYp7LMciOXFnRp1h4zA7+yc505vSCtJcQvEAwd7q8I0DQhY6jmYKuSQhajFv3mGtknWdLQq/Y8o90LLiUDEcIOSkXCEEmMJ8CCDs209QDyWhNwCSdjrM4Gp/yDCPPTGmgDtnMagek5PyykZqX1UcgztZNSKVN04169xZd+H2SHJDdo7Fgwre01nD40HJliYNUmJ/vEE70lS09LxatbzQYRI0NmK75voCas5nNMVv1S29zfv+vG/VN5Jl7/dX2yNB8A==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1664382849; bh=9HDmEb0h7VqmVFiaZkb3I4lZt1yFrL0SfBxfOUolbsk=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=ZpTEEYn3PPKYxgYgNZehONC06/jV2n/FCXsPvgOkLAchaAWxhR66cbM6mkGhT3J+nMr5T/cE8qa4zgd9SoQhogc4nDQFRYFPHCpLMlWfJ/ZkrU2IWk+tdYmYTVlBuALvkLfYshz6MNCF8idYRT+FYag+7ffAzNMavA8SGYYFqPJsth0A1JCLdggypzr4kbcUM6igm/ntqxi/937VJSuH4BEJm1FQtPaOqn6qi86dBAHls/T1GeD3B2B0jdduuXEyrTHfnTjPLYKXduHDMFfYbjGwcGuYnvP3kYZAJnVauXLCCM7L4XrvlaFM5lGsxQKquVsMWoKV1xa4oT19bnwjsw==
X-YMail-OSG: EYBYW0EVM1nhyu87cgMqoQJlPetue2wiA28SUUGjU7W4RB5VkGd8aK.hR1nlXNa
 2BMWpU6hSbBJu9JW0mEtMa2KdhDSx4KsdxUydM7QynSq7Le9Qt4116En0LmPkhE7GQtpcnsbhoVX
 YASGIjDT4.Kzy.JsvryUCBf0Bnqfsh2jHGFufj2YAPAWWkxOdylNXn2BJH4J7wcpMuCsLz9azfYO
 ma7kQPtrVb7kGCepbw2jIo9gEXZ4umGdjIarduaCpm61eVB7ooF2rQV.wLhtBIgDcRcUOcSalxEu
 qhmWwTw0bjP64hDAu81_5rKJBpRHnUwj1lZSWITBz0WDjyFc.AIlM9lEkI3CyYwa8B9ndChVArqS
 JtHvGjxzcsJKTqI2yu3f05jUiQUatSDwTooXc0.Ic8Pbdgc.MShFGPKIXcL4LgrufXd.nf9aBq9O
 oeWHqHQDufoeTFKl6xNvndh40Gjqx9SunQyV.U80S4i5uCgR3LipWWBsJ3cMeG9YygAu1NI8gce4
 pzq9AYqlpua8wNU6._540MNsoz1A_2R1q0SfogedC2gpvZibb0DbUsIiAEVfOsVC604ciMJHrKNC
 6ZeQVM9o3M4VXpMI3hsYtjrQmny3w3L_4hYGXNJdfk3L_Y70twXaEneFVOYSpEDK1kda6xBF_sYo
 ZhxpkbUSsjehnE0uXIuHAUBineOr3vVN9WyzrU0KlLgulXEv6ff2sEhGesKbYh4bxUnAloO7yrom
 dztvS3UVSV2.IJxLk21YWtzStqEBih8mHaYQDveu3erZInMXydMYxwmzuh8alvlEURv9oWKMBvKC
 zkxpcjPdSMepBUbfat8iJg2arQvqkckM7bNsM5mWy7RbfuQtekGQWh9sQ.jfvNW.yQ4cxLaL2LgG
 L5X6tbxMkIlxPxZDOZToHfhRVmln4.hOXLMWZotfcsq7Hn2xA067Mwx07lqNbMAAD8jWq63t3.si
 WaYAWv.yKDmjERIG9gpbWJpQ2tYsOgz2e8nY._s.L2uQZKKTea3MhrIMtDTHygAqa5QA4cBzamZq
 0xqexBEf1f0vHAJiDMzehDV.a3u563d1H8uv17bauMlQ8rQ47tJgEOzomOrCmtJ9pLDGvSCdrJtA
 0CdN5hr9sLcPt2IuCOhgJZDafd_Q2vDoFJfZapz0YoaUutRk9V3vAxCcqNLtLeu7G45hoyjyrKrQ
 06JzUlFiqQMKdzJUtOrcR4U1j.tz4FbK26Nf.55GKC1jWWw4RrH8x3MOmD6c7OpjfZeC_0RqVoMa
 HMaOC6YDeI93ArRohcQuj7gURLQ.IYkHgpAZ61yY71_XJsDaeMl5_54bYYff6o5Dvk5n8lkJ7l0v
 AE7RpgrtnQb1ul9Klbl1X0t387nhGPJMVA5rXg2sPvirSjnmxK5bkYuJk7scpwN0UYUR2lEpTobf
 rGNBE6uuNqCnCfbn4AFH7QAQWQ5JVwhbKDDhnncbf47NM.ULKzRmB.SxJM7_KwVD6bcWDEF08Yx4
 qMbEovrjkfBjXy8wGCAJOGx.yMmkFj9ZLwF0UPToLjIlZ97t8MLTLrZ5wXGwvXjApCX0bPh7jjHO
 cQhUjNbj.eJBVYkITjAyZq2FzbexSjL.76slRn3XKA_ETiKfDFgN.Xlz5_drtPhUNZAUAPBGB4gC
 E26V_0_3iFC.Zbz74.BIUVEp3XCcqE_3il1ws4FnWP05U3WDbkk5PTv7tT1pWBkC8ziln5fUCfK_
 tbzSLc0KMuhreYlDy__eiuxPC41itapfJClKAYya0a77ciQZPDPjCsHxfmpvvY3v175Fi5kE_ciO
 DH333sqKE7WHuTEK2ZATvbDVq13fKNpu3GKWrXd1NrR5GnyZRD1o1cjVe5eclWPDEYksFpo8WD_w
 lLmu0ah26sALtkw9RTciCmotzgousJBo7MIAM64TLblWIjY7BtR5UoLaqMHcCdUeZ3_9A0ea8zEh
 ES78f3wfgKhHHeQsAM_.hqfH4FUZ1e6FYNXGtdlTqbwuHQeGaJKC_ESMAiv8YrSMEAPuilHlXmig
 zfSb6vKNLByF.F6aegjiV5dAiNCqx3O8gE0ghTMDTCLQdkTsgHphyClFKMfVA3Eiu196l.tE9AHj
 jwZdvJwdTRi8vj19RyC9KAyInh860ssTCEwIzugWIDn.nFNzPn_D0dCWhhy2d0T4OEJxTLK5sbsG
 80LqDwKU.FsOBlKcBDW8BnsfNfuryUw8vMByKDbnTuMQ4gxPzn5W4zunzdyfV9DocuqQ58rel8jd
 yJdK30WdwUBf_E9e7gFTqrStoFuxORKAZEKsFr5xxhIuL0x6Y4MV4WpmEuqb2KxBacotuswEJ._u
 BZjP5iUCPQHANlo5LOTuYg62zdyHz1byniU2587gJBQuK
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.ne1.yahoo.com with HTTP; Wed, 28 Sep 2022 16:34:09 +0000
Received: by hermes--production-gq1-7dfd88c84d-h7f6x (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID a2bdf6f43be4df31fa68c8e6e37af63a;
          Wed, 28 Sep 2022 16:34:08 +0000 (UTC)
Message-ID: <6ea0cd27-6076-4d49-1a93-cba1879f0ca5@schaufler-ca.com>
Date:   Wed, 28 Sep 2022 09:34:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v3 11/29] smack: implement get, set and remove acl hook
Content-Language: en-US
To:     Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org
Cc:     Seth Forshee <sforshee@kernel.org>, Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Paul Moore <paul@paul-moore.com>,
        linux-security-module@vger.kernel.org, casey@schaufler-ca.com
References: <20220928160843.382601-1-brauner@kernel.org>
 <20220928160843.382601-12-brauner@kernel.org>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20220928160843.382601-12-brauner@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.20702 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/28/2022 9:08 AM, Christian Brauner wrote:
> The current way of setting and getting posix acls through the generic
> xattr interface is error prone and type unsafe. The vfs needs to
> interpret and fixup posix acls before storing or reporting it to
> userspace. Various hacks exist to make this work. The code is hard to
> understand and difficult to maintain in it's current form. Instead of
> making this work by hacking posix acls through xattr handlers we are
> building a dedicated posix acl api around the get and set inode
> operations. This removes a lot of hackiness and makes the codepaths
> easier to maintain. A lot of background can be found in [1].
>
> So far posix acls were passed as a void blob to the security and
> integrity modules. Some of them like evm then proceed to interpret the
> void pointer and convert it into the kernel internal struct posix acl
> representation to perform their integrity checking magic. This is
> obviously pretty problematic as that requires knowledge that only the
> vfs is guaranteed to have and has lead to various bugs. Add a proper
> security hook for setting posix acls and pass down the posix acls in
> their appropriate vfs format instead of hacking it through a void
> pointer stored in the uapi format.
>
> I spent considerate time in the security module infrastructure and
> audited all codepaths. Smack has no restrictions based on the posix
> acl values passed through it. The capability hook doesn't need to be
> called either because it only has restrictions on security.* xattrs. So
> these all becomes very simple hooks for smack.
>
> Link: https://lore.kernel.org/all/20220801145520.1532837-1-brauner@kernel.org [1]
> Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>

BTW: The Smack testsuite is https://github.com/smack-team/smack-testsuite.git

Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>

> ---
>
> Notes:
>     /* v2 */
>     unchanged
>     
>     /* v3 */
>     Paul Moore <paul@paul-moore.com>:
>     - Add get, and remove acl hook
>
>  security/smack/smack_lsm.c | 69 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 69 insertions(+)
>
> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> index 001831458fa2..8247e8fd43d0 100644
> --- a/security/smack/smack_lsm.c
> +++ b/security/smack/smack_lsm.c
> @@ -1393,6 +1393,72 @@ static int smack_inode_removexattr(struct user_namespace *mnt_userns,
>  	return 0;
>  }
>  
> +/**
> + * smack_inode_set_acl - Smack check for setting posix acls
> + * @mnt_userns: the userns attached to the mnt this request came from
> + * @dentry: the object
> + * @acl_name: name of the posix acl
> + * @kacl: the posix acls
> + *
> + * Returns 0 if access is permitted, an error code otherwise
> + */
> +static int smack_inode_set_acl(struct user_namespace *mnt_userns,
> +			       struct dentry *dentry, const char *acl_name,
> +			       struct posix_acl *kacl)
> +{
> +	struct smk_audit_info ad;
> +	int rc;
> +
> +	smk_ad_init(&ad, __func__, LSM_AUDIT_DATA_DENTRY);
> +	smk_ad_setfield_u_fs_path_dentry(&ad, dentry);
> +	rc = smk_curacc(smk_of_inode(d_backing_inode(dentry)), MAY_WRITE, &ad);
> +	rc = smk_bu_inode(d_backing_inode(dentry), MAY_WRITE, rc);
> +	return rc;
> +}
> +
> +/**
> + * smack_inode_get_acl - Smack check for getting posix acls
> + * @mnt_userns: the userns attached to the mnt this request came from
> + * @dentry: the object
> + * @acl_name: name of the posix acl
> + *
> + * Returns 0 if access is permitted, an error code otherwise
> + */
> +static int smack_inode_get_acl(struct user_namespace *mnt_userns,
> +			       struct dentry *dentry, const char *acl_name)
> +{
> +	struct smk_audit_info ad;
> +	int rc;
> +
> +	smk_ad_init(&ad, __func__, LSM_AUDIT_DATA_DENTRY);
> +	smk_ad_setfield_u_fs_path_dentry(&ad, dentry);
> +
> +	rc = smk_curacc(smk_of_inode(d_backing_inode(dentry)), MAY_READ, &ad);
> +	rc = smk_bu_inode(d_backing_inode(dentry), MAY_READ, rc);
> +	return rc;
> +}
> +
> +/**
> + * smack_inode_remove_acl - Smack check for getting posix acls
> + * @mnt_userns: the userns attached to the mnt this request came from
> + * @dentry: the object
> + * @acl_name: name of the posix acl
> + *
> + * Returns 0 if access is permitted, an error code otherwise
> + */
> +static int smack_inode_remove_acl(struct user_namespace *mnt_userns,
> +				  struct dentry *dentry, const char *acl_name)
> +{
> +	struct smk_audit_info ad;
> +	int rc;
> +
> +	smk_ad_init(&ad, __func__, LSM_AUDIT_DATA_DENTRY);
> +	smk_ad_setfield_u_fs_path_dentry(&ad, dentry);
> +	rc = smk_curacc(smk_of_inode(d_backing_inode(dentry)), MAY_WRITE, &ad);
> +	rc = smk_bu_inode(d_backing_inode(dentry), MAY_WRITE, rc);
> +	return rc;
> +}
> +
>  /**
>   * smack_inode_getsecurity - get smack xattrs
>   * @mnt_userns: active user namespace
> @@ -4772,6 +4838,9 @@ static struct security_hook_list smack_hooks[] __lsm_ro_after_init = {
>  	LSM_HOOK_INIT(inode_post_setxattr, smack_inode_post_setxattr),
>  	LSM_HOOK_INIT(inode_getxattr, smack_inode_getxattr),
>  	LSM_HOOK_INIT(inode_removexattr, smack_inode_removexattr),
> +	LSM_HOOK_INIT(inode_set_acl, smack_inode_set_acl),
> +	LSM_HOOK_INIT(inode_get_acl, smack_inode_get_acl),
> +	LSM_HOOK_INIT(inode_remove_acl, smack_inode_remove_acl),
>  	LSM_HOOK_INIT(inode_getsecurity, smack_inode_getsecurity),
>  	LSM_HOOK_INIT(inode_setsecurity, smack_inode_setsecurity),
>  	LSM_HOOK_INIT(inode_listsecurity, smack_inode_listsecurity),
