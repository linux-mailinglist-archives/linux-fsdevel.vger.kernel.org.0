Return-Path: <linux-fsdevel+bounces-32820-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D4109AF3B2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Oct 2024 22:33:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C21F4B2172D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Oct 2024 20:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A17B22141D0;
	Thu, 24 Oct 2024 20:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gG+T4wzJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F236F1AAE27;
	Thu, 24 Oct 2024 20:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729802012; cv=none; b=JDFmYs8fzomvIcjEmVd23uN4eDPLb80UeRxP92vZmDl8Fk7Td+WyHU7AGdzHFHjzE8/7S+VCj25SboTRTRiu8i1HJDI8kPfTcC8V+Gd87bAcxdR2XSe7/2U5ScPOmRjOuEdzav+RBkXlQbJ6kanDi51DhvXxNF5TkqCHC3k9eRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729802012; c=relaxed/simple;
	bh=9rk5z6/zwvglHu8zFoaHYT653uV9biCfI8lUNpolo8I=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=NN8sLNKBY6LYP1G5BjlndP6DZLuiNmsl+8zBSI6Ee7fJRHXIis6kEuwmuuLN82exVHUQIS1O6j8YVkPix9ZmTAR87XrMp6nmhz4VmZCx+ojlpNiPup81J+i3Gpum6H7Agj39AdWfMEoRtGALU011aOSBF68/RaPvcxwRqZvUf4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gG+T4wzJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C32A7C4CEC7;
	Thu, 24 Oct 2024 20:33:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729802011;
	bh=9rk5z6/zwvglHu8zFoaHYT653uV9biCfI8lUNpolo8I=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=gG+T4wzJoxc4IFwX6iQLg8PjTsMYCLwHqQQbOAzmediLGMky9yWggQEszN8Q5ebkc
	 tiq/kRQT+0UePFvCdXlXbkGoR0Ha6ptCipL5kuUKhxDTpK1vJ0L2G6nshDj/WQ+/li
	 /YIujSulSu+hQ2scA6PEFViBCX5T3hbw0VGwEdRlLbkhsfT9nFHaLMcZPVcQLypmUF
	 mqmqIteIqzVx1vJlfrBZU1qt6/cckk57NtA9yWkV8ZXsFzWvanzKPS9GTRkRs+oEvW
	 h8Zr3kcptgEmL6w6VEBm7HMTFqpXlRTeU0O0wVG2zaiPDT15ZpNF5M/dQJX1NrG3Ij
	 e8/xQQ6IsfmEg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE12D380DBDC;
	Thu, 24 Oct 2024 20:33:39 +0000 (UTC)
Subject: Re: [GIT PULL] bcachefs fixes for 6.12-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <rdjwihb4vl62psonhbowazcd6tsv7jp6wbfkku76ze3m3uaxt3@nfe3ywdphf52>
References: <rdjwihb4vl62psonhbowazcd6tsv7jp6wbfkku76ze3m3uaxt3@nfe3ywdphf52>
X-PR-Tracked-List-Id: <linux-bcachefs.vger.kernel.org>
X-PR-Tracked-Message-Id: <rdjwihb4vl62psonhbowazcd6tsv7jp6wbfkku76ze3m3uaxt3@nfe3ywdphf52>
X-PR-Tracked-Remote: https://github.com/koverstreet/bcachefs tags/bcachefs-2024-10-22
X-PR-Tracked-Commit-Id: a069f014797fdef8757f3adebc1c16416271a599
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c1e822754cc7f28b98c6897d62e8b47b4001e422
Message-Id: <172980201841.2376768.13141234127886796981.pr-tracker-bot@kernel.org>
Date: Thu, 24 Oct 2024 20:33:38 +0000
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 22 Oct 2024 13:39:10 -0400:

> https://github.com/koverstreet/bcachefs tags/bcachefs-2024-10-22

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c1e822754cc7f28b98c6897d62e8b47b4001e422

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

