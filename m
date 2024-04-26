Return-Path: <linux-fsdevel+bounces-17892-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB69D8B3789
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Apr 2024 14:54:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67038283AC9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Apr 2024 12:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 890F4146D4A;
	Fri, 26 Apr 2024 12:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="BTuW3g2S"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B732213E88A;
	Fri, 26 Apr 2024 12:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714136066; cv=none; b=KxGHt6qzLeYXT9ZqpCpMNX2lWexmcci75/A1wG0mQiLCXqX+jLYwR/25MYPitT3Z8xwfL6mpazCndjNcx/vk+UO5rO/XB+cGfGEG10Y60x5HTolgZ28Qq6N/B1bgSYUIRePY9fUHCboLAua24zDLv8u/lnRTJpaXA8l36Pad7vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714136066; c=relaxed/simple;
	bh=PxjWk/DnfndZp7Tnn7yylcFvdTm55zeOL5HaDoGiQmk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=obj1MlVzxMKCzOWkkuoldF+OyflLenn5/gMRgu6r4j4mxxhG8mJMUfeI4E56btQEoym8Ny3fC0ny5OoM8Yu83Mj3e1xchap3AGurIRxBxE3qUw5Ini+2QOfLi/O4Y/PVuuVbPiPAhe2wi9OvSSoO/iAeE5E4RIRyAP1LDqK5Zt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=BTuW3g2S; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4VQt2t2hJHz9sWd;
	Fri, 26 Apr 2024 14:54:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1714136054;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gvK113BQiEHRRB+jUoKp4pYoXm1qV6dv7bI+yo26L2s=;
	b=BTuW3g2SAvenk5ulUQkTFm/sWdNlXv7N24BPmPPBaebmxLqAgsb6/bjYKvZFi1tXEyURDs
	FFtbT8+qEIgbOeyGBt6/Ck0n5PbnTRU/Kd7YkQauiA/i1GguM1ng3uvFUQQkPwATqo2ltU
	6Z4HHR9ONyV6D+sa7/PCLEKNuQqk6pNlhb5WAvyO4P/T9su5NU/w8YKk8Zv1ZpkK4xNbX+
	FbiE6k/QnNgoeVNPla27GvFtpgRdYs8WJRCkI0Wr8sdUqH4vs7BzuLD8ERFRkmPHmdS3mC
	69dnlhPWlRY9OFVf+HF+kIqZ0A8drq895qT8D/8OIEonLq3EAkTWcA2vYKuiBA==
Date: Fri, 26 Apr 2024 12:54:10 +0000
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: djwong@kernel.org, brauner@kernel.org, david@fromorbit.com,
	chandan.babu@oracle.com, akpm@linux-foundation.org,
	linux-fsdevel@vger.kernel.org, hare@suse.de,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-xfs@vger.kernel.org, mcgrof@kernel.org, gost.dev@samsung.com,
	p.raghav@samsung.com
Subject: Re: [PATCH v4 06/11] filemap: cap PTE range to be created to i_size
 in folio_map_range()
Message-ID: <20240426125410.myhl33aewkd6wpzf@quentin>
References: <20240425113746.335530-1-kernel@pankajraghav.com>
 <20240425113746.335530-7-kernel@pankajraghav.com>
 <Ziq8ATyM_c5zEOkd@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ziq8ATyM_c5zEOkd@casper.infradead.org>

On Thu, Apr 25, 2024 at 09:24:33PM +0100, Matthew Wilcox wrote:
> On Thu, Apr 25, 2024 at 01:37:41PM +0200, Pankaj Raghav (Samsung) wrote:
> >  	do {
> >  		unsigned long end;
> > +		unsigned long i_size;
> 
> Usually i_size is the name of a variable that contains an loff_t, not a
> page count.  Not sure what to call this though.  Also, can't we move
> this outside the loop?
You are right, this can move out as i_size is not going to change. I
will make this change. Thanks!
> 
> 	pgoff_t file_end = DIV_ROUND_UP(i_size_read(mapping->host),
> 					PAGE_SIZE) - 1;
> 
> 	if (end_pgoff > file_end)
> 		end_pgoff = file_end;

--
Pankaj

