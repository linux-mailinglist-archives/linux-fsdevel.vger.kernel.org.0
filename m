Return-Path: <linux-fsdevel+bounces-19839-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98F708CA3BA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 May 2024 23:16:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6E2D1C210D2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 May 2024 21:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92978139CFD;
	Mon, 20 May 2024 21:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="knDp39cv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2B8E134DE;
	Mon, 20 May 2024 21:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716239807; cv=none; b=XW8giz8da01eSOvqVoBO0lfMuZLDg5BDOg/UgS+hW7a8wgjP0D5muZQKmS1rcHFxWvYdPzvfrERYJ5g7q8EChQASM6XWVdfgLvFU59pAvePd9BN1LX4XKFGkH8e79LAKkQTWVahy9B/LdLahtsXjEAliz1gWiBoJxUVzMWC4pH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716239807; c=relaxed/simple;
	bh=i9sMlbAULR6WBF7z4CvLAk2CNyoAXyInKoTd0w7BUmk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=E1Co/qTVZaGXohbTugSkMGfEnEalNlPmOiboBaUpto1aksnujkwfT5+ZQ/ApfF+brXWF+JdN3N1j3poGWYIia/7Y0lgfqUJfSn6EvYZ5wBulSp9DtYm5r1HVm4cAFe3Wbh33qcBFBtrUZLXix/CM+9Y1YR7njf6ln7wg1eN+I9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=knDp39cv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8F517C4AF07;
	Mon, 20 May 2024 21:16:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716239806;
	bh=i9sMlbAULR6WBF7z4CvLAk2CNyoAXyInKoTd0w7BUmk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=knDp39cvfVtNAXHezWhCM2eUf8BF+yeBlQ27p5MN1ouM25k8cRbl7CPtWowq3ww4X
	 nCgtBThuJ6nsRcl7N/Ix0bgqZCNS5UB60rAb80aOlEiPV+hniLsvW1i2wkWH1XrWRx
	 qaOYqcSczgiQHXJST7+YRg8FNDZY4fXKK5cSOuc/ZiRyyDf6MpkY88iGc9aWPGgS7C
	 3HWgaB3ZkjK5H4K/QwUipmTgGdki2EV37S4vF9Gf2CmidKke/xAHViFsVm1Q6Ny5Wy
	 FdPiRAyVvIWy6xOrDEM6n/GshsfyOAmdZPgnUT4pnAaV1UhLkYl7/XHeWb2Umnce6w
	 q09zjmqukjnng==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7750FC43332;
	Mon, 20 May 2024 21:16:46 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH 0/6] Remove page_mapping()
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <171623980648.27511.9576243592130521184.git-patchwork-notify@kernel.org>
Date: Mon, 20 May 2024 21:16:46 +0000
References: <20240423225552.4113447-1-willy@infradead.org>
In-Reply-To: <20240423225552.4113447-1-willy@infradead.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org, linux-fscrypt@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net

Hello:

This series was applied to jaegeuk/f2fs.git (dev)
by Andrew Morton <akpm@linux-foundation.org>:

On Tue, 23 Apr 2024 23:55:31 +0100 you wrote:
> There are only a few users left.  Convert them all to either call
> folio_mapping() or just use folio->mapping directly.
> 
> Matthew Wilcox (Oracle) (6):
>   fscrypt: Convert bh_get_inode_and_lblk_num to use a folio
>   f2fs: Convert f2fs_clear_page_cache_dirty_tag to use a folio
>   memory-failure: Remove calls to page_mapping()
>   migrate: Expand the use of folio in __migrate_device_pages()
>   userfault; Expand folio use in mfill_atomic_install_pte()
>   mm: Remove page_mapping()
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,1/6] fscrypt: Convert bh_get_inode_and_lblk_num to use a folio
    https://git.kernel.org/jaegeuk/f2fs/c/262f014dd7de
  - [f2fs-dev,2/6] f2fs: Convert f2fs_clear_page_cache_dirty_tag to use a folio
    https://git.kernel.org/jaegeuk/f2fs/c/196ad49cd626
  - [f2fs-dev,3/6] memory-failure: Remove calls to page_mapping()
    https://git.kernel.org/jaegeuk/f2fs/c/89f5c54b2281
  - [f2fs-dev,4/6] migrate: Expand the use of folio in __migrate_device_pages()
    https://git.kernel.org/jaegeuk/f2fs/c/e18a9faf06c2
  - [f2fs-dev,5/6] userfault; Expand folio use in mfill_atomic_install_pte()
    https://git.kernel.org/jaegeuk/f2fs/c/a568b4126b20
  - [f2fs-dev,6/6] mm: Remove page_mapping()
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



