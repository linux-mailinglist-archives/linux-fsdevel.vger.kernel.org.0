Return-Path: <linux-fsdevel+bounces-7693-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52D12829706
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jan 2024 11:12:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD8FD284C50
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jan 2024 10:12:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8D103FB33;
	Wed, 10 Jan 2024 10:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rtuj9gKL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1792D3F8F1
	for <linux-fsdevel@vger.kernel.org>; Wed, 10 Jan 2024 10:12:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01118C433F1;
	Wed, 10 Jan 2024 10:12:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704881525;
	bh=LHQ+phcaIrAptda2OFp1S0ww2j/0GuZg3vmGhOwii5Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rtuj9gKL5Hprjerley7/LxOyA5+oCI0o25yuqU8IWV/+tWLGbU7Hh8+JQhfjka8tE
	 E7AvmfnkJpSojHFckJ7OhXvFBiEFIFOREToQbEgzXWvOts/Wz+sjTsN5rVysci8/LE
	 X8m+UtIPhkUkiNRqNLM659DEoB+2zdtJgbZxTLOC2CJgSLtPYETwd51Ek4C8pJXmM2
	 h+EGhsDSv/xdeCCb/3OCzx7csV8n0X8C+VAgzvjZb8fukqA41Rb+tnnrAXImNk8YWF
	 J5rdgIGeXxBV/kLCRpdJYr/y8DLfDzQiO5Mz/APQA1rYOaxp4TI6bghKVq6Zx0Tkwe
	 shqYRtUI5wHuw==
From: Christian Brauner <brauner@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fsnotify: compile out fsnotify permission hooks if !FANOTIFY_ACCESS_PERMISSIONS
Date: Wed, 10 Jan 2024 11:11:48 +0100
Message-ID: <20240110-weinanbau-ergotherapie-653f619b6ad9@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240109182245.38884-1-amir73il@gmail.com>
References: <20240109182245.38884-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1116; i=brauner@kernel.org; h=from:subject:message-id; bh=LHQ+phcaIrAptda2OFp1S0ww2j/0GuZg3vmGhOwii5Q=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTOy83JPb9pRtbcDcodM8M8b5rMNhbbON1mx3cnrq2bp m4p2JB8taOUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAiDIsZ/nA99mRcHs+ntEbi dvKdb4JKZe2fnh86kNR9Tfz8Kx97fg1GhpPTf/AFz0g6tvAfW0CHadmVAklrseluBel3FG84SX3 XZQEA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Tue, 09 Jan 2024 20:22:45 +0200, Amir Goldstein wrote:
> The depency of FANOTIFY_ACCESS_PERMISSIONS on SECURITY made sure that
> the fsnotify permission hooks were never called when SECURITY was
> disabled.
> 
> Moving the fsnotify permission hook out of the secutiy hook broke that
> optimisation.
> 
> [...]

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

[1/1] fsnotify: compile out fsnotify permission hooks if !FANOTIFY_ACCESS_PERMISSIONS
      https://git.kernel.org/vfs/vfs/c/b0f2ac4fe541

