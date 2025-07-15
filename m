Return-Path: <linux-fsdevel+bounces-54932-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF309B0570F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 11:50:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 254723A81A4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 09:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE1782D5430;
	Tue, 15 Jul 2025 09:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cOIHeYSy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E95238C1B;
	Tue, 15 Jul 2025 09:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752573045; cv=none; b=l/ZIC7FAuFqktGz0KMn8ArGJo9E8LLhrW0CZfopREIk4LAC3SEYoh3bGyZINCFCVcB0lNPZ+ehGngSFKyGt/h1gKk+8nUuRSanepPuxldNeMImKzpFvkXrtShhYft0ovPA6TruTTfk2wLriGDrhYhsK2PFvS4ecnrZ2jjtL/42Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752573045; c=relaxed/simple;
	bh=Vph+aYJ8m3c+lzxk8yL1dAsjmJBx3do8nhacfLd1qvk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fuYjKocCGMZ3zRS+fnaL+3kiAA/v+4KWT73rbIxLOGKgzNlDe8hNxaSY95F2ebUTjAexMBFmrTZuOh3FnT+3RprpteU1MpjsUMDJZ0hDxqgZFmhLMeKRaHe5Xks7Y2APNsT1YoLl2YPZ07Ku4xrjfSTdcilIiyqGCSb9+ifIrDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cOIHeYSy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA72AC4CEE3;
	Tue, 15 Jul 2025 09:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752573045;
	bh=Vph+aYJ8m3c+lzxk8yL1dAsjmJBx3do8nhacfLd1qvk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cOIHeYSypAJJXZ2pV1VyLE9Ob/Dbp08cY/+6apN6PdU3lBqCYtHGg8Q8PMmGVsfM2
	 zlRJ59mVlGy1rczBbwF/Q7M68wHM/7bLtVOd7Q6gr8RMCoHeeZr4nGTBAFespOreBS
	 nZbSnJ+MkdPLsgl7HfagQ9XoVPKfbPZWejE3Z9uRzIqZvjcElQ50Q1yrgAeWZM0oKQ
	 CU+fecEN/ct1Itnuf752nPXcTxzZQUS0lrh26tY/lXPSK3Pd2XFYBiJ4vMiTc3qflp
	 airv19hwPS1prYf/7Vp0GEobWTunIHBrRX+CDpaQY5VcNEM4kUjIhDyUW9Elb45x/m
	 bNUe+9mVERmwQ==
From: Christian Brauner <brauner@kernel.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2] vfs: add Rust files to MAINTAINERS
Date: Tue, 15 Jul 2025 11:50:32 +0200
Message-ID: <20250715-glotz-ungefiltert-70f4214f1dbd@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250715075140.3174832-1-aliceryhl@google.com>
References: <20250715075140.3174832-1-aliceryhl@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=990; i=brauner@kernel.org; h=from:subject:message-id; bh=Vph+aYJ8m3c+lzxk8yL1dAsjmJBx3do8nhacfLd1qvk=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSUqeSd9bg3yUB3VvL/L4FN394tkwqIK+f7/kHkkviH7 Fzez/P3dpSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEyEs56R4Z4R3zzWDaJM8TtC GKY8mCnUv2zuuUfHQx3ffIwQL+owOsLI0FQkFTbx6NsJzRx/1oU+N6hltTPi+8Wfq9v2UH7Nupp wVgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Tue, 15 Jul 2025 07:51:40 +0000, Alice Ryhl wrote:
> These files are maintained by the VFS subsystem, thus add them to the
> relevant MAINTAINERS entry to ensure that the maintainers are ccd on
> relevant changes.
> 
> 

Applied to the vfs-6.17.rust branch of the vfs/vfs.git tree.
Patches in the vfs-6.17.rust branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.17.rust

[1/1] vfs: add Rust files to MAINTAINERS
      https://git.kernel.org/vfs/vfs/c/3ccc82e31d6a

