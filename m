Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA1831AF1D7
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Apr 2020 17:57:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbgDRP4x (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 18 Apr 2020 11:56:53 -0400
Received: from mail-pj1-f65.google.com ([209.85.216.65]:56012 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725879AbgDRP4w (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 18 Apr 2020 11:56:52 -0400
Received: by mail-pj1-f65.google.com with SMTP id a32so2519421pje.5;
        Sat, 18 Apr 2020 08:56:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=HnN+4R9VnGvVtFRaSn9immSfu526GuFnV34NPuc3GJ4=;
        b=FgYy+wT1Ser6GDI8gBVjfFmegC/sMorPV9TSU0pIowGot5Ct+OjQ6LbWxK8K0EMjwY
         Vvy7yqyqh8CrPruPezePLxC64VJGwDm9JPJp2aWVorcfKENUM32p0+Q219BnwG7nxDSD
         YfnkQySlxHdcvrC3IYvolq2SxhfN5RQnara3I10/FUIDvubBqviEDe9s0CszcsnhvZ0K
         FA5yO/b4AM6WqDCurCRON8crDbaQgJ1Sebv3ow/2FRoHvGksoOmIW4GjuSnmgkEOMgB2
         jOaCLnilHAzF/v1ZVyn9hjYEohKg4k+vV6Q8OU9pV2SGwZi8peVT1OqLHXFi8W0GdsOf
         rl9A==
X-Gm-Message-State: AGi0PuYSSJn99JxwcE5P8VU0msbnveSn6+Z0BpxkX/x/zWAqTqSuj2rV
        9+OnygSVTGTQ/x6zgfishqw=
X-Google-Smtp-Source: APiQypJQm7KDxqeoXzsUCOSRwsfZZCKF62wDEpEX9w3v38O0ZeIERlSVUTpFH4OkBtpVHSsww5t6fg==
X-Received: by 2002:a17:902:b418:: with SMTP id x24mr585768plr.260.1587225411195;
        Sat, 18 Apr 2020 08:56:51 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:551:c132:d476:f445? ([2601:647:4000:d7:551:c132:d476:f445])
        by smtp.gmail.com with ESMTPSA id 23sm7632557pjb.11.2020.04.18.08.56.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Apr 2020 08:56:50 -0700 (PDT)
Subject: Re: [PATCH v7 00/11] Introduce Zone Append for writing to zoned block
 devices
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-block <linux-block@vger.kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Keith Busch <kbusch@kernel.org>,
        "linux-scsi @ vger . kernel . org" <linux-scsi@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "linux-fsdevel @ vger . kernel . org" <linux-fsdevel@vger.kernel.org>,
        Daniel Wagner <dwagner@suse.de>
References: <20200417121536.5393-1-johannes.thumshirn@wdc.com>
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
Message-ID: <afefece2-3016-8b58-fda4-1fbd7fcac75c@acm.org>
Date:   Sat, 18 Apr 2020 08:56:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200417121536.5393-1-johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020-04-17 05:15, Johannes Thumshirn wrote:
> In order to reduce memory consumption, the only cached item is the offset
> of the write pointer from the start of the zone, everything else can be
> calculated. On an example drive with 52156 zones, the additional memory
> consumption of the cache is thus 52156 * 4 = 208624 Bytes or 51 4k Byte
> pages. The performance impact is neglectable for a spinning drive.

What will happen if e.g. syzkaller mixes write() system calls with SG_IO
writes? Can that cause a mismatch between the cached write pointer and
the write pointer maintained by the drive? If so, should SG_IO perhaps
be disallowed if the write pointer is cached?

Thanks,

Bart.
