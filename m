Return-Path: <linux-fsdevel+bounces-37628-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 529A09F4B13
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2024 13:39:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA2B7188814E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2024 12:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 895B11F2C49;
	Tue, 17 Dec 2024 12:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="duKXW5FU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F3B1D47D9;
	Tue, 17 Dec 2024 12:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734439154; cv=none; b=barMDd6zIpHIvDBqqVIY63mnonIACbYmC73rN7yivAReBajvDbGO0cO9vNeYyJUK3JTlT2gwHBir6RFhBG4bXhcmWLFzXfkk0HjChgzbva8ANYPGAmbzhwq1YsiSSradt8gZdN+mf1qXTpn9okQtJh/dEgi20f7YkeT/hETdXog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734439154; c=relaxed/simple;
	bh=pvWqkIfN2XLnjfn9EiXUYtFcUHTfB9bKvq+z57nIOXg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q+kkZQ1RF1mHufhXFuAiLvoqnNfXQ9tyzJ36TCcp+mIDs603upnVkh4q+Gix569fFb7QWypcgmL1QvUMtoYpLng5IvkM1rU0cAJFbO5Hp8A0mcA45ifi89nT+FzvrK2ehNF+itkhtt9NJET4nvUd628mof/wjmNeXNvSnbviXLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=duKXW5FU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DEF5C4CED4;
	Tue, 17 Dec 2024 12:39:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734439153;
	bh=pvWqkIfN2XLnjfn9EiXUYtFcUHTfB9bKvq+z57nIOXg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=duKXW5FU8fhKbZvu5BuwLN6N6dCKo/H8mpFXQ8ia0gm6C0mX2QHe0sRKprkzZxHDI
	 qtJQgE6KHNHe9EKnjzZPAmoZ5XeSYzakyeYErg0EI5/+y3zJe8/KbmnHoUJFKuA/EX
	 QrCC87vrELWgP/WcD+rGZ4DUQC5/YWjzXVLeJFfbPBKB9OWuu7/EenlNeape/z2j1Q
	 z/7rYHGDtVqcURcZtTqMRJ2HhxMfKeL8x9L1zHF70wWkXvxkKCqWFONNGe2ihyhjQT
	 HRoECy9i9zhjZAiyIrpROM/mKBT8kYLtAUQru0yGFMQTeOG90Aft7KG1A4mmq6GdrV
	 A+ZhKRIyLa2cg==
From: Christian Brauner <brauner@kernel.org>
To: Zhang Kunbo <zhangkunbo@huawei.com>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	chris.zjh@huawei.com,
	liaochang1@huawei.com,
	viro@zeniv.linux.org.uk,
	jack@suse.cz
Subject: Re: [PATCH -next] fs: fix missing declaration of init_files
Date: Tue, 17 Dec 2024 13:38:57 +0100
Message-ID: <20241217-pseudologie-niedlich-a726a2d75782@brauner>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241217071836.2634868-1-zhangkunbo@huawei.com>
References: <20241217071836.2634868-1-zhangkunbo@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1034; i=brauner@kernel.org; h=from:subject:message-id; bh=pvWqkIfN2XLnjfn9EiXUYtFcUHTfB9bKvq+z57nIOXg=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQnFryKvWws7TWD+XZUmu/KJU1R2ic2bAn9FTLBb7eDa eGC/Pn/O0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACZS9pbhv0/eJ8/wP+5pIb6b A++Vz9yrNFeJw5m1dNLhvf+5o09PW8zIsF5601XRCyx28tOmdJ3d+qyw8x2jqo1sPt9uywB1Lq+ d/AA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Tue, 17 Dec 2024 07:18:36 +0000, Zhang Kunbo wrote:
> fs/file.c should include include/linux/init_task.h  for
>  declaration of init_files. This fixes the sparse warning:
> 
> fs/file.c:501:21: warning: symbol 'init_files' was not declared. Should it be static?
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

[1/1] fs: fix missing declaration of init_files
      https://git.kernel.org/vfs/vfs/c/2b2fc0be98a8

