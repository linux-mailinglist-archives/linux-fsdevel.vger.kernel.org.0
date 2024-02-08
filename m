Return-Path: <linux-fsdevel+bounces-10857-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EC8884EB6B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 23:13:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BFC61F21119
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 22:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC40950244;
	Thu,  8 Feb 2024 22:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="iWWcaxmc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC2D4F88C;
	Thu,  8 Feb 2024 22:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707430360; cv=none; b=GR1hBmBihmNmE9pLOnOjoqX4dsK2G3Ko0wyVIsnjBw/YqYmTTL7Iuif1ekYY/bhAFjf6Ew8tstXlMqXy4VJ+DGSDwqfYPxoKnk/JKAmBlQAjhxE7VD5d+zi7ai827gXtxGPOHwG7tjJ2VcKGPPdIkzb2sesk6G8vrXoonoV/3Z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707430360; c=relaxed/simple;
	bh=SaWM1q3KRwkuItGeKAM3LJGUjBgBF2JdvDnT+CbIZAY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SItVJQ1lZmOtIV3WwNo84Zc57wUBRh4OuuIuYTDDGOI7BddaD88e8f/WGHN8wzIkFuUUz0nL4NVYWmNzqvqtNBjwqGo+lH8ctuTSTkVBDknJBjn85PFbwaUUG5Zztl/qI+o8Z5/qrtc29QC78/rsxUz1oqUvq6qqWuIZ0VQtPMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=iWWcaxmc; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1707430358;
	bh=SaWM1q3KRwkuItGeKAM3LJGUjBgBF2JdvDnT+CbIZAY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=iWWcaxmcWqoFAauOWqJqBCtLndtPt2l1BF+/ArVLyJihI6jbAHHUucumYgk+xw26N
	 P3551E3iLtytFyzNQ69/j79OQKihodE5Fy/KSJIyqxv9qWGTnoF3a2LECcmwNBAKsb
	 vcuhi79H9kIfGII2z8Ch9d9dMrCGPMpALLzCh98wCC8UUrH+mYLPkfIrKgMgbmV3zj
	 e9NjeD9+6oFTo+WC/aQYnTqK6LrY8dMHC22nBsHC2Ca7Caib+wQPYkyZsQDs3EMdOn
	 D4/1Ir30vdpd7VyniS+hEcxrCgA7LJR68oCAt+hx0zvvwO/dVzklnH0e+sH9habPdl
	 PmEhO2iFFQnqA==
Received: from [172.16.0.134] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4TWB795fqgzYGM;
	Thu,  8 Feb 2024 17:12:37 -0500 (EST)
Message-ID: <3fd6615a-a17e-4c68-9e92-fd1a6939fdfe@efficios.com>
Date: Thu, 8 Feb 2024 17:12:43 -0500
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 09/12] nvdimm/pmem: Cleanup alloc_dax() error handling
Content-Language: en-US
To: Dan Williams <dan.j.williams@intel.com>, Arnd Bergmann <arnd@arndb.de>,
 Dave Chinner <david@fromorbit.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Matthew Wilcox <willy@infradead.org>, Russell King <linux@armlinux.org.uk>,
 linux-arch@vger.kernel.org, linux-cxl@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-xfs@vger.kernel.org, dm-devel@lists.linux.dev, nvdimm@lists.linux.dev,
 linux-s390@vger.kernel.org, Alasdair Kergon <agk@redhat.com>,
 Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>
References: <20240208184913.484340-1-mathieu.desnoyers@efficios.com>
 <20240208184913.484340-10-mathieu.desnoyers@efficios.com>
 <65c54dc181e01_afa429468@dwillia2-xfh.jf.intel.com.notmuch>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <65c54dc181e01_afa429468@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-02-08 16:55, Dan Williams wrote:
[...]
> 
> Oh... I see you cleanup what I was talking about later in the series.
> 
> For my taste I don't like to see tech-debt added and then removed later
> in the series. The whole series would appear to get smaller by removing
> the alloc_dax() returning NULL case from the beginning, and then doing
> the EOPNOTSUPP fixups.
> 
> ...repeat this comment for patch 10, 11, 12.

Done.

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


