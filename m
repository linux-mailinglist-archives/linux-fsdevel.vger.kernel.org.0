Return-Path: <linux-fsdevel+bounces-44325-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ECFCA67631
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Mar 2025 15:21:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E1DD188BA5D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Mar 2025 14:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA6F220D519;
	Tue, 18 Mar 2025 14:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aIyQTLZR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55BB91C5F06
	for <linux-fsdevel@vger.kernel.org>; Tue, 18 Mar 2025 14:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742307263; cv=none; b=aw5UXB5R2SDpSXqB+vyh14zD7VV6knu/c03KrnjzA4qAcyqcskz8+GK6G6xJ0GoydbpfluywOIec4hcSvwx7Rx3iNi3knuLUc8JRRfHDdSfyknuX77jHpbsf5coqysl634tMZeL2SpCX2Nr25Nn2rwV8e2+PKko50o90xQ1BiQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742307263; c=relaxed/simple;
	bh=AQwH42Wm/E0TYByet/X5NRm37bG7Jx1YO9VWk+Cy9oE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oF5hHx7g/Etc8Xd4EgcsJfzA57Bw+34vXDn0MGoSKCeU1gYrlckD2NdlWmsQxpvmR3XF6kop2mtLk5x4jssN5gqMwi0zZj+VWrheL+zV5EG03bsFo/KxCq/TaZOZhw9ougkjtTVGJiKCUiTkrQUib26RvTqwBXctHbrq+mdKZqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aIyQTLZR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59A9EC4CEDD;
	Tue, 18 Mar 2025 14:14:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742307262;
	bh=AQwH42Wm/E0TYByet/X5NRm37bG7Jx1YO9VWk+Cy9oE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aIyQTLZRLSQZGY9Q2/yN9j+mylVVvSYRVcpukHf73yLsOiTeeiFCVbayRQFdBq/q7
	 gD2vIUoG3u1niMkpCNBQPdV4/Dgsb3RFNx1BFPgAnM8W2YtSKoKVUmrEAqCZtRAQNF
	 koJHqYCRhqHP6J3LF9N9/WfrYLND35DCe8QOUHhFu2T+z9dibB/Au8tBnzBYvrD9jH
	 FwGUb6T8Rtku8T4ha6C7BT4K1CudJ8BSRmPj2xwsWHXryFtLWYyfKuBCzaAsOUCrpF
	 22wMXVPUpuA8BhrIaxSnINY+YVRta6bgehbj0Xkm8ff1S3+XeVZR8ouXE72EzsHGiR
	 RR+hLHh2+ip/A==
From: Christian Brauner <brauner@kernel.org>
To: David Disseldorp <ddiss@suse.de>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] MAINTAINERS: append initramfs files to the VFS section
Date: Tue, 18 Mar 2025 15:14:11 +0100
Message-ID: <20250318-zuallererst-herzugeben-c5863bf92869@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250318040711.20683-1-ddiss@suse.de>
References: <20250318040711.20683-1-ddiss@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1010; i=brauner@kernel.org; h=from:subject:message-id; bh=AQwH42Wm/E0TYByet/X5NRm37bG7Jx1YO9VWk+Cy9oE=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTfrN95ZtebGbOynq7+/nqbzTn+DO17Cg3z1+Xs1blsV mkw+6PH7I5SFgYxLgZZMUUWh3aTcLnlPBWbjTI1YOawMoEMYeDiFICJJD9i+J97b5lQOp/WwqfS NrNVF6kb6zEu/nNv5vtd+xTFK74rWnky/I8w355x5UT6g00dv+/mnpuqwrzph0+9kM9KJa57Fnt tktgB
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Tue, 18 Mar 2025 15:07:11 +1100, David Disseldorp wrote:
> At the moment it's a little unclear where initramfs patches should be
> sent. This should see them end up on the linux-fsdevel mailing list.
> 
> 

Applied to the vfs-6.15.initramfs branch of the vfs/vfs.git tree.
Patches in the vfs-6.15.initramfs branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.15.initramfs

[1/1] MAINTAINERS: append initramfs files to the VFS section
      https://git.kernel.org/vfs/vfs/c/0054b437c0ec

