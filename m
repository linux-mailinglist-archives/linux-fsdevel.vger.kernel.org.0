Return-Path: <linux-fsdevel+bounces-6457-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF67A817F2D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Dec 2023 02:12:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DCE91C22C3E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Dec 2023 01:12:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3794C17D5;
	Tue, 19 Dec 2023 01:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Wg1P0xis"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86152137C
	for <linux-fsdevel@vger.kernel.org>; Tue, 19 Dec 2023 01:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-5c6910e93e3so640634a12.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Dec 2023 17:12:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1702948354; x=1703553154; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FyD8HfWQyf6LfBl1NPEudbU6H1HSAZ5Pn+m4oHtEKJw=;
        b=Wg1P0xishPnVdzKuwGifzDuMLmunfkLZUA6/WaSzuTbNBF/Ti4nm+saBAgUXHfTTn2
         Ye59Ody1EOQP8hguHGTOdSz8hhlXQ9F5OwivN+58xvXxnUaxpJFZJKaibUXQDSUNOMKY
         wIyq/4FoAFmRK7qiE1aw6AGVfhV6gsyOlrHHwmvx8WV2ubr+NuX0Ke/BeHaWOkbs31iQ
         lLn8b5KF/KEvBEXB2f27fkBgJFeX/xQlK4rnos22rpD17C5QHyKukYBA415KYnHOR0ET
         TZ1ITABCYm63qSX6Nst2RjJK6LBCJNSKABA5P4q7vj/N1qYAk3CdJC4dDqQl0r1xRAI+
         pSFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702948354; x=1703553154;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FyD8HfWQyf6LfBl1NPEudbU6H1HSAZ5Pn+m4oHtEKJw=;
        b=Mj6S5NAWkFxnM0LOPj+5zNdcrDC3nItgEdqzNVzOyvPyPg6XuqoKXuVXvwXJewW1IB
         Y+wT4gQ5OYsdGjYyIqbhBn4nR0+1g7ClG26ghRdFJcpuy7MbogfineWfDb+47FP+5QS1
         58MG5QiY4b0nHiJwCVhJrThQhRIpTIXjKXdeBMRAVoZhFt1BY7O7TXv2nTakLNs2F8lI
         ZPkyUIYZXbet/uzZr5/MFa6CfrgIqUIW2+maO7NowlRM6eXk6UBhKTPWfc4JQ+/7mfEr
         TsNr12VXJfnNRQ++MNTQJ4Cxy5ZqJ6RxRGKwkLl3UWSn81uBtDxVZoQXGPLdwSO/3X1w
         9bBg==
X-Gm-Message-State: AOJu0Yx2bjbEU9SaKwGJQLSrW3Ts8iQwBsJEMPkYETCtQ1384Pen3wC0
	VaR8ZpKmZRb2vlLznwBGN3m+Lg==
X-Google-Smtp-Source: AGHT+IHzTKkhe0cRVbbtQbsADxYsCKZfTSYLFLvAalrCz0C8TVbXqipR5Q215SljZARR92Emk8hj0A==
X-Received: by 2002:a05:6a20:7d9c:b0:18f:c77b:9fdd with SMTP id v28-20020a056a207d9c00b0018fc77b9fddmr40522857pzj.1.1702948354510;
        Mon, 18 Dec 2023 17:12:34 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id 10-20020a63114a000000b005cd821a01d4sm4330736pgr.28.2023.12.18.17.12.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Dec 2023 17:12:33 -0800 (PST)
Message-ID: <6b3f9f28-1ddf-41dc-9f88-744cd9cd4b96@kernel.dk>
Date: Mon, 18 Dec 2023 18:12:32 -0700
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
To: Bart Van Assche <bvanassche@acm.org>,
 "Martin K . Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Daejun Park <daejun7.park@samsung.com>, Kanchan Joshi <joshi.k@samsung.com>
References: <20231219000815.2739120-1-bvanassche@acm.org>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20231219000815.2739120-1-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/18/23 5:07 PM, Bart Van Assche wrote:
> Hi Martin,
> 
> UFS vendors need the data lifetime information to achieve good performance.
> Providing data lifetime information to UFS devices can result in up to 40%
> lower write amplification. Hence this patch series that adds support in F2FS
> and also in the block layer for data lifetime information. The SCSI disk (sd)
> driver is modified such that it passes write hint information to SCSI devices
> via the GROUP NUMBER field.
> 
> Please consider this patch series for the next merge window.

Bart, can you please stop reposting so quickly, it achieves the opposite
of what I suspect you are looking for.

-- 
Jens Axboe


