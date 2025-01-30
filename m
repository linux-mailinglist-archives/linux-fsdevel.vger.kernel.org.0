Return-Path: <linux-fsdevel+bounces-40420-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E1C08A23355
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jan 2025 18:46:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 515E5162C96
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jan 2025 17:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 105181F12EE;
	Thu, 30 Jan 2025 17:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uL7STLku"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68DE91F0E5D;
	Thu, 30 Jan 2025 17:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738259152; cv=none; b=lol1iJ+d0yd1kfAHm4R/6pOi/fy1eXPuFo+XnP7xvV+DABhY3VWBZo7FhMM/OBP1HH4BDKa0K7xgmlQFNuEEp9FgMP2e+Yxc/5yYiGRznWswBBg/Y7KmLu0lf7DQ1E11RU1JYALYt/NYAxxok7Ee0P6RGX18Fdq5neqkQpzxRDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738259152; c=relaxed/simple;
	bh=YJdAYoCHlP8K1gKlpdBSctRHnA5yQu660V0qmMWqE/8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=EatQQFsgAs1ZVUmvEWk2piKwaxK4N6hRCa2Kzaq+IfQCRjd8lLsY3y5fe5UB2vWVMPQRjqLVJ4060laE9jbzBdwovApLTZb69YNcpZuszNKf3Qk1MAEFI12r0+fH0iaK7ViTyjth4/KXzXMOlY6TH0F07sNR+rvV5jENf9K/hx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uL7STLku; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1CB0C4CED2;
	Thu, 30 Jan 2025 17:45:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738259151;
	bh=YJdAYoCHlP8K1gKlpdBSctRHnA5yQu660V0qmMWqE/8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=uL7STLkudorvwGSUJLmjDTkD3nTZy6Iw0VUoXquUnbJAZA3OgQu2PKxLySlXeTgUK
	 q5JEG6TQ7kDpz6X0a0I3lEqKnDHBB3XLjO+FWk7eQfKujRjMXEbMQAsJcEs8JMfM4M
	 ToHxZ6X3nBHsmE0jqovAt7WhRJYekHwFcVJk1TPTVE9IPvsMN6sU26od3wAvpbmcNv
	 j4vGSSp9RNeJ0aMlPAewAn4rSp0ZoRRFoIM5Isk+2ZtWVZI2JmF0xwxBRkVqWAMoUh
	 O6giXm+pQs9auCieTfCMFcIZ0DmrVDjskm6YqesPHlmfecFt80JR9A9VE/QF/lJhZz
	 xedVcoyWbbjEA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70EF8380AA66;
	Thu, 30 Jan 2025 17:46:19 +0000 (UTC)
Subject: Re: [GIT PULL] ntfs3: bugfixes for 6.14
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250130144632.22506-1-almaz.alexandrovich@paragon-software.com>
References: <20250130144632.22506-1-almaz.alexandrovich@paragon-software.com>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250130144632.22506-1-almaz.alexandrovich@paragon-software.com>
X-PR-Tracked-Remote: https://github.com/Paragon-Software-Group/linux-ntfs3.git tags/ntfs3_for_6.14
X-PR-Tracked-Commit-Id: 55ad333de0f80bc0caee10c6c27196cdcf8891bb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ce335806b5ecc5132aed0a1af8bd48ae3b2ea178
Message-Id: <173825917806.1032810.9904254896538303344.pr-tracker-bot@kernel.org>
Date: Thu, 30 Jan 2025 17:46:18 +0000
To: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc: torvalds@linux-foundation.org, ntfs3@lists.linux.dev, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 30 Jan 2025 17:46:32 +0300:

> https://github.com/Paragon-Software-Group/linux-ntfs3.git tags/ntfs3_for_6.14

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ce335806b5ecc5132aed0a1af8bd48ae3b2ea178

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

