Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D510B6CAE56
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Mar 2023 21:15:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232572AbjC0TPO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Mar 2023 15:15:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232689AbjC0TPC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Mar 2023 15:15:02 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF5E14491
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Mar 2023 12:15:00 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id f14so4340478iow.5
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Mar 2023 12:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1679944500; x=1682536500;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Gc0kPHgFhqGD4+6CsUqo9diRoTcQe86/wTkqbD4xO6g=;
        b=tqtItl50l6xUObsUGXu8lWTm3ivgn7JyNbl+NhAjN+DcsnpvED51wpp1HF4tfjsfBF
         Y4+M1/e62ggDIleeg6XDeRbFGP4ySNO9ejLt90a5oSLJbjotr+sTvirOiY1jy0YK/TBc
         fGOFkDaxKmYrUOGYqAdMOabdgjrufs0tp/uroTqpPxUqzeMN6wgneOd567cqmShIf90w
         UADfABqfOt1vdH5rKM1ymThViFCKATbLLGBtPscKhA5ejBwF09u9NHPcxS3RUtvVj4KJ
         kxhGcDAKeATKB5uJhzfDf6DRcgCShIqP9+zMsKLmDp8/A9OcXQt9BTeRU6Un79aeEZnL
         eMjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679944500; x=1682536500;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Gc0kPHgFhqGD4+6CsUqo9diRoTcQe86/wTkqbD4xO6g=;
        b=pnxqD/JlTzlaX+P5OYW1/cVzn6SL5xjBSndtX+ja3fG48ONDPZZMhoCbIpBBZ8wiTs
         5iQODcZ1ZkyJcP4ktGB144rHryF9E3LrUB6xwwY02qbdv1WuJU2hcoFsRSXDgEtarAbT
         K9jpOqp+UdCN/21qZ8kXw9epm/GhT1MPbW0DPcIWTsM2EK22gYn7yn8nH7HlMlPQ+8SG
         /5D37iN4kWt5TtLuOKMaU31yNbJ0Sx4QmH+FTVFdcHcWTawqQhIFM4ZaanrHL4z1mhHh
         f/Uf5bGmnLWGCI5TeSmszUfMAqzEIqVZ9m3OgLe755jd9j0V8XAfibyVGoA/NDPwQVYs
         KMsg==
X-Gm-Message-State: AO0yUKWKvjro99cPEqdzKOYuTTgwrEmQqbDyjdM3gCAVC2br7dA+zHqZ
        0WakZlk1P3uR8shhJrqOfwdIQw==
X-Google-Smtp-Source: AK7set+qEedkv2uucGVVAcWe2kciqaWELVhKkNfdWXJXNOB5kKSquIciCu4A9/npkNnOxIREY5wdNg==
X-Received: by 2002:a05:6602:1246:b0:758:5525:860a with SMTP id o6-20020a056602124600b007585525860amr7296575iou.0.1679944500290;
        Mon, 27 Mar 2023 12:15:00 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id g13-20020a02270d000000b0040306bfd949sm9357539jaa.21.2023.03.27.12.14.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Mar 2023 12:15:00 -0700 (PDT)
Message-ID: <e22b2971-ee51-a84f-908e-0aaba250452d@kernel.dk>
Date:   Mon, 27 Mar 2023 13:14:59 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 1/4] fs: make do_loop_readv_writev() deal with ITER_UBUF
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, brauner@kernel.org,
        viro@zeniv.linux.org.uk
References: <20230327180449.87382-1-axboe@kernel.dk>
 <20230327180449.87382-2-axboe@kernel.dk>
 <CAHk-=wh4SOZ=kfxOe+pFvWFM4HHTAhXMwwcm3D_R6qR_m148Yw@mail.gmail.com>
 <2d33d8dc-ed1f-ed74-5cc5-040e321ac34f@kernel.dk>
 <CAHk-=whAJtbP0Y96rUhhLcKM4EqL7mMsVMnD4e4BbYK=GXpdCQ@mail.gmail.com>
 <CAHk-=wiCVTXpE=NO1rnOX_KPMora9W9T11KB2vwgR8VXovAR1A@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CAHk-=wiCVTXpE=NO1rnOX_KPMora9W9T11KB2vwgR8VXovAR1A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 3/27/23 1:13 PM, Linus Torvalds wrote:
> On Mon, Mar 27, 2023 at 12:11 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>>
>> Ok, this is all the legacy "no iter_read/write" case, so that looks
>> fine to me too.
> 
> .. and I guess that makes PATCH 2/4 go away too, which is a good sign.

Exactly, both prep fixups can be dropped, leaving just that one prep
patch.

-- 
Jens Axboe


