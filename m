Return-Path: <linux-fsdevel+bounces-60396-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FE2DB4662F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Sep 2025 23:52:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FA855C22C2
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Sep 2025 21:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B329290DBB;
	Fri,  5 Sep 2025 21:52:24 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from swift.blarg.de (swift.blarg.de [138.201.185.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFC2A26B951;
	Fri,  5 Sep 2025 21:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=138.201.185.127
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757109143; cv=none; b=feiKVkSMg++sFXTab+hfkCC3kDzdlYc4ne+VoXgSOdDXelsD99NcVZi9tQzqbd1WEL9hf41+UlOLIt2dYgpfolAxl9raLPMGKpIywv/YqRwEfSVrUrjUcUBU3WDnF6BvK2pgLoXfHRjC3wfJpXA1A16bg60NpNc+xY4qXwE/kkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757109143; c=relaxed/simple;
	bh=z4asl2Bapb25K91UXoz+IWGdFgPTbl7/0HoRKT7Rf+w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mTWAaF/YGRrRJxmuuwZFas8wqj22XGstqdFoz3bpzqrO61fAYOc1Sd8qpNwsvF0UeDiQH+17XuvImYhvc8QT+cXbwt3BBLBX3GWWwunPch09oDA6Po8GByGSYRQuy4/gRWORDO4pmDLzogWvDu/R47qzGzmP/V3Eh4EhLbC0KII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blarg.de; spf=pass smtp.mailfrom=blarg.de; arc=none smtp.client-ip=138.201.185.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blarg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=blarg.de
Received: from swift.blarg.de (swift.blarg.de [IPv6:2a01:4f8:c17:52a8::2])
	(Authenticated sender: max)
	by swift.blarg.de (Postfix) with ESMTPSA id BAFDC409CE;
	Fri,  5 Sep 2025 23:43:07 +0200 (CEST)
Date: Fri, 5 Sep 2025 23:43:06 +0200
From: Max Kellermann <max@blarg.de>
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org, idryomov@gmail.com,
	linux-fsdevel@vger.kernel.org, pdonnell@redhat.com,
	amarkuze@redhat.com, Slava.Dubeyko@ibm.com, vdubeyko@redhat.com
Subject: Re: [RFC PATCH 02/20] ceph: add comments to metadata structures in
 buffer.h
Message-ID: <aLtZatfYT7jy4sdL@swift.blarg.de>
References: <20250905200108.151563-1-slava@dubeyko.com>
 <20250905200108.151563-3-slava@dubeyko.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250905200108.151563-3-slava@dubeyko.com>

On 2025/09/05 22:00, Viacheslav Dubeyko <slava@dubeyko.com> wrote:
> Claude AI generated comments

Is LLM-generated text acceptable in the kernel?  Last week, I was
asked to add more explanations to a patch, but it was rejected because
I was accused of having used a LLM.

I feel that asking others to review LLM-generated content is a DoS on
their time.

>  /*
> - * a simple reference counted buffer.
> - *
> - * use kmalloc for smaller sizes, vmalloc for larger sizes.
> + * Reference counted buffer metadata: Simple buffer management with automatic
> + * memory allocation strategy. Uses kmalloc for smaller buffers and vmalloc
> + * for larger buffers to optimize memory usage and fragmentation.

This rephrasing done by your LLM is wrong.  Previously, the buffer
(i.e. the struct) was "simple".  Now, the management of this data
structure is called "simple".  Can you explain why you thought
changing this meaning is an improvement?

Even ignoring this part, I don't see any other improvement here.  This
just expands the wording (requires more time to read) but adds no
value.

>   */
>  struct ceph_buffer {
> +	/* Reference counting for safe shared access */

This is not "reference counting", but a "reference counter".  But who
really needs to be taught what a "struct kref" is?

And what does "safe shared access" mean?  This wording sounds like
it's for (thread) synchronization, but it's really only about knowing
when the object can be freed because no reference exists.

>  	struct kref kref;
> +	/* Kernel vector containing buffer pointer and length */

I don't think it is helpful to add an explanation of what a "struct
kvec" consists of here.  This is just redundant noise.

>  	struct kvec vec;
> +	/* Total allocated buffer size (may be larger than vec.iov_len) */
>  	size_t alloc_len;

This is the only useful piece of information added by this patch,
albeit trivial enough for everybody to induce from the name.

I'm not so excited about what you got from Claude here.

