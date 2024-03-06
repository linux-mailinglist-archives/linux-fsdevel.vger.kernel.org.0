Return-Path: <linux-fsdevel+bounces-13765-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D18B873A12
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Mar 2024 16:04:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C10251F26870
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Mar 2024 15:04:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE633134CE3;
	Wed,  6 Mar 2024 15:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cybernetics.com header.i=@cybernetics.com header.b="W8ww5OEB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.cybernetics.com (mail.cybernetics.com [72.215.153.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE008131E4B
	for <linux-fsdevel@vger.kernel.org>; Wed,  6 Mar 2024 15:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=72.215.153.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709737434; cv=none; b=tiIGZke5WL0LV81AX1i1qKed6YW0bFqseM83adHXezlvwr9V3k4ndGfAoTFdx4HC2o23zSq9yp+qZp7T1I/2iwCahbLgALB6h9jRNyaQi2gG86HCnPWY4v1C5TmyMbJGj86UIYiwOyO6VUJYUo9I1eTqDLCl6JfCpTc9s5WZGIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709737434; c=relaxed/simple;
	bh=l37PvbgjdurE3CHa9QnNHILZ3KXr3K0O8dJPZpkbpYo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Fpi0l0TuCB5ETE5KaJ+BoZxIWn5bw42KXYJYAPPRajpOU6kauELB0lV23EuOaR5I6GXXSaoWKCg6Gn9k9B7WW+Kfam2ahDZgKX7WShxG6+VVNR6FRt2XJlTHVvEvsPxwRDeFhKe9uFMYEhhkrmUUmVQpHcO74eoSWoujlCQHtok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cybernetics.com; spf=pass smtp.mailfrom=cybernetics.com; dkim=pass (1024-bit key) header.d=cybernetics.com header.i=@cybernetics.com header.b=W8ww5OEB; arc=none smtp.client-ip=72.215.153.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cybernetics.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cybernetics.com
X-ASG-Debug-ID: 1709737400-1cf4391a1c953b0003-kl68QG
Received: from cybernetics.com ([10.10.4.126]) by mail.cybernetics.com with ESMTP id g6dx9Nqb30PiU2Gj; Wed, 06 Mar 2024 10:03:43 -0500 (EST)
X-Barracuda-Envelope-From: tonyb@cybernetics.com
X-Barracuda-RBL-Trusted-Forwarder: 10.10.4.126
X-ASG-Whitelist: Client
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=cybernetics.com; s=mail;
	bh=7qc4ffRYNtvZccYs4/U0SMXhHZBv427Ly9EChqUIDts=;
	h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Content-Language:Subject:MIME-Version:Date:Message-ID; b=W8ww5OEBmzs8NaHgEkoZ
	7JNFDiLMMztKUdLXIcL/jSdNGT9JhIKQmG9mbb3+85HA/frx4z5JdSgfNArLSPFbzOKkZ/LjXeiYo
	AMvEQeTqhnjGUnnl8aH1Jvb+Z+9Mj3gGIEnba//g5rLTdMt6+P2hhKTNxk+GA6yzXWGhhxf/Gk=
Received: from [10.157.2.224] (HELO [192.168.200.1])
  by cybernetics.com (CommuniGate Pro SMTP 7.1.1)
  with ESMTPS id 13115879; Wed, 06 Mar 2024 10:03:26 -0500
Message-ID: <dd86cf53-d884-4a5c-b5b5-eefe1d7641d7@cybernetics.com>
X-Barracuda-RBL-Trusted-Forwarder: 10.157.2.224
Date: Wed, 6 Mar 2024 10:03:25 -0500
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: Fix page refcounts for unaligned buffers in
 __bio_release_pages()
Content-Language: en-US
X-ASG-Orig-Subj: Re: [PATCH] block: Fix page refcounts for unaligned buffers in
 __bio_release_pages()
To: Greg Edwards <gedwards@ddn.com>
Cc: Jens Axboe <axboe@kernel.dk>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
 Hugh Dickins <hughd@google.com>, Hannes Reinecke <hare@suse.de>,
 Keith Busch <kbusch@kernel.org>, linux-mm <linux-mm@kvack.org>,
 linux-block@vger.kernel.org, linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <86e592a9-98d4-4cff-a646-0c0084328356@cybernetics.com>
 <20240229225630.GA460680@bobdog.home.arpa>
From: Tony Battersby <tonyb@cybernetics.com>
In-Reply-To: <20240229225630.GA460680@bobdog.home.arpa>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Barracuda-Connect: UNKNOWN[10.10.4.126]
X-Barracuda-Start-Time: 1709737423
X-Barracuda-URL: https://10.10.4.122:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at cybernetics.com
X-Barracuda-Scan-Msg-Size: 785
X-Barracuda-BRTS-Status: 1

On 2/29/24 17:56, Greg Edwards wrote:
> On Thu, Feb 29, 2024 at 01:08:09PM -0500, Tony Battersby wrote:
>> Fix an incorrect number of pages being released for buffers that do not
>> start at the beginning of a page.
>>
>> Fixes: 1b151e2435fc ("block: Remove special-casing of compound pages")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Tony Battersby <tonyb@cybernetics.com>
>> ---
> This resolves the QEMU hugetlb issue I noted earlier today here [1].
> I tested it on 6.1.79, 6.8-rc6 and linux-next-20240229.  Thank you!
>
> Feel free to add a:
>
> Tested-by: Greg Edwards <gedwards@ddn.com>
>
> [1] https://lore.kernel.org/linux-block/20240229182513.GA17355@bobdog.home.arpa/

Jens, can I get this added to 6.8 (or 6.9 if it is too late)?

Thanks,
Tony


