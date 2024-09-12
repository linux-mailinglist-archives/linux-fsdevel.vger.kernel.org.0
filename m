Return-Path: <linux-fsdevel+bounces-29161-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94E479768B9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Sep 2024 14:09:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 573DC281544
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Sep 2024 12:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 047A11A3AA4;
	Thu, 12 Sep 2024 12:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VlKqICTF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A3A7288BD;
	Thu, 12 Sep 2024 12:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726142875; cv=none; b=QYYYXIJYLpWKwZN2HCnCbXDb0OmTsCnbZtRZRX8meJDIZEnZwlpfvi/w6sK6HOoOBl1tf35BBkkacdLqpAW8cxQo8FRxIhHj5HH+53Z49Q9LPBnfkUC7I36h99uEO5HIuc1YdfL4+GWEmodbqesvNe4c87gEytTcgRicfEEOeCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726142875; c=relaxed/simple;
	bh=FE9qaI2RQDZHJGK18TN5kDROuWwy4+7YXkorV4s++0A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f0gYcfc9EHwzIPguk287m5SQF5LDzeAu6WQa/1mxAq2yriBF7LDQWgZY/202iy6/xMPdtGcYIXE8aB4lzLEzBCD19Nz1vLMUdeVsl6HRQIab3lmKLMet2iIkbKkZhr+Bzs79+MlPj6NHAJstDvJgidk/PdhYUNKY2VR/LVz65mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VlKqICTF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 832A5C4CEC3;
	Thu, 12 Sep 2024 12:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726142874;
	bh=FE9qaI2RQDZHJGK18TN5kDROuWwy4+7YXkorV4s++0A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VlKqICTFJVdzjOmQWZGWUJ85jBV1/9iUlYtK9/cJLStrRFfGgGPZAmps35yCNKSPS
	 EiM+Jw+glEIv3foCRYmrG2LETJUkAuQ10MTb/PSeALYd4eZ+TZyt02zRf48Vgb68Q7
	 PZmq2GRFMRfYcImxwlLo3b3vw82hJjDEG5xbmk6cXtZYhLowPs90Rygua+Cn9Z0evO
	 evPLUliJopHD5fZklDrEctvBnPAd6TvqDcNeTFUsGwfW4dDiZ7VW+VL2tRe633IROV
	 GybOp+zqurd5/eO7bdRRQ1OV2ME+SxBlBXj7xro8KWEk/+ndA/buxKuLY+RgDRGsPY
	 OOB3m3WN/Ii5w==
From: Christian Brauner <brauner@kernel.org>
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	Pankaj Raghav <p.raghav@samsung.com>,
	Jonathan Corbet <corbet@lwn.net>,
	"Darrick J . Wong" <djwong@kernel.org>
Subject: Re: [PATCH] Documentation: iomap: fix a typo
Date: Thu, 12 Sep 2024 14:07:39 +0200
Message-ID: <20240912-frist-backfisch-a5badbdd5752@brauner>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240820161329.1293718-1-kernel@pankajraghav.com>
References: <20240820161329.1293718-1-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=860; i=brauner@kernel.org; h=from:subject:message-id; bh=FE9qaI2RQDZHJGK18TN5kDROuWwy4+7YXkorV4s++0A=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQ9ujnZrMmo68WXFYams8ViTy0+uMhgys+6UMVtCyR0n lydF36zqaOUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAixucYGY6sq5ns5qtkdHCh nfRbqYQTDS8MmlMeXEu/+yTqXt4S/lcM/xOEuJjidDVZGx+o7GX93Su277bHgZz/70uk/V3b537 7zgwA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Tue, 20 Aug 2024 18:13:29 +0200, Pankaj Raghav (Samsung) wrote:
> Change voidw -> void.
> 
> 

Applied to the vfs.blocksize branch of the vfs/vfs.git tree.
Patches in the vfs.blocksize branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.blocksize

[1/1] Documentation: iomap: fix a typo
      https://git.kernel.org/vfs/vfs/c/71fdfcdd0dc8

