Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B22C31C21AE
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 May 2020 01:54:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727791AbgEAXyN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 May 2020 19:54:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726951AbgEAXyN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 May 2020 19:54:13 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 215EEC061A0C
        for <linux-fsdevel@vger.kernel.org>; Fri,  1 May 2020 16:54:12 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id hi11so537488pjb.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 01 May 2020 16:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9p0uqSd3tkiiC3VkHU4yGoSUEHdyAJcrn6CCtmMfaBI=;
        b=XOR4Tt12afi10eez0qYXbuaTt4fYjIk5MtVw9+kThNvwqhylSJ4ehnFJoyr4fZb39i
         FzPCfWF3H3mkE3wj1l4r6Zbj6vBV0Tyux09TLOmAVG9sw9Bc/y189DXLXjUq6DYRZ8zh
         S+3256E7FU9MYHBnj0tz8ms3Cd5PfJPIuwcHzztyG/10PQfqVs3720gr/xDXM4qdrWAY
         9TRLWr1nEVcm1WnqZgFtTTvn9uCdxd63mPSHEjZsgIoURQEOAglQXs6DOM3LP3EUImZw
         ovpJQn1Ce7aLqO7ncvJal1xBeQc1GkH0xg2nKQAVBrMYFL+5voYVPTusuU7dyBe/w1A5
         Urdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9p0uqSd3tkiiC3VkHU4yGoSUEHdyAJcrn6CCtmMfaBI=;
        b=KZPLwNFVKvkrqUR8MakN8l81Fp2lTT1YBlgwuDg58RvBM2Eh5GqZBpRCmpUvJJjm6u
         ZpBGUnttoRgYtbqmD+51XGEnAhUnYzKiNMpx44TTID1k3EEnW00smx55hj2r3Sr/1OJK
         n+DY/WO3Fax38i6/M5hIcRO4GBZP/DBCM+QDXUD2r8AW2bKfpCDTMzR0tXrkRUamqzLt
         U/VFoRJWkU1F+AhdLwNnuh6GVWwAoT37OSRElz/U4Mpf0VOzWU2n4LT7DP9YYVbgZ+M6
         DeZfMB1VRMVXq1jHaHRM+C2SNIljY02oUvFnQlxaE2paYI+hP/weed5M++586BMVXJyk
         S7Pg==
X-Gm-Message-State: AGi0PuYWVI0S0n/VwRAESeE5B05Mg+Pqaki/sODviEY1VSP4iI65QhJ8
        bWqvP02/20UAu9ugvMaEnvEpA1dKgv2Jlw==
X-Google-Smtp-Source: APiQypLVJOUETmGHOLwQntBbJj/tXXB80caG5i2Y/6TIb1wVeQy8sXj58WCZr9w3lAXgYzdJT4ee8g==
X-Received: by 2002:a17:90a:8d02:: with SMTP id c2mr2434921pjo.113.1588377251513;
        Fri, 01 May 2020 16:54:11 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id u188sm3116062pfu.33.2020.05.01.16.54.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 May 2020 16:54:10 -0700 (PDT)
Subject: Re: [PATCH v4] eventfd: convert to f_op->read_iter()
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <6b29f015-bd7c-0601-cf94-2c077285b933@kernel.dk>
 <20200501231231.GR23230@ZenIV.linux.org.uk>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <03867cf3-d5e7-cc29-37d2-1a417a58af45@kernel.dk>
Date:   Fri, 1 May 2020 17:54:09 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200501231231.GR23230@ZenIV.linux.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/1/20 5:12 PM, Al Viro wrote:
> On Fri, May 01, 2020 at 01:11:09PM -0600, Jens Axboe wrote:
>> +	flags &= EFD_SHARED_FCNTL_FLAGS;
>> +	flags |= O_RDWR;
>> +	fd = get_unused_fd_flags(flags);
>>  	if (fd < 0)
>> -		eventfd_free_ctx(ctx);
>> +		goto err;
>> +
>> +	file = anon_inode_getfile("[eventfd]", &eventfd_fops, ctx, flags);
>> +	if (IS_ERR(file)) {
>> +		put_unused_fd(fd);
>> +		fd = PTR_ERR(file);
>> +		goto err;
>> +	}
>>  
>> +	file->f_mode |= FMODE_NOWAIT;
>> +	fd_install(fd, file);
>> +	return fd;
>> +err:
>> +	eventfd_free_ctx(ctx);
>>  	return fd;
>>  }
> 
> Looks sane...  I can take it via vfs.git, or leave it for you if you
> have other stuff in the same area...

Would be great if you can queue it up in vfs.git, thanks! Don't have
anything else that'd conflict with this.

-- 
Jens Axboe

