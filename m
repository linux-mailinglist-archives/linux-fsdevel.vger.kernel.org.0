Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9765E1934C0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Mar 2020 00:49:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727460AbgCYXtV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Mar 2020 19:49:21 -0400
Received: from sonic307-16.consmr.mail.ne1.yahoo.com ([66.163.190.39]:42412
        "EHLO sonic307-16.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727420AbgCYXtU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Mar 2020 19:49:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1585180158; bh=iB4QO2xpcy8z3Txx1jPJgB74/wRX3hSgbjzkB+XNUwQ=; h=Subject:To:References:From:Date:In-Reply-To:From:Subject; b=pqDtOzTmIr80hamOnVtFisWaduCQ2/ogyXTEG+cG/AsJ4q1nDGo1UTh2dAoF1tBbQnKxBRU/JTRhVdoejzOZsPbf0okOzjix1wQOlItSxPqLJjDO85+m4HV59XGNdY+qkAb5ggNDWoL5a39Cl0qp9KncTYtnmNrh93H0RF/+m4UINu6uYg2t4x4ZTtlrsC2g0OsbtATGzLvljxIE5KtgOoG9tle0x81V6nTB8nofySWTw7OhAX0Me9D9RadT/uAhylm0LvQFGordtyC0T+PxYBg2bkQH3gcophcc3lhC97dxBnzGlQ0MtoLlXsFkXn7KuyPsvnDcC0VaBFKmQky52g==
X-YMail-OSG: rTZDQN4VM1kejYoFLE.vQK84bqq5OBrJk2Nyvv82C5_S8cvQCtmP4iMbk61fwGM
 cYodcunZTUBKewV7ZQOSHsbmiK1KuBlvNdSHSy9gkmzy0XVckEBujyFtm8OwB7ZHRMY60Fs0KmoX
 .Ikx.JWmqUPaoFsY4xfeKYOWGY_2Nx4e.0M3LCtUkXXDihBaJUQzm.7MZQlp8Lf5CR.DpOx3o8yo
 DtJU55nO5CEy0M7RLpSjUCz_3j1M1jUI7FDA984qk4HwJODUetgoAYxzuiWB8zkPqsX14_GCoGlW
 Rjr2Fa.hmONjhmqE20WtnX1CbTTQbA1tv4fLTF20O6xJ7Axg0lf4.fdKoOP8HXG8PHQzAMtTYVMe
 6wAkOtDWqKE9BY75hrYyjg1hs91jjuUAub0M5YAswT7mVXqrOsM88tCLnQDzAf2Pe0Tx.knkgNf3
 LvYPuB0VPs.UokxQN7t9Ue2ERTwf_OUM26rLgoDGtaX46EqRKyWf_gLWFpqyk5FUUAWc80A.RrFR
 ImMPNao3ugZrXh13qMXM9IcnwHKJF5W8d7N5OBYF_mZ4hch1MSw3tvNw9s98H1XRoZZCQxoohdei
 rSd3ZmNnUbQZb6Zt_b11QieY5BxBe_jui41SBCFKaspaXQ0cG.kGGXjlv8gR6UChdGep9QNrnMFF
 pr9OoPjNwana2TmYVvlNfxJozUIi5gbAbQlRR0QrQ4palNw.gVGW_r._.sY3eahGH4Ns4j.cWWX8
 KYlU8RMGgOIJBAd2jQ93o83wtSNM3TmQEo9Br7XuNG_l_4a4yA1_6ZSNCX9V.sH.uDjxRI35Bc0o
 ReTglBNEe594BIucTIhmTwhm2hTB_N28N2ujt.djM68aZ5rqMHE6IL.luf2C3uu6KjBPlUihEKDB
 8bvXYNDH8TyAcirgtsAwkei9zamB7K1H9_KU_IvV1jtNaD9.xYyNf0N58mKoLY.thf51gxsndeyZ
 3e0d0ybTspHQE87AcDc0mtYAK.6KlxBwjcZJpE0GleApekQnrd4L8QCx86kNTsgtefU1_923BgS.
 KNl6muiVRQFQ0WOihWBMfZkodTMJfSfyG_gsehDLLWMkuC4JpJP.J1NFoI4iP_L5di1if.dQgq4s
 f.AoVUfMEtaILafvn4Aoo88_mmCQEOplZvgadCD0OPH2jPuqht7_HgLH5QrJN5o_tD2TiQl0wjSO
 5uMXgUJNWMK2y1dddMm7cs.5lBrPL6teVC_nzm6hj2C5B3A_v5SdcH2hfONImjDeG1evPnzkaBS9
 Gh.cDSIU93Kk_lSgB6Aw2XEKP1qJjDlK5Jxkxu_kQl1g_pd4gUYyYoNkwcMexFRmc66iYIOhRRMP
 EAKQB1sIGtVcPEZodbC.EBUN7dXQvoWGKYtm4Gjkq253XsqC_8ldVsNQjPkldDw5VRxRPggjWYrV
 .KVtR8VeDSea_BZYynN_RY.ZO_gTvHRvIOLswXZG9
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.ne1.yahoo.com with HTTP; Wed, 25 Mar 2020 23:49:18 +0000
Received: by smtp403.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 45a1b035f502c324341a01a9b5e8669b;
          Wed, 25 Mar 2020 23:49:16 +0000 (UTC)
Subject: Re: [PATCH v2 3/3] Wire UFFD up to SELinux
To:     Daniel Colascione <dancol@google.com>, timmurray@google.com,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, viro@zeniv.linux.org.uk, paul@paul-moore.com,
        nnk@google.com, sds@tycho.nsa.gov, lokeshgidra@google.com,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20200214032635.75434-1-dancol@google.com>
 <20200325230245.184786-4-dancol@google.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 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
 abzjfg==
Message-ID: <a8d0938c-6ab5-0323-8e98-35e7d3232282@schaufler-ca.com>
Date:   Wed, 25 Mar 2020 16:49:14 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200325230245.184786-4-dancol@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Mailer: WebService/1.1.15518 hermes Apache-HttpAsyncClient/4.1.4 (Java/1.8.0_242)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 3/25/2020 4:02 PM, Daniel Colascione wrote:
> This change gives userfaultfd file descriptors a real security
> context, allowing policy to act on them.

You should change the title to "Wire UFFD up to secure anon inodes".
This code should support any LSM that wants to control anon inodes.
If it doesn't, it isn't correct.

All references to SELinux behavior (i.e. assigning a "security context")
should be restricted to the SELinux specific bits of the patch set. You
should be describing how any LSM can use this, not just the LSM you've
targeted.

>
> Signed-off-by: Daniel Colascione <dancol@google.com>
> ---
>  fs/userfaultfd.c | 34 +++++++++++++++++++++++++++++-----
>  1 file changed, 29 insertions(+), 5 deletions(-)
>
> diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
> index 07b0f6e03849..78ff5d898733 100644
> --- a/fs/userfaultfd.c
> +++ b/fs/userfaultfd.c
> @@ -76,6 +76,8 @@ struct userfaultfd_ctx {
>  	bool mmap_changing;
>  	/* mm with one ore more vmas attached to this userfaultfd_ctx */
>  	struct mm_struct *mm;
> +	/* The inode that owns this context --- not a strong reference.  */
> +	const struct inode *owner;
>  };
> =20
>  struct userfaultfd_fork_ctx {
> @@ -1014,14 +1016,18 @@ static __poll_t userfaultfd_poll(struct file *f=
ile, poll_table *wait)
>  	}
>  }
> =20
> +static const struct file_operations userfaultfd_fops;
> +
>  static int resolve_userfault_fork(struct userfaultfd_ctx *ctx,
>  				  struct userfaultfd_ctx *new,
>  				  struct uffd_msg *msg)
>  {
>  	int fd;
> =20
> -	fd =3D anon_inode_getfd("[userfaultfd]", &userfaultfd_fops, new,
> -			      O_RDWR | (new->flags & UFFD_SHARED_FCNTL_FLAGS));
> +	fd =3D anon_inode_getfd_secure(
> +		"[userfaultfd]", &userfaultfd_fops, new,
> +		O_RDWR | (new->flags & UFFD_SHARED_FCNTL_FLAGS),
> +		ctx->owner);
>  	if (fd < 0)
>  		return fd;
> =20
> @@ -1918,7 +1924,7 @@ static void userfaultfd_show_fdinfo(struct seq_fi=
le *m, struct file *f)
>  }
>  #endif
> =20
> -const struct file_operations userfaultfd_fops =3D {
> +static const struct file_operations userfaultfd_fops =3D {
>  #ifdef CONFIG_PROC_FS
>  	.show_fdinfo	=3D userfaultfd_show_fdinfo,
>  #endif
> @@ -1943,6 +1949,7 @@ static void init_once_userfaultfd_ctx(void *mem)
> =20
>  SYSCALL_DEFINE1(userfaultfd, int, flags)
>  {
> +	struct file *file;
>  	struct userfaultfd_ctx *ctx;
>  	int fd;
> =20
> @@ -1972,8 +1979,25 @@ SYSCALL_DEFINE1(userfaultfd, int, flags)
>  	/* prevent the mm struct to be freed */
>  	mmgrab(ctx->mm);
> =20
> -	fd =3D anon_inode_getfd("[userfaultfd]", &userfaultfd_fops, ctx,
> -			      O_RDWR | (flags & UFFD_SHARED_FCNTL_FLAGS));
> +	file =3D anon_inode_getfile_secure(
> +		"[userfaultfd]", &userfaultfd_fops, ctx,
> +		O_RDWR | (flags & UFFD_SHARED_FCNTL_FLAGS),
> +		NULL);
> +	if (IS_ERR(file)) {
> +		fd =3D PTR_ERR(file);
> +		goto out;
> +	}
> +
> +	fd =3D get_unused_fd_flags(O_RDONLY | O_CLOEXEC);
> +	if (fd < 0) {
> +		fput(file);
> +		goto out;
> +	}
> +
> +	ctx->owner =3D file_inode(file);
> +	fd_install(fd, file);
> +
> +out:
>  	if (fd < 0) {
>  		mmdrop(ctx->mm);
>  		kmem_cache_free(userfaultfd_ctx_cachep, ctx);

