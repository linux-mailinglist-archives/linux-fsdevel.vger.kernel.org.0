Return-Path: <linux-fsdevel+bounces-32179-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C98F89A1E17
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2024 11:19:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AA111F2332E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2024 09:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B35051D6DB6;
	Thu, 17 Oct 2024 09:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z1yaUBxa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22DDA1D7E2F
	for <linux-fsdevel@vger.kernel.org>; Thu, 17 Oct 2024 09:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729156762; cv=none; b=MoStUJal3by8kJWBzNunn+f9gkje1sxjIMLtJgqCRAs39Opfl4GNSc0JpeF/T5SSxM4y3V5Um4T0utCJxcr4H4COSNAuA/dy5ktlGan9bIrsPAt3rTYF3n8A6BI8mhF1eTyJraFToBtXF2Dk5aQWtYMy8ncde846LcCmIejBjV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729156762; c=relaxed/simple;
	bh=/YPKPrRZdMnIhVhVO8vWRnqWIJQeqiDDaPwdyWgT2+E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MFA6FsZgonTTPFAV8sFeb1va4x0K+SDd6ZhT5H5o19iBT7qDs3C6XeP4L62hVsdBT7LrRoWHE/iCsiBIDqXVSeeABMn3QVzozvI45iBRTnoTdNEQjbxBlZuA4pqop784YmxamELtWnh8q1NHpwSZwjTjXViG9TZvVo6CTV7LrC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z1yaUBxa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4AA7C4CEC3;
	Thu, 17 Oct 2024 09:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729156761;
	bh=/YPKPrRZdMnIhVhVO8vWRnqWIJQeqiDDaPwdyWgT2+E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z1yaUBxaT8wcJSSXbGXWRrtin1Nd0WXcFhAsgFdgoyjM1rEhUS6q3wOv2FGnChkk5
	 OiKig6p90pKGBIedPq+xPSVKRWR8f+Ie/1UFY2QOHInsJZnDZVBGJH+C+kRK6/5SQJ
	 G+R+zMq6+lxWjIKPvq0J3w7UBD2s8Cfz4uC/+0wIFdQkWksrU4BL1EJGKRqvzGFlrb
	 +6DbjSLjal3mfZAPJVwnHMbYQz3z0jc7OhPWm5qHSPvZlTPntqRzgRrjNJSLFF0F09
	 UlAxk3SlDzqVB2o0hcjzNr29eO7SeHKijx1CRDyhVd05dwwYXGdWvTun26+/wwQthP
	 G54iXX7SGHmXg==
From: Christian Brauner <brauner@kernel.org>
To: linux-fsdevel@vger.kernel.org,
	Randy Dunlap <rdunlap@infradead.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH] fs: fix f_ref kernel-doc struct member name
Date: Thu, 17 Oct 2024 11:19:12 +0200
Message-ID: <20241017-zweieinhalb-windschatten-9d42459dd6d0@brauner>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241017022536.58966-1-rdunlap@infradead.org>
References: <20241017022536.58966-1-rdunlap@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1095; i=brauner@kernel.org; h=from:subject:message-id; bh=/YPKPrRZdMnIhVhVO8vWRnqWIJQeqiDDaPwdyWgT2+E=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQLXJv856zx5nNZect3PGYW2F1tE3xm/derdVM6Fhw5P 2v2cmZlho5SFgYxLgZZMUUWh3aTcLnlPBWbjTI1YOawMoEMYeDiFICJ5DMyMtzcMGXjvSv+ZTeO vTtdcDdRzbWbp/Rb5ATmxlkO+yR/NbQw/GY9xHXdrNf71JIGvv504Rm8N9wuHhQMnmuxJEvh17Y budwA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Wed, 16 Oct 2024 19:25:36 -0700, Randy Dunlap wrote:
> Eliminate 2 kernel-doc warnings by using the correct struct member name:
> 
> include/linux/fs.h:1071: warning: Function parameter or struct member 'f_ref' not described in 'file'
> include/linux/fs.h:1071: warning: Excess struct member 'f_count' description in 'file'
> 
> 

Applied to the vfs.file branch of the vfs/vfs.git tree.
Patches in the vfs.file branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.file

[1/1] fs: fix f_ref kernel-doc struct member name
      https://git.kernel.org/vfs/vfs/c/babb8e98753a

