Return-Path: <linux-fsdevel+bounces-20276-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D194A8D0E58
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 May 2024 21:43:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F4F91C210F9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 May 2024 19:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D84F160887;
	Mon, 27 May 2024 19:43:15 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 645A217E8FC;
	Mon, 27 May 2024 19:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716838994; cv=none; b=uOU/JElTTW6BhU9v4HUuUt0Ky21W9sthj6L7rvJzrV3QeeZvTaF4OBCP8C9C/x2/H8d3BC9CVvgBD6yBBW6hC1Tlzr6GKmPqfhRoWFfmDmUlZwFb3zWax4o+tT6ZRCZ4Tye1qTal0oBtcd0F1xBH0QX7PeK4uk2xSXX0WWeDU3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716838994; c=relaxed/simple;
	bh=Q6guQNGi0jjNGbWxILSZGcvVmCxeCsFldicxz8i+EQI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fEfWs4x+prred9zZ8rV+KtvvE6t7lR05xA2Trju0MEnT3lSOx8mm0kRxHgYH7w9DL8Bl3dpuUVk1BJKLxabSsloCzYRIW/LCdes+XsxZL1YP1uUgf5HbfbBMSwuNQFuiZ45VpuYrYGKfdZT5RUAbNWfJRmyb0y9wQAz+826/5c4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4210d426325so74555e9.2;
        Mon, 27 May 2024 12:43:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716838992; x=1717443792;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q6guQNGi0jjNGbWxILSZGcvVmCxeCsFldicxz8i+EQI=;
        b=Vr8eFrWgEHMoH8MkxNsZO2saW3JeLWAM2Q7hNG6SNRT0pDxkChem2q7sSxJlTPpkVH
         lz8hLucevEvjhmuzgW1CGE2yxlvVSVsQ7NLCjYVovnWZt6tnktjAz8gGXDcumaufa855
         A7vmyZf7FpgABbvEdByhUQzL/EjSmd2B/mO4VzWQhMtV7lXB1rI1Zyo6fXCab0QYB0Ow
         ubxZTdb2T01QbWSHjmcBtmlj8N5yS7IKCYjXzoIsUE1tDeLgEMV25TDlHy/OSKCJk8Fd
         R1Z6TffBSqcnmfTMlXAmNzzcR2+of/I7lzvm0lcw9j1Tr4MtCsbwwjXqEWd5/EVITtWd
         rVGg==
X-Forwarded-Encrypted: i=1; AJvYcCXXsWL/rLqCNVltasIIRQvN995NigLujjg49EovZHH3fvVhAMK7arPorIvEHkm+Y90c07FG/3bCZd/j2kz7VH5DkpVEu6gOzY8+rJ5VeQ==
X-Gm-Message-State: AOJu0YwTKU6R7aHRy6mOwwSKxe+QfEY+hFoeFBMfPR13XZM+ukpWzaMU
	II7CoKRx4/u5NZE/xde86x04WX8izohIEbkW9ARQoPYXjFwI7KN0
X-Google-Smtp-Source: AGHT+IHPpw7qo8lDaUi+gojHWCq+4MY4MZPDTmB5gouehAe6kc+Tq5kiaXOSCym3aYXo9LOBLKqsmg==
X-Received: by 2002:adf:f9ce:0:b0:356:7963:fe9e with SMTP id ffacd0b85a97d-3567963ffb8mr5148264f8f.6.1716838991524;
        Mon, 27 May 2024 12:43:11 -0700 (PDT)
Received: from [10.100.102.74] (85.65.193.189.dynamic.barak-online.net. [85.65.193.189])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35579d7ed6fsm9840902f8f.9.2024.05.27.12.43.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 May 2024 12:43:11 -0700 (PDT)
Message-ID: <68098d8a-0193-4bb0-8cee-e72e7442c661@grimberg.me>
Date: Mon, 27 May 2024 22:43:09 +0300
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: support large folios for NFS
To: Christoph Hellwig <hch@lst.de>,
 Trond Myklebust <trond.myklebust@hammerspace.com>,
 Anna Schumaker <anna@kernel.org>, Matthew Wilcox <willy@infradead.org>
Cc: linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org
References: <20240527163616.1135968-1-hch@lst.de>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240527163616.1135968-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 27/05/2024 19:36, Christoph Hellwig wrote:
> Hi all,
>
> this series adds large folio support to NFS, and almost doubles the
> buffered write throughput from the previous bottleneck of ~2.5GB/s
> (just like for other file systems).
>
> The first patch is an old one from willy that I've updated very slightly.
> Note that this update now requires the mapping_max_folio_size helper
> merged into Linus' tree only a few minutes ago.

I'll confirm that NFS buffered writes saw a dramatic >2x improvement
against my test system.

For the series:
Tested-by: Sagi Grimberg <sagi@grimberg.me>




