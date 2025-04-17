Return-Path: <linux-fsdevel+bounces-46612-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 02B05A91642
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Apr 2025 10:14:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DFEE19E12CC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Apr 2025 08:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FC9822DFB2;
	Thu, 17 Apr 2025 08:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cld+u/Jc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D31FC225785;
	Thu, 17 Apr 2025 08:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744877644; cv=none; b=CdnLV2dBjOtpmTnbJtwEGZN+VJ19/SjoAcSLeC0vzoxEPJXAd7Lt3kXVz5e9H22xVBv/y3Gdpa1DmcOIGPTGTXKnnd/NPa6bKcxwspuXOeF/XZm6SlTlJG6YXT0Su8TK89UBzlClFqLPr+Gd7VGavufOGTJouJKhgUbUje12sEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744877644; c=relaxed/simple;
	bh=MwepOx7zs2heluVdedWctNgQH1Q2ccAbcwPdl6bA4tw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fTo5XhYMM+t6vky5pnzcFeE92fcMImw2anAm8+0GPAHXNcqnjkV++JWvKC7B+kc/Tn8HjUXP3tDkJkZx8HUASjVCRjiia8ea17BQTzFiJ3Glab4sPdp+Nvios2hfXpnMYYqq9+xaKw1C+cl3sOv8bub4guNWE2TPZQHm3kUbco0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cld+u/Jc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BE08C4CEE4;
	Thu, 17 Apr 2025 08:14:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744877643;
	bh=MwepOx7zs2heluVdedWctNgQH1Q2ccAbcwPdl6bA4tw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Cld+u/JcLCjQWyrbdYUIkrIg1xfu7iOwxBuvjfwhvqCVcPHsz/LMH28VMEpv/8TqL
	 NIORsv1kGbMwhKtx8lFXopYH1tJUpqLqK5dwFT+oTfokwGgSHAgRliQJh37bE8A0YJ
	 wnxNTGWwF0bhH+4TqxuJylD0cuyd+i0AJPtvMZY94gmeacL6ZlZYhrjgJOWOvTBsHk
	 GBMNhSKM1WjQuslSganp33+9nl4+IWnolDyHfrEhvt+4dHXysan2LC22CirdgTNTSJ
	 HpwXfS05v3BgJl0fbRuOHTDx6xR8WmDy89GVwXRbnnq2qsug3QFHTbaiThsvwcee5m
	 1dCKgFX8SFp4A==
From: Christian Brauner <brauner@kernel.org>
To: David Howells <dhowells@redhat.com>,
	Kees Cook <kees@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Paulo Alcantara <pc@manguebit.com>,
	netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] netfs: Mark __nonstring lookup tables
Date: Thu, 17 Apr 2025 10:13:57 +0200
Message-ID: <20250417-manchmal-verbal-7f84877a2c63@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250416221654.work.028-kees@kernel.org>
References: <20250416221654.work.028-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1839; i=brauner@kernel.org; h=from:subject:message-id; bh=MwepOx7zs2heluVdedWctNgQH1Q2ccAbcwPdl6bA4tw=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQw7HDzmua4Xa0lvovN5u2fGmlee4v3aQs+ya7dvmHP9 v0J9fccOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACYio8Pw33OzUMSFtfrJGuun rtU1KT7U/Yrvfr3W78DfSt92vb82rZiR4VpwYe+Gtau6o9f/Nay6ZfXz2d+uh8oXKmau8WIUeK1 +jRsA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Wed, 16 Apr 2025 15:16:55 -0700, Kees Cook wrote:
> GCC 15's new -Wunterminated-string-initialization notices that the
> character lookup tables "fscache_cache_states" and "fscache_cookie_states"
> (which are not used as a C-String) need to be marked as "nonstring":
> 
> fs/netfs/fscache_cache.c:375:67: warning: initializer-string for array of 'char' truncates NUL terminator but destination lacks 'nonstring' attribute (6 chars into 5 available) [-Wunterminated-string-initialization]
>   375 | static const char fscache_cache_states[NR__FSCACHE_CACHE_STATE] = "-PAEW";
>       |                                                                   ^~~~~~~
> fs/netfs/fscache_cookie.c:32:69: warning: initializer-string for array of 'char' truncates NUL terminator but destination lacks 'nonstring' attribute (11 chars into 10 available) [-Wunterminated-string-initialization]
>    32 | static const char fscache_cookie_states[FSCACHE_COOKIE_STATE__NR] = "-LCAIFUWRD";
>       |                                                                     ^~~~~~~~~~~~
> 
> [...]

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

[1/1] netfs: Mark __nonstring lookup tables
      https://git.kernel.org/vfs/vfs/c/58db1c3cd0ce

