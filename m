Return-Path: <linux-fsdevel+bounces-10457-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E487B84B5A8
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Feb 2024 13:56:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A02E1285769
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Feb 2024 12:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BD1E12B142;
	Tue,  6 Feb 2024 12:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TngWwIcp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F01B02D603
	for <linux-fsdevel@vger.kernel.org>; Tue,  6 Feb 2024 12:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707224178; cv=none; b=nbC0wIIqbUIeKZXTSM6qlPGxCuYVk9zgq4oeMmO4+y9OZr7Rf5M+FCpCMxj/az1trWiBw2yuhpm21fQ7ELuS/1Uq7lAZdLgNrDkHG1iLrYP9vC7qmXH0csHb3iIKpSo7FIMXz1BEp6clYrR9aumzBetf+W687QOd3ck+fO92rqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707224178; c=relaxed/simple;
	bh=aHvoIMhqHK8Hz7ZDSGrgTvvDulv0b0MKQAO8XzbAZ1c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ECBE9xbl8QXO+8JsALT0myizJIDQm5AzYbe15DaLxQr5reS4OrKHzbcBVgP2JPIdZQcw4Hl3/oXxn/qcSOnBMCfuAD/SXp0vWnMovK2/dTovaA2MBe17PQpSsqkqhpcYlwaXCWYnmH38srPh/SsGIzgmqCoob7nGQIOEoNG0OtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TngWwIcp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 680AEC433C7;
	Tue,  6 Feb 2024 12:56:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707224177;
	bh=aHvoIMhqHK8Hz7ZDSGrgTvvDulv0b0MKQAO8XzbAZ1c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TngWwIcpsDqnTSVv4Ztckm/P8UV/HaH9Z1tRmjRKe2ndkEuDu5juRmeimIUAa7nK2
	 kEbFMiwK5LA+EcgoaoPXzdaUUviurZPYI4FHZdGHF38EDD4henFpWqsnqfmtoGfyXr
	 lGVeReM8zbXzGvvCFuYtXJANLRf+bJyU/PNe/QCEKHwWr+YQtx9OnFPIDFLntbvIoR
	 vOMSRA4ZTZfxzyJYgOKKmmyLV+VDrcEFKGbTHN1YfBxjdx6tjrccVpwhJzQpzfVxnT
	 xUhwGVFrchuxhufeKG48Rhlb07OdAy7Bc5SeHuoMw4VGbBcR2GcTvwMH4OBh3edPVp
	 09HUa1/lQZT0A==
From: Christian Brauner <brauner@kernel.org>
To: Huang Xiaojia <huangxiaojia2@huawei.com>
Cc: Christian Brauner <brauner@kernel.org>,
	viro@zeniv.linux.org.uk,
	jack@suse.cz,
	yuehaibing@huawei.com,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH-next] epoll: Remove ep_scan_ready_list() in comments
Date: Tue,  6 Feb 2024 13:55:49 +0100
Message-ID: <20240206-ortskenntnis-ruhen-40acfcab93a8@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240206014353.4191262-1-huangxiaojia2@huawei.com>
References: <20240206014353.4191262-1-huangxiaojia2@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1064; i=brauner@kernel.org; h=from:subject:message-id; bh=aHvoIMhqHK8Hz7ZDSGrgTvvDulv0b0MKQAO8XzbAZ1c=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQe0sl88yZk/9oGPneWC2XhBfdL/kxvfS9nxNDoVrnor EbFpNWnOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACbyu56RYdX9x5U1/SflJ727 Gm2yu4CnMXFGyPolzDttWzsTzdVrfRn+h07a+ENFqprr5vw2PsEOw50M3Jl6nUcqvHUNljuzMz5 gBwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Tue, 06 Feb 2024 09:43:53 +0800, Huang Xiaojia wrote:
> Since commit 443f1a042233 ("lift the calls of ep_send_events_proc()
> into the callers"), ep_scan_ready_list() has been removed.
> But there are still several in comments. All of them should
> be replaced with other caller functions.
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

[1/1] epoll: Remove ep_scan_ready_list() in comments
      https://git.kernel.org/vfs/vfs/c/91d5bbf6d41e

