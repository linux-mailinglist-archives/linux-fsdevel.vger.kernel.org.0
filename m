Return-Path: <linux-fsdevel+bounces-2055-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2C397E1D6A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Nov 2023 10:45:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 309ED1C20A7E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Nov 2023 09:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6322C168BB;
	Mon,  6 Nov 2023 09:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EDZDQEBa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A40B6168A2
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Nov 2023 09:45:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4675C433C7;
	Mon,  6 Nov 2023 09:45:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699263927;
	bh=et0OCr+qDn8wpjs1cec6Sb6UBE9WlgRpffILQ++T6F0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EDZDQEBaenQW1sF5NrILU2QAUpTDu5izJcNNRQ9rYSx3lsITCU8t8AtAoSZn7DX2X
	 mLp/EoOJ5kxJWxOjamRoezTDegvr+EGmv7LuiZuJ9JLABrQYRPV1DjjmzFzcUyLxnV
	 np2TztVzOPNEtZVrcbE3qCjQFOL68VjE76SaM//Mz0nkNR4ZTMe8N9dHN7pl4Z/0Rg
	 JPN784dLF7ARN1fFi7odTAPk3vulgNq5qma9X4fDZoGBlCnB9Q0PHU1rr3zD7x0lQW
	 yOeznv1OUT/dyL2gt8OGmmDYupP9nW8dhUDA6KXCNP1S0mtRT4ZjpDiA+hw41+Oy2s
	 YEIADcSL4netQ==
From: Christian Brauner <brauner@kernel.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] vfs: remove a redundant might_sleep in wait_on_inode
Date: Mon,  6 Nov 2023 10:45:19 +0100
Message-Id: <20231106-binden-rundreise-cf5e2f10cb4a@brauner>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231104221117.2584708-1-mjguzik@gmail.com>
References: <20231104221117.2584708-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=862; i=brauner@kernel.org; h=from:subject:message-id; bh=et0OCr+qDn8wpjs1cec6Sb6UBE9WlgRpffILQ++T6F0=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaR6bF19puPqtb3ndTYckuYIOnVo9b3VyncXlCu7RT24dDyg 1Gb/tY5SFgYxLgZZMUUWh3aTcLnlPBWbjTI1YOawMoEMYeDiFICJbLFiZDjG/bugOfKl9pd/1z3mBm d/aJ73a86ZR5su3DETvq+7t1GCkWF9eMLk4ymavE1B/YH6KSZtj6P1Y56mVDmk96nHqszZzgEA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Sat, 04 Nov 2023 23:11:17 +0100, Mateusz Guzik wrote:
> wait_on_bit already does it.
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

[1/1] vfs: remove a redundant might_sleep in wait_on_inode
      https://git.kernel.org/vfs/vfs/c/357196038a51

