Return-Path: <linux-fsdevel+bounces-28463-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A66F596AFA1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 06:08:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D92281C21CAF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 04:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3AE86A8D2;
	Wed,  4 Sep 2024 04:08:00 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B3A3D6B;
	Wed,  4 Sep 2024 04:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725422880; cv=none; b=pYKCPMx1A+dNMNRzCb6fccY0nKifXvP0wYTMYKW94yD3U8hcgw5AQCm8F2eWRwmdhJ/+L8L+Z07TTcJc6kiYrm9y7mYFJYuq/UbOXK/u302kIj/rRZgBW81E9Sv4G7gmJocV1dwtxm8HOvJWcKnZvSwjdXjKbYZJuZZD8sLOlSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725422880; c=relaxed/simple;
	bh=tBcSusuZE4Kf3Djx/i/NOgc7ib3XJikQkZ9YcqBlkvo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uV6MX6nm/d92PTi9ZdWKyGbzWpcymPSUh46ygAlTThmGh954A3XnSpuGr6p8c3lkBU8Ezh5Ayp2P1ar4kB1okghJM7oOHFC6Bm7pfiDmvdfAYTcjBjnIELQ3HtHXdEReB14n996mwPyvQ5AA8pkQ4Ov+IIhG8AAKtBFkjpb18fU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 9A58268AA6; Wed,  4 Sep 2024 06:07:51 +0200 (CEST)
Date: Wed, 4 Sep 2024 06:07:51 +0200
From: Christoph Hellwig <hch@lst.de>
To: Dave Chinner <david@fromorbit.com>
Cc: Julian Sun <sunjunchao2870@gmail.com>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
	tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz,
	brauner@kernel.org, djwong@kernel.org, hch@lst.de,
	syzbot+296b1c84b9cbf306e5a0@syzkaller.appspotmail.com
Subject: Re: [PATCH] iomap: clean preallocated blocks in iomap_end() when 0
 bytes was written.
Message-ID: <20240904040751.GA13262@lst.de>
References: <20240903054808.126799-1-sunjunchao2870@gmail.com> <ZterXrqAFi9knEbD@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZterXrqAFi9knEbD@dread.disaster.area>
User-Agent: Mutt/1.5.17 (2007-11-01)

Just a quick notice that I'm on vacation this week and only doing an
absolute minimal amount of work in the mornings, as I said before I'm
planning to look into it when I get time.  But just as Dave I suspect
that the patch is papering over the real issue.


