Return-Path: <linux-fsdevel+bounces-10853-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D937F84EB44
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 23:08:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FDAD28219D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 22:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B4EC4F5EA;
	Thu,  8 Feb 2024 22:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="pvXwtUFh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0B74C618;
	Thu,  8 Feb 2024 22:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707430119; cv=none; b=oOHUwG+hZfF6tD2JXWeiuXkPf83R4pK6003u8Dl7dsb0V8ss8nn4bh/aeD3OQMegMdhbdJHR7k0vdypt2DK/iKYwYdnoQVoLUg6UDxzsN1oHEMUdJR8IdVZgGDcSjtfntaF4tdS/bNQnPkh2CUlGxjvmV1Yo8/bHXFhirCA5Zos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707430119; c=relaxed/simple;
	bh=DWcVwGwm4VSukQ0xPCGs4U0jnfw399A4ZmqrGg/YgJs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uuvGhcZhifpy4oTI75YwWjMUIYxNPD0nZxecDXO8xL7MJtMw9tzKqQQG05S9wBauJXFLmknV7iD7RhMQsRVxhc1NTAPQf1JTVInr2MR+eEdLQV0sI5DIPNiqFTs5JRgBmdLNf7NTFe/mbp01iTey+u2WCbPF1cDIC84NxLPFWgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=pvXwtUFh; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1707430117;
	bh=DWcVwGwm4VSukQ0xPCGs4U0jnfw399A4ZmqrGg/YgJs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=pvXwtUFhgeVvx2582poFGpdLn4e84OXb6e+lt5m3RtKKFztJvjjYPw3dLHyPgPs2b
	 IS2LXApPzszPggcxAJ0JWBeDevrO0arwy6F0pTHe8KvT8mxX60SHdgdqGQzyxwfgWi
	 9cAqKqJskuuS8bCDI0ahqrHk1zyrHtma49UtuQ8eXKCNzjQwxjZUOIvtwOtWLGvDIM
	 rARHoZSfk7IXqYLbTLRvAbWEF01XGt2LAdQZj85dd1v8Hs9cYWrGBC2Uo1WX+PDWWB
	 scQo1OpY8nQr9bNz97NKklh/0u9OEvM/h9bRsOF8m7ZE6j4pUX2CXkE2j+kZgf9wb7
	 WMxkl7hqzPwbA==
Received: from [172.16.0.134] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4TWB2Y0QYpzY0N;
	Thu,  8 Feb 2024 17:08:37 -0500 (EST)
Message-ID: <d3a3ef0c-7bc9-421a-9308-85d7b4a8fad1@efficios.com>
Date: Thu, 8 Feb 2024 17:08:43 -0500
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 04/12] dcssblk: Handle alloc_dax() -EOPNOTSUPP failure
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
 <20240208184913.484340-5-mathieu.desnoyers@efficios.com>
 <65c549405cee8_afa429495@dwillia2-xfh.jf.intel.com.notmuch>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <65c549405cee8_afa429495@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-02-08 16:36, Dan Williams wrote:
[...]
> Just another "ditto" on alloc_dax() returning NULL so that the ternary
> can be removed, but otherwise this looks good.

Done.

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


