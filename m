Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D318C515D58
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Apr 2022 15:12:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378007AbiD3NP0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 30 Apr 2022 09:15:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241953AbiD3NPZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 30 Apr 2022 09:15:25 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2649B6E4EA
        for <linux-fsdevel@vger.kernel.org>; Sat, 30 Apr 2022 06:11:59 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id n14so2400360plf.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 30 Apr 2022 06:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=rbHJXY572fQPlY1/oCQ8lTxni098FTYcSyKejnNxvz8=;
        b=QTpcQr+eFHJeVUB3NWSouQNbGpXHjM9CJjKwBm7FT8MWsvqUMWVojIpivPVnqoTYCQ
         zDZL07GjYyITVKinpFSM10/BXoZohACn6MV+DOUDtZbAEd9QUa6Xba07D0ph/AdN4SD7
         IRTZYq00D94UF5XPHUW0WFFVLsTX3g6qX44Ttk6VVcumew5i7BI/SENp3ctGGlEp6V4E
         ItTW8HbtJjKuxWmk9FXXGDU8Py6aeL4qwgQf/AUy1CMDXmIwe6zAbg2deEKo3X/I6XWs
         Um/0quaYaPylB0pDXSPmrAOnQbwxWXQTBemm2D313Vm5u0B38BpitPSP77hhno1IgV1h
         07rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=rbHJXY572fQPlY1/oCQ8lTxni098FTYcSyKejnNxvz8=;
        b=Jbz+ouwa7EwSyYdZMiFLD9gdzlG40qdn2W8LUyiJZEVlgqAXBxTvHSKjniL6J9GvO9
         ymPj2nhz9ErVMPPHeeiG7NYzY+wLDaEDk0vtfbG94aIVBk+2Wmwsm/kbtcoCNXIaA5fg
         PIiGAPdEEwV6MLQdsWeZD8YD3al9ru9N0lbq5UqIdmkM7s+5p4GMW5bvB5OvWCeGUhgs
         2DzfIv6H3obRBdGmeGpTcHSKk/toFs+b5DmhFYHlM9vyu4uKo+c6YmRAiqzWnii4JpVZ
         5jzZ86z84iFxjRqUDnBStD/uWdLmsNmOSQ5tm606odhF4jHiCamSNf1wwNSOrqag5QH8
         XiWA==
X-Gm-Message-State: AOAM533+gPuac+GO77GQ0b6T/XUH3/LGd+RoCxaoKS7lztbbFbHHQNiH
        ejlYFZi5UUq+MEDYBoqJ7chf8g==
X-Google-Smtp-Source: ABdhPJzVqX3K1GClAeYIsxafdj7jRZuQQtXP9i0vIO68TCqT5CfARItWrFP+FaVbjmsJi7Png8RPQw==
X-Received: by 2002:a17:90a:7c04:b0:1d7:d7e6:2916 with SMTP id v4-20020a17090a7c0400b001d7d7e62916mr9059401pjf.25.1651324318443;
        Sat, 30 Apr 2022 06:11:58 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id mj19-20020a17090b369300b001d29a04d665sm16268718pjb.11.2022.04.30.06.11.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Apr 2022 06:11:57 -0700 (PDT)
Message-ID: <ee61dae0-30d4-b301-a787-ea83be3f9308@kernel.dk>
Date:   Sat, 30 Apr 2022 07:11:56 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [RFC v3 0/9] fixed worker
Content-Language: en-US
To:     Hao Xu <haoxu.linux@gmail.com>, io-uring@vger.kernel.org
Cc:     Pavel Begunkov <asml.silence@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220429101858.90282-1-haoxu.linux@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220429101858.90282-1-haoxu.linux@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 4/29/22 4:18 AM, Hao Xu wrote:
> This is the third version of fixed worker implementation.
> Wrote a nop test program to test it, 3 fixed-workers VS 3 normal workers.
> normal workers:
> ./run_nop_wqe.sh nop_wqe_normal 200000 100 3 1-3
>         time spent: 10464397 usecs      IOPS: 1911242
>         time spent: 9610976 usecs       IOPS: 2080954
>         time spent: 9807361 usecs       IOPS: 2039284
> 
> fixed workers:
> ./run_nop_wqe.sh nop_wqe_fixed 200000 100 3 1-3
>         time spent: 17314274 usecs      IOPS: 1155116
>         time spent: 17016942 usecs      IOPS: 1175299
>         time spent: 17908684 usecs      IOPS: 1116776

I saw these numbers in v2 as well, and I have to admit I don't
understand them. Because on the surface, it sure looks like the first
set of results (labeled "normal") are better than the second "fixed"
set. Am I reading them wrong, or did you transpose them?

I think this patch series would benefit from a higher level description
of what fixed workers mean in this context. How are they different from
the existing workers, and why would it improve things.

> things to be done:
>  - Still need some thinking about the work cancellation

Can you expand? What are the challenges with fixed workers and
cancelation?

>  - not very sure IO_WORKER_F_EXIT is safe enough on synchronization
>  - the iowq hash stuff is not compatible with fixed worker for now

We might need to extract the hashing out a bit so it's not as tied to
the existing implementation.

-- 
Jens Axboe

