Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DB1D549CC6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jun 2022 21:04:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347095AbiFMTEV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Jun 2022 15:04:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348594AbiFMTDq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Jun 2022 15:03:46 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C285CDECDF;
        Mon, 13 Jun 2022 09:49:06 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 123so6036499pgb.5;
        Mon, 13 Jun 2022 09:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9ALP8lsGfjdjgEofzfsJxd9qV2mlI2gIpt2uj+q0ckY=;
        b=czz4osvuz+f2/S9+hKIjWaAk9nwSjJ5BOHALM+L8npDyOhQSu1gub0HzMFya7upev0
         ksc11lhUgxu5WOL1X01iW7xW28n2VADA6Drw9tJPihqqX620yo73SEmRJ6hGnGZOAzjq
         qAUgNs2B0F1W/wZQbVz2t2VLJ5nKXleE2zBa5OitnNb8XSHZrsJFKLMtydUtpznI1+9E
         fehC7wCZeJMpJkFmbogNuBdjfUA42uqOY4DxjxHRGdQyX1ltUipgYipCxG2mdtoliuRV
         jlddM/kmMTj75GnveSpGfFLOg8Kf6qr7icepy6U07x7cpPImoEsYWl/QwxdTSCRmlv4P
         UeiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=9ALP8lsGfjdjgEofzfsJxd9qV2mlI2gIpt2uj+q0ckY=;
        b=yK5WPLwXavmGzcBpwgJu2L8e1cHjou8k37NHXVs6wSVUGtynBwcc1xaQCuq0naQZgj
         jJGmA+j222Yyj5ySo79pwJ/yVtlkvooB6xKJCdQ5XLTFQzkkXylB6pcuH04H2BKdXxAT
         aavaKkxZss4JF7S9gT5QMkDyHdW/OCFMqrqCiI+6J5reDfpOIg/8TLttW4u1PTtgED9Y
         aXGBSnz/QkUlSHwb4G5Kf0Dp5x+1ApoAiVLPcd02W4C7muHGMyuMCz6HV5kJFO0QLE5O
         GsBEOvuQ4KmcPaUsFB8do2vntAd9XhRkaNMwlfdH2eJ54MNvJE6vBRG/xrAjsUfPnxUh
         0dJA==
X-Gm-Message-State: AOAM530RIlH97XwVfwi1522mUM7tlGxmkV5YqF2gJ3QIK5FbGdhlQs79
        fdWFzcVBWoazjUwAbJiLO+s=
X-Google-Smtp-Source: ABdhPJz7UaAu1dmwAfduVnLzoXN0rY0S0U8WJE6KWUcTeKiIhK5MLmLXhvJaShL6SyWBuIMPeljjvA==
X-Received: by 2002:a05:6a00:3491:b0:51c:1d3b:b0b0 with SMTP id cp17-20020a056a00349100b0051c1d3bb0b0mr131559pfb.68.1655138946195;
        Mon, 13 Jun 2022 09:49:06 -0700 (PDT)
Received: from google.com ([2620:15c:211:201:43cb:e071:e7f2:5e7a])
        by smtp.gmail.com with ESMTPSA id ij7-20020a170902ab4700b001621cd83e49sm5356623plb.92.2022.06.13.09.49.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 09:49:05 -0700 (PDT)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Mon, 13 Jun 2022 09:49:03 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        umgwanakikbuti@gmail.com, bigeasy@linutronix.de
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        regressions@lists.linux.dev, Jens Axboe <axboe@kernel.dk>,
        Nitin Gupta <ngupta@vflare.org>
Subject: Re: qemu-arm: zram: mkfs.ext4 : Unable to handle kernel NULL pointer
 dereference at virtual address 00000140
Message-ID: <Yqdqfz4Ycbg33k1R@google.com>
References: <CA+G9fYtVOfWWpx96fa3zzKzBPKiNu1w3FOD4j++G8MOG3Vs0EA@mail.gmail.com>
 <Yp47DODPCz0kNgE8@google.com>
 <CA+G9fYsjn0zySHU4YYNJWAgkABuJuKtHty7ELHmN-+30VYgCDA@mail.gmail.com>
 <Yp/kpPA7GdbArXDo@google.com>
 <YqAL+HeZDk5Wug28@google.com>
 <YqAMmTiwcyS3Ttla@google.com>
 <YqANP1K/6oRNCUKZ@google.com>
 <YqBRZcsfrRMZXMCC@google.com>
 <CA+G9fYvjpCOcTVdpnHTOWaf3KcDeTM3Njn_NnXvU37ppoHH5uw@mail.gmail.com>
 <YqbtH9F47dkZghJ7@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YqbtH9F47dkZghJ7@google.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 13, 2022 at 04:54:07PM +0900, Sergey Senozhatsky wrote:
> Hello,
> 
> On (22/06/12 20:56), Naresh Kamboju wrote:
> > 
> > I have tested this patch and the reported issue got resolved [1].
> >
> 
> Many thanks for the tests.
> 
> Quite honestly I was hoping that the patch would not help :) Well, ok,
> we now know that it's mapping area lock and the lockdep part of its
> memory is zero-ed out. The question is - "why?" It really should not
> be zeroed out.

Ccing Mike and Sebastian who are author/expert of the culprit patch

Naresh found zsmalloc crashed on the testing [1] and confirmed
that Sergey's patch[2] fixed the problem.
However, I don't understand why we need reinit the local_lock
on cpu_up handler[3].

Could you guys shed some light?

[1] https://lore.kernel.org/all/CA+G9fYtVOfWWpx96fa3zzKzBPKiNu1w3FOD4j++G8MOG3Vs0EA@mail.gmail.com/
[2] https://lore.kernel.org/all/YqBRZcsfrRMZXMCC@google.com/
[3] https://lore.kernel.org/all/YqEKapKLBgKEXGBg@google.com/
