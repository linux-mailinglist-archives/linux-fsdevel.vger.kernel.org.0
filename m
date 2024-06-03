Return-Path: <linux-fsdevel+bounces-20823-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B9F58D842B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jun 2024 15:40:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF5A8289BF9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jun 2024 13:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90CFD12D767;
	Mon,  3 Jun 2024 13:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L6tmNkv3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED3A412BF3A;
	Mon,  3 Jun 2024 13:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717421997; cv=none; b=GkKVbHyVROEyfWeyqWnKv1a9yIlyvbZBe+QAnBNC0xU0nVjXTovl8KlxYEztexniALMptdZFz27+Jwz3RR9HtD5IvDJrwfF/+/bVFGzM53pB/8zdmpNPWV/o8dKpiiqCQhYfuJMM2b/TXdYkCqjD0TOt9dpSwhzf6/YdwXiBPAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717421997; c=relaxed/simple;
	bh=T7Y/+gtUnckL0y2wD4ut574bzZtI0DADyHMyFC770JM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EPyg3Q0UQHl1dTspZZXsDcx1UfTcuJ2R4L3tsbn393G9z9UItX88tBPzsZGO+RPbIlbigUhySs7mrLgDmQM9Q16BLakqMgXR+s+vX1ceuuCevd4fLmbggkZ7HIyCG8AE4JoyiJ8b9CPyhAPRsi6hsj3wV0WQwvF/HqBleygKuzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L6tmNkv3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4092BC4AF07;
	Mon,  3 Jun 2024 13:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717421996;
	bh=T7Y/+gtUnckL0y2wD4ut574bzZtI0DADyHMyFC770JM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L6tmNkv31YF6s79iv8Zz7iJ+yQ0aquj14pocCJIQype5m8BI2Hvy+8ZbNmHZa6ptH
	 aOHJA+lNgJf+bKu7TSknDK+vYK5C0ES59PSye4p324Fg82k1LtIOnwTVYRXc8bAU5Y
	 LaeuWoWeXcGFmVuVvb4/Q1c08l2oCAGiiXUvA9elzqFd6g16EZsQhSFNdCQrTGbZAh
	 AaJEzkogKxJMTh7g+emjqxHEzE9cRJ1/8utSF/e2ZaNJVJnsASYIKQgAuPtrMZQx3M
	 XANAjBvGhKcCmmdIpbpbhDO+scS82wbqzggVN+FG5sXhuulR56yMyrIwqXOCkB7ry3
	 sajA/WM612v3A==
From: Christian Brauner <brauner@kernel.org>
To: Gao Xiang <xiang@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,
	David Howells <dhowells@redhat.com>,
	netfs@lists.linux.dev,
	Jeffle Xu <jefflexu@linux.alibaba.com>,
	Baokun Li <libaokun1@huawei.com>,
	linux-fsdevel@vger.kernel.org,
	Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: (subset) [PATCH] cachefiles: remove unneeded include of <linux/fdtable.h>
Date: Mon,  3 Jun 2024 15:39:40 +0200
Message-ID: <20240603-besen-orbit-0a0aef505617@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240603062344.818290-1-hsiangkao@linux.alibaba.com>
References: <20240603034055.GI1629371@ZenIV> <20240603062344.818290-1-hsiangkao@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1007; i=brauner@kernel.org; h=from:subject:message-id; bh=T7Y/+gtUnckL0y2wD4ut574bzZtI0DADyHMyFC770JM=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTFHl8SfnhFUfwR04UagsVlnEsYsj5MfFXEaf3P71Pmx kkSViwGHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABM5c43hv8My4y38F5+KF+27 r744acPDs1tijj6yLT9baXBv90/lNX2MDP9fJSRtsDScwZEdI7vbo9iS76iSSsbDpRYp6RWi7uW HeQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Mon, 03 Jun 2024 14:23:44 +0800, Gao Xiang wrote:
> close_fd() has been killed, let's get rid of unneeded
> <linux/fdtable.h> as Al Viro pointed out [1].
> 
> [1] https://lore.kernel.org/r/20240603034055.GI1629371@ZenIV
> 
> 

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

[1/1] cachefiles: remove unneeded include of <linux/fdtable.h>
      https://git.kernel.org/vfs/vfs/c/5ea71848f7b2

