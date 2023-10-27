Return-Path: <linux-fsdevel+bounces-1364-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 272F37D9965
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Oct 2023 15:11:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6B99282433
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Oct 2023 13:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D1A51EB23;
	Fri, 27 Oct 2023 13:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i82+QkK8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD6151A738
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Oct 2023 13:10:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D5A0C433C7;
	Fri, 27 Oct 2023 13:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698412242;
	bh=w4HGkMbwZCb4ZQjzQcaiLO3ocgQJnSP7dKmZHyO/B5k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i82+QkK8NosM9604F4Sq2OUQ9CUoGpuJfPxcZZzHI8ITXw9oYeQ0rmX9kYNBBjyi9
	 fQzFo2nPaEO748KVdpIL/UKdMWYGwUGHowOMUIIIPDMHH4f0FhHCpC26ttkZvvLBaA
	 YqVX6/r8fSv+vVAup667NCgIsraGNhRo5Lkag8rfRp5TGa0xEhehF8sSO0hkDr+Epo
	 XZLA+JtVjE9viidEO2iNkb2T+O2Xuy9NLZvoSeyAcc7kpkK1wjfKhh3j9/hO5PGba6
	 25LVckj0PIV8bSULUDniVuKJuQUH7HvvZUPglLHdWutg6C/Go1MT33Uz2eO77DHlzl
	 lvqA+nBg+WCgw==
From: Christian Brauner <brauner@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	linux-fsdevel@vger.kernel.org,
	linux-nfs@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: create an entry for exportfs
Date: Fri, 27 Oct 2023 15:10:37 +0200
Message-Id: <20231027-infoabend-glanz-7617798f5fc5@brauner>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231026205553.143556-1-amir73il@gmail.com>
References: <20231026205553.143556-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1085; i=brauner@kernel.org; h=from:subject:message-id; bh=w4HGkMbwZCb4ZQjzQcaiLO3ocgQJnSP7dKmZHyO/B5k=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRabzu5/CyXd08O5289LsmfWQvkrR+yFSe+8/6cey4nfe/n Ei6bjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIk842NkaCubL86zXdLLaUHvIeljyk l3BBNeubq/NXz+o5L1j92kAwx/pSSzgrpYqov3l3bVHFrQYdXkdZCb9dfhmq38AjKX/kmxAwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Thu, 26 Oct 2023 23:55:53 +0300, Amir Goldstein wrote:
> Split the exportfs entry from the nfsd entry and add myself as reviewer.
> 
> 

Looks useful to clarify this. I've create vfs-6.7.* tags yesterday I
plan on sending this one either at the end of next week or in week 2
together with other possible fixes.

---

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

[1/1] MAINTAINERS: create an entry for exportfs
      https://git.kernel.org/vfs/vfs/c/7723a9a55be9

