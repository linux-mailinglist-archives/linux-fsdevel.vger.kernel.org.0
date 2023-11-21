Return-Path: <linux-fsdevel+bounces-3300-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F62A7F2B67
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Nov 2023 12:04:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64E9A2828DE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Nov 2023 11:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC13A482E7;
	Tue, 21 Nov 2023 11:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j/Nsn+Ct"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2474646521
	for <linux-fsdevel@vger.kernel.org>; Tue, 21 Nov 2023 11:04:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBDDBC433C8;
	Tue, 21 Nov 2023 11:04:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700564679;
	bh=bLdmfmrKP85z5/TW930Brfffu/EjvTxnd+6nqcuEU94=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=j/Nsn+CtDShjd99CVXWNW/pStbQJMlrNNLStgoyREl+DouRWwRYehZfBHvikF0s8f
	 tXlX+lTJLAIn+3FocW7rCDSyXY7wNzsl0A9Gys/ePcbTFapKo8/5z+/SY7iJ1hKMJP
	 pCyT8Nu37/MuqC5lh7XSmeid6dTlV9FKX8T2WUaxYKIjbxHllHTe4rPfhdPfJk8764
	 ZAMk2fzCtOtCcb6ztk5E2aQ722rE6pwJN0nZcJ1uapubNBle2TtLDyVtT7Go/RCR46
	 8jg7LjN3a2JNavBfUYEu3zltmLV/AADfrXGfBkAfKsm2T1Q61jOcIM7ylq0dvXepjR
	 n5zlTkxb1aFtg==
From: Christian Brauner <brauner@kernel.org>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	"Darrick J. Wong" <djwong@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH] fs: Rename mapping private members
Date: Tue, 21 Nov 2023 12:03:28 +0100
Message-ID: <20231121-langsam-auflockern-de200f434e5c@brauner>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231117215823.2821906-1-willy@infradead.org>
References: <20231117215823.2821906-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1179; i=brauner@kernel.org; h=from:subject:message-id; bh=bLdmfmrKP85z5/TW930Brfffu/EjvTxnd+6nqcuEU94=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTG9DU0Lj45pbA0Zi+nkLVq4oyd+gsm/S/k3/lz97Vss f07fyf96ChlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZjI1weMDAsL3Zev/TX/m6Vv 6N4Ore8Vb0RvpPZ3TVGXfh595r34vlWMDI22iVyW9+7vPJFeWzbvYXXjSoN21psLZYX15X6+ubm ojB8A
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Fri, 17 Nov 2023 21:58:23 +0000, Matthew Wilcox (Oracle) wrote:
> It is hard to find where mapping->private_lock, mapping->private_list and
> mapping->private_data are used, due to private_XXX being a relatively
> common name for variables and structure members in the kernel.  To fit
> with other members of struct address_space, rename them all to have an
> i_ prefix.  Tested with an allmodconfig build.
> 
> 
> [...]

Applied to the vfs.misc branch of the vfs/vfs.git tree.
Patches in the vfs.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.misc

[1/1] fs: Rename mapping private members
      https://git.kernel.org/vfs/vfs/c/488e2eea5100

