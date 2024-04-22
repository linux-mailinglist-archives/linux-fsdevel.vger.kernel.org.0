Return-Path: <linux-fsdevel+bounces-17389-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38F538ACEFF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Apr 2024 16:09:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42623B237C9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Apr 2024 14:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8EEF1509A1;
	Mon, 22 Apr 2024 14:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="L5B7yx4f"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC39E15099E;
	Mon, 22 Apr 2024 14:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713794982; cv=none; b=D0d3BOAq704KKk3tJ6mN6oSzqGweir11DhPRb/a0Iadv7mq/eNVgK+A2DZsBFdny0TIkmvtIlJ+/lOeBk+oBZkcbf3YqnGdaRDkPHzCP+7Oma5pkNzDP7HAU0JUx7PVlxSQbjWmRzAEOO9Nd69d8HyOR4iC5++jiaQpAPRL/WoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713794982; c=relaxed/simple;
	bh=N3QI/yvfE9mMO9UX56rE9oNZSYLeaFSevm4oA3XFCiM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rl4GfYr3D8woOMutEROa9MBT4fvGjLD074iCfrCRmXUoovmt/js1zOogETcM7bpRXvIX4VvY4P1xNhv6TlOs3popcUYqtUzcN0dRTMP6p9jiCny5Z+vIBhB8Azq1JFDC6Q6htKeOB8q+xo6pJHdjqiEIoOLifaShti6JTP3BBrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=L5B7yx4f; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4VNRvj25tqz9sqs;
	Mon, 22 Apr 2024 16:09:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1713794977;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hiZJhujvPgZHkOD9PJsqHhFuCGuUZLC3pFCvmi4/afs=;
	b=L5B7yx4f8IdB/n8OlpIVFYN0mwK6BIUitWtyeu8ipcinpiwhr5BZvd5G0hNIXI2szK0Vcq
	JIIxqRKqLOpCNoOtruRt4CfsDwJNH2kbg7bIuDgm2lcSBetJEz8DPeHwKhWGG/5E+/GrmS
	QDJ0r3Qo6nSHqpI9paq3DunEWYXYYWC41cK53Cry93r5OykdW3O7H99csdK28YmAmwlnSb
	Fy1+GTnYRJpZqNXB4//IQQp7ATHEo25V1Vf0yrtrbphhlHHwmC+4YeAyYcIUdGvB9z2jHv
	Df7WjB1BxNxCQHksvPD1HQbUNkx2TdHuLaNnaR6TDN6TL1g55iZHC057JMtRgw==
Date: Mon, 22 Apr 2024 16:09:33 +0200
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>, fstests@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, willy@infradead.org, p.raghav@samsung.com, da.gomez@samsung.com, 
	hare@suse.de, john.g.garry@oracle.com, linux-xfs@vger.kernel.org, 
	patches@lists.linux.dev
Subject: Re: [RFC] fstests: add mmap page boundary tests
Message-ID: <ldgz6z4r6bt44evqe46ngmd5w5ienxjnrk446ktxpdpksqxsl4@fw4sjusyq6ub>
References: <20240415081054.1782715-1-mcgrof@kernel.org>
 <20240415155825.GC11948@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240415155825.GC11948@frogsfrogsfrogs>
X-Rspamd-Queue-Id: 4VNRvj25tqz9sqs

> > +setup_zeroed_file()
> > +{
> > +	local file_len=$1
> > +	local sparse=$2
> > +
> > +	if $sparse; then
> > +		$XFS_IO_PROG -f -c "truncate $file_len" $test_file
> > +	else
> > +		$XFS_IO_PROG -f -c "falloc 0 $file_len" $test_file
> > +	fi
> > +}
> > +
> > +round_up_to_page_boundary()
> > +{
> > +	local n=$1
> > +	local page_size=$(_get_page_size)
> > +
> > +	echo $(( (n + page_size - 1) & ~(page_size - 1) ))
> 
> Does iomap put a large folio into the pagecache that crosses EOF, or
> does it back down to base page size?

No, we back it down to the base page size if the higher order folio
crosses EOF. But this changes when we have the LBS support as we need to
guarantee the base folio order that will be based on the filesystem BS.

