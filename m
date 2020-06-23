Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 962A02047DF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jun 2020 05:18:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730616AbgFWDSc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Jun 2020 23:18:32 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41857 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728612AbgFWDSb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Jun 2020 23:18:31 -0400
Received: by mail-pg1-f193.google.com with SMTP id b5so9208330pgm.8;
        Mon, 22 Jun 2020 20:18:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=mpFj7/RrGtSNh2oxeWkaM9uJQKNxbdQmz4wPUcNhQuU=;
        b=sjtOC+7gsYm2/2Q0rYSPg15/MsWG9tl5HvIm7SKbYMi8oosEqyirnuaQxD5nqhuCwQ
         NPB6BHkSTXqiRSom6IwgDrFxihrt9sUGXPtH8PeqR0PgsIKHNZ3DCsBLRDI2UHpOkQnF
         WqzGAAioaOioVFn2P5t+vvlTbY6GIZHqnH2zfj5bivYDfCKcTsth2EVz+tuna+sR9G0w
         CAODGkLdjFp1v41U94hyE8GCU+FkDeKzSSnmZ8vmVNFO4i+9qHPsJg63a10MRvt+Y3bm
         zR/Z1WnRP+K/sJGtz8G5wtjsBpqxVC8WGVt0i3U7ydnnMiCnVQsvusc/0tI+3tFya8ef
         4Tkw==
X-Gm-Message-State: AOAM5306kgQ1KA+u5YwzJU82DHxyTD5daOPlkzKS1lIuMolqt/S75g10
        UFSdwznUlP2UhZu27jxmXpTkmTL17OM=
X-Google-Smtp-Source: ABdhPJzdc2VdT5EAFZIAAEZc3fGS4qcNI/gX/vWuYt7EogWDJNOGCKd180YoLKtAWecVyPItYkRK0Q==
X-Received: by 2002:a63:6643:: with SMTP id a64mr12702889pgc.246.1592882309689;
        Mon, 22 Jun 2020 20:18:29 -0700 (PDT)
Received: from [192.168.50.147] (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id q22sm11398036pgn.91.2020.06.22.20.18.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jun 2020 20:18:28 -0700 (PDT)
Subject: Re: [PATCH v7 8/8] block: create the request_queue debugfs_dir on
 registration
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     axboe@kernel.dk, viro@zeniv.linux.org.uk,
        gregkh@linuxfoundation.org, rostedt@goodmis.org, mingo@redhat.com,
        jack@suse.cz, ming.lei@redhat.com, nstange@suse.de,
        akpm@linux-foundation.org, mhocko@suse.com, yukuai3@huawei.com,
        martin.petersen@oracle.com, jejb@linux.ibm.com,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20200619204730.26124-1-mcgrof@kernel.org>
 <20200619204730.26124-9-mcgrof@kernel.org>
 <02112994-4cd7-c749-6bd7-66a772593c90@acm.org>
 <20200622124208.GW11244@42.do-not-panic.com>
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
Message-ID: <4d25dbd1-a001-9869-58d5-630696440abc@acm.org>
Date:   Mon, 22 Jun 2020 20:18:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200622124208.GW11244@42.do-not-panic.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020-06-22 05:42, Luis Chamberlain wrote:
> On Sat, Jun 20, 2020 at 11:07:43AM -0700, Bart Van Assche wrote:
>> On 2020-06-19 13:47, Luis Chamberlain wrote:
>>> We were only creating the request_queue debugfs_dir only
>>> for make_request block drivers (multiqueue), but never for
>>> request-based block drivers. We did this as we were only
>>> creating non-blktrace additional debugfs files on that directory
>>> for make_request drivers. However, since blktrace *always* creates
>>> that directory anyway, we special-case the use of that directory
>>> on blktrace. Other than this being an eye-sore, this exposes
>>> request-based block drivers to the same debugfs fragile
>>> race that used to exist with make_request block drivers
>>> where if we start adding files onto that directory we can later
>>> run a race with a double removal of dentries on the directory
>>> if we don't deal with this carefully on blktrace.
>>>
>>> Instead, just simplify things by always creating the request_queue
>>> debugfs_dir on request_queue registration. Rename the mutex also to
>>> reflect the fact that this is used outside of the blktrace context.
>>
>> There are two changes in this patch: a bug fix and a rename of a mutex.
>> I don't like it to see two changes in a single patch.
> 
> I thought about doing the split first, and I did it at first, but
> then I could hear Christoph yelling at me for it. So I merged the
> two together. Although it makes it more difficult for review,
> the changes do go together.

During the past weeks I have been more busy than usual. I will try to
make sure that in the future I have the time to read all comments on the
previous versions of a patch series before replying to the latest
version of a patch series.

>> Additionally, is the new mutex name really better than the old name? The
>> proper way to use mutexes is to use mutexes to protect data instead of
>> code. Where is the documentation that mentions which member variable(s)
>> of which data structures are protected by the mutex formerly called
>> blk_trace_mutex?
> 
> It does not exist, and that is the point. The debugfs_dir use after
> free showed us *when* that UAF can happen, and so care must be taken
> if we are to use the mutex to protect the debugfs_dir but also re-use
> the same directory for other block core shenanigans.
> 
>> Since the new name makes it even less clear which data
>> is protected by this mutex, is the new name really better than the old name?
> 
> I thought the new name makes it crystal clear what is being protected. I
> can however add a comment to explain that the q->debugfs_mutex protects
> the q->debugfs_dir if it is created, otherwise it protects the ephemeral
> debugfs_dir directory which would otherwise be created in lieue of
> q->debugfs_dir, however the patch still lies under <debugfs_root>/block/.
> 
> Let me know if you think that will help.

My concern is that q->debugfs_mutex would evolve the same way as
q->sysfs_lock: at the time of introduction the role of a mutex is very
clear but over time the number of use cases grows to a point where it is
no longer possible to recognize the original purpose. I think there are
two possible approaches: either a comment is added now that explains the
role of q->debugfs_mutex or someone who has followed this conversation
yells when someone tries to use q->debugfs_mutex for another purpose
than what it was intended for.

Thanks,

Bart.

