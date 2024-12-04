Return-Path: <linux-fsdevel+bounces-36463-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 082FF9E3C7F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2024 15:17:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 434C9166B4A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2024 14:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C45C1FA826;
	Wed,  4 Dec 2024 14:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AkLcFG5v"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD601F7084
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Dec 2024 14:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733321825; cv=none; b=mul+Kl3gGSQrp1Kox6OZdB03Um4gX1cJena+rNM5w4RnBGZhbn3KkNXZJVhvw15/SX4lITpC4dkn2mMP754eQkMC5c+0eXyxR4pkV+5amhVK0BJTlo5hodRAw+duucJ4oodGDdownbbWiQGHOiHvhMQNBupDi19gySsUPsbDoMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733321825; c=relaxed/simple;
	bh=p3eUDJE729f2B/4Ombhhcu2NHITmos9R5oamr31zlsY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TO4RR8E+NER9CuF0hE3zcorEqJNg0AK9OBAGQfR1Nc8Xjv0/HX3tazrfAAMQW2FVheYfcA7mAkEBjghdhpVY+bSvVCbO/cfqcwRaxJT9OhNbIbbHX04w2NQTsEHJDyTG4uO16yGDlvWYuh7by9qeHGCn3A/9+BFKa+z+jIqwNPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AkLcFG5v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC64BC4CECD;
	Wed,  4 Dec 2024 14:17:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733321825;
	bh=p3eUDJE729f2B/4Ombhhcu2NHITmos9R5oamr31zlsY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AkLcFG5vz0+jBtfjYIzi5d8R70eBZXR8BmC50bXKkdjmqu/IBL2SWY3UphaU2VSZO
	 HSqESgPkxkz+UNFRwcm+BWmS0FIL4Zq9wZV2Ok8mvsLzpNkgf7bRxKmeU0R0Hkn8OA
	 VbFQ50OqTPE9SYVuLd49NUxkIdD4FatuXWCcnzOTfpixYajxG/vgpCxY1rVR4cdE7G
	 jfh3F9a3VUOaSmaCNOg2MydhQ/Bx3GXEr8h3DCwSLHVxnbYKvGjbgbtM8ZpJKl8C/E
	 7EasxiLVJhY7Za6MaZfdCtU8N9nOqkSAhp7iSt9NIbQYwk9TzL599Tf0uH5j1dGAjO
	 kdRLvCTMkznOA==
Date: Wed, 4 Dec 2024 15:17:01 +0100
From: Christian Brauner <brauner@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jeff Layton <jlayton@kernel.org>, Erin Shepherd <erin.shepherd@e43.eu>, 
	Chuck Lever <chuck.lever@oracle.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2] selftests/pidfd: add pidfs file handle selftests
Message-ID: <20241204-inlandsreise-mehrfach-76ae3cc5fc88@brauner>
References: <20241202-imstande-einsicht-d78753e1c632@brauner>
 <20241204-goldbarren-endzeit-81cb9736bf61@brauner>
 <CAOQ4uxhdcWfjboS8yBs9SLU7G0yY8DXz8QnL8S5prR0dnvVumw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxhdcWfjboS8yBs9SLU7G0yY8DXz8QnL8S5prR0dnvVumw@mail.gmail.com>

On Wed, Dec 04, 2024 at 02:44:51PM +0100, Amir Goldstein wrote:
> On Wed, Dec 4, 2024 at 12:35 PM Christian Brauner <brauner@kernel.org> wrote:
> >
> > Add selftests for pidfs file handles.
> >
> > Link: https://lore.kernel.org/r/20241202-imstande-einsicht-d78753e1c632@brauner
> > Signed-off-by: Christian Brauner <brauner@kernel.org>
> > ---
> > I've added a bunch more selftests.
> > Frankly, I'm going to probably be adding more as corner cases come to me.
> > And I'm just going to be amending the patch and stuffing them into the
> > tree unless I hear objections.
> > ---
> 
> Generally, tests look good and you may add
> 
> Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> 
> But I wonder...
> 
> [...]
> 
> > +/*
> > + * Test valid flags to open a pidfd file handle. Note, that
> > + * PIDFD_NONBLOCK is defined as O_NONBLOCK and O_NONBLOCK is an alias to
> > + * O_NDELAY. Also note that PIDFD_THREAD is an alias for O_EXCL.
> > + */
> > +TEST_F(file_handle, open_by_handle_at_valid_flags)
> > +{
> > +       int mnt_id;
> > +       struct file_handle *fh;
> > +       int pidfd = -EBADF;
> > +       struct stat st1, st2;
> > +
> > +       fh = malloc(sizeof(struct file_handle) + MAX_HANDLE_SZ);
> > +       ASSERT_NE(fh, NULL);
> > +       memset(fh, 0, sizeof(struct file_handle) + MAX_HANDLE_SZ);
> > +       fh->handle_bytes = MAX_HANDLE_SZ;
> > +
> > +       ASSERT_EQ(name_to_handle_at(self->child_pidfd2, "", fh, &mnt_id, AT_EMPTY_PATH), 0);
> > +
> > +       ASSERT_EQ(fstat(self->child_pidfd2, &st1), 0);
> > +
> > +       pidfd = open_by_handle_at(self->pidfd, fh,
> > +                                 O_RDONLY |
> > +                                 O_WRONLY |
> > +                                 O_RDWR |
> > +                                 O_NONBLOCK |
> > +                                 O_NDELAY |
> > +                                 O_CLOEXEC |
> > +                                 O_EXCL);
> > +       ASSERT_GE(pidfd, 0);
> > +
> 
> IIRC, your patch always opens an fd with O_RDWR. Right?
> 
> Isn't it confusing to request O_RDONLY and get O_RDWR?
> Should we only allow requests to request open_by_handle_at()
> with O_RDWR mode?

I think it's nicer to allow people to use open_by_handle_at() with a
zero flag value as O_RDONLY is 0 and have things just work instead of
confusing them by forcing them to specify O_RDWR. Similar to how
pidfd_open() always gives you a O_RDWR file.

