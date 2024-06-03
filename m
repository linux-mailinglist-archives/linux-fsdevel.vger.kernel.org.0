Return-Path: <linux-fsdevel+bounces-20828-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 298A58D8458
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jun 2024 15:49:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AAB51C21716
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jun 2024 13:49:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1997B12DDAE;
	Mon,  3 Jun 2024 13:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZisACYn8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC0512D775;
	Mon,  3 Jun 2024 13:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717422551; cv=none; b=fGQJAIcpsfF3WelzFHorWSZVv7iRa/O+Aa2yQ8aKPGTttI41zZ8wDIel7//hoDGqkS6EJxUrpdOOH8z9qnuvjQPru60LWh3XVdCfqh7MldxcwVi4ZxDrioQqBU7mm6QZHRhTP+uaaGlLPkNrDBSHXomgMqIGE1fSQ2f2kRnYGhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717422551; c=relaxed/simple;
	bh=bN6rbFCtnOlzFHmoF0XRZoe/+d54NqkBt6Joc+xkbmA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Po6pxrofGl/gSv+KOBiWgJSGTaPEKRDFQsjN+zFWrYL1T+GIJeuGC1WToCtF39TPbl8MQjUFgB2AcDj1TY+UR0t7aKjeeyBvXEtmXqmHCffVej+lp3SNHhYqTTLYiwKoRq3XgcchuCYv4+ADeF/vsYJGSmq647iKrVwwX2P0t8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZisACYn8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6627EC2BD10;
	Mon,  3 Jun 2024 13:49:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717422551;
	bh=bN6rbFCtnOlzFHmoF0XRZoe/+d54NqkBt6Joc+xkbmA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZisACYn87/yVDMYuUqZhSnnIDcT1BBhqBJf3pwJ9g36CqBaRd1o++SF7xAIaUJ+yq
	 A8G6tyhCpv5uvRxScuApOIceS+HbBOShXATC+57sKgqA0H/vFpKtbrGTMozCsNPp27
	 bK4bHMLMZKGRuiNLQGFWN1my+eqqxbI3otY09ptnkjM4C/08GOvZxOjqUPcsW8ITjr
	 o4PvmaXrbM4Pa+JerKjE5y5loTi2ClWbVJfm4mz0b/nFx6M7t7+E3vCvMJxvySQSqE
	 Y+3XPMNxRgxhwkoGw4RD3Cfj1cCUR1fpPg2h5+ltUr9y5mU+lesA/mIrjk3nxmoQ7r
	 eMSWOd1DP8vuQ==
From: Christian Brauner <brauner@kernel.org>
To: Thorsten Blum <thorsten.blum@toblux.com>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] readdir: Remove unused header include
Date: Mon,  3 Jun 2024 15:48:56 +0200
Message-ID: <20240603-kugel-kopieren-03484dc4daab@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240602101534.348159-2-thorsten.blum@toblux.com>
References: <20240602101534.348159-2-thorsten.blum@toblux.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=971; i=brauner@kernel.org; h=from:subject:message-id; bh=bN6rbFCtnOlzFHmoF0XRZoe/+d54NqkBt6Joc+xkbmA=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTFnrwgZMi24qn6h+33ZR5dZcre+S28QLgkziPg4q3k9 dUlPxMKOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACaydinD/8xJ736evPgiT1Vh gcYvqU1WLPtW62xSFvabVe/TVL67VZOR4fzGxutu/1Q6t9gZHVxZc+WnYGii/9t3jw+rhzY855t +nwMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Sun, 02 Jun 2024 12:15:35 +0200, Thorsten Blum wrote:
> Since commit c512c6918719 ("uaccess: implement a proper
> unsafe_copy_to_user() and switch filldir over to it") the header file is
> no longer needed.
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

[1/1] readdir: Remove unused header include
      https://git.kernel.org/vfs/vfs/c/c06a4cc368ac

