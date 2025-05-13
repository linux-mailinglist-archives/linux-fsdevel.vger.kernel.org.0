Return-Path: <linux-fsdevel+bounces-48806-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B714DAB4CB2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 May 2025 09:28:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0728C3B61D2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 May 2025 07:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1AB31F09A3;
	Tue, 13 May 2025 07:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l49k1T3u"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5266374059;
	Tue, 13 May 2025 07:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747121302; cv=none; b=olAvwIcOuWSczMPdW/kf34iQQJr4JzJUHsygagR5wJC6SSEZ51lIV0cIhKBVr2W5j4dBTVnUEq0Z8noaZ6lGjCZ6uEowKMbiHHJf2N9aQlk8ZXt3cQxYFY8rDFSA9gTKfVKcBaG4a2ZUc2zc/TUasRt13iLPAQ0QQ0lFjS6Hexo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747121302; c=relaxed/simple;
	bh=q7vKAMtpDtiGe3w4FV5/B8hFy8LHK/sB/Y2saJPHOdI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hvaTT0KW/DYuB+08Z/bx/iyzZo5bfktg5pAgr1oBNgoHCoXzC9e3P/qcu2rL1NZsxGAhoIrTB6koI6lUt0nba49rMyMHE1MMv3Aambw8cXBdnzNtLiZwLuzfUN8ZFcztAV38/fcbRzFvmTEiaC7bmxvwFRRTGE+RA1xkQTWC/J0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l49k1T3u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F367AC4CEED;
	Tue, 13 May 2025 07:28:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747121301;
	bh=q7vKAMtpDtiGe3w4FV5/B8hFy8LHK/sB/Y2saJPHOdI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=l49k1T3u2A9E2RAxBw+nZHwz0WPWf9l4MT7sd0mt4GtFwyxsv5KqF6YkhSt2K+ol5
	 2Ivt5dF8dbD2kpcV8oa4/Onu9rAA2gLhUtWzTjjDgLlq6H2QTXgXI0taZpM7kNEbC2
	 ItEsiXkBDoyD0BHb7qd3KjE/PW69mT4sK+FZqaVqifRpPT/cZd/UAqH5AoV/VPJUfJ
	 t50QUzyyfV79oxldUa0KG+1/3mD7xVsVgorSm/mkp7lQhMFuOlk+t5w6ACyDpUBq5c
	 G/cFf3LadnNSxyVBcPR+NOLAz0iYBIb2dzWZfo8Db9NAu5NWESbtH7LYkhAUDU9jUD
	 k1WHmHaxKoQXA==
From: Christian Brauner <brauner@kernel.org>
To: linux-kernel@vger.kernel.org,
	=?UTF-8?q?Petr=20Van=C4=9Bk?= <arkamar@atlas.cz>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-doc@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH RESEND] Documentation: fix typo in root= kernel parameter description
Date: Tue, 13 May 2025 09:28:12 +0200
Message-ID: <20250513-textil-kureinrichtung-15d108bb56c8@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250512110827.32530-1-arkamar@atlas.cz>
References: <20250512110827.32530-1-arkamar@atlas.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=943; i=brauner@kernel.org; h=from:subject:message-id; bh=q7vKAMtpDtiGe3w4FV5/B8hFy8LHK/sB/Y2saJPHOdI=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQofZmw+/ScE4e98huavRV4+XM3v/6dWeFRdbdVKMr68 nH2c+yrO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACbim8XwPyHBvHfDfV4TBfmf 52R+xtS/SVFSXJHplWnS8y543Y35jxkZ/v0/lHOHsetbjVOiaiP/juYQBdtdAbO70xP+7RJ/sly IFQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Mon, 12 May 2025 13:08:27 +0200, Petr Vaněk wrote:
> Fixes a typo in the root= parameter description, changing
> "this a a" to "this is a".
> 
> 

Applied to the vfs-6.16.misc branch of the vfs/vfs.git tree.
Patches in the vfs-6.16.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.16.misc

[1/1] Documentation: fix typo in root= kernel parameter description
      https://git.kernel.org/vfs/vfs/c/678927c0c96b

