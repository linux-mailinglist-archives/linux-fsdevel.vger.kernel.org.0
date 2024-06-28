Return-Path: <linux-fsdevel+bounces-22799-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1406C91C754
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jun 2024 22:30:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A6B4B272A4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jun 2024 20:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D73AC78C7B;
	Fri, 28 Jun 2024 20:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="HhC1eE2T"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD1AB645;
	Fri, 28 Jun 2024 20:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719606617; cv=none; b=kjT7l0P0SLgRgZyEnnrbAqaA+q6YZpYOR93Z+8laZ9frSpHWXKBlS6ALwVSDmvN3leMZmz5bdDE5F1QSZgTJM5pXtPEyC+c9ymu1c/jS6RKLdD8S/jDKV29XIVj4TzFnqJw+mOfwyA347eqA+ITheT0MD5MpMhmX3Y3jbMCwkZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719606617; c=relaxed/simple;
	bh=wNeM5DL5mhMFCsEYjZfP+2gKIvPvPz++TXwtf0REHoc=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=a9Q39jtlr2MZZR6JMlEe1gOKw+rmnLpEAbprY1Ou6VMW6QJx09vq8dd6rRiThgun8G1GOSSL8LOSwjTkx01afPZuaHYz5VeOhYSLYYWXoiEFXq9RXvHdv/bOI7RtZYf4FNBGyk7C7Py0NohR3N5q/OFtg9Z8MmZmM2Y73rWhhto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=HhC1eE2T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F35DC116B1;
	Fri, 28 Jun 2024 20:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1719606616;
	bh=wNeM5DL5mhMFCsEYjZfP+2gKIvPvPz++TXwtf0REHoc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HhC1eE2TL0YJkENGuuAruJ7gopBm3Wdsw4Y4oCNWIe40m7d9Hsi9HMzFKpBOUxvmI
	 O5OjrEsA8+iRBY4EFZeys5vkaPKXOjovrIMyAt/S75HzCu8Wmz9V5Vy+oVMQ4EVAul
	 Bm++Ojp+aujVN3mKXhtHYLgE2bUN9bTNchxHNHIc=
Date: Fri, 28 Jun 2024 13:30:14 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Abhinav Jain <jain.abhinav177@gmail.com>
Cc: javier.carrasco.cruz@gmail.com, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 shuah@kernel.org, skhan@linuxfoundation.org
Subject: Re: [PATCH] selftests/proc: fix unused result warning during test
 compilation
Message-Id: <20240628133014.111d3a0690033f9fcb2bc57d@linux-foundation.org>
In-Reply-To: <20240628070338.65008-1-jain.abhinav177@gmail.com>
References: <20240625110526.d443fe6d3feb51a50aebf849@linux-foundation.org>
	<20240628070338.65008-1-jain.abhinav177@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 28 Jun 2024 07:03:38 +0000 Abhinav Jain <jain.abhinav177@gmail.com> wrote:

> On Tue, 25 Jun 2024 11:05:26 -0700, Andrew Morton wrote:
> > Thanks.  There's a patch queued which simply deletes this code.
> >
> > https://lkml.kernel.org/r/20240603124220.33778-1-amer.shanawany@gmail.com
> 
> Thank you for sharing the queued patch Andrew.
> There has been no update/revert on it, may I know what would be the next step here?
> After reading the patch above, I believe my change is "more" right. Is that correct?
> 

Well, it's all inside `if (0)', so just remove it.

