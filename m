Return-Path: <linux-fsdevel+bounces-24306-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4764B93D048
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jul 2024 11:16:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F16871F215B3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jul 2024 09:16:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFFA32B9B8;
	Fri, 26 Jul 2024 09:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V+JCZ1YO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E946116;
	Fri, 26 Jul 2024 09:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721985389; cv=none; b=Lo0TghqL4+OQ/v3Ru0S5J9el56scsApdLGkKK/3gMcN991jdhpgloQityoGk0lKFbDYwhjelE96f2OFGsakc1TTE0kn13S1jUuVCFrjRlEkHXShLuUCCBbMeUzOwVwvzqhvZ8699wlFMf1zaJtJulOpaDUAXMGvqKT8XdkmPZNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721985389; c=relaxed/simple;
	bh=PnbtAbDjAPuh96YJQ/mUts5tx5UOs3uqSVoqQhxA+ww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rDAeTfn7cjrFFDSAoBspBFKNj8ZjUMwcyMPPfVLtlh24WIYEN0xCm1h34AUNoGV3Yb3uxUvozsm48lb17xR2evAZL5X2s3iBM1qVCYk3zrG+lOCNKJ+eQDIDXzp6XOF65s6LDMRQgWHSEP87GuP5YhYGe7GIIvVBqyBD3iWEJf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V+JCZ1YO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27759C32782;
	Fri, 26 Jul 2024 09:16:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721985389;
	bh=PnbtAbDjAPuh96YJQ/mUts5tx5UOs3uqSVoqQhxA+ww=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V+JCZ1YOwIhojDTDdz8i0qs3E0cnsup3rbDEcel0eSAPNviCjLd+tJFCpwuEnhHoT
	 GgFvZIargYCqRE93v8OLacXnwv2i/eSAWfTHLWE2WY6yoNR9R08yUCQHOE3r9756Dp
	 GmSOJ0MhcRaL8ZKSoZnH95OZypcA5CjzJnSyt9Nq5Twzn5Jfy7A6NQg+x9BtSN2WvQ
	 n9TYn1tJdd9d3PxfrgiP21uZS1dxXnpeDjgyeDwKXAu65M/XMWWrZmnkhcirdI5xTd
	 9y3dZji+jfzBbCQo7eLTMKhZ+uRKMWRMB0Vljbnu8PgrjjQxJyYALcI49fJ4hJ+p1p
	 PiWvwzLKyaH1Q==
Date: Fri, 26 Jul 2024 11:16:24 +0200
From: Christian Brauner <brauner@kernel.org>
To: syzbot <syzbot+dd73570cf9918519e789@syzkaller.appspotmail.com>
Cc: aleksandr.mikhalitsyn@canonical.com, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	viro@zeniv.linux.org.uk
Subject: Re: [syzbot] [fs?] WARNING: lock held when returning to user space
 in ns_ioctl
Message-ID: <20240726-vorsah-bohrung-5df17560cead@brauner>
References: <00000000000077c88b061d7b893e@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <00000000000077c88b061d7b893e@google.com>

#syz fix: nsfs: use cleanup guard

