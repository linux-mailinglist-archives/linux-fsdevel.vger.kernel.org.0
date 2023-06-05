Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ECB1722CF2
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Jun 2023 18:50:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234910AbjFEQtv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Jun 2023 12:49:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234821AbjFEQtn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Jun 2023 12:49:43 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A2BEE8
        for <linux-fsdevel@vger.kernel.org>; Mon,  5 Jun 2023 09:49:40 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-65c6881df05so199297b3a.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 05 Jun 2023 09:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1685983779; x=1688575779;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vDRJgVE5cH04MV15lyuR8QwAmByzpL4hoF/MQxP+aCo=;
        b=Ei/LRpe8k3OFfTc/VkSB/xDKar7hPdfukU8UV74asVwDhnlUFq6MoQI77JP70KYzqT
         VwpJl9HpmDuXDVX1DG5iZIqF/6J0ErGIY41R19KPoHLnjeF8Gi/FH+8ghj3XB7T03WtI
         VbLYFEUH+p2Nzqh1DTfqkDDmh9kocKybhx0WRy0HA3aWOsXcDYaCCXp4LYMtUQeiTQtK
         orgN2Q+rMlNc3hqMCgoH+0O7l62JNW3r+LaORs4nvGiuhPO4WFjgX1qrLHxZZ1AaVx5K
         KZzSB9g5huWomew3qr9ttRdjb7Gs9g0f0THUtsddtKNSSubwcD1aRda+VpW2odzfxL/L
         j0IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685983779; x=1688575779;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vDRJgVE5cH04MV15lyuR8QwAmByzpL4hoF/MQxP+aCo=;
        b=YXbwAVvb+I6CsKzdotk7v3dTARlD/Vf0KONILeQ9EXTtoPfkE7d/WTqqwbD/AWNiXv
         WcviNX8MyskIFDKtag9dz7C7sGDCFyy1kJeyD1fsyDBCvosD1lyZkX5/eEUKKx7207OC
         phZl7S0DfnXF7FxIIEcZCd0Qn8wSYcniYXyaCk9AgY3Hf8LFlPfbXXtvSbl2xFOhhFlJ
         9r/AHUrsYyXiFGI76sk+t9jbbCuufVJbOLo5zla3m8y4Ok1T7pesNNKlQXjdgSj99pQd
         1Co/kzQPI9gdjMTZ54QicfeHkivssLpSAt/4+sOko5U0Gp7arHsEFGIuYEdfrDkTp/2J
         Giqg==
X-Gm-Message-State: AC+VfDxIh4jFSmRBTQw88vnqSSvHDPAfPZGDd1L8kjHKbGkcDXLMWBAX
        O4T2zNml2O84omUhbw3lRYujzmiwEscA20srniE=
X-Google-Smtp-Source: ACHHUZ6VtRPk+7R/QDfHd2G8LTg/K3iK/fpK4MXqyEZASfsbZ7S8d8CBo4OHEHv2VzEDz6LQ7MPerA==
X-Received: by 2002:a05:6a20:4425:b0:116:1cc7:ada with SMTP id ce37-20020a056a20442500b001161cc70adamr4482199pzb.6.1685983779369;
        Mon, 05 Jun 2023 09:49:39 -0700 (PDT)
Received: from ?IPV6:2600:380:c01c:32f0:eff8:7692:bf8a:abc6? ([2600:380:c01c:32f0:eff8:7692:bf8a:abc6])
        by smtp.gmail.com with ESMTPSA id x24-20020aa784d8000000b0064fd8b3dd14sm5404414pfn.124.2023.06.05.09.49.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jun 2023 09:49:38 -0700 (PDT)
Message-ID: <b1b43d30-8c7c-1a71-0ead-8b967b8af0a4@kernel.dk>
Date:   Mon, 5 Jun 2023 10:49:37 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 0/7] block layer patches for bcachefs
Content-Language: en-US
To:     Kent Overstreet <kent.overstreet@linux.dev>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <20230525214822.2725616-1-kent.overstreet@linux.dev>
 <ee03b7ce-8257-17f9-f83e-bea2c64aff16@kernel.dk>
 <ZHEaKQH22Uxk9jPK@moria.home.lan>
 <8e874109-db4a-82e3-4020-0596eeabbadf@kernel.dk>
 <ZHYfGvPJFONm58dA@moria.home.lan>
 <2a56b6d4-5f24-9738-ec83-cefb20998c8c@kernel.dk>
 <ZH0gjyuBgYzqhZh7@moria.home.lan>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <ZH0gjyuBgYzqhZh7@moria.home.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/4/23 5:38?PM, Kent Overstreet wrote:
> On Tue, May 30, 2023 at 10:50:55AM -0600, Jens Axboe wrote:
>> Sorry typo, I meant text. Just checked stack and it looks identical, but
>> things like blk-map grows ~6% more text, and bio ~3%. Didn't check all
>> of them, but at least those two are consistent across x86-64 and
>> aarch64. Ditto on the data front. Need to take a closer look at where
>> exactly that is coming from, and what that looks like.
> 
> A good chunk of that is because I added warnings and assertions for
> e.g. running past the end of the bvec array. These bugs are rare and
> shouldn't happen with normal iterator usage (e.g. the bio_for_each_*
> macros), but I'd like to keep them as a debug mode thing.
> 
> But we don't yet have CONFIG_BLOCK_DEBUG - perhaps we should.

Let's split those out then, especially as we don't have a BLOCK_DEBUG
option right now.

> With those out, I see a code size decrease in bio.c, which makes sense -
> gcc ought to be able to generate slightly better code when it's dealing
> with pure values, provided everything is inlined and there's no aliasing
> considerations.
> 
> Onto blk-map.c:
> 
> bio_copy_kern_endio_read() increases in code size, but if I change
> memcpy_from_bvec() to take the bvec by val instead of by ref it's
> basically the same code size. There's no disadvantage to changing
> memcpy_from_bvec() to pass by val.
> 
> bio_copy_(to|from)_iter() is a wtf, though - gcc is now spilling the
> constructed bvec to the stack; my best guess is it's a register pressure
> thing (but we shouldn't be short registers here!).
> 
> So, since the fastpath stuff in bio.c gets smaller and blk-map.c is not
> exactly fastpath stuff I'm not inclined to fight with gcc on this one -
> let me know if that works for you.
> 
> Branch is updated - I split out the new assertions into a separate patch
> that adds CONFIG_BLK_DEBUG, and another patch for mempcy_(to|from)_bio()
> for a small code size decrease.
> 
> https://evilpiepirate.org/git/bcachefs.git/log/?h=block-for-bcachefs
> or
> git pull http://evilpiepirate.org/git/bcachefs.git block-for-bcachefs

Cn you resend just the iterator changes in their current form? The
various re-exports are a separate discussion, I think we should focus on
the iterator bits first.

-- 
Jens Axboe

