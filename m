Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 129EC202817
	for <lists+linux-fsdevel@lfdr.de>; Sun, 21 Jun 2020 05:04:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729154AbgFUDDw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 20 Jun 2020 23:03:52 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:40399 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728992AbgFUDDv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 20 Jun 2020 23:03:51 -0400
Received: by mail-pl1-f196.google.com with SMTP id x11so5944788plo.7;
        Sat, 20 Jun 2020 20:03:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=fbfx4fDhe2FB+C7RRQGxAyeicIq0vAnX+Jv4uU7Y0u0=;
        b=tQ3rPeZLQlny6C3K+J5chh7OT8dlcqvxV0x1THNFTmgfcK625zMmoddrUcoJ5k+SOF
         HqkRcv2PwZHfw+fk/Z8Zx4tr7zmSdPeEc5YC6SqosgiDaqom+yfs8+eyqEdqJSEVfBVp
         u6Jal+tfzD/pwc2j5at1LEX3HME/Pgkk9v2h8IspnEEtZK2LWZulA7KN9vcYiGgj8/vz
         x1mlPIDptHvLzrnzym4uvl5uu2rFhHeyznMyENBx/ZCuDOvzA44QsaGQQkCIB9q+K4bV
         d0Ci7Po1zpqQGQo8/xYASBCaris7e4Tl8RlyZamNs68s5ZYNuE0MVENGsj2zyqMc4NG+
         MkVQ==
X-Gm-Message-State: AOAM532uWSSWnft/78+9xCmTqa51PstFsdw/w07mSmJIUfRe5bw8ugOV
        Rd9i46UydvTB8BVWFwAdqfjeRz4H
X-Google-Smtp-Source: ABdhPJzo9RB4ccik4ptkPYUBGdPxCKzBLNuGMQf6ezuNTisqAipFNox3fotu4zRwcOxg6f4w4nrIrw==
X-Received: by 2002:a17:902:3:: with SMTP id 3mr13126779pla.120.1592708630395;
        Sat, 20 Jun 2020 20:03:50 -0700 (PDT)
Received: from [192.168.50.147] (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id t7sm9074784pju.42.2020.06.20.20.03.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 20 Jun 2020 20:03:49 -0700 (PDT)
Subject: Re: [PATCH 08/10] fs: move the buffer_heads_over_limit stub to
 buffer_head.h
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200620071644.463185-1-hch@lst.de>
 <20200620071644.463185-9-hch@lst.de>
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
Message-ID: <4336d6ee-edca-d439-b900-d7a38982b6a5@acm.org>
Date:   Sat, 20 Jun 2020 20:03:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200620071644.463185-9-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020-06-20 00:16, Christoph Hellwig wrote:
> Move the !CONFIG_BLOCK stub to the same place as the non-stub
> declaration.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
