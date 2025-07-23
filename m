Return-Path: <linux-fsdevel+bounces-55827-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F097B0F2B5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 15:00:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78C9D1C84744
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 13:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72C392E7640;
	Wed, 23 Jul 2025 13:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a10hlX3V"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB00D2E719C;
	Wed, 23 Jul 2025 13:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753275637; cv=none; b=XHJOs1ckO3z9EMqbcaU9qbBeWMHOya+hExj3JLXG4KXmYrCT5VrtaAW6VDUJ5gkjdkvEW41o83UkWC5lwFqQLbbx4UmW3NAi08P9gm78VOqdNpwZsET71vjwiaQrmaBCzzhe7HhGAtxTVC7495A6kzICxO2C62zELK31q7kfIgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753275637; c=relaxed/simple;
	bh=eRf4Cih9YhOYA+UX246T+Ym+G4cCUPmS6X+sT6ta8Gk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kxGJ9Lk2nS4HfUfwtLJGTCuMNDFCm8AFpK8muUca8bOmTNjA0aUUTQ4BTlyhWW4v0BOV2nXV7G/H3qTjsx6JbdnHgzEm4OinEG6jT/KF+gPwU6CPIEqmd8/Ro/kLiEzqqoXYeAsxddN3CyQTrf5yrIn31CeChiCl2e5MR+rP7bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a10hlX3V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37B95C4CEF5;
	Wed, 23 Jul 2025 13:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753275637;
	bh=eRf4Cih9YhOYA+UX246T+Ym+G4cCUPmS6X+sT6ta8Gk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a10hlX3VqAc+OoovMwxC62UoHxrXGYFxE1xnu1mOLs94S5e3oUOaX/Yduuhy+Jh3y
	 +90SVVBHm3IdsXNdf3aeiISI+UYXDpdTmCzs+RoRD9Mneht+HsnmbxzP4kB5xCU3s1
	 hISIASadEyiLagsEfIimIVHTQglgqq26HgGNxSFZNwg17Bp3a8eeG6PMtMDonujETr
	 K0BrakaxBPhpz883r/7iXNdSV/1d8xpdWL3UXJ+368s8vSw8Cyw5gj3VmGU4KOTwz1
	 C9MOsVVQeIC7LjvCilpUHtRwsIXHDqJMoWS/dr/jvcshmD5EtugbZqxnOS2gEYwcUA
	 rJNNPQ8ieEQfQ==
From: Christian Brauner <brauner@kernel.org>
To: Jann Horn <jannh@google.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	kernel test robot <lkp@intel.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH] eventpoll: fix sphinx documentation build warning
Date: Wed, 23 Jul 2025 15:00:26 +0200
Message-ID: <20250723-abhob-leiht-6d60441f0a65@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250721-epoll-sphinx-fix-v1-1-b695c92bf009@google.com>
References: <20250721-epoll-sphinx-fix-v1-1-b695c92bf009@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1129; i=brauner@kernel.org; h=from:subject:message-id; bh=eRf4Cih9YhOYA+UX246T+Ym+G4cCUPmS6X+sT6ta8Gk=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQ03PnwVvfkyi8L/mwviRZf33nH+tO3nW45Ls0SNw935 pTdYVzC31HKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCR/u+MDFvsVsyucz695l/P B5P5E6WfvrZjVX3VrXxTij9zflColCAjw8yy2q+xvXdjj8Z1nGo4yrDh1Fr1O3ry/1LuGifeeOo RwwwA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Mon, 21 Jul 2025 19:09:55 +0200, Jann Horn wrote:
> Sphinx complains that ep_get_upwards_depth_proc() has a kerneldoc-style
> comment without documenting its parameters.
> This is an internal function that was not meant to show up in kernel
> documentation, so fix the warning by changing the comment to a
> non-kerneldoc one.
> 
> 
> [...]

Applied to the vfs-6.17.misc branch of the vfs/vfs.git tree.
Patches in the vfs-6.17.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.17.misc

[1/1] eventpoll: fix sphinx documentation build warning
      https://git.kernel.org/vfs/vfs/c/ecb6cc0fd8cd

