Return-Path: <linux-fsdevel+bounces-77306-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gK2FBvw7k2kg2wEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77306-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Feb 2026 16:47:08 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 87441145C09
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Feb 2026 16:47:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8D7F630067A2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Feb 2026 15:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A87933123D;
	Mon, 16 Feb 2026 15:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ls2hUITJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABAD523A9B0
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Feb 2026 15:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771256813; cv=pass; b=I1YRbcvKlqeflzOD0zHhPBgeYaObfH15EjvjUIFkvkyJrkP7Pgk8dvsh30DlttL78xcIpEIht95oAJVXoM3QaHKLFFNqCyJQlJXlfQ5SDXhuneuGL+8kddx77B0yDEMIkqEFT8iVhMrlDRFwC5Dc0TC7ics7ru/RVN8Q3l8ky6A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771256813; c=relaxed/simple;
	bh=djpwv/o4GoPPJBT2whDzEpO49Xpb/mpKkKS5KADS0aw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HqXvU/kiR5QbBqwfmXGOuUh2Lmbw1FzyVYxdgDydM/19d36lxnvdnqz2s50ATevJU4+6ZaFpdBMOxs2JCvp03FKvZzrWp5KVALNmaJ1H2wwSEFK/vVY9fz1TBsrkUswy9Bz+hMQUGtXUw8HjZ58J5ngs6BTH5SGQtLXbz7xwFw8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ls2hUITJ; arc=pass smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b883c8dfb00so642698366b.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Feb 2026 07:46:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771256810; cv=none;
        d=google.com; s=arc-20240605;
        b=AUBBUYXT11v/dyUZZ1tr2S7YSPr8UZNHOK32R+Fkg0oadckiOYVct/BQ+EZBbFC8lF
         ICfO5IMLGRkwM0lJP5zt5I+i1aw5XruUUIkVvARfTKr5fOf6XfPEv9cNS4zboFA+4ct0
         aMA4ooNF9mm4ZnfbF0W8ypVf2Ai88xN2hKRVtNQrIu5tDFRWbRkXUWp/yNU5sBnFJKzv
         QLZCuANbCtsrMKW/V6QsbS2JGkqc+wmDZrRfgIdVWkR69X/zWn2Ujjw+mIZ8FZFqd64Z
         9gGbY//K3qjZAD+nXvipHkCx8SADSlL17TgtkmbP5hZEIxkeyaWsxrSDWwc2xNnba0z+
         0XYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EwFQ9XHRm/+AQIEABXNY8BO3EtxJflHDwT4zNmU2dNc=;
        fh=dv9pSA5AH7ktGo8X/XVT1S04g7jbRsTAoRoP3a81N8w=;
        b=frrUd/51NEkmltrzk0mGYBWAjVIDFNjg8FGC/nV/6kqG+fdxSo4psCBnPA7+ZtX9Uh
         SZdYO+8g0kkQ6K0YoOCw+OBldOYEqdTDn7xSStLEXXzZvkDtnYF5v0McSM84sni0KqvX
         GvzjhYW/5hB6NgG/f0ikJhEYIfnGA1eQv8eVcgoIrImPY+eMKRmoTgQJ4rAZoCs8iGy0
         iYV2UdxU64fVVurHh3GEMngi6HQEcZpf7vUW/x9ePV1nog3IM8+zuBfX92BSiSZkKyTV
         gCSVDnXuKdY9rUrd835VUq4CdNxTHGKxj24oR3nDftwGxoQ+yACRlur8OGUdoRwhZZsu
         lgfA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771256810; x=1771861610; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EwFQ9XHRm/+AQIEABXNY8BO3EtxJflHDwT4zNmU2dNc=;
        b=Ls2hUITJPzh2+aWIbjAnvxJ8Q3fFBL8727qpP89XXZGqd1sAOZ99q8QjdTRmIAPaOV
         u1/gLyUXYWeZ1xoU7g/QQOQA9RdQcD87jAzZKzd/vW5fJOt4W2hsjan8lsCrA9lx7uma
         eet9IKx02VqAYcsdPlfB3MXSN6n6bUbT7YiOhN1vjkchrlsHbnI2sLmTCPtR1fYhjr39
         7hwEvZOW32wRq8aTMGUnWPfL7kUlsSyB0uW0lEY/GYpvUkBNcM5X+uG4EHkHzrJgELjC
         rCJlf6+HgnW4yasia/jFwu1YG2BllD7zQL/yE4TYth5SqvE+iQZSGFQJXdIz7cKEDcCP
         hnxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771256810; x=1771861610;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EwFQ9XHRm/+AQIEABXNY8BO3EtxJflHDwT4zNmU2dNc=;
        b=FYGUN2q5WMcZd3TzPPXuQ36cuc/A7857aH9wz/5jEUWl6AihLLRyj1UjlKYnymqiKr
         BF3vxCiDFJxtnwCfIy3Bc99HNJMoxeCEtoeSf8TPhdbXmMFb6QeyX/bWvia+uZetrhzo
         OREifAREZj1dKdq1mvUApnYTUzSHP8dNfJBK7puTXXrMqSEpJ9ahEWYi0GmoutTxIBLE
         eaxdD+DRNWdzOohJ3m5pi1bVKnbg5XCA/pLrqcfILrueze7G5D+4DqjyrfzHgoNmozuY
         2s5Ht43X4o3WC8ZYjytZZ43wVd7UGYgdV3rdMxVjw0wABElme/1OvWz4kX0ri+MfS4IE
         q0Rw==
X-Forwarded-Encrypted: i=1; AJvYcCXUNiGk0TmTr+QvC2SQSF/biJ1tH9az3ux91t3qWOw6PokKqpTJ+Yj4nT6th3LHSKUgCLvxmVn66M2v7kpZ@vger.kernel.org
X-Gm-Message-State: AOJu0YwabhxLgvUN+vlvr9sWb6tF1Sr89eYRg6Y1vsUG53/a4qCNO6do
	YUfNFFMzVKkGAB1/T2gIXsOpOaqNhyPqjD+/5IVJv8GF8BAk3Zd033NSxMb/qVa6vbzl/pEj9Qd
	1qtm4sTL4BeKooDOUpVK81wpqFnKrg9E=
X-Gm-Gg: AZuq6aI12jpqIrJ1hl0ALRd2ZT1aAhBQry0zb5l65H/fx1geEDZad6vdCY2CYRDR/uu
	woftneaGdloiRwyDk5NwQaWwPAkEodz60Uo/vu3EP+ym65XvGpfY9AocD32sMrzDDKZ9woz+FJf
	w5sqlmrHRHj23boubtr/HdlI2RhMjz48ND4b8ajWo0gaoMHwjEK3tD1eusqqyOK5lS8d2nAU4h/
	rKQg4/iMGEIHtK0SoV113FxxO2h8pqOlDJ4r9l95+BH4pGq3R6T0szbYHBkpyMnGNZtSSKqCO6z
	cZLEoR04
X-Received: by 2002:a17:907:e849:b0:b8e:dc98:ad20 with SMTP id
 a640c23a62f3a-b8fb4149e36mr557161866b.4.1771256809530; Mon, 16 Feb 2026
 07:46:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260216150625.793013-1-omosnace@redhat.com> <20260216150625.793013-3-omosnace@redhat.com>
In-Reply-To: <20260216150625.793013-3-omosnace@redhat.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 16 Feb 2026 16:46:38 +0100
X-Gm-Features: AaiRm50W-dqNFKibz1fwwn2MM3hFVT2cCQwgYkQhpvQg3H1petMEkBdqAAcwRxQ
Message-ID: <CAOQ4uxhDwhd5Rn00qhd0j-OySph6v6ZCi8YM0MUP0C6Y3NQUzA@mail.gmail.com>
Subject: Re: [PATCH 2/2] fanotify: call fanotify_events_supported() before
 path_permission() and security_path_notify()
To: Ondrej Mosnacek <omosnace@redhat.com>
Cc: Jan Kara <jack@suse.cz>, Matthew Bobrowski <repnop@google.com>, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77306-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[amir73il@gmail.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 87441145C09
X-Rspamd-Action: no action

On Mon, Feb 16, 2026 at 5:06=E2=80=AFPM Ondrej Mosnacek <omosnace@redhat.co=
m> wrote:
>
> The latter trigger LSM (e.g. SELinux) checks, which will log a denial
> when permission is denied, so it's better to do them after validity
> checks to avoid logging a denial when the operation would fail anyway.
>
> Fixes: 0b3b094ac9a7 ("fanotify: Disallow permission events for proc files=
ystem")
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---

Fine by me,
Feel free to add
Reviewed-by: Amir Goldstein <amir73il@gmail.com>

>  fs/notify/fanotify/fanotify_user.c | 25 ++++++++++---------------
>  1 file changed, 10 insertions(+), 15 deletions(-)
>
> diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fano=
tify_user.c
> index 9c9fca2976d2b..bfc4d09e6964a 100644
> --- a/fs/notify/fanotify/fanotify_user.c
> +++ b/fs/notify/fanotify/fanotify_user.c
> @@ -1210,6 +1210,7 @@ static int fanotify_find_path(int dfd, const char _=
_user *filename,
>
>                 *path =3D fd_file(f)->f_path;
>                 path_get(path);
> +               ret =3D 0;
>         } else {
>                 unsigned int lookup_flags =3D 0;
>
> @@ -1219,22 +1220,7 @@ static int fanotify_find_path(int dfd, const char =
__user *filename,
>                         lookup_flags |=3D LOOKUP_DIRECTORY;
>
>                 ret =3D user_path_at(dfd, filename, lookup_flags, path);
> -               if (ret)
> -                       goto out;
>         }
> -
> -       /* you can only watch an inode if you have read permissions on it=
 */
> -       ret =3D path_permission(path, MAY_READ);
> -       if (ret) {
> -               path_put(path);
> -               goto out;
> -       }
> -
> -       ret =3D security_path_notify(path, mask, obj_type);
> -       if (ret)
> -               path_put(path);
> -
> -out:
>         return ret;
>  }
>
> @@ -2058,6 +2044,15 @@ static int do_fanotify_mark(int fanotify_fd, unsig=
ned int flags, __u64 mask,
>                         goto path_put_and_out;
>         }
>
> +       /* you can only watch an inode if you have read permissions on it=
 */
> +       ret =3D path_permission(&path, MAY_READ);
> +       if (ret)
> +               goto path_put_and_out;
> +
> +       ret =3D security_path_notify(&path, mask, obj_type);
> +       if (ret)
> +               goto path_put_and_out;
> +
>         if (fid_mode) {
>                 ret =3D fanotify_test_fsid(path.dentry, flags, &__fsid);
>                 if (ret)
> --
> 2.53.0
>

