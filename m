Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B2737AD8EB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Sep 2023 15:21:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231226AbjIYNVJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Sep 2023 09:21:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231935AbjIYNVH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Sep 2023 09:21:07 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C15AFE
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Sep 2023 06:21:01 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-9a9d82d73f9so773208466b.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Sep 2023 06:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1695648059; x=1696252859; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Bn7iTgk75DF3DW8sTBDK7BwRnFNBYwDw+r/Tm44OLFA=;
        b=GNagsra4GCGDzTy92nT4uU054HTMhUzj2r5S1XoXuehiAyadddYpumYs2vyWIaXAWg
         XDxiLhjp0/2e3mA8dvWOaRpHj+sjDd7Zeo+3G0My3yJDVMj9KJn67DhdzQ5db31/lq7n
         GusMJST4VmMIvjWLabaoC+IT9aZa49UuVVAB4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695648059; x=1696252859;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bn7iTgk75DF3DW8sTBDK7BwRnFNBYwDw+r/Tm44OLFA=;
        b=Me2KjjelUPLDukGHfHuBjoc+FcljWzzSRro/aVGE+QCBkxldcxRaq+Rm+KUCyRjDcK
         FhWwfPeeXtkfbqMpXNds3x92WVps8RvgBjl7M+/7Ij9MGbdNUS6vxpF1Vh8GWd0cVtPm
         HLLx7z7BIBq8+evrUSjVg1wHL3X1E+op92TzaKsPn3XL5C5UXyiqhpn80QfydzfFLQdT
         Yy47r7/dh4I1S/Y0oBgmu64Bp+DZUCFTxxxcCPRXPi41dh6XcC/02eUe0Qp8JOKhXPPh
         vj7jzVDjP2y93hY/HpH2cvIg597VljTa5cocT0AI6foYdaA++j6r3UgnHTegEBW1JSR5
         oKWQ==
X-Gm-Message-State: AOJu0YzqfYkoqg5MoElS+PJTpXCCdP+3NvXHzYBwufTuKPPnsnVgk9Oo
        zJKoVV8jFz2ZvUVwWV9zJnoBlZSL4zTTEAMZDPSEeA==
X-Google-Smtp-Source: AGHT+IHmxMwgC53O5hQ/QSKMb6t/FgpbrX6Ui+dVQFc7nP6qEjhRvhi5crY4OxsJkC1oykn7zUX+j49dgMzgcYgF0b0=
X-Received: by 2002:a17:906:3089:b0:9ad:7d5c:52f5 with SMTP id
 9-20020a170906308900b009ad7d5c52f5mr5603619ejv.75.1695648059583; Mon, 25 Sep
 2023 06:20:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230913152238.905247-1-mszeredi@redhat.com> <20230913152238.905247-3-mszeredi@redhat.com>
 <44631c05-6b8a-42dc-b37e-df6776baa5d4@app.fastmail.com> <20230925-total-debatten-2a1f839fde5a@brauner>
 <CAJfpegvUCoKebYS=_3eZtCH49nObotuWc=_khFcHshKjRG8h6Q@mail.gmail.com> <20230925-wahlrecht-zuber-3cdc5a83d345@brauner>
In-Reply-To: <20230925-wahlrecht-zuber-3cdc5a83d345@brauner>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 25 Sep 2023 15:20:48 +0200
Message-ID: <CAJfpegvAVJUhgKZH2Dqo1s1xyT3nSopUg6J+8pEFYOnFDssH8g@mail.gmail.com>
Subject: Re: [RFC PATCH 2/3] add statmnt(2) syscall
To:     Christian Brauner <brauner@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Miklos Szeredi <mszeredi@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-man@vger.kernel.org,
        linux-security-module@vger.kernel.org, Karel Zak <kzak@redhat.com>,
        Ian Kent <raven@themaw.net>,
        David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        Amir Goldstein <amir73il@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 25 Sept 2023 at 15:19, Christian Brauner <brauner@kernel.org> wrote:
>
> > How about passing u64 *?
>
> struct statmnt_req {
>         __u64 mnt_id;
>         __u64 mask;
> };
>
> ?

I'm fine with that as well.

Thanks,
Miklos
