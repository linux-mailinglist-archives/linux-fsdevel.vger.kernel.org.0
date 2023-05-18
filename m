Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F2D8708C49
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 May 2023 01:31:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229969AbjERXbx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 May 2023 19:31:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjERXbw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 May 2023 19:31:52 -0400
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18493C1;
        Thu, 18 May 2023 16:31:51 -0700 (PDT)
Received: by mail-oo1-xc2c.google.com with SMTP id 006d021491bc7-554f951e658so339823eaf.0;
        Thu, 18 May 2023 16:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684452710; x=1687044710;
        h=content-transfer-encoding:in-reply-to:cc:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eYgDPuLZiKeSPvGEjWOY9Kw5MPWojzL4LRufpH719TQ=;
        b=IQO2fjLRAy+iPaC34snXbtkrfVQnWY04g6bmUzfpFaMHFgtdgckYGNwyiqkjLHVqei
         d+M56JxXARfISb84dEqsW7HAX/frhxY0d1E67eqDyxKX8JiALNSH5luxfPnybUN5im28
         Wg9P/TEDQwUub1oVvSVPIgrqbQhTFuGzPCJnCI+6OsZJ5eVdCr8yn67totj8xxtXlTvF
         Tb1nsj8dEGgho0yp45uSoSifG97voZSAoJkchZpnclk4zlP1Trdxall1WhaGbkjYF3d6
         4ISA2TjNgvswptaNVztlE5nb0Skan9827uqHshyLtZJPSeTlQIN3YXWnnCfep9wLzSfg
         a7gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684452710; x=1687044710;
        h=content-transfer-encoding:in-reply-to:cc:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eYgDPuLZiKeSPvGEjWOY9Kw5MPWojzL4LRufpH719TQ=;
        b=Z2leHZzuoqF2CV6HgQGavQPte2U5iU/SZPTKDgeuVK8AaR/J/lt6zUQyTtwQJ1Lwse
         mL1A4QkzTuo/OKViRCCWQjpqbug3MRu2mHpOzwt1B9/3nUbp4fur+nyKRDEKIhH5Hw/C
         2EDMTmOmDd1FKoBxTwqdadLYuaHXjW6ktbyghH6FPq2EXIEBl6VNjo3bWPWtvx1luHGM
         pd9t3PVwXg7Q9kDWrFIqe8WFjlH+NxNpARj6xOpMOjaAx0AHPD1AAGykdD/Yq4a4xgUz
         ipkwdTHacWKBrc64bI9I/kpf1FBy5vn58EfW5vADY/Blk2zBsXoIXpV02o6gcJe1FT9k
         2r/Q==
X-Gm-Message-State: AC+VfDzAefDBd5kA0zUzlbMVSeoTRfguQWineT1B+d6TT1MHUezRnLu8
        r7uTQ4zyJMPLs8Nrp3pd+dL2QR+On0k=
X-Google-Smtp-Source: ACHHUZ5FZaUANm5x68UabkwtO8tsnGuh3O1Ul5AELkv5gASaJYrr9FXsm6HWXp9lUXSQnEEq68QxvA==
X-Received: by 2002:a4a:764a:0:b0:54c:b507:2616 with SMTP id w10-20020a4a764a000000b0054cb5072616mr18716ooe.3.1684452710343;
        Thu, 18 May 2023 16:31:50 -0700 (PDT)
Received: from [192.168.0.92] (cpe-70-94-157-206.satx.res.rr.com. [70.94.157.206])
        by smtp.gmail.com with ESMTPSA id n14-20020a4abd0e000000b0052a32a952e9sm917047oop.48.2023.05.18.16.31.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 May 2023 16:31:49 -0700 (PDT)
Message-ID: <652d32c5-4b33-ce3a-3de7-9ebc064bbdcb@gmail.com>
Date:   Thu, 18 May 2023 18:31:47 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [ANNOUNCE] util-linux v2.39
Content-Language: en-US
To:     Karel Zak <kzak@redhat.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, util-linux@vger.kernel.org
References: <20230517112242.3rubpxvxhzsc4kt2@ws.net.home>
From:   Bruce Dubbs <bruce.dubbs@gmail.com>
Cc:     "Douglas R. Reno" <renodr2002@gmail.com>
In-Reply-To: <20230517112242.3rubpxvxhzsc4kt2@ws.net.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/17/23 06:22, Karel Zak wrote:
> 
> The util-linux release v2.39 is available at
>                                    
>    http://www.kernel.org/pub/linux/utils/util-linux/v2.39
>                                    
> Feedback and bug reports, as always, are welcomed.

Karel,  I have installed util-linux v2.39 in LFS and have run into a problem with one 
test, test_mkfds.  Actually the test passes, but does not clean up after itself. 
What is left over is:

tester   32245     1  0 15:43 ?        00:00:00 /sources/util-linux-2.39/test_mkfds 
-q udp 3 4 server-port=34567 client-port=23456 server-do-bind=1 client-do-bind=1 
client-do-connect=1
tester   32247     1  0 15:43 ?        00:00:00 /sources/util-linux-2.39/test_mkfds 
-q udp6 3 4 lite=1 server-port=34567 client-port=23456 server-do-bind=1 
client-do-bind=1 client-do-connect=1

It's possible it may be due to something we are doing inside our chroot environment, 
but we've not had this type of problem with earlier versions of util-linux.

In all I do have:

   All 261 tests PASSED

but the left over processes interfere later when we try to remove the non-root user, 
tester, that runs the tests.  I can work around the problem by disabling test_mkfds, 
but thought you would like to know.

   -- Bruce
