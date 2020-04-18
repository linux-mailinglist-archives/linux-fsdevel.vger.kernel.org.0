Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 742791AF271
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Apr 2020 18:52:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726563AbgDRQwa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 18 Apr 2020 12:52:30 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38695 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbgDRQwa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 18 Apr 2020 12:52:30 -0400
Received: by mail-pg1-f193.google.com with SMTP id p8so2791732pgi.5;
        Sat, 18 Apr 2020 09:52:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=0PdHh12p/eUjnkElIW6AN7rO6qysrDgEcQlUXmzSyXY=;
        b=FW4V7rngTGHRmQrxqMk40njvSGnJy1+ZE5AEaGRz0ks2C6BCJiOyB0svMiqNfaAFg5
         kHuDzoFF2pe8fix14/Qc1uHsE/Y2x9QCFiJ00En5MjSOiSH/+svHb9xafLIxeaHAZezw
         YSebifwGFktL9iZYGXJiHKGP6LGe3U6ZhcCtI4cUH8J3oMgZZW3eCul8MmXTM+vaMmr1
         egOH3XSXBBQypOLFUsWaFFF5PPmqyDcc0FHuUwKl86ii90juylciBdht1spSEAqIDDZM
         Gg/u6YNPGNHZLlygDs4k0JUwLoMOBnDhb2giVxvxZgEnkRFnxpZ0haCBvFYWfxgqy6L6
         VLbQ==
X-Gm-Message-State: AGi0PuYeNbHx0l29n4UmDAUAwyOzgw/S6FNwJB1HMhl/Q/lVWYdzhKZT
        2AfS2nVkaFiupi/aBbuwoTQ=
X-Google-Smtp-Source: APiQypK8NQL8SLJVdjg7gGhIYWOQIOAX0MxRVPaDSi2V+SK098xDvxqPaLwBKpO5AMdF8hwruzecrg==
X-Received: by 2002:a63:c007:: with SMTP id h7mr8457441pgg.428.1587228749073;
        Sat, 18 Apr 2020 09:52:29 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:551:c132:d476:f445? ([2601:647:4000:d7:551:c132:d476:f445])
        by smtp.gmail.com with ESMTPSA id g11sm8687955pjs.17.2020.04.18.09.52.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Apr 2020 09:52:28 -0700 (PDT)
Subject: Re: [PATCH v7 05/11] block: introduce blk_req_zone_write_trylock
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-block <linux-block@vger.kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Keith Busch <kbusch@kernel.org>,
        "linux-scsi @ vger . kernel . org" <linux-scsi@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "linux-fsdevel @ vger . kernel . org" <linux-fsdevel@vger.kernel.org>,
        Daniel Wagner <dwagner@suse.de>, Christoph Hellwig <hch@lst.de>
References: <20200417121536.5393-1-johannes.thumshirn@wdc.com>
 <20200417121536.5393-6-johannes.thumshirn@wdc.com>
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
Message-ID: <9073431b-7411-e964-4a74-7ac972a8033a@acm.org>
Date:   Sat, 18 Apr 2020 09:52:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200417121536.5393-6-johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020-04-17 05:15, Johannes Thumshirn wrote:
> +bool blk_req_zone_write_trylock(struct request *rq)
> +{
> +	unsigned int zno = blk_rq_zone_no(rq);
> +
> +	if (test_and_set_bit(zno, rq->q->seq_zones_wlock))
> +		return false;
> +
> +	WARN_ON_ONCE(rq->rq_flags & RQF_ZONE_WRITE_LOCKED);
> +	rq->rq_flags |= RQF_ZONE_WRITE_LOCKED;
> +
> +	return true;
> +}
> +EXPORT_SYMBOL_GPL(blk_req_zone_write_trylock);

Although different requests can be processed concurrently by the block
layer, all processing steps for an individual request happen
sequentially. So I think it is safe to move the
WARN_ON_ONCE(rq->rq_flags & RQF_ZONE_WRITE_LOCKED) above the
test_and_set_bit() call.

Thanks,

Bart.
