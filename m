Return-Path: <linux-fsdevel+bounces-59623-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A27FAB3B693
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Aug 2025 11:00:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8938B7AD239
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Aug 2025 08:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 673F82DCF5D;
	Fri, 29 Aug 2025 09:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="egCHoD49"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FB652DC328
	for <linux-fsdevel@vger.kernel.org>; Fri, 29 Aug 2025 09:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756458014; cv=none; b=l0aaL2LtrJ+CHc1rsa9djYcUZvz1NLgWEayV/DRPKRovhtj9V0H9qd+zmvv6CjSm1rXy2bgCDAerdQ6P+gwm5yAZfapHsszqJJAnqQu0aoWkkWXTJ6YBUzFHhyVi/FiUb/88MQ8j5Jvs+ndDWcukUlkaC7YmrLLW7iqayDYkTlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756458014; c=relaxed/simple;
	bh=fQwb9mM6knMDr3YCfsYeFWVuYqVoePVMApjpt3F4KwM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=IBZbDG4Coq29zpM9AzEdALTbTOYQO7Cz0ckZKe7KkeYieAfQOCHJJnlEcLQLwgqAWznnyOZXk3d6uuXp874T7ISqdFCy/hDaPMiyLLDOP2iw0Ggi6YqSLCFqDEKk9Qusd6kXYB/+dkQQYevowVEa7BUECLZOJSC0QmX2AhtdtCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=egCHoD49; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20250829090004epoutp016838be63dee2ae7e8082a3c917f959db~gMT-BQuKR0099700997epoutp01i
	for <linux-fsdevel@vger.kernel.org>; Fri, 29 Aug 2025 09:00:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20250829090004epoutp016838be63dee2ae7e8082a3c917f959db~gMT-BQuKR0099700997epoutp01i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1756458004;
	bh=uRfid9eNRN1IiYiLsnEKYQu88MjmvxZl3zgdA6RmIhE=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=egCHoD49xR6PtICey0GDtw4Sx59Y7VZ4nxmF9kVPG855KI8bIk1gqEXodlTOF9RRf
	 u+i31C5oz8l1xOSb1cDjYRZqZUyUd8EyVDSJhUD7BAEzON/nxdGDj+7xhU9FTVYYlU
	 3Pt3ARQk2w2GfCKDhMpfbEvlhydzmq3zfweJMdOQ=
Received: from epsnrtp04.localdomain (unknown [182.195.42.156]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPS id
	20250829090003epcas5p36bada7713dea2fb6f6cc6883fb86363e~gMT_Hgm1i2928729287epcas5p3p;
	Fri, 29 Aug 2025 09:00:03 +0000 (GMT)
Received: from epcas5p1.samsung.com (unknown [182.195.38.93]) by
	epsnrtp04.localdomain (Postfix) with ESMTP id 4cCsfV5rzjz6B9m5; Fri, 29 Aug
	2025 09:00:02 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20250829090001epcas5p1624018975802eceeb655e76bf63d152a~gMT8VfSQU1933919339epcas5p17;
	Fri, 29 Aug 2025 09:00:01 +0000 (GMT)
Received: from [107.111.86.57] (unknown [107.111.86.57]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250829085958epsmtip2c5f994338290c8c07053baa5737e55fe~gMT5u6ee93040930409epsmtip2G;
	Fri, 29 Aug 2025 08:59:58 +0000 (GMT)
Message-ID: <77291508-cd85-4889-8502-73eb834e543c@samsung.com>
Date: Fri, 29 Aug 2025 14:29:57 +0530
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 0/1] writeback: add sysfs to config the number of
 writeback contexts
Content-Language: en-US
To: wangyufei <wangyufei@vivo.com>, Andrew Morton
	<akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, Lorenzo
	Stoakes <lorenzo.stoakes@oracle.com>, "Liam R. Howlett"
	<Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport
	<rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko
	<mhocko@suse.com>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, Stephen
	Rothwell <sfr@canb.auug.org.au>, open list <linux-kernel@vger.kernel.org>,
	"open list:MEMORY MANAGEMENT - MISC" <linux-mm@kvack.org>, "open list:PAGE
 CACHE" <linux-fsdevel@vger.kernel.org>
Cc: anuj20.g@samsung.com, hch@lst.de, bernd@bsbernd.com, djwong@kernel.org,
	jack@suse.cz, opensource.kernel@vivo.com
From: Kundan Kumar <kundan.kumar@samsung.com>
In-Reply-To: <20250825122931.13037-1-wangyufei@vivo.com>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20250829090001epcas5p1624018975802eceeb655e76bf63d152a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250825123009epcas5p1573496e2cad2f58d22036493e5af03be
References: <CGME20250825123009epcas5p1573496e2cad2f58d22036493e5af03be@epcas5p1.samsung.com>
	<20250825122931.13037-1-wangyufei@vivo.com>

On 8/25/2025 5:59 PM, wangyufei wrote:
> Hi everyone,
> 
> We've been interested in this patch about parallelizing writeback [1]
> and have been following its discussion and development. Our testing in
> several application scenarios on mobile devices has shown significant
> performance improvements.
> 

Hi,

Thanks for sharing this work.

Could you clarify a few details about your test setup?

- Which filesystem did you run these experiments on?
- What were the specifics of the workload (number of threads, block size,
   I/O size)?
- If you are using fio, can you please share the fio command.
- How much RAM was available on the test system?
- Can you share the performance improvement numbers you observed?

That would help in understanding the impact of parallel writeback?

I made similar modifications to dynamically configure the number of
writeback threads in this experimental patch. Refer to patches 14 and 15:
https://lore.kernel.org/all/20250807045706.2848-1-kundan.kumar@samsung.com/
The key difference is that this change also enables a reduction in the
number of writeback threads.

Thanks,
Kundan

> 


