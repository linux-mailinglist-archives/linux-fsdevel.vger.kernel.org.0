Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C8706E318A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Apr 2023 15:15:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbjDONPz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 15 Apr 2023 09:15:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbjDONPy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 15 Apr 2023 09:15:54 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AED124C31
        for <linux-fsdevel@vger.kernel.org>; Sat, 15 Apr 2023 06:15:52 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-63b5312bd34so441559b3a.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 15 Apr 2023 06:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1681564552; x=1684156552;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FDoeyOkk6TLcbWPLicxk2nAcFd4vulVwN1Th/ORcIBE=;
        b=Ozs96uUdlsV0iLwm5FkjhtfWxZXFvC4NsM6s3QV+/Uck/NrbDym76dousQcXck9W/Z
         nPM0AOkUDstn5Y0BEiBbeZBzxlpCk6tnVCTUhZwYfHs7ZjXv1m1Yxg3nYguITdjZPm7L
         HOKKUc06HE5z9DMxRN44fOtuAb2lvQwCtpmOI3aLIwjxlCnMGDewtG28ZOqJ91KjzQ9N
         knF+H2RjY8Mf4eIymjkzgf5jLvlLVPqwer9pyGaYB0vuX8MIH9KMkJO12mDetxNZuXjk
         qIrW3nveZIEtE6Up0JdLcmsSzN1KRANcURzkTRy0cEZ9bVO+6Jn6tfrb495kenJud+7Z
         +zTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681564552; x=1684156552;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FDoeyOkk6TLcbWPLicxk2nAcFd4vulVwN1Th/ORcIBE=;
        b=JmsGCu8g6C9IS4cyKazjFX1cr31vx7LIIp+F5l53PP6n/LfRSs3pveqydP9izIOsuH
         Qh9dY33gmAgzWUWoYfvEFG54AvwO2SLJ8lhnZXonG5M42SGWfE4NwjpwKgy8b6j88Kft
         bRg0I2YLqJM3F0JLnEhGvTTwxrjsUL/HnGWu6Ln7NgYuhaM8gMJ22I6PFMdWjErL6kY7
         wI4t4GBFymI7K5lSBdUg6OBRfhu/vsOBHBmVg5Tsh5JQevTHMg+osJK1IL8+8iII6QiK
         2G60JP8byfqAizVVKP3eGz9gTCqU66UTip0quJX1VeLjuEqkZt6RV3mLTqbM0I6TPQ9S
         tVMQ==
X-Gm-Message-State: AAQBX9cdrsS6sbMuEPxkD6QEeujg6v2oZXXuNfuWOLPaksNbWBA3UKdQ
        ICswymNbhIcpxCoHXEuNN5b71Q==
X-Google-Smtp-Source: AKy350Y7yuybEO7Elj/aE+xeem9Ot8bNg6QT7Ni4yu0UNeS9Yxp/xv2tunXjAJR6POrQVtXXl+NBUw==
X-Received: by 2002:a05:6a20:2448:b0:e3:6fdb:f6c6 with SMTP id t8-20020a056a20244800b000e36fdbf6c6mr7927795pzc.6.1681564551984;
        Sat, 15 Apr 2023 06:15:51 -0700 (PDT)
Received: from [192.168.4.201] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id a21-20020a1709027d9500b001a1cd6c5a88sm4661610plm.73.2023.04.15.06.15.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 15 Apr 2023 06:15:51 -0700 (PDT)
Message-ID: <cfeade24-81fc-ab73-1fd9-89f12a402486@kernel.dk>
Date:   Sat, 15 Apr 2023 07:15:49 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 1/2] fs: add FMODE_DIO_PARALLEL_WRITE flag
Content-Language: en-US
To:     "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@infradead.org>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Bernd Schubert <bschubert@ddn.com>, io-uring@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, dsingh@ddn.com
References: <20230307172015.54911-2-axboe@kernel.dk>
 <20230412134057.381941-1-bschubert@ddn.com>
 <CAJfpegt_ZCVodOhQCzF9OqKnCr65mKax0Gu4OTN8M51zP+8TcA@mail.gmail.com>
 <ZDjggMCGautPUDpW@infradead.org> <20230414153612.GB360881@frogsfrogsfrogs>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20230414153612.GB360881@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 4/14/23 9:36?AM, Darrick J. Wong wrote:
> On Thu, Apr 13, 2023 at 10:11:28PM -0700, Christoph Hellwig wrote:
>> On Thu, Apr 13, 2023 at 09:40:29AM +0200, Miklos Szeredi wrote:
>>> fuse_direct_write_iter():
>>>
>>> bool exclusive_lock =
>>>     !(ff->open_flags & FOPEN_PARALLEL_DIRECT_WRITES) ||
>>>     iocb->ki_flags & IOCB_APPEND ||
>>>     fuse_direct_write_extending_i_size(iocb, from);
>>>
>>> If the write is size extending, then it will take the lock exclusive.
>>> OTOH, I guess that it would be unusual for lots of  size extending
>>> writes to be done in parallel.
>>>
>>> What would be the effect of giving the  FMODE_DIO_PARALLEL_WRITE hint
>>> and then still serializing the writes?
>>
>> I have no idea how this flags work, but XFS also takes i_rwsem
>> exclusively for appends, when the positions and size aren't aligned to
>> the block size, and a few other cases.
> 
> IIUC uring wants to avoid the situation where someone sends 300 writes
> to the same file, all of which end up in background workers, and all of
> which then contend on exclusive i_rwsem.  Hence it has some hashing
> scheme that executes io requests serially if they hash to the same value
> (which iirc is the inode number?) to prevent resource waste.
> 
> This flag turns off that hashing behavior on the assumption that each of
> those 300 writes won't serialize on the other 299 writes, hence it's ok
> to start up 300 workers.
> 
> (apologies for precoffee garbled response)

Yep, that is pretty much it. If all writes to that inode are serialized
by a lock on the fs side, then we'll get a lot of contention on that
mutex. And since, originally, nothing supported async writes, everything
would get punted to the io-wq workers. io_uring added per-inode hashing
for this, so that any punt to io-wq of a write would get serialized.

IOW, it's an efficiency thing, not a correctness thing.

-- 
Jens Axboe

