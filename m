Return-Path: <linux-fsdevel+bounces-58325-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DD23B2CA50
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Aug 2025 19:15:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1FDA7B8F65
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Aug 2025 17:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DED142FD1A4;
	Tue, 19 Aug 2025 17:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="shnnu0Ex"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40DF123CF12;
	Tue, 19 Aug 2025 17:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755623713; cv=none; b=NhdTU+sDoF+32Az9QdQfFfZ95iZBD4QiqpGYUhL8Odd19CFqrjBIo7Mh3CqdbjoIhIVs1dSDvn6qx93dKFarflvcvOqIFh3dT4QLRENVA5WBdoVng8r5+hT0a2UznSXDw+h6C8Evk0sTkg9XC2Vs7Hr1aZ9KIJLtO7+6RxYreCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755623713; c=relaxed/simple;
	bh=ax3Wrz64+irSjkjwqsQbXNTCEf04FRP+UWIxlwJ6EYo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YC/S0Gd7D4LYcv9UXv8aZrzduv4rx3GqUfg7AeZe0LSCI3NWbN6VFNlzkAbpGzAQQ5AjeVaeN8tEsDjd/Bog73wuEQqmSQaq2ELEHPsE8p/ntody8H0xbAEON/q8Kc6GJwQEhF+zpJHBkkgqnFbs4wEl/YGZE49UOwUzOYi4BtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=shnnu0Ex; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ax3Wrz64+irSjkjwqsQbXNTCEf04FRP+UWIxlwJ6EYo=; b=shnnu0ExgwO5ug+1NjNkSaywhv
	orlrcgYpxLBCIPL8tEgBKOi7tWJ9kNY8WwO8hJ+rE+3AWo1EwSUWgUqSOfmbWqwxJxCOfW8cnFr9h
	bG2CKBSPrqMbKIuA4Zsa+wAlMtH9XSCOzyzbcVe0bIjVJPaneNmy2ess+jZOw12WmB7mZ79DsgJIp
	1TPnHMjoIABaUDoafap4m7If+qd4ofc37VhvtPU8bBtZXdQnLyyXuz0HcozE0L/i3Gcd2bfHgU3CL
	TuA0KOhauDDXEoUN1BVh1gQxDKkyKiZYqiXTR+dvWQpioTP3/8PqdYKErMX8LkTQL7rWWjI/N1Paa
	F5VJu+JQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uoPvQ-00000000cMk-0oYq;
	Tue, 19 Aug 2025 17:15:08 +0000
Date: Tue, 19 Aug 2025 18:15:08 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Shrikant Raskar <raskar.shree97@gmail.com>
Cc: brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH] fs: document 'name' parameter in name_contains_dotdot()
Message-ID: <20250819171508.GI222315@ZenIV>
References: <20250818182652.29092-1-raskar.shree97@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250818182652.29092-1-raskar.shree97@gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Aug 18, 2025 at 11:56:52PM +0530, Shrikant Raskar wrote:
> Adds a brief description of the 'name' parameter to resolve
> the kernel-doc warning.

See https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?h=fs-next&id=4e021920812d164bb02c30cc40e08a3681b1c755

