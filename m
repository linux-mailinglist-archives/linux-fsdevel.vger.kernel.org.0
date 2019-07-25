Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 089EC757E2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jul 2019 21:31:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbfGYTbW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Jul 2019 15:31:22 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:38733 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726597AbfGYTbV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Jul 2019 15:31:21 -0400
Received: by mail-oi1-f195.google.com with SMTP id v186so38501433oie.5;
        Thu, 25 Jul 2019 12:31:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=z5QXyRkHTDjoQ131uZRhhER75vIP6/0mu4Z4dfUeq3Q=;
        b=HdSoZMalCwFy0wej2LSSJX7IASoRR9GpY8FBECBF1B2lO0Ubn+pTLhY6ae3fHK/ybO
         psd9Pt7d8dz/WidHo9LR0e7QEEj95ljcToqSLptekogF2/nf1fbB65Rulwl5xaA7xr3v
         oSG+xfzKBjXcrUV3WhiWW8fjCZUlO0MDNxE5akV0A+0vroztNlsN3bBCtqxFNJ9WCwnp
         rYVrgabYj/LUBNg+KutK9CCwRn7UR6ew3hfWs8WsQqMW1r7vwvMHpJmtLAfEsooqpW99
         RdiKyVr9AsIVRgo8HZE6xQEmJNk2lbF6kQirQfwDQsKWi1wgCdGQxVI4T76VEhpcy+/N
         nqSg==
X-Gm-Message-State: APjAAAXRoAK78ADS6/F6C8qz3WPRrOaZNlAo80D2vp2aWEOw+pHc0Bxx
        xNz/0acGcuQq6Sg3iKW8AxYKIKFP
X-Google-Smtp-Source: APXvYqy9/zPA47wMvG6CBiuBVcbb9OiBE6ydCS+VVRQ7d2TMrQCD2fTGnTbr6XYi7DvfplS2ffrhHg==
X-Received: by 2002:aca:cf51:: with SMTP id f78mr7856900oig.10.1564083080517;
        Thu, 25 Jul 2019 12:31:20 -0700 (PDT)
Received: from [192.168.1.114] (162-195-240-247.lightspeed.sntcca.sbcglobal.net. [162.195.240.247])
        by smtp.gmail.com with ESMTPSA id c29sm18852509otd.66.2019.07.25.12.31.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Jul 2019 12:31:19 -0700 (PDT)
Subject: Re: [PATCH v6 02/16] chardev: introduce cdev_get_by_path()
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-block@vger.kernel.org,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        Stephen Bates <sbates@raithlin.com>, Jens Axboe <axboe@fb.com>,
        linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Keith Busch <kbusch@kernel.org>,
        Max Gurtovoy <maxg@mellanox.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Christoph Hellwig <hch@lst.de>
References: <20190725172335.6825-1-logang@deltatee.com>
 <20190725172335.6825-3-logang@deltatee.com>
 <20190725174032.GA27818@kroah.com>
 <682ff89f-04e0-7a94-5aeb-895ac65ee7c9@deltatee.com>
 <20190725180816.GA32305@kroah.com>
 <da0eacb7-3738-ddf3-8c61-7ffc61aa41f4@deltatee.com>
 <20190725182701.GA11547@kroah.com>
 <20190725190024.GD30641@bombadil.infradead.org>
 <27943e06-a503-162e-356b-abb9e106ab2e@grimberg.me>
 <20190725191124.GE30641@bombadil.infradead.org>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <e91094eb-3ce8-b42b-663a-b62d4617fc96@grimberg.me>
Date:   Thu, 25 Jul 2019 12:31:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190725191124.GE30641@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


>>>>> NVMe-OF is configured using configfs. The target is specified by the
>>>>> user writing a path to a configfs attribute. This is the way it works
>>>>> today but with blkdev_get_by_path()[1]. For the passthru code, we need
>>>>> to get a nvme_ctrl instead of a block_device, but the principal is the same.
>>>>
>>>> Why isn't a fd being passed in there instead of a random string?
>>>
>>> I suppose we could echo a string of the file descriptor number there,
>>> and look up the fd in the process' file descriptor table ...
>>
>> Assuming that there is a open handle somewhere out there...
> 
> Well, that's how we'd know that the application echoing /dev/nvme3 into
> configfs actually has permission to access /dev/nvme3.

Actually, the application is exposing a target device to someone else,
its actually preferable that it doesn't have access to it as its
possibly can create a consistency hole, but that is usually a root
application anyways... We could verify at least that though..

>  Think about
> containers, for example.  It's not exactly safe to mount configfs in a
> non-root container since it can access any NVMe device in the system,
> not just ones which it's been given permission to access.  Right?

I'm seeing this as an equivalent to an application that is binding a
socket to an ip address, and the kernel looks-up according to the net
namespace that the socket has.

I do agree this is an area that was never really thought of. But what
you are describing requires infrastructure around it instead of forcing
the user to pass an fd to validate around it.
