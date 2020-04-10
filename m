Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 259761A3E89
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Apr 2020 04:58:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726583AbgDJC6S (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Apr 2020 22:58:18 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:52532 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbgDJC6S (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Apr 2020 22:58:18 -0400
Received: by mail-pj1-f66.google.com with SMTP id ng8so298001pjb.2;
        Thu, 09 Apr 2020 19:58:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=3/zr6sp9cnHWIbeu5mJQjJua9Pc19Fnu4r/08td9UIE=;
        b=WQnZx4gkH1BgWzx2MiLB4gT/nuH3SkrlQMbuqEiYVT6KW0tR1JLlE8FbWHTD3rbqev
         QB2+oiiY01HWm0vv7dMwrHhjY4Nr4nDjwx1UTSY7PkQ2KN/YYAJsdkE6/Gg9kwy6Ee1+
         Jn0WKIXqmTsWs/UtZtPZ1hAmw8lu4gAciVUlzHvnYA323GAni5dzNDXoIDvdzikt2FS2
         dcJIQXrmkIKzHyyrS2HKrXsK2MsB6dfCb0CBhVHrMSMcPgmZtytLT4yWfRlyv0iH8vc5
         m7rIojNtVY9MatuQZ3zJpA0M/p3wKIxaXisqPHIbTY8kLzXWpYnledpqBPWzFrF69EH9
         ocDw==
X-Gm-Message-State: AGi0Puabg+wGvhYVI+JXjqGPDh7zSVoS+lHn2+6bU9cdeRZ9lmfXXm2Q
        yqYpvtVDeBz2+/xsZKpkNnQ=
X-Google-Smtp-Source: APiQypITMgw/AlMFWADX+9U8ko5YTL0iHM+x6VLTaZdr633nQqFlHiG0A1Q83kztjT0dA4M+pSaGPg==
X-Received: by 2002:a17:902:bf46:: with SMTP id u6mr2700916pls.33.1586487496100;
        Thu, 09 Apr 2020 19:58:16 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:ed4e:1b14:7fc4:cd73? ([2601:647:4000:d7:ed4e:1b14:7fc4:cd73])
        by smtp.gmail.com with ESMTPSA id ne16sm470242pjb.11.2020.04.09.19.58.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Apr 2020 19:58:15 -0700 (PDT)
Subject: Re: [RFC v2 3/5] blktrace: ref count the request_queue during ioctl
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
 <20200409214530.2413-4-mcgrof@kernel.org>
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
Message-ID: <e2928c9a-ffd5-c0b6-2107-a820da0c5b7f@acm.org>
Date:   Thu, 9 Apr 2020 19:58:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200409214530.2413-4-mcgrof@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020-04-09 14:45, Luis Chamberlain wrote:
> Ensure that the reqest_queue ref counts the request_queue
                  ^^^^^^^^^^^^ ^^^^^^^^^^
                request_queue? refcounts?
> during its full ioctl cycle. This avoids possible races against
> removal, given blk_get_queue() also checks to ensure the queue
> is not dying.
> 
> This small race is possible if you defer removal of the reqest_queue
                                                          ^^^^^^^^^^^^
                                                          request_queue?
> and userspace fires off an ioctl for the device in the meantime.

Anyway:

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
