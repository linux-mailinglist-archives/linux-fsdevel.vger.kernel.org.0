Return-Path: <linux-fsdevel+bounces-39626-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A514BA16305
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Jan 2025 17:52:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9988164189
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Jan 2025 16:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32EEF1DF963;
	Sun, 19 Jan 2025 16:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="urN36yKn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A631DF25A;
	Sun, 19 Jan 2025 16:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737305573; cv=none; b=JO35uZqpQj4aolsPV9GZlzMSlPaFMYkjs+iOKKuYdb46YT07J63w0MGGYWIugzQxF5y89Z90Kgm3t6ogSkwBaCoPjvFgwqomfMp3fy94jFrcBFN6ZoVPCEe+xxFn1uewIKXmVH+fZjb8ziDT4iKquN+guOh3KGnPgZ5nHP+o2ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737305573; c=relaxed/simple;
	bh=V07P04V+OgSpViVCO7NA/0iUMrEa2OA5QEfOkU8EpgQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tho71M9okodfl59TZ+Sb7v4FR0upZOVhu1Jal2viUcLv+Muvf8ZGZ+wB2uFfB/JkKjNKUGZqYY6tf7Nm82D4rXD9wKefFiHONkjMcOo0AUq6fTCY7C83oU1u3H08vtzes9PvvxkhvFg3Ib38TOcb83lex/sZXgbEduV47UvUlm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=urN36yKn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2F2FC4CEE4;
	Sun, 19 Jan 2025 16:52:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737305573;
	bh=V07P04V+OgSpViVCO7NA/0iUMrEa2OA5QEfOkU8EpgQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=urN36yKnyKd4gWHKpLBDwaksHopwqtvsszf4BpviBcsP3c+mZ6QAS8FYjMt63Ibc3
	 lFAxVvXSebrVrUCK+N17NeGQqh3zg8TkH/4fXdFU+84h1mrul08DOz+HmFE18Mh5v9
	 s2urwalb1eL+9O8MYgNx0xluPnP+ulzItpEUmr4eDKLPLTMXgJtzEqPZBJ+MnmezJx
	 CLf2InwUay3U/F0KAiYVu9OvAQBWynzNQaWePnWOhHKEAO6mPLMOLG+UOuBCTbMZTt
	 gumhdD68U1oau9rQ3y+6XG02EFaVA/AFjzkEJtHzIIUA3axuKs61m592Sp9/f/FGa1
	 zQZb+lseeAyOA==
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-53e3a227b82so3415229e87.0;
        Sun, 19 Jan 2025 08:52:52 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCURGwZJeWeukH6TW2SsGnhXLL7Vj8vNC1DMHMcdKGOIY2lp1cIXXB/LEZC9VOfnxEE3gVoM1pDVOgA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLNY51U3nPv+pURQBFhhcUfn/ExGrhJ5Rdw9w0xeCSB2mwVXiv
	EKcTEQoEVYp2emoAZoR6qBPLDSmgdqiJo7sYABfbZtZnHQn48gCdxsTBRVgkJQZDG6B5O6qGnlY
	KeCBXJmJAd18ZbOu/kc0bB2qha64=
X-Google-Smtp-Source: AGHT+IGvezg7d3dGQj8cdrg+wOdDdESTKa6Wta5EkEEe7GBAHpf18FUPQ1HSVCkY1sSyiF6Up9W4sx84JzWDYCeYDt8=
X-Received: by 2002:a05:6512:159b:b0:540:358e:36b9 with SMTP id
 2adb3069b0e04-5439c2807e3mr3557600e87.45.1737305571313; Sun, 19 Jan 2025
 08:52:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250119145941.22094-1-James.Bottomley@HansenPartnership.com>
 <20250119145941.22094-2-James.Bottomley@HansenPartnership.com>
 <CAMj1kXEQVJ6kqGFqXT9sqdNX9Juc7CiWa-4q+J7D=YucFimrqA@mail.gmail.com> <e4e0dc96752c33c6ff0e07165467c35a350b23c5.camel@HansenPartnership.com>
In-Reply-To: <e4e0dc96752c33c6ff0e07165467c35a350b23c5.camel@HansenPartnership.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Sun, 19 Jan 2025 17:52:39 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGAyAcjdp448g9TsiBfziUy=WAdQ5e13SZKJ-Vr1e+JiQ@mail.gmail.com>
X-Gm-Features: AbW1kvZ_UrAxOeB2x2hgaqGScpjMfsii7f1pwfLvmdiLRahQg4yP2UUodzfEgtc
Message-ID: <CAMj1kXGAyAcjdp448g9TsiBfziUy=WAdQ5e13SZKJ-Vr1e+JiQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] efivarfs: prevent setting of zero size on the inodes
 in the cache
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: linux-fsdevel@vger.kernel.org, linux-efi@vger.kernel.org, 
	Jeremy Kerr <jk@ozlabs.org>, Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"

On Sun, 19 Jan 2025 at 17:48, James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
>
> On Sun, 2025-01-19 at 17:32 +0100, Ard Biesheuvel wrote:
> > On Sun, 19 Jan 2025 at 16:00, James Bottomley
> > <James.Bottomley@hansenpartnership.com> wrote:
> > >
> > > Current efivarfs uses simple_setattr which allows the setting of
> > > any
> > > size in the inode cache.  This is wrong because a zero size file is
> > > used to indicate an "uncommitted" variable, so by simple means of
> > > truncating the file (as root) any variable may be turned to look
> > > like
> > > it's uncommitted.  Fix by adding an efivarfs_setattr routine which
> > > does not allow updating of the cached inode size (which now only
> > > comes
> > > from the underlying variable).
> > >
> > > Signed-off-by: James Bottomley
> > > <James.Bottomley@HansenPartnership.com>
> > > ---
> > >  fs/efivarfs/inode.c | 17 +++++++++++++++++
> > >  1 file changed, 17 insertions(+)
> > >
> > > diff --git a/fs/efivarfs/inode.c b/fs/efivarfs/inode.c
> > > index ec23da8405ff..a4a6587ecd2e 100644
> > > --- a/fs/efivarfs/inode.c
> > > +++ b/fs/efivarfs/inode.c
> > > @@ -187,7 +187,24 @@ efivarfs_fileattr_set(struct mnt_idmap *idmap,
> > >         return 0;
> > >  }
> > >
> > > +/* copy of simple_setattr except that it doesn't do i_size updates
> > > */
> > > +static int efivarfs_setattr(struct mnt_idmap *idmap, struct dentry
> > > *dentry,
> > > +                  struct iattr *iattr)
> > > +{
> > > +       struct inode *inode = d_inode(dentry);
> > > +       int error;
> > > +
> > > +       error = setattr_prepare(idmap, dentry, iattr);
> > > +       if (error)
> > > +               return error;
> > > +
> > > +       setattr_copy(idmap, inode, iattr);
> > > +       mark_inode_dirty(inode);
> > > +       return 0;
> > > +}
> > > +
> > >  static const struct inode_operations
> > > efivarfs_file_inode_operations = {
> > >         .fileattr_get = efivarfs_fileattr_get,
> > >         .fileattr_set = efivarfs_fileattr_set,
> > > +       .setattr      = efivarfs_setattr,
> > >  };
> >
> > Is it sufficient to just ignore inode size changes?
>
> Yes, as far as my testing goes.
>
> >  Should we complain about this instead?
>
> I don't think so because every variable write (at least from the shell)
> tends to start off with a truncation so we'd get a lot of spurious
> complaints.
>

Fair enough

I'll queue these up - thanks.

