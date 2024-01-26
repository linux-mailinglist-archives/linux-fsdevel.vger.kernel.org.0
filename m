Return-Path: <linux-fsdevel+bounces-9128-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C857F83E5C0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jan 2024 23:42:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 083E81C21C9B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jan 2024 22:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97D3345960;
	Fri, 26 Jan 2024 22:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="xlZeaFQt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69895481B9;
	Fri, 26 Jan 2024 22:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706308829; cv=none; b=LZFbbmE4f/mOCw2ZjRsWqESFckrmMZnD99mrFSknEqnS3ZW9ZOY1oovMOT3QksdiWYorOsMp9mGgSlHbBzd5cgxjM75rLT8JnWQA5O78T6VVEeVULvQBrkkaMzm8EKdcexDL32nA//n/bgI8r/0v2CxC6tN7QeNefCSOQpAh7RQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706308829; c=relaxed/simple;
	bh=KdgVTF1I7piz/UIVWYQxc4e2/s4Zy2p5ecUufv75WuE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qzh/YMsrJWiTZrVedRwSq7kSrlI2dl01YwdC872VPBdz5fCMChqZakVfu01m+r88UFF2UR/47w/hbMDCaG+uiKsKWQPZE5zT2ZOui1n4NwXyEGW1JKXKjYFnEvnCREoWpSllYsAj27J/A75EITTBmp9uKQoH2FnBvI54ePhTftE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=xlZeaFQt; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1706308824;
	bh=KdgVTF1I7piz/UIVWYQxc4e2/s4Zy2p5ecUufv75WuE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=xlZeaFQtPMRbcxFa+swDpAsChLuZeopnEtnueNQfh63SbH+H8v7qDtaa23mV+SMjr
	 oa4HfgGiyldqhe4KvYlLbtri+Vlz7cixeQkqxIrSLQlCIx9lTxZyW3RHINAR2XB9Yg
	 art8DoBQkKbO3scIpBMgoMEjgHXXtzKtUdt7GX0jH8M7G9IIsz2dXAm3JH1XLvj9cI
	 LSVv/6mH4ccGkuYZ1gIw4Xj7ChrAGCTtPl5HindBGjtwktZ+FpjIM7lHn19NMTGNe4
	 695qYSYKp9M7CGEvTI9x4YcdOFf3XGlmaqNKf9SfMVkZsnx5PqSKAMsEaQjuQQdQDb
	 hy+NfsGZqWLlA==
Received: from [172.16.0.134] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4TMCMD52przVQ5;
	Fri, 26 Jan 2024 17:40:24 -0500 (EST)
Message-ID: <1df2a2f8-f51d-4e02-9126-3e8245750466@efficios.com>
Date: Fri, 26 Jan 2024 17:40:24 -0500
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] eventfs: Have inodes have unique inode numbers
Content-Language: en-US
To: Matthew Wilcox <willy@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Steven Rostedt <rostedt@goodmis.org>, LKML <linux-kernel@vger.kernel.org>,
 Linux Trace Devel <linux-trace-devel@vger.kernel.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Christian Brauner <brauner@kernel.org>, Ajay Kaher
 <ajay.kaher@broadcom.com>, Geert Uytterhoeven <geert@linux-m68k.org>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>
References: <20240126150209.367ff402@gandalf.local.home>
 <CAHk-=wgZEHwFRgp2Q8_-OtpCtobbuFPBmPTZ68qN3MitU-ub=Q@mail.gmail.com>
 <20240126162626.31d90da9@gandalf.local.home>
 <CAHk-=wj8WygQNgoHerp-aKyCwFxHeyKMguQszVKyJfi-=Yfadw@mail.gmail.com>
 <CAHk-=whNfNti-mn6vhL-v-WZnn0i7ZAbwSf_wNULJeyanhPOgg@mail.gmail.com>
 <8547159a-0b28-4d75-af02-47fc450785fa@efficios.com>
 <ZbQzXfqA5vK5JXZS@casper.infradead.org>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <ZbQzXfqA5vK5JXZS@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-01-26 17:34, Matthew Wilcox wrote:
> On Fri, Jan 26, 2024 at 05:14:12PM -0500, Mathieu Desnoyers wrote:
>> I would suggest this straightforward solution to this:
>>
>> a) define a EVENTFS_MAX_INODES (e.g. 4096 * 8),
>>
>> b) keep track of inode allocation in a bitmap (within a single page),
>>
>> c) disallow allocating more than "EVENTFS_MAX_INODES" in eventfs.
> 
> ... reinventing the IDA?

Looking at include/linux/idr.h now that you mention it, yes,
you are absolutely right!

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


