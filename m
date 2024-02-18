Return-Path: <linux-fsdevel+bounces-11961-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58F2F8598FF
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Feb 2024 20:13:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8A8BB21288
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Feb 2024 19:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5391A6F53E;
	Sun, 18 Feb 2024 19:13:01 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BD091D696;
	Sun, 18 Feb 2024 19:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708283581; cv=none; b=gsiv0VJAG4RCsysNDJFVqXx5ffkInEi7JYXaZrGWOq3VXNmDdroURF9D5q6LR4pHZlwbjaIw1Aq/CUeeBcddNGcGkVOis6keE+ZmLzius+mCT6fpuH3ylO67amektZwh/3QJPP2GHvuJH3c7iqqEMivQBAPr0CtU24Obgt7SusM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708283581; c=relaxed/simple;
	bh=zO/LuEh8ruW5c8elMQENCvHE5l8w1EYu5MI98z83Z88=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IchtMZp5E/kqOvmknycNQKCmkPraO/B0gMFAxrYecqOYbZ0jGdpAqSP1P6qZdcIJy646A+M3if4TyFdtb36sa/B4TycPc5y1IrQIlilMcRUjB37UsZb5SpnwzrLtnVGCUCnyGD2L2w56BRsXjv/RvYy3S/rDdlr98krSUX4WLZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de; spf=fail smtp.mailfrom=denx.de; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=denx.de
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id DA44B1C006B; Sun, 18 Feb 2024 20:12:56 +0100 (CET)
Date: Sun, 18 Feb 2024 20:12:56 +0100
From: Pavel Machek <pavel@denx.de>
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Kees Cook <keescook@chromium.org>,
	Kentaro Takeda <takedakn@nttdata.co.jp>,
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Eric Biederman <ebiederm@xmission.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, mingo@redhat.com,
	peterz@infradead.org, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, surenb@google.com,
	michael.christie@oracle.com, mst@redhat.com, mjguzik@gmail.com,
	npiggin@gmail.com, zhangpeng.00@bytedance.com, hca@linux.ibm.com
Subject: Re: [PATCH AUTOSEL 5.10 7/8] exec: Distinguish in_execve from in_exec
Message-ID: <ZdJWuMifIiNnrLbZ@duo.ucw.cz>
References: <20240202184156.541981-1-sashal@kernel.org>
 <20240202184156.541981-7-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RWb6j82WY1Y0XPxm"
Content-Disposition: inline
In-Reply-To: <20240202184156.541981-7-sashal@kernel.org>


--RWb6j82WY1Y0XPxm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: Kees Cook <keescook@chromium.org>
>=20
> [ Upstream commit 90383cc07895183c75a0db2460301c2ffd912359 ]
>=20
> Just to help distinguish the fs->in_exec flag from the current->in_execve
> flag, add comments in check_unsafe_exec() and copy_fs() for more
> context. Also note that in_execve is only used by TOMOYO now.

These are just a whitespace changes, we should not need them.

Best regards,
								Pavel

> +++ b/fs/exec.c
> @@ -1565,6 +1565,7 @@ static void check_unsafe_exec(struct linux_binprm *=
bprm)
>  	}
>  	rcu_read_unlock();
> =20
> +	/* "users" and "in_exec" locked for copy_fs() */
>  	if (p->fs->users > n_fs)
>  		bprm->unsafe |=3D LSM_UNSAFE_SHARE;
>  	else
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index aa015416c569..65cfe85de8d5 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -806,7 +806,7 @@ struct task_struct {
>  	 */
>  	unsigned			sched_remote_wakeup:1;
> =20
> -	/* Bit to tell LSMs we're in execve(): */
> +	/* Bit to tell TOMOYO we're in execve(): */
>  	unsigned			in_execve:1;
>  	unsigned			in_iowait:1;
>  #ifndef TIF_RESTORE_SIGMASK
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 633b0af1d1a7..906dbaf25058 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -1452,6 +1452,7 @@ static int copy_fs(unsigned long clone_flags, struc=
t task_struct *tsk)
>  	if (clone_flags & CLONE_FS) {
>  		/* tsk->fs is already what we want */
>  		spin_lock(&fs->lock);
> +		/* "users" and "in_exec" locked for check_unsafe_exec() */
>  		if (fs->in_exec) {
>  			spin_unlock(&fs->lock);
>  			return -EAGAIN;

--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--RWb6j82WY1Y0XPxm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZdJWuAAKCRAw5/Bqldv6
8vEZAKCsYpt/9YYcVItFN4Cb+Qx3eGNUzACePikZNygBi7iNKiPV0JHUidFNPlk=
=Wlsl
-----END PGP SIGNATURE-----

--RWb6j82WY1Y0XPxm--

