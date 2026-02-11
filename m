Return-Path: <linux-fsdevel+bounces-76928-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UHF2O5hEjGlxkQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76928-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Feb 2026 09:58:00 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5808E122760
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Feb 2026 09:58:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D5474301E3C4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Feb 2026 08:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C16351BBBE5;
	Wed, 11 Feb 2026 08:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gUVcwaIG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13521309F1D
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Feb 2026 08:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770800259; cv=pass; b=Wi3lj3CEOaQdLfyXC4mddWy1A1e+SeqBP4C2fas8KVx+vdFHVUug3Cvfu06r3vuhVapQGDbdgL3EDiZklmM99IFDKWryJWqMC2l4YN3es1+sWR4W0CKMLjFs7Qi2tz6kG3QgxEHEhYKi4RR03ptnBQbuMj+C6hTRP+tSGYtzrhQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770800259; c=relaxed/simple;
	bh=CnJdoUqw+NNkumwonbn2O7O4fLspWMM1fKB6A3EqAJk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pvNTW6DOu3GDBEFz/Slo1ZA3BjPorrUE5sY4FJOQdPnQ8n6pri0KPqsmDAwSMDWTb3MflehhyGeEbWpcFCSSdMk2Af1GbhzkG4tgmAzWaE+tJiuUX4ptDEBy/ILQZKEWnijHwRtMwdRyxFgDVfuvpawXjKblzklNg0LdbQHgfq0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gUVcwaIG; arc=pass smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6597a7bd7d6so7941538a12.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Feb 2026 00:57:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770800256; cv=none;
        d=google.com; s=arc-20240605;
        b=D210E4LlLcEIq667YVl3LjoQC5SlgKpOLRoqK0ZmSsTjUUJHCA63IvU+Z1P7ZfZTwS
         VUtv+zS7GQdBx2pRP2BwE9od1LqyTfMTlzLoD60CIo4WU3xn6+lI6ghqF8/MOvDQXZN+
         ESmShbdMvktJMKItvi0WeiCIhl5dAeDR3AD8tmfaKW5Df+g2y0o86dNj1IDc3UhPQEr2
         GC/SUg019jOkipK3WW+z/KcD2+P4HUNboFwn5zexUsPE/pSU29iNcHp70X3yzn29ggju
         ZgW142aV/RYsvV6PuYWzGyYRv4cGdZNmTKH5k5Amg+SD5fJ9lp09goB3Fbsql7Qm+hh8
         a4Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=o4A7oKwEiC9tREor63KRS1zCNiVlkxcuV2TlnBTX3Wg=;
        fh=IB2+ukEleh0u7AD+NmTF3BZAMJqRjO3lIOrCyUmEmkc=;
        b=j6Jseoksk55D/jXgWECSHLqEXSzJRvcjU5uGHwsHHtoOgVyHB6so/NPXdPLfNhLXk+
         lTvvSI3xofyP6UypC+QqSShXTylG0vaxdHglnYaaWY0nPa4sUJe+tpD131ZO44SjVsJR
         HLV0qMU1LAgsZSG1Ku/v2e5Isti63CZT3FhCE7Owe7Pys2umkqAsF72LjSVyfPjucpP1
         eKkfxxuvFuTCq0DRZTMChxMpB1MZ76U9bX/t+pCW91fCNpXFO/iOuRBflZP+mqri76Oa
         Hd/6vFBBt0yH6whbhfXYHtUwozqvsCcUVnUuwkMVHEiBGY5gIGW1fWhkqgrxWVqEqatu
         s0jg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770800256; x=1771405056; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o4A7oKwEiC9tREor63KRS1zCNiVlkxcuV2TlnBTX3Wg=;
        b=gUVcwaIGn0aDWUmLHalWJqvJvPwlosY1Biw/m+75rP7ViPxIrS18gQzhM4jFWIMPnh
         lE8xl8CT0wXiVbCWXAPe4OnqdvhWmgOcySvP4ML0Sr7L5y6u+UcDfxCbbhfgXmtYx+yY
         pCfVXjmAE6WNh7u/bmr+sKz18v7AYrfeP5EmV5rKST17lj3VTunAm0dBJuJNzapnAOU2
         Zm/MyqRWA8qUAmqRuguFXHEQqVmYnYmX81huBayme1rG//ktn6WpbHuX0x/XetmzXuVN
         bp0c6IoOkQxzNHdvc1mQl6Qdvs1uv/bhuqPfaHbbMRMLKR8lfrS8JUTFZeZIZpOR5Xfc
         5+3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770800256; x=1771405056;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=o4A7oKwEiC9tREor63KRS1zCNiVlkxcuV2TlnBTX3Wg=;
        b=jSFiKl7g5wANOjF7RyS+AMxnnXi2nyLl/6NPBxSuYvvIRMNgd1lbGpcgDxJ6tEcYig
         PVBMsBhY9QRYe3pNG+Pkt/jdm8+bqM1AwQVk2sdNqAuL62LnTHE69X3AQlZw0gDHejWx
         6OM6YXtM8yJrLibrywKS7FNEYkiwJ5B0VtmZUAU8cN9EuOmzeqIDGLqR3aAvTgiOUxr8
         0t54XI1SVcaY2HGTtj9gzr2sj7thqlyyHZbCYD2FkCfHiu8LVYKPDheukYhghqb+29/p
         eni6Fh+HsC27KnCmZkxZZTWcs9eFdEq7c1GmTXe6EOpbFNUpGVxWLjZyiKH0/dw4gg88
         aYQg==
X-Forwarded-Encrypted: i=1; AJvYcCWrbkSARWgcK1gocffuIHbACeJUbrVj7ku65qL2Of7pjw96uAVSO//lpUAHKM/Ew/cKLRpXsmF3Za/9K4ku@vger.kernel.org
X-Gm-Message-State: AOJu0Ywb5G5aqMVtUSKmf2/6HAvrDG4cmR1FCtXyIPzpE7FH5sW3KWT6
	GfTVSeElS4L781ncI4Y/KKcsibp4BF9ZmQprxcFSxVAJWDJQhX8N/PIU4BtCVtOnItK2hXB21h6
	u/3/KNTeVxXH9XURUE19hPrcLbcV6cM/p8igo
X-Gm-Gg: AZuq6aInvH6ZJoFvDfIK3DooDJH5/mpCb2s18WBNlceQ5cdzGd3wi4g6revV/0cYIX7
	LhqBVF133vddkMVHMpVAPkwFgfJanYkcqspv7mkrXiwC81NKDbF5Zux6E5IFp1pa5oXTb4xPE/a
	rlQ28sfGQpqRfiGXwdKH3fXNe/aYbzBcaOU1HA97IG0LI73+23IeklpYYRji6hQFBlc8oiYwEKK
	ZoYA0QdBHhlBrY7Cstu6fyKdI5EgXueSqRLhPMfBQTAYcX8B0Sx/O20cRY89uJQS8jy0WYF91ko
	n8SvoydaQzVYGEeD8mbeiO8LS+m/N0szBX1wkG3Arg==
X-Received: by 2002:a05:6402:440b:b0:65a:390a:2070 with SMTP id
 4fb4d7f45d1cf-65a39d77b56mr877040a12.32.1770800256118; Wed, 11 Feb 2026
 00:57:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260210095042.506707-1-amir73il@gmail.com> <bc7dga4oxvoqevokdzffl25mh7uawx3rfvz5q2goyz4z76l65r@bp4vpjmzmbhk>
In-Reply-To: <bc7dga4oxvoqevokdzffl25mh7uawx3rfvz5q2goyz4z76l65r@bp4vpjmzmbhk>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 11 Feb 2026 09:57:24 +0100
X-Gm-Features: AZwV_QitR5W3f8iFDVsYJmYjvRxXqh09fxnrYIv9SScVINHDL8Ucz3R_YFw9jvI
Message-ID: <CAOQ4uxgVhPCxc2369purMTSU9sQuPuR+xBXBYoAbZ7ugVufSmA@mail.gmail.com>
Subject: Re: [PATCH] fs: set fsx_valid hint in file_getattr() syscall
To: Andrey Albershteyn <aalbersh@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>, Miklos Szeredi <miklos@szeredi.hu>, Jan Kara <jack@suse.cz>, 
	"Darrick J . Wong" <djwong@kernel.org>, linux-fsdevel@vger.kernel.org, 
	syzbot+fa79520cb6cf363d660d@syzkaller.appspotmail.com, 
	Andrey Albershteyn <aalbersh@kernel.org>, stable@vger.kernel.org
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
	TAGGED_FROM(0.00)[bounces-76928-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[amir73il@gmail.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel,fa79520cb6cf363d660d];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[appspotmail.com:email,mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5808E122760
X-Rspamd-Action: no action

On Tue, Feb 10, 2026 at 6:45=E2=80=AFPM Andrey Albershteyn <aalbersh@redhat=
.com> wrote:
>
> On 2026-02-10 10:50:42, Amir Goldstein wrote:
> > The vfs_fileattr_get() API is a unification of the two legacy ioctls
> > FS_IOC_GETFLAGS and FS_IOC_FSGETXATTR.
> >
> > The legacy ioctls set a hint flag, either flags_valid or fsx_valid,
> > which overlayfs and fuse may use to convert back to one of the two
> > legacy ioctls.
> >
> > The new file_getattr() syscall is a modern version of the ioctl
> > FS_IOC_FSGETXATTR, but it does not set the fsx_valid hint leading to
> > uninit-value KMSAN warning in ovl_fileattr_get() as is also expected
> > to happen in fuse_fileattr_get().
> >
> > Reported-by: syzbot+fa79520cb6cf363d660d@syzkaller.appspotmail.com
> > Closes: https://lore.kernel.org/r/698ad8b7.050a0220.3b3015.008b.GAE@goo=
gle.com/
> > Fixes: be7efb2d20d67 ("fs: introduce file_getattr and file_setattr sysc=
alls")
> > Cc: Andrey Albershteyn <aalbersh@kernel.org>
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > ---
> >  fs/file_attr.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/fs/file_attr.c b/fs/file_attr.c
> > index 53b356dd8c33a..910c346d81bcd 100644
> > --- a/fs/file_attr.c
> > +++ b/fs/file_attr.c
> > @@ -379,7 +379,7 @@ SYSCALL_DEFINE5(file_getattr, int, dfd, const char =
__user *, filename,
> >       struct filename *name __free(putname) =3D NULL;
> >       unsigned int lookup_flags =3D 0;
> >       struct file_attr fattr;
> > -     struct file_kattr fa;
> > +     struct file_kattr fa =3D { .fsx_valid =3D true }; /* hint only */
> >       int error;
> >
> >       BUILD_BUG_ON(sizeof(struct file_attr) < FILE_ATTR_SIZE_VER0);
> > --
> > 2.52.0
> >
>
> There's same patch a bit earlier from Edward
> https://lore.kernel.org/linux-fsdevel/tencent_B6C4583771D76766D71362A3686=
96EC3B605@qq.com/
>

Nice. I'm fine with taking Edward's patch.
With addition of the Fixes: and cc: stable tags.

Thanks,
Amir.

