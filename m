Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 41A8C14499A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jan 2020 02:56:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727590AbgAVB4C (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Jan 2020 20:56:02 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:50549 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726396AbgAVB4C (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Jan 2020 20:56:02 -0500
Received: by mail-pj1-f66.google.com with SMTP id r67so2318337pjb.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Jan 2020 17:56:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ughD8EkfzZ2MT9taNPpfqufT1vIfrbzj2d5lhoDdcCs=;
        b=xg6QbYvQI8Lcp3eyVvMHPQjo5nOSDbFcfnYJPf7c4tc4M68KNnggamZ05z0iPvQ6Tz
         oZRfs8nHGynhSz/3eOxGfNmxZM1kwjPwZwvQV2BGqUP3i/OZo/PI2BQHgL+MMAalMie6
         LjiGfByiRHSh1xSWJ8xeXBZTYdXmFzIPpSFaFRnEHrbpE52buXvhuTzBMFxHfcmem7Cz
         n8GPqQGJ4O0dZ/1r7DALHyfTy+h/WEa1BsmK3bmIXkdE9kzNXBVnsy+eeEhjeh0PoAuh
         g8gm++dFXs9PEqIsVEDP+LLsRPzklv/oDqNoLtix0WwNnlEp+ulMD8/33Mib1fc/qlJ/
         NMzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ughD8EkfzZ2MT9taNPpfqufT1vIfrbzj2d5lhoDdcCs=;
        b=rVfLRzqDCUycbESW8roYsya1kfDRXHPnLSzlltIs3jTPcJVDHP7gPaicegP6IpZ2C/
         9/EQOlApwpRMu0DLy3ZJ9CzGW2BMlUD42yQL8HsZ2l+7HJQbwHpIBPG61DpFhrW6LjyZ
         kpRi1s1b43RVrNShQS26fzeaTMf4J0poenwKH+qIk11fDFdZ43TAzmGlB5sij0dw9uTT
         NeIpkpmhTzF9qWSIIgR4EkI8Hpp8T2BgmX9Q0qGRs08alEcH6gCAOGRBu6JNb2LWWXoP
         Irwno4pj6Qmz+KbC7/UECIDCsTxhOBKhYrLdPLp2kV601xtpDe7fzXNK0BeqO2J+V4Dq
         RAMA==
X-Gm-Message-State: APjAAAWToT8KnZNZ3tZ0enpss8owvV395Sk+qZ7+gm5Y5C0YmjaY/nNM
        j0W/KEfNjQahcaYXikbk1nQXkQ==
X-Google-Smtp-Source: APXvYqwa8UKyJwV77XoBvUAWxuZJ8PJJ53EHBLJTOfOLb2DJYwRJN7ZRS5CUg7lkEkhIx6E7ZnhWHg==
X-Received: by 2002:a17:902:9f98:: with SMTP id g24mr8564576plq.325.1579658161685;
        Tue, 21 Jan 2020 17:56:01 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id 3sm678609pjg.27.2020.01.21.17.56.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jan 2020 17:56:01 -0800 (PST)
Subject: Re: [POC RFC 0/3] splice(2) support for io_uring
To:     Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>
References: <cover.1579649589.git.asml.silence@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <63119dd6-7668-a7bc-ea24-1db4909762bb@kernel.dk>
Date:   Tue, 21 Jan 2020 18:55:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <cover.1579649589.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 1/21/20 5:05 PM, Pavel Begunkov wrote:
> It works well for basic cases, but there is still work to be done. E.g.
> it misses @hash_reg_file checks for the second (output) file. Anyway,
> there are some questions I want to discuss:
> 
> - why sqe->len is __u32? Splice uses size_t, and I think it's better
> to have something wider (e.g. u64) for fututre use. That's the story
> behind added sqe->splice_len.

IO operations in Linux generally are INT_MAX, so the u32 is plenty big.
That's why I chose it. For this specifically, if you look at splice:

	if (unlikely(len > MAX_RW_COUNT))
		len = MAX_RW_COUNT;

so anything larger is truncated anyway.

> - it requires 2 fds, and it's painful. Currently file managing is done
> by common path (e.g. io_req_set_file(), __io_req_aux_free()). I'm
> thinking to make each opcode function handle file grabbing/putting
> themself with some helpers, as it's done in the patch for splice's
> out-file.
>     1. Opcode handler knows, whether it have/needs a file, and thus
>        doesn't need extra checks done in common path.
>     2. It will be more consistent with splice.
> Objections? Ideas?

Sounds reasonable to me, but always easier to judge in patch form :-)

> - do we need offset pointers with fallback to file->f_pos? Or is it
> enough to have offset value. Jens, I remember you added the first
> option somewhere, could you tell the reasoning?

I recently added support for -1/cur position, which splice also uses. So
you should be fine with that.

-- 
Jens Axboe

