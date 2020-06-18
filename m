Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4418B1FEDED
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jun 2020 10:40:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728932AbgFRIjt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Jun 2020 04:39:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728765AbgFRIjo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Jun 2020 04:39:44 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD00FC0613EF
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Jun 2020 01:39:43 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id c3so5077422wru.12
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Jun 2020 01:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=bfGxedb35Oy+a+SaZCiApfvdfQftE+QGRqOTHCEiwk0=;
        b=Jp9qjrjhQcFj3NXFN/4Rrfme74bB0nupeKD4ZlzQWvUS7V6iRJu1jv1Sw/xuYGTK7k
         ej+7JPWkQcKo3Ajn043X+/+R+2UJ5jWokpn3flKm+7PyPqNh17V4WhZVxVl8UGg64Wfl
         yLAVVzaAY5T02u0306kGK6RI1pOm68OMgMXs1Q6bzwjTyr46pYHRf/2EDMWEUCo1eENB
         ah42bVn0bM6JaiFAzRuDUo0UXVHCUtYN8YRPwPB1XYEJI1AxR6UM7zrwjYxOlgOAVjlf
         Murw1Sff/3vLDbdD7Obz+r4KwOHNyTfSd6/UabOTjfMlsof+K6zxD5w1t/9NBrZ/jGDZ
         u39Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=bfGxedb35Oy+a+SaZCiApfvdfQftE+QGRqOTHCEiwk0=;
        b=FB2P7vjWpvhHtkb9k+9eKnKUMJ59WtymBFOxVTj//0fbA5EPQnWXaFFOr9DtENuy9R
         0bTsTOrOHzBdz7V0j6l85BQvve/41g3cQB7WneaxbDq+O2d3U2S9xwfoxIU1uqVroDTd
         RGvoGHx2gyPwnLxAWV2gb4fzCfNBgHrjaoJ5Kja+LCyKvIxGetNXG0bcjJue4EezkcOc
         BboF00I8DrKDWyPzCtAxnAUUiBSmZn/feYMpSkgKrZXno8LptfS8MQmHqpF0OULebeAu
         myJOmd5xhml6vcIeE+DbqbCPfufYGbvIcfdSVhZNdER+l8lbqYYPoMuYcIL+OgiVCMAl
         H/wA==
X-Gm-Message-State: AOAM530AjXTxObXNc+X+ATTcdzLX6hxYouFU7prFIEY6PKrZWYc1X8T5
        mbKWtRl5i/hrXJ9ibgvwfNQUDw==
X-Google-Smtp-Source: ABdhPJyDJ4nqkXRrg8KN6BZdktgYlGnBwNdxZkxcf0GETyowwUFVAIHSwSrcMLTYoBfjtVs+p7hvSA==
X-Received: by 2002:adf:a18b:: with SMTP id u11mr3390432wru.102.1592469582468;
        Thu, 18 Jun 2020 01:39:42 -0700 (PDT)
Received: from localhost ([194.62.217.57])
        by smtp.gmail.com with ESMTPSA id d24sm2471775wmb.45.2020.06.18.01.39.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2020 01:39:41 -0700 (PDT)
Date:   Thu, 18 Jun 2020 10:39:40 +0200
From:   Javier =?utf-8?B?R29uesOhbGV6?= <javier@javigon.com>
To:     Matias =?utf-8?B?QmrDuHJsaW5n?= <mb@lightnvm.io>
Cc:     Kanchan Joshi <joshi.k@samsung.com>, axboe@kernel.dk,
        viro@zeniv.linux.org.uk, bcrl@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-aio@kvack.org, io-uring@vger.kernel.org,
        linux-block@vger.kernel.org, selvakuma.s1@samsung.com,
        nj.shetty@samsung.com, Damien Le Moal <Damien.LeMoal@wdc.com>,
        Keith Busch <keith.busch@wdc.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 0/3] zone-append support in aio and io-uring
Message-ID: <20200618083940.jzjtbfwwyyyhpnhs@mpHalley.local>
References: <CGME20200617172653epcas5p488de50090415eb802e62acc0e23d8812@epcas5p4.samsung.com>
 <1592414619-5646-1-git-send-email-joshi.k@samsung.com>
 <f503c488-fa00-4fe2-1ceb-7093ea429e45@lightnvm.io>
 <20200618082740.i4sfoi54aed6sxnk@mpHalley.local>
 <f9b820af-2b23-7bb4-f651-e6e1b3002ebf@lightnvm.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f9b820af-2b23-7bb4-f651-e6e1b3002ebf@lightnvm.io>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 18.06.2020 10:32, Matias Bjørling wrote:
>On 18/06/2020 10.27, Javier González wrote:
>>On 18.06.2020 10:04, Matias Bjørling wrote:
>>>On 17/06/2020 19.23, Kanchan Joshi wrote:
>>>>This patchset enables issuing zone-append using aio and io-uring 
>>>>direct-io interface.
>>>>
>>>>For aio, this introduces opcode IOCB_CMD_ZONE_APPEND. 
>>>>Application uses start LBA
>>>>of the zone to issue append. On completion 'res2' field is used 
>>>>to return
>>>>zone-relative offset.
>>>>
>>>>For io-uring, this introduces three opcodes: 
>>>>IORING_OP_ZONE_APPEND/APPENDV/APPENDV_FIXED.
>>>>Since io_uring does not have aio-like res2, cqe->flags are 
>>>>repurposed to return zone-relative offset
>>>
>>>Please provide a pointers to applications that are updated and 
>>>ready to take advantage of zone append.
>>
>>Good point. We are posting a RFC with fio support for append. We wanted
>>to start the conversation here before.
>>
>>We can post a fork for improve the reviews in V2.
>
>Christoph's response points that it is not exactly clear how this 
>matches with the POSIX API.

Yes. We will address this.
>
>fio support is great - but I was thinking along the lines of 
>applications that not only benchmark performance. fio should be part 
>of the supported applications, but should not be the sole reason the 
>API is added.

Agree. It is a process with different steps. We definitely want to have
the right kernel interface before pushing any changes to libraries and /
or applications. These will come as the interface becomes more stable.

To start with xNVMe will be leveraging this new path. A number of
customers are leveraging the xNVMe API for their applications already.

Thanks,
Javier

