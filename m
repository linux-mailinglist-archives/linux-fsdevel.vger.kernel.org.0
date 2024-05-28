Return-Path: <linux-fsdevel+bounces-20329-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E61518D1821
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 May 2024 12:09:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0D6A28D74D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 May 2024 10:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 660AD1667D3;
	Tue, 28 May 2024 10:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iDRpmt/5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B978117E8F4;
	Tue, 28 May 2024 10:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716890955; cv=none; b=MFbqecOb34lvqbv3Sp0JozKsCXZmHlUHXhFA6ReCNoFn+JQWEVIMG/YhKhGhlUVLfnTNFh/RvjiVx4kDuW0zRGLGMSADqbybElws4eBspmG5lxVD5TA8DSLbk4ts4RCYT+4+hKBArK+6OqShqbA0kVpkbSEMQxb1GkWL/Gw+06M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716890955; c=relaxed/simple;
	bh=u0H4aL4Zr2+tv0WfZ/TAAEYj4LV89tFQZguReEdgKUQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=et7m0Jv8D8axPd+xFdHlkHPRr+h1pyGWzaoVD7It6x2zyQF914idaWbEw786liQ8pBN3OuovSmab4PbOliPyl2Iff4xAhaU9NcVsADntdL3DuLjAQdSgfpwh4oQcHIBXhV3mFiue9i7abKOf95T2GM1jqBvbvivUDJmOVIMbkSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iDRpmt/5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80B3DC3277B;
	Tue, 28 May 2024 10:09:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716890955;
	bh=u0H4aL4Zr2+tv0WfZ/TAAEYj4LV89tFQZguReEdgKUQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iDRpmt/5lxhvelyALqnhGPuhOwpTfS48hFraVk2K58w5jNmpB+NMnMMLQ1Q5pQCZ/
	 C7OcVV7qBaYo8J3Yb43Mx03LfsYQUCEvJyAPuNBOp+eUPTHrR1uUYR/EcsGqb6WA/m
	 Hw8Wlk8FL5Iki1xocRntw7E+WoV/xng/qLco3qCDgLfd/96tyIDvqYnKbmEbuNtjsV
	 dVwzVUb/idB714hSNlwgRf59s10eJVNCYWckIyqdC6ENpLx0OJNhciAxtTsZboUC2H
	 xcQbjK4uUWgncJv7o340sZ/53r7RhKYSgsoIgCF8UTbKDBjkzHZpve6LvTllkwvZba
	 cZB1EAk5b0d2w==
From: Christian Brauner <brauner@kernel.org>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	autofs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Ian Kent <raven@themaw.net>,
	Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH] fs: autofs: add MODULE_DESCRIPTION()
Date: Tue, 28 May 2024 12:09:04 +0200
Message-ID: <20240528-umwegen-specht-0d7e82bb5ed3@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240527-md-fs-autofs-v1-1-e06db1951bd1@quicinc.com>
References: <20240527-md-fs-autofs-v1-1-e06db1951bd1@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=891; i=brauner@kernel.org; h=from:subject:message-id; bh=u0H4aL4Zr2+tv0WfZ/TAAEYj4LV89tFQZguReEdgKUQ=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSFrnVu/e/wYrv71jpW4zJBrhbXE51/9ef9TupbZ1q9J 1B7y9eMjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIlkZTIyXFzjJey/5ahZz+UX +ewL7r5q+ft2pSW3w4/c6TuqzCUmCDP8j60wYH7OKGy17t1WuSwPmVNPFaa/qJExKC+KeJH5itW KCQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Mon, 27 May 2024 12:22:16 -0700, Jeff Johnson wrote:
> Fix the 'make W=1' warning:
> WARNING: modpost: missing MODULE_DESCRIPTION() in fs/autofs/autofs4.o
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

[1/1] fs: autofs: add MODULE_DESCRIPTION()
      (no commit info)

