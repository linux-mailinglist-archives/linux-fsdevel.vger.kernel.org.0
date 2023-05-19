Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B852709C6D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 May 2023 18:30:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbjESQaU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 May 2023 12:30:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230111AbjESQaT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 May 2023 12:30:19 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2005C1
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 May 2023 09:30:17 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2ac836f4447so38494901fa.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 May 2023 09:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1684513816; x=1687105816;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kK1ZTkygyrBiweN68dKEUcpOojpjbump5mMSvci/Nuk=;
        b=Sjhvkk2GxQhG4iAmAY5uw9IcngF2TuKIYUlQVWQDgnn8viw8Vus3J2UYKi2pRt9EnZ
         GhCdb7Jq/wi9B5BwBvPyi3KlB4RUQJiLnpSeBir9WyUpCj2gCAKYiibZNOEivOKI3lYw
         tPEJ7cbGmkqhCC/TBZIKntAr1zVz3XZ89U/mU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684513816; x=1687105816;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kK1ZTkygyrBiweN68dKEUcpOojpjbump5mMSvci/Nuk=;
        b=I1ZSKbKj64XriFdKj76Zrq2UcvBWUA/h7UM98I3AxzTZuXdUw+nYo6QHvfho9sDVfO
         ZaOmC0NkjGCKf+Vv9a74UhMGPLranfiT6HooYHYXe9ffsw9KZu15Jupg9kNnznN6XGGf
         DzoGPeKbsu1m3Xh5flme0iEkHeNs4MEirhVtR0qgTNKq9uM5t8KH/BoQ0zd4SzSPqqXl
         FbtpD6qjbC0Sd3IfcmPFe5lMVoetdZxGX5T7mjH9lTnXpZC3zVXaYuaiYVNjHKKr/uX9
         TL5baDIOVmuAuYmZ7bW88GuTLWDXF8pV6zkPEmmgwHSPAFTLT7Tn+0WHsm5zHmrvktov
         sKyQ==
X-Gm-Message-State: AC+VfDyI8FCz0rDK1fgqbPjwX695Qt1eetLQM3tphS8wvhYpHcduEmeA
        pIqJSSLPuLzNHbUEtvJXgdtZ6IBuY1RAbzI6dgiikFNf
X-Google-Smtp-Source: ACHHUZ5UmiZSe0UzO4+VMsiNOehU7SVjmtFoa1mO6mzeTpV8oz4GFGZh3qJB1KfseUdFCfYbI6h6Lw==
X-Received: by 2002:a2e:b165:0:b0:2ad:7943:4c15 with SMTP id a5-20020a2eb165000000b002ad79434c15mr1062147ljm.14.1684513816042;
        Fri, 19 May 2023 09:30:16 -0700 (PDT)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id o13-20020ac2494d000000b004efe9fc130esm638818lfi.251.2023.05.19.09.30.15
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 May 2023 09:30:15 -0700 (PDT)
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2af177f12d1so24727771fa.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 May 2023 09:30:15 -0700 (PDT)
X-Received: by 2002:a05:6402:2d5:b0:510:f6e0:7d9f with SMTP id
 b21-20020a05640202d500b00510f6e07d9fmr2254674edx.13.1684513359285; Fri, 19
 May 2023 09:22:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230519074047.1739879-1-dhowells@redhat.com> <20230519074047.1739879-10-dhowells@redhat.com>
 <ZGcvfLWAqmOLrnLj@infradead.org>
In-Reply-To: <ZGcvfLWAqmOLrnLj@infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 19 May 2023 09:22:22 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgzSLXt38J_B2=QWCDi7A1c5B0_cJ3XYRj9rYn+YXbjQA@mail.gmail.com>
Message-ID: <CAHk-=wgzSLXt38J_B2=QWCDi7A1c5B0_cJ3XYRj9rYn+YXbjQA@mail.gmail.com>
Subject: Re: [PATCH v20 09/32] tty, proc, kernfs, random: Use direct_splice_read()
To:     Christoph Hellwig <hch@infradead.org>
Cc:     David Howells <dhowells@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hillf Danton <hdanton@sina.com>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 19, 2023 at 1:12=E2=80=AFAM Christoph Hellwig <hch@infradead.or=
g> wrote:
>
> Pinging Al (and maybe Linus): is there any good reason to not simply
> default to direct_splice_read if ->read_iter is implemented and
> ->splice_read is not once you remove ITER_PIPE?

For me, the reason isn't so much technical as "historical pain".

We've had *so* many problems with splice on random file descriptors
that I at some point decided "no splice by default".

Now, admittedly most of the problems were due to the whole set_fs()
ambiguity, which you fixed and no longer exists. So maybe we could go
back to "implement splice by default".

I agree that as long as the default implementation is obviously safe,
it should be ok, and maybe direct_splice_read is that obvious..

           Linus
