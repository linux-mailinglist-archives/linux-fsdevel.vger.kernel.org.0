Return-Path: <linux-fsdevel+bounces-3925-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A5A3D7F9EFD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Nov 2023 12:52:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D72351C20D9C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Nov 2023 11:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A40C71A27A;
	Mon, 27 Nov 2023 11:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Mxuu75ab"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A65D13A
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 Nov 2023 03:52:18 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-50aaaf6e58fso6237943e87.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Nov 2023 03:52:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1701085937; x=1701690737; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UDO7ncvXAATevhwT++kqK1bgvPT8hD/xVk4r8C8v3oU=;
        b=Mxuu75ab8TDgyQqcOZlZEv1qjQENnoDNfkXQ8hLS4iR/H6rMaySKwpmKP7rpAxx/AK
         vsfSVDS1jmO3iM4xcPvbXZZgQuDTrn2lzwwEb6h1JVnLDMLGmV5NtkhQP36d0lzBpZjT
         1vOE8Pk87DSe1t5D3kWUpdAPO31p0Q7OIUb/yYD/jBZ+606jKq6Y/pkjL4LeGYu5b+Qx
         omstqQI5wT1yJwI7EUwR7EnuUuEJQTCZIaEiAD4ZGq3mvoFy58hN9eruiw0Rk0HCtTRP
         +XqiyLPC5LKZ4kvmGK5E41CwE4hQQtvEdN1Wf0xS/VO5yNmtTOCz55UGm/83bzExNsfM
         GCNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701085937; x=1701690737;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UDO7ncvXAATevhwT++kqK1bgvPT8hD/xVk4r8C8v3oU=;
        b=daVi7Wx+aCmwl+ScXXa/k2erEtr5+khA5gbvmQhYp5ZidsZbAMxNe0yK5z2BAO07w3
         jOQ/DHF8smDrkbBfpidOHGMFryqNYjfQeaxzNSnI4AeTwDsKJpxhdOX9ylwMYKhulfaQ
         mVOe/M4EwEiknQ0M3x3nc25/nIgPnLZzOgSt0zQ7tvJYyuUTdvyYQ+p4C93PgrgG7Alx
         l3iiJeC4D6EC6dUbcdF8QQLIYh7AbRLBlpZ+Nqi7PNZAS29fq0lYYjt6fOjQcI7eRpeq
         bSm8AGFWT64UBbcL+gFeIjVFrbNOcMDeXv0gJBtLoW3gTGw5dS6kySRv8KAiypMg8BQ2
         N+0A==
X-Gm-Message-State: AOJu0YwmGCyYxUYjlm3qw+BgpzoK7aHIVEiEddKUpmDa+ZtTj/ku8dqn
	ObLMmygp2F6bT7dEzGLbkwH54A==
X-Google-Smtp-Source: AGHT+IH4TrdNMPzblGZNP+ycO68tEu2jCSB6jgINc1mAPjd3KiDZt90uG7xK9DQ2U8O9Q0zTqoOViQ==
X-Received: by 2002:a05:6512:2244:b0:50b:a68e:9541 with SMTP id i4-20020a056512224400b0050ba68e9541mr8023149lfu.23.1701085936674;
        Mon, 27 Nov 2023 03:52:16 -0800 (PST)
Received: from ?IPV6:2a02:6b6a:b5c7:0:e8f2:79b9:236a:4d41? ([2a02:6b6a:b5c7:0:e8f2:79b9:236a:4d41])
        by smtp.gmail.com with ESMTPSA id r7-20020a05600c35c700b0040b30be6244sm13673021wmq.24.2023.11.27.03.52.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Nov 2023 03:52:16 -0800 (PST)
Message-ID: <9867cf7b-29a1-4fc7-61b0-7212268f9d50@bytedance.com>
Date: Mon, 27 Nov 2023 11:52:15 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [External] Re: Conditions for FOLL_LONGTERM mapping in fsdax
Content-Language: en-US
To: Christoph Hellwig <hch@infradead.org>
Cc: dan.j.williams@intel.com, vishal.l.verma@intel.com, dave.jiang@intel.com,
 nvdimm@lists.linux.dev, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
 Fam Zheng <fam.zheng@bytedance.com>,
 "liangma@liangbit.com" <liangma@liangbit.com>
References: <172ab047-0dc7-1704-5f30-ec7cd3632e09@bytedance.com>
 <454dbfa1-2120-1e40-2582-d661203decca@bytedance.com>
 <a0d67f2d-f66b-8873-7c11-31d90aae8e8c@bytedance.com>
 <ZVw2CYKcZgjmHPXk@infradead.org>
From: Usama Arif <usama.arif@bytedance.com>
In-Reply-To: <ZVw2CYKcZgjmHPXk@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 21/11/2023 04:46, Christoph Hellwig wrote:
> We don't have any way to recall the LONGTERM mappings, so we can't
> support them on DAX for now.
> 

By recall do you mean put the LONGTERM pages back? If I removed the 
check in check_vma and allowed the mappings to happen in fsdax, I can 
see that the mappings unmap/unpin in vfio_iommu_type1_unmap_dma later on 
which eventually ends up calling put_pfn.

Thanks

