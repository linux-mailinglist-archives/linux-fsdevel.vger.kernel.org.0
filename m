Return-Path: <linux-fsdevel+bounces-77924-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oEYDOaQinGkZ/wMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77924-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 10:49:24 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DCD51742E2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 10:49:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E7AAD30078B6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 09:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B34651643B;
	Mon, 23 Feb 2026 09:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VsjZlfRu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C491934E770
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Feb 2026 09:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771840155; cv=pass; b=D53xZstJMCet74xtsqGnPJYofUwgkVnq1R/IMKMTz9jYaQcvZLKHbdItMKoXefDvFuc/EiXt0ZlRC7vKYn6YALQlU9d12tEiRr5o5ExVNFczqQJWBeHZubHuPdctn+NkXNQkZqu4VOV1Kq5TNErudOFt3Z+pFGifSo+qkx7hVwc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771840155; c=relaxed/simple;
	bh=Xh4bjPWHtF+IO6/pJTbboimYkYntcuZV8mtoP+YljlA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LWC+AWq7kiRmY3H5MfyasWnrXoUdmtYhb/AjRhTlTbQf+BYpNtlTuvI+kQZYCYt4FyODu+pWdOZeNoyjrHl49AGAI5ukEAeF6IyotrKDu29ITQNUyF9MwOOIoCLJHPjIJHX5jLbYA52EZW6oUbFEj90BM8FK4FgARlxMnNHX+cw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VsjZlfRu; arc=pass smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-4359249bbacso3011587f8f.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Feb 2026 01:49:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771840152; cv=none;
        d=google.com; s=arc-20240605;
        b=Q8AEzmqhOsBDCpRqFnRFfy3t8Ge8TLU7FWkdR/MyImgBRyTpWAWHpiZCjvKiSaYV9B
         Mo00A+K+5DEr/hTC8GTJMqAMSi/QFNZV70zJdAopZljmLJdjFR+H8AmJq9+VAbsWSVOe
         d0wMK2gpvf61ZEf1SFzHwnatSaGk+hKK1hvndlqgIK4EEpt4emAxxDbtlY6AwpNuH+ii
         B+5yINPSmBQcF2dEa6H2ehDE1bNcyC7Zs3b1+Go0q51hhw7HbM0l0yvmjOVBswxa1MDK
         sFFNw1BoNS/Q+q0eKG9zbzFTWYbl8fgsBqMx0IyfOgLrpyTzIusk6B3IohdAGoldM2Sb
         Wj5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2/el3cFDhCdryFwCuaSLEKRCesYmHLj0qrChriFmVgE=;
        fh=G1aw1C11WuNoIWYzSb7cDc23dRaUmaS1jkMVUgsiBX4=;
        b=IC8NhyhaZL1jCNqNn6uHhWJGpRD39j4ZPUC9oFokBQo01ffzmOmA0GNt1KfKfAxWmx
         BEa70ZXB43F5ZBDsxAUYc/jfSx4QU3Nie7h5TBs5V16NSdH8tf75+MfwxkSrI1CNNGPX
         d/p65AUwrbN3wOpWzb0a02DZM7BLSFjclddIqz34KUSv+Bq+RiJrtu/5SJqPQurmDWt7
         sM2y4WUTHa+ylIwIgm6+dgVyPa8qm/syKT+BViKbi3lxungdCB6u5jAqmw3HdaOUxZBO
         allSyA1Zm1AdW7/L6f8f5codt+o4934cLmwJyt39fEp8cQ+WAa9DNEEtz7vHjhS075VF
         9XkA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771840152; x=1772444952; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2/el3cFDhCdryFwCuaSLEKRCesYmHLj0qrChriFmVgE=;
        b=VsjZlfRucprXXOxcNuewJuffOlegZKKI002qWZs6ZknVE5gsDu7XvFbdD5dYC0pBHF
         hYL4t9/tAM4Ib47GjXqtmt1+txReBN2DP219k3nvQ58w/bzLOsKfBpZjvSqR75boT8f9
         l+9GG23LZCTKykPI9++AyA0AG0BF9yl5B0HKfazfIfR+B9QAaUXlw2yg1KK7EwCHKbro
         JpHGhiGOxZcrJ+a+weU45TKUUDyC2y/I5985HYfX8JLsIxEsVfU5Em8XgO6/ZZ2VzSmf
         m+KZ5Xz8wLZqWkRdq6LqW0MPFKwCBu21z91i8tk3RhrOlHD3gF2z9uT7Kjk50oW693rW
         dBxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771840152; x=1772444952;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2/el3cFDhCdryFwCuaSLEKRCesYmHLj0qrChriFmVgE=;
        b=n8+E5drr8WmzmtweuPT4ocfht8V88qJwGKcbI1z4c/R4cA567ZVlykWi9PVO5vgtW4
         mLm7mIY/eZ2+DToUuuWoCDt9HwE+2vjmMnfOqGKXesMQ4HKJq3lhva6oU9LmBNwaP/xH
         ZB7OPmAo7rqiBF4/cfrxIMf/U8b7CuO6iAoBApjytXWVeQ8BK8HeIH8Lx4+eLseYGsKU
         4jJQWEVXA4zHv2EHelie34G3kO/qkse7I9hm37LiwqkF9saxNFKTOhPMomuADu0farbE
         1628cl1BSXU2u4HdtObvg0Kwxg3mBHlH4kMIhPrdwd5X/OLEGrpAG/9hp6lFFdEl8AQk
         7v+w==
X-Forwarded-Encrypted: i=1; AJvYcCWBULUvKb59nSdQ4WCtlffGyii/st5d3/kpczjcXYAdjYAWd2gxiluvGRwtGhOigYGdZ86KxbzU2RhYP98X@vger.kernel.org
X-Gm-Message-State: AOJu0YxQj6ni6bOvGAzmeer70NICZLIJ7TBbUcB5d4qeLPNClEXPwJne
	cjZk7Nkq3vZGx0up/KWenm467fnE8XMJmexB3e1cNxt5XWaPXZ+lejMdoF9+L0rCTiBiHv71VZO
	WbUyvZrgmlhkeBLfC1YeDfHJil4EVYRI=
X-Gm-Gg: ATEYQzyx6J+YJFvuVFek95BCPkaqlwDSx+mk45FVCa4TqlMZmMcGZ/iQXIP77j30lBF
	zm9iLNVxQqb8B8XCa5sfXssvVAYQDYoPFQ/t6070BYbSTr+DTtWMO4Vq7KBqq5orXkm0r82pLua
	y9jvFGFET+PAtAuy+SWWcPmsjxteE0M7FY7SGovffxNMrkix2vzTb6tDQ5oMk7bAxsNBF7kZ7Oi
	cId/rExepyxkXkFZ7zsSTT7kXEmMBEgwhNktUaVIBTki10/QhUOoyvGnkCZjy5CI65V2UG6mosi
	RknXiCiD4ium+B/V2GiSc7OaX8MOYg1oDn1U5JgSOA==
X-Received: by 2002:a05:6000:4014:b0:437:6aa8:b7eb with SMTP id
 ffacd0b85a97d-4396fd9b885mr14177751f8f.5.1771840152054; Mon, 23 Feb 2026
 01:49:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260223011210.3853517-1-neilb@ownmail.net> <20260223011210.3853517-10-neilb@ownmail.net>
In-Reply-To: <20260223011210.3853517-10-neilb@ownmail.net>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 23 Feb 2026 11:49:00 +0200
X-Gm-Features: AaiRm53oCa-QOult778vTlpI836VKQ_vX_Rm7xdLmLP8dTvXCc4lfRf1Ct2RZiU
Message-ID: <CAOQ4uxjtedA8B1QZDddRtsSP0XgFZCuBTD1VGvN4wawRyoox=A@mail.gmail.com>
Subject: Re: [PATCH v2 09/15] ovl: Simplify ovl_lookup_real_one()
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77924-lists,linux-fsdevel=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,ownmail.net:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,brown.name:email]
X-Rspamd-Queue-Id: 9DCD51742E2
X-Rspamd-Action: no action

On Mon, Feb 23, 2026 at 2:13=E2=80=AFAM NeilBrown <neilb@ownmail.net> wrote=
:
>
> From: NeilBrown <neil@brown.name>
>
> The primary purpose of this patch is to remove the locking from
> ovl_lookup_real_one() as part of centralising all locking of directories
> for name operations.
>
> The locking here isn't needed.  By performing consistency tests after
> the lookup we can be sure that the result of the lookup was valid at
> least for a moment, which is all the original code promised.
>
> lookup_noperm_unlocked() is used for the lookup and it will take the
> lock if needed only where it is needed.
>
> Also:
>  - don't take a reference to real->d_parent.  The parent is
>    only use for a pointer comparison, and no reference is needed for
>    that.
>  - Several "if" statements have a "goto" followed by "else" - the
>    else isn't needed: the following statement can directly follow
>    the "if" as a new statement
>  - Use a consistent pattern of setting "err" before performing a test
>    and possibly going to "fail".
>  - remove the "out" label (now that we don't need to dput(parent) or
>    unlock) and simply return from fail:.
>
> Reviewed-by: Jeff Layton <jlayton@kernel.org>
> Signed-off-by: NeilBrown <neil@brown.name>

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

> ---
>  fs/overlayfs/export.c | 71 ++++++++++++++++++++-----------------------
>  1 file changed, 33 insertions(+), 38 deletions(-)
>
> diff --git a/fs/overlayfs/export.c b/fs/overlayfs/export.c
> index 83f80fdb1567..b448fc9424b6 100644
> --- a/fs/overlayfs/export.c
> +++ b/fs/overlayfs/export.c
> @@ -349,69 +349,64 @@ static struct dentry *ovl_dentry_real_at(struct den=
try *dentry, int idx)
>         return NULL;
>  }
>
> -/*
> - * Lookup a child overlay dentry to get a connected overlay dentry whose=
 real
> - * dentry is @real. If @real is on upper layer, we lookup a child overla=
y
> - * dentry with the same name as the real dentry. Otherwise, we need to c=
onsult
> - * index for lookup.
> +/**
> + * ovl_lookup_real_one -  Lookup a child overlay dentry to get an overla=
y dentry whose real dentry is given
> + * @connected: parent overlay dentry
> + * @real: given child real dentry
> + * @layer: layer in which @real exists
> + *
> + *
> + * Lookup a child overlay dentry in @connected with the same name as the=
 @real
> + * dentry.  Then check that the parent of the result is the real dentry =
for
> + * @connected, and @real is the real dentry for the result.
> + *
> + * Returns:
> + *   %-ECHILD if the parent of @real is no longer the real dentry for @c=
onnected.
> + *   %-ESTALE if @real is no the real dentry of the found dentry.
> + *   Otherwise the found dentry is returned.
>   */
>  static struct dentry *ovl_lookup_real_one(struct dentry *connected,
>                                           struct dentry *real,
>                                           const struct ovl_layer *layer)
>  {
> -       struct inode *dir =3D d_inode(connected);
> -       struct dentry *this, *parent =3D NULL;
> +       struct dentry *this;
>         struct name_snapshot name;
>         int err;
>
>         /*
> -        * Lookup child overlay dentry by real name. The dir mutex protec=
ts us
> -        * from racing with overlay rename. If the overlay dentry that is=
 above
> -        * real has already been moved to a parent that is not under the
> -        * connected overlay dir, we return -ECHILD and restart the looku=
p of
> -        * connected real path from the top.
> -        */
> -       inode_lock_nested(dir, I_MUTEX_PARENT);
> -       err =3D -ECHILD;
> -       parent =3D dget_parent(real);
> -       if (ovl_dentry_real_at(connected, layer->idx) !=3D parent)
> -               goto fail;
> -
> -       /*
> -        * We also need to take a snapshot of real dentry name to protect=
 us
> +        * We need to take a snapshot of real dentry name to protect us
>          * from racing with underlying layer rename. In this case, we don=
't
>          * care about returning ESTALE, only from dereferencing a free na=
me
>          * pointer because we hold no lock on the real dentry.
>          */
>         take_dentry_name_snapshot(&name, real);
> -       /*
> -        * No idmap handling here: it's an internal lookup.
> -        */
> -       this =3D lookup_noperm(&name.name, connected);
> +       this =3D lookup_noperm_unlocked(&name.name, connected);
>         release_dentry_name_snapshot(&name);
> +
> +       err =3D -ECHILD;
> +       if (ovl_dentry_real_at(connected, layer->idx) !=3D real->d_parent=
)
> +               goto fail;
> +
>         err =3D PTR_ERR(this);
> -       if (IS_ERR(this)) {
> +       if (IS_ERR(this))
>                 goto fail;
> -       } else if (!this || !this->d_inode) {
> -               dput(this);
> -               err =3D -ENOENT;
> +
> +       err =3D -ENOENT;
> +       if (!this || !this->d_inode)
>                 goto fail;
> -       } else if (ovl_dentry_real_at(this, layer->idx) !=3D real) {
> -               dput(this);
> -               err =3D -ESTALE;
> +
> +       err =3D -ESTALE;
> +       if (ovl_dentry_real_at(this, layer->idx) !=3D real)
>                 goto fail;
> -       }
>
> -out:
> -       dput(parent);
> -       inode_unlock(dir);
>         return this;
>
>  fail:
>         pr_warn_ratelimited("failed to lookup one by real (%pd2, layer=3D=
%d, connected=3D%pd2, err=3D%i)\n",
>                             real, layer->idx, connected, err);
> -       this =3D ERR_PTR(err);
> -       goto out;
> +       if (!IS_ERR(this))
> +               dput(this);
> +       return ERR_PTR(err);
>  }
>
>  static struct dentry *ovl_lookup_real(struct super_block *sb,
> --
> 2.50.0.107.gf914562f5916.dirty
>

