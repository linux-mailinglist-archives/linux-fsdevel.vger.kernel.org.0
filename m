Return-Path: <linux-fsdevel+bounces-20346-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7687E8D19E3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 May 2024 13:41:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B8961F23584
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 May 2024 11:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7370016C879;
	Tue, 28 May 2024 11:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UZr8Fovm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA11D16ABEA;
	Tue, 28 May 2024 11:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716896461; cv=none; b=r4LhWewKvKzb0qu4YZ4NvvesGZEmBIAwJmku9PyaFWxS9O3DPZMXA3cMDsP0GZAu5fmze6cs7V0A04t7ksiWYbVPGHDfHgj0oXhAslz5nAqOaALf+H+6uMDyxWlEtkFkp2SVkV0Tv+5eTv+pojJ9N+wt5KToeiWyoqaXdPkC5yI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716896461; c=relaxed/simple;
	bh=nTnqqSYa4I/AgFNmPv6khCzjQUGlr5Fq9ioqus63Z5A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QAPvD2KNsaYY8bx3duTSiTEijzQpHJ89m1OuU5x5JIPTGVGTXacvujighx65rIFJk9XXaAuOefO76VGbikyt3Y0aI/+beSkXHrtyIrko0ZxlnS6ci8OZ5PdKZwodq8Yr/1iiseFOyRxnQ+jQQ3w2TmZd/IPbzWq+mSD3EpvrtLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UZr8Fovm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57B10C3277B;
	Tue, 28 May 2024 11:40:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716896461;
	bh=nTnqqSYa4I/AgFNmPv6khCzjQUGlr5Fq9ioqus63Z5A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UZr8FovmS/oz14uLYlsog1dq/IVopZHHLKcV8JaTHcDNSah+0mVTqL2UyZDJlRi1e
	 w1j0n+1xQTvoR7lxMWzcddVY2NQ5wjwYlrSX9uMB4rZlhoc90fn/RRvQF28YJgMi63
	 014eO+1e6j5uln2HzSl6xCoHiDX5iqQ4Y9Iq2/B5YLMcDBPuSzaQzAkwUFQ8sNzfb1
	 dE0R7PLssMexeZdyLPaB8trqnD6ztT9TAqi7+vk86IhAx+Pzl/CjKjRxv9JI7vK1pt
	 eG3DmbhOQnkGatkw7Piou1TsK+UmxNAGNNBNJJOBb1azXlOIH/i7ZpZvcav1gNUhKb
	 /t/Q+ayaNRtsw==
From: Christian Brauner <brauner@kernel.org>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Nicolas Pitre <nico@fluxnic.net>,
	Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH] fs: cramfs: add MODULE_DESCRIPTION()
Date: Tue, 28 May 2024 13:40:42 +0200
Message-ID: <20240528-genutzt-wohnprojekt-74654ae5d3ab@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240527-md-fs-cramfs-v1-1-fa697441c8c5@quicinc.com>
References: <20240527-md-fs-cramfs-v1-1-fa697441c8c5@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=919; i=brauner@kernel.org; h=from:subject:message-id; bh=nTnqqSYa4I/AgFNmPv6khCzjQUGlr5Fq9ioqus63Z5A=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSFHjqyeNb3mNpvoturfPjXMExPePn4IfvJ/3Jfja5f/ ly8xvfk4o5SFgYxLgZZMUUWh3aTcLnlPBWbjTI1YOawMoEMYeDiFICJKG1m+O+su+Zewe89k9bv v3v1ZmulZd+hY/JsxvX6pborVdo3iexlZGjt2Z6akG78oLDmMmuiZ7Pe/kJhvk3snrsLuzp6XKf e5QIA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Mon, 27 May 2024 10:55:02 -0700, Jeff Johnson wrote:
> Fix the 'make W=1' warning:
> WARNING: modpost: missing MODULE_DESCRIPTION() in fs/cramfs/cramfs.o
> 
> 

Applied to the v6.10-rc1 branch of the vfs/vfs.git tree.
Patches in the v6.10-rc1 branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: v6.10-rc1

[1/1] fs: cramfs: add MODULE_DESCRIPTION()
      https://git.kernel.org/vfs/vfs/c/9149a57dd525

