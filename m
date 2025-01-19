Return-Path: <linux-fsdevel+bounces-39623-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF1A0A162F0
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Jan 2025 17:33:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE1A43A4FA7
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Jan 2025 16:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7879A1DF747;
	Sun, 19 Jan 2025 16:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N2COoblC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDDFA3207;
	Sun, 19 Jan 2025 16:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737304383; cv=none; b=MX0i5Xvf2RTQWfF/MV9S+HimNEGW1qyL784sGxrwZh2dTZvdAyx63EmHAAeJPjC8sqZLVUL2vu/xDTUvT/Rsk3uXL0BWAMb16rpphbAEEHTxwAyVXVJMRwt7N0gZVpfxUvT6iPHNCUbvoTWJJrHcAdUTV/G9tjkD+FRxmNGz0Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737304383; c=relaxed/simple;
	bh=p89gvGV67F5EfjIm56iKgGqaNDLLlMPsKjoAY3lubH4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mtsIZ8s53CobeYdlvZWb5uvTzbHptTkk4V6ITxLBGlSGcm6xB4Ot5s1oS7fcaQOWvgE5gW5FqM4eC1lWX3fnH8Vmzp9et1Dnx8Wgp1OvRitI23GGq1hRv2wANtOViu1697T3umb/gmueQQW/rM1qzVlE8Yjdxj0HF9tqcVhH9sA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N2COoblC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42CD8C4CEE0;
	Sun, 19 Jan 2025 16:33:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737304383;
	bh=p89gvGV67F5EfjIm56iKgGqaNDLLlMPsKjoAY3lubH4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=N2COoblCm+0J7eqjk3zCB964Gfp179QPXRkQIJ0kCTfZsR1a0GDgo/r4MashNWLnw
	 7vacNlB+xASBEvjsbg0K/hlzMlMZ+65IAazPHZ42lbJDHSgHiudyA2hdP94SbvuY3a
	 46j9zdtQM1pFnm5zilsWfsQDkPOAalYOMEj+IYJEvUMY+vLXWVaEEdMTRwBLB4iqKC
	 CTypfXPU3z9aDOyoAeiJxqVclTC10bsap5KHvCc9WNKmIssDkTVzkTBUwAOo0p8cPe
	 QBPtXOnyBaBpV7Z82mUoTRv/LyEVU3RBgwRBLjLDMRs2VZ9P8tNcLkj6tpc0vzk4h2
	 l43ZaCLT8ZkFw==
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-30227c56b11so36537301fa.3;
        Sun, 19 Jan 2025 08:33:03 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWUtIQjMdn4g5sqsty4OBgwYANBfLKoxxBhFSD0sSqrj21ORYH1dMX6C81kDZvN1mUgC5eA1pokAow=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8vl8IcDmgI+R+Ohf8/67/a4Y0a6wZaZKvV9pZIXk3t+X7TRt+
	beK1cUkp0wERLNDh53ynC+tTQpXp5KbrUxGSkpJrGJSDprMflkMB460Is0HMiCFw6L5ngHhBr3r
	6++PJPzqaLhhPoCy2xpk03I+TFh0=
X-Google-Smtp-Source: AGHT+IFjoVPvozYe8NDbnrY0yBEOcU3oZyT3A+xuwog074rdsCyPHDORGTYCRccDF6BIyVJOHsJRK8wEy04bfuNcetY=
X-Received: by 2002:a05:651c:1183:b0:300:3bcd:8d05 with SMTP id
 38308e7fff4ca-3072ca8b0c1mr28053291fa.15.1737304381639; Sun, 19 Jan 2025
 08:33:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250119145941.22094-1-James.Bottomley@HansenPartnership.com> <20250119145941.22094-2-James.Bottomley@HansenPartnership.com>
In-Reply-To: <20250119145941.22094-2-James.Bottomley@HansenPartnership.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Sun, 19 Jan 2025 17:32:50 +0100
X-Gmail-Original-Message-ID: <CAMj1kXEQVJ6kqGFqXT9sqdNX9Juc7CiWa-4q+J7D=YucFimrqA@mail.gmail.com>
X-Gm-Features: AbW1kvbrpil9jKfUPCKdqorfTAS3IvRTehKxOVSSkgjqICrR9JWP75i8QcI7v4M
Message-ID: <CAMj1kXEQVJ6kqGFqXT9sqdNX9Juc7CiWa-4q+J7D=YucFimrqA@mail.gmail.com>
Subject: Re: [PATCH 1/2] efivarfs: prevent setting of zero size on the inodes
 in the cache
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: linux-fsdevel@vger.kernel.org, linux-efi@vger.kernel.org, 
	Jeremy Kerr <jk@ozlabs.org>, Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"

On Sun, 19 Jan 2025 at 16:00, James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
>
> Current efivarfs uses simple_setattr which allows the setting of any
> size in the inode cache.  This is wrong because a zero size file is
> used to indicate an "uncommitted" variable, so by simple means of
> truncating the file (as root) any variable may be turned to look like
> it's uncommitted.  Fix by adding an efivarfs_setattr routine which
> does not allow updating of the cached inode size (which now only comes
> from the underlying variable).
>
> Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
> ---
>  fs/efivarfs/inode.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>
> diff --git a/fs/efivarfs/inode.c b/fs/efivarfs/inode.c
> index ec23da8405ff..a4a6587ecd2e 100644
> --- a/fs/efivarfs/inode.c
> +++ b/fs/efivarfs/inode.c
> @@ -187,7 +187,24 @@ efivarfs_fileattr_set(struct mnt_idmap *idmap,
>         return 0;
>  }
>
> +/* copy of simple_setattr except that it doesn't do i_size updates */
> +static int efivarfs_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
> +                  struct iattr *iattr)
> +{
> +       struct inode *inode = d_inode(dentry);
> +       int error;
> +
> +       error = setattr_prepare(idmap, dentry, iattr);
> +       if (error)
> +               return error;
> +
> +       setattr_copy(idmap, inode, iattr);
> +       mark_inode_dirty(inode);
> +       return 0;
> +}
> +
>  static const struct inode_operations efivarfs_file_inode_operations = {
>         .fileattr_get = efivarfs_fileattr_get,
>         .fileattr_set = efivarfs_fileattr_set,
> +       .setattr      = efivarfs_setattr,
>  };

Is it sufficient to just ignore inode size changes? Should we complain
about this instead?

