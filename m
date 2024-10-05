Return-Path: <linux-fsdevel+bounces-31089-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30387991B41
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Oct 2024 00:36:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C52EF281D10
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Oct 2024 22:36:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F3B216B3AC;
	Sat,  5 Oct 2024 22:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UCVCzyJ5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE235223;
	Sat,  5 Oct 2024 22:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728167802; cv=none; b=AKRY25C+ByN9ruCfjO7AKgd0mii43PHdyl+3aiGBn0kgMSZVkbZ6vVTCEvj6viLUtE4GDRJ+GoGJyd3FcmG5egBqlqSVSfK/ir9YsOB5PGAmRVCUPogDRNvYWN1dzOHYAg3Y9d1FseW1GZlPBY9vx3x8gK4lBjtl+SYtVjO4qaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728167802; c=relaxed/simple;
	bh=1WnY5GqmOwjJc/0X/Ij7LvIdokIzvRcFMtH/uFu8SWQ=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=CvNhArAkkY87DzxBV1HE06qu1qxElFUhSFooOxuXceMnTzkZNGv2sdUUJN7ABMSuhm1xTQJAdsJXzpzQv1bCGMsST3ILNSV7Bf0WNMb4OB6BeJNdO5uScUF8t/ENv/UaMkmF1v3omCnpiA/ucE6qQ4XJhDVfX/az/ff73luGSOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UCVCzyJ5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C30DC4CEC2;
	Sat,  5 Oct 2024 22:36:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728167802;
	bh=1WnY5GqmOwjJc/0X/Ij7LvIdokIzvRcFMtH/uFu8SWQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=UCVCzyJ5Ty2IpwDdgMSyOOcArWMPPoKlfjOx7YJEKTQY5DStuopx9ElKJnpKUIgoJ
	 UIF4NHM2Ar9ie05CewMJqdyiUkMSlZlWUx+liU1It5HlpVLoofK0tNAjNYHRqSqmQu
	 koAwvaZ+XUO36x6XnexV+VnmVkoxOfm384AW76y4U/Ku9sJ7K2b2A8iaBVz6QaAFqf
	 xlLMU+euYDCZB/JpSlvY3SGp1Rn1WD5ERGsXq+057+a7TIcEmkWHnxiWoDOi7daLzD
	 PnNxsGHAPi23Y9q9LTu3W+DHdI+ukZcYNklyQktzR29Km6cprGmUkAXChMx1zAhVhd
	 uJO4PSo5yNndw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70E383806656;
	Sat,  5 Oct 2024 22:36:47 +0000 (UTC)
Subject: Re: [GIT PULL] bcachefs fixes for 6.12-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <cphtxla2se4gavql3re5xju7mqxld4rp6q4wbqephb6by5ibfa@5myddcaxerpb>
References: <cphtxla2se4gavql3re5xju7mqxld4rp6q4wbqephb6by5ibfa@5myddcaxerpb>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <cphtxla2se4gavql3re5xju7mqxld4rp6q4wbqephb6by5ibfa@5myddcaxerpb>
X-PR-Tracked-Remote: git://evilpiepirate.org/bcachefs.git tags/bcachefs-2024-10-05
X-PR-Tracked-Commit-Id: 0f25eb4b60771f08fbcca878a8f7f88086d0c885
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8f602276d3902642fdc3429b548d73c745446601
Message-Id: <172816780614.3194359.10913571563159868953.pr-tracker-bot@kernel.org>
Date: Sat, 05 Oct 2024 22:36:46 +0000
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 5 Oct 2024 14:35:18 -0400:

> git://evilpiepirate.org/bcachefs.git tags/bcachefs-2024-10-05

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8f602276d3902642fdc3429b548d73c745446601

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

