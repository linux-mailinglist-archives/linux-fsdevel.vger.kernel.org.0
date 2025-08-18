Return-Path: <linux-fsdevel+bounces-58191-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 16C7AB2AE5C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Aug 2025 18:39:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 858D0177EC1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Aug 2025 16:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBAE922422A;
	Mon, 18 Aug 2025 16:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BWQKoTOj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB5323D7D3
	for <linux-fsdevel@vger.kernel.org>; Mon, 18 Aug 2025 16:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755535036; cv=none; b=IMvSnG2nUCotsLGcvurZ1IcQDZHNyE8OgD0fl4u82QlvyX4O21NEoZv+vL19W6vPZtwsPShIB7MSLql8VcG+et1APuGaLJjFxMWnzJpKJujkS+0oUEsDVTuIiJjp7BANIs4kq8hG5p0vmUw1l5rC/Ixh9J7Vmxb2L14JUG4izZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755535036; c=relaxed/simple;
	bh=CXsqL/lHCm+cMFq/tlqgDl87AfsAugv/SBOIgN84Ue0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wjs3W27Hr+CsT4yznVx1Cy339cSlfhPBi/uvBpbb7c0AmYG+Wo0pO7MzXyPUxQ0jr7A3SnXJA5jtdJK+8AnfK5vilp5pcGyOPnb+aa9sE5hcATl8zjmrLQYDbAgNr3gw1WrzD9NLYX/kDuk110HJjif9rsjwGwF9E+X+rwY/Zy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BWQKoTOj; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 18 Aug 2025 09:36:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755535017;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zyF8w0ug34YvP5h7YWfOovC3eabcMuzPu9gaq703vMM=;
	b=BWQKoTOjJAeg4ipv6fK8Ni7Adn19kl83Nn8j2/nL/VJeDPG13FOQHnsIQM96vulIIi2LxN
	W1tkkuQTVtgtz56jrp0ILxSONjpanH3QZC3lMFvNO5hFWyOEoeD83DnEwUIXx7Jj9gC4L+
	fqR41CjDwS1kp4FtVdlWSSJJN1SjesM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: syzbot ci <syzbot+ciacf14517a343602e@syzkaller.appspotmail.com>
Cc: boris@bur.io, kernel-team@fb.com, linux-btrfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, willy@infradead.org, wqu@suse.com, 
	syzbot@lists.linux.dev, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot ci] Re: introduce uncharged file mapped folios
Message-ID: <d63fvoc3ans2d4xsuzsavchg3g6b3a5ao6osckrkwgwe3354zq@fp5nxj23krys>
References: <cover.1755300815.git.boris@bur.io>
 <68a19424.050a0220.e29e5.0065.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68a19424.050a0220.e29e5.0065.GAE@google.com>
X-Migadu-Flow: FLOW_OUT

On Sun, Aug 17, 2025 at 01:34:44AM -0700, syzbot ci wrote:
> syzbot ci has tested the following series
> 
> [v2] introduce uncharged file mapped folios
> https://lore.kernel.org/all/cover.1755300815.git.boris@bur.io
> * [PATCH v2 1/3] mm/filemap: add AS_UNCHARGED
> * [PATCH v2 2/3] mm: add vmstat for cgroup uncharged pages
> * [PATCH v2 3/3] btrfs: set AS_UNCHARGED on the btree_inode
> 
> and found the following issue:
> WARNING in folio_lruvec_lock_irqsave

Ok that is expected and we need to fix the warning instead. We can
either remove this warning or make is only applicable to non-file
folios.


