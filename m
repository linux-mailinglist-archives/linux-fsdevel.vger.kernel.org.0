Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4416C7A8DC7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Sep 2023 22:29:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbjITU3H (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Sep 2023 16:29:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjITU3H (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Sep 2023 16:29:07 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DABCDAB
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Sep 2023 13:29:00 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-405082a8c77so2547635e9.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Sep 2023 13:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695241739; x=1695846539; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YgsQjPYSA4x9EUAST26pLIMgzwk5/fmUNEDBBVE+P4A=;
        b=Ue/arN93mwyg8iKLJhbSFF+q+mIhcBN5Rk4lKj708pkihWlD0xI3IJSfskhPu6+xP6
         VlVzkb95PcBHv5G9CFMCS6cuh+Zn5o9ieWpQUkiRZ+IFh7u0NcVSBFf0txtp+IEZMUfL
         +n2iwL3jKnZtmx5XxhBGqQr8Gv4+zdi8Jai42sKOMf2Se3/fyGGgm7F5NYtz2sUViRGb
         p/NdH5VVGWL1gZhZTfBCyTUy/7eem2uQS13827nZwqCzS2MQEKvH3DWU0jloNc89dk6C
         t6Zie03d6H9qinAeckzaPSLeudx3L77cMtSPoJ3qlW2KhRvXeLEFvT+qxDyWveacRR8+
         VHug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695241739; x=1695846539;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YgsQjPYSA4x9EUAST26pLIMgzwk5/fmUNEDBBVE+P4A=;
        b=CZpz5M9PnyZ00iaCqsoGNRxDvJ1nxs+gN177EezfK+a5iKohg9VOAEJ7GE2rYESO2b
         Em19G1RX6UHc+fP4UwDN+ZQKMPpiUlNFYm0RZ9hacGlYbircGTz3iOJTBpKBMhnwMp9K
         Hschdhn9prq2HpYG3xK6YXaJAVM5l6+zOnzFQHpM4si5AcO5+NSpJo/3wzgDpa4GnjHk
         Rfn3N6mSqGjKkaXB9VgIXO9UOvzCQFZSiooPeGiA8fLgpwR7K+wkVG6pp3iMIOGwuPha
         w8E8JtrLAoScrn2+c8vxex7bFmqALjXtm+pQhPp/WkgjT8wWwj3+JLHJD7ep6iYlXUpz
         gsIQ==
X-Gm-Message-State: AOJu0Ywa2g3rguNFWhE9bm55ck9IrzYaLd+o24W0TZ081MxZi0GT3bnN
        kklfk5FDhE72NNI8eGWgwwfFuX5ZLbE4oSZLGVk=
X-Google-Smtp-Source: AGHT+IGDfv/YLLELO80/AwOpt2FqIG3pvnqbIIT+ZCfg9BFOvM4bzq1JUiJir9NJ7gpa6NUyZFEhhXHVmlbh71wxQAc=
X-Received: by 2002:a5d:674b:0:b0:321:56af:5ef9 with SMTP id
 l11-20020a5d674b000000b0032156af5ef9mr3573600wrw.70.1695241738899; Wed, 20
 Sep 2023 13:28:58 -0700 (PDT)
MIME-Version: 1.0
Sender: mr.qamarmuhama@gmail.com
Received: by 2002:a5d:55d0:0:b0:314:417c:5250 with HTTP; Wed, 20 Sep 2023
 13:28:58 -0700 (PDT)
From:   Dr Lisa Williams <lw4666555@gmail.com>
Date:   Wed, 20 Sep 2023 13:28:58 -0700
X-Google-Sender-Auth: RaD5QO1dRIIf5603nALuOx_XGfU
Message-ID: <CAJEdJUj51ULvzHQjTvyqWX6U0qNLV4evzUfbGxfu-kP0FaSjGA@mail.gmail.com>
Subject: Hi,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

My name is Dr. Lisa Williams, from the United States, currently living
in the United Kingdom.

I hope you consider my friend request. I will share some of my photos
and more details about me when I get your reply.

With love
Lisa
