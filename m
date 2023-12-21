Return-Path: <linux-fsdevel+bounces-6613-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A42BE81AC0D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Dec 2023 02:16:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D62D91C236EC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Dec 2023 01:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B7BD4696;
	Thu, 21 Dec 2023 01:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OsgpU0yv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBCA04416
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 Dec 2023 01:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703121397;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LPUgNg6sIG/w3dPgMZGJ2RTTtfGOJE1Cs+qzLnT13Io=;
	b=OsgpU0yvQhut1dTO7MSr1/ogxyEthP9Ek2d8H/q6pfC/Q+cPPad7DbB4IeKwOP3P8QF1SW
	aErjgSa18gioSK+l47u+smgPIFZ4NxSokB0br8h6ORTtmro/qNgyaq7m0pXBzi5Dtuu6hl
	VloCDL1EOQY4XBm1fdcRdBhijkWw7GM=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-156-lW7HH2NbOVCD2vjMj-AcTw-1; Wed, 20 Dec 2023 20:16:35 -0500
X-MC-Unique: lW7HH2NbOVCD2vjMj-AcTw-1
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-1d393941fbdso2660685ad.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Dec 2023 17:16:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703121394; x=1703726194;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LPUgNg6sIG/w3dPgMZGJ2RTTtfGOJE1Cs+qzLnT13Io=;
        b=mf95o80QR2YeGAfpMqDUW1Krrhjy7cX4TFU/9/DWXbnKodKBdjli033kJO/wSuB11s
         fJq1V5zSxB9vvy35Ln7HRBXDH+WR+860V99Lw34M4TuvFiGyyinvSU2vDftB91culbAZ
         3AaLbH4LPT8T4F3W5F/HjNM+ZKK6bIwuH34xvqiymhX+8sBRhVF8IE0wpKcZkOu3UlK8
         IK8oLzNIqiutyW4+yfc1K//rH9BjLRPgnZL8OCGHamRteLx3WvE52eUnQ1Q4QG+qEYI2
         XnAfcMRMQYIqu9zoEsWJ5jn/hSeDzH9G+N0nS6Db6NyUDfpXVIAx7rw3d6Mamp0cM0de
         EMHw==
X-Gm-Message-State: AOJu0YyVQu0ogxXGE502gF3+6O3Do+0O2XsQboLoX2qf3UCbgKk3rVN1
	VW2gEslq0pjc2YmZ1UEEZaUe1rsMV44vRNIH8D6jBBCGifMNkFC/5GBrnyvwo2/aUkazlYF22b5
	0bu345uHhl/dUs427UTBl4XYWpA==
X-Received: by 2002:a17:902:a3c7:b0:1d3:9d96:d18 with SMTP id q7-20020a170902a3c700b001d39d960d18mr7911268plb.12.1703121394696;
        Wed, 20 Dec 2023 17:16:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHtnSIWKOQL7I+65Ho8w7hpF7c38Drl5aBJo8e64rVV5xVP833cdtegaYZvJQt72d/ffRBMOA==
X-Received: by 2002:a17:902:a3c7:b0:1d3:9d96:d18 with SMTP id q7-20020a170902a3c700b001d39d960d18mr7911263plb.12.1703121394464;
        Wed, 20 Dec 2023 17:16:34 -0800 (PST)
Received: from [10.72.112.86] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id b6-20020a170902d50600b001d060c61da5sm338685plg.134.2023.12.20.17.16.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Dec 2023 17:16:34 -0800 (PST)
Message-ID: <915a4f0e-0b85-46e5-ab4a-9a9d1774deac@redhat.com>
Date: Thu, 21 Dec 2023 09:16:32 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 17/22] get rid of passing callbacks to ceph
 __dentry_leases_walk()
Content-Language: en-US
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, ceph-devel@vger.kernel.org
References: <20231220051348.GY1674809@ZenIV> <20231220052925.GP1674809@ZenIV>
 <446cf570-4d3d-4bdb-978c-a61d801a8c32@redhat.com>
 <20231221011201.GY1674809@ZenIV>
From: Xiubo Li <xiubli@redhat.com>
In-Reply-To: <20231221011201.GY1674809@ZenIV>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 12/21/23 09:12, Al Viro wrote:
> On Thu, Dec 21, 2023 at 08:45:18AM +0800, Xiubo Li wrote:
>> Al,
>>
>> I think these two ceph patches won't be dependent by your following
>> patches,  right ?
>>
>> If so we can apply them to ceph-client tree and run more tests.
> All of them are mutually independent, and if you are willing to take
> them through your tree - all the better.
>
Sure, I will apply them into the ceph-client repo. And will run the 
tests for them.

Thanks Al.

- Xiubo


