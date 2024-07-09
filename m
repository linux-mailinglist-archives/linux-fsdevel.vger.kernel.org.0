Return-Path: <linux-fsdevel+bounces-23451-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D72CF92C6C9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jul 2024 01:51:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2798A283F4F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jul 2024 23:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9742F18C16B;
	Tue,  9 Jul 2024 23:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DCzTmhwt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D97901474BE;
	Tue,  9 Jul 2024 23:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720569064; cv=none; b=TFvvw2c/yr6PwYfrGzm6e1X5N/XUsWe2WItObIjs2vjViq9ID1xxFxLYHEd15GReIPunxWkAJpg+eR5iv4qftlpHDkkmAlxBt+N1fD5ex+L9etrXb97uHhGmV9ZdAfmgOnh2OXFkguOpnxM9eHSSl1l0qR6X5CrjLcJfqXJQKvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720569064; c=relaxed/simple;
	bh=06szhZhvI5y/0ml1HztEAZfKngl9g/YYJWu9WNQ4sLM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rI+84Xf2G2rgFW86L2Zm+CaVFbcWAOIddwGqcFuW3PFvXG158EE3UuvVWI2bS9S2T+3Fy8Ii4WSpCg5yrDIJKu8pZgiPXCIWcBiZepm8uPvj+9eFzRhhlsc8i4kNrQEkMWZbuILInTWRCiF6gSxpigOPwAX40AGoaZHbzdrBjSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=DCzTmhwt; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description;
	bh=1MnKJi0jeAHhcjlp5AtWFQ8iIjqs+OJI3rZ7gK/CmMU=; b=DCzTmhwt94ownkzIzPjjLO9YFf
	eu92ryb30Y5fTRUbNpYryFLMftlaguCeCXoN5EOazjbAsFOs+tBSCQRNU7Q9+73B6Auj6hO18pDHa
	tVqNTGWjeWJdyOsHdlhu3/6ety3pwwmck57aAkc4fbaq1wmZauOvq+WLqpISS8yRZqCLos8OaPI4C
	hs61AA6++huLcis6+2wfhFY8FKzdLoiDZGfl8hPNz2QPC/0WLP/nmKUoFVXt2uML9oLLHVZjGnISQ
	SNynxgD4UGwrFpzo35YzDs92U2UM4UsY3+jCn/D4vFLAhvCA1+Qv96t7MNQa7spkBp1odrX3/w5pV
	UYTO+k7A==;
Received: from [50.53.4.147] (helo=[192.168.254.17])
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sRKbT-00000008U6L-2tpi;
	Tue, 09 Jul 2024 23:50:35 +0000
Message-ID: <420ac42f-dad2-4fd9-b36a-6405d14b6e25@infradead.org>
Date: Tue, 9 Jul 2024 16:50:24 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/9] Documentation: add a new file documenting
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
 Kent Overstreet <kent.overstreet@linux.dev>, kernel-team@fb.com,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
 linux-ext4@vger.kernel.org, linux-btrfs@vger.kernel.org, linux-mm@kvack.org,
 linux-nfs@vger.kernel.org, linux-doc@vger.kernel.org
References: <20240708-mgtime-v4-0-a0f3c6fb57f3@kernel.org>
 <20240708-mgtime-v4-5-a0f3c6fb57f3@kernel.org>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240708-mgtime-v4-5-a0f3c6fb57f3@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/8/24 8:53 AM, Jeff Layton wrote:
> Add a high-level document that describes how multigrain timestamps work,
> rationale for them, and some info about implementation and tradeoffs.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  Documentation/filesystems/multigrain-ts.rst | 120 ++++++++++++++++++++++++++++
>  1 file changed, 120 insertions(+)
> 
> diff --git a/Documentation/filesystems/multigrain-ts.rst b/Documentation/filesystems/multigrain-ts.rst
> new file mode 100644
> index 000000000000..e4f52a9e3c51
> --- /dev/null
> +++ b/Documentation/filesystems/multigrain-ts.rst
> @@ -0,0 +1,120 @@

> +Inode Timestamp Ordering
> +========================
> +
> +In addition just providing info about changes to individual files, file

   In addition to just

> +timestamps also serve an important purpose in applications like "make". These
> +programs measure timestamps in order to determine whether source files might be
> +newer than cached objects.


