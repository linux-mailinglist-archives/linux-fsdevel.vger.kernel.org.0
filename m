Return-Path: <linux-fsdevel+bounces-21948-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BB2FE90FDFF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jun 2024 09:46:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 424EEB24F55
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jun 2024 07:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28AFF55E5B;
	Thu, 20 Jun 2024 07:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CWHbd+m3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F951803A;
	Thu, 20 Jun 2024 07:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718869596; cv=none; b=p56w9jp1paPGmoWCgBmS3dvSPXzhr+AWXgAdqatUEaYi1Hy/dGWyX6isyj79oQExI3QCoMns7Ekb99uUefVryrDkCtrFXrBKyO00P2F5ZNSjrTRisWNLFpaaoxKGWjVPs0Se2eXiXZO0rXBStlAi0gC1ab/65pnkfzRR+ZXyavI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718869596; c=relaxed/simple;
	bh=v2gXpKgBK7Qhc0Qigkxufj6SFVYQaHNJh7yaTp7lIjE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DHjjP9bCpw72Krxg1JqPlV97FN55aWJPs3B3g+z/BmcaUOfEBPJv5M837gwUfCPoR++o4bfT4c8+gWTO6PADLGwXP8sWJqS8pkQZQpB44/zvwElHO8RRt0sU+cbzsfAnOHOck0/0pcjZL4CquzY59gd2g9lHskHvqKeKqpF6wlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CWHbd+m3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87BDCC2BD10;
	Thu, 20 Jun 2024 07:46:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718869596;
	bh=v2gXpKgBK7Qhc0Qigkxufj6SFVYQaHNJh7yaTp7lIjE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CWHbd+m3Lyicvoc6NVwiI70irdmZ7m2/V/fn0f9jRrL7MJDvsvFwIhQOQ5FIRKEqo
	 L1dDSsfk3Acw8QmOesIOQiBSiaAZQVbN4lRWpbEEoHRrNYx0EPYGIZugA2lQr4mlm3
	 kY/au8NDHWjUSAlTz3aj5y2MzyBArPIwtsc3o9svgMAFC0nivk0o3j4wo4Dw87RwNx
	 HK/5TPn9YRKsjTKGz3r+ms6+a+3ZD8fVKDWNUawBWbHbw2oxs4GY5Ky/qPzbJyjxMw
	 DseKV3Yc920blW/EigtLemKgxlLFQQnXHHZ+h3rtoIV386fvwhBcYgjASkmDfCmHe9
	 MDTcrTEik+WpA==
From: Christian Brauner <brauner@kernel.org>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Christian Brauner <brauner@kernel.org>,
	sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] openpromfs: add missing MODULE_DESCRIPTION() macro
Date: Thu, 20 Jun 2024 09:46:19 +0200
Message-ID: <20240620-periodisch-begleichen-68d1d06b70c6@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240619-md-sparc-fs-openpromfs-v1-1-51c85ce90fa3@quicinc.com>
References: <20240619-md-sparc-fs-openpromfs-v1-1-51c85ce90fa3@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1081; i=brauner@kernel.org; h=from:subject:message-id; bh=v2gXpKgBK7Qhc0Qigkxufj6SFVYQaHNJh7yaTp7lIjE=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQV3wuZq3Geze38Mpvzt7oUXB7qXrLfo7Eg//8SmYa/M +9bRW5S7yhlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZjIAS1GhuvrM4/PWxr+5Opr ju2aX85+7ub48FnvZqrK560Wi5rn+KgyMszZO2fNO/X7U+tC5bQu3PbW9grP4Ny4+oDuk6CmFbs P6nEBAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Wed, 19 Jun 2024 07:38:14 -0700, Jeff Johnson wrote:
> With ARCH=sparc, make allmodconfig && make W=1 C=1 reports:
> WARNING: modpost: missing MODULE_DESCRIPTION() in fs/openpromfs/openpromfs.o
> 
> Add the missing invocation of the MODULE_DESCRIPTION() macro.
> 
> 

Applied to the vfs.module.description branch of the vfs/vfs.git tree.
Patches in the vfs.module.description branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.module.description

[1/1] openpromfs: add missing MODULE_DESCRIPTION() macro
      https://git.kernel.org/vfs/vfs/c/807221c54db6

