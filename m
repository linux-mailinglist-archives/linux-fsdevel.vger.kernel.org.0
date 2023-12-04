Return-Path: <linux-fsdevel+bounces-4788-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 88B06803D31
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 19:36:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23BECB203D8
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 18:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88E402FC31
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 18:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V6RXIRt0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21DF8B0
	for <linux-fsdevel@vger.kernel.org>; Mon,  4 Dec 2023 08:51:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701708694;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=o9ogsP7zlAcAVFyuHDbm4AvBG24zophldpJM8ON7Y+o=;
	b=V6RXIRt09ii69Dn7IkfZBFzqnJ4fH94dEo+3o08rywp6etk8pKcdfWoMFtx6ZJAH74VuR4
	TP9Of3xdZ9WqnhehMGeTNNP8Qrq+0vkTO/YDWtTw02yPVvw2EfbwWPMIBVEVqtXeL1y91e
	uuSYbfKQpWv9x5+baFk8w/kVTeejNQo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-679-ZUd-t1LTOtai2116_H8cJQ-1; Mon, 04 Dec 2023 11:51:33 -0500
X-MC-Unique: ZUd-t1LTOtai2116_H8cJQ-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-40b23aef363so40531415e9.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 04 Dec 2023 08:51:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701708691; x=1702313491;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:from:content-language:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=o9ogsP7zlAcAVFyuHDbm4AvBG24zophldpJM8ON7Y+o=;
        b=UdMM+LEd5XtrTn6uNRb/126QdnuZvnP+EfNfdYYw1hJNGoQfgsr6yM0nd1596Sd1MY
         XGa9iog/oXGeNzE668DzbAb68zI5VxOgd3ETcS4/lkzQyuIklqFD73w912YpfufHmtjj
         +uAswx1Akg7q/XD+IxFjVm5Z7ylLeFJ853P0IGijUDKZYnK9YwwH3yHkBLdppovfFPOD
         MIzQcmTctJNh9EIP9NOOCVuf1KB2aOx0kkRBXBIagNTjaHTQaoVyQNA99yx7gZOexh+D
         wgSABO5Vsnb7dpaVrHXqiC9Sgbszef+mjSpzhi0+YivEAZAhj39Ga/9BDjUvv6/a2fLe
         WB0g==
X-Gm-Message-State: AOJu0YzpoWBzXUKY0LlnjtCN9xoOQ+D5MGxXeC/4dljXPOoYHMv1S/Cn
	1mb/Rhpr0PyW44zYzoYYGzTICXmo+ESDBXJG4SArTzsc8xxKjr+vSlCVYepSdyodauP606VpIVZ
	rBv2jQTPmai7yTKTyGP4phqdIcg==
X-Received: by 2002:a05:600c:c2:b0:40c:884:f57c with SMTP id u2-20020a05600c00c200b0040c0884f57cmr1635943wmm.122.1701708691542;
        Mon, 04 Dec 2023 08:51:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFgIgPt8Dy8Q9xUvIjGSKixEK781mOZvM09+B05A+JOLlIl6K2h0d3eJu9hDiGed860Y3clBA==
X-Received: by 2002:a05:600c:c2:b0:40c:884:f57c with SMTP id u2-20020a05600c00c200b0040c0884f57cmr1635932wmm.122.1701708691063;
        Mon, 04 Dec 2023 08:51:31 -0800 (PST)
Received: from ?IPV6:2003:cb:c722:3700:6501:8925:6f9:fcdc? (p200300cbc72237006501892506f9fcdc.dip0.t-ipconnect.de. [2003:cb:c722:3700:6501:8925:6f9:fcdc])
        by smtp.gmail.com with ESMTPSA id fs16-20020a05600c3f9000b0040b48690c49sm15576505wmb.6.2023.12.04.08.51.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Dec 2023 08:51:30 -0800 (PST)
Message-ID: <1db10afb-9088-4b9a-a46f-646c33bd932a@redhat.com>
Date: Mon, 4 Dec 2023 17:51:29 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Issue with 8K folio size in __filemap_get_folio()
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
To: Matthew Wilcox <willy@infradead.org>,
 Viacheslav Dubeyko <slava@dubeyko.com>
Cc: Linux FS Devel <linux-fsdevel@vger.kernel.org>, linux-mm@kvack.org,
 Hugh Dickins <hughd@google.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
References: <B467D07C-00D2-47C6-A034-2D88FE88A092@dubeyko.com>
 <ZWzy3bLEmbaMr//d@casper.infradead.org>
 <ZW0LQptvuFT9R4bw@casper.infradead.org>
 <22d5bd19-c1a7-4a6c-9be4-e4cb1213e439@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <22d5bd19-c1a7-4a6c-9be4-e4cb1213e439@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04.12.23 16:09, David Hildenbrand wrote:
> On 04.12.23 00:12, Matthew Wilcox wrote:
>> On Sun, Dec 03, 2023 at 09:27:57PM +0000, Matthew Wilcox wrote:
>>> I was talking with Darrick on Friday and he convinced me that this is
>>> something we're going to need to fix sooner rather than later for the
>>> benefit of devices with block size 8kB.  So it's definitely on my todo
>>> list, but I haven't investigated in any detail yet.
>>
>> OK, here's my initial analysis of just not putting order-1 folios
>> on the deferred split list.  folio->_deferred_list is only used in
>> mm/huge_memory.c, which makes this a nice simple analysis.
>>
>>    - folio_prep_large_rmappable() initialises the list_head.  No problem,
>>      just don't do that for order-1 folios.
>>    - split_huge_page_to_list() will remove the folio from the split queue.
>>      No problem, just don't do that.
>>    - folio_undo_large_rmappable() removes it from the list if it's
>>      on the list.  Again, no problem, don't do that for order-1 folios.
>>    - deferred_split_scan() walks the list, it won't find any order-1
>>      folios.
>>
>>    - deferred_split_folio() will add the folio to the list.  Returning
>>      here will avoid adding the folio to the list.  But what consequences
>>      will that have?  Ah.  There's only one caller of
>>      deferred_split_folio() and it's in page_remove_rmap() ... and it's
>>      only called for anon folios anyway.
>>
>> So it looks like we can support order-1 folios in the page cache without
>> any change in behaviour since file-backed folios were never added to
>> the deferred split list.
> 
> I think for the pagecache it should work. In the context of [1], a total
> mapcount would likely still be possible. Anything beyond that likely
> not, if we ever care.

Thinking about it, maybe 64bit could be made working. Anyhow, just 
something to keep in mind once we want to support folio-1 orders: memmap 
space can start getting a problem again.

-- 
Cheers,

David / dhildenb


