Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42277771197
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Aug 2023 20:48:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbjHESsH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 5 Aug 2023 14:48:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjHESsH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 5 Aug 2023 14:48:07 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B98182D4E
        for <linux-fsdevel@vger.kernel.org>; Sat,  5 Aug 2023 11:48:05 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2b95d5ee18dso50214451fa.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 05 Aug 2023 11:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1691261284; x=1691866084;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aE3aVUFZz0Pt4+RHGO5Pm733Go7Y9ttkQg+3JtB4S4o=;
        b=Q5nhjfYNB/Mx0F71c/diYKMtiLPlp9ZTRajB27ddxTXRFwlWZ8RW1c9HCRyjy+k62L
         8+ygtwMa+sd7H1TOIwvGBrN9XzLpv3xeAx9JH4atf/zlO33ML8GxGaKITzoNGIOiYA7Q
         IgqdLlT7KxygKwLb26W3OkIBcLd1VnfJzfULw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691261284; x=1691866084;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aE3aVUFZz0Pt4+RHGO5Pm733Go7Y9ttkQg+3JtB4S4o=;
        b=YO2Ls2Zt/CgQqGtLXIGEdV7M/ty0O9Xom0bo6vWYYFyB8u8AL6jzWqXrBiV1xilP3U
         B1BPs6MXXbn6IkfxxwnQi8R/mJSOqh8jkBx+u/QWORJ278fAW1pcH2siQSElM88G0GDw
         0II81CuKUb6TJxXZMQUfHwtYRt+hDcJqMsHeGtNsUa7gSNPD+JF9kRmsp2s3Z0mEX4/Q
         iS7q6XhPOcPhaRQqNKxF8wQ60YQsUGT1mfaQ0FnET5X+VxdqSi+KBcSeLgZ1miiAUF4g
         DJ3XfDnVI8yZJo0mRv+T/9vw9lYF6Bn9lUH98kP+qUERlx9hr0Sd1PL57DRNwb3nUfoD
         naiw==
X-Gm-Message-State: AOJu0YyXekU0v84dUlDmHhPQW9TwgPKxY8xymFYygMCiTauZcEuZsAiy
        iijB6uSltggeZD/JgtIaSxHNvyeOw5DJjoDMoS2SHAsZ
X-Google-Smtp-Source: AGHT+IHc3ov/jwjEoVbLbjvB2rkOGJu9FzCis5TO6RfQzBjor+OuBz9elMK2lcW8IP8f7yOdYFcmSA==
X-Received: by 2002:a2e:6a0e:0:b0:2b9:e831:f165 with SMTP id f14-20020a2e6a0e000000b002b9e831f165mr3664019ljc.42.1691261283878;
        Sat, 05 Aug 2023 11:48:03 -0700 (PDT)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id e15-20020a2e818f000000b002b940b3784csm997318ljg.6.2023.08.05.11.48.02
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Aug 2023 11:48:02 -0700 (PDT)
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2b95d5ee18dso50214201fa.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 05 Aug 2023 11:48:02 -0700 (PDT)
X-Received: by 2002:a19:7611:0:b0:4fd:d64f:c0a6 with SMTP id
 c17-20020a197611000000b004fdd64fc0a6mr3262956lff.48.1691261282423; Sat, 05
 Aug 2023 11:48:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230804-turnverein-helfer-ef07a4d7bbec@brauner> <20230805-furor-angekauft-82e334fc83a3@brauner>
In-Reply-To: <20230805-furor-angekauft-82e334fc83a3@brauner>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 5 Aug 2023 11:47:45 -0700
X-Gmail-Original-Message-ID: <CAHk-=witxS+hfdFc+xJVpb9y-cE6vYopkDaZvvk=aXHcv-P5=w@mail.gmail.com>
Message-ID: <CAHk-=witxS+hfdFc+xJVpb9y-cE6vYopkDaZvvk=aXHcv-P5=w@mail.gmail.com>
Subject: Re: [PATCH] file: always lock position
To:     Christian Brauner <brauner@kernel.org>
Cc:     Mateusz Guzik <mjguzik@gmail.com>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Seth Forshee <sforshee@kernel.org>,
        linux-fsdevel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, 5 Aug 2023 at 04:47, Christian Brauner <brauner@kernel.org> wrote:
>
> So instead of relying on the inode we could just check f_ops for
> iterate/iterate_shared.

Yes. Except I hate having two of those iterate functions. We should
have gotten rid of them absolutely years ago.

You shamed me into fixing that.

          Linus
