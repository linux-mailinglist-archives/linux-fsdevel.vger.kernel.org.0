Return-Path: <linux-fsdevel+bounces-77922-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6GpoEiwgnGkZ/wMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77922-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 10:38:52 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A9601174077
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 10:38:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E0BB830432EB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 09:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BE6034F244;
	Mon, 23 Feb 2026 09:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lvjUXwJM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58E6B34E75E
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Feb 2026 09:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771839328; cv=pass; b=WyZvCZ5FMzt7yJxVIwo/sEMLP4GQ3lbT9MEJqgHLlZ+I2RYhBNyNM29qLQNpxFHRAPuxC8mbzS87lAibvD8w2bZk6Ou6qHJ3WqL4sy3XvX1j4ppakVWOZu2THpGwHE8ZGmZqDU86m94jh1d1L3+4t2r7HfGpuHp/YMVh8+pGYn4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771839328; c=relaxed/simple;
	bh=mAAOjC5VpT1HkXsRAwtGw0eUE/35I2Skqe677nArRZE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tvgkJLyGgNlE1jxFTKHuF08XuXeEBoAUS0TNyQ8C92mJWOkTP7B5gJU5lp8sLYPO1kpmLGclvSLrKHfdfAs+Ubh/L9pS4wrXmXL//b23kWDu+uvxuXxVklM4Lrc947eLv1Zz+dk4skdPpfBcJPUEcbgWivlCGjjmcSlDDsdyjfc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lvjUXwJM; arc=pass smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b8f992167dcso505137366b.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Feb 2026 01:35:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771839326; cv=none;
        d=google.com; s=arc-20240605;
        b=ATBzaZGi5N7dqyoFA4qmxLZdOn8+wlhiYO3wAKvozBK+cV1EdFpno4ow0+1N46E0mk
         VAU37Cq1hHwSa9lrbKT/68E7TCZ+f849wuIKn7TOr+xvUuK+COc+D8ZhN6PbIwmNxhD7
         iLpoAB/za9yx2/MBOuIQD7WtzcE78GzueAMwDwIkEK4x9La1lmoFXr3mn0QDz1T76TEF
         HV8aOKPxpjGknafnGmXpeEOkjo1J8sxQmvUS758/nkUJNb/g5obTMCU0uYKCguEWBLnb
         uzQS4De+CmOI+dTkzXnbj1gZcvuztbc5xum3Ql5okUSsghjgvlIpGkzvp2uPzWTqyFXe
         dY0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5/tsVKpvOF9hjEuBModNYiVpSPXtrrKrMQ519faKcis=;
        fh=Hgs3b3wv98Ut44sItKW5SdhcT4ad1br3zpiltembkdQ=;
        b=Y2LTo5FQqdDtwO1NmcPvUaWlX5mrJl8jDjuSsTvo2uGZS9ECUohpQSfNaFexmV+04M
         BmS0hi1/ZQUIn5V3bOj/jk5wiMtVETXVw2KniCeR5y/dtXXG1mqAB/1a/scivE+k65z4
         t8cixtZF6aJRA11kfoSvWLFBOFpIxwak6hFQwd3AhwIMR6/KbXr450tCbwfCsAhG8xEC
         MgfXGaTQDH9nuxln0spsim7jDoRZNJ2OkYgheJ/pCXlOIQFGvCHtqgTM2OYEDTMylJnn
         swmiQZmtMQ5GHUt3HPqG9Cw0UF9qF31q4/QpJiv5WmTJ1nWDRvVssew8D+FpTTLb1RBe
         PYlg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771839326; x=1772444126; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5/tsVKpvOF9hjEuBModNYiVpSPXtrrKrMQ519faKcis=;
        b=lvjUXwJMFDUVNdE9/6JGFIIEgXAr+NW/nxJYiNKP83A2h2rSdOYnS2Qap5SEi8qvuc
         Xvv8mX7Ib5UTjZ2Ntgfe8sP1Y8sbStPRBVlVXYlUG96b6S34FcSJuKZLdABzCTwQSawB
         6kEeAv1Xy3QQTZBXYrCOuzdG6KW4vFjs2HUXgSqvz4TtzIzp1VaFIlsTAa6b5Sp1Jd34
         8+G7qchOZolFb2NrtqZ2ma6izvwW8ElQncc0YNDtZAtfeVwNdlTIquDlE1K/HvvMVBW5
         MVSWix+ReYo/KfT3GNcH4MXXhrxRSIQZW2RW+9DJtcTlAkJOfHQiKIYj+U2ejfaspoaD
         g7tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771839326; x=1772444126;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5/tsVKpvOF9hjEuBModNYiVpSPXtrrKrMQ519faKcis=;
        b=rx+FIsJaNLQXfZ7Ux2JXftZ9MoGGY5AwzI4nWFDH3pwmF82auXnDSoT5fJfiTKaYE+
         kCxaQDgo6Hjozdh6E+vrbcPLgFtfEM4/TMGiXrNlCaJMXN/EhPuui5BH994gC8ZeHNwn
         MhojxpInZ4/EQmecvYjy4BnTJDW1+850Qxs7TEgMhc/63V1/7V+jdr8GWHcmw/md6zWJ
         j0FAJDJGd5a5NwvPsv7B1ETzH1FKn0AHS8gyIjhPk7GmzATC9lnFO+a1oYOY4IojVqTa
         fFDwPYPZEuKjLRlJ+ueMAa1SG/scXXnMaiJWSTYvL0mp+0iU7OEKE7JT5hFlDdDrEFte
         9Xiw==
X-Forwarded-Encrypted: i=1; AJvYcCVb8uzkGXBQTg3DNPXZO5WwKBqJuMCpZcfDemTLy+LsJFePIozFJxCODcLHR8QZ0OlO1aPoOiXANN5N+tDu@vger.kernel.org
X-Gm-Message-State: AOJu0Yzain1TACEUEMNHigZxGKd3yfpt3sJJ8W6kPrQWnhLlvh3fsXw3
	hbo2BZDAimTsyyWaUjF/0XKlKk4H8I/hEkwxlDkhDLRhUBK6f8W1u4YUsqgaBdc/PaQprhqEYa3
	mfbiu+A0y9ij6bgwgEw7woEOrt8mSpbc=
X-Gm-Gg: AZuq6aLsHSUbzHx6Ko5V+Ln4CKklcDZCpRllCgHCJVy3Vrfrq0CoPOg6k1zT4/oqRtD
	VnUpuvgBmr1wO3amV0+6Cx1MfK/s2R2ph3x8mBQwFLUu/qzFJqRQDUIew9FnIvUrOdVLMY9pRfA
	g2d7y7MxiDW1OTp7OdyhX0AWlLF+BSgZTSfGTmD0zoBUXpr4dg/K9k7xf9ZYOGuQHwB41r6Pp2B
	d8QvggIAC1wtu6HjO6K2ndXMRzH/bqA8j+GCONI5UvrfBqQNyzjOXQ16BotbF0+r9YSmQDoDw2v
	hwhZ65KqtyYFkaGRcrJO1bzZN8jqE7Vz+IxOKh8/Tw==
X-Received: by 2002:a17:906:7307:b0:b88:5002:50c0 with SMTP id
 a640c23a62f3a-b90819db296mr564028666b.20.1771839325394; Mon, 23 Feb 2026
 01:35:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260223011210.3853517-1-neilb@ownmail.net> <20260223011210.3853517-12-neilb@ownmail.net>
In-Reply-To: <20260223011210.3853517-12-neilb@ownmail.net>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 23 Feb 2026 11:35:14 +0200
X-Gm-Features: AaiRm51zLgcrRbPb_4HmwkH5uY0J9aukMWrvlX2vP_E-cCHRJFMZshxY7_A02Xw
Message-ID: <CAOQ4uxibL=2Z0FZMz5wMAo=JMaJouOVo3p7t3Fi3FR59U5Tu=g@mail.gmail.com>
Subject: Re: [PATCH v2 11/15] ovl: pass name buffer to ovl_start_creating_temp()
To: NeilBrown <neil@brown.name>
Cc: Christian Brauner <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	David Howells <dhowells@redhat.com>, Jan Kara <jack@suse.cz>, Chuck Lever <chuck.lever@oracle.com>, 
	Jeff Layton <jlayton@kernel.org>, Miklos Szeredi <miklos@szeredi.hu>, 
	John Johansen <john.johansen@canonical.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, "Darrick J. Wong" <djwong@kernel.org>, 
	linux-kernel@vger.kernel.org, netfs@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, apparmor@lists.ubuntu.com, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77922-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[22];
	FREEMAIL_CC(0.00)[kernel.org,zeniv.linux.org.uk,redhat.com,suse.cz,oracle.com,szeredi.hu,canonical.com,paul-moore.com,namei.org,hallyn.com,gmail.com,vger.kernel.org,lists.linux.dev,lists.ubuntu.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[amir73il@gmail.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[brown.name:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: A9601174077
X-Rspamd-Action: no action

On Mon, Feb 23, 2026 at 2:14=E2=80=AFAM NeilBrown <neilb@ownmail.net> wrote=
:
>
> From: NeilBrown <neil@brown.name>
>
> Now ovl_start_creating_temp() is passed a buffer in which to store the
> temp name.  This will be useful in a future patch were ovl_create_real()
> will need access to that name.
>
> Signed-off-by: NeilBrown <neil@brown.name>
Reviewed-by: Amir Goldstein <amir73il@gmail.com>

> ---
>  fs/overlayfs/dir.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
>
> diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
> index ff3dbd1ca61f..c4feb89ad1e3 100644
> --- a/fs/overlayfs/dir.c
> +++ b/fs/overlayfs/dir.c
> @@ -66,10 +66,9 @@ void ovl_tempname(char name[OVL_TEMPNAME_SIZE])
>  }
>
>  static struct dentry *ovl_start_creating_temp(struct ovl_fs *ofs,
> -                                             struct dentry *workdir)
> +                                             struct dentry *workdir,
> +                                             char name[OVL_TEMPNAME_SIZE=
])
>  {
> -       char name[OVL_TEMPNAME_SIZE];
> -
>         ovl_tempname(name);
>         return start_creating(ovl_upper_mnt_idmap(ofs), workdir,
>                               &QSTR(name));
> @@ -81,11 +80,12 @@ static struct dentry *ovl_whiteout(struct ovl_fs *ofs=
)
>         struct dentry *whiteout, *link;
>         struct dentry *workdir =3D ofs->workdir;
>         struct inode *wdir =3D workdir->d_inode;
> +       char name[OVL_TEMPNAME_SIZE];
>
>         guard(mutex)(&ofs->whiteout_lock);
>
>         if (!ofs->whiteout) {
> -               whiteout =3D ovl_start_creating_temp(ofs, workdir);
> +               whiteout =3D ovl_start_creating_temp(ofs, workdir, name);
>                 if (IS_ERR(whiteout))
>                         return whiteout;
>                 err =3D ovl_do_whiteout(ofs, wdir, whiteout);
> @@ -97,7 +97,7 @@ static struct dentry *ovl_whiteout(struct ovl_fs *ofs)
>         }
>
>         if (!ofs->no_shared_whiteout) {
> -               link =3D ovl_start_creating_temp(ofs, workdir);
> +               link =3D ovl_start_creating_temp(ofs, workdir, name);
>                 if (IS_ERR(link))
>                         return link;
>                 err =3D ovl_do_link(ofs, ofs->whiteout, wdir, link);
> @@ -247,7 +247,9 @@ struct dentry *ovl_create_temp(struct ovl_fs *ofs, st=
ruct dentry *workdir,
>                                struct ovl_cattr *attr)
>  {
>         struct dentry *ret;
> -       ret =3D ovl_start_creating_temp(ofs, workdir);
> +       char name[OVL_TEMPNAME_SIZE];
> +
> +       ret =3D ovl_start_creating_temp(ofs, workdir, name);
>         if (IS_ERR(ret))
>                 return ret;
>         ret =3D ovl_create_real(ofs, workdir, ret, attr);
> --
> 2.50.0.107.gf914562f5916.dirty
>

