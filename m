Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EDA121B1F0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jul 2020 11:05:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbgGJJFQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Jul 2020 05:05:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726496AbgGJJFQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Jul 2020 05:05:16 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8BD5C08C5CE
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Jul 2020 02:05:15 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id q4so5626800lji.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Jul 2020 02:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VUmFAc962e5K337BfXwFy3uOoKxsKlxWlo6RdFjoWeU=;
        b=fAutD3cY5ow4YDV5uFTnEihRtuC7Y68t5bQaAcEGwzsqiN3yEk3pVzn5mMwLm0lOmL
         VSSvAUFBBhFsy6dQskJH1YPZX9Lx3irhJqVRTFkBdnN8OkHOoKmubOCN0Qrt+lsu2KfL
         63RF42ZenfvJ1bMQEXzT4IVxvDFOA2BE2kLwo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VUmFAc962e5K337BfXwFy3uOoKxsKlxWlo6RdFjoWeU=;
        b=JyCudQD915rPWjY6+ZwLefmu6n1qSXJvR+cpBvgHGVaRe8G+mnUrWmtiQe47WVhEBx
         xizaI4gdGjzLYukcWhbSUbmXCMt1pbQjTPBkT1xXOTw72ZHJPiTGKid3JDL3ZsfkoDWO
         xyPKCiTJ/orsCpVlNTwvNcNJihD2RsFTkENKa/zfx40+D1rGocSt/hp0gSqMKmpENN+O
         BDMfofxHTGyUKYvJCLv9+KDCeDODteMT5kdYRAFQuRu1nfGAK9BgvQdv72VKRJPL9vP5
         QoA4We+p2O4ehlZqVS0DpcvGuRBUPjGyCU7fxdLYdMm24E6KPD11gXUvaojvxBjo0nff
         gZrQ==
X-Gm-Message-State: AOAM531Du64Z0+2/+AFvJTKlNMoPxE2iuBHZHm1O7IvH2hYhn2gECC9p
        dBHpsZWMrvmD7le4lY3BIKaGxNUevCrlDx1E
X-Google-Smtp-Source: ABdhPJyfIcP/PQ2s2693hklug7eNZqe5piHixI/UWoYEV5w5FplqjvG+6fc9SV7PjhrnOvGJY/ELSw==
X-Received: by 2002:a2e:8e8a:: with SMTP id z10mr30448109ljk.351.1594371914312;
        Fri, 10 Jul 2020 02:05:14 -0700 (PDT)
Received: from [172.16.11.153] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id q1sm1687890lji.71.2020.07.10.02.05.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jul 2020 02:05:13 -0700 (PDT)
Subject: Re: [PATCH] kcmp: add separate Kconfig symbol for kcmp syscall
To:     Cyrill Gorcunov <gorcunov@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200710075632.14661-1-linux@rasmusvillemoes.dk>
 <20200710083025.GD1999@grain>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <14b4a1f0-3caf-75e4-600a-3de877a92950@rasmusvillemoes.dk>
Date:   Fri, 10 Jul 2020 11:05:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200710083025.GD1999@grain>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/07/2020 10.30, Cyrill Gorcunov wrote:
> On Fri, Jul 10, 2020 at 09:56:31AM +0200, Rasmus Villemoes wrote:
>> The ability to check open file descriptions for equality (without
>> resorting to unreliable fstat() and fcntl(F_GETFL) comparisons) can be
>> useful outside of the checkpoint/restore use case - for example,
>> systemd uses kcmp() to deduplicate the per-service file descriptor
>> store.
>>
>> Make it possible to have the kcmp() syscall without the full
>> CONFIG_CHECKPOINT_RESTORE.
>>
>> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
>> ---
>> I deliberately drop the ifdef in the eventpoll.h header rather than
>> replace with KCMP_SYSCALL; it's harmless to declare a function that
>> isn't defined anywhere.
> 
> Could you please point why setting #fidef KCMP_SYSCALL in eventpoll.h
> is not suitable?

It's just from a general "avoid ifdef clutter if possible" POV. The
conditional declaration of the function doesn't really serve any purpose.

> Still the overall idea is fine for me, thanks!>
> Reviewed-by: Cyrill Gorcunov <gorcunov@gmail.com>

Thank you.

Rasmus


