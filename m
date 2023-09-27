Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EDD07B06FE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Sep 2023 16:34:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232127AbjI0Oex (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Sep 2023 10:34:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232050AbjI0Oev (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Sep 2023 10:34:51 -0400
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 801ABF9;
        Wed, 27 Sep 2023 07:34:48 -0700 (PDT)
Received: by mail-oo1-xc2f.google.com with SMTP id 006d021491bc7-57bb6b1f764so4102693eaf.2;
        Wed, 27 Sep 2023 07:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695825288; x=1696430088; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1wcyeaO32bSJUSTh9kt7Myh0bGIAbOaRoe3l7edBb+0=;
        b=gN0548ichyFLvn5itazQb0pK2HlGGlxOzAN9FDiSEz1E74ZUK42ttWwZ4TNYVhUdbv
         DkHdVK4rdwGFSza5dq41kSgqwrs7GJYpbZSFli7bIygcC2F5LuBU9n9TdfB047eQf2ly
         Pc4ckyipXDORsMOki3wHnr7aUtDAopElgpc+u0GMYfSeCO8VjqR+OeQJLGs3mvBPcs9z
         nsOjnJIzJvKJx3yxHe90lxCCYpNRfQoG6OWrRwjV/7WjBCNpx9Mpi5rcENZyWtaiurQ0
         fur+hHXYj+ykpLHm1hf/M21jntZ0pgQOHy6sP4WiOndIjxna2fFiU/AeLJcfYRQLb40m
         qxwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695825288; x=1696430088;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1wcyeaO32bSJUSTh9kt7Myh0bGIAbOaRoe3l7edBb+0=;
        b=XcJhc2woiHD5ugW8TOMcvLbLj/xhKa3yPquyy8sJ+EDS9TpJnvVMw8S+RoJxhlcWvB
         nNhnaZze/LjZE/E/LvkqVP8heSGzSZatMunsRho98jksHyl5I/7HESFmbpmY0PJOnHGA
         hDuU3pkXLIcE9XRQiYpbDYvZCrqTBDvEusOFi7GComCmt6CR5/69zvb+UhrgV6p9ZI0h
         cyQZqWX8+Y7PIRtfZ6QwdudEPkLtVbyShr7AIEIEadN9YWOhi/VYRV+R8aX0FJ/rmkt3
         EcE/mYlcFjC28ydUoM13ANvlJxZtgjNrFLnbbLeqWnLimpCUMEDAqk5+EcWejHjTl/qQ
         g2iA==
X-Gm-Message-State: AOJu0YxK0oCpOQL3FwJ4XRganb/ZcZOr3Pp36i2khc0+Q0+P6Fk153G3
        a1OdfO9OwUZOv3nOoXZqZKMJG1iSs76zEeq2KAQ=
X-Google-Smtp-Source: AGHT+IFIelY/GDfiCw1krmZpT+E78j8KHrwhJX5RtwF6Sr+jZ0IHDVKur4LgIMoLstm6j+C3xtuSFCsIUaGh56VwGqU=
X-Received: by 2002:a4a:6c58:0:b0:57b:6ab1:87c9 with SMTP id
 u24-20020a4a6c58000000b0057b6ab187c9mr2324019oof.0.1695825287657; Wed, 27 Sep
 2023 07:34:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac9:5785:0:b0:4f0:1250:dd51 with HTTP; Wed, 27 Sep 2023
 07:34:47 -0700 (PDT)
In-Reply-To: <20230927-kosmetik-babypuppen-75bee530b9f0@brauner>
References: <20230926162228.68666-1-mjguzik@gmail.com> <CAHk-=wjUCLfuKks-VGTG9hrFAORb5cuzqyC0gRXptYGGgL=YYg@mail.gmail.com>
 <CAGudoHGej+gmmv0OOoep2ENkf7hMBib-KL44Fu=Ym46j=r6VEA@mail.gmail.com> <20230927-kosmetik-babypuppen-75bee530b9f0@brauner>
From:   Mateusz Guzik <mjguzik@gmail.com>
Date:   Wed, 27 Sep 2023 16:34:47 +0200
Message-ID: <CAGudoHGK8H18F0QSowb703m=5hsbP2hHvTjMArxoj4g5a0M7UA@mail.gmail.com>
Subject: Re: [PATCH v2] vfs: shave work on failed file open
To:     Christian Brauner <brauner@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/27/23, Christian Brauner <brauner@kernel.org> wrote:
>> I don't have a strong opinion, I think my variant is cleaner and more
>> generic, but this boils down to taste and this is definitely not the
>> hill I'm willing to die on.
>
> I kinda like the release_empty_file() approach but we should keep the
> WARN_ON_ONCE() so we can see whether anyone is taking an extra reference
> on this thing. It's super unlikely but I guess zebras exist and if some
> (buggy) code were to call get_file() during ->open() and keep that
> reference for some reason we'd want to know why. But I don't think
> anything does that.
>
> No need to resend I can massage this well enough in-tree.
>

Ok, I'm buggering off to other patches.

Thanks.

-- 
Mateusz Guzik <mjguzik gmail.com>
