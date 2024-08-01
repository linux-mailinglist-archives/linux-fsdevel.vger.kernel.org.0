Return-Path: <linux-fsdevel+bounces-24792-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19C84944D5B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2024 15:43:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA37D284C8E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2024 13:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 518C31A3BB9;
	Thu,  1 Aug 2024 13:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SuIV0fzL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B157F61FF2;
	Thu,  1 Aug 2024 13:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722519783; cv=none; b=jQdY5JCoLoSvjA7NTaXb3EvcuY+e1nSAgeoeMBpSabP6JdQjf67Cq9FHNYk8rJDEnqhvUtBCfvxuPkHh9HMxB1ymsFWWK0WQtyMKFhUu3L/cr+x1AdchW478etMvQ7xd2qOESE8lU2J3ctkMSgOp/0iBGbni026nSSE1ehSSJTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722519783; c=relaxed/simple;
	bh=0BEluha7ZRHJFlfSVvNdZ811dnk97HBDCx8iQM824GY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SI96x2rPhC3HxLGYbZHtT2aAz+DnV7rve5b1KX6dHFXPOt5qQe8IcjyHwM0+hzQfdLZorx7QeARfk7z9qTdc35ItIhmw/ZB06QRb8KRMY/7c3MSj4M3nq3IrbpE+nseXzZod6obLzF+/6hQJc9CElewarho/piMbsv+M2CmYp6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SuIV0fzL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA698C32786;
	Thu,  1 Aug 2024 13:43:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722519783;
	bh=0BEluha7ZRHJFlfSVvNdZ811dnk97HBDCx8iQM824GY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SuIV0fzLn4viuCqdn4I1+/PkRsZKH8HEn2RdrXFMPPlaDoaeOdupH8/BR2nvk0fuo
	 QdzRE0AKlJFpgqGuuSfBdKj8aD4KXrQ5Jb69Kb8o39cmiItUWjIcZgKFAygLTm7laH
	 f7uxoAM0W6yn2DnFWBgzfqbcg7w6QhjlUWWU+v4VoLjvQrFvH8xgeboUE6/k15xf8S
	 6h42SGrGDiDMeiG4rDtMvtZgYEz5skguMd7CxBWv+RSdaxgsPi37wo9gfF1jCovuSN
	 qqVEWeCly05KGzKTRVh7xDpxVomSUq/9Ydo5Vyks/A8dp5xayio8h1m57qgo1lOT4q
	 ioN1efJ16MvXg==
From: Christian Brauner <brauner@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,
	sfr@canb.auug.org.au,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: clean up warnings for multigrain timestamp docs
Date: Thu,  1 Aug 2024 15:42:54 +0200
Message-ID: <20240801-schuhe-tragweite-7afecbc5d48a@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801105127.25048-1-jlayton@kernel.org>
References: <20240801105127.25048-1-jlayton@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1284; i=brauner@kernel.org; h=from:subject:message-id; bh=0BEluha7ZRHJFlfSVvNdZ811dnk97HBDCx8iQM824GY=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaStnvDwwM/fyqaZFu9fdr7YH1z6MDy4a+a6X/FvGk3bL ZbvWFB4vqOUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAi0+YwMnTETY+8Z3zAMVHP 6kzOdUWmA5K/rPerPnhe28Seuf7CYWWGvyISCj851bI1pzgmHP3xJf6jQZiLygFxEzFXp7dN29o f8gMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Thu, 01 Aug 2024 06:51:27 -0400, Jeff Layton wrote:
> Stephen Rothwell reported seeing a couple of warnings when building
> htmldocs:
> 
> /home/jlayton/git/linux/Documentation/filesystems/multigrain-ts.rst:83: WARNING: duplicate label filesystems/multigrain-ts:multigrain timestamps, other instance in /home/jlayton/git/linux/Documentation/filesystems/multigrain-ts.rst
> /home/jlayton/git/linux/Documentation/filesystems/multigrain-ts.rst: WARNING: document isn't included in any toctree
> 
> 
> [...]

Applied to the mgtime branch of the vfs/vfs.git tree.
Patches in the mgtime branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: mgtime

[1/1] Documentation: clean up warnings for multigrain timestamp docs
      https://git.kernel.org/vfs/vfs/c/d48cd6da24a9

