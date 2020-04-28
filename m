Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACE951BB5CD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Apr 2020 07:20:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726299AbgD1FUh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Apr 2020 01:20:37 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35849 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725917AbgD1FUg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Apr 2020 01:20:36 -0400
Received: by mail-pg1-f194.google.com with SMTP id o185so9768533pgo.3;
        Mon, 27 Apr 2020 22:20:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=vxbCh2ZY2ziZZ0zt5JmFVi9sNiqULsfecLw1vp9X5vM=;
        b=GmHGCkILwi5JbJPMFGux4GqNAn52X5uwQGQyOgay0LKcrn+3CM7qPNUnqTvOcPf3D5
         9xVnbzs2PWS+baqHhxJ262H/mzM/P2/F/kRqV5uGjp9OO3isNttyYV/edqVoLjNRpAct
         fNJO6cIqvuBmjQakLEz6ZXINUDIVYhfIXHc8WtbPPwuU41wtlPw9GWFCaNQr/4Yv8aek
         TkDuFjYIZj4NAo9vQAy7VcID6xYcAGfRIjVnfrDK/oIm4Pgb0yYeLNfU75jJSkARhDG2
         DQlcrP69cy6PjvWULj8j6l0/2ezSZsW8a2YQPcv6tErjTXTQZFc4difd3MfjVUwGPfSq
         1Pog==
X-Gm-Message-State: AGi0Puajhep972Bcb5LLb9mYyCaHml8rKX0D+J7gknZ/vUTqnb+4Red7
        dfD/lYKC1uVM6eXEJ51NcFlCcZ2JIFol1w==
X-Google-Smtp-Source: APiQypIxlpkUXAGXLMmLTdY/cx8oCqDBRUSAAIQXRnFZerdHrPnzLWOI2csxSLeZUMbj2nnfzRh3AA==
X-Received: by 2002:a63:7c4:: with SMTP id 187mr16577436pgh.59.1588051235884;
        Mon, 27 Apr 2020 22:20:35 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:a598:4365:d06:a875? ([2601:647:4000:d7:a598:4365:d06:a875])
        by smtp.gmail.com with ESMTPSA id s13sm13731186pfm.62.2020.04.27.22.20.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Apr 2020 22:20:35 -0700 (PDT)
Subject: Re: [PATCH v8 04/11] block: Introduce REQ_OP_ZONE_APPEND
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-block <linux-block@vger.kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Keith Busch <kbusch@kernel.org>,
        "linux-scsi @ vger . kernel . org" <linux-scsi@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "linux-fsdevel @ vger . kernel . org" <linux-fsdevel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
References: <20200427113153.31246-1-johannes.thumshirn@wdc.com>
 <20200427113153.31246-5-johannes.thumshirn@wdc.com>
From:   Bart Van Assche <bvanassche@acm.org>
Autocrypt: addr=bvanassche@acm.org; prefer-encrypt=mutual; keydata=
 mQENBFSOu4oBCADcRWxVUvkkvRmmwTwIjIJvZOu6wNm+dz5AF4z0FHW2KNZL3oheO3P8UZWr
 LQOrCfRcK8e/sIs2Y2D3Lg/SL7qqbMehGEYcJptu6mKkywBfoYbtBkVoJ/jQsi2H0vBiiCOy
 fmxMHIPcYxaJdXxrOG2UO4B60Y/BzE6OrPDT44w4cZA9DH5xialliWU447Bts8TJNa3lZKS1
 AvW1ZklbvJfAJJAwzDih35LxU2fcWbmhPa7EO2DCv/LM1B10GBB/oQB5kvlq4aA2PSIWkqz4
 3SI5kCPSsygD6wKnbRsvNn2mIACva6VHdm62A7xel5dJRfpQjXj2snd1F/YNoNc66UUTABEB
 AAG0JEJhcnQgVmFuIEFzc2NoZSA8YnZhbmFzc2NoZUBhY20ub3JnPokBOQQTAQIAIwUCVI67
 igIbAwcLCQgHAwIBBhUIAgkKCwQWAgMBAh4BAheAAAoJEHFcPTXFzhAJ8QkH/1AdXblKL65M
 Y1Zk1bYKnkAb4a98LxCPm/pJBilvci6boefwlBDZ2NZuuYWYgyrehMB5H+q+Kq4P0IBbTqTa
 jTPAANn62A6jwJ0FnCn6YaM9TZQjM1F7LoDX3v+oAkaoXuq0dQ4hnxQNu792bi6QyVdZUvKc
 macVFVgfK9n04mL7RzjO3f+X4midKt/s+G+IPr4DGlrq+WH27eDbpUR3aYRk8EgbgGKvQFdD
 CEBFJi+5ZKOArmJVBSk21RHDpqyz6Vit3rjep7c1SN8s7NhVi9cjkKmMDM7KYhXkWc10lKx2
 RTkFI30rkDm4U+JpdAd2+tP3tjGf9AyGGinpzE2XY1K5AQ0EVI67igEIAKiSyd0nECrgz+H5
 PcFDGYQpGDMTl8MOPCKw/F3diXPuj2eql4xSbAdbUCJzk2ETif5s3twT2ER8cUTEVOaCEUY3
 eOiaFgQ+nGLx4BXqqGewikPJCe+UBjFnH1m2/IFn4T9jPZkV8xlkKmDUqMK5EV9n3eQLkn5g
 lco+FepTtmbkSCCjd91EfThVbNYpVQ5ZjdBCXN66CKyJDMJ85HVr5rmXG/nqriTh6cv1l1Js
 T7AFvvPjUPknS6d+BETMhTkbGzoyS+sywEsQAgA+BMCxBH4LvUmHYhpS+W6CiZ3ZMxjO8Hgc
 ++w1mLeRUvda3i4/U8wDT3SWuHcB3DWlcppECLkAEQEAAYkBHwQYAQIACQUCVI67igIbDAAK
 CRBxXD01xc4QCZ4dB/0QrnEasxjM0PGeXK5hcZMT9Eo998alUfn5XU0RQDYdwp6/kMEXMdmT
 oH0F0xB3SQ8WVSXA9rrc4EBvZruWQ+5/zjVrhhfUAx12CzL4oQ9Ro2k45daYaonKTANYG22y
 //x8dLe2Fv1By4SKGhmzwH87uXxbTJAUxiWIi1np0z3/RDnoVyfmfbbL1DY7zf2hYXLLzsJR
 mSsED/1nlJ9Oq5fALdNEPgDyPUerqHxcmIub+pF0AzJoYHK5punqpqfGmqPbjxrJLPJfHVKy
 goMj5DlBMoYqEgpbwdUYkH6QdizJJCur4icy8GUNbisFYABeoJ91pnD4IGei3MTdvINSZI5e
Message-ID: <b0b44bd9-3047-b9e8-9635-ec5837844263@acm.org>
Date:   Mon, 27 Apr 2020 22:20:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200427113153.31246-5-johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020-04-27 04:31, Johannes Thumshirn wrote:
> +/*
> + * Check write append to a zoned block device.
> + */
> +static inline blk_status_t blk_check_zone_append(struct request_queue *q,
> +						 struct bio *bio)
> +{
> +	sector_t pos = bio->bi_iter.bi_sector;
> +	int nr_sectors = bio_sectors(bio);
> +
> +	/* Only applicable to zoned block devices */
> +	if (!blk_queue_is_zoned(q))
> +		return BLK_STS_NOTSUPP;
> +
> +	/* The bio sector must point to the start of a sequential zone */
> +	if (pos & (blk_queue_zone_sectors(q) - 1) ||
> +	    !blk_queue_zone_is_seq(q, pos))
> +		return BLK_STS_IOERR;
> +
> +	/*
> +	 * Not allowed to cross zone boundaries. Otherwise, the BIO will be
> +	 * split and could result in non-contiguous sectors being written in
> +	 * different zones.
> +	 */
> +	if (blk_queue_zone_no(q, pos) != blk_queue_zone_no(q, pos + nr_sectors))
> +		return BLK_STS_IOERR;
> +
> +	/* Make sure the BIO is small enough and will not get split */
> +	if (nr_sectors > q->limits.max_zone_append_sectors)
> +		return BLK_STS_IOERR;
> +
> +	bio->bi_opf |= REQ_NOMERGE;
> +
> +	return BLK_STS_OK;
> +}

Since the above function has not changed compared to v7, I will repeat
my question about this function. Since 'pos' refers to the start of a
zone, is the "blk_queue_zone_no(q, pos) != blk_queue_zone_no(q, pos +
nr_sectors)" check identical to nr_sectors < q->limits.chunk_sectors?
Since q->limits.max_zone_append_sectors is guaranteed to be less than or
equal to the size of a zone, does that mean that the check
"blk_queue_zone_no(q, pos) != blk_queue_zone_no(q, pos + nr_sectors)" is
superfluous?

Thanks,

Bart.
