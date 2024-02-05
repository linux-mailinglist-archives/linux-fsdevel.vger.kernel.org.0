Return-Path: <linux-fsdevel+bounces-10357-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 633BD84A81A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 22:52:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64FFA1C27FDD
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 21:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 280611369B1;
	Mon,  5 Feb 2024 20:46:43 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 748B11369AD
	for <linux-fsdevel@vger.kernel.org>; Mon,  5 Feb 2024 20:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707166002; cv=none; b=j66XAjzmhT7YVF9QOgBFYo39X2QGfucOzd7AW2wmwlgrlzjhH8pCtlJKZ3fpWlRJxTTX95uwPRiucBg8EZNue2O0NZEYRD/28nR8v+fyFqejcXz1zrPQ2AMecyeK7y2zbSlJwbVlwnO+rEqGMPWbGMTpOh5mXzMsydTs7DHzKwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707166002; c=relaxed/simple;
	bh=KoILZ7+Eg0t7m2EkZBes9sRMGY/sY7N1zIl6XPUqLoA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KQ5T3lItrfC4RTT8pRGFw5b2O11WRdIYFXvKfJHxTWcoZnz4+Tws33l98cgGnifVTpgQaeXO/Rf5VCfxOdKxqMP9Jlf1GutmJjpdkSluY2THlXADzV5YTeFmLCU1fnxwEif04m24fkGkPH+r1ATHBqPSeI+yhFJxtCCD/hzTmjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6de3141f041so3354027b3a.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 05 Feb 2024 12:46:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707166001; x=1707770801;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lyj/yydQKhg5WBByjq/hxGXbsahrnRoBJaEuMwvz9Lo=;
        b=EJbnp31A3tbPiz16bJr26zVREzG+mIqhYCSYSlPZCSe/pHU6vSPrVIrItOoJz+PWuQ
         Wd1h5uFgjZY1HEub0Z3tKOIOGEh2o46NhA9RGaH/v1czV+TdzHrCtnlu9zl9jK/cXkQX
         xuhXpwwO4T9v1ZemyBwew2niNj5PIym1zPSjPRXRrounWJcWm9URZjRFFpnn51oxLPl0
         tsG+u0TRRcPLXmtHyHHwxMM3VlfnclyezpOiX8ChNmeqyAfa/jm+bq80MD/SkzK/jpkL
         iqO0n0kVWAGCFgdQFLgBGkqpUYKrYEr08iGLnRVDcrdss5hKIp70aNVQiDw4qYOEKOid
         Tcgw==
X-Gm-Message-State: AOJu0Yy+9cVUisYlrUvz0DQuOjpdM0Rh4C6CoWSWhwfa0O5BcyQ9/Ul7
	sIri2yA7Hi5H/dO5jgZlaaJstd95Ul+k/IpsuGm+Qt47hr/VI1Es
X-Google-Smtp-Source: AGHT+IE1baEISgwU3VQrNriL2e97Pq9MN5fCh10cWGAhlXR5ztjm2Y3LeTWYCFLMkNEjzxDA6whg3g==
X-Received: by 2002:a05:6a20:6a0c:b0:19c:5e3f:1cd8 with SMTP id p12-20020a056a206a0c00b0019c5e3f1cd8mr767677pzk.44.1707166000526;
        Mon, 05 Feb 2024 12:46:40 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUx3xJKyq94Y77cavnQYgdmMM0mBa7iRPxcTKBsyJGFufO2dJEg2N9jIwz5QJ3bTgjEkjsfHGA4s/z5Tqjw9fw7NlrDq27Tuy8Icg3SeNfCKyEdoPd16gC45u3pCUPCUdhSiHJVtB3QbJMS+/i8tZFA2uV86vemM2toXqTdJvNxpjCptZaqpDiIFZ4Wh3WSzCZIFPR8VaUDB1oJuJJ2y4Qsjktp
Received: from ?IPV6:2620:0:1000:8411:cdf4:99a4:cfef:d785? ([2620:0:1000:8411:cdf4:99a4:cfef:d785])
        by smtp.gmail.com with ESMTPSA id z30-20020aa79e5e000000b006ddb0b0ff0dsm294812pfq.34.2024.02.05.12.46.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Feb 2024 12:46:39 -0800 (PST)
Message-ID: <b545bbbf-06c5-4e32-aebe-769c639fea6c@acm.org>
Date: Mon, 5 Feb 2024 12:46:38 -0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/6] block, fs: Restore the per-bio/request data
 lifetime fields
Content-Language: en-US
To: Jens Axboe <axboe@kernel.dk>
Cc: Christian Brauner <brauner@kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 Kanchan Joshi <joshi.k@samsung.com>
References: <20240202203926.2478590-1-bvanassche@acm.org>
 <20240202203926.2478590-7-bvanassche@acm.org>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240202203926.2478590-7-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/2/24 12:39, Bart Van Assche wrote:
> Restore support for passing data lifetime information from filesystems to
> block drivers. This patch reverts commit b179c98f7697 ("block: Remove
> request.write_hint") and commit c75e707fe1aa ("block: remove the
> per-bio/request write hint").
> 
> This patch does not modify the size of struct bio because the new
> bi_write_hint member fills a hole in struct bio. pahole reports the
> following for struct bio on an x86_64 system with this patch applied:
> 
>          /* size: 112, cachelines: 2, members: 20 */
>          /* sum members: 110, holes: 1, sum holes: 2 */
>          /* last cacheline: 48 bytes */

Hi Jens,

Since this patch affects both the block layer and VFS code, can you please
help with reviewing this patch?

Thanks,

Bart.


