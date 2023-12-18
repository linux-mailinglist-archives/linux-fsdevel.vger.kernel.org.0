Return-Path: <linux-fsdevel+bounces-6435-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB9E5817E29
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Dec 2023 00:31:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89F6928263F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Dec 2023 23:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0148B768EF;
	Mon, 18 Dec 2023 23:29:08 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F5F760B7;
	Mon, 18 Dec 2023 23:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3b9d8bfe845so3098926b6e.0;
        Mon, 18 Dec 2023 15:29:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702942145; x=1703546945;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IMhxuDm7jCgcjkNbF9utPAMTKDmnaTIQB3+kH020gZw=;
        b=LruCcIdfmRM1YMppDxF6QuzrZJZBl8GL/plxXKaQPtdDNgZ05ArucORp6Gh/lYXmcu
         5hHvBVhnz3ccGNNBQ4s72zVCx2lXS63KPnh40TflLb9eoWoNGQLUIkKmbAI8sPItAIR/
         +XVneQ2ridGPHKuPC6UNz5L03E9pBFoHZNvfhGpH1sNNogF6prP9G4XzPDrbZnTUpDhy
         fxpp1nlVF5CXgdIpRun+7DwnvBsWVQgMRrfQ5bGzXf8GaGwzAtfG2TtD4XTj7yIN1oj8
         WyeRdQI9JZy0q25ChI/1sHRp4JQRV5LqVvWp/m9RLRWd10d8egXQ9CH8nSh5z/63HLoG
         aJlQ==
X-Gm-Message-State: AOJu0Yygk3XE/aG0dbxr2iCDPRiO+y9EQnRibXZiSv2QQKnI4mPTRsMo
	zlBhWiLt9/beLWx9/r6MriEjb0NzqP8=
X-Google-Smtp-Source: AGHT+IGhmwkLxf9WBMuku/O82sDnDglDuGoyICe9RL55MLWzp0MGV2cbEblM/1mUBzd2970BDakqvA==
X-Received: by 2002:a05:6808:10cc:b0:3b2:f500:c1e5 with SMTP id s12-20020a05680810cc00b003b2f500c1e5mr24972479ois.29.1702942145165;
        Mon, 18 Dec 2023 15:29:05 -0800 (PST)
Received: from ?IPV6:2620:0:1000:8411:e67:7ba6:36a9:8cd5? ([2620:0:1000:8411:e67:7ba6:36a9:8cd5])
        by smtp.gmail.com with ESMTPSA id n8-20020a654508000000b005c65fcca22csm15697270pgq.85.2023.12.18.15.29.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Dec 2023 15:29:04 -0800 (PST)
Message-ID: <7d8564bc-8711-43f5-b6b5-21ae204783f6@acm.org>
Date: Mon, 18 Dec 2023 15:29:01 -0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 00/19] Pass data lifetime information to SCSI disk
 devices
Content-Language: en-US
To: dgilbert@interlog.com, "Martin K . Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, Daejun Park <daejun7.park@samsung.com>,
 Kanchan Joshi <joshi.k@samsung.com>
References: <20231218185705.2002516-1-bvanassche@acm.org>
 <dbfe9ac0-d432-4911-8a47-23d3d6f3811a@interlog.com>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <dbfe9ac0-d432-4911-8a47-23d3d6f3811a@interlog.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/18/23 15:08, Douglas Gilbert wrote:
> On 12/18/23 13:56, Bart Van Assche wrote:
>> Changes compared to v6:
>>   - Dropped patch "fs: Restore F_[GS]ET_FILE_RW_HINT support".
> 
> That leaves us with F_SET_RW_HINT and F_GET_RW_HINT ioctls. Could you please
> explain, perhaps with an example, what functionality is lost and what we still
> have?
Hmm ... what information do you expect that is not available in the fcntl man
page? From that man page:

        F_SET_RW_HINT (uint64_t *; since Linux 4.13)
               Sets the read/write hint value associated with the underlying inode re‐
               ferred to by fd.  This hint persists until either it is explicitly mod‐
               ified or the underlying filesystem is unmounted.

        F_SET_FILE_RW_HINT (uint64_t *; since Linux 4.13)
               Sets the read/write hint value associated with the open  file  descrip‐
               tion referred to by fd.

The functionality that is lost is to open a file multiple times and to call
F_SET_FILE_RW_HINT with a different value for each file. Ceph used this approach
to specify R/W hints per LBA range in combination with direct I/O.

Bart.

