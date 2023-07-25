Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFE51762405
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jul 2023 22:58:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231297AbjGYU6R (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Jul 2023 16:58:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231330AbjGYU6P (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Jul 2023 16:58:15 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E9871BC3
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Jul 2023 13:58:10 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-682eef7d752so1365480b3a.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Jul 2023 13:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1690318689; x=1690923489;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xLjgmoInhbbVcHSZOX3Dw4HQ4eVDyk2e3GDfp0OqxPo=;
        b=FDgdx/46xAYnB86wVCldw7axWoUoFVmgUGRSDJzuJq1w4PY0DUSgMdu1b1A3kfCoeF
         8SA8wxbzp7SJdIbgPQIKqcxbM3ZDjkDeqDDqGLn4lNV3p7c4mtzUdy7UFzxx5fHMKQ0d
         q97mkN3cgYFQlKF47ibEPBnce5Q2iRa7CTrMQOPXElTw8tg17Mhi3TNOM2wet+6UHrts
         vgSCsC97LaeHsBstUBkOoqhYiHTUkoa0737FSUjMunrukKPmDi8uZDa1E2PrCgqHcuAK
         jvikc6eiw9EnYOwQ92owqAxt/wwdT+7xyPQgnfYUm/z+gkZVZB0zYbvV2FhtHtMddgS4
         9+yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690318689; x=1690923489;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xLjgmoInhbbVcHSZOX3Dw4HQ4eVDyk2e3GDfp0OqxPo=;
        b=FTGXRsE9fNNO+6LPnJCqYn6lE+zYQ248M96JWeMkuqqs7PGSMmzBm/XqM+GqxGnP65
         Ken/s/JYe6qoO2LIAttXon9p+NeDdofeCZlg6YwUkAgU7Ldc+8hldSHpunLkJKYIGa97
         FzpZ0z27NCGEpsLaHp3XQHJNFQAmrM9QYLL+wWf3fTUxBYwh5nLNNvLtIc7HfE/aXlRt
         0GRbMoQeAzkOhjfy7y3p03a3scMAHweLtL/xn2bZ6yNpjPApt/sfJ0Ewzn3RdIu5A8Wn
         4oz145JDpuJRxaf7jr1rR+AO7suIL1EVypcM3y9puhrayn19yeKQ+D4Uu0TouAhoQeJg
         yr7g==
X-Gm-Message-State: ABy/qLYy4YeL5SdneTsjinH7UK9E6Y3vQGL4dU994wp+yXIJZ0leZs0b
        ryjk0/FESjtbi5yEnQtnezZxvA==
X-Google-Smtp-Source: APBJJlH7WkOeA/IlWsAYgdx+CF7wBOZw7N58vM0ISOT6ZSODeC9qpCk661MZGoaUY42AoMhSBv6ASg==
X-Received: by 2002:a05:6a20:3c90:b0:134:d4d3:f0a5 with SMTP id b16-20020a056a203c9000b00134d4d3f0a5mr203635pzj.2.1690318689584;
        Tue, 25 Jul 2023 13:58:09 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id x9-20020a056a00270900b00654228f9e93sm10045855pfv.120.2023.07.25.13.58.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jul 2023 13:58:09 -0700 (PDT)
Message-ID: <88806a9b-6b3f-1451-ee55-df7da9445a59@kernel.dk>
Date:   Tue, 25 Jul 2023 14:58:07 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] file: always lock position
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Seth Forshee <sforshee@kernel.org>,
        linux-fsdevel@vger.kernel.org, stable@vger.kernel.org
References: <20230724-vfs-fdget_pos-v1-1-a4abfd7103f3@kernel.org>
 <CAHk-=whfJhag+iEscftpVq=dHTeL7rQopCvH+Pcs8vJHCGNvXQ@mail.gmail.com>
 <20230724-scheren-absegnen-8c807c760ba1@brauner>
 <CAHk-=whwUTsixPwyBiuA25F2mAzARTU_-BijfmJ3MzkKLOYDmA@mail.gmail.com>
 <20230724-gebessert-wortwahl-195daecce8f0@brauner>
 <CAHk-=wiZRxy3983r_nvWG4JP=w+Wi623WA9W6i2GXoTi+=6zWg@mail.gmail.com>
 <20230724-eckpunkte-melden-fc35b97d1c11@brauner>
 <CAHk-=wijcZGxrw8+aukW-m2YRGn5AUWfZsPSscez7w7_EqfuGQ@mail.gmail.com>
 <790fbcff-9831-e5cf-2aaf-1983d9c2cffe@kernel.dk>
 <CAHk-=wgqLGdTs5hBDskY4HjizPVYJ0cA6=-dwRR3TpJY7GZG3A@mail.gmail.com>
 <20230724-geadelt-nachrangig-07e431a2f3a4@brauner>
 <CAHk-=wjKXJhW3ZYtd1n9mhK8-8Ni=LSWoytkx2F5c5q=DiX1cA@mail.gmail.com>
 <4b382446-82b6-f31a-2f22-3e812273d45f@kernel.dk>
 <CAHk-=wg8gY+oBoehMop2G8wq2L0ciApZEOOMpiPCL=6gxBgx=g@mail.gmail.com>
 <8d1069bf-4c0b-22be-e4c4-5f2b1eb1f7e8@kernel.dk>
 <CAHk-=whMEd2J5otKf76zuO831sXi4OtgyBTozq_wE43q92=EiQ@mail.gmail.com>
Content-Language: en-US
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CAHk-=whMEd2J5otKf76zuO831sXi4OtgyBTozq_wE43q92=EiQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/25/23 2:51?PM, Linus Torvalds wrote:
> On Tue, 25 Jul 2023 at 13:41, Jens Axboe <axboe@kernel.dk> wrote:
>>
>> Right, but what if the original app closes the file descriptor? Now you
>> have the io_uring file table still holding a reference to it, but it'd
>> just be 1. Which is enough to keep it alive, but you can still have
>> multiple IOs inflight against this file.
> 
> Note that fdget_pos() fundamentally only works on file descriptors
> that are there - it's literally looking them up in the file table as
> it goes along. And it looks at the count of the file description as it
> is looked up. So that refcount is guaranteed to exist.
> 
> If the file has been closed, fdget_pos() will just fail because it
> doesn't find it.
> 
> And if it's then closed *afterwards*, that's fine and doesn't affect
> anything, because the locking has been done and we saved away the
> status bit as FDPUT_POS_UNLOCK, so the code knows to unlock even if
> the file descriptor in the meantime has turned back to having just a
> single refcount.

Ah yes good point. If registered with io_uring and closed, then it won't
matter how many extra references we hold or grab in the future, it won't
be found in the file table. I guess that's obvious...

-- 
Jens Axboe

