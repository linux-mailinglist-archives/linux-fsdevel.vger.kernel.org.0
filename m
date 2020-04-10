Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F7811A3E9E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Apr 2020 05:12:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbgDJDM1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Apr 2020 23:12:27 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:33436 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726594AbgDJDM0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Apr 2020 23:12:26 -0400
Received: by mail-pg1-f195.google.com with SMTP id d17so456751pgo.0;
        Thu, 09 Apr 2020 20:12:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=riLsCQbI8rWtquYxJsTgKqCXsr91BsaOod5Gd8OL/tY=;
        b=AcVxCVhitGWT7cX7BC3gMTShdwHIFV5P+Jx8Q5h0Qp1kliooiSyQCNr7uE1nIizppC
         Ygj1Z9CPNTWP6FI8YeNQuRpDxHP/njrgWzKvlbCMHc57JRKWkxXkzC2fCU5HB4cMOHE6
         xGN7Vh0vo/wqar3SN9oZWL/4/do0C5gaDGNoC2v1LYcw4UpMGCh3LIGmJ6x2csMBGNaW
         S4ZJ6/pXzdtXtHzMMe53u3r7zNqzEY5KZCl9H8bF7eDLVpMksP78VAvMt9AcFnjbGGSm
         DK9S0SXDZ3pVSKop/meYukydamHAk85gb7sUu3rxj9wJt6Ce6dJboGs87OKLwtz7cVzc
         GmSA==
X-Gm-Message-State: AGi0PuZ04j8Zq0FJwDUzdvmoav665rDlAIxlQBerp0iCZVMRnPLl9r/m
        /N7W7InMeWO1x7sL4i+9lrg=
X-Google-Smtp-Source: APiQypJB9TbTwNuE4JRdnVGrOnnBOWWgxmCc4vJV5SidGuVHW3ci9n/1oxuQj7yHNMWcyR+ZersXAg==
X-Received: by 2002:a65:5a4f:: with SMTP id z15mr2583848pgs.103.1586488344310;
        Thu, 09 Apr 2020 20:12:24 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:ed4e:1b14:7fc4:cd73? ([2601:647:4000:d7:ed4e:1b14:7fc4:cd73])
        by smtp.gmail.com with ESMTPSA id q6sm461549pja.34.2020.04.09.20.12.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Apr 2020 20:12:23 -0700 (PDT)
Subject: Re: [RFC v2 5/5] block: revert back to synchronous request_queue
 removal
To:     Luis Chamberlain <mcgrof@kernel.org>, axboe@kernel.dk,
        viro@zeniv.linux.org.uk, gregkh@linuxfoundation.org,
        rostedt@goodmis.org, mingo@redhat.com, jack@suse.cz,
        ming.lei@redhat.com, nstange@suse.de, akpm@linux-foundation.org
Cc:     mhocko@suse.com, yukuai3@huawei.com, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Omar Sandoval <osandov@fb.com>,
        Hannes Reinecke <hare@suse.com>,
        Michal Hocko <mhocko@kernel.org>
References: <20200409214530.2413-1-mcgrof@kernel.org>
 <20200409214530.2413-6-mcgrof@kernel.org>
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
Message-ID: <161e938d-929b-1fdb-ba77-56b839c14b5b@acm.org>
Date:   Thu, 9 Apr 2020 20:12:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200409214530.2413-6-mcgrof@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020-04-09 14:45, Luis Chamberlain wrote:
> blk_put_queue() puts decrements the refcount for the request_queue
                  ^^^^
        can this word be left out?

> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index 8b1cab52cef9..46fee1ef92e3 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -614,6 +614,7 @@ struct request_queue {
>  #define QUEUE_FLAG_PCI_P2PDMA	25	/* device supports PCI p2p requests */
>  #define QUEUE_FLAG_ZONE_RESETALL 26	/* supports Zone Reset All */
>  #define QUEUE_FLAG_RQ_ALLOC_TIME 27	/* record rq->alloc_time_ns */
> +#define QUEUE_FLAG_DEFER_REMOVAL 28	/* defer queue removal */
>  
>  #define QUEUE_FLAG_MQ_DEFAULT	((1 << QUEUE_FLAG_IO_STAT) |		\
>  				 (1 << QUEUE_FLAG_SAME_COMP))
> @@ -648,6 +649,8 @@ bool blk_queue_flag_test_and_set(unsigned int flag, struct request_queue *q);
>  #else
>  #define blk_queue_rq_alloc_time(q)	false
>  #endif
> +#define blk_queue_defer_removal(q) \
> +	test_bit(QUEUE_FLAG_DEFER_REMOVAL, &(q)->queue_flags)

Since blk_queue_defer_removal() has no callers the code that depends on
QUEUE_FLAG_DEFER_REMOVAL to be set will be subject to bitrot. It would
make me happy if the QUEUE_FLAG_DEFER_REMOVAL flag and the code that
depends on that flag would be removed.

Please add a might_sleep() call in blk_put_queue() since with this patch
applied it is no longer allowed to call blk_put_queue() from atomic context.

Thanks,

Bart.
