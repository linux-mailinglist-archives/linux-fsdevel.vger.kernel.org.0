Return-Path: <linux-fsdevel+bounces-69743-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 24E34C842A2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Nov 2025 10:14:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6D64034DB47
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Nov 2025 09:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15D802FE06F;
	Tue, 25 Nov 2025 09:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q2IB+rn6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 623EF1E285A;
	Tue, 25 Nov 2025 09:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764062033; cv=none; b=OXv6NKmzKSIrkv1yVQi7DuaMjOLlnngGHCebyO919vH52trgRDew2aXU3Zny9LrtCbsP8hYdNWkYLDcFXlhl+ewOt3kLohRTnkeHdXg7NWerNEksQWm2XqsVS7noIAqaNYcMJZFQMp307l4s8eFBK1U3esRA7tL0cFA+IW/s2Ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764062033; c=relaxed/simple;
	bh=O9pp8DSJbuC/nRnBCa4prL0cDC51/LxOHE2sS71sIPk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZtzKRJJHCpqtNC4AQFP5iTdHFFEX8HiUslmqgvthPQvVak0jBuiyaubxz38K2F4gfigUQYQLfeP5kDQiw9yYdwWGQ3puZLRgiDJP+tZ9ShrUCC+nMaNt22bjowXoJxeronqGPHFF+PQqbCXL794Ecev+iiiUS/2m+xx7kecYKJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q2IB+rn6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E01FBC4CEF1;
	Tue, 25 Nov 2025 09:13:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764062032;
	bh=O9pp8DSJbuC/nRnBCa4prL0cDC51/LxOHE2sS71sIPk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q2IB+rn6tkFo7SWtWHbkpFTS/YmwBnGPf5nSjhVgv+PyRDOHVLI5gITvuFlY6Whjb
	 AOzMHwn+H9rj87I+K8YLUCj70FfmUZTb2A5XG722VHgqshpWHEZ3sTVXa5oQiqt1HY
	 fdR1W6NDIk32UePdA0slCXpmiCHGzTmrUqhkJTPaPl/tSIajIYhbhkhaxfuAUhv1sZ
	 DHWZ4l53Ct4XId0S2eISvfQHbPtPLP5NTdb+nuXl2O6TXZi6aNDdUiqIS5lxZqDCUB
	 zTpvpv2nQAbRifzkgmOk49RHREWbuKWBW6PM7mDmzMJ/dhfyCgoCnUMFSPlCGHsiig
	 VSrK9yMNlpQXA==
From: Christian Brauner <brauner@kernel.org>
To: Askar Safin <safinaskar@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	patches@lists.linux.dev,
	kernel-janitors@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] include/linux/fs.h: trivial fix: regualr -> regular
Date: Tue, 25 Nov 2025 10:13:42 +0100
Message-ID: <20251125-besten-molekular-3e435e267b05@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251120195140.571608-1-safinaskar@gmail.com>
References: <20251120195140.571608-1-safinaskar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=858; i=brauner@kernel.org; h=from:subject:message-id; bh=O9pp8DSJbuC/nRnBCa4prL0cDC51/LxOHE2sS71sIPk=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSqFvucP+O33zzXv/XZO6PYX9xPLVJdxT6fKn32WWWfk n7tuwLPjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgImkWjD8z/nlfahdf/Vpi0CV S4HL04XKm2SbimXS/rQZWes96/etZWQ4+3Jxv+AECauSvNlztn21YOyvvzV36rt5PGY/Sjfs+Gf FDgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Thu, 20 Nov 2025 19:51:40 +0000, Askar Safin wrote:
> Trivial fix.
> 
> 

Applied to the vfs-6.19.misc branch of the vfs/vfs.git tree.
Patches in the vfs-6.19.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.19.misc

[1/1] include/linux/fs.h: trivial fix: regualr -> regular
      https://git.kernel.org/vfs/vfs/c/54ca9e913e22

