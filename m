Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D9077A7595
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Sep 2023 10:15:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232409AbjITIP7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Sep 2023 04:15:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230447AbjITIP5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Sep 2023 04:15:57 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A368B6
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Sep 2023 01:15:50 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-9aa0495f9cfso137218166b.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Sep 2023 01:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1695197748; x=1695802548; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ynjSr5MB1I1cIWXu5OdlM4BjZKE+HPB70bp5/SDZQf0=;
        b=DX/ZyTowlt7ltsNcEisnXLF4444HDPk37lyksdQdeJYpCt+ZN6ITlscQPt2vJpKCNt
         m4ajnr/GOE5OMCe+NXTU3jBn3qANgCqfF8krv869ykgGB+Dnd2WIhtfR6oOdOWYXSSzc
         de2g334U7Oq8Teb7c2HYKbjMwxnna3Roh6Tqs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695197748; x=1695802548;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ynjSr5MB1I1cIWXu5OdlM4BjZKE+HPB70bp5/SDZQf0=;
        b=KS7BZOHDkw71Zli89DWKyuYB56sizNKFnTeSsQh2xCewH0K+MxDaMjNjfiHlAiMQGf
         egSBdVtg1d/r7ecahjz+93DLxqi9nS0MhC1nz9WOgHFOE8lmy2nEi2XuUvOjHRTEPo1Z
         UOuMNPaA8jl3QPWg1UtdHDpOwOu/OgcMZiBWpaq03Y8Q23r8LSF1rfGtuQXP9UJB78aE
         EJ2XlL2eMsOdj/UsuFJ5o9XRaX2IemqrhD4/5l7aqdZStXqiuD4FhIKRfKhCNIBFT7+r
         D7c1a9bhn8eCUT6nson51SFoPP4V1MTXVWdZO0fzTgbmo90eqljoAQFbFkPXIMlCz0qr
         ci+Q==
X-Gm-Message-State: AOJu0YxlzY+U6mMbfbhZXkER/hd3VjwKvot8NJvBT0lPDbwoED8ayis6
        zvJXQpio4VvB/IGQ4ClQg7DISPmq7I8X9CmhodfIrg==
X-Google-Smtp-Source: AGHT+IEjBmC+pbqei2qtDo3mL+sJmHw+XHQjGTEbBmsKyn4Z+j3/jjv6U8X7iRAepAsSTOhDAOVdp6YLboMDHtxEOZo=
X-Received: by 2002:a17:906:739a:b0:9ae:37d9:8043 with SMTP id
 f26-20020a170906739a00b009ae37d98043mr2756098ejl.31.1695197748714; Wed, 20
 Sep 2023 01:15:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230920024001.493477-1-tfanelli@redhat.com>
In-Reply-To: <20230920024001.493477-1-tfanelli@redhat.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 20 Sep 2023 10:15:37 +0200
Message-ID: <CAJfpegtVbmFnjN_eg9U=C1GBB0U5TAAqag3wY_mi7v8rDSGzgg@mail.gmail.com>
Subject: Re: [PATCH 0/2] fuse: Rename DIRECT_IO_{RELAX -> ALLOW_MMAP}
To:     Tyler Fanelli <tfanelli@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, mszeredi@redhat.com,
        gmaglione@redhat.com, hreitz@redhat.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 20 Sept 2023 at 04:41, Tyler Fanelli <tfanelli@redhat.com> wrote:
>
> At the moment, FUSE_INIT's DIRECT_IO_RELAX flag only serves the purpose
> of allowing shared mmap of files opened/created with DIRECT_IO enabled.
> However, it leaves open the possibility of further relaxing the
> DIRECT_IO restrictions (and in-effect, the cache coherency guarantees of
> DIRECT_IO) in the future.
>
> The DIRECT_IO_ALLOW_MMAP flag leaves no ambiguity of its purpose. It
> only serves to allow shared mmap of DIRECT_IO files, while still
> bypassing the cache on regular reads and writes. The shared mmap is the
> only loosening of the cache policy that can take place with the flag.
> This removes some ambiguity and introduces a more stable flag to be used
> in FUSE_INIT. Furthermore, we can document that to allow shared mmap'ing
> of DIRECT_IO files, a user must enable DIRECT_IO_ALLOW_MMAP.
>
> Tyler Fanelli (2):
>   fs/fuse: Rename DIRECT_IO_RELAX to DIRECT_IO_ALLOW_MMAP
>   docs/fuse-io: Document the usage of DIRECT_IO_ALLOW_MMAP

Looks good.

Applied, thanks.  Will send the PR during this merge window, since the
rename could break stuff if already released.

Miklos
