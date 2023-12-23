Return-Path: <linux-fsdevel+bounces-6828-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C442481D428
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Dec 2023 14:11:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32D15B22629
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Dec 2023 13:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 432BAD300;
	Sat, 23 Dec 2023 13:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AIRjINYG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A899DCA7E;
	Sat, 23 Dec 2023 13:11:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CE01C433C7;
	Sat, 23 Dec 2023 13:11:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703337088;
	bh=iqSS45CShcvhUCmvhEOAPQULCaDRCWWgivFSf8KVhrM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AIRjINYG7V2Lm0UVESMvyq9c7UKBgZAu9W3/om5qCywDpTVrGChndYdCrl7iw0FA+
	 ZEtP5rw6zKN/TJvC9N+F7+iabFwduI/BcMABM7B2d7wu2TEOBANnUZ6YRhugubXtud
	 B/pd6I3qkkZuoTVRFJ8ylr/8WKLE/XGAxtw3Dcj671onvr/VwksryPqJMPA2xx+OMf
	 9l0QecdF5NL0u3QGbSyEbErB/mJ4igBu7o1dTCcOqrB8jKpsUfo64yTVXLkheaGFjK
	 cPOkYc1SjAsJTlwiW3Rdg6t9DR8VjJSDm2gaqfoGuwy5SFOxpnyJZ7Kta4j12835VI
	 wL9fhGinIqY5w==
Date: Sat, 23 Dec 2023 14:11:24 +0100
From: Christian Brauner <brauner@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org,
	linux-unionfs@vger.kernel.org
Subject: Re: [RFC][PATCH 0/4] Intruduce stacking filesystem vfs helpers
Message-ID: <20231223-kronleuchter-kehren-f91545a17968@brauner>
References: <20231221095410.801061-1-amir73il@gmail.com>
 <20231222-bekennen-unrat-a42e50abe5de@brauner>
 <CAOQ4uxiDEHattVW2NecEwf66GNrUnkAief9XSTWbegcgyzuSbA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxiDEHattVW2NecEwf66GNrUnkAief9XSTWbegcgyzuSbA@mail.gmail.com>

On Sat, Dec 23, 2023 at 10:07:11AM +0200, Amir Goldstein wrote:
> On Fri, Dec 22, 2023 at 2:44 PM Christian Brauner <brauner@kernel.org> wrote:
> >
> > > If I do that, would you preffer to take these patches via the vfs tree
> >
> > I would prefer if you:
> >
> > * Add the vfs infrastructure stuff on top of what's in vfs.file.
> >   There's also currently a conflict between this series and what's in there.
> 
> I did not notice any actual conflicts with vfs.file.
> They do change the same files, but nothing that git can't handle.
> Specifically, FMODE_BACKING was excepted from the fput()
> changes, so also no logic changes that I noticed.

Huh, let me retry while writing this mail:

  ✓ [PATCH RFC 1/4] fs: prepare for stackable filesystems backing file helpers
    + Link: https://lore.kernel.org/r/20231221095410.801061-2-amir73il@gmail.com
    + Signed-off-by: Christian Brauner <brauner@kernel.org>
  ✓ [PATCH RFC 2/4] fs: factor out backing_file_{read,write}_iter() helpers
    + Link: https://lore.kernel.org/r/20231221095410.801061-3-amir73il@gmail.com
    + Signed-off-by: Christian Brauner <brauner@kernel.org>
  ✓ [PATCH RFC 3/4] fs: factor out backing_file_splice_{read,write}() helpers
    + Link: https://lore.kernel.org/r/20231221095410.801061-4-amir73il@gmail.com
    + Signed-off-by: Christian Brauner <brauner@kernel.org>
  ✓ [PATCH RFC 4/4] fs: factor out backing_file_mmap() helper
    + Link: https://lore.kernel.org/r/20231221095410.801061-5-amir73il@gmail.com
    + Signed-off-by: Christian Brauner <brauner@kernel.org>
  ---
  ✓ Signed: DKIM/gmail.com
---
Total patches: 4
---
Applying: fs: prepare for stackable filesystems backing file helpers
Applying: fs: factor out backing_file_{read,write}_iter() helpers
Patch failed at 0002 fs: factor out backing_file_{read,write}_iter() helpers
When you have resolved this problem, run "git am --continue".
If you prefer to skip this patch, run "git am --skip" instead.
To restore the original branch and stop patching, run "git am --abort".
error: sha1 information is lacking or useless (fs/overlayfs/file.c).
error: could not build fake ancestor
hint: Use 'git am --show-current-patch=diff' to see the failed patch

Ok, I see that I didn't include your branch so git got confused by
missing overlayfs changes that you have in your tree and thus failed to
apply here.

> 
> The only conflict I know of is with the vfs.rw branch,
> the move of *_start_write() into *__iter_write(), therefore,
> these patches are already based on top of vfs.rw.

Aha, there we go.

> 
> I've just pushed branch backing_file rebased over both
> vfs.rw and vfs.file to:
> https://github.com/amir73il/linux/commits/backing_file
> 
> Started to run overlayfs tests to see if vfs.file has unforeseen impact
> that I missed in review.
> 
> > * Pull vfs.file into overlayfs.
> > * Port overlayfs to the new infrastructure.
> >
> 
> Wait, do you mean add the backing_file_*() helpers
> and only then convert overlayfs to use them?
> 
> I think that would be harder to review (also in retrospect)
> so the "factor out ... helper" patches that move code from
> overlayfs to fs/backing_file.c are easier to follow.

It depends. Here I think it's a bit similar to David's netfs library
stuff where a bunch of infra is added. Then the conversion is on top of
that. However, I have no mandatory rule here.

> 
> Or did you mean something else?
> 
> > io_uring already depends on vfs.file as well.
> >
> > If this is straightforward I can include it in v6.8. The VFS prs will go
> > out the week before January 7.
> 
> Well, unless I misunderstood you, that was straightforward.
> The only complexity is the order and dependency among the PRs.
> 
> If I am not mistaken, backing_file could be applied directly on top of
> vfs.rw and sent right after it, or along with it (via your tree)?

Along with it.

