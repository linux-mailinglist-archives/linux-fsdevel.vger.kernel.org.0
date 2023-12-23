Return-Path: <linux-fsdevel+bounces-6857-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCF6B81D664
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Dec 2023 20:51:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAC511C217FA
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Dec 2023 19:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC59E15EAC;
	Sat, 23 Dec 2023 19:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fvF147pF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA2715481;
	Sat, 23 Dec 2023 19:51:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D424C433C7;
	Sat, 23 Dec 2023 19:51:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703361085;
	bh=u7ygzGPjuBwLfW8yEdZK803ninkHtEohyWbt2QaO3C4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fvF147pFfRc1lZNdaSHoh+EIX7YnasrDvLhAEwwLAOSEK+rrmRrv44T9XBcG4M2Ar
	 tzaPyXGSVMNln/tuih3PIxRQSYM09AG6IzoxOh4gFktuDec4dkWQ45ByTKTMcSpC0k
	 OG4LHpFTR1S8i89NlEa43SDQEkkro3T21qsFIdGNWs5Wkp4hWzSry/8Mz5reajYc+5
	 DNCKBwDAYEeMy71ZWYW1ZxPuAH5uu5VDXrwN1uEfkIwthDTgQFlQ9Y+56suzne6ZEB
	 3CEECBZhkrUIn/nwQYwj4FEX7BrSuXpwkPf6IDSAXUX9k0hfTE63QvoCN9B3IHckmO
	 qKmGnmuP6IydQ==
From: Christian Brauner <brauner@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-unionfs@vger.kernel.org,
	Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: [GIT PULL] overlayfs backing file helpers for 6.8
Date: Sat, 23 Dec 2023 20:51:16 +0100
Message-ID: <20231223-jagdsaison-querschnitt-b52158ca1d48@brauner>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231223154405.941062-1-amir73il@gmail.com>
References: <20231223154405.941062-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1124; i=brauner@kernel.org; h=from:subject:message-id; bh=u7ygzGPjuBwLfW8yEdZK803ninkHtEohyWbt2QaO3C4=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaS2Wxnv93BbNUOu7+g39cy6mat+7Llgy3rRz87OdXLvt hIj1pnBHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABMpyWZk6GRdJh3TI6nybsv5 jQEtHzkW+b+8myP+9sW7ObKLF+xVmcfwP9fYkHf/1k+FS5QVvdXve5ZNn/86utvoevsHZf2oBtd qBgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Sat, 23 Dec 2023 17:44:05 +0200, Amir Goldstein wrote:
> Please pull the overlayfs backing file helpers for 6.8.
> 
> The only change since the patches that you reviewed [1] is that I added
> assertion to all the helpers that file is a backing_file as you requested.
> 
> This branch merges cleanly with master branch of the moment.
> 
> This branch depends on and is based on top of vfs.rw branch in your tree.
> When test merging with vfs.all of the moment, there is a trivial conflict
> in MAINTAINERS file with the vfs.netfs branch.
> 
> [...]

Pulled into the vfs.rw branch of the vfs/vfs.git tree.
Patches in the vfs.rw branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series or pull request allowing us to
drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.rw

https://git.kernel.org/vfs/vfs/c/7a18c0fff41e

