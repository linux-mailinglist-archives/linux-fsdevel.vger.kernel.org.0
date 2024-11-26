Return-Path: <linux-fsdevel+bounces-35883-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DA859D948C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Nov 2024 10:32:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8E92164594
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Nov 2024 09:32:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7B361B87DE;
	Tue, 26 Nov 2024 09:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H14T9VEu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD5E194C61;
	Tue, 26 Nov 2024 09:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732613568; cv=none; b=rRxaesnT3Qzf3rmIGA9jEg7sU+5q7QLC2AZRKE5D2fbAb21tQ2tT1byZAuGE/X9ktbKe9jhM/lWFxVJGMeCrR2kUV2mTpaI4gPLFUo8yfCLOJbiHgG0G01mShmeoyF/hKRNfs5LdVeO5gsN8JhWQnIynPCnQti4LmyuYSn1FtBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732613568; c=relaxed/simple;
	bh=M7GZx/GsHt2BSXXlMMEKaM+QCfTjRb5JF4MRjL1QOQs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MOYczGCEIlKL9ZaAD1sYBrjbwcRAebCtpbwl5K3/6MHdTYYCOEFiit1dtkoNnh1GYO1O2RmaWMwBydG+Q+y46AAFmmLP+1mMR3o3nL6Z3a7zOE8xMiazQNOhek/fuMUq5KX4qz2c7rkzlSJroS+0txiKGYeAhzfAvkthn+aEH7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H14T9VEu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A075C4CECF;
	Tue, 26 Nov 2024 09:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732613567;
	bh=M7GZx/GsHt2BSXXlMMEKaM+QCfTjRb5JF4MRjL1QOQs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=H14T9VEuMP1l1i5tDqTGs7fkgNaFW7goKkYHl7ACLQ8BXhOKG57ZZDjiNbVO0Lltx
	 Fmf9vMOlrDmOHsUed07urt8SbaFS2oJumPEcN5xCwoFaIutAk91OHSIhRNe4uaotJb
	 gvl2j786+7XEpA1zg3x7xTTHlnvLphR32owaXPIschbdr1FLLd2np72oUyx3R+40c/
	 lL1U5r5/XUVy2c22NSDqWgHnnqy+zvcWL6VANBE2fSE3tzUmr0jOZVWWiIA5O/NJ6d
	 iowdSNEHMsUZjnIaXGCzuYcB4REYvaTsYmZR5xqr7n8r6jOchvZWKY32zgrUrx2p2j
	 lBEaeQCgmvOXA==
From: Christian Brauner <brauner@kernel.org>
To: linux-fsdevel@vger.kernel.org,
	Randy Dunlap <rdunlap@infradead.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Eric Sandeen <sandeen@redhat.com>,
	David Howells <dhowells@redhat.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH] fs_parser: update mount_api doc to match function signature
Date: Tue, 26 Nov 2024 10:32:37 +0100
Message-ID: <20241126-zahnmedizin-abwerben-bdbb0f91b373@brauner>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241125215021.231758-1-rdunlap@infradead.org>
References: <20241125215021.231758-1-rdunlap@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=940; i=brauner@kernel.org; h=from:subject:message-id; bh=M7GZx/GsHt2BSXXlMMEKaM+QCfTjRb5JF4MRjL1QOQs=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaS7Tt1+d7N25rnGOJ8zz1zWP52+5IzV2w0pF+7Vpxw/c O7ZeomXpztKWRjEuBhkxRRZHNpNwuWW81RsNsrUgJnDygQyhIGLUwAmst+IkeH2dx42EbVflftv vY5qiVBx//1zx9uw95d/SvHFmV65Eb6X4X9JzNHrPDZhDx/9EE71l2ed+1duw+LL/bxmPBw6N94 sa+UHAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Mon, 25 Nov 2024 13:50:21 -0800, Randy Dunlap wrote:
> Add the missing 'name' parameter to the mount_api documentation for
> fs_validate_description().
> 
> 

Applied to the vfs.fixes branch of the vfs/vfs.git tree.
Patches in the vfs.fixes branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.fixes

[1/1] fs_parser: update mount_api doc to match function signature
      https://git.kernel.org/vfs/vfs/c/c66f759832a8

