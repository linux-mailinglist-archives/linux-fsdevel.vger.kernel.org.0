Return-Path: <linux-fsdevel+bounces-23799-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A4A38933687
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jul 2024 08:01:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D601E1C22A55
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jul 2024 06:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9078A14A8F;
	Wed, 17 Jul 2024 06:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="T2f0kHzh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A064911712;
	Wed, 17 Jul 2024 06:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721196069; cv=none; b=o94Hiwgs5R9Rqeh8P1lKw8lFZH+Q2Bn6ZCl8nYmPyLnCDds3jIMhkxljZ27fU4Uve34U5zjdr9L9tpgZZVNqPDJpnX1ES8b2CiFdbFUWa0dj4ddATmxdQ/ooNXDOCbOD3ntVB98+LfmAm7BZZ1iKFR7zCU0SDKOmIaUJ46sXxH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721196069; c=relaxed/simple;
	bh=RFXjAgM+5/fsswwUyL7uiUhCLmR4FoPb4Hf8nYZk960=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GJHUDww6S8De/kX2o/ohpWPr+9vymwGFU83s2CIGsUgnCj+jwl4LOd0QFGEyFCTwxLDs8NVlS+XieDT0pLFAzgz/Losi1wMmr7LAhD7YDvQVEt96vbEJ4qayzHNchWzkrCQP896LJIEPjHxzdr320u9RnFYqsVXTsF5U8ZLfndg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=T2f0kHzh; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=mf6/kkJicUX0q5FPWb7HFODThRUeroz1DuVg1N8KqDw=; b=T2f0kHzh4ncICrqU2OzBRJ1TBE
	DSozUpfaSHF6jQ5mJABEqktRvZkcDaXtP9K83bXsV+Ml48DEoGnuTnNr+r2U8OXc05ebi6+S0gRmk
	1QKIgs56iHnCkzgJeUCifl/101a/zpx+KSOpljmceVLI3WjZVfEymv8iUa1SlLDa1Gn/YEZbHwY9q
	rVVHF8XX9vfMb8hseftIgewdvWFCiArdkHGIFAVFYL9DOp0KSl5vHjbTIqt/T2e6c/tkX3JqXzxCr
	vvULFobdA7cTQHQ4lQPN2D7HzcH/U7lBfNcVnmmK2hWS8woyw+MPoh6IRuiTBvST0xmFvCHF2AR3s
	1ivbwAFg==;
Received: from [50.53.4.147] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sTxic-0000000CkkC-05Bv;
	Wed, 17 Jul 2024 06:00:50 +0000
Message-ID: <c65edd73-57b7-43d1-8012-6bdf318fcced@infradead.org>
Date: Tue, 16 Jul 2024 23:00:45 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 5/9] Documentation: add a new file documenting
 multigrain timestamps
To: Jeff Layton <jlayton@kernel.org>, Alexander Viro
 <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>,
 Jan Kara <jack@suse.cz>, Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Chandan Babu R <chandan.babu@oracle.com>, "Darrick J. Wong"
 <djwong@kernel.org>, Theodore Ts'o <tytso@mit.edu>,
 Andreas Dilger <adilger.kernel@dilger.ca>, Chris Mason <clm@fb.com>,
 Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
 Hugh Dickins <hughd@google.com>, Andrew Morton <akpm@linux-foundation.org>,
 Jonathan Corbet <corbet@lwn.net>
Cc: Dave Chinner <david@fromorbit.com>, Andi Kleen <ak@linux.intel.com>,
 Christoph Hellwig <hch@infradead.org>, Uros Bizjak <ubizjak@gmail.com>,
 Kent Overstreet <kent.overstreet@linux.dev>, Arnd Bergmann <arnd@arndb.de>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
 linux-ext4@vger.kernel.org, linux-btrfs@vger.kernel.org, linux-mm@kvack.org,
 linux-nfs@vger.kernel.org, linux-doc@vger.kernel.org
References: <20240715-mgtime-v6-0-48e5d34bd2ba@kernel.org>
 <20240715-mgtime-v6-5-48e5d34bd2ba@kernel.org>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240715-mgtime-v6-5-48e5d34bd2ba@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/15/24 5:48 AM, Jeff Layton wrote:
> Add a high-level document that describes how multigrain timestamps work,
> rationale for them, and some info about implementation and tradeoffs.
> 
> Reviewed-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  Documentation/filesystems/multigrain-ts.rst | 120 ++++++++++++++++++++++++++++
>  1 file changed, 120 insertions(+)
> 


Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

-- 
~Randy

