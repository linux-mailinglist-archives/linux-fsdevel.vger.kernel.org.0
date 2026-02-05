Return-Path: <linux-fsdevel+bounces-76381-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kAjyOGplhGkh2wMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76381-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Feb 2026 10:39:54 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8492BF0EC1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Feb 2026 10:39:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A7252302D125
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Feb 2026 09:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34DC639E6D7;
	Thu,  5 Feb 2026 09:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FjUGTiXw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 765BD399013
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Feb 2026 09:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770284251; cv=pass; b=KzKj/y9hRdo8oAxEXEFx1hI5YeNcK/Er37sm0p54REw7VkwQVLXAJ/ucBmpU5ZKpNAfhxpqXCgyJWEg2BnwgNAlRWRsiFWOWYEUIci7LyJk3xqsSDt5uwb3QxA8yWVBcTIi3MXe4V2yS9OXxLgQGPYODrl/fBUx7f9Ih2xUR4yk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770284251; c=relaxed/simple;
	bh=O3zjcpb1gIgdrnZIOWkOIcCmTAMhdJCAtczZfkl8Mgo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WAzYR/ZgXqDUhQfl0FcWGaky8U5CYVpZtKdwoWWc0pXwiOqhxQUKA72zFm5xTrEgiS9Z6t0FrhTrjwSpcsqBmHXn+gTRucJ192H+l76+PGFfVcj0nELJ96/zEv4ceKfwKxpJjQSwZQ04l4ksDArzNMn2EdYxI9FzfLjxvniLD/o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FjUGTiXw; arc=pass smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-65956402da9so1336262a12.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Feb 2026 01:37:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770284250; cv=none;
        d=google.com; s=arc-20240605;
        b=KnHSUZGcXHUzDz9HvbEdHZUhAxjAbgiMKOIzyCnwmYzgtJEiQSgANpDn6LpAljO+sa
         5hyG178SplwvdY0mYNdIXZs1dxQmyZfGP83hV3cnCB9E9443lCecSYHz0Dpg0g45qNR8
         A8B9BLW+Q36bZeZfKU8cP1yMrAM0nH//q4fD3/QLzytoQ4AfI1MAT3NUn2RPQfBXDBbd
         AexQOv1UHVR8sBsnTG/TpwSumt050F97UiReLTmC8ODt40cbek62uA8WzKPGo/qEvQHf
         17Q2ivsnrjDK2tuVU9dcKzoogpWA2iqIZN7LexQT/QFS6st2lH65/DDjlhXgVgD7uwcv
         JIRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ts7BIpqOHUIYO1yz8UgL/PwCOZwIbnvcvFeQ/hBIaCk=;
        fh=561jpH20lYEfxBioiwpT4FzVBphKqQe6rLZ1w6KNll4=;
        b=f7GjwGoa6byyAutrCxmrmgXM0Q8YRn6TOIbSHCMHbge3pVN8qv0w0vIGbzqaXCWXUi
         gIrU2RffB4kvZP5oGkxkI9dSOMhHICAvdb2zfqvKnfJvPtWkCghIKyALEkmPgMyx3O6e
         Pebbvd0lT4lcQwxGzB0Fw6BcB0LTwaFfqy8WoXlKE5ZnTGXc/zFWdFRhg6qfOL2L2nbJ
         zO/+Sv1QDWqyV8A8WX4P3obbpsGze52u2vDQJnsbO0NnDGpNPQOjhok3cGKDr8P9fy6z
         T0tkMLeFy89Q46zzo6x2ezjlnQ2Ebm2yQN5clA0g1+ttSE6DoBi69hNFET3hSIZKzK94
         cD0Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770284250; x=1770889050; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ts7BIpqOHUIYO1yz8UgL/PwCOZwIbnvcvFeQ/hBIaCk=;
        b=FjUGTiXw2YWjuQ7I+GqvszU9ONy2XE3+0JTAxPXHkvt5eZPZz+J5Ufml3pqOgP8T2L
         rGpjc6btwhogLQMha/Jf6R6/yMMHusEbVvvB9GvauRcrLVSE37m/5NRzEmxkn7UFT56a
         iuPSJZkpndM52iukwsc73xY8GdCH4GozIXR7BrzDyyEcwiI2UfOmNraXaq/qo6qKWX5v
         Js4guz62jAPbbEGBBruoJBw9nESFq2rhHfK5hAw/E3v3AMLBniyg3HEQD/EO70aNkSpl
         fnmqT9r0YmS9KqEzDR/y8yvYgP0e5gBj2781l3djCI2R2Qr30Ey5NTf0YpiUPWKYhCsR
         bKZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770284250; x=1770889050;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ts7BIpqOHUIYO1yz8UgL/PwCOZwIbnvcvFeQ/hBIaCk=;
        b=YTQ53ez4pVHrizIq/EroOPNeOoV/Bd7YCJH5S+xmVPYwQy8L3NoJre98xB3dfvcrCk
         B06kdsFFODPBrdl6UEwHkHyfZF+vuMU0Vmze2EVOIxwNrdxZTB7v6daMHQEu3yOiPfcN
         idpLlPmdWaVB2RCm2JHKxV4wBxnamjIYcj7tb8GJT5MAhPbaNkdMYXIE0zWfR1SFHJFr
         QBZcfMbMHyGk4QlRvvq9nyplh8R0X0O7ifNqpWp10PbZhR7uHKURbp6lY3K0Q31v7ODB
         nEUjCJ8431vaQDx9bibtoz4pNhGzKR3/eTkkCVTddRSM1s6uveX4s84H1qu3Gvh+U5qh
         DNnw==
X-Forwarded-Encrypted: i=1; AJvYcCUeMpT3loJFJhAh5W0M6cvwQUNWSVjBUlWncQ9+k3OHWEvkzAqmFwS+v7VhlpZu9f2AiubbuEZNO6CthMCq@vger.kernel.org
X-Gm-Message-State: AOJu0YxFStKkDgEZtKvMQ1+mh+u6exZZJ/Kyu/nwzgsMMJY/7V+JehaZ
	mCWQx2JfEMnpsNMS0Y6DuiCJUzqwskNarO6IMLDKyjzDbJiuTu+ji0DnmgcT2gJWqKWwl6Tcmfl
	EY0ZoM0bgQZcfD8iIFtEE2ZRHdOFXsQ8=
X-Gm-Gg: AZuq6aIYgkzmJKnA2nG406430va7FyF9yIpdH5N6eEhxpRI5E3MAonMIOdYwGDoiw+k
	UtV42DjF4qufyle2fwXmpRCfIvF5/IL2bjR3p6u0CAI8VvXmYVaMYQeZv++wtprHX7NPh0mXA0i
	Hlx7gvNooML9abFSIPbi0D/y0igOm1jAHYJadrJGbKlwBPwnab/iDvX9QiyuY46NW4rqMzwrlww
	+QdprqaNLDPtLn5vc2hXwvyRrxQ4n3TT8/d5IbEFu5z/9Rt5ybxDDHPqaQeEPcE9ek9NCMdW4NL
	T/+gof8P1d/krmRhNd23T7mxXWqe9Q==
X-Received: by 2002:a05:6402:2688:b0:658:cf28:90ed with SMTP id
 4fb4d7f45d1cf-65949cc1e5emr3920680a12.15.1770284249654; Thu, 05 Feb 2026
 01:37:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260204050726.177283-1-neilb@ownmail.net> <20260204050726.177283-12-neilb@ownmail.net>
In-Reply-To: <20260204050726.177283-12-neilb@ownmail.net>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 5 Feb 2026 10:37:18 +0100
X-Gm-Features: AZwV_QjDs8XEOiRuWGAHzisKUrokVjcatEGo5N0FYjLzK48UQXH5p374RE5BkHo
Message-ID: <CAOQ4uxiYUTi=8BjRFbY_GdBZR_5CuP6680me=_xQaPcQk7EFuQ@mail.gmail.com>
Subject: Re: [PATCH 11/13] ovl: use is_subdir() for testing if one thing is a
 subdir of another
To: NeilBrown <neil@brown.name>
Cc: Christian Brauner <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	David Howells <dhowells@redhat.com>, Jan Kara <jack@suse.cz>, Chuck Lever <chuck.lever@oracle.com>, 
	Jeff Layton <jlayton@kernel.org>, Miklos Szeredi <miklos@szeredi.hu>, 
	John Johansen <john.johansen@canonical.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, linux-kernel@vger.kernel.org, 
	netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-nfs@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76381-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[21];
	FREEMAIL_CC(0.00)[kernel.org,zeniv.linux.org.uk,redhat.com,suse.cz,oracle.com,szeredi.hu,canonical.com,paul-moore.com,namei.org,hallyn.com,gmail.com,vger.kernel.org,lists.linux.dev,lists.ubuntu.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[amir73il@gmail.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ownmail.net:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 8492BF0EC1
X-Rspamd-Action: no action

On Wed, Feb 4, 2026 at 6:09=E2=80=AFAM NeilBrown <neilb@ownmail.net> wrote:
>
> From: NeilBrown <neil@brown.name>
>
> Rather than using lock_rename(), use the more obvious is_subdir() for
> ensuring that neither upper nor workdir contain the other.
> Also be explicit in the comment that the two directories cannot be the
> same.
>
> As this is a point-it-time sanity check and does not provide any
> on-going guarantees, the removal of locking does not introduce any
> interesting races.
>
> Signed-off-by: NeilBrown <neil@brown.name>

Looks reasonable

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

> ---
>  fs/overlayfs/super.c | 15 +++++----------
>  1 file changed, 5 insertions(+), 10 deletions(-)
>
> diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
> index ba9146f22a2c..2fd3e0aee50e 100644
> --- a/fs/overlayfs/super.c
> +++ b/fs/overlayfs/super.c
> @@ -451,18 +451,13 @@ static int ovl_lower_dir(const char *name, const st=
ruct path *path,
>         return 0;
>  }
>
> -/* Workdir should not be subdir of upperdir and vice versa */
> +/*
> + * Workdir should not be subdir of upperdir and vice versa, and
> + * they should not be the same.
> + */
>  static bool ovl_workdir_ok(struct dentry *workdir, struct dentry *upperd=
ir)
>  {
> -       bool ok =3D false;
> -
> -       if (workdir !=3D upperdir) {
> -               struct dentry *trap =3D lock_rename(workdir, upperdir);
> -               if (!IS_ERR(trap))
> -                       unlock_rename(workdir, upperdir);
> -               ok =3D (trap =3D=3D NULL);
> -       }
> -       return ok;
> +       return !is_subdir(workdir, upperdir) && !is_subdir(upperdir, work=
dir);
>  }
>
>  static int ovl_setup_trap(struct super_block *sb, struct dentry *dir,
> --
> 2.50.0.107.gf914562f5916.dirty
>

