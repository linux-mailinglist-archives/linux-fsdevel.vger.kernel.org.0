Return-Path: <linux-fsdevel+bounces-23873-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE660934322
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jul 2024 22:18:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79AE51F215E5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jul 2024 20:18:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7506E1849E7;
	Wed, 17 Jul 2024 20:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kmJtJPhG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F781849C4;
	Wed, 17 Jul 2024 20:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721247507; cv=none; b=P8Fz+2ShVftJ0FoQ2DehN5jw+IaLDRJyRkQ3EYhZj517gXACFhOMNc/PFNnPPQGxg4p4wAx0UZo5yQsGEcLAQoofEy6lCzRF40Q1mMifWkPzjHFxcQZsefLzqcvx7Q5IIkIiJabA1B9gU++9RQS157g0firiU0vB53toueZoqLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721247507; c=relaxed/simple;
	bh=eGAUc4pMZTQM/tUvOucsws9wjJgDrtbStBt3rco9ePs=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=k3dsw309qKlao4zPZW9TYdsp2i0cg9lq5E3QFjsGKYLHEwryUvwiRi+hx9YmbE+7ilkLnfIy1xIConqvc5e0mWjQEV9sChCoPDU5eXrsX1Psuvn4Y1lWdAHXkVxc/WRbvKZlOo5tI/+wyqzkYVO7noNBj8mFVNRLK5TLtvZUsZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kmJtJPhG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B4C25C32782;
	Wed, 17 Jul 2024 20:18:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721247507;
	bh=eGAUc4pMZTQM/tUvOucsws9wjJgDrtbStBt3rco9ePs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=kmJtJPhGUEsED4nSYVi2oWBVKQXpzId5xhQOZ2S5EVJxqg9gUjs4XE/1/YZDnPVd+
	 gXXVxPE0qzhSDt++LgpWbCOV7j+OhaLqF6V7E2hGJDrENbC/IN7BqWGh8ECJLhnJ2U
	 U9V6fUUT5PFqXDBxLrLcvMi4o6TSG9nnTaH11JvH1uJpeB/jsOxbO2Kpz/riSIkO5N
	 CEbu4yZFQscJQg0GRmr5XjRiT4qSu+CzzaaOR2r3yTen5gGfMWwT7ADJZt2X0u1RPF
	 1gxTvlbt5IGAQt5un1ghaLmXaGusb03FTh+KR3ViM7ELvgsSipCuEpRuANSi+KSGy2
	 TN7LH294MqcXQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 94A65C433E9;
	Wed, 17 Jul 2024 20:18:27 +0000 (UTC)
Subject: Re: [GIT PULL] xfs: new code for 6.11
From: pr-tracker-bot@kernel.org
In-Reply-To: <871q3sison.fsf@debian-BULLSEYE-live-builder-AMD64>
References: <871q3sison.fsf@debian-BULLSEYE-live-builder-AMD64>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <871q3sison.fsf@debian-BULLSEYE-live-builder-AMD64>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-6.11-merge-3
X-PR-Tracked-Commit-Id: 2bf6e353542d233486195953dc9c346331f82dcb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bf3aa9de7ba57c2c7b5ea70c1ad3a6670cd6fcb0
Message-Id: <172124750760.12217.1834948599153677699.pr-tracker-bot@kernel.org>
Date: Wed, 17 Jul 2024 20:18:27 +0000
To: Chandan Babu R <chandanbabu@kernel.org>
Cc: torvalds@linux-foundation.org, chandanbabu@kernel.org, linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 17 Jul 2024 09:14:02 +0530:

> https://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-6.11-merge-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bf3aa9de7ba57c2c7b5ea70c1ad3a6670cd6fcb0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

