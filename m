Return-Path: <linux-fsdevel+bounces-13215-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EA8886D4FB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Feb 2024 21:52:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B06171C22463
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Feb 2024 20:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5445E74C11;
	Thu, 29 Feb 2024 20:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cybernetics.com header.i=@cybernetics.com header.b="oND8RtnD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.cybernetics.com (mail.cybernetics.com [72.215.153.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10D0813E7DE
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Feb 2024 20:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=72.215.153.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709239238; cv=none; b=GtkReUhqtfzMIqKRMzfdC/aqhiuEaTowN7AXWSH5AGCfjRk8JNvQak16FjD4m/9eBCs/DNWsPi1oXqneVG1d1pGTmdSXbTLEN6kUhKPFiOXdE4EjFCxq/zTWIl9nTpinsqcKggVj6m3VND9KSKZp+tDXJAY02MPDLny4rhv+CFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709239238; c=relaxed/simple;
	bh=d2Jnd4yjkGkEApv48eNzr6PHo1ck9eCm1SggiXIqMu4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HorlnkVJpwB/3SpWOA4WwLKBLVqAYpKiEkzIIZdAM8qUUc/Oiz/x5e3dfEXfqjCI9bDPljtmtbxsI11cxBDD/we9cPbkMLTOG2IdCoT+i6euiHJPXO64wBWk/NRoLSztSNim5OlATp7cVp3UaFdsWkBLrd+A1qPak5HVZ7zw3MU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cybernetics.com; spf=pass smtp.mailfrom=cybernetics.com; dkim=pass (1024-bit key) header.d=cybernetics.com header.i=@cybernetics.com header.b=oND8RtnD; arc=none smtp.client-ip=72.215.153.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cybernetics.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cybernetics.com
X-ASG-Debug-ID: 1709239210-1cf4391a1c513a0001-kl68QG
Received: from cybernetics.com ([10.10.4.126]) by mail.cybernetics.com with ESMTP id HEvayFu8xC0yrdsC; Thu, 29 Feb 2024 15:40:32 -0500 (EST)
X-Barracuda-Envelope-From: tonyb@cybernetics.com
X-Barracuda-RBL-Trusted-Forwarder: 10.10.4.126
X-ASG-Whitelist: Client
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=cybernetics.com; s=mail;
	bh=KGdwz7goRECtYGm5sOnk6GBz6zSl4J5s0wT/cSLJdMw=;
	h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Content-Language:Subject:MIME-Version:Date:Message-ID; b=oND8RtnDJqAi9sA80RB4
	sb4XkMRRCvNMjh6iERzlbrwrBvsjIOrbs14Fav2aVqBlrnTByQSS+hxqeGim5/aVdLcGaeyzzFjAt
	NXzreOxVb4kMcqOJ2IsQTScZkRwbiu5reQ7c8yHiEMiU44bqKuGSJgsmQLeCuBABcbFTPk8IMY=
Received: from [10.157.2.224] (HELO [192.168.200.1])
  by cybernetics.com (CommuniGate Pro SMTP 7.1.1)
  with ESMTPS id 13109217; Thu, 29 Feb 2024 15:40:10 -0500
Message-ID: <2dbe097c-a4b8-4f22-8c39-1bdecbee4581@cybernetics.com>
X-Barracuda-RBL-Trusted-Forwarder: 10.157.2.224
Date: Thu, 29 Feb 2024 15:40:09 -0500
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
To: Matthew Wilcox <willy@infradead.org>
Cc: Jens Axboe <axboe@kernel.dk>, Andrew Morton <akpm@linux-foundation.org>,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
 Hugh Dickins <hughd@google.com>, Hannes Reinecke <hare@suse.de>,
 Keith Busch <kbusch@kernel.org>, linux-mm <linux-mm@kvack.org>,
 linux-block@vger.kernel.org, linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <86e592a9-98d4-4cff-a646-0c0084328356@cybernetics.com>
 <ZeDguZujxets0KtD@casper.infradead.org>
From: Tony Battersby <tonyb@cybernetics.com>
In-Reply-To: <ZeDguZujxets0KtD@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Barracuda-Connect: UNKNOWN[10.10.4.126]
X-Barracuda-Start-Time: 1709239232
X-Barracuda-URL: https://10.10.4.122:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at cybernetics.com
X-Barracuda-Scan-Msg-Size: 1861
X-Barracuda-BRTS-Status: 0

On 2/29/24 14:53, Matthew Wilcox wrote:
> On Thu, Feb 29, 2024 at 01:08:09PM -0500, Tony Battersby wrote:
>> Fix an incorrect number of pages being released for buffers that do not
>> start at the beginning of a page.
> Oh, I see what I did.  Wouldn't a simpler fix be to just set "done" to
> offset_in_page(fi.offset)?

Actually it would be:

ssize_t done = -offset_in_page(offset);

But then you have signed vs. unsigned comparison in the while(), or you
could rearrange the loop to avoid the negative, but then it gets clunky.

>
>> @@ -1152,7 +1152,7 @@ void __bio_release_pages(struct bio *bio, bool mark_dirty)
>>  
>>  	bio_for_each_folio_all(fi, bio) {
>>  		struct page *page;
>> -		size_t done = 0;
>> +		size_t nr_pages;
>>  
>>  		if (mark_dirty) {
>>  			folio_lock(fi.folio);
>> @@ -1160,10 +1160,11 @@ void __bio_release_pages(struct bio *bio, bool mark_dirty)
>>  			folio_unlock(fi.folio);
>>  		}
>>  		page = folio_page(fi.folio, fi.offset / PAGE_SIZE);
>> +		nr_pages = (fi.offset + fi.length - 1) / PAGE_SIZE -
>> +			   fi.offset / PAGE_SIZE + 1;
>>  		do {
>>  			bio_release_page(bio, page++);
>> -			done += PAGE_SIZE;
>> -		} while (done < fi.length);
>> +		} while (--nr_pages != 0);
>>  	}
>>  }
>>  EXPORT_SYMBOL_GPL(__bio_release_pages);
> The long-term path here, I think, is to replace this bio_release_page()
> with a bio_release_folio(folio, offset, length) which calls into
> a new unpin_user_folio(folio, nr) which calls gup_put_folio().

I developed the patch with the 6.1 stable series, which just has:

nr_pages = (fi.offset + fi.length - 1) / PAGE_SIZE -
	   fi.offset / PAGE_SIZE + 1;
folio_put_refs(fi.folio, nr_pages);

Which is another reason that I went for the direct nr_pages
calculation.  Would you still prefer the negative offset_in_page() approach?

Tony


