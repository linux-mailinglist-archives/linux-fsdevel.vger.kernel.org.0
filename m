Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B90532025A2
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Jun 2020 19:33:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728315AbgFTRdd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 20 Jun 2020 13:33:33 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:35586 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727808AbgFTRdc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 20 Jun 2020 13:33:32 -0400
Received: by mail-pj1-f66.google.com with SMTP id i4so6085706pjd.0;
        Sat, 20 Jun 2020 10:33:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=2P3Vzv5xtm8mkodco3WgSqBsNpt49S7EUwCeOg0xzd0=;
        b=UsiqiPGQw/nRujRF8EsnHU6+gBVzQ6Bd2xfpo9Pzbc6GywP96mJDcsHF+Kg8ifSOVX
         MoSizDL5Aw095ae3OeETxTCv0x3phTql7eRF8G9nVf8mUxl71W3Hrmun3wh+og5s7ZXe
         s4bpj8iTSruYxDrWf9+7Wi4lOjmseAYOVVBf2YTqc/hcrT8+AZIIDCMgKE42SxS34wo2
         EYJb7RAr97VKgw18JM7vx0VmxvCsvBppmfeMxmjlSkhwHx1LbRhItB5V8pZV+5P9Is6z
         xLtdhlaC6Heo4c7szKToNJZT6ZPI4kOwB3R11Kt6JepweiqWrTZbdDtOxo3uQQN7hCD2
         faRQ==
X-Gm-Message-State: AOAM532OTLztNLuzQ72kr9znD3hv2hjMyHZSMLaMCzUzclC/8rMVlVw+
        9rjePc5Upr1Gq6KC6Ab3lQej9WM4kV4=
X-Google-Smtp-Source: ABdhPJytRswymFRQkcGFImTFiKQxq06LmY1uLhViW9168gtYVm2YXL6mzI9sfOCC4T0c2fQinH1mfg==
X-Received: by 2002:a17:902:8a98:: with SMTP id p24mr12734212plo.90.1592674411462;
        Sat, 20 Jun 2020 10:33:31 -0700 (PDT)
Received: from [192.168.50.147] (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id u19sm9947631pfk.98.2020.06.20.10.33.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 20 Jun 2020 10:33:30 -0700 (PDT)
Subject: Re: [PATCH v7 7/8] blktrace: ensure our debugfs dir exists
To:     Luis Chamberlain <mcgrof@kernel.org>, axboe@kernel.dk,
        viro@zeniv.linux.org.uk, gregkh@linuxfoundation.org,
        rostedt@goodmis.org, mingo@redhat.com, jack@suse.cz,
        ming.lei@redhat.com, nstange@suse.de, akpm@linux-foundation.org
Cc:     mhocko@suse.com, yukuai3@huawei.com, martin.petersen@oracle.com,
        jejb@linux.ibm.com, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20200619204730.26124-1-mcgrof@kernel.org>
 <20200619204730.26124-8-mcgrof@kernel.org>
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
Message-ID: <379e1fc9-a070-7730-71cd-aee7f582d403@acm.org>
Date:   Sat, 20 Jun 2020 10:33:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200619204730.26124-8-mcgrof@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020-06-19 13:47, Luis Chamberlain wrote:
> diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
> index e6e2d25fdbd6..098780ec018f 100644
> --- a/kernel/trace/blktrace.c
> +++ b/kernel/trace/blktrace.c
> @@ -538,6 +538,18 @@ static int do_blk_trace_setup(struct request_queue *q, char *name, dev_t dev,
>  #endif
>  		bt->dir = dir = debugfs_create_dir(buts->name, blk_debugfs_root);
>  
> +	/*
> +	 * As blktrace relies on debugfs for its interface the debugfs directory
> +	 * is required, contrary to the usual mantra of not checking for debugfs
> +	 * files or directories.
> +	 */
> +	if (IS_ERR_OR_NULL(dir)) {
> +		pr_warn("debugfs_dir not present for %s so skipping\n",
> +			buts->name);

Maybe mention in the message what is being skipped (block tracing)?

> +		ret = -ENOENT;
> +		goto err;
> +	}
> +
>  	bt->dev = dev;
>  	atomic_set(&bt->dropped, 0);
>  	INIT_LIST_HEAD(&bt->running_list);

Anyway:

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
