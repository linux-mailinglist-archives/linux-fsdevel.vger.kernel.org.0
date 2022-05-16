Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 619E25280E7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 May 2022 11:34:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236617AbiEPJei (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 May 2022 05:34:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232428AbiEPJef (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 May 2022 05:34:35 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 740E62C66C
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 May 2022 02:34:32 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id r11so25914729ybg.6
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 May 2022 02:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IsnZHn/Yb4Gg4uzTdxR5MipH5YV//XGbgl5gxawgKOw=;
        b=kmC6qA4DQSfbPbmqKTjTBN+WiFA0Fp/1W+HQRhmuXM+3VJxNSa/n6DET1zzSgB32zM
         2MdZbryi1/IyT1ZUQaOX3m4fIjXz6nZrhkvXoK6vI7TgQx/7eqC5YqIfuAG5e5mwlrHw
         qshxLVL14zm59d3UYcGrOutXSgZehfPbu1a/S9zlUl7bW8M3pY3GsN7ksSHniACf7GGy
         sHR9INC1Pb5TFxTh1M55e0zQx6jrLoXmLKpbRrdDsC0ul5eQHwk/0Z4CPAi0ES5I6Gf6
         Ij0NDczGoDm2JiJex3kKBcSWZMdNPALUNFF3aPIRfKFB6mRTQx6Qphp0wWMo/07ZAfk1
         2Fug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IsnZHn/Yb4Gg4uzTdxR5MipH5YV//XGbgl5gxawgKOw=;
        b=53vWu7yMNqimrJccl9Xc/EbhtiYZK5Z5SDFpHzoXiTO90cTz4/rjxOQcups9gD/wPv
         AiqBgGstLpnqwHaH0NYRKq1FnIJncnrnN6aW/0CZWsG1Qpzr1c5m6lblLV34z/hK+4As
         g52TA7YAHnqJu5Uc3SZiv7gE1B2ivb29EHzW1LMRqd8wkuoURCikPffnxWQK7pcAT5BJ
         yGKZ/iKRV5fG5KA+JYUIj4nCBsGouSQvUJHFfOQaWCJO9o0tMNgiHmSp0YXzsEjoLsf8
         Crw594Kw8+NgYj0V/9IEilt/c04EdLSp582bOqtomCpa9lJK811nQS1DyQLzjLBENhg1
         qV7Q==
X-Gm-Message-State: AOAM531s5hj3XgTUtweSNdUVzfMW8qxkh2lfToETOVsunOFp6qBcQU7M
        qaCCpJxOGNhkr0kMfVWN98xUTbhJYVBp92v7qM6TL1z43r9QQA==
X-Google-Smtp-Source: ABdhPJyeoQNI9JDCmFz0km+ymnaePhVCU3SoEOUk9C3+XEExM8+dDbDOgXuSUOaR7g4ZF7g8zFfUQptgZ03LEbD8kTA=
X-Received: by 2002:a25:9a43:0:b0:64a:bc11:3132 with SMTP id
 r3-20020a259a43000000b0064abc113132mr16724281ybo.261.1652693671784; Mon, 16
 May 2022 02:34:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220516090752.2137286-1-bh1scw@gmail.com>
In-Reply-To: <20220516090752.2137286-1-bh1scw@gmail.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Mon, 16 May 2022 17:33:55 +0800
Message-ID: <CAMZfGtU+WrB9FsiToZJZAVQ26+vS63CeBTAa-AhbhLpi1rGCNw@mail.gmail.com>
Subject: Re: [PATCH] kernel/sysysctl.c: Remove trailing white space
To:     bh1scw@gmail.com
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 16, 2022 at 5:08 PM <bh1scw@gmail.com> wrote:
>
> From: Fanjun Kong <bh1scw@gmail.com>
>
> This patch removes the trailing white space in kernel/sysysctl.c
> Special thanks to Muchun Song.
>
> Signed-off-by: Fanjun Kong <bh1scw@gmail.com>

Reviewed-by: Muchun Song <songmuchun@bytedance.com>

Thanks.
