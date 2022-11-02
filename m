Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71D5661638B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Nov 2022 14:14:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231219AbiKBNOo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Nov 2022 09:14:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231340AbiKBNOh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Nov 2022 09:14:37 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01B192AC61;
        Wed,  2 Nov 2022 06:14:36 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-3691e040abaso165718017b3.9;
        Wed, 02 Nov 2022 06:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=h4Qt4+7BCtKcn4LLoSu0RRkNEJEJ/wzm8INNJC+mbcM=;
        b=TAHjqFBWfeOX0IQXjYQCEXWx9G6UWa4lAB+NgrEPgjS2Y9Gex05iuxYzLfsooQV3vU
         WMausD7iXUy85YoOK8v3QLs5BxH2hFRpLQrcCEXfFvbsyXxvF33yrx3CYuT9NWXK4w0x
         gPeeA8NTjn+4cIVlxPIxLo6nnqkzbHvfgpdBtJv23pnMfz3quqNiPPEkFx9j5zAHUDAN
         TYLa0CwL7OAg229kNs0IHhMqugKjKHD+qT+elblhLn5qa48zDjX4PatcdKjER5Rx0qKZ
         pdxA5a+V7V4gN6SPZWsyY2aDcd7u9Dr2Tf5ytxToa7G1yNyA8KHoVyewcqqw4RHckE+j
         1oLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h4Qt4+7BCtKcn4LLoSu0RRkNEJEJ/wzm8INNJC+mbcM=;
        b=NjjHgj+0+/Brpa42JNhz80dYnV5HTipTCZ0s1LlWoVJELvTQ8wpaXiRO2JZuEhT8bJ
         Q0Mfwcy1qjcMpUw+BGsS2TNaNCmHx3cCA7LKjGSRTncMLYoE9MYp6LE0mgzb0Kl1of57
         Vg8CejfyO3nzvWrUVUS50P8WSri0gZWpqHJMlXrVjOV7DM/s22LVRg65dXU/uuKWK3aU
         DiJ+phtO0G1m65IxCOBq1tq53ZP/XZFyKXVThSf78QQ1RJWdH45htGM194nT0u2viWD3
         6EPzjDu6ChyFTF1riwiTVwu9vHQQHDOU9Dxmo6mzanXBVqfPH4W5hU83pwWbD5jsy+Wa
         RE7g==
X-Gm-Message-State: ACrzQf1M1rUNBPDTRg3+KuFeB9jb2RuHLeDHzOKUJM1R1BcVtjGjP7Yf
        rtRSF0TwzUvt90xCuKhDt5s7YmDOw+pvV4by4Eg81mQfHq0=
X-Google-Smtp-Source: AMsMyM7Go2dY4fPx7yT1HB5yw/V5bGz2LMNKt7XKGTUmWQ3Q0pzGo+mbmi+3J34k1bvQE6nHMv/vWR40e30Kn2HfgAU=
X-Received: by 2002:a81:6208:0:b0:367:f222:df0d with SMTP id
 w8-20020a816208000000b00367f222df0dmr24153950ywb.422.1667394875814; Wed, 02
 Nov 2022 06:14:35 -0700 (PDT)
MIME-Version: 1.0
References: <CABDcava8ADBNrVNh+7A2jG-LgEipcapU8dVh8p+jX-D4kgfzRg@mail.gmail.com>
In-Reply-To: <CABDcava8ADBNrVNh+7A2jG-LgEipcapU8dVh8p+jX-D4kgfzRg@mail.gmail.com>
From:   Guillermo Rodriguez Garcia <guille.rodriguez@gmail.com>
Date:   Wed, 2 Nov 2022 14:14:24 +0100
Message-ID: <CABDcava_0n2-WdyW6xO-18hTPNLpdnGVGoMY4QtPhnEVYT90-w@mail.gmail.com>
Subject: fs: layered device driver to write to evdev
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>, Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi all,

I have a number of embedded boards that integrate a pwm-based buzzer
device, and use the pwm-beeper device driver in order to control this.

However the pwm-beeper device driver only supports simple (play /
stop) ioctls, so I had implemented a "layered" device driver that
would talk to the pwm-beeper device (through evdev), and provide
additional ioctls to userspace so that an application could say e.g.
"beep for 50ms", and the driver would take care of the timing.

This layered device driver used set_fs + vfs_write to talk to the
underlying device. However, since [1] this no longer works.

I understand that device drivers should implement ->write_iter if they
need to be written from kernel space, but evdev does not support this.
What is the recommended way to have a layered device driver that can
talk to evdev ?

Thanks in advance,

(If possible, please CC me in any replies)

 [1]: https://lore.kernel.org/lkml/20200626075836.1998185-9-hch@lst.de/

-- 
Guillermo Rodriguez Garcia
guille.rodriguez@gmail.com
