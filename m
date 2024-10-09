Return-Path: <linux-fsdevel+bounces-31469-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 19AB2997518
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2024 20:50:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FDBD1C21BBB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2024 18:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30A981A255A;
	Wed,  9 Oct 2024 18:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=krisman.be header.i=@krisman.be header.b="X5cRc5HS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F35FFEDE
	for <linux-fsdevel@vger.kernel.org>; Wed,  9 Oct 2024 18:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728499814; cv=none; b=ckBmKBXMPpmOW9ATFLk25AqvLQEIkEfKVp471fYvUMU8XMVz3LxDbNRUkzmcYVziYgRaDiyptpef4ymxRCU5f+GZqd3GvP8u8SxjwCXMkhWNkLJb3LFrDpt0dPDXTC3wOVyBAY57qJ75skWr8KkSZCQOPfYNjqfpoRuCYsfFbd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728499814; c=relaxed/simple;
	bh=G799N47IaQfA/S7q6IaKPCx0SFzQJmZCELJ5YbAHY7g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=McfAAAKw6miCujhntMLQGPn3Xc4YoJoGmVSIlY7OGLKE2ExBqGKB4+/dQz1ORrJSGaV5WNYGuQ5hCrtvWEXfx8qMQLeHGoXs2YL/BDyivyduA16qeVCegfAWuYZb5nbop3Z5MyI/CkHJ2QCDH5tJfqs77/eDhbhCDFVHzxMG174=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=krisman.be; spf=pass smtp.mailfrom=krisman.be; dkim=pass (2048-bit key) header.d=krisman.be header.i=@krisman.be header.b=X5cRc5HS; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=krisman.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=krisman.be
Received: by mail.gandi.net (Postfix) with ESMTPSA id 97AE9FF803;
	Wed,  9 Oct 2024 18:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=krisman.be; s=gm1;
	t=1728499810;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=3O9E9FJ9+pGPIMh7kjei1THyfGYU9CFhlYDekeb/g8s=;
	b=X5cRc5HSTvbUGk73K/WGzpm8jsonJuBIGOxDviGY6i2xKqxZVd8y7YX/bIR58Ko3WluDAe
	HdlRO0ev+motOydpMxTC/n2Zv1tRtXR1iYm9tOAcwOeD/1J8gX/VCylNKkesiWiaPHF2qf
	OrCFtccd/RC0dmcnDsYff2oZcPX3PR+XvgDPh6DMfhFAyVXptxKDy7CvfNgkkVBGXMaDOo
	Qbc0apJlt98YacrRahuZ/LzuQdHmdIomLaV9BiPB+JSBTsleAeBc4FQW8KSzNR2z9EH2D8
	svpG7nMZHt6NeBQyEhvvbQQ6kIIUSqeL+3esriKP0RcTCoXOaK3XcWfY9oLjIg==
From: Gabriel Krisman Bertazi <gabriel@krisman.be>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "Theodore Ts'o" <tytso@mit.edu>, linux-fsdevel@vger.kernel.org
Subject: [GIT PULL -rc3] unicode fixes
Date: Wed, 09 Oct 2024 14:50:08 -0400
Message-ID: <8734l5rtzz.fsf@mailhost.krisman.be>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: gabriel@krisman.be

The following changes since commit 8cf0b93919e13d1e8d4466eb4080a4c4d9d66d7b:

  Linux 6.12-rc2 (2024-10-06 15:32:27 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krisman/unicode.git tags/unicode-fixes-6.12-rc3

for you to fetch changes up to 5c26d2f1d3f5e4be3e196526bead29ecb139cf91:

  unicode: Don't special case ignorable code points (2024-10-09 13:34:01 -0400)

----------------------------------------------------------------
unicode updates

* Patch to handle code-points with the Ignorable property as regular
character instead of treating them as an empty string. (Me)

Signed-off-by: Gabriel Krisman Bertazi <krisman@suse.de>

----------------------------------------------------------------
Gabriel Krisman Bertazi (1):
      unicode: Don't special case ignorable code points

 fs/unicode/mkutf8data.c       |   70 -
 fs/unicode/utf8data.c_shipped | 6703 ++++++++++++++++++++---------------------
 2 files changed, 3346 insertions(+), 3427 deletions(-)

-- 
Gabriel Krisman Bertazi

