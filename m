Return-Path: <linux-fsdevel+bounces-14454-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B939B87CE1A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Mar 2024 14:31:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EACA01C2105B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Mar 2024 13:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 440D828E02;
	Fri, 15 Mar 2024 13:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WvhlQWHa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FEBC25760;
	Fri, 15 Mar 2024 13:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710509463; cv=none; b=qaj8lRkYrlYW4n0SsssnBx5WZq4kBVRtXdHixE9Ncgt3obVvO0lklnl8qeIC8EqmaUIMY6Un7mPRxnr0BoZnFblzV56PF89rjAqhGtSY8hkw5RD1+G8edpFBFxQqR5T6sY5zvBFhfEC5jklyBfm8NYMutN+NZialAFvFbaO3x/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710509463; c=relaxed/simple;
	bh=TCAvTPDDyMtBOpDF5RzJopMQnVJK92lEuN5mqBZOkvc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Mg1JcciekbsLky4Pz+xILvhKNNPmXVM3fm4wpD4r3+TxLDNY4YcSGqMQU7xS2ESDhl/yJrUyUJEWMo5HmfkQ+9dD6tzNbe9cIbm35wyxs3p93mGlxTONHMLoBZYLlj/OAnRRwh2f6undQloWKosd68jX3uXxCu5d4vV5IPfey40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WvhlQWHa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5E0FC433C7;
	Fri, 15 Mar 2024 13:31:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710509463;
	bh=TCAvTPDDyMtBOpDF5RzJopMQnVJK92lEuN5mqBZOkvc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WvhlQWHahq84Nj1PeWqopYGv9pkIJUxmw9Pc5mkM2Iobus9QknFWd1vyqdbTMdhsy
	 3ORzBSfFUKRb++HwJ9TJXsFAyMs3VuG8qkul0URvQn6hxoUhDDaMFy/WcVR5SVMwTZ
	 ePkoo72H38qgvqCl4VDNMWrgmeD3zgT/UrvpONo5norAB13qfl/606aXUn+kZHupsy
	 74VCCKuGRNEMBRavv5tzIy7nVaJc5PyY2nzXp3wWxP7CnrdVbRoDVnMxKitjMz+pgd
	 /RrdfwufNJeOeN1ftj4iOmpF+IJSxnrLWT0mRzPxbc+lXfvHSyVUbNHcmsRMNlHJ9E
	 ovkcbZDbUkvjw==
From: Christian Brauner <brauner@kernel.org>
To: Yang Li <yang.lee@linux.alibaba.com>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH -next] fs: Add kernel-doc comments to proc_create_net_data_write()
Date: Fri, 15 Mar 2024 14:30:56 +0100
Message-ID: <20240315-bitten-feiern-95b68a84b3a9@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240315073805.77463-1-yang.lee@linux.alibaba.com>
References: <20240315073805.77463-1-yang.lee@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=962; i=brauner@kernel.org; h=from:subject:message-id; bh=TCAvTPDDyMtBOpDF5RzJopMQnVJK92lEuN5mqBZOkvc=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaR+8Z2wRKjn/zOLXT2iy27Ozmg0tHPnvZK2JPPBh/4fG mcazNfN6ShlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZgImzsjw8bH55+kZRy9u8dg x71bry29GPsPa7tK/V66+fEtF5fFV04x/DPffLJ7bXFQnabeTg3xTt+7Wf+f702aVmVW/iagJOz ecx4A
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Fri, 15 Mar 2024 15:38:05 +0800, Yang Li wrote:
> This commit adds kernel-doc style comments with complete parameter
> descriptions for the function proc_create_net_data_write.
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

[1/1] fs: Add kernel-doc comments to proc_create_net_data_write()
      https://git.kernel.org/vfs/vfs/c/18326d197204

