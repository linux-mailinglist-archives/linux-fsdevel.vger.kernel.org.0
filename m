Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4758F3060CE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Jan 2021 17:17:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237005AbhA0QRc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Jan 2021 11:17:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343960AbhA0QPo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Jan 2021 11:15:44 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAC59C06174A
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Jan 2021 08:15:03 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id b8so1284378plh.12
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Jan 2021 08:15:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xiqRpJ5Ht6dR1wStXAMqrua7i2NfwhoL7Gu6JxmbtR0=;
        b=uWA0sCspPE3AkDSyaNYslh7VDfnSpKOfrK0nXICZYMMjajQojSrQhAYij265UzsGks
         VwWSj6yZAjVHCk2OLX+cBU2oQvVQDWNbB2quFe5YO+SFCSMrhwIXcicULLZldCXP1EHI
         9/HeEq5Z0t5qQzwbGRPMsEimr0xkKw7XxYAtyUbkp6n5xXYk6Db8dJk9LtFfjSStcDDj
         DyMuTkfxZ0Ako7l26doxamMLFxkz3DPmZFj0f6kSDn5YhvDNx2WonCGf0HyHUirBMUOH
         oXPJQwBPU4sNNuf6M5qw1GF2SUOpgCZ6jotLwVlzOeEnUy0oKgVGD/R0vFYhPirac8oj
         PxSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xiqRpJ5Ht6dR1wStXAMqrua7i2NfwhoL7Gu6JxmbtR0=;
        b=EVpMfgOu3l2wKMA2iDeLg6fi7zi5bRXB+65xecPmRKVuk8dSi7mcmWdBWOSZ5PZmbi
         Gm1Z/SWeDU9sPR8s6kM8ZVaNimU1jtRnz85ygPHg/t9mz0N9l89vkNwmSYdQsfU/yR+h
         j9//WCBxj19vGuKYBcM0FF2YdQIpdjROOj8vXAVV/xa7O6FFXXViou+PEXIN5MWLAip6
         BJQqNJdjGP6JUyDtdtUpkxU++yB4Ei3qpdKWHkZCAXJEI2wO1Jg2laF3GyeN60ZXbdrU
         7KgoXvItq9VX9DEHQmMqMZeZMf6oDIESMrxLLS8hn7hv/5E9synF2Zy3cOrxkahI2uJI
         2Qvw==
X-Gm-Message-State: AOAM532zomrLXomeWPuwUO9SDbwgoHBBTSNwZQFOz6VfKdv6CZb4wecr
        xuqNhSGBjpqxk4cb5lP3+64mqw==
X-Google-Smtp-Source: ABdhPJzsswtHV3w92LRCKEE7cnjcT4Vnr+fzOt1CqP/Koqrj3vZY9dGwAEokGdDdFpPClOtSAuHMbA==
X-Received: by 2002:a17:902:eccb:b029:de:8483:505d with SMTP id a11-20020a170902eccbb02900de8483505dmr12053475plh.63.1611764103374;
        Wed, 27 Jan 2021 08:15:03 -0800 (PST)
Received: from [192.168.4.41] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id u12sm2775076pgi.91.2021.01.27.08.15.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Jan 2021 08:15:02 -0800 (PST)
Subject: Re: [PATCH] Revert "block: simplify set_init_blocksize" to regain
 lost performance
To:     Maxim Mikityanskiy <maxtram95@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210126195907.2273494-1-maxtram95@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <eac57824-f2eb-9a81-aa5f-3fd62f8e531d@kernel.dk>
Date:   Wed, 27 Jan 2021 09:15:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210126195907.2273494-1-maxtram95@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 1/26/21 12:59 PM, Maxim Mikityanskiy wrote:
> The cited commit introduced a serious regression with SATA write speed,
> as found by bisecting. This patch reverts this commit, which restores
> write speed back to the values observed before this commit.
> 
> The performance tests were done on a Helios4 NAS (2nd batch) with 4 HDDs
> (WD8003FFBX) using dd (bs=1M count=2000). "Direct" is a test with a
> single HDD, the rest are different RAID levels built over the first
> partitions of 4 HDDs. Test results are in MB/s, R is read, W is write.
> 
>                 | Direct | RAID0 | RAID10 f2 | RAID10 n2 | RAID6
> ----------------+--------+-------+-----------+-----------+--------
> 9011495c9466    | R:256  | R:313 | R:276     | R:313     | R:323
> (before faulty) | W:254  | W:253 | W:195     | W:204     | W:117
> ----------------+--------+-------+-----------+-----------+--------
> 5ff9f19231a0    | R:257  | R:398 | R:312     | R:344     | R:391
> (faulty commit) | W:154  | W:122 | W:67.7    | W:66.6    | W:67.2
> ----------------+--------+-------+-----------+-----------+--------
> 5.10.10         | R:256  | R:401 | R:312     | R:356     | R:375
> unpatched       | W:149  | W:123 | W:64      | W:64.1    | W:61.5
> ----------------+--------+-------+-----------+-----------+--------
> 5.10.10         | R:255  | R:396 | R:312     | R:340     | R:393
> patched         | W:247  | W:274 | W:220     | W:225     | W:121
> 
> Applying this patch doesn't hurt read performance, while improves the
> write speed by 1.5x - 3.5x (more impact on RAID tests). The write speed
> is restored back to the state before the faulty commit, and even a bit
> higher in RAID tests (which aren't HDD-bound on this device) - that is
> likely related to other optimizations done between the faulty commit and
> 5.10.10 which also improved the read speed.

Can't argue with these numbers, and while this should probably get
fixed up instead, let's leave that for future kernels. I'll apply this
for 5.11, thanks.

-- 
Jens Axboe

