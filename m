Return-Path: <linux-fsdevel+bounces-38740-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 60ED6A0791B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jan 2025 15:25:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34BE27A3159
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jan 2025 14:25:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0A9E21B18A;
	Thu,  9 Jan 2025 14:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rILD4UmZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A751219EB6;
	Thu,  9 Jan 2025 14:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736432687; cv=none; b=XNa1U1GFQdPkxPZynWDf83/LPzAgH+Vv7pqsgj3Pd6+2dX8tI0+CQkcLpapTVKEp+s8T/TurESJmxXMJBVi59Gw/Oe4VG1tEivNDrNrM0URoUApuo45u3YTplN0G4yhFD95C8lLjWfqyH/gDfaH+kzrmDLLPyIKib4Q3xQ7NCp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736432687; c=relaxed/simple;
	bh=jaa6R9FjR24fTZ569p2L8SukGki7KN9rrIQk1/kuRiU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=akfax1x4Vpn+MIDwDWBm8G3rUsztjgXNGEHXxwVAY1wUUzhzfs3Yx/ItDz6YN72oQSBnu27XDPUlRvERW/o/pIqM5in5zD897Y1voGOf0bOOjcB8gFZB2Xe5p+UVs0iI7sfsdi4gwibeI52W7UJVNn39OR75HfQcMQ9r1/ULZFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rILD4UmZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E85F9C4CEE4;
	Thu,  9 Jan 2025 14:24:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736432686;
	bh=jaa6R9FjR24fTZ569p2L8SukGki7KN9rrIQk1/kuRiU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=rILD4UmZfMJG6phrxvs8Cohdem3rRIGhmlA8aFNwTgNhOP+lYCJay62CyntH58dun
	 qk0oM/GEiWr+0SUTn2AxzOXtgYlo+OI+rTWt2tGvlh+8MLGSEBiGS0Zu2r4H5p0trV
	 kGaTHta9vmtIM0NSFGaDjulqxL8/pe/UBAZD7OOrIE+srwygMEoQ98f66nD103Xlq8
	 25IoyrSInPYYYAT+M1vKQQGVhwcDo3lxlqZSdYgXrlq8Xbj+qm+jbSU1bFcpWFKc6K
	 j4JzyjnQy5vZPeKzIrbQHskBD+WUQGSpb2H/R3yFoN5JC7mc8jGADZfEWfsMbYcc6C
	 omQG9PqUpBG7g==
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-30167f4c1deso7993471fa.1;
        Thu, 09 Jan 2025 06:24:46 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUlPpY0YPMQF2/AGmRd0fm2m+KeQu+V5W0JhdBMdejbzIypPSvf9qIAxip4znmpMvEQH6mWTCSGLQ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YweCGBo5STmIrZ/qVbkMQ0vSeGHg3npC3yn02HiaodCz2J9Mhs2
	UO+OodPmwFzlPEqG44pfrjQWR1wEOiZQuntp46XJ2g/XjqCWCc4kDMs5xeyx9cEeEWaRaTxbjK8
	FhvSthrYOG+9qUic1mIy4XZzdVak=
X-Google-Smtp-Source: AGHT+IHuf/paA/0BAgb13qtejl2qZTrQHqYTLErf3suy1S359kZezvJ8LIhwAmSlbUWffvhWq5fAO6khyKtmQggGOdA=
X-Received: by 2002:a2e:b8c7:0:b0:2ff:a89b:4210 with SMTP id
 38308e7fff4ca-305f453383amr22875691fa.8.1736432685132; Thu, 09 Jan 2025
 06:24:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250107023525.11466-1-James.Bottomley@HansenPartnership.com> <CAMj1kXHy+D2GDANFyYJLOZj1fPmgoX+Ed6CRy3mSSCeutsO07w@mail.gmail.com>
In-Reply-To: <CAMj1kXHy+D2GDANFyYJLOZj1fPmgoX+Ed6CRy3mSSCeutsO07w@mail.gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 9 Jan 2025 15:24:34 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFMMSQB9oyNkpEmd1RMBYc_3GuPPOPjxQyWKFgUNdqtWQ@mail.gmail.com>
X-Gm-Features: AbW1kvZJSXK8qLPcFbWBljtbIVVv-mxItBnUHPgKi7mzQ2eoCaLitx_gOblRutI
Message-ID: <CAMj1kXFMMSQB9oyNkpEmd1RMBYc_3GuPPOPjxQyWKFgUNdqtWQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] convert efivarfs to manage object data correctly
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: linux-fsdevel@vger.kernel.org, linux-efi@vger.kernel.org, 
	Jeremy Kerr <jk@ozlabs.org>, Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"

On Thu, 9 Jan 2025 at 10:50, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Tue, 7 Jan 2025 at 03:36, James Bottomley
> <James.Bottomley@hansenpartnership.com> wrote:
> >
> > I've added fsdevel because I'm hopping some kind vfs person will check
> > the shift from efivarfs managing its own data to its data being
> > managed as part of the vfs object lifetimes.  The following paragraph
> > should describe all you need to know about the unusual features of the
> > filesystem.
> >
> > efivarfs is a filesystem projecting the current state of the UEFI
> > variable store and allowing updates via write.  Because EFI variables
> > contain both contents and a set of attributes, which can't be mapped
> > to filesystem data, the u32 attribute is prepended to the output of
> > the file and, since UEFI variables can't be empty, this makes every
> > file at least 5 characters long.  EFI variables can be removed either
> > by doing an unlink (easy) or by doing a conventional write update that
> > reduces the content to zero size, which means any write update can
> > potentially remove the file.
> >
> > Currently efivarfs has two bugs: it leaks memory and if a create is
> > attempted that results in an error in the write, it creates a zero
> > length file remnant that doesn't represent an EFI variable (i.e. the
> > state reflection of the EFI variable store goes out of sync).
> >
> > The code uses inode->i_private to point to additionaly allocated
> > information but tries to maintain a global list of the shadowed
> > varibles for internal tracking.  Forgetting to kfree() entries in this
> > list when they are deleted is the source of the memory leak.
> >
> > I've tried to make the patches as easily reviewable by non-EFI people
> > as possible, so some possible cleanups (like consolidating or removing
> > the efi lock handling and possibly removing the additional entry
> > allocation entirely in favour of simply converting the dentry name to
> > the variable name and guid) are left for later.
> >
> > The first patch removes some unused fields in the entry; patches 2-3
> > eliminate the list search for duplication (some EFI variable stores
> > have buggy iterators) and replaces it with a dcache lookup.  Patch 4
> > move responsibility for freeing the entry data to inode eviction which
> > both fixes the memory leak and also means we no longer need to iterate
> > over the variable list and free its entries in kill_sb.  Since the
> > variable list is now unused, patch 5 removes it and its helper
> > functions.
> >
> > Patch 6 fixes the second bug by introducing a file_operations->release
> > method that checks to see if the inode size is zero when the file is
> > closed and removes it if it is.  Since all files must be at least 5 in
> > length we use a zero i_size as an indicator that either the variable
> > was removed on write or that it wasn't correctly created in the first
> > place.
> >
> > v2: folded in feedback from Al Viro: check errors on lookup and delete
> >     zero length file on last close
> >
> > James
> >
> > ---
> >
> > James Bottomley (6):
> >   efivarfs: remove unused efi_varaible.Attributes and .kobj
> >   efivarfs: add helper to convert from UC16 name and GUID to utf8 name
> >   efivarfs: make variable_is_present use dcache lookup
> >   efivarfs: move freeing of variable entry into evict_inode
> >   efivarfs: remove unused efivarfs_list
> >   efivarfs: fix error on write to new variable leaving remnants
> >
>
> Thanks James,
>
> I've tentatively queued up this series, as well as the hibernate one,
> to get some coverage from the robots while I run some tests myself.
>

For the record,

Tested-by: Ard Biesheuvel <ardb@kernel.org>

including the hibernation pieces. It looks pretty to me solid to me.

I'd add a Reviewed-by: as well if I wasn't so clueless about VFS
stuff, so I'll gladly take one from the audience.

Thanks again, James - this is a really nice cleanup.

