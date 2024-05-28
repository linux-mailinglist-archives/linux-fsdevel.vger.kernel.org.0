Return-Path: <linux-fsdevel+bounces-20345-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D49E8D19DF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 May 2024 13:41:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E3B028D889
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 May 2024 11:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13E5916C87C;
	Tue, 28 May 2024 11:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qU1qW8o3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C09A16C855;
	Tue, 28 May 2024 11:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716896433; cv=none; b=dFAMIUEH1+6q4lq8PTOnDfq2Qawr4qddE45h9YcSShVTtpFoJayGu3YoAR/3NvhTfnZzT0rTbADQUxDVG26Zuv/EyfcLvxmlMcJ0eFxgOr7GolOGqDjeqS5dFwKq7IfSxZk+35q34m/zFtW5O/wzvI+teoJZbR7ZFbXLBqsMSHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716896433; c=relaxed/simple;
	bh=uNv7NHqHzFgggcdb6PDv5TvU8eZ5Ipnraxm/zrZyFoc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BxUapD2bMxpeSndNj0L8BKrgcLwTyyWCZc+XMqksnpwZbIceB33GJ7c707A3QwNuRB2Wlcd1sv7Dd1IdIwrvxiMUyPy/Rl5nivdCUU8lVX5MSpgJ7VeGm+5dFUyvw01Sf7rYWcUMyFudjCZ2rJIa4toOzX/U7IfxmbFjrUM1Tyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qU1qW8o3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AECDC32781;
	Tue, 28 May 2024 11:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716896433;
	bh=uNv7NHqHzFgggcdb6PDv5TvU8eZ5Ipnraxm/zrZyFoc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qU1qW8o3T8zvR1NXO5EGznMdlG+EeLaNjTZHhqTlW9UEbOOyKb+Z1u0OnmBemKlq9
	 MhUSRfI0Q97c3JezYxQ6cT6rtWvf+6Lh0EYn7Q8KaVZnLRc3Q8Hi98PMGEDVF74qoH
	 TOJg0+dCBXz4F92eGIq8LYJGFaBiplOAIaGsb42FE42XIG62dlAi+9HVu1JclDmChe
	 CF4jLLxWJEcFva4MD9I3aesfpx3F6bTWU/BLVk/v+nZxbFMCzPKynWHeC+/m25hN6K
	 y1WtMUtJyK870PHjqnkSsITQ4T7mGbAXUobSYMx6ZNOy1FFGOc93N6Bf4T+OU3BQQj
	 kE+4L03tymiGA==
From: Christian Brauner <brauner@kernel.org>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	Eric Biederman <ebiederm@xmission.com>,
	Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] fs: binfmt: add missing MODULE_DESCRIPTION() macros
Date: Tue, 28 May 2024 13:40:24 +0200
Message-ID: <20240528-boote-neuauflage-38effd449864@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240527-md-fs-binfmt-v1-1-f9dc1745cb67@quicinc.com>
References: <20240527-md-fs-binfmt-v1-1-f9dc1745cb67@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1005; i=brauner@kernel.org; h=from:subject:message-id; bh=uNv7NHqHzFgggcdb6PDv5TvU8eZ5Ipnraxm/zrZyFoc=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSFHlqZpxFvxnhBb6170h6HxE07fnZGMskE1L6uF/l1U Ov09eo3HaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABNxOczIMHej2L/GZfZC92xu 7/lwd753q8cFE6b6C7rnnOTbbDaHrWRkmKQXca/CoHZJ4rlDDVtkqoQmM9SyRNjqnvNd7bqsTO0 ACwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Mon, 27 May 2024 11:57:52 -0700, Jeff Johnson wrote:
> Fix the 'make W=1' warnings:
> WARNING: modpost: missing MODULE_DESCRIPTION() in fs/binfmt_misc.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in fs/binfmt_script.o
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

[1/1] fs: binfmt: add missing MODULE_DESCRIPTION() macros
      https://git.kernel.org/vfs/vfs/c/d60efd521448

