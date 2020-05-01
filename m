Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBB061C1DA1
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 May 2020 21:08:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730051AbgEATIV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 May 2020 15:08:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729766AbgEATIV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 May 2020 15:08:21 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CF5EC061A0C
        for <linux-fsdevel@vger.kernel.org>; Fri,  1 May 2020 12:08:21 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id l25so2608214pgc.5
        for <linux-fsdevel@vger.kernel.org>; Fri, 01 May 2020 12:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=12753pvCs41oaRWN2f3fDLkKSoGRm3fE1KHXq7bPLrQ=;
        b=bkY90fbnY1XYGa0d8K57hg+77EDktHM/phFxEqzYengai1tDm2GYhy/LwgmaVg32Gt
         bXngLucaA7iU/uc/3atFx5qMMYxYMkWf6Z81h/gVnbxlDB8bwW5UFxXTkf7XFq7SbSOx
         dF6fGsVNyR1WoY5gQ0kZrqdFGP/Ml8YhyIWR2X/j/rSaE79SvpAmjqauJPVhCRN+9QYb
         /7Oqqs35izW8u3pE3Ay5FCOzefx1NnwZDo+n4xowCBqmPEJX/sQbXqlpcOvltF3DGupG
         3z1Hy/DceEFd1t1T19Yh+gPIw6oVbCTtGT5HTNi1Ln1b2zUEcHPFIWoaYX76/7vRSZVk
         xfhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=12753pvCs41oaRWN2f3fDLkKSoGRm3fE1KHXq7bPLrQ=;
        b=udtJn/t7ObotDfcq+4ba0+AnHUH7ieQLpJerdwJTbfmP8d/AWhCXs7RJreaKRBuqF7
         xSo0ueIRY3HtgxgLpV5ASKmSqA8kqoaacGryWAsyQPwVgfHbIp3Haq0cIQFbxNsstD2+
         Pu2GiPGavFWbZgmMzRZHJKDHrytqRDjGSVuW70gDAlIuGXqtL0GFojiUttxvILsqUKOW
         BTnyfNdTFwtK5MqmaeqQQTo0Rad6dwSBNhLvSf7T48sQFfBZaH9mGCB0YceOmCSsnc2A
         3u2KNRrnPXr9343sdM5ECpSoWKVZolcC44mmtenOLWjeRAHxOnylhMk7ZKyRi3emoKIM
         wzIA==
X-Gm-Message-State: AGi0PuYdvGQikpqSHL6OkLAlKiNLkgFYTgflkpbAiDJR5t84bxnCluyT
        Zf5DIFp3Ew1WYvjewaD1nyXYZfufTJN1rw==
X-Google-Smtp-Source: APiQypK73kKvog/67sF9fNxwenhO3t7N+W4fXoQLOC5oFOHI03fkwaHBEkWbCceIXcUTZ39Pgp5kKw==
X-Received: by 2002:a63:c00a:: with SMTP id h10mr5776405pgg.238.1588360100452;
        Fri, 01 May 2020 12:08:20 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id u8sm321012pjy.16.2020.05.01.12.08.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 May 2020 12:08:19 -0700 (PDT)
Subject: Re: [PATCH v3b] eventfd: convert to f_op->read_iter()
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <97a28bdb-284a-c215-c04d-288bcef66376@kernel.dk>
 <20200501190018.GN23230@ZenIV.linux.org.uk>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <db9405e8-5960-787f-5a4c-8266b2e456f2@kernel.dk>
Date:   Fri, 1 May 2020 13:08:18 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200501190018.GN23230@ZenIV.linux.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/1/20 1:00 PM, Al Viro wrote:
> On Fri, May 01, 2020 at 11:54:01AM -0600, Jens Axboe wrote:
> 
>> @@ -427,8 +424,17 @@ static int do_eventfd(unsigned int count, int flags)
>>  
>>  	fd = anon_inode_getfd("[eventfd]", &eventfd_fops, ctx,
>>  			      O_RDWR | (flags & EFD_SHARED_FCNTL_FLAGS));
>> -	if (fd < 0)
>> +	if (fd < 0) {
>>  		eventfd_free_ctx(ctx);
>> +	} else {
>> +		struct file *file;
>> +
>> +		file = fget(fd);
>> +		if (file) {
>> +			file->f_mode |= FMODE_NOWAIT;
>> +			fput(file);
>> +		}
> 
> No.  The one and only thing you can do to return value of anon_inode_getfd() is to
> return the fscker to userland.  You *CAN* *NOT* assume that descriptor table is
> still pointing to whatever you've just created.
> 
> As soon as it's in descriptor table, it's out of your hands.  And frankly, if you
> are playing with descriptors, you should be very well aware of that.
> 
> Descriptor tables are fundamentally shared objects; they *can* be accessed and
> modified by other threads, right behind your back.
> 
> *IF* you are going to play with ->f_mode, you must use get_unused_fd_flags(),
> anon_inode_getfile(), modify ->f_mode of the result and use fd_install() to
> put it into descriptor table.  With put_unused_fd() as cleanup in case
> of allocation failure.

OK, that makes sense, so we've got f_mode set before the fd_install() and fd
visibility. I wrote that up, will test, and send out a v4... Thanks Al, this
is very helpful.

-- 
Jens Axboe

