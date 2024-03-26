Return-Path: <linux-fsdevel+bounces-15293-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E9BB88BE3E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Mar 2024 10:48:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 078262E289A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Mar 2024 09:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31B7D11CBA;
	Tue, 26 Mar 2024 09:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="WpQ+Ny/V"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE6E10A19;
	Tue, 26 Mar 2024 09:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711446254; cv=none; b=iIE7tyvIb1bKRWbip27c28qWlen3sizUj6nhvTQAe8huDa+3LdZPvjIgHl1784gGoTAMwNY81SF/YBugj+3/STmXgkt5mfwa/nAeRxWQzkjIenR6FflcVTqFMPAdldRsVxZy54jn11ENamldOKZxvQWpSOU1icX6MGqNoBLV2Xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711446254; c=relaxed/simple;
	bh=otwNxssUTqC8hixZ724zKmTu0LPn+6xgWSR2/3zJtqA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g2SXGePh2lb5xF+JVO3/eRFuloLkeAbTyPe1x5DlBNTj+nhQinA/L5iXXZaHmT0mvcQLlO5MMKm8CFqiRWVJdBvV0K5bCN+7jIPmsNyUsiPrnRVzlo3Sewt8MdtxWdIZbu94M0ZmsmquQIV+DkwiVvp6S/un6SQJdlNt/J6iHGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=WpQ+Ny/V; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4V3lHr6bWfz9scb;
	Tue, 26 Mar 2024 10:44:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1711446248;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YrxaH5mDWbAQSraF+LJ/aFHOMZvEWk75cjO9z38h3ds=;
	b=WpQ+Ny/VkIGZVysTH9mt6ac6RJIyCQebBhbHlxffuvruRXKXPbTkzElPZGzrve3xAMydqz
	FzwRyBnZHBfacuxH6PnJB8Bf2FbqGz9YWC2THPAs9/Rq5Cnrv2Y3pfWlbhZhv5RO3FrVMF
	N7rBO3rjyZhniq35YhDDYlFMWpAgwkeMPjPc98/zmWCggjAIJlL/B3sPeJ93UWO8swi9bP
	VNEOiZ2fS2J3aSpm+Bs1m5GwKCu7yXFOjkPmpp48UafhHQM3lKS85eHfvVH+pGt3rzgs5S
	vg8Z5qaYNPqqQ6dPRygBDajkpk2y3m9pi0ejAzbH6PPK7VaVGZKbr2T9ZcMIxQ==
Message-ID: <5e5523b1-0766-43b2-abb1-f18ea63906d6@pankajraghav.com>
Date: Tue, 26 Mar 2024 10:44:02 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3 04/11] readahead: rework loop in
 page_cache_ra_unbounded()
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Matthew Wilcox <willy@infradead.org>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 gost.dev@samsung.com, chandan.babu@oracle.com, mcgrof@kernel.org,
 djwong@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 david@fromorbit.com, akpm@linux-foundation.org,
 Pankaj Raghav <p.raghav@samsung.com>
References: <20240313170253.2324812-1-kernel@pankajraghav.com>
 <20240313170253.2324812-5-kernel@pankajraghav.com>
 <ZgHFPZ9tNLLjKZpz@casper.infradead.org>
 <7217df4e-470b-46ab-a4fc-1d4681256885@suse.de>
From: Pankaj Raghav <kernel@pankajraghav.com>
In-Reply-To: <7217df4e-470b-46ab-a4fc-1d4681256885@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Hannes,

On 26/03/2024 10:39, Hannes Reinecke wrote:
> On 3/25/24 19:41, Matthew Wilcox wrote:
>> On Wed, Mar 13, 2024 at 06:02:46PM +0100, Pankaj Raghav (Samsung) wrote:
>>> @@ -239,8 +239,8 @@ void page_cache_ra_unbounded(struct readahead_control *ractl,
>>>                * not worth getting one just for that.
>>>                */
>>>               read_pages(ractl);
>>> -            ractl->_index++;
>>> -            i = ractl->_index + ractl->_nr_pages - index - 1;
>>> +            ractl->_index += folio_nr_pages(folio);
>>> +            i = ractl->_index + ractl->_nr_pages - index;
>>>               continue;
>>>           }
>>>   @@ -252,13 +252,14 @@ void page_cache_ra_unbounded(struct readahead_control *ractl,
>>>               folio_put(folio);
>>>               read_pages(ractl);
>>>               ractl->_index++;
>>> -            i = ractl->_index + ractl->_nr_pages - index - 1;
>>> +            i = ractl->_index + ractl->_nr_pages - index;
>>>               continue;
>>>           }
>>
>> You changed index++ in the first hunk, but not the second hunk.  Is that
>> intentional?
> 
> Hmm. Looks you are right; it should be modified, too.
> Will be fixing it up.
> 
You initially had also in the second hunk:
ractl->index += folio_nr_pages(folio);

and I changed it to what it is now.

The reason is in my reply to willy:
https://lore.kernel.org/linux-xfs/s4jn4t4betknd3y4ltfccqxyfktzdljiz7klgbqsrccmv3rwrd@orlwjz77oyxo/

Let me know if you agree with it.

> Cheers,
> 
> Hannes
> 

