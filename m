Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 92F0A1A4750
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Apr 2020 16:22:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbgDJOWc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Apr 2020 10:22:32 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45047 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726145AbgDJOWc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Apr 2020 10:22:32 -0400
Received: by mail-pg1-f196.google.com with SMTP id n13so1029232pgp.11;
        Fri, 10 Apr 2020 07:22:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=xlgGbQXteZwjaq0FPW56XQgo4r5anuUOKJTrYIkhdRE=;
        b=oDHbJUraA1BTx45bC30boK/SHoNN4LZexj/35kAi0QhauRLOsDxjp5Pnx0pxm+hSXS
         hJYBPLIpiuHBh64aZxb4S+g+wqvoi/oGLK5/hAMcXWm0f44ruJ60QVQp0YUOIKEaoojI
         cRRY3VtsQwTzPElXrzQjdf7j5KDTH6b7PTORehDmzaAvvTJ2FoXxB8lAuHG3jdymV3nN
         pAUMDbEkJueICNHlQFMl6cHgiWKZfaCGbtNgpDGGDEXTyQgCJ1D+ofckmTC6xswNPSEt
         CbluZbOjo3uQUNqQoCdz8Qu3tbyx7m9dHRim4TmuYNZKADgM8+r+BMsE10IsQqnlU5/n
         azGw==
X-Gm-Message-State: AGi0PubN725z5wUFTpX7c/0SPe9xU8BTo5OVgXfdGxAM7mKBZVNHiE45
        r5oZ/Wz3/3xHr+k3LGSD78XbzgVn
X-Google-Smtp-Source: APiQypInzAbKW6EPxbsfNyjm2zdAsyobTg29jQQ1MpkwdVJ9GxtK43RPuySgXb5XA9bg7cPegMDy+Q==
X-Received: by 2002:a63:213:: with SMTP id 19mr4642616pgc.202.1586528550741;
        Fri, 10 Apr 2020 07:22:30 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:8c73:15e7:164:cf4f? ([2601:647:4000:d7:8c73:15e7:164:cf4f])
        by smtp.gmail.com with ESMTPSA id h11sm1868818pfn.125.2020.04.10.07.22.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Apr 2020 07:22:29 -0700 (PDT)
Subject: Re: [PATCH v5 06/10] scsi: export scsi_mq_free_sgtables
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-block <linux-block@vger.kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Keith Busch <kbusch@kernel.org>,
        "linux-scsi @ vger . kernel . org" <linux-scsi@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "linux-fsdevel @ vger . kernel . org" <linux-fsdevel@vger.kernel.org>
References: <20200409165352.2126-1-johannes.thumshirn@wdc.com>
 <20200409165352.2126-7-johannes.thumshirn@wdc.com>
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
Message-ID: <e3d40619-9f61-1eb0-865a-cec1d4793358@acm.org>
Date:   Fri, 10 Apr 2020 07:22:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200409165352.2126-7-johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020-04-09 09:53, Johannes Thumshirn wrote:
> scsi_mq_free_sgtables is used to free the sg_tables, uninitialize the
> command and delete it from the command list.
> 
> Export this function so it can be used from modular code to free the
> memory allocated by scsi_init_io() if the caller of scsi_init_io() needs
> to do error recovery.
> 
> While we're at it, rename scsi_mq_free_sgtables() to scsi_free_sgtables().

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
