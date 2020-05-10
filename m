Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E988F1CC5CC
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 May 2020 02:36:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728886AbgEJAgP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 9 May 2020 20:36:15 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46837 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726778AbgEJAgO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 9 May 2020 20:36:14 -0400
Received: by mail-pg1-f193.google.com with SMTP id q124so2700033pgq.13;
        Sat, 09 May 2020 17:36:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=SQF8VGNw/LWoe9FfZGxpzTCfdvJXZRTz9yGixScGhPs=;
        b=qfvcu0K3EvzWUREclK/jjWSv3eUWCHQjL7qjT3vjJqMi4635F4NwrG/3O51IAT1HMF
         JEKE91L3MA6mKHRHA6flh5vEcJUr8WQNiqJ6RRRgQyr8jespEGnQ23b/r6r/nNPN2Cpq
         Fp8gyWyF8CmclGQLzKZ0tQGc41wXaXPniBJFwMqRu0/HbtgF44wLbqJ4i6ClfiPas7Xm
         qO7etrJlOBRs5MTw2B9QOPi8EsDaTq4496iBKTjFE9POjD0U/R9udZ+a+PRig6l6rT1y
         Z3VhZmDTkX2IBqkOhisbClOemXZIzq/7OGVf+5Csrh/yPjASUF1Be3Lh2O/mjTgaZeDB
         Uo5w==
X-Gm-Message-State: AGi0PuYhtSvFybeX4JjaL6E6pzEfm2kow+2aOnK26M9tjO8FgKZ12EqD
        8zqvGOjJSSwflqB0pURA0V8=
X-Google-Smtp-Source: APiQypLzWG+D3I3lGRvqUjjthvsCMHM3xjJIhlNwyoTH7tORaG4skYeDsbtO5wgVmwoRSn49F59p9Q==
X-Received: by 2002:a63:7219:: with SMTP id n25mr8505744pgc.358.1589070972603;
        Sat, 09 May 2020 17:36:12 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:8ef:746a:4fe7:1df? ([2601:647:4000:d7:8ef:746a:4fe7:1df])
        by smtp.gmail.com with ESMTPSA id z6sm5386018pfb.87.2020.05.09.17.36.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 May 2020 17:36:11 -0700 (PDT)
Subject: Re: [PATCH v4 1/5] block: revert back to synchronous request_queue
 removal
To:     Luis Chamberlain <mcgrof@kernel.org>, axboe@kernel.dk,
        viro@zeniv.linux.org.uk, gregkh@linuxfoundation.org,
        rostedt@goodmis.org, mingo@redhat.com, jack@suse.cz,
        ming.lei@redhat.com, nstange@suse.de, akpm@linux-foundation.org
Cc:     mhocko@suse.com, yukuai3@huawei.com, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Omar Sandoval <osandov@fb.com>,
        Hannes Reinecke <hare@suse.com>,
        Michal Hocko <mhocko@kernel.org>,
        Christoph Hellwig <hch@lst.de>
References: <20200509031058.8239-1-mcgrof@kernel.org>
 <20200509031058.8239-2-mcgrof@kernel.org>
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
Message-ID: <3969cc50-eef7-0b39-58eb-a19535a61d15@acm.org>
Date:   Sat, 9 May 2020 17:36:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200509031058.8239-2-mcgrof@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020-05-08 20:10, Luis Chamberlain wrote:
> We revert back to synchronous request_queue removal because asynchronous
> removal creates a regression with expected userspace interaction with
> several drivers. An example is when removing the loopback driver, one
> uses ioctls from userspace to do so, but upon return and if successful,
> one expects the device to be removed. Likewise if one races to add another
> device the new one may not be added as it is still being removed. This was
> expected behavior before and it now fails as the device is still present
> and busy still. Moving to asynchronous request_queue removal could have
> broken many scripts which relied on the removal to have been completed if
> there was no error. Document this expectation as well so that this
> doesn't regress userspace again.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
