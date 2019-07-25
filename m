Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 09F747583B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jul 2019 21:43:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726262AbfGYTnh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Jul 2019 15:43:37 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:39683 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726385AbfGYTng (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Jul 2019 15:43:36 -0400
Received: by mail-ot1-f67.google.com with SMTP id r21so46853959otq.6;
        Thu, 25 Jul 2019 12:43:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AB7k73A/9o/kiEuhYTJZDvvpmb5gQLdNw/V/UVLUe8w=;
        b=npliwWmcOwPkuQYAT0OIUPMzKv8GqdsWYj39IYgD/Rl0k2TVquj8uEegvtjdlB05e8
         TCiKeeVepq8W/MlnUugmwbURadFy953YreXFVXXsqUHBDoEK7pNnLq4o/eIan4IkRONK
         bNUtPRoaxTApBdc5JF8/cdt74A1pZRA9Hk41fcnUSRrQ5hOkCBdvUEgfmV2JP/6l0MYH
         687sUnPvp8fkP8+It+j4vWahjUt1fVkAG9w0OmumbQlCjxpmln+IQGpbQ37QpnHUJEmr
         ZaIYkUv/CQvDcnLyBXN06TmB0LEa+LTs/+RLDL4Q+p2eLMpWA+l/kzY5hoUIFvokEsvt
         n1lQ==
X-Gm-Message-State: APjAAAXgZVm9Bkii3MOc8U/t9VTVQ8Y7KIOV1cthhuYdcBmwx8qfY2/D
        eiYvvpVdwoYAlguj3k1i8XM=
X-Google-Smtp-Source: APXvYqz9WGa4zv/OdhNOHzYyvqVyo1EtCgdTXwKr/MVzBRdy4TVgCb4zZfHmx5oJ+u/1wTmK8XpwHA==
X-Received: by 2002:a9d:6195:: with SMTP id g21mr34812081otk.103.1564083815719;
        Thu, 25 Jul 2019 12:43:35 -0700 (PDT)
Received: from [192.168.1.114] (162-195-240-247.lightspeed.sntcca.sbcglobal.net. [162.195.240.247])
        by smtp.gmail.com with ESMTPSA id l12sm16886495otp.74.2019.07.25.12.43.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Jul 2019 12:43:35 -0700 (PDT)
Subject: Re: [PATCH v6 02/16] chardev: introduce cdev_get_by_path()
From:   Sagi Grimberg <sagi@grimberg.me>
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
 <966fa988-de56-effe-dd52-3515ee83629c@grimberg.me>
Message-ID: <af960e70-7373-51f2-3ff3-f23335f94aa1@grimberg.me>
Date:   Thu, 25 Jul 2019 12:43:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <966fa988-de56-effe-dd52-3515ee83629c@grimberg.me>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


>> So, as was kind of alluded to in another part of the thread, what are
>> you doing about permissions?  It seems that any user/group permissions
>> are out the window when you have the kernel itself do the opening of the
>> char device, right?  Why is that ok?  You can pass it _any_ character
>> device node and away it goes?  What if you give it a "wrong" one?  Char
>> devices are very different from block devices this way.
> 
> We could condition any configfs operation on capable(CAP_NET_ADMIN) to
> close that hole for now..

s/NET/SYS/...
