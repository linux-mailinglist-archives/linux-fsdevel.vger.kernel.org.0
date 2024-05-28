Return-Path: <linux-fsdevel+bounces-20340-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DCF68D19AB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 May 2024 13:35:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED3B0280F95
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 May 2024 11:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34AA516C879;
	Tue, 28 May 2024 11:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jqZiX/QN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 881BE16C85B;
	Tue, 28 May 2024 11:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716896082; cv=none; b=j5tPMZkSxnPxBHn/N9VN9DlWjHUmuDtJ7GlYsyDPE3lhjxCN2xZyUTm4WjsLyi3SUYXCNHN570fbX9j4R+4XDElDb8l6cF1/TG6XeT6bJi95efeS3WgCtikAQTiy2qE7W7Q/CMDkJ2tLpmEnkTqEGf0l8hhOs2wkeqt/INEPfyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716896082; c=relaxed/simple;
	bh=9wGuHehGZ7Wo4wMIu99WxMw87OmZSZO2EPyqVpgkf2I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qlxWMCR6bDf0pdcmdcYfZfGaPASier2rd51kHFVOxlWAgTPWHVZJI89zd07LpxObIfuxSpk7LoHkEy6db6D9UUgQJHS7r6rknwZEgOGX8yCyMMqK2WvSqsoY3mwh30iPLdd7uOrGKzE+9dXO/SgheoR3gVU0nAul1A9baegTxGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jqZiX/QN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56F1BC3277B;
	Tue, 28 May 2024 11:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716896082;
	bh=9wGuHehGZ7Wo4wMIu99WxMw87OmZSZO2EPyqVpgkf2I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jqZiX/QNADwaqFb4PkQw2ythPLEnt9ZL4nNfdZGbgR0GeGXOMGktu2ZN4MSQm++M8
	 uSx9ev6S/3odjVwcqsNXBLB9CNI/BrSVPYQZ2sHrCJUkOyh+cqINKUKJmxvyPdXL/N
	 v8xqxexxvZDIoLF28NW8VMS4QvYsF0typq5soeZfSs331sA0//32qdXban1M/slOmN
	 zJenUlKiGPg18WUCbtnc/TK17IwnWstvFQ+lz723oBPOclJ1/QBPu+0lPRfSmZAFEZ
	 BPzLi60+mu4L73AGDPy2uql0M0U/kxp0/P3m1zMk/mjPjftKsHpFUTgmx3lSgRz9E3
	 FUTDMW4aVot/w==
From: Christian Brauner <brauner@kernel.org>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
	Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH] fs: fat: add missing MODULE_DESCRIPTION() macros
Date: Tue, 28 May 2024 13:34:27 +0200
Message-ID: <20240528-februar-astronaut-3908de3fa2c4@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240527-md-fs-fat-v1-1-b6ba7cfcb8aa@quicinc.com>
References: <20240527-md-fs-fat-v1-1-b6ba7cfcb8aa@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=997; i=brauner@kernel.org; h=from:subject:message-id; bh=9wGuHehGZ7Wo4wMIu99WxMw87OmZSZO2EPyqVpgkf2I=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSFHvS8GG/KVnP4X+v7OYuFWu4fmsOQk/543/G9zf/dt 6btieVa2VHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCRTT2MDCfXTncMu/Tkypev 8ucEtR1kUuZ+9e659euEotCx7d0zQkUYfjF/PF4X5jyL786a8NTiXLtPe7fyaP5u/pCkwZdz8HV lHAMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Mon, 27 May 2024 11:00:40 -0700, Jeff Johnson wrote:
> Fix the 'make W=1' warnings:
> WARNING: modpost: missing MODULE_DESCRIPTION() in fs/fat/fat.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in fs/fat/fat_test.o
> 
> 

Applied to the v6.10-rc1 branch of the vfs/vfs.git tree.
Patches in the v6.10-rc1 branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: v6.10-rc1

[1/1] fs: fat: add missing MODULE_DESCRIPTION() macros
      https://git.kernel.org/vfs/vfs/c/9101026fc35c

