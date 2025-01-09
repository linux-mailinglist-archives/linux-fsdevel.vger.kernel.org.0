Return-Path: <linux-fsdevel+bounces-38752-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 544BFA07D0B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jan 2025 17:12:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2135818818D8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jan 2025 16:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FD4A2206B6;
	Thu,  9 Jan 2025 16:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N48xC6Rc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAECD220681;
	Thu,  9 Jan 2025 16:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736439118; cv=none; b=BNDGQ4gEty4bI+9z4L07uVmhvg4ed5agTUXkvJtD+XEfFh9LSnvP3ONLd4xitl+e5B5axzouKaK0TYb+yZK2l2JhRLvdhDCG308QbtYpzQ2Dl+0p9v7f6Mn++jsdS3gA1m3rrHomqDkimzDPUKsuMxO0pVtMwT3sT87odYEeQlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736439118; c=relaxed/simple;
	bh=JA7m3+r2MUe8BHdxHsYdtx9F4e5KEVY5GM8J8HYfzD4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SZXTGMQayR8+oRXiBscJj4DjGMI+N127KXX96bQC1fAMUbuP/34/ayvW5gRzul/t6Vbh7/wtnvqrhjFquY25yK/Qgc37CvyqN+EpS+DmEKKX+7j7+D8IyUekPq5lPELXTka0doUYR75863eURMlCiq1wjsBdt+p5qmPs6INWJk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N48xC6Rc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77CD5C4CED2;
	Thu,  9 Jan 2025 16:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736439117;
	bh=JA7m3+r2MUe8BHdxHsYdtx9F4e5KEVY5GM8J8HYfzD4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=N48xC6Rc69yQT12hw/UF6XlsPGxQNkiwzATCT9e9HcGy1V4HbY+QbE9XnEciXQt9r
	 6NY7R3HFe/DttdJLNj+uRElShysR0ztm0O+DfboBcmCYk8E+EJ/NCxbMYTIAzqXAJL
	 hyDSXPj7r9KFcJyYSWi41xb4lKX8FCPO9ct6MSxAQbkDn1/6TtDF1xPyAlLFMtl1x+
	 DSke/Y855hlon88bkr/7TTb2O+Auo5zVQ5CmqFzolow1YY/2muUkLqdsd5Nbn4mN75
	 7hlcZM4ieAHa+hPYQ85HBktU0AMI157JKA/KuSprzwwCyT2eYCqa1kLlfHLsB6Derd
	 KKxaR9+YD17dQ==
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-54024aa9febso1046662e87.1;
        Thu, 09 Jan 2025 08:11:57 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWJKZ6yhOAESAaOpNgsGo9PsYFOkkG5X4SKW3l73A+HNJQqc3miih3eWEGek57u3LCgzI5xuWxVYa4=@vger.kernel.org
X-Gm-Message-State: AOJu0YynoW5yluSMO7KOunrOhCDIKWfZ5oTyqCe7x52KZq7G+8xYeVBI
	WF8YfdOnk0VUQfNdNB8Ho47oMTicK/wAdQrfoO9X6UdLPRQ9PfAjnJEk1AQKB0NB/sDOPl1t4c4
	wHAfRKq8UysqeonJKwM50LVtNYJI=
X-Google-Smtp-Source: AGHT+IEab1pzhymrx824hZ6lRescnrHeXXXXsbufv7ysX2MRpKtM9EJJjpadE3xU3zoL+CRZg9WrgVc5aBHTGvzK2i8=
X-Received: by 2002:a05:6512:ea8:b0:540:1a0c:9ba6 with SMTP id
 2adb3069b0e04-542845d47f9mr2269416e87.34.1736439115801; Thu, 09 Jan 2025
 08:11:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250107023525.11466-1-James.Bottomley@HansenPartnership.com>
 <CAMj1kXHy+D2GDANFyYJLOZj1fPmgoX+Ed6CRy3mSSCeutsO07w@mail.gmail.com> <8ec4aa383506dd1c28c650874b3d8e36ded2a2c9.camel@HansenPartnership.com>
In-Reply-To: <8ec4aa383506dd1c28c650874b3d8e36ded2a2c9.camel@HansenPartnership.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 9 Jan 2025 17:11:44 +0100
X-Gmail-Original-Message-ID: <CAMj1kXEpUyMUH38GEM-vtzPNGGKOOcuRzi8qGQkTzf9CB+AwQQ@mail.gmail.com>
X-Gm-Features: AbW1kvYRDBp1BKPCwvSj4Lv09-pt0pOtbAda7hveevAA8AW5xhjNFCX2LxuSBgU
Message-ID: <CAMj1kXEpUyMUH38GEM-vtzPNGGKOOcuRzi8qGQkTzf9CB+AwQQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] convert efivarfs to manage object data correctly
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: linux-fsdevel@vger.kernel.org, linux-efi@vger.kernel.org, 
	Jeremy Kerr <jk@ozlabs.org>, Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"

On Thu, 9 Jan 2025 at 16:50, James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
>
> On Thu, 2025-01-09 at 10:50 +0100, Ard Biesheuvel wrote:
> > On Tue, 7 Jan 2025 at 03:36, James Bottomley
> > <James.Bottomley@hansenpartnership.com> wrote:
> [...]
> > > James Bottomley (6):
> > >   efivarfs: remove unused efi_varaible.Attributes and .kobj
> > >   efivarfs: add helper to convert from UC16 name and GUID to utf8
> > > name
> > >   efivarfs: make variable_is_present use dcache lookup
> > >   efivarfs: move freeing of variable entry into evict_inode
> > >   efivarfs: remove unused efivarfs_list
> > >   efivarfs: fix error on write to new variable leaving remnants
> > >
> >
> > Thanks James,
> >
> > I've tentatively queued up this series, as well as the hibernate one,
> > to get some coverage from the robots while I run some tests myself.
> >
> > Are there any existing test suites that cover efivarfs that you could
> > recommend?
>
> I'm afraid I couldn't find any.  I finally wrote a few shell scripts to
> try out multiple threads updating the same variable.  I think I can
> probably work out how to add these to the kselftest infrastructure.
> Hibernation was a real pain because it doesn't work with secure boot,
> but I finally wrote a UEFI shell script to modify variables and reset.
> Unfortunately I don't think we have a testing framework I can add these
> to.
>

I tested the hibernation changes using QEMU/arm64, using a
non-persistent varstore image, and checked whether adding and/or
deleting variables via efivarfs resulted in the expected behavior
after a resume from hibernate.

I also checked the behavior regarding zero sized files, and that looks
sound to me. But I didn't go as far as torture test it with concurrent
updates as you have.

All in all, I think it is reasonable to queue this up so it gets some
wider exposure.

