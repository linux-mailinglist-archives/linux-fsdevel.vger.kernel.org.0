Return-Path: <linux-fsdevel+bounces-11428-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CB40853BF5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 21:07:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADCA028342D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 20:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C801960BA5;
	Tue, 13 Feb 2024 20:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="ePAd/JKT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EB5D608ED;
	Tue, 13 Feb 2024 20:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707854861; cv=none; b=lTY4Gw7KjiFJG8rgZzo+Gyt/iwVslu3dzYIrOGISg69yXc2l59NA3+JzfGILIHAT6yB0qkFpO05W+nYwDaW2Fo9jzo3FEmCOA8A0t4d06UAUf9PSuOuO8RHA32efdRYCNAN1nVgI6yn120uzkfrJOjGXYin4Vsec+3zuIEWX9XY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707854861; c=relaxed/simple;
	bh=alxn2JLgjr0DojlbSs97ulyVsMi+u/5tolBs0g7cDYY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X3/6AJRHdP89cAjyKJomQMTquNNK7lmrPxuzZ8/ANsQ3BjMPEB94sA+WKdaSyCKPd/O7TJPIAmihhfTXrQQJ1ZWargmAYSofDXH/TZBfhB3i+dZX7ge2crOW5UfImS8+HlFB784oylC51YeczlVnLvZS9PK3fATgrRUoXjiZwfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=ePAd/JKT; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1707854858;
	bh=alxn2JLgjr0DojlbSs97ulyVsMi+u/5tolBs0g7cDYY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ePAd/JKT5l1npVFtLSV92syRc0qQPEbJ6J160gC0b8WCC4dfDbW3EG1UGk0O5grua
	 7gWfpMGssKwTjxMg4GUq/aFmu26AMPY3qL5JMZGZ0MHU7n6tPThIRg4j5C77qVIgYj
	 KB5T4c5VUB5nPWPR2oV+Wc19YFld74wNPWRE8yeG4s5GHgkHCm9B9O2XnpcDEnb8BJ
	 FUycIX80oLfkPuXd8okFwOzXpUCcq/BBbcrkxe7atQaJsFX+gMXFJFaC0gPfoRc/oN
	 IakJ/XDGnn2jCaia1G87Xxyc0CAgNn0GXEwkZpH+KCD4H+sd7BKYfjF38aPyzNQkLL
	 FAFRufc1+XJww==
Received: from [172.16.0.134] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4TZC6f27bSzYsQ;
	Tue, 13 Feb 2024 15:07:38 -0500 (EST)
Message-ID: <457bde90-5ce7-4c60-9268-e5980ddf6cc0@efficios.com>
Date: Tue, 13 Feb 2024 15:07:38 -0500
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/8] dax: alloc_dax() return ERR_PTR(-EOPNOTSUPP) for
 CONFIG_DAX=n
Content-Language: en-US
To: Dan Williams <dan.j.williams@intel.com>, Lukas Wunner <lukas@wunner.de>
Cc: Arnd Bergmann <arnd@arndb.de>, Dave Chinner <david@fromorbit.com>,
 linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Matthew Wilcox <willy@infradead.org>, Russell King <linux@armlinux.org.uk>,
 linux-arch@vger.kernel.org, linux-cxl@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-xfs@vger.kernel.org, dm-devel@lists.linux.dev, nvdimm@lists.linux.dev,
 linux-s390@vger.kernel.org
References: <20240212163101.19614-1-mathieu.desnoyers@efficios.com>
 <20240212163101.19614-2-mathieu.desnoyers@efficios.com>
 <20240213063226.GA4740@wunner.de>
 <65cbbdfe19172_29b129476@dwillia2-mobl3.amr.corp.intel.com.notmuch>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <65cbbdfe19172_29b129476@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-02-13 14:07, Dan Williams wrote:
> Lukas Wunner wrote:
>> On Mon, Feb 12, 2024 at 11:30:54AM -0500, Mathieu Desnoyers wrote:
>>> Change the return value from NULL to PTR_ERR(-EOPNOTSUPP) for
>>> CONFIG_DAX=n to be consistent with the fact that CONFIG_DAX=y
>>> never returns NULL.
>>
>> All the callers of alloc_dax() only check for IS_ERR().
>>
>> Doesn't this result in a change of behavior in all the callers?
>> Previously they'd ignore the NULL return value and continue,
>> now they'll error out.
>>
>> Given that, seems dangerous to add a Fixes tag with a v4.0 commit
>> and thus risk regressing all stable kernels.
> 
> Oh, good catch, yes that Fixes tag should be:
> 
> 4e4ced93794a dax: Move mandatory ->zero_page_range() check in alloc_dax()
> 
> ...as that was the one that updated the alloc_dax() calling convention
> without fixing up the CONFIG_DAX=n case.
> 
> This is a pre-requisite for restoring DAX operation on ARM32.

I'll change the Fixes tag in this commit to:

Fixes: 4e4ced93794a ("dax: Move mandatory ->zero_page_range() check in alloc_dax()")

for v6.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


