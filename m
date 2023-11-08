Return-Path: <linux-fsdevel+bounces-2378-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A15B7E52F7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Nov 2023 11:01:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11F662815E8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Nov 2023 10:01:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A90061095F;
	Wed,  8 Nov 2023 10:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p4vsctcN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D016E10941;
	Wed,  8 Nov 2023 10:01:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E75D9C433C8;
	Wed,  8 Nov 2023 10:01:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699437699;
	bh=c26pV7uu7/MezlnwE49nnT69zyOHtMIPvZ6cQacoyxU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=p4vsctcNNKAZO8V02D/+/2cT2LB3Cxy6duxIKPb+IbiyHHheVfH50qOG5Ot8uEorb
	 DqS7SiFp89i9HizLvrD06U+UwwXhyvBfqv6DAf3sVrQ72aB0udxPGWSFfsTePm5oSD
	 i8DOsNqH3iZ5TCUr94dS946Q+nTYTAOmnh1YVEC0MyTOL6ZO1MDeaL7y0HEm4AgyRH
	 LfWsi03i3Tbow1nOJhb+KPG7OyV7/q3wyDmyejY3+R2BouqPPYCvYIy7SpoB+VkL27
	 gtgxn+vl29bYmYaYxQJ8f92kSodttuGn1y1W82TAHqrzynPkXqsuAAabtpEDU1+F6x
	 cLMq42CM2IdCA==
From: Christian Brauner <brauner@kernel.org>
To: Abhinav Singh <singhabhinav9051571833@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	nvdimm@lists.linux.dev,
	linux-kernel-mentees@lists.linuxfoundation.org,
	viro@zeniv.linux.org.uk,
	dan.j.williams@intel.com,
	willy@infradead.org,
	jack@suse.cz
Subject: Re: [PATCH] fs : Fix warning using plain integer as NULL
Date: Wed,  8 Nov 2023 11:01:29 +0100
Message-Id: <20231108-rasur-zugute-1f2c148eae10@brauner>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231108044550.1006555-1-singhabhinav9051571833@gmail.com>
References: <20231108044550.1006555-1-singhabhinav9051571833@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1056; i=brauner@kernel.org; h=from:subject:message-id; bh=c26pV7uu7/MezlnwE49nnT69zyOHtMIPvZ6cQacoyxU=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaR6x8RnfJuaclg56tObSdPfS+7Zzjrz5JHft365bYp6F3cn +NUhzo5SFgYxLgZZMUUWh3aTcLnlPBWbjTI1YOawMoEMYeDiFICJpE5h+O/aeHr2evn8gG/3D1tF/n 6lutWlZenM23deM4T8qH2v0beT4Z/tjNsPk2RaTPSDDTJfzm9oSN4dy2AxYdVlpuAtswSYH7MCAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Wed, 08 Nov 2023 10:15:50 +0530, Abhinav Singh wrote:
> Sparse static analysis tools generate a warning with this message
> "Using plain integer as NULL pointer". In this case this warning is
> being shown because we are trying to initialize  pointer to NULL using
> integer value 0.
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

[1/1] fs : Fix warning using plain integer as NULL
      https://git.kernel.org/vfs/vfs/c/372bfbd2ea43

