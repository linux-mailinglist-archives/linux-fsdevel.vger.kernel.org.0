Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 771192B799
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 May 2019 16:34:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726206AbfE0OeX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 May 2019 10:34:23 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36272 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbfE0OeX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 May 2019 10:34:23 -0400
Received: by mail-pg1-f194.google.com with SMTP id a3so9220787pgb.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 May 2019 07:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gzYd5rx1o8UxZW4stQdx6cv757J2ePBOY7rK3z3WF7c=;
        b=2Kjr0WYyIF4h5/WCFdInXfzwd8WmU4K7sGPGZrrxUEUIcLWQeIlrbbuZ4PH8Ng0v3U
         Javm8+Rr7xB5MGDbhAbL+S+v/10vKgVBHm+KuiubWlmpsuy3lyzVTZs0QEyP0v+uPPak
         HRNzOePTOHJ9LJ160aTfyhoR2FDfFcKvApLRrHIE+HDuyXr/7ahDmIwu1YkP+/sxIWwr
         xZW3RzFlKsVs5mKOxO0iHXIbKF25vVIxz4rISRiWPPqEjxfKdaH6j1YFBqb2N+YjDbes
         tkyQfHXAszg2BPsMVqO4B3+fYw7+XzkV1AjHpZj4PndXIDQfkKK+VqTzVHVMpqJJqXjj
         eGvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gzYd5rx1o8UxZW4stQdx6cv757J2ePBOY7rK3z3WF7c=;
        b=K8MYAzjMbbo3B9hV1fw/KieiBhXH6jr6PsBGQmoEb1d66PFDDKfYaU/qXD5Gyaf/FP
         0Dy1LZjgAdx+AyRWBSyUAAVKaP+HwHd385lDKexKfDSTOLEZQKCrXswcZUFpI6leQBRO
         rXSwvMYxBE0T32aI3B48RfhlP6PN3f4KK+RoKJ3E0HrwXNqlShPhbOwhriV44IePqE9U
         oSdPRLlB4t6bXAaAKtWEQXeI9BvLHfFKEZRstOPe+M3oN4+L8mSzWUol2IHJNVR1y1ny
         8dDUFiwxERrU2pPzsK+s+p8o7+y7EaInYvQKFDHSwWb4X4dNCA9fSxx5i/S4E679G0GJ
         OtTQ==
X-Gm-Message-State: APjAAAXKmOqSckGWW/6FW07t4/96+5y2n34nmEj5Ohn3eB+Rsj76ZBc1
        UazvCG6curNd2h2nPKtxTUb2QjuZFSud6g==
X-Google-Smtp-Source: APXvYqxerSNHfYHMILvQqVQgc4ZKHCw4PPZFWvyaCivx3rsK9/JVgguQ/LIwrNRe6Em6v7ryl6+8TQ==
X-Received: by 2002:a63:4b24:: with SMTP id y36mr10376626pga.36.1558967662131;
        Mon, 27 May 2019 07:34:22 -0700 (PDT)
Received: from [192.168.1.121] (66.29.164.166.static.utbb.net. [66.29.164.166])
        by smtp.gmail.com with ESMTPSA id q17sm17589598pfq.74.2019.05.27.07.34.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 May 2019 07:34:20 -0700 (PDT)
Subject: Re: [bug report] io_uring: add support for sqe links
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     linux-fsdevel@vger.kernel.org
References: <20190527100808.GA31410@mwanda>
 <e46527f2-44f9-499d-3de9-510fc8f08feb@kernel.dk>
 <20190527141014.GI24680@kadam>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <9b7b794b-26ed-7525-5f81-93cb60e1a005@kernel.dk>
Date:   Mon, 27 May 2019 08:34:18 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190527141014.GI24680@kadam>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/27/19 8:10 AM, Dan Carpenter wrote:
> On Mon, May 27, 2019 at 07:36:22AM -0600, Jens Axboe wrote:
>> On 5/27/19 4:08 AM, Dan Carpenter wrote:
>>> Hello Jens Axboe,
>>>
>>> The patch f3fafe4103bd: "io_uring: add support for sqe links" from
>>> May 10, 2019, leads to the following static checker warning:
>>>
>>> 	fs/io_uring.c:623 io_req_link_next()
>>> 	error: potential NULL dereference 'nxt'.
>>>
>>> fs/io_uring.c
>>>      614  static void io_req_link_next(struct io_kiocb *req)
>>>      615  {
>>>      616          struct io_kiocb *nxt;
>>>      617
>>>      618          nxt = list_first_entry_or_null(&req->link_list, struct io_kiocb, list);
>                                                      ^^^^^^^^^^^^^^^
> If this list is empty then "nxt" is NULL.

Right...

>>>      619          list_del(&nxt->list);
>>>                             ^^^^^^^^^
>>> The warning is a false positive but this is a NULL dereference.
>>>
>>>      620          if (!list_empty(&req->link_list)) {
>                           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> 
> We're checking for list_empty() here.

After deleting an entry from it.

>>>      621                  INIT_LIST_HEAD(&nxt->link_list);
>>>                                           ^^^^^
>>> False positive.
>>
>> Both of them are false positives. I can work around them though, as it
>> probably makes it a bit cleaner, too.
>>
>>>
>>>      622                  list_splice(&req->link_list, &nxt->link_list);
>>>      623                  nxt->flags |= REQ_F_LINK;
>>>      624          }
>>>      625
>>>      626          INIT_WORK(&nxt->work, io_sq_wq_submit_work);
>>>                             ^^^^^^^^^^
>>>      627          queue_work(req->ctx->sqo_wq, &nxt->work);
>>>                                                ^^^^^^^^^^
>>> Other bugs.
>>
>> Not sure what that means?
> 
> All these dereferences outside the if not empty check are a problem.

But this is the same thing If 'nxt' can ever be NULL, it's a problem.
If it cannot, then it's a false positive.

I'll just add a check. It should not happen, but it probably can if
the chain is messed up.

-- 
Jens Axboe

