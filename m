Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A2672F8ED4
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Jan 2021 20:07:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727137AbhAPTGs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 16 Jan 2021 14:06:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726273AbhAPTGr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 16 Jan 2021 14:06:47 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 875D5C061574
        for <linux-fsdevel@vger.kernel.org>; Sat, 16 Jan 2021 11:06:07 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id m5so7134416pjv.5
        for <linux-fsdevel@vger.kernel.org>; Sat, 16 Jan 2021 11:06:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=Q5S9A5hSN6OK2jkdC8onzYIcAjQqz9ljUhJQSNopCiU=;
        b=ofgzkeumhQ31AH+DaOz1hPbk+oasRYqSqfozQSwbypqfvhKnrdFnoNrfE0pa+8lXKy
         BtfQiCCS2/CU7zo9o5on7BV8LUP1qjp26SzW1YyaDq+3RiH46GS1q4Vq1q0fxJvJZe47
         ZnljJ1/emajlUi6vE6Jas4mup5vQXLOWLrHKZmLZtTx3iiXVSedpcarZwCihFU08aVwP
         nNOyex++Hzcm019CYi2KiDJuW0nwNkgzsy5PWRoH+nzzPJKOcgQf4XHCUzYdn2TOOpJr
         SQdZySb7Kq/ZibRvd2tB3mEOtxx4rzlz011xsCjvStQKybDa27l2E6XfI9DS2U88SZvT
         X92Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Q5S9A5hSN6OK2jkdC8onzYIcAjQqz9ljUhJQSNopCiU=;
        b=cpJ6cUSE1CcpETAaeHHBie21dJ/uQKPkbp6c0zJFEUJbK1brweIdHSTNNV6qdDS2K2
         nVXTdPGfEKLCLZjyjc+KUcISz2fgb8t3ELtZDgm6KvuPGIOGkLu6TUmeyETsspGH/F5l
         kLr21QsOFInCeWeVqhw7M8hZULiR16Z2+4+4CQRF3QjTPv4h/j7/XN8UCGAQBIKx4EfY
         EQwIX/hWTFP2AGdNUhdmDyCMcIetJ66CBX2Q+rdHxKLzZz54hAhMKO/IpLIZecFkoQvP
         Yt0H83VDreAcoaPve3h59e9BSePsLZR2647Q7GlEwgKrypTHvBkVYXYO+e7dfXPmJBn7
         0kmg==
X-Gm-Message-State: AOAM531EL6EgzsL9EY3T2HKtYMyb46AnqWC8dmu3ceasNhd+L9VCcSco
        2IO+ubko+XfqUKtlvQiopyR5LA==
X-Google-Smtp-Source: ABdhPJy/16+Tkq1kSaSsq3wdAC2u6nss8jxuN656VC1ZwoI1qOQzaXLK3PMvWocaRyTd96keNKEpFQ==
X-Received: by 2002:a17:902:854b:b029:db:c725:edcd with SMTP id d11-20020a170902854bb02900dbc725edcdmr18556127plo.64.1610823966705;
        Sat, 16 Jan 2021 11:06:06 -0800 (PST)
Received: from [192.168.4.41] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id x81sm1770299pfc.46.2021.01.16.11.06.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 Jan 2021 11:06:06 -0800 (PST)
Subject: Re: WARNING in io_uring_flush
To:     syzbot <syzbot+a32b546d58dde07875a1@syzkaller.appspotmail.com>,
        asml.silence@gmail.com, hdanton@sina.com, io-uring@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
References: <00000000000050736105b904f335@google.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <29e3c654-a1ca-e0ca-2af9-948feb5b00b5@kernel.dk>
Date:   Sat, 16 Jan 2021 12:06:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <00000000000050736105b904f335@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

#syz test: git://git.kernel.dk/linux-block io_uring-5.11

-- 
Jens Axboe

