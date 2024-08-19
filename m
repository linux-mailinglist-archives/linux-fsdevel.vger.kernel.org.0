Return-Path: <linux-fsdevel+bounces-26240-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 52BF195663E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Aug 2024 11:02:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B4E2285A42
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Aug 2024 09:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDBC715B971;
	Mon, 19 Aug 2024 09:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ir3khIMl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C5813C8E8;
	Mon, 19 Aug 2024 09:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724058114; cv=none; b=c65T3hGCQqRC+bHRG/0r2vaUzND+A1SIg3vbAS7u0MKeGehwq87XoKjfubm5CjtUFdikj8tUm09rD6zKv3GzB/N9nVqSyM+R6+RZyqS7qvYh8Rd3v2YnpXxORqxfZz523fanVvQ0ZZfsc64D9BQY38RUElXfVQPX0VZxrptmVss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724058114; c=relaxed/simple;
	bh=yVdw8Guk03mBlIogqzC6Cu+WN/LccnzLj/97Uwp0Juw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hLQWy2iDzlCnMBUZ+2X5emliu+4l88nNbsBQYtPmR0f5Ik4mk4FtmJkiEoOF4ig6KOiVul6L5XCBNLP4KVXwCjHvyWtr/qthJQKT31I8eWYXIflxaAJ3gSS2hwhpI6rdlA1/Cwuy+kZfNkKzuykjGo9qmhgqGez0hb9xRpigHa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ir3khIMl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BF2AC32782;
	Mon, 19 Aug 2024 09:01:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724058113;
	bh=yVdw8Guk03mBlIogqzC6Cu+WN/LccnzLj/97Uwp0Juw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ir3khIMlr7LmrabJwZnRwe4fmPmHzhtsyMkvchI0N3UNEKDi2IpLaBb7pllFhDPSa
	 GXNByn0y8oHCzeVSb1JeyssvNqRCvr+5u/OM3QwEIqR+ficov8w5pYZO5pEFlTZsbd
	 wK7VUHQpJiMSV30jpzd3d0/14pRtlRHD7h9B3ub6U3LVgWIFCQLhK1NBowhwAdNIlW
	 vgxv4RDS529W1IsfsjlpQROjPhnmOrc0aSc86hrBmeMW9Q0P4U+wNkYRYBpxyhcY0d
	 /XdfXXuTVv5f4MAH5tFGqKDtHdLkn3gBuvUAqUcGTYDBM085Fe4nXWpOYovjyTMNm4
	 nH6LMD6ryt57w==
From: Christian Brauner <brauner@kernel.org>
To: sforshee@kernel.org,
	corbet@lwn.net,
	Hongbo Li <lihongbo22@huawei.com>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH -next] doc: correcting the idmapping mount example
Date: Mon, 19 Aug 2024 11:01:43 +0200
Message-ID: <20240819-satzung-hackfleisch-0cfc3e3abfc7@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240816063611.1961910-1-lihongbo22@huawei.com>
References: <20240816063611.1961910-1-lihongbo22@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=939; i=brauner@kernel.org; h=from:subject:message-id; bh=yVdw8Guk03mBlIogqzC6Cu+WN/LccnzLj/97Uwp0Juw=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQd5vypvUkkO7jilePaKyIfzpR4i1t4/GWPtzG58GhVg Fb8jM2KHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABMpm8jIsMW/c/3jsy8u/1p7 cIqp2KyW051LJ85bz35D5k7ajz/pN3cx/E+qdZ5TuZnDt84imntVhVbXFPk9fbzrLvjwXDSPfvJ yARsA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Fri, 16 Aug 2024 14:36:11 +0800, Hongbo Li wrote:
> In step 2, we obtain the kernel id `k1000`. So in next step (step
> 3), we should translate the `k1000` not `k21000`.
> 
> 

Applied to the vfs.misc branch of the vfs/vfs.git tree.
Patches in the vfs.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.misc

[1/1] doc: correcting the idmapping mount example
      https://git.kernel.org/vfs/vfs/c/bef1ad86cac0

