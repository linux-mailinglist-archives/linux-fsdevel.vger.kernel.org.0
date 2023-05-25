Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51CBA711215
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 May 2023 19:25:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233904AbjEYRZH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 May 2023 13:25:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231745AbjEYRZG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 May 2023 13:25:06 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BD10E63
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 May 2023 10:24:48 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-510d6e1f1b2so4639269a12.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 May 2023 10:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1685035487; x=1687627487;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3TG2KiabOTIRDETeuidPveq5vd/DC84WzmbIAz8Xbn0=;
        b=g/c3t+Jte85Hauun7NR2559wp9vRtlwRU1Ir9tnqHBR+XkmM/1G6dp1+QIxHdLgmXq
         28vM+W/gx3SIJDmWcdsX6p5+IoNP7VHmHQ376lp+7Qjo6QoTOmHqFd+Zj0m6V4rbhHvZ
         Q7GotxjIyWBLkDgHBUBxG1XTAnwI7PQa3ApdA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685035487; x=1687627487;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3TG2KiabOTIRDETeuidPveq5vd/DC84WzmbIAz8Xbn0=;
        b=K4nCOxDyRf0KaE7NTBCbVBTtKwJ6Fc9WVOrTiLBIToevS7T3XaaHVEVRHvLSMB3eyf
         hISRUZXQJ8IiCvDLZcq8Oubg0o+k+t5d2DHyJ/XBL00uglWYEvucdAMpCz7LVcE77ABx
         7TXArwaRzHGxxU1F8sY6FcRknumz/OPO6WSjs3GQOC7FHgwqmhCGoRN7BTtmVnDIi9A8
         ivelXdeS5Cr0UcTv/G/EAum0l/mPm2W2JVX+fESEuhwAk6AW62RyEZrP9M75UIh0CsxZ
         Ver1z1lT2+H+hm95CL0i2KIlrK15cqw3hfiEO2Q2rUTbs3EY6bwtJJ2L/9GLxakbPSy4
         WY2w==
X-Gm-Message-State: AC+VfDy2T13LztMikoqzY52AyzEbH8A4F/bJ/D8mG0upltgNpTEgV5BA
        fSj1Vcdie1calBXKY7nS/npdIZnkrblr3pUfLlpQIodX
X-Google-Smtp-Source: ACHHUZ4a/uVuSrKFtyi7vumxFbMRSpIOUFF2kz684eWL+1d8r/C0W9M9AkJdRzoS9cr5qmLeTirjxA==
X-Received: by 2002:a17:906:ef07:b0:96f:74d0:ad0e with SMTP id f7-20020a170906ef0700b0096f74d0ad0emr2078117ejs.58.1685035486760;
        Thu, 25 May 2023 10:24:46 -0700 (PDT)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com. [209.85.208.45])
        by smtp.gmail.com with ESMTPSA id gg26-20020a170906e29a00b00973a9d66f56sm1060144ejb.206.2023.05.25.10.24.46
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 May 2023 10:24:46 -0700 (PDT)
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-50bcb229adaso4633127a12.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 May 2023 10:24:46 -0700 (PDT)
X-Received: by 2002:a17:907:9289:b0:96a:6723:da48 with SMTP id
 bw9-20020a170907928900b0096a6723da48mr1860929ejc.75.1685035054236; Thu, 25
 May 2023 10:17:34 -0700 (PDT)
MIME-Version: 1.0
References: <ZGxfrOLZ4aN9/MvE@infradead.org> <20230522205744.2825689-1-dhowells@redhat.com>
 <3068545.1684872971@warthog.procyon.org.uk> <ZG2m0PGztI2BZEn9@infradead.org>
 <3215177.1684918030@warthog.procyon.org.uk> <CAHk-=wjaqHgd4u63XdZoTPs1YCJnDZ7-GQHKKdFrT32y2-__tw@mail.gmail.com>
 <e00ee9f5-0f02-6463-bc84-b94c17f488bc@redhat.com> <98511.1685034443@warthog.procyon.org.uk>
In-Reply-To: <98511.1685034443@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 25 May 2023 10:17:17 -0700
X-Gmail-Original-Message-ID: <CAHk-=wht8Z=Vm-WkvZ2fMcBkF+CZSwm0nMpbtFoKc5_o+0oEbQ@mail.gmail.com>
Message-ID: <CAHk-=wht8Z=Vm-WkvZ2fMcBkF+CZSwm0nMpbtFoKc5_o+0oEbQ@mail.gmail.com>
Subject: Re: Extending page pinning into fs/direct-io.c
To:     David Howells <dhowells@redhat.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hillf Danton <hdanton@sina.com>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
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

On Thu, May 25, 2023 at 10:07=E2=80=AFAM David Howells <dhowells@redhat.com=
> wrote:
>
> Should everywhere that is using ZERO_PAGE(0) actually be using my_zero_pf=
n()?

No, that would just make code uglier for no reason, because then you
have to turn that pfn into a virtual address.

So if what you *want* is a pfn to begin with, then use, use my_zero_pfn().

But if what you want is just the virtual address, use ZERO_PAGE().

And if you are going to map it at some address, give it the address
you're going to use, otherwise just do zero for "whatever".

The only thing you can't use ZERO_PAGE(0) for is literally that "is
this a zero page" address comparison, because ZERO_PAGE(0) is just
_one_ address.

                   Linus
