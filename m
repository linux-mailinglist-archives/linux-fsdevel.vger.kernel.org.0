Return-Path: <linux-fsdevel+bounces-45190-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68CBEA74621
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Mar 2025 10:14:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE80D189C53C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Mar 2025 09:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C844213E89;
	Fri, 28 Mar 2025 09:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cSLN8PR5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D96E4213E69;
	Fri, 28 Mar 2025 09:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743153276; cv=none; b=g6Z83Aevr9ot83fUBwr5RfFh5f87BK5ZmbdhLeGRsBtvATqzOTT2vT/IWUo97eLlCy4qQLLYW/O2HRLNyhnQ0yz34tcMsSzGtQWauPvsRmQBHaI+dXMLlzbiGY1TlBTuLwdQRuPmAPT2n2tt3zstAtYAHdSZQnbV1jZ41wtgSfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743153276; c=relaxed/simple;
	bh=6E+1krQUsQz13SOR02sZAPmH4sQWRbkNr1y+0pGHuaE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YceZcXqI5U67CUy8pILR8IKmOBU7rZx8kXxacZY75elqWd7AxnozSgFYbNlg4i4O9gyp82OhPO0Mc/j80wWPG2jOuTtRufrnRmkrrznQshMdiovUkPKIh2aVYL96GxC+UHUOkqyPEILfrlfAXp29BhiuuL7gPp/UImRgPBMyKOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cSLN8PR5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00417C4CEE4;
	Fri, 28 Mar 2025 09:14:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743153275;
	bh=6E+1krQUsQz13SOR02sZAPmH4sQWRbkNr1y+0pGHuaE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cSLN8PR5bFNCp8B1Z9DCNOzvXzpCgPQi6mfkQGoyZUwIbQnmyexu71M2YPeWISJIu
	 OQ8lVdRl6hNiOh0VsNm1Cu0RrOPNF3ohd5qwcp2qJYsTNBJ4M4C0BVg91WRz5pwnMx
	 4h0grN+N5yJviFatPNHmkbSimzjpKM+pbcZa2zno8wPaU2VNTbHrJEwNrvmqCR5Bme
	 ycymwL8SmBgoCK7ApfTXe6nRx90Vwt+TCYK5RX3P0AOIWA0hJyjfcHHsGN//UG2Ayb
	 e3kMi1WsjHDUGsab8d82qo9dRR7nxoaJViFp5I8Vu6fjY97//GX9A6hvzKod8f0eDD
	 9DKBqQRXri9CQ==
From: Christian Brauner <brauner@kernel.org>
To: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andreas Hindborg <a.hindborg@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Breno Leitao <leitao@debian.org>
Subject: Re: [PATCH] MAINTAINERS: configfs: add Andreas Hindborg as maintainer
Date: Fri, 28 Mar 2025 10:14:28 +0100
Message-ID: <20250328-testlauf-kordel-6ebfaca4ba0d@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250326-configfs-maintainer-v1-1-b175189fa27b@kernel.org>
References: <20250326-configfs-maintainer-v1-1-b175189fa27b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1035; i=brauner@kernel.org; h=from:subject:message-id; bh=6E+1krQUsQz13SOR02sZAPmH4sQWRbkNr1y+0pGHuaE=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQ/yyjbyy91XSlLQuqxta/47BQ/ibqU/Is+qesXsgj/m m7V6XG4o5SFQYyLQVZMkcWh3SRcbjlPxWajTA2YOaxMIEMYuDgFYCKKtxgZ/s/luGiT8IFfmVd5 YrzP5E+RsoeWuTxlShfK0bldYlS8j+F/NJu954m6faEVnx+HvU75fHxF0lSP/s/7hI/JKLhnhp9 gBwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Wed, 26 Mar 2025 17:45:30 +0100, Andreas Hindborg wrote:
> Remove Joel Becker as maintainer of configfs and add Andreas Hindborg as
> maintainer and Breno Leitao as reviewer. Also update the tree URL.
> 
> Add an entry for Joel Becker to CREDITS.
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

[1/1] MAINTAINERS: configfs: add Andreas Hindborg as maintainer
      https://git.kernel.org/vfs/vfs/c/8de544883456

