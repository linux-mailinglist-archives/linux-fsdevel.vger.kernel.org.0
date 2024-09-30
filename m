Return-Path: <linux-fsdevel+bounces-30346-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 20A4698A1F7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Sep 2024 14:19:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBC8C1F22254
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Sep 2024 12:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99ECF1922E6;
	Mon, 30 Sep 2024 12:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DtW7/GyH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC9F18E75F;
	Mon, 30 Sep 2024 12:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727698289; cv=none; b=cATqNJYXEfFQlqnVBQgov4x6GAcXzH1W60KEjVpQiei6vZIYJPlXvJZkFpzqEKtKsOKAvEKBVPaT++kOASzHhpmnxHXahF4eR63AQbSekJMQac8HjiI6EsWmkZhzzOra7lNJaWSyc/90Jxr4EtV0JGa4HwpLWG/0I4N+pWadyZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727698289; c=relaxed/simple;
	bh=9tWYCp4vpeMn12EPX2msoogZdQh1CDg3ECXvFAwQFrI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NOSh5C7FALJBMvvpAplGktuPNAvdLb+I1PY4uhtADjfFxr8quaIQ8es3Y1pEIRwqeuXZzP6KFj61cz6AqnWeI6EonRvnbBgAQEeZhephJAcVOLftNFTjVP/igaEMGwi+GD82I+n0yAt4kCNnM2ZBaC2/Prm7iHpSFjp2s2R7AVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DtW7/GyH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FD78C4CEC7;
	Mon, 30 Sep 2024 12:11:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727698288;
	bh=9tWYCp4vpeMn12EPX2msoogZdQh1CDg3ECXvFAwQFrI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DtW7/GyH4g10ziUg9s5F+jREy77B0GIPKsSrEPcpFH/JvNCzMKcqs/ItrlREKtPOa
	 9EC2ctjfh70STkNZ+tsJnmRGjatdPOuPWCDdWE4IGrVvIl2AKu/Ro0G1C+HnK5W36H
	 QUj5ZwxlzYekodauDrU1eZb+/58mU7nZu/LBi0U0Qv/7b36tqPXYBpdysyO7UGYTt7
	 W89lQv3L+DWhbvWMPJTSpNOQbglEptxhyshUWWtWCihXybRSsiVP/ipqkvd9XYLgCN
	 U1vNvcV6GZ9Xyz73AUnbFuq8zTZKh6XLr72tZ76vtYF0/LXi3ooi1x1C/r9zbt9ZPA
	 WcKdMeHzLvFBg==
From: Christian Brauner <brauner@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	netfs@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] netfs: Add folio_queue API documentation
Date: Mon, 30 Sep 2024 14:11:17 +0200
Message-ID: <20240930-baubranche-unbewusst-8646dc251e66@brauner>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <2912369.1727691281@warthog.procyon.org.uk>
References: <2912369.1727691281@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=867; i=brauner@kernel.org; h=from:subject:message-id; bh=9tWYCp4vpeMn12EPX2msoogZdQh1CDg3ECXvFAwQFrI=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaT9mpq5rcmS6R738hc6YjnHHuYeOG3aydDfI1zH7v1Ef PU1oW6ZjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIks12VkOLfhfUIsh7aUqpXB XSOlVuPS0Ozrr86lWDfPkXzdddRal+F/jnGGeca7dab+op9eRe78Jtlp9S1+X9/OSzpCr2TLdj7 iBQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Mon, 30 Sep 2024 11:14:41 +0100, David Howells wrote:
> 
> Add API documentation for folio_queue.
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

[1/1] netfs: Add folio_queue API documentation
      https://git.kernel.org/vfs/vfs/c/28e8c5c095ec

