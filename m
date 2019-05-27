Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 104DD2B681
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 May 2019 15:36:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726511AbfE0Ng1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 May 2019 09:36:27 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36456 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726395AbfE0Ng0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 May 2019 09:36:26 -0400
Received: by mail-pf1-f195.google.com with SMTP id u22so2310326pfm.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 May 2019 06:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8FblGJ8IL94YZVfgvbNK9dTbVHc5evf+UUaEl8CiQeA=;
        b=ItBuazfoD4SliYAo5oWst0JC066uAt3FYtk2EqaZeZDvcXN8ynC/DX0Q8AYiFVGvUf
         bY0r4G1wxbHTXDrNRmIevsG6k8rFz9DNG70s4NKPYnZYWWgVRmHa7Iqv3ewOQGV28OL0
         h4QSLLsS1AG6ZctBcgGw39tLcU4U3UieILNKFUrika5xHj4QGqkabkEhJS01MWsJlWyG
         Gwo0y/EGDRzoPHXr1dGt84JuBjB2V3kT61/klWTvcq1qTqYtuTQvtrwdR3lOBRVI2SSP
         VNKewaIzbPSXsjCNOj+rtBL0xSJJT+1UqGd6ohyFV3LMPze4VtpTueMTAdkgBel4k6K6
         4kVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8FblGJ8IL94YZVfgvbNK9dTbVHc5evf+UUaEl8CiQeA=;
        b=P/VBfQxAX63UcdLSywIiAbZ2jCf5Mwxz027otTsYpJKIxigh02oxpaQ02tvNDmb82e
         /xNqjsw05ecCcWn+xofA2IuCb1QPhcrLYw4Q+6fnsMDVyL1BMK9Amg3z4s/AcsAr6qUV
         LGtpmXr3MtLuDJBcvxPavxK77eLiBBv3RAon8eVPvSh2cvq3CMFp2+PcXrspuZ3GvjZ0
         IPvBIUspfa46Swf3aHwzEU2tgWEmyi55g02WJ7tnyriCjdKAe6lXKapsCuyKZBwp1M6X
         Gka6KqXeVTWG9/yD4MpFEpbq348fgDy3ay1tBbC369mLLnP+NcBq/pGexuNJbtaMc3A3
         TGpQ==
X-Gm-Message-State: APjAAAWdPzJz2qAlX4oJXjZpg2UPoxBL4dB85PCAiflOWrdrdSp55Pb2
        FdlgDNNrhz37KbgZm7T//gsHmu/EDECwIA==
X-Google-Smtp-Source: APXvYqwJPPzy4frXO6C2Lp7m8GcKmY/AgqRgdOA+JE+7d0AY6INlsdLQhitBPfpgDlNvyt08sUpg6A==
X-Received: by 2002:a17:90a:9202:: with SMTP id m2mr31475203pjo.37.1558964185599;
        Mon, 27 May 2019 06:36:25 -0700 (PDT)
Received: from [192.168.1.121] (66.29.164.166.static.utbb.net. [66.29.164.166])
        by smtp.gmail.com with ESMTPSA id k13sm10660834pgr.90.2019.05.27.06.36.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 May 2019 06:36:24 -0700 (PDT)
Subject: Re: [bug report] io_uring: add support for sqe links
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     linux-fsdevel@vger.kernel.org
References: <20190527100808.GA31410@mwanda>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <e46527f2-44f9-499d-3de9-510fc8f08feb@kernel.dk>
Date:   Mon, 27 May 2019 07:36:22 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190527100808.GA31410@mwanda>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/27/19 4:08 AM, Dan Carpenter wrote:
> Hello Jens Axboe,
> 
> The patch f3fafe4103bd: "io_uring: add support for sqe links" from
> May 10, 2019, leads to the following static checker warning:
> 
> 	fs/io_uring.c:623 io_req_link_next()
> 	error: potential NULL dereference 'nxt'.
> 
> fs/io_uring.c
>     614  static void io_req_link_next(struct io_kiocb *req)
>     615  {
>     616          struct io_kiocb *nxt;
>     617
>     618          nxt = list_first_entry_or_null(&req->link_list, struct io_kiocb, list);
>     619          list_del(&nxt->list);
>                            ^^^^^^^^^
> The warning is a false positive but this is a NULL dereference.
> 
>     620          if (!list_empty(&req->link_list)) {
>     621                  INIT_LIST_HEAD(&nxt->link_list);
>                                          ^^^^^
> False positive.

Both of them are false positives. I can work around them though, as it
probably makes it a bit cleaner, too.

> 
>     622                  list_splice(&req->link_list, &nxt->link_list);
>     623                  nxt->flags |= REQ_F_LINK;
>     624          }
>     625
>     626          INIT_WORK(&nxt->work, io_sq_wq_submit_work);
>                            ^^^^^^^^^^
>     627          queue_work(req->ctx->sqo_wq, &nxt->work);
>                                               ^^^^^^^^^^
> Other bugs.

Not sure what that means?


-- 
Jens Axboe

