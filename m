Return-Path: <linux-fsdevel+bounces-416-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CB05B7CADB1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Oct 2023 17:38:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF6F2B20E07
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Oct 2023 15:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ECC62AB2B;
	Mon, 16 Oct 2023 15:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="SIZIxrgj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E5727729
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Oct 2023 15:37:54 +0000 (UTC)
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D57E83
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Oct 2023 08:37:51 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-58949a142bfso83000a12.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Oct 2023 08:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1697470671; x=1698075471; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oaOTKWkhj+Ncly5skMVpADRKfvKmkl49ZSj9OUlLEMI=;
        b=SIZIxrgjuqqRbx5QzX+VurzqQtOYf8EfJRR5dW5eWIYKtTG41ECwyRhiVWmt1kLJRt
         L8LdMxRgovwn0yC1EOO6If0cIoQ0B6gnPO5KqbQS/MDXzjep8NLQry04c226hopvcekz
         xSKoDwY7r1suEMaGNKLjzt7KSy7V9Ta7meatoHPbgHntB1oYrEj5QfJDcLjiQjdBUeCx
         C45GmF7IZMWVsMUeMqf5q3zeBXqYizqrpUUpFmaQ/L8nfk9/jIO5mmgps/iASk7IDQNX
         29XvpZEC99Q3TPeeu+WpsCLFIxFom3z52jmrPmGhp+n/nGLZHnxYTZCYe2jB/D4qxECC
         NHhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697470671; x=1698075471;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oaOTKWkhj+Ncly5skMVpADRKfvKmkl49ZSj9OUlLEMI=;
        b=rHiw/779ZIam8eF4KMn3HlcIQa2vvR+wS56YHuknfJULfiBhpvfidQlH1lR1AAzhsK
         bamef/gZ/1saJAApvo51SFzuBiJgvjovTCfJZS1w0MSch8WyXYglzyWx0IEr1ht/aL95
         JgvnbRfBErgwSK+4uc42pbzd8FDR/DsyFXhjfbEJK0QpN95oycTM+0naJ4g/QuXu+BN8
         EH4CJ6hYV64YpIr2KwW2wA4lrWeFHMxRf8eCvpNcK0T+QWV9j0oOuUCV7mMS0/e9o24m
         9MDw+LXTdkxSjI0/e2y5G+k5Qt0EmDQqqN+0aez/7g/M9Q+Q7Pow61d9YYj43wAPtAET
         msNQ==
X-Gm-Message-State: AOJu0YweDTUe5xcnWBcHPqZSjz2/M7QhYzSvOS9EVE3dzlu5UQli5did
	xWmakxxCVJzBZV3EXOoEkICXsw==
X-Google-Smtp-Source: AGHT+IEt6IQopXt79C7UVRKDQuxG88LVLlKv2JonJNh16F7MbNICzKRuaf6/mNKWk4b5FhoAjcCwTA==
X-Received: by 2002:a17:90a:4ca4:b0:274:99ed:a80c with SMTP id k33-20020a17090a4ca400b0027499eda80cmr31810476pjh.3.1697470670913;
        Mon, 16 Oct 2023 08:37:50 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id on6-20020a17090b1d0600b0027d0adf653bsm4886462pjb.7.2023.10.16.08.37.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Oct 2023 08:37:50 -0700 (PDT)
Message-ID: <40652eee-1cea-4888-86e2-e65a23475182@kernel.dk>
Date: Mon, 16 Oct 2023 09:37:48 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: simplify bdev_del_partition()
Content-Language: en-US
To: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Christoph Hellwig <hch@lst.de>
Cc: linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20231016-fototermin-umriss-59f1ea6c1fe6@brauner>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20231016-fototermin-umriss-59f1ea6c1fe6@brauner>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 10/16/23 9:27 AM, Christian Brauner wrote:
> BLKPG_DEL_PARTITION refuses to delete partitions that still have
> openers, i.e., that has an elevated @bdev->bd_openers count. If a device
> is claimed by setting @bdev->bd_holder and @bdev->bd_holder_ops
> @bdev->bd_openers and @bdev->bd_holders are incremented.
> @bdev->bd_openers is effectively guaranteed to be >= @bdev->bd_holders.
> So as long as @bdev->bd_openers isn't zero we know that this partition
> is still in active use and that there might still be @bdev->bd_holder
> and @bdev->bd_holder_ops set.
> 
> The only current example is @fs_holder_ops for filesystems. But that
> means bdev_mark_dead() which calls into
> bdev->bd_holder_ops->mark_dead::fs_bdev_mark_dead() is a nop. As long as
> there's an elevated @bdev->bd_openers count we can't delete the
> partition and if there isn't an elevated @bdev->bd_openers count then
> there's no @bdev->bd_holder or @bdev->bd_holder_ops.
> 
> So simply open-code what we need to do. This gets rid of one more
> instance where we acquire s_umount under @disk->open_mutex.

Reviwed-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe



