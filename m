Return-Path: <linux-fsdevel+bounces-5200-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0668880927F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 21:39:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3826C1C20AA1
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 20:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3B3F57313
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 20:39:05 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 733B811D;
	Thu,  7 Dec 2023 11:39:15 -0800 (PST)
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-5c66bbb3d77so1005399a12.0;
        Thu, 07 Dec 2023 11:39:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701977955; x=1702582755;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7ea0bLt1xDXJqLwpVnDjBrB6RdwQeP53hqIoiRkcKIc=;
        b=VNyQstg6KJ86CpTOmpJCpwupXTsXc3hzKN3WWmUgf1FUj9Y2i4poP6RGZACqUxvR1D
         ldF/92ECloYyX+YXxi8Xb4CTYi10fs0YFPkGeFlzT7H8MKfzJ8bZVHY+3lEzVIWDyeW5
         NBkgzlUgfjqY12C020NUbhuATfUS3RSONjzQ7LBIzRQIty+uolW1Tt1L4YVsK2lDTtm7
         QbLpkXK/l3FJFsULbxHCyGgPVYoz/vB3knapBQyS8eS0Nlk7I0hzS+0ZWrx6V2N6P4CD
         QCm2ykv8Jr4/XN95MCNFrvf6Htf3FR58vdd+Ota7rFay5DFN2iBYevM+5OX8l1u5zsrw
         UB+A==
X-Gm-Message-State: AOJu0Ywbpg7h3qx7sR7kIgG6O/IoYuQy1gspy9gwbdnTyqk4254+AcGI
	WXL0d30UvZeUWZLq2shDLWI=
X-Google-Smtp-Source: AGHT+IGo4/Dq1BZH0p3mEPgS0rcxwkz+3AegL4OI0Sf5oNuE0HhSFxDEamZqnOHJlnhksU+gYF1OUw==
X-Received: by 2002:a17:902:db0d:b0:1d0:b24c:17d5 with SMTP id m13-20020a170902db0d00b001d0b24c17d5mr3003183plx.35.1701977954659;
        Thu, 07 Dec 2023 11:39:14 -0800 (PST)
Received: from [172.22.37.189] (076-081-102-005.biz.spectrum.com. [76.81.102.5])
        by smtp.gmail.com with ESMTPSA id b18-20020a170903229200b001d07d88a71esm185809plh.73.2023.12.07.11.39.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Dec 2023 11:39:08 -0800 (PST)
Message-ID: <fd6d207d-fe03-4fdf-bd74-3463860135ef@acm.org>
Date: Thu, 7 Dec 2023 09:39:06 -1000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 03/17] fs/f2fs: Restore the whint_mode mount option
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>
Cc: "Martin K . Petersen" <martin.petersen@oracle.com>,
 linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
 Daejun Park <daejun7.park@samsung.com>, Kanchan Joshi <joshi.k@samsung.com>,
 Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
References: <20231130013322.175290-1-bvanassche@acm.org>
 <20231130013322.175290-4-bvanassche@acm.org> <20231207174529.GC31184@lst.de>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20231207174529.GC31184@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/7/23 07:45, Christoph Hellwig wrote:
> On Wed, Nov 29, 2023 at 05:33:08PM -0800, Bart Van Assche wrote:
>> Restore support for the whint_mode mount option by reverting commit
>> 930e2607638d ("f2fs: remove obsolete whint_mode").
> 
> I know that commit sets a precedence by having a horribly short and
> uninformative commit message, but please write a proper one for this
> commit and explain why you are restoring the option.  Also if anything
> changed since last year.

Hi Christoph,

A possible approach is that I drop this patch from this patch series and
that I let the F2FS maintainers restore write hint support in F2FS.

Thanks,

Bart.

