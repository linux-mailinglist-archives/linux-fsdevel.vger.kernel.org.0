Return-Path: <linux-fsdevel+bounces-10852-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 206D884EB3D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 23:08:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53E771C24204
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 22:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B122E4F894;
	Thu,  8 Feb 2024 22:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="rbCIFCFu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80ED14F885;
	Thu,  8 Feb 2024 22:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707430064; cv=none; b=XEv5BDBxoDtXbczph15Z8B9ZsArbV+/DyNKdV4MmLyZsrLfnqwdMoVZMJwOHdzeKW0xOnsmNZPny9+L1xJl8c17eN9eDIBGpEk+MwMlqCcz7YQV8WVs77MTQ9Lqc92C+yWmSazlRr/bK4P2nEWCWzyTlQgXMzMy6/S5tjjMtDN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707430064; c=relaxed/simple;
	bh=NW3Z6hWoXmRxqai8o12W5w34FTKrJ+lQKYdIy/TOHK8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q0c20/gIpZ47rWaxahv6nkaNw9KxfJcBq7pRpM67SxhajLihjZwc33Hg5ABaqwXHxbztAfKQMSbF+6jMTjSA68UhHoV4z8SCfr5R86UObPMDfn9RJPAUWmNXjzYoAuuQsZwyCEB1qOkxYE2uYRDlN9u0MxQShuh1Om1jXWBYPjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=rbCIFCFu; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1707430061;
	bh=NW3Z6hWoXmRxqai8o12W5w34FTKrJ+lQKYdIy/TOHK8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=rbCIFCFuEu+qf9blIK4r/Hk4M/eWuJUQnvyKQPFhR6tti+9MNaffZX1E26cy+qfVP
	 OKgfbZKXoSTyvTNK13AwpTTtkaPnqy9m3ivGK4aIOPtpIehn+aIXa+X1giYdGNaVii
	 yOaeJrOZZNw6RT1zvi2fsVJWRgV7dmKVu0jKyfrJIcmbVhRkl3iXjBbwnUm1/IOEtk
	 PjdeAkVoR76WmptchplrBqCBXmHlmTHfdahEhoWaMKS0qt7+ciGS+6IWIt2QtIO7w3
	 xlXhKeXPsJFcjBjaLduwGmgSGmLpBpGGMyZ1aZbfNoPvZ3FkRUzfQlpd/Bnf87QY4O
	 Aid/FNQz02gBg==
Received: from [172.16.0.134] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4TWB1T2SC2zY9l;
	Thu,  8 Feb 2024 17:07:41 -0500 (EST)
Message-ID: <15939d13-76d0-4a47-84c0-1b194530e145@efficios.com>
Date: Thu, 8 Feb 2024 17:07:47 -0500
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 03/12] dm: Treat alloc_dax() -EOPNOTSUPP failure as
 non-fatal
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
 <20240208184913.484340-4-mathieu.desnoyers@efficios.com>
 <65c548ea54127_afa429463@dwillia2-xfh.jf.intel.com.notmuch>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <65c548ea54127_afa429463@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-02-08 16:34, Dan Williams wrote:
[...]
> Similar feedback as the pmem change, lets not propagate the mistake that
> alloc_dax() could return NULL, none of the callers of alloc_dax()
> properly handled NULL and it was just luck that none of the use cases
> tried to use alloc_dax() in the CONFIG_DAX=n case.

Done.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


