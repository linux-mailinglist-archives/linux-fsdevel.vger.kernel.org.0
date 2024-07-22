Return-Path: <linux-fsdevel+bounces-24100-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D069F9394E4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jul 2024 22:45:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AD321F21861
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jul 2024 20:45:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF0D0446A2;
	Mon, 22 Jul 2024 20:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PW5QIotz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 356773D97F;
	Mon, 22 Jul 2024 20:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721681098; cv=none; b=H2FuODEWf9Ps2GeqgBwClBujwE7/x4pRag+t42PzyeQUjZucarLTPL2SZf5pvE2Yfig0+jFvcAP5WbNpJfrPNala8O4qpRcymIfelMnuVusNgGBS2LVtxjD6/3YFArJ2HTJga+Kow9Klut/RMUX1HvVyExhmIwo4pShDIYYv+L0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721681098; c=relaxed/simple;
	bh=fdPw8eIg51J5NpNhaASX6E6gh1/S4eQttbOsWz6D+sQ=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=eNDUZKhCrbO06pyuw6xBdWbISPMDwJ26OoO+cLgmmox2ObyeMYufZWogyF/jHu84LOu1Sx4te9Gtt+b5yyPVV2ypNWE332BKP470O+cLH7d9NWPs5zxXIB6iMQWyc3YzCLPgA4RiGSN89asX/xm8fOTt03IUYDC23IypIGr/Gaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PW5QIotz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 17FABC116B1;
	Mon, 22 Jul 2024 20:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721681098;
	bh=fdPw8eIg51J5NpNhaASX6E6gh1/S4eQttbOsWz6D+sQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=PW5QIotz0Vom6jNmx93d7q5MwhQF6lQqRUMepXPGzOv9qcouvWdACXu+DiERi2IE0
	 nldRI3fwvYBX/1N2M/zspyJnklogSDWRQ7cldVQ9XoA+gxN/6qnY2Sg5LYpQngg7Lf
	 J+MJ9wCp9yMcD7mgaZrwbSOOnpMaerXN3SqfYMBM+0I4RfAZBSeI28b96FWZq9xzwC
	 2uU8aJOuUVaqq2nqNyBafAOzHevcmN7uxvCJ5n8khw9VxOuVxw75cxGHaneK9Azg8Z
	 qmFdywlMfTpAklZ52WMhgBv0XXo+f+zmYV970NbJLTdmZa/l3JYH9jMuTJkw6CZued
	 eiMMvv6YWSfgw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0F16AC43443;
	Mon, 22 Jul 2024 20:44:58 +0000 (UTC)
Subject: Re: [GIT PULL] bcachefs fixes for 6.11-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <xcuhxvqskxdrcjpxufbor3u4ud4sxufofh36y3p4a4y5ovvaqa@ldn4qyogpw2j>
References: <xcuhxvqskxdrcjpxufbor3u4ud4sxufofh36y3p4a4y5ovvaqa@ldn4qyogpw2j>
X-PR-Tracked-List-Id: <linux-bcachefs.vger.kernel.org>
X-PR-Tracked-Message-Id: <xcuhxvqskxdrcjpxufbor3u4ud4sxufofh36y3p4a4y5ovvaqa@ldn4qyogpw2j>
X-PR-Tracked-Remote: https://evilpiepirate.org/git/bcachefs.git tags/bcachefs-2024-07-22
X-PR-Tracked-Commit-Id: 737759fc098f7bb7fb4cef64fec731803e955e01
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: dd018c238b8489b6dd8c06f6b962ea75d79115ff
Message-Id: <172168109805.32529.13093246106409335840.pr-tracker-bot@kernel.org>
Date: Mon, 22 Jul 2024 20:44:58 +0000
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 22 Jul 2024 13:12:31 -0400:

> https://evilpiepirate.org/git/bcachefs.git tags/bcachefs-2024-07-22

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/dd018c238b8489b6dd8c06f6b962ea75d79115ff

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

