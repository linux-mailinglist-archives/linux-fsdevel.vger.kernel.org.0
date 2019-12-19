Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3DB0D125A63
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2019 06:00:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726155AbfLSFAY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Dec 2019 00:00:24 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45142 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbfLSFAY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Dec 2019 00:00:24 -0500
Received: by mail-pg1-f194.google.com with SMTP id b9so2440654pgk.12;
        Wed, 18 Dec 2019 21:00:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=g7u7M8qJMOVgBJaM2MBNP0fTnIjXWTjo4K/cUGZgSpY=;
        b=NqYENaakp/NKOOIYSemTf45CUqxRvV3wMQKIvqvAETLEG2u/R5QZ8N29E/JpraFV6q
         nWZLVatHEJPfcayh37qfmSxiu/Fq765hfHx0p/hG6tbTX+Ij//0pvf7qlqZZk3HTPSuz
         eyge4Z1DnlI227pG0D1AFQ2RK3gnMKQDPX3lWvsSgzDD+gJyagRTALIqq3Cp8nCIStEo
         CZpCJ+rgX66C4GxnnG/uhdd5thf1VOCVChMK1MbAcbdnnJ3pf0RgGN+0OIZzFU6wAI+r
         LKF9nQW8U/EYAXHuv9vf44MOBKLv5R3LUIpD6WgUMsrHg1L2X6F+co9/sEu6tvJ0oabd
         7j2Q==
X-Gm-Message-State: APjAAAXF/OnZc3hY2ZlVLfDsou5y3Lo6sTio82oE9Xmop1K+qDwIq8NA
        svPJ8JUJshbgCLZd33xzzkQ=
X-Google-Smtp-Source: APXvYqzrchZp4IVjqJtkB+T3s1vmskPzQuKNoxzKqezHXHEJ0b+KslSmNNEJF62Swk4LR1ZMRP7c9w==
X-Received: by 2002:a63:1a1c:: with SMTP id a28mr7364030pga.374.1576731623735;
        Wed, 18 Dec 2019 21:00:23 -0800 (PST)
Received: from ?IPv6:2601:647:4000:1108:5490:c75a:2158:20b3? ([2601:647:4000:1108:5490:c75a:2158:20b3])
        by smtp.gmail.com with ESMTPSA id u20sm5030655pgf.29.2019.12.18.21.00.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Dec 2019 21:00:22 -0800 (PST)
Subject: Re: kernel BUG at fs/buffer.c:LINE!
To:     jaegeuk@kernel.org
References: <0000000000009716290599fcd496@google.com>
Cc:     axboe@kernel.dk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
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
Message-ID: <31033055-c245-4eda-2814-3fd8b0d59cb9@acm.org>
Date:   Wed, 18 Dec 2019 21:00:21 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <0000000000009716290599fcd496@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2019-12-18 08:21, syzbot wrote:
> syzbot has bisected this bug to:
> 
> commit 5db470e229e22b7eda6e23b5566e532c96fb5bc3
> Author: Jaegeuk Kim <jaegeuk@kernel.org>
> Date:   Thu Jan 10 03:17:14 2019 +0000
> 
>     loop: drop caches if offset or block_size are changed
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13f3ca8ee00000
> start commit:   2187f215 Merge tag 'for-5.5-rc2-tag' of
> git://git.kernel.o..
> git tree:       upstream
> final crash:    https://syzkaller.appspot.com/x/report.txt?x=100bca8ee00000
> console output: https://syzkaller.appspot.com/x/log.txt?x=17f3ca8ee00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=dcf10bf83926432a
> dashboard link:
> https://syzkaller.appspot.com/bug?extid=cfed5b56649bddf80d6e
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1171ba8ee00000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=107440aee00000

Hi Jaegeuk,

Since syzbot has identified a reproducer I think that it's easy to test
whether your new patch fixes what syzbot discovered. Have you already
had the chance to test this?

Thanks,

Bart.
