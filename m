Return-Path: <linux-fsdevel+bounces-2411-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 11BD07E5D0C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Nov 2023 19:19:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 419791C20B2B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Nov 2023 18:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79D04358B3;
	Wed,  8 Nov 2023 18:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h6lKfaFB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E6BD358A2
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 Nov 2023 18:19:51 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EDB21FF9
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 Nov 2023 10:19:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699467589;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Tix/i3v+sgjwjsKkq5B9E9w28/STeAVpcb2O8GD/72g=;
	b=h6lKfaFBGbw6zs90MQ6nvbK/pT/UHyfyoNfC7rzHBVMurFzXrPx9sJEKH7FPU+2x329Vgx
	Jhh9BM6glvXmhntblbafQY1nq1YL26D1Ox8FAqCO843kpUklKoBb+Jlenwm69WeWHJtzYI
	VNsk82pTrzrI/H4oG0raN+TNVW1P5xU=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-212-MIlAqR6hNWKIYx4utqV7Nw-1; Wed, 08 Nov 2023 13:19:48 -0500
X-MC-Unique: MIlAqR6hNWKIYx4utqV7Nw-1
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-420f5614aa9so98051cf.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 Nov 2023 10:19:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699467587; x=1700072387;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Tix/i3v+sgjwjsKkq5B9E9w28/STeAVpcb2O8GD/72g=;
        b=rP2gDOaoYXSM4dPQyh4DIX9+BzX26OEjgUtdDBhRfkkSzy65qv2ml4fg+IKsUx1r/g
         n8DawHyagx05KXR+A+6TqsLH/aNbtfmr3t2fAwdxUVG7pC17wgEiDEspyloxF3yd6Sbu
         QfXJobcITMBaGRtKOWFdo81FFAa9M9Ss0SccIZEtC/3ICq0uMfnntaLa3/rAQAqJZiAd
         9Bq7/VNeq2z1vsyG2AuUfkwa8ng4bbWlDfo0WqHdGKuwyWHnSNC+DpYnV+NrzjrcfxK6
         edKkFSzeNbxJTDWAR47HdrX5SkayrUjDAcCJyEelPLoubVtfHN1EOk9kWpTwK/YtU8Bs
         ZJeg==
X-Gm-Message-State: AOJu0Yw5GcKQkuogMfE9KxSKE4yewCBvK1rTllQd2MccJHHaF5NBJjM5
	o9P7iosZzptPy1fvE5AbhBvoR95UtxIzLoGP5u2DDSIBt0v71FMCi4R4j+7ogVYlT6Yot3kyw2E
	nePRm96U5/E/V1UUsLZ5btsEWB54r7iISVA==
X-Received: by 2002:ac8:5f4a:0:b0:418:737:87fc with SMTP id y10-20020ac85f4a000000b00418073787fcmr2680229qta.18.1699467586845;
        Wed, 08 Nov 2023 10:19:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFnHaEjW4kYfsbsP4hrsQaPNwtaelyJHp6iJrJIJ0nO9aIyi2ROjvbWutD5zP71LUr9ChB1gQ==
X-Received: by 2002:ac8:5f4a:0:b0:418:737:87fc with SMTP id y10-20020ac85f4a000000b00418073787fcmr2680214qta.18.1699467586578;
        Wed, 08 Nov 2023 10:19:46 -0800 (PST)
Received: from ?IPV6:2600:4040:7c46:e800:32a2:d966:1af4:8863? ([2600:4040:7c46:e800:32a2:d966:1af4:8863])
        by smtp.gmail.com with ESMTPSA id z15-20020ac8454f000000b00419ab6ffedasm1152697qtn.29.2023.11.08.10.19.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Nov 2023 10:19:45 -0800 (PST)
Message-ID: <1d634875-8df2-414f-bd97-04a50d55fc48@redhat.com>
Date: Wed, 8 Nov 2023 13:19:45 -0500
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] fuse: Rename DIRECT_IO_{RELAX -> ALLOW_MMAP}
To: Bernd Schubert <bernd.schubert@fastmail.fm>,
 Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org, mszeredi@redhat.com, gmaglione@redhat.com,
 hreitz@redhat.com
References: <20230920024001.493477-1-tfanelli@redhat.com>
 <CAJfpegtVbmFnjN_eg9U=C1GBB0U5TAAqag3wY_mi7v8rDSGzgg@mail.gmail.com>
 <32469b14-8c7a-4763-95d6-85fd93d0e1b5@fastmail.fm>
Content-Language: en-US
From: Tyler Fanelli <tfanelli@redhat.com>
In-Reply-To: <32469b14-8c7a-4763-95d6-85fd93d0e1b5@fastmail.fm>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/6/23 9:08 AM, Bernd Schubert wrote:
> Hi Miklos,
>
> On 9/20/23 10:15, Miklos Szeredi wrote:
>> On Wed, 20 Sept 2023 at 04:41, Tyler Fanelli <tfanelli@redhat.com> 
>> wrote:
>>>
>>> At the moment, FUSE_INIT's DIRECT_IO_RELAX flag only serves the purpose
>>> of allowing shared mmap of files opened/created with DIRECT_IO enabled.
>>> However, it leaves open the possibility of further relaxing the
>>> DIRECT_IO restrictions (and in-effect, the cache coherency 
>>> guarantees of
>>> DIRECT_IO) in the future.
>>>
>>> The DIRECT_IO_ALLOW_MMAP flag leaves no ambiguity of its purpose. It
>>> only serves to allow shared mmap of DIRECT_IO files, while still
>>> bypassing the cache on regular reads and writes. The shared mmap is the
>>> only loosening of the cache policy that can take place with the flag.
>>> This removes some ambiguity and introduces a more stable flag to be 
>>> used
>>> in FUSE_INIT. Furthermore, we can document that to allow shared 
>>> mmap'ing
>>> of DIRECT_IO files, a user must enable DIRECT_IO_ALLOW_MMAP.
>>>
>>> Tyler Fanelli (2):
>>>    fs/fuse: Rename DIRECT_IO_RELAX to DIRECT_IO_ALLOW_MMAP
>>>    docs/fuse-io: Document the usage of DIRECT_IO_ALLOW_MMAP
>>
>> Looks good.
>>
>> Applied, thanks.  Will send the PR during this merge window, since the
>> rename could break stuff if already released.
>
> I'm just porting back this feature to our internal fuse module and it 
> looks these rename patches have been forgotten?
>
>
> Thanks,
> Bernd
>
 From a conversation with Miklos, I believe the patches will be modified 
to make DIRECT_IO_RELAX an obsolete alias and still add 
DIRECT_IO_ALLOW_MMAP.


Tyler


