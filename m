Return-Path: <linux-fsdevel+bounces-69740-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D1CD4C84257
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Nov 2025 10:08:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 68F194E84F4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Nov 2025 09:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 327D22D9EE8;
	Tue, 25 Nov 2025 09:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="teaWOSXI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EFD82D9ECD
	for <linux-fsdevel@vger.kernel.org>; Tue, 25 Nov 2025 09:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764061700; cv=none; b=QZn7eHB2pZQJaB07htfqcOQgBPJa87MpbepqNXD0THOD3Viqv61tEF7h/FzblTqX1bCpTqfD0Ys2bhU1G2RvbgF7WxlNu9qxc/QaEBid6xgVZJimPigiYIei4Vk1jciHV+P137FfKI8ioNm6KG5aSIBoVP95rc8FL0m2chrTKVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764061700; c=relaxed/simple;
	bh=qEForH4UERxlJzWHaD8mCi//CVHZG/Qbyimik7VDcdQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DGqXdKGvZNyQMpaI7hec0RWGbrKFOPDSwm134S2gGmxDkpjvMBAxbw0U/QtZgEQjQX3om3NfK0aeNoSkEKoXqibBuD7sWnjexXgfBTxqtpyO88UaXr1YSnDrNYx5uAcn+qRI2AbHCSuPuqXOjJVkkVR8nIpaWsM5XGa+yzWNpG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=teaWOSXI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9728C4CEF1;
	Tue, 25 Nov 2025 09:08:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764061700;
	bh=qEForH4UERxlJzWHaD8mCi//CVHZG/Qbyimik7VDcdQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=teaWOSXIauFjWLTKsqZKUb2s9GbEFIa8UoEcVwExOPQNC9X3nx2GdqN3ikqJ9drKp
	 yE+PCpllMBsZKAfD2Wq2EaS4D+ebT1ZtZ4QCDQrMU7/lcjyMb5RLZDaQE7ZQdUQCQ3
	 S4tWNusR9tlIT3oBdIKmM3W4Nxukv63Zdd6Gb7hD06PtUmx6/IDx+1bMnFY4rjpl56
	 yocPYVCjvjH0lEebM+e2D/euIwaSJTz0YoOPQ0gYTdXAIUKJqjE3+xFFX3DlbVQOD8
	 W55WrjEEkcyzmXa/XMqCdDYCPy5pf6iGivMCtGrJvgQsDOPv7sn0exOdpaJKF3+2Ke
	 6bAcuC28XHKew==
From: Christian Brauner <brauner@kernel.org>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2] fs: Add uoff_t
Date: Tue, 25 Nov 2025 10:08:15 +0100
Message-ID: <20251125-boote-auslosung-3e9b140b2c07@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251123220518.1447261-1-willy@infradead.org>
References: <20251123220518.1447261-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1356; i=brauner@kernel.org; h=from:subject:message-id; bh=qEForH4UERxlJzWHaD8mCi//CVHZG/Qbyimik7VDcdQ=; b=kA0DAAoWkcYbwGV43KIByyZiAGklcgCjG8EMFjS7fTXlPE7u3JqUf94+lYXm2IOQGVOKUlFXq oh1BAAWCgAdFiEEQIc0Vx6nDHizMmkokcYbwGV43KIFAmklcgAACgkQkcYbwGV43KK5ZgD9Eb1x g2oi0fD9QswVPf1en3IhDkHVKfTQ0KoLrSVQo4wA/0h0D90Sy6Ae9wlAnxCQPQLn9Na0gGTdNW2 AhFUyE6oI
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Sun, 23 Nov 2025 22:05:15 +0000, Matthew Wilcox (Oracle) wrote:
> In a recent commit, I inadvertently changed a comparison from being an
> unsigned comparison (on 64-bit systems) to being a signed comparison
> (which it had always been on 32-bit systems).  This led to a sporadic
> fstests failure.
> 
> To make sure this comparison is always unsigned, introduce a new type,
> uoff_t which is the unsigned version of loff_t.  Generally file sizes
> are restricted to being a signed integer, but in these two places it is
> convenient to pass -1 to indicate "up to the end of the file".
> 
> [...]

Applied to the vfs-6.19.folio branch of the vfs/vfs.git tree.
Patches in the vfs-6.19.folio branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.19.folio

[1/1] fs: Add uoff_t
      https://git.kernel.org/vfs/vfs/c/37d369fa97cc

