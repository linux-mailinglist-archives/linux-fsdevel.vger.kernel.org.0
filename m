Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 979325FC6CD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Oct 2022 15:55:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbiJLNy5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Oct 2022 09:54:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbiJLNyx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Oct 2022 09:54:53 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9FC110576
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Oct 2022 06:54:48 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id s2so24613124edd.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Oct 2022 06:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=x2tUb5+aLG8nam33vfaV25MeR7P8G77Loo4qayZcNpU=;
        b=H2rbP2y7a33ArIHNNILZbA76NG2+X/SR3QOLjp7Zyib7xxe52pAgRd6xnQh+PLuQiZ
         vgUN32VfzlFDBwcTpV5VOPAdL2BQtYrmuDCKhUYGSnTkCTnUQLWsa9MiTsTmbVr2O0CJ
         9DMuG/ljOOgeV4fnznCEFL8ESQ3wEb73shvzM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x2tUb5+aLG8nam33vfaV25MeR7P8G77Loo4qayZcNpU=;
        b=NYLbZQtQAFPFZ56fVP9ekoby/GibrHzGfyiAUAPDq04Y74va6DmQ2mu24KubO4g2IV
         y1SexhdAifnsMmOTbxJkQftt6ENdpnvhW+n/xG4pk7+Yr1BPBlmjx4xnThIlS4HFVnpP
         W1YvsdeQcaTP6L3wXhXIhUKtqt7v2QS9ZgW8hac1Rwgi6e24FrpYz+cRX8K5pcKXOLQQ
         iHJkv2JehaPqQ80Asi1L9aDzdzHJnctziue6EuBhT6jR+7TpENeQCwu3GRx9MmMqKJ66
         CVk4M1u6KbFGjkgrJXCQlYxH3i2BZWHi+NNifeHT6tR+bNbg0Qvi0p6RSjeNtfnqxnuV
         SSLQ==
X-Gm-Message-State: ACrzQf0Dqpjpxo+57xhW1pNLZJKc8fVHAqruYbCxpyJvsIH5z+rai7Ox
        RjBkFIZIyY5eBJ3wjKxp0VwEE2En4hsthVzlNlTBkQ==
X-Google-Smtp-Source: AMsMyM5i9wtc4jHHAG4BKdvGzBQM+sSkdoTnwxvW8c+6VbI4dkGaNQjwflByW2NoDfRkkqVCzCj/z/zmf046zQSqTVk=
X-Received: by 2002:a05:6402:3215:b0:45c:97de:b438 with SMTP id
 g21-20020a056402321500b0045c97deb438mr5204382eda.7.1665582887439; Wed, 12 Oct
 2022 06:54:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220901074259.313062-1-ye.xingchen@zte.com.cn>
In-Reply-To: <20220901074259.313062-1-ye.xingchen@zte.com.cn>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 12 Oct 2022 15:54:36 +0200
Message-ID: <CAJfpeguPHUmGDzT6VXC6SaQaAb3vLVT+xt4k31AqDiJuZ-oK0w@mail.gmail.com>
Subject: Re: [PATCH linux-next] fuse: Remove the unneeded result variable
To:     cgel.zte@gmail.com
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        ye xingchen <ye.xingchen@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 1 Sept 2022 at 09:43, <cgel.zte@gmail.com> wrote:
>
> From: ye xingchen <ye.xingchen@zte.com.cn>
>
> Return the value fuse_dev_release() directly instead of storing it in
> another redundant variable.
>
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>

Applied, thanks.

Miklos
