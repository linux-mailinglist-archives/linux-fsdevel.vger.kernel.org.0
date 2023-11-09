Return-Path: <linux-fsdevel+bounces-2501-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58EDA7E667D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 10:19:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0D43281142
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 09:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B336D111A8;
	Thu,  9 Nov 2023 09:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ak2l8fch"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED36411190
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Nov 2023 09:19:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73AF2C433C8;
	Thu,  9 Nov 2023 09:19:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699521551;
	bh=HVYvN2ozVNeiaMghylZLEYToigZ/kX7ZicoXTeV4yrA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ak2l8fchJOepij39mv/tFpw2xQhP+8ITDV/1uKYBlWBbwDTPF3nloOkHMUYL8mUUt
	 LoGAnMc4TpW/WAhZ5y4gUXY/vrKU7UjMfbIQ+286lN56QwhglNPucsfijVA8IXHvpK
	 OtBxnGHu6xdoueQ/9CACI+PbWYaF2VhhMvdTQAgu7dJuF71vYfSPOhkmBykkeZlO95
	 f9QYP6zJiuywK7Cq/OXcDTM5XnxAUzDx2/9sbSj3eFgAFG/UctLTm4Nu4dd+oSx7kS
	 tSyMgUq5zFBrgDLuD+Kof05icpkQGUnHTk5osbxBRfkPkYvliW+Man1WSKiCQihLJR
	 CXjrzcC6pCKjA==
From: Christian Brauner <brauner@kernel.org>
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	Yusong Gao <a869920004@163.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Filesystems Development <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] fs: Clarify "non-RCY" in access_override_creds() comment
Date: Thu,  9 Nov 2023 10:19:04 +0100
Message-Id: <20231109-klang-thermal-02adaa814632@brauner>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231031114728.41485-1-bagasdotme@gmail.com>
References: <20231031114728.41485-1-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1023; i=brauner@kernel.org; h=from:subject:message-id; bh=HVYvN2ozVNeiaMghylZLEYToigZ/kX7ZicoXTeV4yrA=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaT6LP7d5Xi51b+CxenWlF+VdSuf7Ey/0tu5jqUo6dKqhdYP 2k7t7ihlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZhIVzDD/5j3JQsaVHwZVDiX2/67NH Hbc/5n99bIHs494Fgo0dp9WIiRoaHugqaMgKpm56TzLJwsfB1nVOb+dNL/v6PpXoeOgnonLwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Tue, 31 Oct 2023 18:47:28 +0700, Bagas Sanjaya wrote:
> The term is originally intended as a joke that stands for "non-racy".
> This trips new contributors who mistake it for RCU typo [1].
> 
> Replace the term with more-explicit wording.
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

[1/1] fs: Clarify "non-RCY" in access_override_creds() comment
      https://git.kernel.org/vfs/vfs/c/effa12a475e6

