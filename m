Return-Path: <linux-fsdevel+bounces-1209-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 440E07D75FA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Oct 2023 22:53:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D9761C20E5A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Oct 2023 20:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E2EB28DDE;
	Wed, 25 Oct 2023 20:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OSZiex5N"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C3412B6D
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Oct 2023 20:52:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6826EC433CB;
	Wed, 25 Oct 2023 20:52:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698267177;
	bh=Vdk7BnaY8q7QNCJoZksb3qatX/oTAIiXyJ2WGA8kKz4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OSZiex5NLJLIdwo3OGE5y7GNejpyJLbYAEka2BD5acr7DERGI/UPOUliBT28wY/d+
	 BYEn67m5J+liIGKKo5fN2/4gAWzWiI4zFnz+t/TSrwxzy2+SCny6uiNO4ZQa9RLNhj
	 Zv9+P9oyRw/YyLK41ux2FKUKXIpoQ6v0skIHd5tSbQWeZYzjRFOrJsYtCMXHe2P9mQ
	 Uk7AY261ugtcGjlbiGFVwQ7xFkLP5P1elylb1RW85Ekfw9Tczh5I2Y0U1CXW3K1WJm
	 P8sPbRrwtnyvKxcXUwOvTLN8KDKND4tf+HxftvcIKyR3ZPOHpui5LTSaykkPIvr023
	 UFMSq+ukGAdsg==
From: Christian Brauner <brauner@kernel.org>
To: Christoph Hellwig <hch@lst.de>,
	Amir Goldstein <amir73il@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] freevxfs: derive f_fsid from bdev->bd_dev
Date: Wed, 25 Oct 2023 22:52:52 +0200
Message-Id: <20231025-armaturen-semantik-d87139f9b0e1@brauner>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231024121457.3014063-1-amir73il@gmail.com>
References: <20231024121457.3014063-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1093; i=brauner@kernel.org; h=from:subject:message-id; bh=Vdk7BnaY8q7QNCJoZksb3qatX/oTAIiXyJ2WGA8kKz4=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRaNii0fC9cIPvK/sHFrU+3vFKYPuPW1VkS7x7Mzdy1IHFj Ss/k+I5SFgYxLgZZMUUWh3aTcLnlPBWbjTI1YOawMoEMYeDiFICJ3K5hZGjZ1cl2/sa9TexfJFfxNA dyBXufnhowrXK54vmLMh992M8yMqya7lV+SvtKWuqXjce5zhZFMDuLHTj6IndP+vag1muTPnIBAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Tue, 24 Oct 2023 15:14:57 +0300, Amir Goldstein wrote:
> The majority of blockdev filesystems, which do not have a UUID in their
> on-disk format, derive f_fsid of statfs(2) from bdev->bd_dev.
> 
> Use the same practice for freevxfs.
> 
> This will allow reporting fanotify events with fanotify_event_info_fid.
> 
> [...]

Applied to the vfs.f_fsid branch of the vfs/vfs.git tree.
Patches in the vfs.f_fsid branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.f_fsid

[1/1] freevxfs: derive f_fsid from bdev->bd_dev
      https://git.kernel.org/vfs/vfs/c/462e67783c2e

