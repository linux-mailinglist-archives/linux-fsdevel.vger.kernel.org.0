Return-Path: <linux-fsdevel+bounces-51273-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D97F3AD50BF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 12:02:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D80F164384
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 10:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A6302571B0;
	Wed, 11 Jun 2025 10:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t5q5WAZd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89574220F33
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Jun 2025 10:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749636160; cv=none; b=bUCsCDMktHW7AFXtHrxsu9MAYcsm8lA0M7EIGp9OYHKtmlUWhoG9FbIW5qI399Y5XN4P4s1el/qMW76FpepsVHkZQzJddfqEd+dHLEat5goSnU0hzItjIiRU05EYyDuGwnxHsX1cSwX/AZwxZKQ19oIVWIm0278BCY7uMRsV7BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749636160; c=relaxed/simple;
	bh=K9Gvy8gIZldInIRPquGwsNycVOt5EXt90rejdUjfayQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rg0C/HM8vq64Yu67hV1h+LwDa1YSsFjXov3twKvRJmYpSbObA+9vbp9puEM4NuVtriEguGs2HjitFIE6VBz3SqBaHAMwOm4TUVjfIIzpL/cjAddcURO4irfipDdYwHa6TLk7psc8Gv3epiMaiJofuWPCN0U7TGlEx6Z2lykyYvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t5q5WAZd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78DE5C4CEEE;
	Wed, 11 Jun 2025 10:02:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749636160;
	bh=K9Gvy8gIZldInIRPquGwsNycVOt5EXt90rejdUjfayQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=t5q5WAZdwEv+M3Zyyv6VVhywAYBJOckZLiKODY21jLr6LDu+EF7qim6yktkLtRwy5
	 YzNdcdH9lf2ky2r/FoRcJBA8dL8gZY8m+IpbnzNzMd1FTlPO1vV0LetRvJE4qLi+Kb
	 i0wse9poaPvMf0SqiOl4e39f/p9O6qseiGvbGU/MqAUuLU6lzlu1nSdmhyS4zrRTSy
	 0BU+siAazeJuEd9UmvEXGRCUqX2Aov0LftODk4bp2qNNqEdeJfuWGdvsYVM/rM7Je7
	 Hy32+Q0Jfx8m6zNbbCrpz/Ci2w39lKQciIvAc8V0nLgqDFhmV0Sd6gU8e3vkMfcGwM
	 PX4PxSu8Buaow==
From: Christian Brauner <brauner@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Christian Brauner <brauner@kernel.org>,
	jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	viro@zeniv.linux.org.uk
Subject: Re: [PATCH] fs: add missing values to TRACE_IOCB_STRINGS
Date: Wed, 11 Jun 2025 12:02:28 +0200
Message-ID: <20250611-ofenrohr-ledig-25daeb0c4188@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250610140020.2227932-1-hch@lst.de>
References: <20250610140020.2227932-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=866; i=brauner@kernel.org; h=from:subject:message-id; bh=K9Gvy8gIZldInIRPquGwsNycVOt5EXt90rejdUjfayQ=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWR4hlitFdhgFv0qsyGuqX4eCwfzDQHza807hPJDl4c+f KtoJOLWUcrCIMbFICumyOLQbhIut5ynYrNRpgbMHFYmkCEMXJwCMJEXegz/k+PzdNbFRUS7ZnTM 0m4tWJM+/VxN2J9/GxRPsk6tuPoqguF/DY9ftMSKf7EzlvVwbnEz49myNT3fQHZm2lfjZQdPrD/ KBwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Tue, 10 Jun 2025 16:00:20 +0200, Christoph Hellwig wrote:
> Make sure all values are covered.
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

[1/1] fs: add missing values to TRACE_IOCB_STRINGS
      https://git.kernel.org/vfs/vfs/c/6bdd3a01fe46

