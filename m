Return-Path: <linux-fsdevel+bounces-59132-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C121B34AE5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 21:30:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FD6F2A5039
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 19:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1632283FE4;
	Mon, 25 Aug 2025 19:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rf82zK0A"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6423422E004;
	Mon, 25 Aug 2025 19:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756150198; cv=none; b=KnTy4Ok6rnrY7Pu6jbw+Pf/oOQ4auMO7B+DDm40UamOQl+F9aZxutJxE4gKRMaU1Nte2OpMnsYDfK4TprSD02vvVIk537fFa+s6v/SMf5PU9lzLscUgx9JJZwXO1k7q5ax258aB294g57RpiqdLrYQnAIt9tbZ3A4H2D+uPQCxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756150198; c=relaxed/simple;
	bh=bK/dJGf1c/o2JKnJD0GabsxjilHzu//YKeLIDaxe6HQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jxojoRJj55hq3w1Kgc4ZyQfxSvNf8QlXZxEG7M0gf2+KjiLN+nC9nKkGKPY+F4SgMFB9mtlMVhIhNgposMunhT7bwZ5OMTEvbI1/M52r1uRqdsEeR85gO8/U/bskd85HmfzCHV3k5hBv407Ble8dMCb+m447OLx2gkY0bant+E8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=rf82zK0A; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=hA3lZJuNB2NIOaRUnLgWkKb+xbazF1yxLCJop6dJ7Ec=; b=rf82zK0AJeq1hvVddpzn605r9f
	vWSZEbkA6p/yzAH/BOnrNb4kEIERMh5S+FEwhdVvGwqBqTzzRyiDagBrJ3UypWw0mjTp0HfzJkSIU
	9j9pRRSiNJaD3SI0rf+Ugxg1rx80AQPlJfql6JG0yl6VyU0IL9GyBmesasmfgjEe3Rq7l3wr+9uIU
	Ffnh7mO6IoAdK15bK0o6yaNn1g4PRsoey8SS45oBTo0znj2hFwvQClI95e7S7RbqbgPsfcECzrHla
	M2B23aMKXz1DvZbPbpovWh7MZLfoQpyPEh729lbcdIdI4BSWEDf9KeBsZ67t1S7Efll2wRYQAZ+XJ
	3NFyLSVA==;
Received: from [50.53.25.54] (helo=[192.168.254.17])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqct9-00000009JrZ-0obD;
	Mon, 25 Aug 2025 19:29:55 +0000
Message-ID: <fc0b3998-df4a-49d0-88a6-e2c1c5c6650c@infradead.org>
Date: Mon, 25 Aug 2025 12:29:54 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] uapi/fcntl: conditionally define AT_RENAME* macros
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-kernel@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>,
 Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>,
 Alexander Aring <alex.aring@gmail.com>, Josef Bacik <josef@toxicpanda.com>,
 Aleksa Sarai <cyphar@cyphar.com>, Jan Kara <jack@suse.cz>,
 Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org,
 linux-api@vger.kernel.org
References: <20250824221055.86110-1-rdunlap@infradead.org>
 <aKuedOXEIapocQ8l@casper.infradead.org>
 <9b2c8fe2-cf17-445b-abd7-a1ed44812a73@infradead.org>
 <aKxfGix_o4glz8-Z@casper.infradead.org>
 <0c755ddc-9ed1-462e-a9f1-16762ebe0a19@infradead.org>
 <aKyvO2bvPCZEzuBd@casper.infradead.org>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <aKyvO2bvPCZEzuBd@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/25/25 11:45 AM, Matthew Wilcox wrote:
> On Mon, Aug 25, 2025 at 10:52:31AM -0700, Randy Dunlap wrote:
>> $ grep -r AT_RENAME_NOREPLACE /usr/include
>> /usr/include/stdio.h:# define AT_RENAME_NOREPLACE RENAME_NOREPLACE
>> /usr/include/linux/fcntl.h:#define AT_RENAME_NOREPLACE	0x0001
>>
>> I have libc 2.42-1.1 (openSUSE).
> 
> I wonder if we can fix it by changing include/uapi/linux/fcntl.h
> from being an explicit 0x0001 to RENAME_NOREPLACE?  There's probably
> a horrendous include problem between linux/fcntl.h and linux/fs.h
> though?

I'm working on something like that now (suggested by Amir),
but it might depend on whether stdio.h has been #included first.

-- 
~Randy


