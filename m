Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 81CCF75849
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jul 2019 21:45:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726614AbfGYTpT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Jul 2019 15:45:19 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:37216 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726251AbfGYTpT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Jul 2019 15:45:19 -0400
Received: by mail-ot1-f67.google.com with SMTP id s20so52875316otp.4;
        Thu, 25 Jul 2019 12:45:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YM6khcozeX5HCI3TLwGme6MoZN6oKGjknBQrsf5/NIs=;
        b=lotIOCdhfy/2wpoG1+TBBKKGlDLndm1kFyAbkrTJJqoYCtuik2CxMKhFCzJgDkNrSA
         oeapOw+UU8NnsZx2UDH/7wL1FK6zxEFL5ZWxlCKuxdGpOh7xVeb913uNBshdwXBIIMxs
         emfVrlYEgjMuXLz5M+KUYF2Jy9qFO8MST3i2Bu32hqI74BeHYOJO9VxuEGUDbhKZN4gO
         +SAoNuU1+iGxNvF4Vj7iEufAsXmdUrfLD3Au0eF97PgT3VgtQdEq3fs3ZQymDqMnKn6L
         tVk/qhArul+/0215ypVIN0PJSOwrS7G4YLRnR3fZVEzOc/tyV1xDndPTh1uXI2UzC25h
         1tsA==
X-Gm-Message-State: APjAAAWg3PHbQSc5ElFM1ba0Ufva0yJUR/ShI/lhLiACtXxSYoeKfNR5
        m0mF0CXMk+H451BKMEGabYA=
X-Google-Smtp-Source: APXvYqztMRLMzXcB5HNvGbVqaTvfVch+4p86/tSF9VTNiZRY+RU1oA8E47opbCMO3jKmoCOODsTS7g==
X-Received: by 2002:a05:6830:2148:: with SMTP id r8mr60886138otd.179.1564083918204;
        Thu, 25 Jul 2019 12:45:18 -0700 (PDT)
Received: from [192.168.1.114] (162-195-240-247.lightspeed.sntcca.sbcglobal.net. [162.195.240.247])
        by smtp.gmail.com with ESMTPSA id x5sm17395205otb.6.2019.07.25.12.45.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Jul 2019 12:45:17 -0700 (PDT)
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
References: <20190725172335.6825-3-logang@deltatee.com>
 <20190725174032.GA27818@kroah.com>
 <682ff89f-04e0-7a94-5aeb-895ac65ee7c9@deltatee.com>
 <20190725180816.GA32305@kroah.com>
 <da0eacb7-3738-ddf3-8c61-7ffc61aa41f4@deltatee.com>
 <20190725182701.GA11547@kroah.com>
 <a3262a7f-b78e-05ba-cda3-a7587946bd91@deltatee.com>
 <5951e0f5-cc90-f3de-0083-088fecfd43bb@grimberg.me>
 <20190725193415.GA12117@kroah.com>
 <966fa988-de56-effe-dd52-3515ee83629c@grimberg.me>
 <20190725194312.GA13090@kroah.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <89fb0e7e-eccd-5db5-00c1-d0b90c85270f@grimberg.me>
Date:   Thu, 25 Jul 2019 12:45:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190725194312.GA13090@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


>>> So, as was kind of alluded to in another part of the thread, what are
>>> you doing about permissions?  It seems that any user/group permissions
>>> are out the window when you have the kernel itself do the opening of the
>>> char device, right?  Why is that ok?  You can pass it _any_ character
>>> device node and away it goes?  What if you give it a "wrong" one?  Char
>>> devices are very different from block devices this way.
>>
>> We could condition any configfs operation on capable(CAP_NET_ADMIN) to
>> close that hole for now..
> 
> Why that specific permission?

Meant CAP_SYS_ADMIN

> And what about the "pass any random char device name" issue?  What
> happens if you pass /dev/random/ as the string?

What is the difference if the application is opening the device if
it has the wrong path?
