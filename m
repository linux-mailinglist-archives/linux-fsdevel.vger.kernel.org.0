Return-Path: <linux-fsdevel+bounces-28046-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40C9D9662BE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2024 15:16:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F157028321D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2024 13:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3AA519F47E;
	Fri, 30 Aug 2024 13:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UtBUP4m2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A9A1DA26;
	Fri, 30 Aug 2024 13:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725023810; cv=none; b=q9Pp9KjhzPJHSLZsP9fBXL1c7o2EOjOoVoEXZo0MGnIBZRejHV7sj638SATaHROmMXbli7CJSpyRXjgve4gxzrZzRKT31uhnXvvFDNvrqwaTYsbzaIQZ4OfRLu+f4ycfwI4NrrixHsW2XOnGY8Ol3lykzamMXsbgMoTCi+IF/cE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725023810; c=relaxed/simple;
	bh=Dl2L9NwIDprqdBAnezOUz3Rk1CiM63YZoF5boaYplEM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Pvy5jdp3uF2PsNCxslx5PCiaT9ZCzOITFkArDm8UTLaCMw6LDgYPIUssEBiUFxeekn+DcHsZwCuXXNON1gx2VNRvAH5Xn9pWSXsO/S4WtdL1HNXtk4LqUS7gtJ7wbCS5ScvjnMjI0+QFe8pxrxo3yDm1T3+fXDWjGI103XHGNpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UtBUP4m2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C76CC4CEC2;
	Fri, 30 Aug 2024 13:16:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725023809;
	bh=Dl2L9NwIDprqdBAnezOUz3Rk1CiM63YZoF5boaYplEM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UtBUP4m26ZglaB/yBHijKEC5ndJpMYCkd+Bk/eTMzhuGZVJs2wSB20uZf/HCEzt/i
	 d7D/l8ZFneX2NOjvZI4o2ghYahfmhBfNuY8vadMu5bRLsv4dWkVjPOWKUR7hnXWpjz
	 zInFFRBCiPfSfrnP5+Z7SMVSK4cvKQS57RvYbt2fOtCU3kQt/5gLWgSQ79MP2v1Pbb
	 Sysu3+p1ZOjuCEyj3b1vfohX97EaYQ7tesrcKd7rM14AVWwk4ccWPBYg07A7qJoxxD
	 bORX/XCdPotcE3yel8tRYi2AeVI5zqrYT90IATBXLHf6vnRYEGfEyHXAEzSFjIN+xN
	 tVLcwhXd1kR7Q==
From: Christian Brauner <brauner@kernel.org>
To: dhowells@redhat.com,
	jlayton@kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Cc: Christian Brauner <brauner@kernel.org>,
	netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Simon Horman <horms@kernel.org>
Subject: Re: [RESEND PATCH] fscache: Remove duplicate included header
Date: Fri, 30 Aug 2024 15:16:32 +0200
Message-ID: <20240830-pillen-skifahren-57714a89d21c@brauner>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240628062329.321162-2-thorsten.blum@toblux.com>
References: <20240628062329.321162-2-thorsten.blum@toblux.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=875; i=brauner@kernel.org; h=from:subject:message-id; bh=Dl2L9NwIDprqdBAnezOUz3Rk1CiM63YZoF5boaYplEM=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRdPGbJ8TS3t5O/bc3RYp4YU2bxPVsuJC+f0vXq67YbA tPz2JrVO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACbCE8rIcEM7odp+ypzESyqH koRd9k5/dCAizcNKy8vxfKeXb4xMEMP/mhkXODiCguM+7Vq4XWZl7lX9YpPND5Y0lorYH/nRXvq PCwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Fri, 28 Jun 2024 08:23:30 +0200, Thorsten Blum wrote:
> Remove duplicate included header file linux/uio.h
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

[1/1] fscache: Remove duplicate included header
      https://git.kernel.org/vfs/vfs/c/007d218b7ee7

