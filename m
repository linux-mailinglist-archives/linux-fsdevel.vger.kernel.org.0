Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70D731C21DC
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 May 2020 02:22:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727088AbgEBAWR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 May 2020 20:22:17 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:32969 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726352AbgEBAWR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 May 2020 20:22:17 -0400
Received: by mail-pl1-f193.google.com with SMTP id t7so4217747plr.0;
        Fri, 01 May 2020 17:22:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=xqP1ypKDzEDw8qavmEZaNBpUnC4fGF3wqn5BkO6DJEw=;
        b=JWEIY2csSErLBWeVaLNOjxdIDxxoYounSqOlxjjHKCnRGaifTn5BHXoPRjkYBMstB2
         L2vgoK/PbXJSItFg8CqBG6zAizKh3rD2n9q737HfEZ0K5F6mNeLjc6GKs2yqI27H44DM
         fLH2SDWLbXGDXNn6tdN3WQKEs+E0ag6C4DG6F1gwL2R5LMGpQPELzxfvxfcCCMZX+6XM
         vRdA+CwJSyWMloKfwZvQ+3pmywiXQMOxY0rL+ypI+Scy50VO6s4jRjzKhD9G9KOcsbdb
         6OG6BxQK/SEEfIksYcZQrvR7HmsvxFSVvMre4fIAHwYjkABuF/OrOK9UxPEpkA0Zmzrr
         575w==
X-Gm-Message-State: AGi0PuZTYaqYPbGrvV5rUO/FuSbzoBP91CW2lhi6ewFEfA/hmyMLQy7s
        2VH4Y5foUdeAFfp15c21g4g=
X-Google-Smtp-Source: APiQypKGMZAno3U6uaIKiwykYHUO3c1ZI12E5QCOg2T09raiI4CXPQD/nVyzblnBvoqcpJ970KJBpg==
X-Received: by 2002:a17:902:6b05:: with SMTP id o5mr6451646plk.274.1588378936357;
        Fri, 01 May 2020 17:22:16 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:3401:2e72:5c00:8ec0? ([2601:647:4000:d7:3401:2e72:5c00:8ec0])
        by smtp.gmail.com with ESMTPSA id o11sm2863889pgp.62.2020.05.01.17.22.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 May 2020 17:22:15 -0700 (PDT)
Subject: Re: [PATCH v3 1/6] block: revert back to synchronous request_queue
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
References: <20200429074627.5955-1-mcgrof@kernel.org>
 <20200429074627.5955-2-mcgrof@kernel.org>
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
Message-ID: <a2c64413-d0a4-e5c8-e0fa-904285a1189e@acm.org>
Date:   Fri, 1 May 2020 17:22:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200429074627.5955-2-mcgrof@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020-04-29 00:46, Luis Chamberlain wrote:
> The last reference for the request_queue must not be called from atomic
> conext. *When* the last reference to the request_queue reaches 0 varies,
  ^^^^^^
  context?
> and so let's take the opportunity to document when that is expected to
> happen and also document the context of the related calls as best as possible
> so we can avoid future issues, and with the hopes that the synchronous
> request_queue removal sticks.
> 
> We revert back to synchronous request_queue removal because asynchronous
> removal creates a regression with expected userspace interaction with
> several drivers. An example is when removing the loopback driver, one
> uses ioctls from userspace to do so, but upon return and if successful,
> one expects the device to be removed. Likewise if one races to add another
> device the new one may not be added as it is still being removed. This was
> expected behaviour before and it now fails as the device is still present
           ^^^^^^^^^
           behavior?

> +/**
> + * blk_put_queue - decrement the request_queue refcount
> + * @q: the request_queue structure to decrement the refcount for
> + *
> + * Decrements the refcount to the request_queue kobject. When this reaches 0
                              ^^
                              of?

> +/**
> + * blk_get_queue - increment the request_queue refcount
> + * @q: the request_queue structure to incremenet the refcount for
                                         ^^^^^^^^^^
                                         increment?
> + *
> + * Increment the refcount to the request_queue kobject.
                             ^^
                             of?

>  /**
> - * __blk_release_queue - release a request queue
> - * @work: pointer to the release_work member of the request queue to be released
> + * blk_release_queue - releases all allocated resources of the request_queue
> + * @kobj: pointer to a kobject, who's container is a request_queue
                                   ^^^^^
                                   whose?

> +/**
> + * disk_release - releases all allocated resources of the gendisk
> + * @dev: the device representing this disk
> + *
> + * This function releases all allocated resources of the gendisk.
> + *
> + * The struct gendisk refcounted is incremeneted with get_gendisk() or
                         ^^^^^^^^^^    ^^^^^^^^^^^^
                         refcount?     incremented?

Please fix the spelling errors. Otherwise this patch looks good to me.

Thanks,

Bart.
