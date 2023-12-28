Return-Path: <linux-fsdevel+bounces-6995-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4E1A81F6F5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Dec 2023 11:41:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C73E281857
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Dec 2023 10:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B34A26ABD;
	Thu, 28 Dec 2023 10:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LIul1hgV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A35A6AA2;
	Thu, 28 Dec 2023 10:41:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95DFBC433C7;
	Thu, 28 Dec 2023 10:41:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703760098;
	bh=Lm4RH2YhQ3SYoEAGCv2AsMstea+qfOvRqcQ+qVAsHzA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LIul1hgVSjO2fY4vaW6g6T6UmUnLjOfVEw2axvcJzcFUAnRb8kVJhNS5fXdA5T49y
	 E+2d1HIBdAcWpFty9RiYKqr0DKssm5xLMOse5wdbtKXH7h9RelNgqOVZcjpzicNvF5
	 eYBQd+hnAIlDFnZA7/849lemrFQ0+ARykJJ49d7EANlOoIr83T4LjLmODI1qM3Sbkv
	 aYM+YGo3xa9awqOgWcZa6M1hyakQeLmJUFOxutVIswCq4cYU112ahhT4r6HPgr/Uh2
	 5kr8cDab8FCGQ1yziFZV/dBua/ZW/N/lZ9nkkoolveWHNmt9X1Izqxd4Z7EV+MNyvU
	 auyb9cTwwGmxA==
From: Christian Brauner <brauner@kernel.org>
To: Vegard Nossum <vegard.nossum@oracle.com>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Amir Goldstein <amir73il@gmail.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>
Subject: Re: [PATCH -next] fs: fix __sb_write_started() kerneldoc formatting
Date: Thu, 28 Dec 2023 11:41:15 +0100
Message-ID: <20231228-behutsam-mut-904e0a059471@brauner>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231228100608.3123987-1-vegard.nossum@oracle.com>
References: <20231228100608.3123987-1-vegard.nossum@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1301; i=brauner@kernel.org; h=from:subject:message-id; bh=Lm4RH2YhQ3SYoEAGCv2AsMstea+qfOvRqcQ+qVAsHzA=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaT2Bpx6cP7BUpZ90YICRSWPs1KZf5i0fev82dLh8lzOZ vkN9cLXHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABNhmM7wT6117Yoryq3LDKQb Obr23vixlsHlWJf/avM/Gx//KF9w9gojwzan4/osn9cuk7sz/fDqs+wWZyLf+lvXH5DdfMj6SMC xMB4A
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Thu, 28 Dec 2023 11:06:08 +0100, Vegard Nossum wrote:
> When running 'make htmldocs', I see the following warning:
> 
>   Documentation/filesystems/api-summary:14: ./include/linux/fs.h:1659: WARNING: Definition list ends without a blank line; unexpected unindent.
> 
> The official guidance [1] seems to be to use lists, which will prevent
> both the "unexpected unindent" warning as well as ensure that each line
> is formatted on a separate line in the HTML output instead of being
> all considered a single paragraph.
> 
> [...]

Applied to the vfs.rw branch of the vfs/vfs.git tree.
Patches in the vfs.rw branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.rw

[1/1] fs: fix __sb_write_started() kerneldoc formatting
      https://git.kernel.org/vfs/vfs/c/c39e2ae3943d

