Return-Path: <linux-fsdevel+bounces-15300-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 627D288BEC0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Mar 2024 11:07:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93B0B1C3CB69
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Mar 2024 10:07:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E0A567750;
	Tue, 26 Mar 2024 10:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="SKyZ+6qj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C2A55A0E1;
	Tue, 26 Mar 2024 10:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711447610; cv=none; b=K/fWo3KwY1L47dyXZ5V5ONtTUF7fxsA4wRKEWoZIQaOnGHvfgKrkFUqOSj/RQGUJFFz5vE3E73VvUSMrjbBmpPK+TK33wuVt3pwpumC7KMdqGs1HzDnn6fn9e0/adExLthKnwdnY5c/UPMF403FJ9LcDRxlF52kXtNw/A18SGHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711447610; c=relaxed/simple;
	bh=zDrEdt71S1V5WCgqhPBVSngeotjSuDZavyd+Y5LUUjo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NDhewmR/ioofhX50xWIFp0TIYqzsJDC6BgL+MS97cL0ijLt2rUWbz/+vMcWBGVC8yq8FMvc3d/JMPJDpLxHo/Xhny3syZI0Xvq2BkM3o8O39QUbQhXG1NYMGwx+RsuE4NqD1JihR4mjg/hKdsHAsl6cAqJhhqK1L/+XufZ6jsxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=SKyZ+6qj; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4V3lnt0K4fz9sSF;
	Tue, 26 Mar 2024 11:06:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1711447602;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/l44hIRVvOPEpGQpeViqZ0xwsEycYNDv++J/k+vdgEc=;
	b=SKyZ+6qjmQ6o2EGEB3YUZN55bm155l+3rRdII0vYo0M/FQm42gD9m1nLnv5eZDYcM8sb1n
	MpMHvjjhdoS2f1QiJOdcwAmc1lDnHiRuc95L3qeYW/siY2sKBVZtMrtCD7OJrIlSeGxTQV
	Qp0TF6xN5V99E/bFaEng6gD2MEL98WeCv0fWmkjGHBjaMJIk31bzxIueBpp3gbllnSDZWQ
	uKZ9fKizPoJdLS/5/xpGCIKvtmKKZ+B/KmSOq/7H6uAKkyCieAZ7TZjDgE/mzmZ1V2zI5k
	5Q7ehK9AJ1+3cS5w9yoD5/49gaGu3IZb/tFlPs0TZgMWsD/h3/mxtoUrPswqOA==
Message-ID: <1a4a6ad3-6b88-47ea-a6c4-144a1485f614@pankajraghav.com>
Date: Tue, 26 Mar 2024 11:06:36 +0100
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
 <5e5523b1-0766-43b2-abb1-f18ea63906d6@pankajraghav.com>
 <3aa8bdf1-24f6-4e1f-a5c4-8dc2d11ca292@suse.de>
From: Pankaj Raghav <kernel@pankajraghav.com>
In-Reply-To: <3aa8bdf1-24f6-4e1f-a5c4-8dc2d11ca292@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 26/03/2024 11:00, Hannes Reinecke wrote:
> On 3/26/24 10:44, Pankaj Raghav wrote:
>> Hi Hannes,
>>
>> On 26/03/2024 10:39, Hannes Reinecke wrote:
>>> On 3/25/24 19:41, Matthew Wilcox wrote:
>>>> On Wed, Mar 13, 2024 at 06:02:46PM +0100, Pankaj Raghav (Samsung) wrote:
>>>>> @@ -239,8 +239,8 @@ void page_cache_ra_unbounded(struct readahead_control *ractl,
>>>>>                 * not worth getting one just for that.
>>>>>                 */
>>>>>                read_pages(ractl);
>>>>> -            ractl->_index++;
>>>>> -            i = ractl->_index + ractl->_nr_pages - index - 1;
>>>>> +            ractl->_index += folio_nr_pages(folio);
>>>>> +            i = ractl->_index + ractl->_nr_pages - index;
>>>>>                continue;
>>>>>            }
>>>>>    @@ -252,13 +252,14 @@ void page_cache_ra_unbounded(struct readahead_control *ractl,
>>>>>                folio_put(folio);
>>>>>                read_pages(ractl);
>>>>>                ractl->_index++;
>>>>> -            i = ractl->_index + ractl->_nr_pages - index - 1;
>>>>> +            i = ractl->_index + ractl->_nr_pages - index;
>>>>>                continue;
>>>>>            }
>>>>
>>>> You changed index++ in the first hunk, but not the second hunk.  Is that
>>>> intentional?
>>>
>>> Hmm. Looks you are right; it should be modified, too.
>>> Will be fixing it up.
>>>
>> You initially had also in the second hunk:
>> ractl->index += folio_nr_pages(folio);
>>
>> and I changed it to what it is now.
>>
>> The reason is in my reply to willy:
>> https://lore.kernel.org/linux-xfs/s4jn4t4betknd3y4ltfccqxyfktzdljiz7klgbqsrccmv3rwrd@orlwjz77oyxo/
>>
>> Let me know if you agree with it.
>>
> Bah. That really is overly complicated. When we attempt a conversion that conversion should be
> stand-alone, not rely on some other patch modifications later on.
> We definitely need to work on that to make it easier to review, even
> without having to read the mail thread.
> 

I don't know understand what you mean by overly complicated. This conversion is standalone and it is
wrong to use folio_nr_pages after we `put` the folio. This patch just reworks the loop and in the
next patch I add min order support to readahead.

This patch doesn't depend on the next patch.

> Cheers,
> 
> Hannes
> 

