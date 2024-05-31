Return-Path: <linux-fsdevel+bounces-20670-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 085BA8D69A6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 May 2024 21:20:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A1301C21F69
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 May 2024 19:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FD158063C;
	Fri, 31 May 2024 19:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="maT/Cayf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C7592B9C2;
	Fri, 31 May 2024 19:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717183204; cv=none; b=QCHqVwMlt9U2c59pG+tGES1sTL/XLAgSCppFxeMfNSyP+A2fQhMaA2VPYiXFNv7K1AfnZewkm4MvlNMWiMoKy/WEB3A3maYK7fNSd0lFanxAx5RFbB/Ap0nVO3/Nn1mw1JQocjGWODAbs9CSGpra9Nxy64cFbfU8zpf0KIy23iY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717183204; c=relaxed/simple;
	bh=VfOSh3jZo/FtpixUIPxhcFVqhHvS4bpYu139qzJdjes=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=WpIV1XH4gdwybfst0YLLI2rqK1/e1oW8SqflzYCX6EuuPoSV/mBRKEM7EkUJv765/i09OiAkxgtszuni4mSb2M8aTkFpQLzerFlpAl8/5ZVs0x0XUpxClanfoj7U4st5+aG62gaQYNuj+sFw88fEoB0IhU0ZNSl8OT28LQLq1zU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=maT/Cayf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5E670C2BD10;
	Fri, 31 May 2024 19:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717183204;
	bh=VfOSh3jZo/FtpixUIPxhcFVqhHvS4bpYu139qzJdjes=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=maT/CayfFs7vCRBV4U8B+CSqDNFqXZ6TqmLoBV/uQvcCxxywLt0XyBFE2+YluTcf8
	 GuIOTV05fhrWzi9wiUrFoZHPwgqwzrCxrx7eTZUvLIS+NsmZ/maE732fHCIOBk3JRr
	 jIp2jaUlWgqnMW4rkHqrwejJhBihz0yCKJfUC2yDomc/3coz2ItlJOyYQ4wPOLgrVA
	 Buu1GkT67zkJUls10juCZa4FGy3UO6Cpy8RohnYm5+3drIwQM1EU2e8/7GjWZLSk7X
	 CxCZ/k4pkMqodlqzR1vvAqWNa4d9TCsr0HRzUm4TpzW0JAcRm80v/t55ui+ekQV3ie
	 WEnNuplBOisnA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4EA8EC4361B;
	Fri, 31 May 2024 19:20:04 +0000 (UTC)
Subject: Re: [GIT PULL] bcachefs fixes for 6.10-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <wvw6rfvpz7nfq3dbvy2frovpzrqkgsyke6e45pgh2bntvubxqb@wjanieiymayi>
References: <wvw6rfvpz7nfq3dbvy2frovpzrqkgsyke6e45pgh2bntvubxqb@wjanieiymayi>
X-PR-Tracked-List-Id: <linux-bcachefs.vger.kernel.org>
X-PR-Tracked-Message-Id: <wvw6rfvpz7nfq3dbvy2frovpzrqkgsyke6e45pgh2bntvubxqb@wjanieiymayi>
X-PR-Tracked-Remote: https://evilpiepirate.org/git/bcachefs.git tags/bcachefs-2024-05-30
X-PR-Tracked-Commit-Id: 7b038b564b3e2a752d2211e7b0c3c29fd2f6e197
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ff9bce3d06fbdd12bcc74657516757b66aca9e43
Message-Id: <171718320427.20247.17569724543278721273.pr-tracker-bot@kernel.org>
Date: Fri, 31 May 2024 19:20:04 +0000
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 30 May 2024 11:53:16 -0400:

> https://evilpiepirate.org/git/bcachefs.git tags/bcachefs-2024-05-30

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ff9bce3d06fbdd12bcc74657516757b66aca9e43

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

