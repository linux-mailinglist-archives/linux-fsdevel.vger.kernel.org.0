Return-Path: <linux-fsdevel+bounces-7615-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB66782880B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jan 2024 15:28:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECA151C243FF
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jan 2024 14:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D8BA39ACC;
	Tue,  9 Jan 2024 14:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PtJmAIXF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A63C339AC0;
	Tue,  9 Jan 2024 14:27:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7681FC433C7;
	Tue,  9 Jan 2024 14:27:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704810469;
	bh=5UKutk+ST+B6lxLgZc3b+MyL/xXT4h1umGkakQFzmn0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PtJmAIXFOXHRxRTjpft2PmPErgltsZmhAjEByylyN+TPbLoDprQzs8rEDSnzbKN0H
	 9yJIXIPF5o1FbOPcBKSssCpzKGrPQ7RX77M1MtfQVaxnOA6URaVU/C24QD5MtIzfZ8
	 gsxtIHXRLvqc6+QMv6Zzykx1NerEkTlCZIW1ZaLPiSeJh5ADNoeffYBVbs8Q2+hCDk
	 m2y3M/kcfBwTDpFv0siu+kS/X0lxMSq9oSBhC07sw/IViFstTrZk/jeZI2DImhliPi
	 4KXN1MBCEuaN8hca5SLJ0MSspDeAvJvNFbu5zdEO8IarsI4rqaqj80gmPt0uN54fcH
	 lTe+s4ksOGAHw==
From: Christian Brauner <brauner@kernel.org>
To: Jay <merqqcury@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	viro@zeniv.linux.org.uk
Subject: Re: [PATCH] fs: fix a typo in attr.c
Date: Tue,  9 Jan 2024 15:27:04 +0100
Message-ID: <20240109-amtssiegel-erdboden-02a6731745a9@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240109072927.29626-1-merqqcury@gmail.com>
References: <20240109072927.29626-1-merqqcury@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=839; i=brauner@kernel.org; h=from:subject:message-id; bh=5UKutk+ST+B6lxLgZc3b+MyL/xXT4h1umGkakQFzmn0=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTODb+hZil4+MT8F3lTbRJznToLutMFujIrEiw+VDyZy 3m8mS2no5SFQYyLQVZMkcWh3SRcbjlPxWajTA2YOaxMIEMYuDgFYCIl2xgZFoe66Lr91Aplyv1T vH9ZHus+gwZbGb//mncVtrvw3+2tZGT47n1mXXBZ18NHn7a8WsJY8eh+1jmrrKYtF8PmXVl9QZ+ LDwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Tue, 09 Jan 2024 15:29:27 +0800, Jay wrote:
> The word "filesytem" should be "filesystem"
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

[1/1] fs: fix a typo in attr.c
      https://git.kernel.org/vfs/vfs/c/6aad0d7ba166

