Return-Path: <linux-fsdevel+bounces-22946-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1AB0923F02
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jul 2024 15:30:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BAEF1F227BA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jul 2024 13:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 738D71B4C52;
	Tue,  2 Jul 2024 13:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="KZaCKKWd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25588D266;
	Tue,  2 Jul 2024 13:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719927021; cv=none; b=Z/n0UI2OsUgKHjBNG7aefAUtQ1XwIeyxVQFLswrQf91N6ZgmF2d2nIc7IZUrZVztxx0Gw+qRSNLly1gJKcLQACpzvdQJAGkf8QgXjJjsYdAKfc5cj1x/3X5C5F4CXTFoZjATisEMpQ7Ch937UTeENY680hVg2i7Js8oQdeQUPWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719927021; c=relaxed/simple;
	bh=07wJLNcwr+baGCJCP/F1XaeLBINuK7arxryuHcuoQZo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hPHrR3eJNU0r+MidayhzPGDNBHHIlS6h+TCBhfbufyHgP6W8wvi8UNgsTVi7wy+Wbet25pcKJxbUwBvWr/4/+XH2ndCEp+mWX7SlL/MkcGrld+t5FosNN8GfpkuTg37+t6cBikOZsUh+pKxwoDvZj0MXAcCDFNQZgufVWhVxakE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=KZaCKKWd; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1719927009;
	bh=07wJLNcwr+baGCJCP/F1XaeLBINuK7arxryuHcuoQZo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=KZaCKKWdch3pNxrVCWDa7yvlE7UQYrYmA7qiMog304SXH+ChN7hdn7Lm4sZFyrMdT
	 U17gpRn8BFdTpRULsxRe+jB55vrZKQnxkbCUybDvenRF/FLjDSmp38dK5TCy//m486
	 mmN/tuxAkMOuwBuePXqTsYyqRCPqxJ/KXuNvpKCM8oidbyPaYcqvlZJcTs+ss9uSLX
	 /AqDhWbUbY92AwOIhPUlFH323mgVa/fgEQz8xb/AngSCHm2/xAsLPEXpTPOmDan3zs
	 aPRNUnEKPoFAH2QRnX7AOkIR/ykU+9EuPH3xEfTVg+Fhr3mdWBk4XvrRJHmzbP4Q4B
	 0+dTeqleJuVhw==
Received: from [172.16.0.134] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4WD3gP5sHbz1879;
	Tue,  2 Jul 2024 09:30:09 -0400 (EDT)
Message-ID: <8015a0bf-39e2-406c-8f61-db87a40a71a3@efficios.com>
Date: Tue, 2 Jul 2024 09:30:30 -0400
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] hugetlbfs: use tracepoints in hugetlbfs functions.
To: Hongbo Li <lihongbo22@huawei.com>, Steven Rostedt <rostedt@goodmis.org>
Cc: muchun.song@linux.dev, mhiramat@kernel.org, linux-mm@kvack.org,
 linux-trace-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20240612011156.2891254-1-lihongbo22@huawei.com>
 <20240612011156.2891254-3-lihongbo22@huawei.com>
 <20240701194906.3a9b6765@gandalf.local.home>
 <1eca1fcd-5479-47b2-b7ba-eb4027135af2@huawei.com>
Content-Language: en-US
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <1eca1fcd-5479-47b2-b7ba-eb4027135af2@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024-07-02 07:55, Hongbo Li wrote:
> 
> 
> On 2024/7/2 7:49, Steven Rostedt wrote:
>> On Wed, 12 Jun 2024 09:11:56 +0800
>> Hongbo Li <lihongbo22@huawei.com> wrote:
>>
>>> @@ -934,6 +943,12 @@ static int hugetlbfs_setattr(struct mnt_idmap 
>>> *idmap,
>>>       if (error)
>>>           return error;
>>> +    trace_hugetlbfs_setattr(inode, dentry->d_name.len, 
>>> dentry->d_name.name,
>>> +            attr->ia_valid, attr->ia_mode,
>>> +            from_kuid(&init_user_ns, attr->ia_uid),
>>> +            from_kgid(&init_user_ns, attr->ia_gid),
>>> +            inode->i_size, attr->ia_size);
>>> +
>>
>> That's a lot of parameters to pass to a tracepoint. Why not just pass the
>> dentry and attr and do the above in the TP_fast_assign() logic? That 
>> would
>> put less pressure on the icache for the code part.
> 
> Thanks for reviewing!
> 
> Some logic such as kuid_t --> uid_t might be reasonable obtained in 
> filesystem layer. Passing the dentry and attr will let trace know the 
> meaning of structure, perhaps tracepoint should not be aware of the
> members of these structures as much as possible.

As maintainer of the LTTng out-of-tree kernel tracer, I appreciate the
effort to decouple instrumentation from the subsystem instrumentation,
but as long as the structure sits in public headers and the global
variables used within the TP_fast_assign() logic (e.g. init_user_ns)
are export-gpl, this is enough to make it easy for tracer integration
and it keeps the tracepoint caller code footprint to a minimum.

The TRACE_EVENT definitions are specific to the subsystem anyway,
so I don't think it matters that the TRACE_EVENT() need to access
the dentry and attr structures.

So I agree with Steven's suggestion. However, just as a precision,
I suspect it will have mainly an impact on code size, but not
necessarily on icache footprint, because it will shrink the code
size within the tracepoint unlikely branch (cold instructions).

Thanks,

Mathieu

> 
> Thanks,
> Hongbo
> 
>>
>> -- Steve
>>

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


