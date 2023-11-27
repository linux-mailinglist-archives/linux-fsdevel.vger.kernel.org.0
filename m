Return-Path: <linux-fsdevel+bounces-3973-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 069887FA97D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Nov 2023 20:01:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9CFE3B2123C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Nov 2023 19:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48F5C3DBAA;
	Mon, 27 Nov 2023 19:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C13E8D5D;
	Mon, 27 Nov 2023 11:00:29 -0800 (PST)
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-5be30d543c4so3235804a12.2;
        Mon, 27 Nov 2023 11:00:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701111629; x=1701716429;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eF2GAnwCh5Wl+Gbs8aDczVuuiH/00RAFmCz4QwFQh9Q=;
        b=AmNzsn3H1Zu9ZWWEW0TCY1TDJAhsIpaaP4NKzSQuZtb+0mY51le+qWDMPYb1AgnY3v
         gCQ63q0fCkBQu9cglCXiUqzbMGSPvQpOcfsar9LVbF0qTRhE+96TR8yWMpMf0wSmSBTT
         Tu/1SyndsMG+SbshNcb+AlmSZNkuX5eFRh2hc1+oW4lh6FH4ZbggWqJ+2mwfMx0u9ZQn
         MKPqNDD9ixzU5g+jP08efljeTTJ1qRVZvTZ5Y4hPMmajBtqKaLRXUQcYfDOyOWV8a3G8
         dGDqQOT/rZGr8qmS6M+QMzHYun8pJ+HlTcT7ejNOsg0OU9G4dVltL8CkdQlNypxNQlQ0
         m+Kw==
X-Gm-Message-State: AOJu0Yx7JoUQNG0C50FctRpl2QYGudhLnKE3AgDchlenxjI/QinoKjFE
	WYWMajBkj2LwTyDcqwra5Mg=
X-Google-Smtp-Source: AGHT+IFKgEY8d51UqToBG4tJWu9dmlT0UGoTXo4O4PcHe/ONPOxFBj02ypg61y1wM7FhoDCaZPDbBQ==
X-Received: by 2002:a05:6a20:a129:b0:18c:ba47:74e7 with SMTP id q41-20020a056a20a12900b0018cba4774e7mr2389404pzk.52.1701111628967;
        Mon, 27 Nov 2023 11:00:28 -0800 (PST)
Received: from ?IPV6:2620:0:1000:8411:c7c5:cabf:7030:2d30? ([2620:0:1000:8411:c7c5:cabf:7030:2d30])
        by smtp.gmail.com with ESMTPSA id s1-20020a62e701000000b006c1221bc58bsm7442392pfh.115.2023.11.27.11.00.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Nov 2023 11:00:28 -0800 (PST)
Message-ID: <eadc84c5-5f73-499a-8c3e-eb5bfbc67ed1@acm.org>
Date: Mon, 27 Nov 2023 11:00:26 -0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/15] fs: Rename the kernel-internal data lifetime
 constants
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>
Cc: "Martin K . Petersen" <martin.petersen@oracle.com>,
 linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
 Daejun Park <daejun7.park@samsung.com>, Kanchan Joshi <joshi.k@samsung.com>,
 Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>,
 Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>
References: <20231114214132.1486867-1-bvanassche@acm.org>
 <20231114214132.1486867-2-bvanassche@acm.org> <20231127070830.GA27870@lst.de>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20231127070830.GA27870@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/26/23 23:08, Christoph Hellwig wrote:
> More importantly these constant have been around forever, so we'd better
> have a really good argument for changing them.

Hi Christoph,

I will drop this patch.

As you know the NVMe and SCSI specifications use the numeric range 0..63 for
the data lifetime so there is a gap between the values supported by the
F_[GS]ET_RW_HINT fcntls and the data lifetime values accepted by widely used
storage devices. Do you think that it should be possible for user space
applications to specify the full range (0..63)?

Thanks,

Bart.

