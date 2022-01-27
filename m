Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FE8E49E621
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jan 2022 16:34:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237837AbiA0PeQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Jan 2022 10:34:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234154AbiA0PeP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Jan 2022 10:34:15 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 649C8C06173B
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Jan 2022 07:34:15 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id d138-20020a1c1d90000000b0034e043aaac7so3594614wmd.5
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Jan 2022 07:34:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=embecosm.com; s=google;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DNE+5BFtlKi2Kr5x/uLwXLqdr57iuRQ85gAjFIgeb+Q=;
        b=FNH1UVpBVLyYTqPTeY9w124cr19PvxcVA41tqaP0xiAya41dqgfEYKDr5IDsnd5Mo/
         Bt9+7c3/nsZi6X9shbasDYXvfpikPbTdzMqeQGpgzP6D7DIwsfDJYnSn+WcVVV5xCKyh
         8II+IHtevtDc0Rc6m0xzW6doqAatkBNkNXRaXvoeayqlbK8EX4r0gDe7yD85yZR0Rrtp
         +1Qfz0p2dQAqXrxSOsDX5TxT/eDUGsblNwZF4O4VPAHFjtNl2f2iDw0A5CHJgB6SQdfB
         EGdzdH6DrDa5Im5PdUR/TT0DhzUePLjTTxAtBwGaSXy/5tKjb6HOzJ8yk1cuea3CtlFt
         f5rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DNE+5BFtlKi2Kr5x/uLwXLqdr57iuRQ85gAjFIgeb+Q=;
        b=lATZDAH6jLJGF2APF/QHYXqfPVn2kgBeMv5ItpiWbbDsc91ixXY3fDF8HyV4/9Z/bz
         7dFznj+tgHHogV3hyrxSJm5yKuH8sy7y1RD8001okXaOoyvD6RbM59Tr8e1lshUnURAr
         Ez7M3Q/nekaBuK0JOk8AeBRytXuDc1QVR1o1ey5hGXdwwEUpOATd2uKNKLnZIDpQ5/p5
         F2a2Hzw8QawMgLmAvTm0HnxU6QnoXavJ/zqeAb53i5LcMknONe9kJK55bPVVIJJZbMxt
         V4Wu98ZZsBi05hFZPmNyvgSrQNRklVceb3ZEaDmnz7e5PCMwawgOcG/hXOjyy45QhUFe
         RqVw==
X-Gm-Message-State: AOAM5324UmjmSLMRlUAyMu5Hc+mdWQe1gdQdtbtp+tQP7epv9iqaaXEo
        q/A3dEqXd2vsf07IkFIAzZWaosb5eTUbJA==
X-Google-Smtp-Source: ABdhPJzN8mEQmC9/NB1YIK8aAMojdtMHjSg6rYIWkIbstaSuTFlfDIlsmGdWAN2IZtYjXTRobCt3Qg==
X-Received: by 2002:a05:600c:264d:: with SMTP id 13mr3681311wmy.85.1643297653690;
        Thu, 27 Jan 2022 07:34:13 -0800 (PST)
Received: from [192.168.88.236] (79-69-186-222.dynamic.dsl.as9105.com. [79.69.186.222])
        by smtp.gmail.com with ESMTPSA id r2sm3650409wrz.99.2022.01.27.07.34.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jan 2022 07:34:13 -0800 (PST)
Subject: Re: Help! How to delete an 8094-byte PATH?
From:   Maxim Blinov <maxim.blinov@embecosm.com>
To:     Matthew Wilcox <willy@infradead.org>,
        Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     linux-ext4@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
References: <d4a67b38-3026-59be-06a8-3a9a5f908eb4@embecosm.com>
 <20220127122039.45kxmnm3s7kflo6h@riteshh-domain>
 <YfKg3DQS0h2lPo3z@casper.infradead.org>
 <a57e2fde-f430-952d-9878-d7a5307cb2db@embecosm.com>
Message-ID: <e2ab3266-3dfe-3fb2-0bfe-fd2c2b10e635@embecosm.com>
Date:   Thu, 27 Jan 2022 15:34:12 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <a57e2fde-f430-952d-9878-d7a5307cb2db@embecosm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

...Oh dear, I think I may have been extremely stupid: This entire time I
thought I was typing into the QEMU VM, but in actual fact I was typing
into the docker container that contained it.

So this wasn't an ext4 issue at all, but a limitation of whatever
filesystem docker containers use.
