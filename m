Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B205F1AE9B0
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Apr 2020 05:38:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725969AbgDRDit (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Apr 2020 23:38:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725320AbgDRDis (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Apr 2020 23:38:48 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4974C061A0F
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Apr 2020 20:38:46 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id q16so2945614pje.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Apr 2020 20:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=I4TH2XxPoRqCQAiVceMrJ6JF2Ars1jAhN+GkKLq+qBA=;
        b=vDno9PVLultcm6YIs0lgt1nHx8S+GaUz2rUcccr2W+TcwDwEU06i7IFQ6I4FamebXD
         phJTlHBda+hMxHcxYHWBYgZeCPjbDYetGVDyFzosCtx5Kkm0pbH6cNvXYSJtINDqJV+X
         c3L+ZeP2HXsJuA9wEK3GRMWt39segDCz7I8GCMzYBaRUwPwuM3drd4leZiDbOMs3hyiq
         tFFbp+eZEv16CUzpFED47BkVxtMalx9qV1aUp1lkR36Pj3kk6KVt1RR61U/TxSdRwMg1
         GwBhcrimkOAEsQNynzGmMyIZooleRS9aES8XVSbSMmA4LiOS+YOC/AMbyzKHwa59jLLZ
         fgKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=I4TH2XxPoRqCQAiVceMrJ6JF2Ars1jAhN+GkKLq+qBA=;
        b=M1QdKgD5CZ7NPULUGbxemKCRnY+4gGtyFnGpuyg1f+FNutfNmeVGXOjYLTXiCfvFxV
         /orDh2Hu4ifHBMIz/f4m+g0JXAIxgil130RXdcczrXCsH4o0YC2WWEHJT4uAgKtfL59W
         2wR4ujxxM2Cc/Ffnq4Txb5FuzIqHC71x923y3+I4FtL5m1EnLKYp2ZSbct6mTyiznS3h
         hMvNl/OYvg8JYN197fIUXyEkX3qlL1VNVv5CJeB9XB4dYoUYvt7gwLumGLCBfoi1B5X/
         A8LhvCh9PiTMck/OQ0ZagV10DmPcfOwNW15YeX4tZx/0NP/Qea+Y1waSnYDuadGqbBfA
         Vdvw==
X-Gm-Message-State: AGi0PuanW7jS1/2hC9qH+BO6W+RYbmd0trYgoJoWXA4G9fadIpd0yg9a
        wcYgfCZNJ3lOkH/kpoUCJWxljQ==
X-Google-Smtp-Source: APiQypLVBWWqIZPFDHrZdz3nEmonR54iAxMsEDZEg3slo2Uc8dj6KskFX3WRuoEZhT7ee8FI9ehJCQ==
X-Received: by 2002:a17:90b:2388:: with SMTP id mr8mr8078215pjb.107.1587181125903;
        Fri, 17 Apr 2020 20:38:45 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id v67sm17068790pfb.83.2020.04.17.20.38.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Apr 2020 20:38:45 -0700 (PDT)
Subject: Re: [PATCH] buffer: remove useless comment and
 WB_REASON_FREE_MORE_MEM, reason.
To:     Zhiqiang Liu <liuzhiqiang26@huawei.com>, viro@zeniv.linux.org.uk,
        rostedt@goodmis.org, mingo@redhat.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org
Cc:     jack@suse.cz, tj@kernel.org, bigeasy@linutronix.de,
        linfeilong <linfeilong@huawei.com>,
        Yanxiaodan <yanxiaodan@huawei.com>,
        Mingfangsen <mingfangsen@huawei.com>,
        renxudong <renxudong1@huawei.com>
References: <5844aa66-de1e-278b-5491-b7e6839640e9@huawei.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <f8fb1248-3e92-c1da-88c5-bd6220d1f3d4@kernel.dk>
Date:   Fri, 17 Apr 2020 21:38:42 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <5844aa66-de1e-278b-5491-b7e6839640e9@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 4/12/20 11:12 PM, Zhiqiang Liu wrote:
> From: Zhiqiang Liu <liuzhiqiang26@huawei.com>
> 
> free_more_memory func has been completely removed in commit bc48f001de12
> ("buffer: eliminate the need to call free_more_memory() in __getblk_slow()")
> 
> So comment and `WB_REASON_FREE_MORE_MEM` reason about free_more_memory
> are no longer needed.

Applied, with:

Fixes: bc48f001de12 ("buffer: eliminate the need to call free_more_memory() in __getblk_slow()")

added.

-- 
Jens Axboe

