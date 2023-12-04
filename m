Return-Path: <linux-fsdevel+bounces-4792-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25EFD803D37
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 19:37:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D09D81F21220
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 18:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58EA12FC21
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 18:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RhNTDsrN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ED2B83
	for <linux-fsdevel@vger.kernel.org>; Mon,  4 Dec 2023 09:22:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701710541;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=BxpEGgGCNFY0+iGwQLlTZOTLsM4FANkSWPWg5m69yu4=;
	b=RhNTDsrNsg7iOJAbb1cj+S2PKb6q6UiGxCFqzi6X3B5mA4g05w1Mzrj63vqHV7Tjv1UaPQ
	YMZU3EQ4iXKm6kGzLWmZGM0sK5GKwEGR1x71Ov2W90zpqlK0uQGm9dflVZsGlVWYcGxXai
	dn51riXvwjX4+B7kNaMjRrljFDQ+d/0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-167-fyYQguW-NhW0UoND057wgw-1; Mon, 04 Dec 2023 12:22:19 -0500
X-MC-Unique: fyYQguW-NhW0UoND057wgw-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-33349915da3so1036873f8f.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 04 Dec 2023 09:22:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701710539; x=1702315339;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BxpEGgGCNFY0+iGwQLlTZOTLsM4FANkSWPWg5m69yu4=;
        b=HctaOk9o3XRASQ8nPcYv1NrbJ1G+sBqtkPlXazIJvwgNwRNIPauRfwBZo6qVEP6J33
         XUiThZRcaIiAs5dBotKC03ZOR7PmStxnwJcuQUWcfQbEA+6uhP9QIRxWPEs9Xyne8EcI
         pqeo9dSOtivYj77bX/KB62dZ6z5E8IjQ09y0SD0WAaN/W6+HNHXBOC/vTvZuRJ3BMyFL
         pXbO2IgTzjJ7LtAcjd1rqTWqVIg7woEFzWHxrdTuDctCgxCPLJjZgm7C65SXP4sNePCm
         1ezNbovpovvmDZX/eKuXZdORCvZt9Tiq0dQypz9fKoGVoN+gEcVxXQ5d0/keRJssi446
         1uCA==
X-Gm-Message-State: AOJu0YwhXQJgCb+YbA84ormw4+rpEoLTAsCLrTxamZ8BX58CYu3qeGc9
	DHwadNKxbdntU0iHDuu3kgqq0nZIIWyNULNtTXL9YF2Urx/rayKzhLu/8iWRKCv9+V8K/a1zY7z
	x6TqeTCLecehCmwOgmkahcGTvOg==
X-Received: by 2002:a5d:480f:0:b0:333:2fd2:3c08 with SMTP id l15-20020a5d480f000000b003332fd23c08mr2487253wrq.193.1701710538746;
        Mon, 04 Dec 2023 09:22:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGaKr4E0NTD6V2uyjFu1MJyo8t9v6rQSlbxuJnXfbEvkLVX00Haxh5lbg4sPf0yhSQVIAzDlg==
X-Received: by 2002:a5d:480f:0:b0:333:2fd2:3c08 with SMTP id l15-20020a5d480f000000b003332fd23c08mr2487245wrq.193.1701710538407;
        Mon, 04 Dec 2023 09:22:18 -0800 (PST)
Received: from ?IPV6:2003:cb:c722:3700:6501:8925:6f9:fcdc? (p200300cbc72237006501892506f9fcdc.dip0.t-ipconnect.de. [2003:cb:c722:3700:6501:8925:6f9:fcdc])
        by smtp.gmail.com with ESMTPSA id q11-20020a5d658b000000b003333298eb4bsm9420907wru.61.2023.12.04.09.22.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Dec 2023 09:22:18 -0800 (PST)
Message-ID: <d830e87d-9937-43c8-b29b-826c31e31e9f@redhat.com>
Date: Mon, 4 Dec 2023 18:22:17 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Issue with 8K folio size in __filemap_get_folio()
Content-Language: en-US
To: Matthew Wilcox <willy@infradead.org>
Cc: Viacheslav Dubeyko <slava@dubeyko.com>,
 Linux FS Devel <linux-fsdevel@vger.kernel.org>, linux-mm@kvack.org,
 Hugh Dickins <hughd@google.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
References: <B467D07C-00D2-47C6-A034-2D88FE88A092@dubeyko.com>
 <ZWzy3bLEmbaMr//d@casper.infradead.org>
 <ZW0LQptvuFT9R4bw@casper.infradead.org>
 <22d5bd19-c1a7-4a6c-9be4-e4cb1213e439@redhat.com>
 <ZW4JqpKAc56aIUhF@casper.infradead.org>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <ZW4JqpKAc56aIUhF@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04.12.23 18:17, Matthew Wilcox wrote:
> On Mon, Dec 04, 2023 at 04:09:36PM +0100, David Hildenbrand wrote:
>> I think for the pagecache it should work. In the context of [1], a total
>> mapcount would likely still be possible. Anything beyond that likely not, if
>> we ever care.
> 
> I confess I hadn't gone through your patches.
> 
> https://lore.kernel.org/all/20231124132626.235350-8-david@redhat.com/
> 
> is the critical one.  It's actually going to walk off the end of order-2
> folios today (which we'll create, eg with XFS).

Note that order-2 only uses _rmap_val0. So that *should* work  as 
expected (and that layout resulted in the best cache behavior, weirdly 
enough).

> 
> You can put _rmap_val0 and _rmap_val1 in page2 and _rmap_val2-5 in page3
> to fix this.  Once we're allocating order-1 folios, I think you can
> avoid this scheme and just check page0 and page1 mapcounts independently.

I could put _rmap_val0 in page1 after I get rid of  		_folio_nr_pages. 
That would make it work on 64bit.

But yeah, it feels kind of stupid to do elaborate tracking for "it's 2 
pages". OTOH, less special-casing can be preferable.

-- 
Cheers,

David / dhildenb


