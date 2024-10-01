Return-Path: <linux-fsdevel+bounces-30496-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D59A98BCAC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2024 14:50:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05524B241BF
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2024 12:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D0E41C3F1B;
	Tue,  1 Oct 2024 12:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="xwg3lWQB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A60A1C2DB1;
	Tue,  1 Oct 2024 12:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727787004; cv=none; b=AYMVZcTmKeZZkushNrqXsfitO3kjZOeorwwVlqmJA2npA3MwnOCBaO0hmnAXxPNBrtRSYmcu42DQ8yvpnubgcfsSYErsNE8ILIcbNcuvY8olEtl6tSROcZp9OZwFomIn6eIv3xV1so2SzHuGfKmF7xUEkoUEWnAhbNcu+cG/vFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727787004; c=relaxed/simple;
	bh=xns8hsxhIdD6+hI7mmFB5qJiP3BTBo67OOjHhk9I9Tk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FMt9AAM6cAUOyd2IjFOHsxbQ7diJOvsmD0O2/2NFB6B2si9ZTtbjkNiz/6ChKLAdARtYIT6Y5YhhEbzSd/fSEIn03mlqaQLrzhaZfSgv2WkkpBJZ2P4dR+cDtw4Ni6gBWAIW/gfo5c2MQj008GkKUodrl0vcp5Y61u3ubmxwOfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=xwg3lWQB; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=v2VbEpiu02sSfttNZ1FIT6I0JoTTAy8v78m159FGc9c=;
	t=1727787002; x=1728219002; b=xwg3lWQB2SmD+yEeHiW8rBym9RlQ2WCxPnDPO2olVqsxE13
	jJHmqltEGeumQUO5txmJhdzRFnctVI2o+4SEN7AvhpvjQMOqDPxrY86mwP3nBhPX+1qjUp43+XyF7
	Dj0D2jpinEj/rn63KKSeP+lVWShf3465Ulxrk9pmwa83AL6kWZyzc7zBd1y2xUvXTSd3PTNKCDjbB
	aEi2Eb7zvhA5yLpXAonvY5MBom5TB7rX+RDlKCwQU1hVqo2FPy8T/NeZA44s4jSTgdfRgQY93674C
	xTUaIXKSbxILnnn2JoxyORyUb1TwEERdYFGI9tBMclBOpGn2YXjrdVtxZd1cYyDg==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1svcK7-00079U-U7; Tue, 01 Oct 2024 14:49:52 +0200
Message-ID: <b77aa757-4ea2-4c0a-8ba9-3685f944aa34@leemhuis.info>
Date: Tue, 1 Oct 2024 14:49:51 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [regression] getdents() does not list entries created after
 opening the directory
To: =?UTF-8?Q?Krzysztof_Ma=C5=82ysa?= <varqox@gmail.com>
Cc: yangerkun <yangerkun@huawei.com>, Christian Brauner <brauner@kernel.org>,
 linux-fsdevel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>,
 LKML <linux-kernel@vger.kernel.org>, Matthew Wilcox <willy@infradead.org>,
 Linux regressions mailing list <regressions@lists.linux.dev>
References: <8196cf54-5783-4905-af00-45a869537f7c@leemhuis.info>
 <ZvvonHPqrAqSHhgV@casper.infradead.org>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
Content-Language: en-US, de-DE
In-Reply-To: <ZvvonHPqrAqSHhgV@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1727787002;408a80b2;
X-HE-SMSGID: 1svcK7-00079U-U7

On 01.10.24 14:18, Matthew Wilcox wrote:
> On Tue, Oct 01, 2024 at 01:29:09PM +0200, Linux regression tracking (Thorsten Leemhuis) wrote:
>>> 	DIR* dir = opendir("/tmp/dirent-problems-test-dir");
>>>
>>> 	fd = creat("/tmp/dirent-problems-test-dir/after", 0644);
> 
> "If a file is removed from or added to the directory after the most
> recent call to opendir() or rewinddir(), whether a subsequent call to
> readdir() returns an entry for that file is unspecified."
> 
> https://pubs.opengroup.org/onlinepubs/007904975/functions/readdir.html
> 
> That said, if there's an easy fix here, it'd be a nice improvement to
> QoI to do it, but the test-case as written is incorrect.

Many thx Willy!

Which leads to a question:

Krzysztof, how did you find the problem? Was there a practical use case
(some software or workload) with this behavior that broke and made your
write that test-case? Or is that a test-program older and part of your
CI tests or something like that?

Ciao, Thorsten



