Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E3F4B7580D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jul 2019 21:37:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726291AbfGYThS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Jul 2019 15:37:18 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:41066 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726177AbfGYThR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Jul 2019 15:37:17 -0400
Received: by mail-ot1-f67.google.com with SMTP id o101so52854476ota.8;
        Thu, 25 Jul 2019 12:37:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bRrEPEVgexSO2qJ+xF9O3stEIjJPqaaPVCD0SdqrQlc=;
        b=SzzCyXiRNMP1N7slHOmSIjmirJZq0/SQSw320vDtStVJePkzFcEjrJe+mVSye8yAbA
         UwCpIAUADMP8/NNbqcnUPBC24p7EhRX3KUrBJ9ZFeki4GDTEms9FWTdnF9LWdyvZ1d0N
         HeGOBE0P0WmnXw1bGPcXO1LmzkzRCUjmLPxi6AWXLtKSxl2b4uYLOdGDq2QR6Vqd4cMP
         /y9+ISJDb5n2ZQIucrVO0Imv/OXaLWiqv9gYIYUy9TqkALc/hCqRujnPIvfJVM+BwZwh
         7f3WzeIdD3HJwmLKsepG0MXP1s2tNAdHoLwXckgUPe+NQ8cDHD3z6pDYZKEgw4SXgX0N
         gGNA==
X-Gm-Message-State: APjAAAWB/w1ehXI/hosYWPXZ7g483oR7sSO+rQ2p7qJ2cchSQ7zcbKDE
        QjkFtI9ds6yIgfLBgrEQusY=
X-Google-Smtp-Source: APXvYqz9bV6QeYb15MSNKNxP2VfnI+u9Ca2BFAT2KloajK/flSPNHX4CrsZFsKbSXnU3PDj2zYBIPQ==
X-Received: by 2002:a9d:7a4e:: with SMTP id z14mr40017650otm.258.1564083436737;
        Thu, 25 Jul 2019 12:37:16 -0700 (PDT)
Received: from [192.168.1.114] (162-195-240-247.lightspeed.sntcca.sbcglobal.net. [162.195.240.247])
        by smtp.gmail.com with ESMTPSA id w22sm16304470otp.73.2019.07.25.12.37.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Jul 2019 12:37:16 -0700 (PDT)
Subject: Re: [PATCH v6 02/16] chardev: introduce cdev_get_by_path()
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Logan Gunthorpe <logang@deltatee.com>,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        Stephen Bates <sbates@raithlin.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
References: <20190725172335.6825-1-logang@deltatee.com>
 <20190725172335.6825-3-logang@deltatee.com>
 <20190725174032.GA27818@kroah.com>
 <682ff89f-04e0-7a94-5aeb-895ac65ee7c9@deltatee.com>
 <20190725180816.GA32305@kroah.com>
 <da0eacb7-3738-ddf3-8c61-7ffc61aa41f4@deltatee.com>
 <20190725182701.GA11547@kroah.com>
 <a3262a7f-b78e-05ba-cda3-a7587946bd91@deltatee.com>
 <5951e0f5-cc90-f3de-0083-088fecfd43bb@grimberg.me>
 <20190725193415.GA12117@kroah.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <966fa988-de56-effe-dd52-3515ee83629c@grimberg.me>
Date:   Thu, 25 Jul 2019 12:37:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190725193415.GA12117@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


>>>>>> Why do you have a "string" within the kernel and are not using the
>>>>>> normal open() call from userspace on the character device node on the
>>>>>> filesystem in your namespace/mount/whatever?
>>>>>
>>>>> NVMe-OF is configured using configfs. The target is specified by the
>>>>> user writing a path to a configfs attribute. This is the way it works
>>>>> today but with blkdev_get_by_path()[1]. For the passthru code, we need
>>>>> to get a nvme_ctrl instead of a block_device, but the principal is the same.
>>>>
>>>> Why isn't a fd being passed in there instead of a random string?
>>>
>>> I wouldn't know the answer to this but I assume because once we decided
>>> to use configfs, there was no way for the user to pass the kernel an fd.
>>
>> That's definitely not changing. But this is not different than how we
>> use the block device or file configuration, this just happen to need the
>> nvme controller chardev now to issue I/O.
> 
> So, as was kind of alluded to in another part of the thread, what are
> you doing about permissions?  It seems that any user/group permissions
> are out the window when you have the kernel itself do the opening of the
> char device, right?  Why is that ok?  You can pass it _any_ character
> device node and away it goes?  What if you give it a "wrong" one?  Char
> devices are very different from block devices this way.

We could condition any configfs operation on capable(CAP_NET_ADMIN) to
close that hole for now..
