Return-Path: <linux-fsdevel+bounces-25490-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E341994C797
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Aug 2024 02:28:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F068D1C21F75
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Aug 2024 00:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80C9A442C;
	Fri,  9 Aug 2024 00:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ulg63fX3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9B423DE;
	Fri,  9 Aug 2024 00:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723163311; cv=none; b=ZUPrqjkKJ8+3iB9S9GHLEeU+YJhcUQt2Rg/VQ3syHJDkJOfvApHXYSu3feGX2cH6wW/x4TQ1fRvtERUKZTOYDqUF3PV8RbGweCIMgxkWXwzLJ0F6F3IvFAE/CqqNhZ7jgDwkuvL8spyzOthKmR3xn2EVh7UI14h7TPT1WTpJaVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723163311; c=relaxed/simple;
	bh=j7acfRmWN8a8RIUIMSOekjkgzrtuHbzOe0P51lahgZw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=uF8c106WMTLtSg5VmAFj8lMVU4MagprHyaQtIEJ2kg3wVu7RM4NmdK2ejWM7tWRH4KquIcmSaNMV8O9q+87AIeLP74AVHX1edT8VL+ijl/fuF8PTt5bjGcPn02JTs+rKWg0UTklNXXoGmDVCF8jvs9EKcPf5VegiuZ/eEytYlC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ulg63fX3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 379B9C32782;
	Fri,  9 Aug 2024 00:28:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723163310;
	bh=j7acfRmWN8a8RIUIMSOekjkgzrtuHbzOe0P51lahgZw=;
	h=Date:From:To:Cc:Subject:From;
	b=ulg63fX3EbQGQNuLeccth32BOSnsq27MAYDmw9ss10IlQqo+IySmhDspOzs0/+U4U
	 jtBE71A+RPcxIZZmoPgZz0EltuxNM0QDXm+Xp65M1DnAe68BlMnOxMljwtDWogU4H+
	 f72+n87jL/IoOTLZ5VgQ/jV6HPw7K13zzEBo6aWT9L8pvzxB64d5jGU7r/v6XFoNge
	 6M3AorT1XF+eG4J3PSvuu/2KNkaQ7dkC6W0obbnr8uUwqcTx5NGD2jPEndnDRjzSda
	 q0NiOj9jMGWBsXm8iAt5o3znVlD9X5OOGyhYMy2lg5S7yY3izvhKWo6eegP3SE2kIZ
	 9G04ZcYr1uM1Q==
Date: Fri, 9 Aug 2024 08:28:24 +0800
From: Gao Xiang <xiang@kernel.org>
To: linux-erofs@lists.ozlabs.org
Cc: linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: [ANNOUNCE] erofs-utils: release 1.8
Message-ID: <ZrViqMFpC6uVEoXK@debian>
Mail-Followup-To: linux-erofs@lists.ozlabs.org,
	linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi folks,

A new version erofs-utils 1.8 is available at:
git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs-utils.git tags/v1.8

It mainly includes the following changes:

   - (mkfs.erofs) support multi-threaded compression (Yifan Zhao);
   - support Intel IAA hardware accelerator with Intel QPL;
   - add preliminary Zstandard support;
   - (erofsfuse) use FUSE low-level APIs and support multi-threading (Li Yiyan);
   - (mkfs.erofs) support tar source without data (Mike Baynton);
   - (mkfs.erofs) support incremental builds (incomplete, EXPERIMENTAL);
   - (mkfs.erofs) other build performance improvements;
   - (erofsfuse) support building erofsfuse as a static library (ComixHe);
   - various bugfixes and cleanups (Sandeep Dhavale, Noboru Asai,
           Luke T. Shumaker, Yifan Zhao, Hongzhen Luo and Tianyi Liu).

It has been long time since the last release, mainly due to several new
major features and limited incremental builds.  However, it'd be better
not to hold it off any longer, as users have asked for multi-threaded
mkfs support.

In the future erofs-utils versions, we are going to improve incremental
builds, support multi-threaded mkfs for fragments and compressed data
deduplication, multi-threaded fsck/extraction as well as more remote
storage (e.g. HTTP, S3 and OCI registries), stabilize liberofs APIs for
3rd-party applications and eventually find a way to integrate a Rust
version [1].  Also see [2].

Feedback and contribution, as always, are welcomed.

[1] https://github.com/ToolmanP/erofs-rs
[2] https://erofs.docs.kernel.org/en/latest/roadmap.html

Thanks,
Gao Xiang

