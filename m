Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC4AD28E4F9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Oct 2020 19:02:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731120AbgJNRCM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Oct 2020 13:02:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730009AbgJNRCM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Oct 2020 13:02:12 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC908C061755
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Oct 2020 10:02:11 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id k21so2274594ioa.9
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Oct 2020 10:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=1FmEIkrqfL0T3fOHDc6OHU2lmhTkM3AhohF3xQ/xB7E=;
        b=nCDOAyyXhiRZZz7rZ9wEUHslojMwI/MOxw3Lqtua2iKHYhXaotVSr69c6pqSs3JDno
         rbr5GpWiK0EIzhRtNZ9JiywfQClnnP2K4YumKU0T1RM048fq9rOlrkCw/hKjK9omGufF
         b7/VGcG7jMw8dHgKIeFxZnexkgwDEQyf2fBRXWWPqLse5diN0XaK8n4ux1Jsp4OImgbF
         BUHvFyPwqLDJRpSHpQXTEi9YJw6YGFmJR3mtFhPKyQXo2ZC5l6zhLLWW7tMIWGg2kz9C
         p/q/mXzv/8HGDQfX7cD8HoderJFuPXQJXMGxpKj8yxJX58xe1QGCWilXPbbc03Dx6GRr
         VJIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1FmEIkrqfL0T3fOHDc6OHU2lmhTkM3AhohF3xQ/xB7E=;
        b=SelU9WoNqJwFaRP0oHdGDdgkcPiLjSCGcoTceTQivQmwvD03fFOkrf5pvtqMLdCN7W
         zTMMACiMTfh/XErsAETC4uncPCCOb41zQUpQE5IG5wtjrmBMfj/Zl64NwFQXg7u94/5f
         TzNXxWoFHrUY07MnxJIqgdoyo64+mDlb3R1k7Ivz1Q9jPi1Ad0UnujF2dVp6lL6B+k5F
         /e9VL0QLSZT9432Cdy84H1V/u0XDUpG+d0D3uvrt5YarJywIJXSfIP2Z1YUvL42Rerfq
         JoDqHmkFOW72uqd6E1NHNQQbOAniMyjCr3emuO7vH3bUQBrPVqQxXZEqLXqQsOfYhaMq
         Ovrg==
X-Gm-Message-State: AOAM53034VTTI7dw1x//lSAcwG69TkAneUQ0CX4VGjzUyuyhH9w08rwL
        wAGAly5zh6mlkPN9V85Clwu68A==
X-Google-Smtp-Source: ABdhPJzhd+/16ZvJiUYYfs9WNkd1c88ZyLGztYQfhm8605zQRwoONNTABR+sxO8FM05H4pLYKZakxg==
X-Received: by 2002:a05:6638:dcc:: with SMTP id m12mr395388jaj.30.1602694930981;
        Wed, 14 Oct 2020 10:02:10 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id n9sm2447180ilj.74.2020.10.14.10.02.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Oct 2020 10:02:10 -0700 (PDT)
Subject: Re: general protection fault in __se_sys_io_uring_register
To:     syzbot <syzbot+4520eff3d84059553f13@syzkaller.appspotmail.com>,
        io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
References: <0000000000000c3be205b1a4782f@google.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <7fccdc0f-bcd8-505d-f0dd-672471be30f6@kernel.dk>
Date:   Wed, 14 Oct 2020 11:02:04 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <0000000000000c3be205b1a4782f@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

#syz dup: general protection fault in __do_sys_io_uring_register

-- 
Jens Axboe

