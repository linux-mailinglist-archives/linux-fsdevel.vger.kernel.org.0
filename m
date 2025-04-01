Return-Path: <linux-fsdevel+bounces-45406-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EECA6A7727B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Apr 2025 04:02:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A54E416B54C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Apr 2025 02:02:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BACFB154BE2;
	Tue,  1 Apr 2025 02:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fCpzlj75"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2343470820
	for <linux-fsdevel@vger.kernel.org>; Tue,  1 Apr 2025 02:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743472945; cv=none; b=Tk5V/QTeb5u3hvVTx+Amwb5HHtxPmgvN05qMB5BZsNam0u+vfd3EtPx4xTt1jlJzldCeEsdBPakH667w308PWJUMn7eIkxpX3LU/ExV8wcS9/FuSIFIERASEqA4d5i1h55Gj8DVoC+MkjB7iSMFDBFJoPfIosGu6L30ve5aM2xE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743472945; c=relaxed/simple;
	bh=GU+Mct0K4YvtPgrdNE5wQY8SlZ//nDuUSUO/GQ7+a1Q=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=KPoe+F9AVvhNf5P7quB2MZmhI/k6PTywm7Fjg3cZm0np2Igagv86ONVAc09szguaa/eGf49edtg3GpE0qTKcmsX4DcnWYSL20BZqi9wRvenuDR/3zwsbHnDHbqY9YHt5lC4O/i7Pa98zxgSwkee1NXaujGz8LahTVDSHZhslsOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fCpzlj75; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02B4EC4CEE3;
	Tue,  1 Apr 2025 02:02:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743472945;
	bh=GU+Mct0K4YvtPgrdNE5wQY8SlZ//nDuUSUO/GQ7+a1Q=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=fCpzlj75+muRp7Tobt4H8oY4coQysjHpCvEzbqbcMJaOaNIBULkCzfjGd00qhZCfQ
	 PH5bPsRIu7P4MKE9k2lhpg3HZYYVDtvnfgxmQOJ0BoEfuhtL8PJ6ZxS1+2Swx7xnGo
	 h6x/c7RkTcjwIqq9zFTK5gsnDsuzKlKANDxVImZNICcFmSBr01IRPHo4Ugy9/wcHYI
	 7tsVkiGxT3/9M2i+5vcxuEbLDeq3sErj8dcdCDR6iAR5lOo+qF13pziZ/GZqvCseBc
	 6ocuuCQL1WtWbJY9wVb9iYuUXeP7+KOQvvhMeBkpmEL1Jz7Fm6jOu1YLmcTb9pOwcP
	 yJvGjUVzsEb+g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAF40380AA7A;
	Tue,  1 Apr 2025 02:03:02 +0000 (UTC)
Subject: Re: [GIT PULL] ext2, udf, and isofs fixes and improvements for 6.15-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <dsr7ciqsadlveg2lf3zivliyqrmicj3l7crjtvao5hsakpzpbj@pjtvahqcdyln>
References: <dsr7ciqsadlveg2lf3zivliyqrmicj3l7crjtvao5hsakpzpbj@pjtvahqcdyln>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <dsr7ciqsadlveg2lf3zivliyqrmicj3l7crjtvao5hsakpzpbj@pjtvahqcdyln>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fs_for_v6.15-rc1
X-PR-Tracked-Commit-Id: 6afdc60ec30b0a9390d11b7cebed79c857ce82aa
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4080cf02f11e337c5031013f77e0ba1a475985ee
Message-Id: <174347298154.206397.3644568682394121615.pr-tracker-bot@kernel.org>
Date: Tue, 01 Apr 2025 02:03:01 +0000
To: Jan Kara <jack@suse.cz>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-fsdevel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 31 Mar 2025 16:19:14 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fs_for_v6.15-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4080cf02f11e337c5031013f77e0ba1a475985ee

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

