Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EBA42B8376
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Nov 2020 18:59:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726211AbgKRR64 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Nov 2020 12:58:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbgKRR64 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Nov 2020 12:58:56 -0500
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66567C0613D4
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Nov 2020 09:58:56 -0800 (PST)
Received: by mail-il1-x135.google.com with SMTP id n5so2793381ile.7
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Nov 2020 09:58:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=RHM44Z31TODI36NU69HtGTSe77AacSdaBSQlZ2dh504=;
        b=iVRwUUiu7byXatmGf++o0AyVyDx1MQvIrJACC2AIzhZyyp8WqpUBGs14xhkns7EWjB
         jkFnG7cfoGjYeC3mgjgvQ8HUn9pA4Nce5vdFIgGwRSAXFTyflZttYGi8ItsadadGqGbx
         P0YDjf0ZigbYU/sTCc7AZ0xiMA7ALYeETcIXU+nNeNeqhVo2rKE0TU7YqPiTIOrkW3Hx
         i0ydrImwhfDeUxhWBLp/QeI7EsoGVYqh/CpUUuNG6iMmHLXKD5dsDp6kJf/5nJnIenyZ
         qcaPUcLDhuexwkaNnUljaN2XVnpAtaqxEge+e4kzSLTD3xxM6P9TygcPU1wUFKtgNlGB
         bKrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RHM44Z31TODI36NU69HtGTSe77AacSdaBSQlZ2dh504=;
        b=JztTAojXQIfLQX88uliKDQhOo9ottGi4FSN81BGKydMixWnbADW8SVx1OcIUPJpuRP
         4JXcwOxHabkszAD1h4x70pedRqxvdDuG0pNJgaX2poh0QNbT4bT8pNvnclPofpLwRp0Q
         eWpDmCmnmi2nnB9LF5MNdY+VU0GdbNDtez2n4usG2LNTUMQV1WG0k1vnOeQli8LS2WHc
         7lNilXOjlAQ7F5A1wH3N50j1ROo8AGtzytRMFnW3AnvbVuJO8FwD21jxByHQIxbZ786k
         1vzf6I0PgfOBIM56O5iUyJzPiEptDTe6HM6hp6GHHf3psRo+PqD7aN3r1UC1A9cXXeID
         MYVw==
X-Gm-Message-State: AOAM5329ZgX7rSYSmFKoknFpqO6T3KC6Ki8+jCQJr8rNkp52CMezbbdV
        8BkQP4XzNzCV+47szru0kIoGeTuAz2Dy+Q==
X-Google-Smtp-Source: ABdhPJxfwFRR1SLojQ3KKE3pug8dRlj88nDvok5Zl2mi48hZHoqSW0y/Eq4zHC6qyDgBniyKUSa33A==
X-Received: by 2002:a92:5f03:: with SMTP id t3mr18332882ilb.25.1605722335675;
        Wed, 18 Nov 2020 09:58:55 -0800 (PST)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id o3sm13877329ilk.27.2020.11.18.09.58.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Nov 2020 09:58:55 -0800 (PST)
Subject: Re: INFO: task can't die in io_sq_thread_stop
To:     Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>,
        syzbot <syzbot+03beeb595f074db9cfd1@syzkaller.appspotmail.com>,
        io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
References: <00000000000038569805b4211287@google.com>
 <39be8d01-6550-ee8a-5a8d-2707b372b711@linux.alibaba.com>
 <d57f9c10-e640-08f5-4c20-2553768aff65@linux.alibaba.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <f082f65d-85b0-5226-2070-d0d01f160faa@kernel.dk>
Date:   Wed, 18 Nov 2020 10:58:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <d57f9c10-e640-08f5-4c20-2553768aff65@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 11/17/20 8:27 PM, Xiaoguang Wang wrote:
> hi,
> 
> A gentle reminder, in case you overlooked this syzbot report.

Did see it (and your reply), was hoping you'd send an actual patch
for this (nudge, nudge).

With luck, maybe we'll see a reproducer out of syzbot at some point too.

-- 
Jens Axboe

