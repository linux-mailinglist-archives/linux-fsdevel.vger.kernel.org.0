Return-Path: <linux-fsdevel+bounces-43247-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BBF3FA4FCE4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Mar 2025 11:55:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D5A27A34F8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Mar 2025 10:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7FB822ACF2;
	Wed,  5 Mar 2025 10:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B9DVaemP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E60622154B;
	Wed,  5 Mar 2025 10:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741172127; cv=none; b=NAaQtCJJls/oCF19Xbn7UjiR5swsxlNQ5qIcHmabz9vU80U+eJMu6buRFTNWcLuvboYh/WmMxa7fFDj82Mz8Z3BS+Aeqyq1rhhDUDPiw7OkD0t4MQGBEahovVvGPg4PHw6RSU0a0j9vOg1D2VlX1pFzCC/FIpluxhZYTS1Estsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741172127; c=relaxed/simple;
	bh=Wlhyf0USg/tu1XOgzH5NxGUkooy3w2wOgrCLVWvycyI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nJA/o5Vlk4WZ0/BDX+IAQtCi7yPSxz+U74J3ptTEF0Sb5Q6K9Td4tUJv/s9VbE4V6Dfy1R8O2vxI5azIjpgyqmovWCYZdDetwxiGGgn2/bTfM2iZxspx93+NUt5SF22WK2ADstQTFSrgkV0wBcNI0+WqgNl9K5EwrFUHi+55W3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B9DVaemP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C56D6C4CEE2;
	Wed,  5 Mar 2025 10:55:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741172126;
	bh=Wlhyf0USg/tu1XOgzH5NxGUkooy3w2wOgrCLVWvycyI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=B9DVaemP3felO8/LqxjBzCuCdtwi88e9jfFVqqu5z5z/LITUlrfnKL3D9R5jvjbOE
	 cpD2IAbgb343QaDENfsx52Wz1Kp5mY/EuD8giZvGuaDtHH6cGVyh784KqZ20GXpiy+
	 TdxX8/+Vdt5T+A9JOjhLofig9gtkGZ4aWpba/3ynIV0YX4n3wMMEe0x8YXuxgdoTDd
	 8zXbN81NOCp5r3iOTtLDGOxYI3ZgwdvXZdn390w4Ze/gzVBIbaSasqEz5+p+2eVe88
	 Mrhgb7v43oWUb3voCogUGRpVqTWxvlrsp6zpyDIXxf5HMS7ZEvuURanuaLvphaQ3q1
	 Hdqq3Bu1hzbOA==
From: Christian Brauner <brauner@kernel.org>
To: Aiden Ma <jiaheng.ma@foxmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	sforshee@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	corbet@lwn.net
Subject: Re: [RESEND] doc: correcting two prefix errors in idmappings.rst
Date: Wed,  5 Mar 2025 11:54:55 +0100
Message-ID: <20250305-wacht-lauwarm-77a350b8a936@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <tencent_4E7B1F143E8051530C21FCADF4E014DCBB06@qq.com>
References: <tencent_4E7B1F143E8051530C21FCADF4E014DCBB06@qq.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1037; i=brauner@kernel.org; h=from:subject:message-id; bh=Wlhyf0USg/tu1XOgzH5NxGUkooy3w2wOgrCLVWvycyI=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSf0J35sGx5Z9ndKsezinx3WLvf1rW2zFp7ZPthL+8v+ hLb2rbLdZSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzEw5qR4XmKsmf2f52fB/QF wxmzT9ndj2lfq8jW42qr21Tcnc8izfA/4p5Pa8U7gW6DxwW9pnIzv9bK3N09JfX0+sKNb8W/q37 lAAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Tue, 04 Mar 2025 19:54:01 +0800, Aiden Ma wrote:
> Add the 'k' prefix to id 21000. And id `u1000` in the third
> idmapping should be mapped to `k31000`, not `u31000`.
> 
> 

It's good to know that there's at least some people that read this document. :)

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

[1/1] doc: correcting two prefix errors in idmappings.rst
      https://git.kernel.org/vfs/vfs/c/50dc696c3a48

