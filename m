Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8F895ED0E0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Sep 2022 01:15:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231823AbiI0XPo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Sep 2022 19:15:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbiI0XPn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Sep 2022 19:15:43 -0400
Received: from sonic304-28.consmr.mail.ne1.yahoo.com (sonic304-28.consmr.mail.ne1.yahoo.com [66.163.191.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FA00E8D95
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Sep 2022 16:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1664320540; bh=N1+ZIo9TbKcqDQ5rFjbCt6U4JF2yW5ERfW0z48+hWF0=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=iVHMejBFX/+V68heYIcUFxNOqBm9asKcnHFErI+zoCVtrTC0fpjUXtpkFQrND+8im47nzCvUyPKxYXO+wN5ytS0j4IEXEXjzkYeBx0uN173iklp8b+5bH4BYIfqf2Ie4bFgDsHgKB78cokYQ9ItskKnMrYIpoPKPK2j1jzwBiF//dJJk3bz2R5xxIj6bWbkvsvSfvFChsXMVKnTT9t739m73Y/Qk6KWrZQ4djBqzh3Ru/vOU/W2g8jaG0zV+IzBslKpIIcpOxNHcl/GmOTdjuBXGXvyObtunIJY4M90kdvpCNPJSrL/g+wmAF7eK8Dv5+hEfiX8OCeFcLIUUjdk1rg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1664320540; bh=SyRRkdLWaJJxZ0HiA4fSMERItv2ynZVB4STd+qTUubw=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=jTUQeI8AX2B+6cAfT7J50SNspYCLlNx6pwrDf6jKQHyBXW5pEVmBEA4M0FGhjZAEcs4SPOuUJQCSDiW88h0D8Dgd6qZnixhSOvx/JB2xbwtbEY8Nvp6ZxMx6g9LppJqmkAaI1RKYSNWtWaiXX0r3tkEjI9IaiUzUbY15xSHql7Cp01zVN5topetUlW2GY9uDKGYxtNGcbJ1O8BwhUG1y9vxchxmgTBxO19fkhF8nP3jxQ+w6TcyTswsXsNleZ+3M/CgMvN8ScFGmguLlM5P3c8okTb3rNHm8JrlsAhTBRF+Bw1mmrErxvyKceIVbuUQGsMjZMsB8U1cY5NcoGqz8EQ==
X-YMail-OSG: BfsSpZIVM1nqh0DHj1bT23Lr1EEaSD5dU2yuY18IGqhTBF_XjYS6TqDZJgcnBoy
 8G1BmgT.4xHDrOHkxtTC6KXYaPm2Q8wIns4zSxKq1bJhtpDKAln9Bniq8gPTvV8s.eD6tEewbmRj
 kL7JJ78BdN9CSeaCZKE6L8aGX1c7805KzaaFHqeNPWi5RdWKbV8iglKUtmecl38r3HDq6.YXn8rZ
 vrlfLEMgpSY24iz9evgrlFI1bj9leSik8HID92rrLWW3fhqZnUaWsLKpfim7cmRsMGfL1MAtiEqy
 GZpbQxR2hMMiQFcvsymGxW2KXKuBkJ_f2KFqHSSgeN001FIm9.nu4Wu2oWLefLKeZWjxqYsUXkNh
 2yyvUhmJjRgY2KCLk.TvUiQ1g3N0PnC3Iz1D6HS6Szl6Jrjc5wVkTLT8dQDZUVM1ClQ.BTSB7yyf
 Mus4iT46oOCe5NpFYXHJadiYy8bNGip4xV0DaPVZtlZqnda5xF2ZOK.wkKwB4xGbNAZufMLyvR3z
 Oz_DFA9rt00hmPSea6t6p3160RCB04ab1zKFjw5jVE2I7m.4tvoUrkWF9HYbVjIR1oZxPLLM96LO
 YIcGYjTPvM6bFhEbMnk3kfubqD5ztG_OgpT_2cbjfjMQlUTAj6b6wzBu.mW47mctlR5AYLahtFsn
 LwRlD3An_i6JyJ45r8eAkfTqkPOdWvgrv4f6.9Wvj.uzF25XecL9dC_ixug6GO_rOHR7EmLz3MSv
 hQdVhBXrRFI0yLXb_3GkZq4zqvqr9Ah1I7qp6FmIen8OzczJNfqaxZWtBZdUPyFfzEc8KZbwMQfH
 iy9ieQk_v2iMuHd8W2HDavYuVdg1aP72eWJB9O6ya1oxtq6vw16BuNUUqHxkRYmZ.dkqRXQc97Fq
 z_STuesErAO2pHprnlfBVbcAdmatDjXjHFrcjayfr8RtCvzmpdMql59ZnH_PDrx2QMIDvGv1NMI4
 x2oUyXTTNkxTlwC8Z0VqxvAz4kKIbQ.GdRPrr4Arkvioue8S9jB.LSzgVEetICPb6aYXadGwDmCy
 RKo7fzoXFC4isZQUMjiq_0c8rqhBZn0BpoEdOVSglLdu1l8ewZzxOXBk3ODQb1jN8DunUeeNFQkW
 QQ7HFIS30UPmadmI0r1ljEH2bjRe5PcVP1Afue0SKKyhA.gtLVFZ0APYQjJfsArYKVOkXCeb35X8
 .xwKhqe5nAVsQrfGVHrODv4Hr.fGSoeZoNvAt8PM3_K7gXlgmeUSYLY4SI1c2KgPonFJMFbm7o__
 16YTicANGlZ7zgIyunIdX5ytSbads6h0RFUTu0tghoiNUsq8XljgSIiuVQBjhv3vEHPSpEYJ0On.
 ihRZwA.nSp3PyZ_7NfjfOUW3K8uRZGlxab2wa.Sw7mzjJwjGuu0k1roQQWQekJYllJlAC0N96Z5r
 qsQC4pG5iyVrq1JjzJNTeDs72g1qRFwsin_dyCkGFRt01VliD33o3XKKylJRIOTWv9I5mllPXdaD
 _EzggUR_MHpC_6oYCs8x1jQYF8q.xj5U0XtcJmyuDBadxlOneA09PJTNKgNEel5fRo6gWqjl1w9g
 q1X.SSjxO5zHo0oZYbFrFF5qC02ylMeJTKBybRG_pc6enw2tWF4hova762.PPVnPAWGImnbxwhZw
 G5piyHj3znTdPE0PyuAUqRBSOPX9ICItyZzWvOj4NUNMSn.SHAxi.yh9i8ck1XgVfbr7m2_G2dFy
 NV.JA5MzvVDUcPk4EjBgtnzvssaaEE9GAPiWYZl_2Pk.ngUi66s7GeiEJhpAlEHmzUW83EJiV5Cm
 UxJJPKkjwuCVkwBL7q9.S4HUkHVk7QiJTSbEJlAf6BOCQl2BB3UGbEG8q2IdbKL.AtRlZJBi4e1n
 hiTiwOR3Hn.ZSFfzCNEkFMH_us1w5p4ypLQdz63hqKrQkYpuoMzJEOTuHRneLs4Iydqz3GZX03Xw
 qwm8Wv.oX1viNr1z06nVqMoMqUYUqDoyI0vqItFl8vXcMLa6IL7gSMm31GMoooPIw5y2k8_pSaI4
 V.8aBYQbRREONgXkC7Yu3hQ5BnpoWrt4ddZqc_CmNEGTqHQ6BfxQadClqwFJ9Tb5DwQIpeR0kDcG
 5MpiSBjt8goIznTkk4OJyY_ZgYSGtNipEJYyqBccGl2d2x12SW6IWAVBrIjImCie3rGlBr3oZWn3
 LRoz2aFG.jqnLMPmDAWBl.Gtw3qlqj6I9Nhpx0uUigc.08DZO6BODn2w.ClMkuiQJXAaq4f5IYn0
 xWKax7u5A0sErdRidIKtSKeqWr3qKZtzF5H0LYa1QJ5rE58DXegxnm6FyEoYA0o2_lfgNmTxBYgx
 BkAX3nxEiz6191q4HjhGsbiUFYwkV8ytiUkwN4Fpm67V7Bg--
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.ne1.yahoo.com with HTTP; Tue, 27 Sep 2022 23:15:40 +0000
Received: by hermes--production-bf1-759bcdd488-mc79z (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID aa3837e369269596f7dd6b5d88f196ef;
          Tue, 27 Sep 2022 23:15:34 +0000 (UTC)
Message-ID: <4385f332-8b49-827f-502c-5458e14224ef@schaufler-ca.com>
Date:   Tue, 27 Sep 2022 16:15:32 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v2 12/30] smack: implement set acl hook
Content-Language: en-US
To:     Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org
Cc:     Seth Forshee <sforshee@kernel.org>, Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-security-module@vger.kernel.org, casey@schaufler-ca.com
References: <20220926140827.142806-1-brauner@kernel.org>
 <20220926140827.142806-13-brauner@kernel.org>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20220926140827.142806-13-brauner@kernel.org>
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

On 9/26/2022 7:08 AM, Christian Brauner wrote:
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
> this all becomes a very simple hook for smack.
>
> Link: https://lore.kernel.org/all/20220801145520.1532837-1-brauner@kernel.org [1]
> Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>

The Smack hook looks fine.
Acked-by: Casey Schaufler <casey@schaufler-ca.com>

> ---
>
> Notes:
>     /* v2 */
>     unchanged
>
>  security/smack/smack_lsm.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>
> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> index 001831458fa2..ec6d55632b4f 100644
> --- a/security/smack/smack_lsm.c
> +++ b/security/smack/smack_lsm.c
> @@ -1393,6 +1393,29 @@ static int smack_inode_removexattr(struct user_namespace *mnt_userns,
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
>  /**
>   * smack_inode_getsecurity - get smack xattrs
>   * @mnt_userns: active user namespace
> @@ -4772,6 +4795,7 @@ static struct security_hook_list smack_hooks[] __lsm_ro_after_init = {
>  	LSM_HOOK_INIT(inode_post_setxattr, smack_inode_post_setxattr),
>  	LSM_HOOK_INIT(inode_getxattr, smack_inode_getxattr),
>  	LSM_HOOK_INIT(inode_removexattr, smack_inode_removexattr),
> +	LSM_HOOK_INIT(inode_set_acl, smack_inode_set_acl),
>  	LSM_HOOK_INIT(inode_getsecurity, smack_inode_getsecurity),
>  	LSM_HOOK_INIT(inode_setsecurity, smack_inode_setsecurity),
>  	LSM_HOOK_INIT(inode_listsecurity, smack_inode_listsecurity),
