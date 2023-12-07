Return-Path: <linux-fsdevel+bounces-5199-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26B5580927E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 21:39:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53E3D1C20B19
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 20:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0B6F56394
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 20:39:00 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F1B5172E;
	Thu,  7 Dec 2023 11:37:49 -0800 (PST)
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1d0a5422c80so11523615ad.3;
        Thu, 07 Dec 2023 11:37:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701977869; x=1702582669;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2Q1J5+enS2KsYa9yALuFgIlKitrdGmdGnbjYViWXE5A=;
        b=iRuEFQsIddpv5+zjVmJadoUALdrIwTVWdEc2LotKErmi23j4fFNnZaceAlD5xPxq9D
         yuPHhXWgYBLCsHK9Yj8x9rCBFCMI5eZIogdme8ywCXn7NnO5t+4v9xGjzKinqSZ++xxs
         8oC5aTRu2s5m6ybJkEEIxaURUoC25BiiW1KxlE0SsmDiSs8vKKPrB3FzA6PDc8109fkB
         hjc5SvmxPmimzWFdEbV0xW+V5Fj3N4GycEkgMVf+Xj5aHZRG2ZNY7DRLxZsjZlLcdhI9
         zf5pqFmvdG3ju2/d73+Mxb6cynuDbjbcLXKTrB1XXyFwLUktu3yk20Ji/uLcc8+ey5H9
         s+Ug==
X-Gm-Message-State: AOJu0YzRpt60OLAYNARt0bA5iEHTn8sf5Mt4uTZyGGLlZIYr0n4BWhbH
	bwg2a7AURT0R4jOkLsGoh08=
X-Google-Smtp-Source: AGHT+IHE1wdo6fpOjyQaaNwLpOlDdomdg5zdIsvX59BYcMRxIntc6aZSeweCOjgxhtb9B7iJ4XLbaA==
X-Received: by 2002:a17:903:41d1:b0:1d0:c1ea:d3ae with SMTP id u17-20020a17090341d100b001d0c1ead3aemr3579062ple.99.1701977868743;
        Thu, 07 Dec 2023 11:37:48 -0800 (PST)
Received: from [172.22.37.189] (076-081-102-005.biz.spectrum.com. [76.81.102.5])
        by smtp.gmail.com with ESMTPSA id b18-20020a170903229200b001d07d88a71esm185809plh.73.2023.12.07.11.37.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Dec 2023 11:37:47 -0800 (PST)
Message-ID: <3c08f127-45ff-458c-9ae7-75a1870781d8@acm.org>
Date: Thu, 7 Dec 2023 09:37:44 -1000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 04/17] fs: Restore F_[GS]ET_FILE_RW_HINT support
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>
Cc: "Martin K . Petersen" <martin.petersen@oracle.com>,
 linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
 Daejun Park <daejun7.park@samsung.com>, Kanchan Joshi <joshi.k@samsung.com>,
 Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>,
 Dave Chinner <dchinner@redhat.com>, Chaitanya Kulkarni <kch@nvidia.com>
References: <20231130013322.175290-1-bvanassche@acm.org>
 <20231130013322.175290-5-bvanassche@acm.org> <20231207174617.GD31184@lst.de>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20231207174617.GD31184@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/7/23 07:46, Christoph Hellwig wrote:
> On Wed, Nov 29, 2023 at 05:33:09PM -0800, Bart Van Assche wrote:
>> Revert commit 7b12e49669c9 ("fs: remove fs.f_write_hint") to enable testing
>> write hint support with fio and direct I/O.
> 
> To enable testing seems like a pretty bad argument for bloating struct
> file.  I'd much prefer to not restore it, but if you want to do so
> please write a convincing commit log.

Hi Christoph,

I have submitted a pull request for fio such that my tests can be run
even if F_SET_FILE_RW_HINT is not supported (see also
https://github.com/axboe/fio/pull/1682).

The only other application that I found that uses F_SET_FILE_RW_HINT is
Ceph. Do we want to make the Ceph code work again that uses
F_SET_FILE_RW_HINT? I think this code cannot be converted to
F_SET_RW_HINT.

 From the Ceph source code:

----------------------------------------------------------------------
int KernelDevice::choose_fd(bool buffered, int write_hint) const
{
#if defined(F_SET_FILE_RW_HINT)
   if (!enable_wrt)
     write_hint = WRITE_LIFE_NOT_SET;
#else
   // Without WRITE_LIFE capabilities, only one file is used.
   // And rocksdb sets this value also to > 0, so we need to catch this
   // here instead of trusting rocksdb to set write_hint.
   write_hint = WRITE_LIFE_NOT_SET;
#endif
   return buffered ? fd_buffereds[write_hint] : fd_directs[write_hint];
}
----------------------------------------------------------------------

Thanks,

Bart.

