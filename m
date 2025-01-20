Return-Path: <linux-fsdevel+bounces-39747-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98822A1749E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jan 2025 23:30:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF8E27A3328
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jan 2025 22:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D93291F0E26;
	Mon, 20 Jan 2025 22:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="raZULB9I"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3596D1F03C7;
	Mon, 20 Jan 2025 22:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737412197; cv=none; b=hL9jSbSbu2IaIq0NGWDrV6LMyy07FWEWLkz0FG/7DMP9PxTdXhjvyWXXiMNBmY0xN5Z/GVp2U+eQhi+RFX8RMimOfSteQZMz7lQ8HNYLKlUPcL1HPllUT45/ra1RlGYGa1nlnMWlqjqpUXp/SvWyEVIXrxVSxEO39n2Hvg30u7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737412197; c=relaxed/simple;
	bh=QwxevrfJ6v1wH79Rp7747W9yC95BAsnV7T6F6s6xjdg=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=cZbBL50ziXffbv2lBX30Mi8vjir65+ld721kKA75pq00ymdPH2yp/cfS+FQeIR1xun+Vh9gAIgHp+kOSkcwvTon1JekyBUnQCtOC2NPYl/evh2U+Ym2nB2BCF7eyan0sEtMt/7btF+9u/TQVUjM9tuUkJSks4dmJCLXaRchYX1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=raZULB9I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 186A0C4CEE4;
	Mon, 20 Jan 2025 22:29:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737412197;
	bh=QwxevrfJ6v1wH79Rp7747W9yC95BAsnV7T6F6s6xjdg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=raZULB9IrSEMBNx2+RVUDJM1EfOA0SSPzquPIlvDY9MWx8MxadijoQaki7g/KRS/b
	 /RC9FYCZPVUItUxpnRnqsk9J3a+GxodUc+cKAPMkmnFEYVHf7q7iOH6Tsoux7/Ebjw
	 9WG/IbQmjWsDeWR93ZzNQmvxy6lB0XQQEiliQOEIADFXsoBCLdFslovvnQl7hwlgrF
	 fjRYoUBNepVmnyYwJZJxysfXO7q0DNLPtJM5T2ChpiectTcGxfEVJ5tPIw6vxLRwIg
	 sxcoEFgBXip5t4b43pURPZUFep2fhm+KgE3KGgdtWRfEmKK3glCG4RxFpu+7skTeSl
	 r9qzuYGlHH5Ug==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5CEE8380AA6C;
	Mon, 20 Jan 2025 22:30:22 +0000 (UTC)
Subject: Re: Re: [GIT PULL] bcachefs changes for 6.14-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <h6ibklgumu7ug77lhuruqnhtp7dftc36pgqryz5ha6igzgm5sq@bdxgtyrow2cv>
References: <mk2up66w3w4procezp2qeehkxq2ie5oyydvcowedd2fkltxbhh@yvuqt3jdjood> <h6ibklgumu7ug77lhuruqnhtp7dftc36pgqryz5ha6igzgm5sq@bdxgtyrow2cv>
X-PR-Tracked-List-Id: <linux-bcachefs.vger.kernel.org>
X-PR-Tracked-Message-Id: <h6ibklgumu7ug77lhuruqnhtp7dftc36pgqryz5ha6igzgm5sq@bdxgtyrow2cv>
X-PR-Tracked-Remote: git://evilpiepirate.org/bcachefs.git tags/bcachefs-2025-01-20.2
X-PR-Tracked-Commit-Id: ff0b7ed607e779f0e109f7f24388e0ce07af2ebe
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2622f290417001b0440f4a48dc6978f5f1e12a56
Message-Id: <173741222117.3666340.7094288730625439277.pr-tracker-bot@kernel.org>
Date: Mon, 20 Jan 2025 22:30:21 +0000
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 20 Jan 2025 12:38:26 -0500:

> git://evilpiepirate.org/bcachefs.git tags/bcachefs-2025-01-20.2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2622f290417001b0440f4a48dc6978f5f1e12a56

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

