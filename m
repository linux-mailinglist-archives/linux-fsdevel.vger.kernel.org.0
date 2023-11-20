Return-Path: <linux-fsdevel+bounces-3176-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD24E7F0A17
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Nov 2023 01:33:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9867E280C26
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Nov 2023 00:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2BB017F6;
	Mon, 20 Nov 2023 00:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GUXAR/Nf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA095A4
	for <linux-fsdevel@vger.kernel.org>; Sun, 19 Nov 2023 16:33:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700440387;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WCyeeEPwIGj3bpAJL4TtDBoFWik53odHI36KbldyAKM=;
	b=GUXAR/NfLom0a4BXhFUPg6H5br2/z4Zbp+3gCGZiTMBXXxMsYzwiACm8j57SQlsm7mCyaC
	PhDjwxdewIDVa2oDZnQIzF16y3LgUwn6yLtGxVsriDh/uqyaRwlbSYeGjHf8U+wY1UClI+
	1HwCslJ3uttFQC5G4Gco7RkUOQLsETc=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-530-lEOmz3W_MrKJu74UjxDB7Q-1; Sun, 19 Nov 2023 19:33:03 -0500
X-MC-Unique: lEOmz3W_MrKJu74UjxDB7Q-1
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-1cc23f2226bso42683335ad.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 19 Nov 2023 16:33:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700440382; x=1701045182;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WCyeeEPwIGj3bpAJL4TtDBoFWik53odHI36KbldyAKM=;
        b=o4G/ybQ+mCaMBLsQESdJg+PY27thlGVNOMTLbqb2s6HKniggfxngtGPgPeTogmwUqR
         2x2q2PgK3p1VEh/8yzaMQs/NOuxM7cxgR01JUaoClS25qVE4AAf6+NALpubrU53l0ufH
         kZGXMcTVbN43wQm81pDRWWw9eolCGD2col+WUzvuRNVHvzDThYGHPeOSBSgmhLqRJ6Et
         aVRyMdWYGbnUUwxliZ3/gTATkUr3iHOhElIlDUVd1jmYVwrrt6jsjTOaHk0z8WvAfP1m
         9+kPyXO8Y7Wery6YZ4VANjqQN9rbdzka/mZqj592pjJPc1iBMtcnswzS+tRIDO9jMBA1
         J+CQ==
X-Gm-Message-State: AOJu0YzGgtBFUZ/Pzw5coifE/3OT+beae/XRWg41FWVN9A3yA3Bwux4O
	5npsUWyKB/V1mQNqKKKr/h8vpNs8fVmxdbLQ/ELqX85Nx6kg3TLKprtz0G/sgnJLLi+eoBN7qeJ
	nt9/mDgyeiYqabzNaefxrC+6+qg==
X-Received: by 2002:a17:903:24f:b0:1cc:31c4:377b with SMTP id j15-20020a170903024f00b001cc31c4377bmr4657582plh.63.1700440382393;
        Sun, 19 Nov 2023 16:33:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFKpiHzxc7T7GkDawGmHPBW9MXDVjLIBv1HPj4WXs1mGDpxPpVR+Zmi56gIvYiEElODTwvU8w==
X-Received: by 2002:a17:903:24f:b0:1cc:31c4:377b with SMTP id j15-20020a170903024f00b001cc31c4377bmr4657568plh.63.1700440382103;
        Sun, 19 Nov 2023 16:33:02 -0800 (PST)
Received: from [10.72.112.63] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d8-20020a170902cec800b001bbd1562e75sm4854592plg.55.2023.11.19.16.32.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Nov 2023 16:33:01 -0800 (PST)
Message-ID: <dd56647e-bcae-d38f-a4d4-d5d8c4bcd5f7@redhat.com>
Date: Mon, 20 Nov 2023 08:32:58 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 00/15] Many folio conversions for ceph
Content-Language: en-US
To: Matthew Wilcox <willy@infradead.org>, Ilya Dryomov <idryomov@gmail.com>
Cc: Jeff Layton <jlayton@kernel.org>, ceph-devel@vger.kernel.org,
 David Howells <dhowells@redhat.com>, linux-fsdevel@vger.kernel.org
References: <20230825201225.348148-1-willy@infradead.org>
 <ZVeIuiixrBypiXjp@casper.infradead.org>
From: Xiubo Li <xiubli@redhat.com>
In-Reply-To: <ZVeIuiixrBypiXjp@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 11/17/23 23:37, Matthew Wilcox wrote:
> On Fri, Aug 25, 2023 at 09:12:10PM +0100, Matthew Wilcox (Oracle) wrote:
>> I know David is working to make ceph large-folio-aware from the bottom up.
>> Here's my attempt at making the top (ie the part of ceph that interacts
>> with the page cache) folio-aware.  Mostly this is just phasing out use
>> of struct page in favour of struct folio and using the new APIs.
>>
>> The fscrypt interaction still needs a bit of work, but it should be a
>> little easier now.  There's still some weirdness in how ceph interacts
>> with the page cache; for example it holds folios locked while doing
>> writeback instead of dropping the folio lock after setting the writeback
>> flag.  I'm not sure why it does that, but I don't want to try fixing that
>> as part of this series.
>>
>> I don't have a ceph setup, so these patches are only compile tested.
>> I really want to be rid of some compat code, and cecph is sometimes the
>> last user (or really close to being the last user).
> Any progress on merging these?  It's making other patches I'm working on
> more difficult to have these patches outstanding.
>
Hi Willy,

I had one comment on the [01/15], could you confirm that ?

Thanks

- Xiubo



