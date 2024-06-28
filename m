Return-Path: <linux-fsdevel+bounces-22744-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAB1491BA4A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jun 2024 10:45:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 274921C22603
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jun 2024 08:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C0C114B963;
	Fri, 28 Jun 2024 08:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m7qIWgsv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E6B1494BD;
	Fri, 28 Jun 2024 08:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719564304; cv=none; b=IAWkMxWUfP3dicb+3ndXmXvw+DsE4cob5KPXrLMZirP1M5wDn1qefIhl2rLMkRo84vY7/qKVWsw1qN7XMbicoLvLhq1zEkSSnGz5/hnNMcVdQxvW/s4PHDEY9GdFRq1oY55mf/GOPzU44QNIhWdpDgrZ3u3a8LOwjqiwxg8a/7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719564304; c=relaxed/simple;
	bh=cC+EmC/4LJL8p72CmY1W0gVCgYZuQXFrJjllOON5cRA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I2SV47NBksLZQURSEsnzz0yWAhXLaIoKI2T6a392ACBtYRoq4wGhDwBt74HRbJZTujAyVmR4lvddNC9zyTdwqyP9V1WAxl+ycfrDtFOIYqgEjko4EJYgiGti5J1e6EdaOCstjuhItlHtUJhRiMUsCji1m/Xcz8KzhfgUl1pqcu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m7qIWgsv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30415C2BD10;
	Fri, 28 Jun 2024 08:45:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719564304;
	bh=cC+EmC/4LJL8p72CmY1W0gVCgYZuQXFrJjllOON5cRA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=m7qIWgsvfXgM9EfkQoo4XwC9oblZQYOndBTwObvOBSEpKlv1hqwUmC8WIwC+uUwhj
	 fPi0A+F8+UTMhv5adgBduSp/iQ9tsG25sPkZWAdBwOMFQIM4dBHcgqV4KT0R1BChnZ
	 x9ztdGaoiruXo1Bvg38CM3/ElbcSkj8+7k2Ug+vCh67Rvw6fVK3gsV+VkgWwKk8SUQ
	 wglMYa4NdaGaXlw1/TXCyc9OJdG8E5bkft0QkF4C1meC9pz8TyuAbPJBLcwKlsJ6Fb
	 /xZCr/2/ichN8f2kBD2PRwUWmLZgg2bFsElL0vI0YBENV1d4Kz0iBxjR3kUwsdQiyz
	 B7viv6honmy7g==
From: Christian Brauner <brauner@kernel.org>
To: Thorsten Blum <thorsten.blum@toblux.com>
Cc: Christian Brauner <brauner@kernel.org>,
	netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Simon Horman <horms@kernel.org>,
	dhowells@redhat.com,
	jlayton@kernel.org
Subject: Re: [RESEND PATCH] fscache: Remove duplicate included header
Date: Fri, 28 Jun 2024 10:44:48 +0200
Message-ID: <20240628-dingfest-gemessen-756a29e9af0b@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240628062329.321162-2-thorsten.blum@toblux.com>
References: <20240628062329.321162-2-thorsten.blum@toblux.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=875; i=brauner@kernel.org; h=from:subject:message-id; bh=cC+EmC/4LJL8p72CmY1W0gVCgYZuQXFrJjllOON5cRA=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTVVbC/XetzVnouV5jIohsPF5wuCc5qiy//vNJj+d+5Z vO2q1U+7yhlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZjI3UWMDA8fTtys4m12aFPF /P9Z4cKMrdlL5zIIxayRfCquXi+qHMPI0Dano09f8tp9i+wYBZ3Cxc/us4oY31/w9reBlc4E847 3rAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Fri, 28 Jun 2024 08:23:30 +0200, Thorsten Blum wrote:
> Remove duplicate included header file linux/uio.h
> 
> 

Applied to the vfs.netfs branch of the vfs/vfs.git tree.
Patches in the vfs.netfs branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.netfs

[1/1] fscache: Remove duplicate included header
      https://git.kernel.org/vfs/vfs/c/5094b901bedc

