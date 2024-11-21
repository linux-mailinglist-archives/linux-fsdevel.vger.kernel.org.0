Return-Path: <linux-fsdevel+bounces-35402-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 360E89D4A33
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2024 10:47:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D48341F22516
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2024 09:47:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D1BF1AAE37;
	Thu, 21 Nov 2024 09:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FYMNF25s"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0512623099D;
	Thu, 21 Nov 2024 09:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732182456; cv=none; b=en+OJLw7qU7nhvhMblSBrBqPL7oXmwTId8YLa91dxPReQyyDsl6gsISVMxhKKNky3LK61bItUuLUCDwC8YkCCpslaExcQHIf4LembraokIDv3WjatJLPVGmHl/4juBSBcVR9yUD4FBYXxPXqgfT92q+jIK1ez0dB29IDktNJyfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732182456; c=relaxed/simple;
	bh=PbLurLVA/+bf9CYkiO8ePmZYryCDHBh3Dv96wVaozQk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sMwc+C54Sx1y0q93sODJWbZSvKxtZFFnZLmKRNG1Y5wZWbTxBGKEBVg5E+FfnGXe5MH5bwK7B6atgloItl5w8RRmrfsZ6MinSB0iWsB88iz5yrYNC3ShqjECvQ0scb+T6fVBQh1CrLmyqLM9zqy0AXVb+WIQQ6dcBGL7KQF4OyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FYMNF25s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 070D8C4CECE;
	Thu, 21 Nov 2024 09:47:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732182455;
	bh=PbLurLVA/+bf9CYkiO8ePmZYryCDHBh3Dv96wVaozQk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FYMNF25sMECw9192l5xrhE5w/aLu6TgiUIVJxe2QIFuSejiZ73Gcy/fLov55cVBS+
	 YSEb44dSsHlTzQDSmy12P4btUKNkSSFB4XSwQ4iQKf0t8Js7mOdczmIfSDpyc2j1vr
	 nN3uIcUxY7hqolHXaXLcvdJEhydIb7c4mFzF7Rvg+qCrcC4il+oWVI+d5Gi2gM+M4G
	 E8RrmaGBCmafSLKvWuwHmZd2oYGxNuR79HPz22orWQI6j7oJRU0JJWZW8Ed35V6cm4
	 nVIDnozmPQdlLM4inraRcf07AE2S37tVPn68HINPKji0z0HsAPKsde1Y/pbpdI2mDZ
	 42SVs8X8RsT5w==
From: Christian Brauner <brauner@kernel.org>
To: linux-fsdevel@vger.kernel.org,
	Randy Dunlap <rdunlap@infradead.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v2] fiemap: use kernel-doc includes in fiemap docbook
Date: Thu, 21 Nov 2024 10:47:25 +0100
Message-ID: <20241121-abblitzen-einfordern-2f3ec7a87d41@brauner>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241121011352.201907-1-rdunlap@infradead.org>
References: <20241121011352.201907-1-rdunlap@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1226; i=brauner@kernel.org; h=from:subject:message-id; bh=PbLurLVA/+bf9CYkiO8ePmZYryCDHBh3Dv96wVaozQk=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTbM66/G/J44/adlp/DpoqFF0RpnlheF/5jkoln1MPul wpO/xb7dpSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAExkxlOGn4ysJrrXnljufm1p c5Rb+nt89vlPDMsqFNpmsVYeqNntVsnwT6+k+MTT6msqajJP+CqFOmUYzF35T7xaOIk5mn/lhPz FnAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Wed, 20 Nov 2024 17:13:52 -0800, Randy Dunlap wrote:
> Add some kernel-doc notation to structs in fiemap header files
> then pull that into Documentation/filesystems/fiemap.rst
> instead of duplicating the header file structs in fiemap.rst.
> This helps to future-proof fiemap.rst against struct changes.
> 
> Add missing flags documentation from header files into fiemap.rst
> for FIEMAP_FLAG_CACHE and FIEMAP_EXTENT_SHARED.
> 
> [...]

Applied to the vfs-6.14.misc branch of the vfs/vfs.git tree.
Patches in the vfs-6.14.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.14.misc

[1/1] fiemap: use kernel-doc includes in fiemap docbook
      https://git.kernel.org/vfs/vfs/c/07537da4e219

