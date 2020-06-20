Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADED72025D0
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Jun 2020 20:07:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728373AbgFTSHs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 20 Jun 2020 14:07:48 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36862 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727808AbgFTSHr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 20 Jun 2020 14:07:47 -0400
Received: by mail-pg1-f193.google.com with SMTP id p3so3380764pgh.3;
        Sat, 20 Jun 2020 11:07:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=NzZdSjEt874a3GJH+7QELllYmmkWwmA69bmmuHgTAoc=;
        b=hh4UONth6FNSudKukThq0sNryxE+OUj4MaywiVMXVCZsG96E7L41YXaSjFo76fy2gJ
         sAzDdD1qNigqyzgnrGOi8/ODz3lC7+5zOnINlWwLw1LlpFzQWHFu3lndypKeI3xGL6lt
         epZbwtA/C4hV+V7xTEry1UcSO9yZCG6aTpoBWH7PTkymPc1Aq0lxL6UftUMsDXIPC7iI
         Z2OUhql+S5thxAlzM4cRKHcc5B/cbvuf79dUYnDXli2eOJUbT9fNfqFSdQN4MOTVEXWh
         bcSu1hphLjrhIesM3/rgjxHDPJaPSstNzoJD8smvOWJa/fS4kMPIZljWU5//+t7L7Qih
         Z/ag==
X-Gm-Message-State: AOAM532ZB4zclxuJkJRhRZhEGhyD98XIdg85GJpqkbd1HCRgFWF45xOC
        aABgAeQTHhW7gxIIRbo8NIrIqcQS5t0=
X-Google-Smtp-Source: ABdhPJyXZ5+MX59b6ULR5gqIuxp5l3tCoeY0xbteLpJXFGzXJOEKGFgYUdAnj2qpGVZHCWN7S8ZLZw==
X-Received: by 2002:a63:fa4d:: with SMTP id g13mr7185310pgk.26.1592676466144;
        Sat, 20 Jun 2020 11:07:46 -0700 (PDT)
Received: from [192.168.50.147] (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id s22sm2614781pgv.43.2020.06.20.11.07.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 20 Jun 2020 11:07:45 -0700 (PDT)
Subject: Re: [PATCH v7 8/8] block: create the request_queue debugfs_dir on
 registration
To:     Luis Chamberlain <mcgrof@kernel.org>, axboe@kernel.dk,
        viro@zeniv.linux.org.uk, gregkh@linuxfoundation.org,
        rostedt@goodmis.org, mingo@redhat.com, jack@suse.cz,
        ming.lei@redhat.com, nstange@suse.de, akpm@linux-foundation.org
Cc:     mhocko@suse.com, yukuai3@huawei.com, martin.petersen@oracle.com,
        jejb@linux.ibm.com, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20200619204730.26124-1-mcgrof@kernel.org>
 <20200619204730.26124-9-mcgrof@kernel.org>
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
Message-ID: <02112994-4cd7-c749-6bd7-66a772593c90@acm.org>
Date:   Sat, 20 Jun 2020 11:07:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200619204730.26124-9-mcgrof@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020-06-19 13:47, Luis Chamberlain wrote:
> We were only creating the request_queue debugfs_dir only
> for make_request block drivers (multiqueue), but never for
> request-based block drivers. We did this as we were only
> creating non-blktrace additional debugfs files on that directory
> for make_request drivers. However, since blktrace *always* creates
> that directory anyway, we special-case the use of that directory
> on blktrace. Other than this being an eye-sore, this exposes
> request-based block drivers to the same debugfs fragile
> race that used to exist with make_request block drivers
> where if we start adding files onto that directory we can later
> run a race with a double removal of dentries on the directory
> if we don't deal with this carefully on blktrace.
> 
> Instead, just simplify things by always creating the request_queue
> debugfs_dir on request_queue registration. Rename the mutex also to
> reflect the fact that this is used outside of the blktrace context.

There are two changes in this patch: a bug fix and a rename of a mutex.
I don't like it to see two changes in a single patch.

Additionally, is the new mutex name really better than the old name? The
proper way to use mutexes is to use mutexes to protect data instead of
code. Where is the documentation that mentions which member variable(s)
of which data structures are protected by the mutex formerly called
blk_trace_mutex? Since the new name makes it even less clear which data
is protected by this mutex, is the new name really better than the old name?

Thanks,

Bart.
