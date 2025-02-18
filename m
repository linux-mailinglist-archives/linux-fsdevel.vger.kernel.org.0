Return-Path: <linux-fsdevel+bounces-41962-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25145A39422
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2025 08:52:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFABD3B8AB3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2025 07:48:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A49C1EB197;
	Tue, 18 Feb 2025 07:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="URNhDnKB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3BA51EB19E
	for <linux-fsdevel@vger.kernel.org>; Tue, 18 Feb 2025 07:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739864906; cv=none; b=L7LXAZ+v+J+KLK3YnHJON7FQmc6nSDxzqLNuSy90zIlM5ZIWtpO3OPNabite4XUE0KW30+pzeWkERVYS3VlBsii4+YaMmcfqBxvLEt3nb0XeD/vWutSmKMmfpsa7g9ZRXSlxMTAZCS6DxvO9CwwQQZXzn71SDsWdFPJ0yeAyIA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739864906; c=relaxed/simple;
	bh=TueStPmrCOTpO0rDX0bArFpCJ7HIXwE59AnssQBXYys=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lwMxiZpwVUU2zSBTzY7d/beNP6QiTqHQ8WhniwRblGBxL8//yMx4G9LxP6EAxP7IVOHYdWIOeBAUAM/0H6+CRlY3cw+aX910y9KqFnflhkzDRlyJ7WT+1M/UBJ04DEFtDre6AbWi/D7j1HBzDKPGv62ObdkGWF+/RB9UDOcCFAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=URNhDnKB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 304FEC4CEE2;
	Tue, 18 Feb 2025 07:48:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739864906;
	bh=TueStPmrCOTpO0rDX0bArFpCJ7HIXwE59AnssQBXYys=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=URNhDnKBJuPaSGYvkB/+HT2VZfOY5Y42dWk1jRSpwmPv0ggABVn0tWohbayPmG13N
	 EOMU0RNl41/88v0V+ekqoQICIUtKEHqwB8CruPCRAR5N1gFNr4RSQtTG4/3tKpjd3V
	 EHLjfloGc/aFjHHtpufaPtwwNkHYoiq/CiDg5oQ54flaai/rnLjwuRR8xWOZip+Gpr
	 41a94P/xmJEYEi9vFQFLCWKJZ8QOfUM+Ne+2rxZx2sfmPp5pAwQgVudR2+2HDCXFB5
	 zbVwbYKEcqWpWwrVPatcgZ7XWpcL+oDTkdmVjhyGkd0Ji5d0lcH2tvPqdec0K1O+xV
	 pcv/7ZbRiLUMA==
From: Christian Brauner <brauner@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [GIT PULL] fuse fixes for 6.14-rc4
Date: Tue, 18 Feb 2025 08:48:11 +0100
Message-ID: <20250218-tiger-laben-ac039cb95dca@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <CAJfpegv=+M4hy=hfBKEgBN8vfWULWT9ApbQzCnPopnMqyjpkzA@mail.gmail.com>
References: <CAJfpegv=+M4hy=hfBKEgBN8vfWULWT9ApbQzCnPopnMqyjpkzA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=856; i=brauner@kernel.org; h=from:subject:message-id; bh=TueStPmrCOTpO0rDX0bArFpCJ7HIXwE59AnssQBXYys=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRvsXaJmuLWLm28NTNaUiirsZBFMKHC7cOkD07/HtaV7 KzO6j3XUcrCIMbFICumyOLQbhIut5ynYrNRpgbMHFYmkCEMXJwCMJEZ9YwMKy+qzLNIOmCxasYW 5n2cDs3ljZwGeTH1farKRptuOWflMDI8PG7500pw9RSxRfsenfHLPrunfNv2h9/nFd53ajsptOQ YIwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Mon, 17 Feb 2025 12:18:09 +0100, Miklos Szeredi wrote:
> Please pull from:
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git
> tags/fuse-fixes-6.14-rc4
> 
> - Fix a v6.13 regression in fuse readahead, triggered by SPLICE_F_MOVE
> on /dev/fuse.
> 
> [...]

Pulled into the vfs.fixes branch of the vfs/vfs.git tree.
Patches in the vfs.fixes branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series or pull request allowing us to
drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.fixes

https://git.kernel.org/vfs/vfs/c/b8d975e7cccf

