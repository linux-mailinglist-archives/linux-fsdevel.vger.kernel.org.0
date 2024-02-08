Return-Path: <linux-fsdevel+bounces-10850-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 963D184EB1C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 23:05:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5214728AD17
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 22:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 292714F88B;
	Thu,  8 Feb 2024 22:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="QPi9w618"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13CEE4F887;
	Thu,  8 Feb 2024 22:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707429893; cv=none; b=HRGpOlHSudXx98mraS00fQTeGwymlfkYNU5Qy9R5MefgoqgyiqIeUrYOM1L21IfgyvnEFB8zEWPuiGS/wOjapn8ENrQnFlXvNAqT0MYiqLJM3UxGnKGLIr2UyOfj283O9nvv/R7jdCWHJfWZDY9FguTcrG9kencRzoYpipQ4vwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707429893; c=relaxed/simple;
	bh=Lj0yj5k2Ucs4SxuNKFcA0jefNpL/MeJWdfUW/qhrm9Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XZEmVnMVVTVyJQYN9JtdCFv5RCxgD5z6TDtaE+gMUT80HN757GB3j3F/2dHGitEAVktCdoHlOkwaIkVbryFrm8CnihOaLF7hhkYcOi80W//nz+o/7w1vorqK0+rVwt+j20ZA2eK+trLIXePb41fvA8dKUz6MC/q0O/da1qoWQO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=QPi9w618; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1707429887;
	bh=Lj0yj5k2Ucs4SxuNKFcA0jefNpL/MeJWdfUW/qhrm9Y=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=QPi9w618PKwnA9XXOQgmCJB1PCRsMn9Uf67yi2RMSz+npuqM1XhKC7wv0qn/5qaPZ
	 HtBBgHJW61pZKEUsgM3zLsLXEe86GqM9Phz9OBoAMCs4XewbLcgNcWisq0fpdud38S
	 4+Cak3UtLlm7WZZcn4+/e6iz1E4DwB1CN767MGyarGK4n5Em+teSI+EgIpfRi5kayu
	 FZw7bi34H+EYdcnCWkmUKL9ZD5zDBU6c7Yy7VjUqHCA/Jl05m7ySivgFkCGTg3BslR
	 2YD+qB8C1BDraBeGGpeO0/Ly1umtbT7QEm6IpByZbYEiI7Av04b1Noi+TDQJ0soltb
	 Y9mP8c1pyefEQ==
Received: from [172.16.0.134] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4TW9y72DKCzXtH;
	Thu,  8 Feb 2024 17:04:47 -0500 (EST)
Message-ID: <acb2ca39-412a-4115-95c5-f15e979a43bb@efficios.com>
Date: Thu, 8 Feb 2024 17:04:52 -0500
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/12] nvdimm/pmem: Fix leak on dax_add_host() failure
Content-Language: en-US
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Dan Williams <dan.j.williams@intel.com>, Arnd Bergmann <arnd@arndb.de>,
 Dave Chinner <david@fromorbit.com>, linux-kernel@vger.kernel.org,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Matthew Wilcox <willy@infradead.org>, Russell King <linux@armlinux.org.uk>,
 linux-arch@vger.kernel.org, linux-cxl@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-xfs@vger.kernel.org, dm-devel@lists.linux.dev, nvdimm@lists.linux.dev,
 linux-s390@vger.kernel.org, Alasdair Kergon <agk@redhat.com>,
 Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>
References: <20240208184913.484340-1-mathieu.desnoyers@efficios.com>
 <20240208184913.484340-2-mathieu.desnoyers@efficios.com>
 <20240208132112.b5e82e1720e80da195ef0927@linux-foundation.org>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <20240208132112.b5e82e1720e80da195ef0927@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-02-08 16:21, Andrew Morton wrote:
> On Thu,  8 Feb 2024 13:49:02 -0500 Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> 
>> Fix a leak on dax_add_host() error, where "goto out_cleanup_dax" is done
>> before setting pmem->dax_dev, which therefore issues the two following
>> calls on NULL pointers:
>>
>> out_cleanup_dax:
>>          kill_dax(pmem->dax_dev);
>>          put_dax(pmem->dax_dev);
> 
> Seems inappropriate that this fix is within this patch series?
> 
> otoh I assume dax_add_host() has never failed so it doesn't matter much.
> 
> 
> The series seems useful but is at v4 without much sign of review
> activity.  I think I'll take silence as assent and shall slam it all
> into -next and see who shouts at me.
> 

Thanks Andrew for picking it up! Dan just reacted with feedback that
will help reducing the patch series size by removing intermediate
commits. I'll implement the requested changes and post a v5 in a few
days.

So far there are not behavior changes requested in Dan's feedback.

Should I keep this patch 01/12 within the series for v5 or should I
send it separately ?

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


