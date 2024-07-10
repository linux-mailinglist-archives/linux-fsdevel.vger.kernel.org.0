Return-Path: <linux-fsdevel+bounces-23492-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 94F5892D527
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jul 2024 17:37:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF1B11C21665
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jul 2024 15:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F7461946AF;
	Wed, 10 Jul 2024 15:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sandeen.net header.i=@sandeen.net header.b="mgr97y61"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sandeen.net (sandeen.net [63.231.237.45])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84FF21B809
	for <linux-fsdevel@vger.kernel.org>; Wed, 10 Jul 2024 15:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.231.237.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720625857; cv=none; b=t4m+7kpJyr5f9chOo2/rlcxznpJZkePy/JaOEJKUJL/QKEqacdgwHpAmrlDJSNkhEMhDAs11qShfGlCx5OzPFdIFhn6vhEud2+tPsGPs3nOLMd4B0s4SAMFruAwkg/kA5gZQR+uthcHqT8oobrY+oPMkf6C8LR451FDzJFvnndk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720625857; c=relaxed/simple;
	bh=0Ala8wqXpDIKh+/51xVZfPmm0+ispgDP63jQDZe4ecw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=taFIEQwYsfVawfaA1fdP3gbk5RL4/wWooMk8/AIAz+D/cOJbnDRuKfMVTN2a+QCObz30+07HF4ivQF6lMg6rNbPLEE5AZXwuWrfZrEQpCGt3XAEGgpUkHUacmO339oSW8FacjhnwfmsqPM8pM8xVwWkXXD2+WXO1Qz2shAf2k7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sandeen.net; spf=pass smtp.mailfrom=sandeen.net; dkim=pass (2048-bit key) header.d=sandeen.net header.i=@sandeen.net header.b=mgr97y61; arc=none smtp.client-ip=63.231.237.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sandeen.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sandeen.net
Received: from [10.0.0.71] (usg [10.0.0.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by sandeen.net (Postfix) with ESMTPSA id B0FD9479AE7;
	Wed, 10 Jul 2024 10:37:28 -0500 (CDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sandeen.net B0FD9479AE7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sandeen.net;
	s=default; t=1720625848;
	bh=w9vJgpsBEz4p2/uoTcV2lAz0p4L3ri9AyOjX1+DoPRY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=mgr97y615Y+R9cZw9qZximZ4G3jBKmnfHjhGapgFRNuQotFtJl4AhCZpRaIqb8Hkx
	 SvRhtStnCJtNjflIiUZoBnOMVvQasqzEjtWmTy5UuHQxWgJe1m0YBK4jWEwo2OOHvL
	 YTZoyKJgdDdw25bzj+8Fi0Q5bFW2RvlUyQHkritQJUQPeTrLtKrtmv71zDuNDjZz44
	 B/n9XEZmFj2MFC0fTgJ1+1SZK3LXvL8xX6K9moU5+IrAecwpgHodmpkH/jTuhLKxZO
	 Hr6EODAAXuq2nVHgAI3nhwHjvSxQA//tHzyVPcjixZqjhoda1omS1DOwwyCmDI9qGI
	 MtdqP4aL2FZlw==
Message-ID: <904a02fa-56c1-4f20-ae09-7d50c9745f62@sandeen.net>
Date: Wed, 10 Jul 2024 10:37:27 -0500
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] vfs: don't mod negative dentry count when on shrinker
 list
To: Brian Foster <bfoster@redhat.com>, linux-fsdevel@vger.kernel.org
Cc: Ian Kent <ikent@redhat.com>, Josef Bacik <josef@toxicpanda.com>,
 Christian Brauner <brauner@kernel.org>, Waiman Long <longman@redhat.com>
References: <20240703121301.247680-1-bfoster@redhat.com>
Content-Language: en-US
From: Eric Sandeen <sandeen@sandeen.net>
In-Reply-To: <20240703121301.247680-1-bfoster@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/3/24 7:13 AM, Brian Foster wrote:
> The nr_dentry_negative counter is intended to only account negative
> dentries that are present on the superblock LRU. Therefore, the LRU
> add, remove and isolate helpers modify the counter based on whether
> the dentry is negative, but the shrinker list related helpers do not
> modify the counter, and the paths that change a dentry between
> positive and negative only do so if DCACHE_LRU_LIST is set.
> 
> The problem with this is that a dentry on a shrinker list still has
> DCACHE_LRU_LIST set to indicate ->d_lru is in use. The additional
> DCACHE_SHRINK_LIST flag denotes whether the dentry is on LRU or a
> shrink related list. Therefore if a relevant operation (i.e. unlink)
> occurs while a dentry is present on a shrinker list, and the
> associated codepath only checks for DCACHE_LRU_LIST, then it is
> technically possible to modify the negative dentry count for a
> dentry that is off the LRU. Since the shrinker list related helpers
> do not modify the negative dentry count (because non-LRU dentries
> should not be included in the count) when the dentry is ultimately
> removed from the shrinker list, this can cause the negative dentry
> count to become permanently inaccurate.
> 
> This problem can be reproduced via a heavy file create/unlink vs.
> drop_caches workload. On an 80xcpu system, I start 80 tasks each
> running a 1k file create/delete loop, and one task spinning on
> drop_caches. After 10 minutes or so of runtime, the idle/clean cache
> negative dentry count increases from somewhere in the range of 5-10
> entries to several hundred (and increasingly grows beyond
> nr_dentry_unused).
> 
> Tweak the logic in the paths that turn a dentry negative or positive
> to filter out the case where the dentry is present on a shrink
> related list. This allows the above workload to maintain an accurate
> negative dentry count.
> 
> Fixes: af0c9af1b3f6 ("fs/dcache: Track & report number of negative dentries")
> Signed-off-by: Brian Foster <bfoster@redhat.com>
> Acked-by: Ian Kent <ikent@redhat.com>
> ---
> 
> Hi Christian,
> 
> I see you already picked up v1. Josef had asked for some comment updates
> so I'm posting v2 with that, but TBH I'm not sure how useful this all is
> once one groks the flags. I have no strong opinion on it. I also added a
> Fixes: tag for the patch that added the counter.
> 
> In short, feel free to grab this one, ignore this and stick with v1, or
> maybe just pull in the Fixes: tag if you agree with it. Thanks.

This might also want a:

Cc: stable@vger.kernel.org # v5.0+

just FWIW. Given the mild panic On The Internet about negative dentries, an
artificial and permanent increase in the counter is probably adding to the
worries.

Thanks,
-Eric

