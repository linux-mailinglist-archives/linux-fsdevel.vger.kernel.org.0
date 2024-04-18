Return-Path: <linux-fsdevel+bounces-17244-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB8F68A9882
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Apr 2024 13:27:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 875671F2239A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Apr 2024 11:27:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F205415E7EA;
	Thu, 18 Apr 2024 11:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RFcl7Ce8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5642515E5D4;
	Thu, 18 Apr 2024 11:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713439668; cv=none; b=cD0zmhmaxofH+7zebmVQtVShaMvEr5R8yeb8OHf94ySKc7m6DJMlBzhxIpKvb7gUL44tuHKIJ0owAuRC3FhFX/JqgLF/vNBhLnPLE7MTMxV1AQmeEusv9lHVFmB2OuomPoyH7IWWaFT1s+pyRAVDPofLCgyDiKziLEWmLlYbXmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713439668; c=relaxed/simple;
	bh=/2ZX0SY/zasAtR4FACNuP1o81/PV72X8mNtJb+PVuOk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c8ahl5p7hByk0Rd/r3fwPjZ9jC4b8KmNfgwS2URh2Kf3zi7jBWbyFqZpbtxL/2d+vgMxiqyTVhGgnNnZCmm7jAiDEO976+CEWB9jGq4LQbJxK6v10i85D7PAwTalWdtrCVpN2tyKdpZCpPE+c+Mgs+FDUbWUUnoVbNHKvwoTCWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RFcl7Ce8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6FF1C113CC;
	Thu, 18 Apr 2024 11:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713439667;
	bh=/2ZX0SY/zasAtR4FACNuP1o81/PV72X8mNtJb+PVuOk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RFcl7Ce8HCnihAJOlaIpL687gGy//lWdeJGZGwCHTFwQeU0FYdUQ5rMLXnpndbWvQ
	 Wt9gddmMR+dJA371hCTRJ/fIh6rLdFtQVg/I3HtqoDOAyO3alHNb4OF6iTVMhDpjVv
	 JU8nYzHfnXMwjDmgHorg79C7NLHLw1UlAjV2w2UAIM3xOCR6pSy82P0CnLpHsfB6YL
	 FUlkvlQ+Ma1ZXwZWPpY8YkqVWqOOmrVyhdDmXzBinpEOntuxeEhPbOnM9DOxIwRNpe
	 RljZAyd/eOsYtwXFF+AzPXU8yfeEiUB9uT9lE86JWiDyU7aFhze6dXJsQmc6Mu5w09
	 FLuhmFtg3hTYQ==
Date: Thu, 18 Apr 2024 13:27:42 +0200
From: Christian Brauner <brauner@kernel.org>
To: syzbot <syzbot+3acccbed6f1454bf337c@syzkaller.appspotmail.com>
Cc: jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Subject: Re: [syzbot] [fs?] WARNING: ODEBUG bug in bdev_super_lock (2)
Message-ID: <20240418-emsig-abgehackt-b5c21d3a3e78@brauner>
References: <0000000000006249a406164ec138@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0000000000006249a406164ec138@google.com>

On Wed, Apr 17, 2024 at 11:09:27AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    fe46a7dd189e Merge tag 'sound-6.9-rc1' of git://git.kernel..

The cause of this bug has long been fixed upstream. The commit listed
here where this is tested on is prior to that fix.

> git tree:       upstream

#syz fix: fs,block: yield devices early

