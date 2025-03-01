Return-Path: <linux-fsdevel+bounces-42877-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D5CFA4AA07
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Mar 2025 10:28:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E69A174445
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Mar 2025 09:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48D4B1C5D79;
	Sat,  1 Mar 2025 09:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kXU9sCpe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C70B189BB0
	for <linux-fsdevel@vger.kernel.org>; Sat,  1 Mar 2025 09:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740821320; cv=none; b=MvLLpHtdkA6L9xWU+H2bKZo3n+HjNKQYlb2zKahH41+UFkIHcx6lifEERJo1dhTu1eIIIBB9VbPQX6deb5DFlt7V73GJQ9qav0/zumR6F658uSh7H6woVZOTxYyAvOnv7v2m9/DbfjHtz/YFIIZ2Az5DechvvndbZq06oKGtuGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740821320; c=relaxed/simple;
	bh=8+u+gVADQ4e9hYi4b5ye6sjPEsS6djXHzBKpLEt98MA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lQfRykHnOF/yy2Wq0M9sR2gRATyVKUMFARg8v3NocitZJO6WTpa9TD4qqi3Idyx1g0YjWG7CpaT0a7Uqe3IGjjpch3Zimc8XxBH3c4QCOBO3gpZQ092UbEGz8aM2gw0bFijtyzloQIXBCqJmnVOeOcNiENGmddrtyejEil0OEaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kXU9sCpe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6192C4CEDD;
	Sat,  1 Mar 2025 09:28:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740821320;
	bh=8+u+gVADQ4e9hYi4b5ye6sjPEsS6djXHzBKpLEt98MA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kXU9sCpeCb6rovQhoZc1G/6EuOu48GuJVrurbGKmttfPrMtRTgDRIgWCPD1pCdxya
	 Fi7cpR1kl49cRs6lvPNIN07WZtob7X3oVc8zaHoR/qSOAjp7SDQcLA/7JUpjwZCpan
	 MDZyzl1RWLqco0UjvV5caR6cEyrnW5qAjL8Vecp0gvzzuSisp0F/vf/w7ScU8qZEsp
	 XaB1COXBijaZxMFki3+/H5qs8F5XfDWrBtFm8/Iv4H0zOsuWUNjWMfN2I4hhtuetax
	 IOgqDPPAXxn/Uf7H2ZzUj8l/fiJpPsyJAmnZNCPs1JPVFaL5Kd3uHu9mijHb0sNFAV
	 LADFRY3yLaaEA==
From: Christian Brauner <brauner@kernel.org>
To: linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	Eric Sandeen <sandeen@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Tyler Hicks <code@tyhicks.com>
Subject: Re: [PATCH] ecryptfs: remove NULL remount_fs from super_operations
Date: Sat,  1 Mar 2025 10:28:34 +0100
Message-ID: <20250301-latten-unlogisch-7a59c9bcf245@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <5dc2eb45-7126-4777-a7f9-29d02dff443f@redhat.com>
References: <5dc2eb45-7126-4777-a7f9-29d02dff443f@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1102; i=brauner@kernel.org; h=from:subject:message-id; bh=8+u+gVADQ4e9hYi4b5ye6sjPEsS6djXHzBKpLEt98MA=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQfuuz8kKWurVzxsmrqqfqkHa5qp+WVS6dJTH3qJWnM+ C3vgeb3jlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIkcl2H4X8jPsDJz22zB+Nc3 76xYeM+CW50r/HWny7pbnBsexvlM42NkePL8S6gEkx9H8t4AQ+MHvGuFkn3r/j//8VKQsTPRLJu JCQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Fri, 28 Feb 2025 08:31:17 -0600, Eric Sandeen wrote:
> This got missed during the mount API conversion. This makes no functional
> difference, but after we convert the last filesystem, we'll want to remove
> the remount_fs op from super_operations altogether. So let's just get this
> out of the way now.
> 
> 

Applied to the vfs-6.15.misc branch of the vfs/vfs.git tree.
Patches in the vfs-6.15.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.15.misc

[1/1] ecryptfs: remove NULL remount_fs from super_operations
      https://git.kernel.org/vfs/vfs/c/46bbe45bef93

