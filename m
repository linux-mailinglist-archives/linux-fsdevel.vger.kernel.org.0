Return-Path: <linux-fsdevel+bounces-1002-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89A0F7D4B67
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Oct 2023 11:00:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B817F1C20A99
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Oct 2023 09:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B184221115;
	Tue, 24 Oct 2023 09:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L1NSnPap"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1EC91FDF
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Oct 2023 09:00:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F1A0C433C7;
	Tue, 24 Oct 2023 09:00:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698138039;
	bh=TvrYanv2jMskWb2cAdNa0Fkuu/4Td1ZBRvYxLvrzlLg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L1NSnPapOv3BbA5HbkEy0sE7FwTjSDK7Ty0co0SIzlpxCoK8PlzG+KShFxrnQTgoe
	 KXZQGhMB9ZOB7aJ0l0HynxfPu79eQ8JA6CcRDR/HsRqkQ2TcNU7lGdj/kkh6LNVdJh
	 yJThyqLRTzld9/38ZLCYhfkDFkOGuglfib3MrrKn9fhusoQILwe0b5vt8PAeEudyyw
	 moTZWovTPMevBu+Y3B2J/tF7VocNEn09WhE4TvmCUam8tlgemUp2wjDhV2d4kgbTlD
	 fXyd7malpeJ/uW0ePstc6zS06L9uIH9dmSIXQt70UnBeSGULh67MZKEHAlFtuT/8Hq
	 mvKjr1uRyqbKA==
From: Christian Brauner <brauner@kernel.org>
To: Bernd Schubert <bschubert@ddn.com>
Cc: Christian Brauner <brauner@kernel.org>,
	bernd.schubert@fastmail.fm,
	Al Viro <viro@zeniv.linux.org.uk>,
	Amir Goldstein <amir73il@gmail.com>,
	Dharmendra Singh <dsingh@ddn.com>,
	Miklos Szeredi <miklos@szeredi.hu>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] [RFC] vfs: Convert BUG_ON to WARN_ON_ONCE in open_last_lookups
Date: Tue, 24 Oct 2023 11:00:32 +0200
Message-Id: <20231024-sanft-beichten-e6d2365bc88d@brauner>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231023184718.11143-1-bschubert@ddn.com>
References: <20231023184718.11143-1-bschubert@ddn.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=933; i=brauner@kernel.org; h=from:subject:message-id; bh=TvrYanv2jMskWb2cAdNa0Fkuu/4Td1ZBRvYxLvrzlLg=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSat8/5qn6lYcGcIznMcqzii/ed6n9wQur6w+XW7Kv4+95L MrD97yhlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZjIxv0M/71cdmfveCzG7xb1w3jmOp 0GtUvrCqdHuwbXTzvz/pmP5CxGhnO3q8I10+ZtWxOygSm9SM7ppvjTZxVa91hzg7acymwJYQcA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Mon, 23 Oct 2023 20:47:18 +0200, Bernd Schubert wrote:
> The calling code actually handles -ECHILD, so this BUG_ON
> can be converted to WARN_ON_ONCE.
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

[1/1] vfs: Convert BUG_ON to WARN_ON_ONCE in open_last_lookups
      https://git.kernel.org/vfs/vfs/c/c04d905f6c7c

