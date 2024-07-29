Return-Path: <linux-fsdevel+bounces-24422-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AF6593F369
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jul 2024 12:58:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11B081F226FB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jul 2024 10:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96E9614535D;
	Mon, 29 Jul 2024 10:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FTnr8hs9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1EAC145336;
	Mon, 29 Jul 2024 10:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722250705; cv=none; b=pavgfnQsj1hVzb4uJ58hPlj1jqIxXauoNHnThUXNbkhf5ZvJ560vbANzFNTaq633NthtiB2GJsCHThYrcE08+tAudE0IF/cs6Gcxxf/X3IDTdXggla+GjiK/0qgT33UUUzamYpM0h3KAyP24dBDOZE/j0r1JLY/HUpeivv4ub64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722250705; c=relaxed/simple;
	bh=fiO7i6mqpUoxi+7/v5/Nsp0Jyzn13Vgei+tT64/9Oc8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=da1QrJdUy2dgygn7+b1HL2y1VIS2m8MlhXQ386Qtrmf26R6z3oh2OzGzAdD2BWQ7z4Ma9Jg57KLwSeU+iReKO64QCDuaotvA0xHRMpcfKjwhOuQUSarXtgdp8fUh/HnU4bw90wDjnGxlwrx1NClVDSC4TAkjFGisC6/JtFXSj+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FTnr8hs9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28353C32786;
	Mon, 29 Jul 2024 10:58:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722250704;
	bh=fiO7i6mqpUoxi+7/v5/Nsp0Jyzn13Vgei+tT64/9Oc8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FTnr8hs963bf+s/GC/SiQ3wKb4CybEglWNWxa2vPrt/dDL1h4RUK2idHolx96Imob
	 iaOn8wn4bERXPvtHGz60oiNa096GpUa1jh+4x6uMm5AmqFkDPspLb3wYDIJQ/kWvSj
	 ZCVaGMBB70acehcIQW/029V0EFKJH8Dlsl7nmfRIqw5b3DgC1+r20VPUrePG1+C+LW
	 H8qHOUKPTt2MMwRp14PGL4eWiYWlm3hox35PAefTM4dpoL1LAoqKHg3/2jupBboFTL
	 V3inzvMN4PBetFYLf1GLad6SrAA6qTuukIVoppF4JF1GNiKMXpPhTix6miH3eWUQJL
	 0UjfhM7s42CZA==
From: Christian Brauner <brauner@kernel.org>
To: mohitpawar@mitaoe.ac.in
Cc: Christian Brauner <brauner@kernel.org>,
	jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fixed: fs: file_table_c: Missing blank line warnings and struct declaration improved
Date: Mon, 29 Jul 2024 12:57:58 +0200
Message-ID: <20240729-ausnahmen-wohlverdient-24693ce88363@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240727072134.130962-2-mohitpawar@mitaoe.ac.in>
References: <linux-fsdevel@vger.kernel.org> <20240727072134.130962-1-mohitpawar@mitaoe.ac.in> <20240727072134.130962-2-mohitpawar@mitaoe.ac.in>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1052; i=brauner@kernel.org; h=from:subject:message-id; bh=fiO7i6mqpUoxi+7/v5/Nsp0Jyzn13Vgei+tT64/9Oc8=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQtL90V9PtY1yxO7vWn1RRMnr89qTlR+rDJy59i9vzep pNCjx+c2lHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjARM3NGhi0PfdcfXPxntr1U +NxHv/3ubv93r7U67uyaVTqLTUo7D7AzMkzNkjueIHXiG6/2i38pR/zu1ty5cyPPf+P6J2+2qwl pW/ECAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Sat, 27 Jul 2024 12:51:34 +0530, mohitpawar@mitaoe.ac.in wrote:
> Fixed-
> 	WARNING: Missing a blank line after declarations
> 	WARNING: Missing a blank line after declarations
> 	Declaration format: improved struct file declaration format
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

[1/1] Fixed: fs: file_table_c: Missing blank line warnings and struct declaration improved
      https://git.kernel.org/vfs/vfs/c/0268eb6ea276

