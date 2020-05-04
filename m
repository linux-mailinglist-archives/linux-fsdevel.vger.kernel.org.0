Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB7E01C3BAD
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 May 2020 15:48:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728808AbgEDNsB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 May 2020 09:48:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728801AbgEDNr7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 May 2020 09:47:59 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0098AC061A0E
        for <linux-fsdevel@vger.kernel.org>; Mon,  4 May 2020 06:47:58 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id mq3so3888469pjb.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 04 May 2020 06:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=Rg9UJJZ2W+/6S6MT1yhRF1ts3Ydv5puORxZkSnYHZRI=;
        b=H+GI6QH7GVmDJt9eR5e3WijVO2f2YgUQwIhVzCHRTk48F9Zye6P94vp8XXB6uvbUFZ
         qb7kz6M0lu8AjoQ0nx42BHznddNfwoCWOvaurhJJ6WbIZTX6RUZaBpeuKaFv6+Qvwqpd
         6BPL4gJqV6q3lrNiUJY1c6ccc46SW8R8FERPrNPiyfQyedEj9QSpDi7VxAxjB9FSTkDF
         H0sx8Qbo8EkV/QZM9xhttl8qeCYARH2Tr5pibQ3Y6MGB9Ew590BRnWO/zzIcAOb2ZS4n
         T/SNCgDp4ZxIszIldbtusRlvPZNOlCqBmsQWwTlLuFYiN04oLaOv+tWLQpHwAuMx4IVF
         k0qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Rg9UJJZ2W+/6S6MT1yhRF1ts3Ydv5puORxZkSnYHZRI=;
        b=cbFSS2pC6Vl2d8b2pD4NI4TQsenHBRkWpCht3JHkq2lwiB6uv/3RTgEVkfZdl8s1ud
         GU5v/PAMpukKn2sa8v2En4KAD8gg6BtVTU40zQK6Y+newSUxQFPJ9phpxf1z6ov4XVJw
         rf9vwS78L1ecgTO5sXGLL0QOTH12dla0r8fRVBNa7QzvRUZSNpEAoT+68hJ4240BIIjC
         VD4XgDPpHJ882TFaMg2p2sFyWe7bfBVOFxBmLVcBf869nz2MWYOzy5+NajoLfV8SsJr1
         4DDNmQe5jb/vhJGLUr6XOt6qGoiYFNkTerImvoALoH/VI+NKx6Wm6aNHtSEJkalvfTYD
         G4hw==
X-Gm-Message-State: AGi0Pubwlcb+kk/Uj8iAK6+ttUSjBmGoZk1i9vdqQ9zqm3yOkV7B5M2N
        Ul/1d4zshhcEME8U/dxmPInc1g==
X-Google-Smtp-Source: APiQypLp6xInEdHrkCM7w6jc80BQxPrij8GCaCtwruE5LFklNlcGU79ZnBD6dQ7m0iXCPMxhm3LB8A==
X-Received: by 2002:a17:90a:8d01:: with SMTP id c1mr17221288pjo.170.1588600078528;
        Mon, 04 May 2020 06:47:58 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id r78sm8909979pfr.10.2020.05.04.06.47.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 May 2020 06:47:58 -0700 (PDT)
Subject: Re: linux-5.7-rc4/fs/io_uring.c:2786: bad if test ?
To:     David Binderman <dcb314@hotmail.com>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "io-uring@vger.kernel.org" <io-uring@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <DB7PR08MB3801F4B9DD818545A8DA6CC99CA60@DB7PR08MB3801.eurprd08.prod.outlook.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <529ea928-88a6-2cbe-ba8c-72b4c68cc7e8@kernel.dk>
Date:   Mon, 4 May 2020 07:47:54 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <DB7PR08MB3801F4B9DD818545A8DA6CC99CA60@DB7PR08MB3801.eurprd08.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/4/20 2:12 AM, David Binderman wrote:
> Hello there,
> 
> linux-5.7-rc4/fs/io_uring.c:2786:6: warning: Identical condition 'force_nonblock', second condition is always false [identicalConditionAfterEarlyExit]
> 
> Source code is
> 
>     if (force_nonblock)
>         return -EAGAIN;
> 
>     poff_in = (sp->off_in == -1) ? NULL : &sp->off_in;
>     poff_out = (sp->off_out == -1) ? NULL : &sp->off_out;
>     ret = do_splice(in, poff_in, out, poff_out, sp->len, flags);
>     if (force_nonblock && ret == -EAGAIN)
>         return -EAGAIN;
> 
> So the second return can never execute. Suggest code rework.

Looks like that's a leftover of the "only punt sometimes" code. That
second one is indeed dead now, Pavel is re-working the async punt
for 5.8 anyway so I don't think it's worth touching at this point.

-- 
Jens Axboe

