Return-Path: <linux-fsdevel+bounces-38571-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D377A042FB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jan 2025 15:46:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1E337A169D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jan 2025 14:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84E7B1F2C3F;
	Tue,  7 Jan 2025 14:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vGXOYHJV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE911D958E
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Jan 2025 14:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736261165; cv=none; b=euPJjSeYYyIS2rrrR04XwQSBu1sLk/qPtmO2zYKH18H4xAlPY9IPM9L8lavktYNRh9x9kVCUl5YLYytWLRkqvo/o0NHxBup/sWZasGXj8X+hqAfnvvsVKu7Vbr0V1cX/9Thf3WgxDqCk/bU8qmmnheA28gdcowIdkwFN1pZ+Vh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736261165; c=relaxed/simple;
	bh=EMMIx2b/AQwoZCw3Mxgb80QcQH/nA4Fe27eBqnFyTuk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Sf/U7AzTN718sEYrmA0QX7vlFmUYm4wdbMg2krgxv7dK87C/cMq/0cOFbZTLcYpAQEl7Z2BhDKZNSXDjCImTtB92p8xtNOWoYkOiLf6Bpacg7IzFx2BpJnYT42134r2W4iuMOP/SgDSbrsqO5ttAdwIQxvGC/ejFGGXrd16jYOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vGXOYHJV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B390C4CED6;
	Tue,  7 Jan 2025 14:46:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736261165;
	bh=EMMIx2b/AQwoZCw3Mxgb80QcQH/nA4Fe27eBqnFyTuk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vGXOYHJVyJBmhvdgEYlwhOhCnhtxWbl5HHsl64Nvr7Lj4QznYc4X/RSY1NzULgPCq
	 C6kfQkz5w/6PcvuX4sqTpl29+fO/eeSajZI4FxiEn/YCNuvieD6f9+m7RICB583TLW
	 s1hQTeaKNDNC0iwYZPkTB9PvRUOX7B1jqxVVOUi7bymNS4o06n8K/GzdUCMOfx8/C2
	 +V3iAyBF0WoIM76tdGpD+2IojQcS5zu6EmjWAvnl46MAK36OTUXQolblhMPoV4ZtSo
	 5CJSaOefpsL2Uolot0/kdcg3yqUGAv+nrvr1f0P3i2CNAsK0XfYTVnyP5Llnjb7Wev
	 9JYZr30m6Sjsg==
From: Christian Brauner <brauner@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [GIT PULL] fuse fixes for 6.13-rc7
Date: Tue,  7 Jan 2025 15:45:44 +0100
Message-ID: <20250107-behielt-haselnuss-e0ff6d12d941@brauner>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <CAJfpegu7o_X=SBWk_C47dUVUQ1mJZDEGe1MfD0N3wVJoUBWdmg@mail.gmail.com>
References: <CAJfpegu7o_X=SBWk_C47dUVUQ1mJZDEGe1MfD0N3wVJoUBWdmg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=853; i=brauner@kernel.org; h=from:subject:message-id; bh=EMMIx2b/AQwoZCw3Mxgb80QcQH/nA4Fe27eBqnFyTuk=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTX2qnbXfFJyJ+ROmUNr3bLuduX4yd33P4VFRxycJK/h 4zTTbErHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABPZ7MLIME/nwnwXP71XOdKy i031u4xy9A9+mvky+XWRfFD/3CJDX4bfLJbnz9emyP2PPshf1p5wcF/u3KSXv+fX/qzaLawc49L MCQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Mon, 06 Jan 2025 14:01:36 +0100, Miklos Szeredi wrote:
> Please pull from:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git
> tags/fuse-fixes-6.13-rc7
> 
>  - Two fixes for the folio conversion added in this cycle
> 
> Thanks,
> Miklos
> 
> [...]

Pulled into the vfs.fixes branch of the vfs/vfs.git tree.
Patches in the vfs.fixes branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series or pull request allowing us to
drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.fixes

https://git.kernel.org/vfs/vfs/c/3ff93c593561

