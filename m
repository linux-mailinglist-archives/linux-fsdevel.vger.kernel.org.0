Return-Path: <linux-fsdevel+bounces-6962-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8971C81F05D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Dec 2023 17:26:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38B4C1F211B1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Dec 2023 16:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 784D34643E;
	Wed, 27 Dec 2023 16:25:46 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F25FC45BFE;
	Wed, 27 Dec 2023 16:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-5cd8667c59eso3990625a12.2;
        Wed, 27 Dec 2023 08:25:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703694344; x=1704299144;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0PE/DGxKJhbVAIXggezPl80ntLg4MQz3qOXEinxT3MQ=;
        b=abXivxEDFIs3dNKGPmYb+/VsjFBrhDlcCbH+ejyujhJzxdBVPmJ+PT8BRU+ujiqAur
         E1NzksvclTuV86JBId84m+nRahNxRakw8Qj20BVU9pkiN77Rl/aafE7IoQ3eaplglgD0
         edOD3uKaWXGtntjvHUNMDRibWP7SeCDMeTjz2+hw/HanzThEvAa89HlJqKoJllH2L+8C
         vnxFNmY3VDLnr5l1xbESpB68mDNXIdsgcXy4/+TnEQZmx7Ty+0gBHjdAD5q8+8YaNxCs
         GMJH5fN5bFKKeJj8iRSK7TWPIgmCTUOcLGSuMeSH/VYn6yKlQ9SY5SDvGgo1dtIvoeWH
         UO0w==
X-Gm-Message-State: AOJu0Yye6eji3Zn2zAMXdouB94dlWdEcp1mgyUsVbWhcIq7dLY5pFDIy
	TnK1SxArlXyHySuJwOVIqxQ=
X-Google-Smtp-Source: AGHT+IH/zOwNn75wpOY+KOiDM+na3AfqciidrM3SLh6/wTidYd/xK5Sq6/igVjj6fouqBLfRDPXL8A==
X-Received: by 2002:a05:6a20:993:b0:193:fdb7:f48f with SMTP id e19-20020a056a20099300b00193fdb7f48fmr8394414pzb.30.1703694343908;
        Wed, 27 Dec 2023 08:25:43 -0800 (PST)
Received: from [192.168.51.14] (c-73-231-117-72.hsd1.ca.comcast.net. [73.231.117.72])
        by smtp.gmail.com with ESMTPSA id x23-20020a056a00189700b006d9a6953f08sm7707913pfh.103.2023.12.27.08.25.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Dec 2023 08:25:42 -0800 (PST)
Message-ID: <ce26426f-5de3-4cc9-9c6e-f5409b17c147@acm.org>
Date: Wed, 27 Dec 2023 08:25:41 -0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 00/19] Pass data lifetime information to SCSI disk
 devices
Content-Language: en-US
To: Jens Axboe <axboe@kernel.dk>,
 "Martin K . Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Daejun Park <daejun7.park@samsung.com>, Kanchan Joshi <joshi.k@samsung.com>
References: <20231219000815.2739120-1-bvanassche@acm.org>
 <6b3f9f28-1ddf-41dc-9f88-744cd9cd4b96@kernel.dk>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <6b3f9f28-1ddf-41dc-9f88-744cd9cd4b96@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/18/23 17:12, Jens Axboe wrote:
> Bart, can you please stop reposting so quickly, it achieves the opposite
> of what I suspect you are looking for.

Got it. I will repost less frequently.

Jens, can you please help with reviewing patches 5 and 6 of this series?
I think that's what most important right now to help this patch series
to make progress.

Thank you,

Bart.

