Return-Path: <linux-fsdevel+bounces-19462-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FBBC8C59F4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 May 2024 18:55:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FD211F224F5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 May 2024 16:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00C0117F389;
	Tue, 14 May 2024 16:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="on5xZ+uQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5913F12E7F;
	Tue, 14 May 2024 16:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715705734; cv=none; b=Hzuet8yC6uv1bWyPOz6rxVSmHavKZw/D6l7Sb3MaxDTKc3PspyYGkTcrzF0WJG2NRZuQlBLlpjI4MHU1cVBNeQv2w5gM/Dh3TAa8+dvGzyPzrrI6bzeOciZFVe2HsBFFvhD4GM2wwtMaYXqXCCNbjkNEQHyv7gQ7dr8zsf+jVIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715705734; c=relaxed/simple;
	bh=RcCpHcBXxFFCTloM2Ewr/gwuvTCPh3AICe59zua+0yM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=AgdJbiNfspXGHGfDyGGPygDrSCx9B2FcEXzXo0xX7PJJiLpvFjXO5d/sXGqp6OUJ/Pt8URjbI/fhPXnRFI+kzTPMXqfRJwTM93TVIErSUdhO9sViuOi34DUx+r+nNE28QqcW+aJ9zoU9fm9cJv/4+Fq6r2qWjb7ipyu5PIdsRxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=on5xZ+uQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2B20C2BD11;
	Tue, 14 May 2024 16:55:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715705733;
	bh=RcCpHcBXxFFCTloM2Ewr/gwuvTCPh3AICe59zua+0yM=;
	h=Date:From:To:Cc:Subject:From;
	b=on5xZ+uQdPApwyrZw+Nu0eiwRaACjMWnf6He/ipOh8FLu7qwEbcXFJsmlXJISu+5u
	 MQUbw12AAuG0ph4V+fx7GSQAkXay3Kz1ede9Vz63bTD2B4fljnyJO1eA5ek76vY0M5
	 MqBlLoqxWHWHtzAJjo9oh6hnJebUg+u4mW79vc1d/9QuY/eDniBYolA5WWK/4epizO
	 Fe7QkUpfXzR8xj1q8L1MKEmCaLluqrBtWEc3xAYHF2DPfuPW1KubMU1TD9H7a6is6l
	 viEBA7gkvk6gYktXgEbBmdoNTyjOaZrc88yo4Jb2jJzjeh+4Xpp0ghr4v0GMxu91RP
	 M04KWqlx6lBxA==
Date: Tue, 14 May 2024 09:55:32 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
	Jaegeuk Kim <jaegeuk@kernel.org>, Mateusz Guzik <mjguzik@gmail.com>
Subject: [GIT PULL] fscrypt update for 6.10
Message-ID: <20240514165532.GA2965@sol.localdomain>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit dd5a440a31fae6e459c0d6271dddd62825505361:

  Linux 6.9-rc7 (2024-05-05 14:06:01 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/fs/fscrypt/linux.git tags/fscrypt-for-linus

for you to fetch changes up to 7f016edaa0f385da0c37eee1ebb64c7f6929c533:

  fscrypt: try to avoid refing parent dentry in fscrypt_file_open (2024-05-08 10:28:58 -0700)

----------------------------------------------------------------

Improve the performance of opening unencrypted files on filesystems that
support fscrypt.

----------------------------------------------------------------
Mateusz Guzik (1):
      fscrypt: try to avoid refing parent dentry in fscrypt_file_open

 fs/crypto/hooks.c | 32 ++++++++++++++++++++++++++------
 1 file changed, 26 insertions(+), 6 deletions(-)

