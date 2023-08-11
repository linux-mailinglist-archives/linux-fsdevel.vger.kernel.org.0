Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ADCD7796E9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Aug 2023 20:16:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233755AbjHKSQb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Aug 2023 14:16:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235816AbjHKSQa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Aug 2023 14:16:30 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A179030E5
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Aug 2023 11:16:29 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-51a52a7d859so6954483a12.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Aug 2023 11:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1691777788; x=1692382588;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yc08NlpUYdnLIv24Lptdj+fSBDTOBa932kABNWFPLk4=;
        b=dlJ1tEDlztHmryjbQZih0pdyEUsXg81udRjdiDTbqn2QFS3KT0ZuyD4/c5fLwlboLE
         RiNMr+EnCv/TL/33QqpDGg0ZaHXezf8UK1U/fFXHKmXCbe1Kxf7+3pYUa8TYpyIPsi6x
         MDst4WAHK23JqgtOxCIw86lrY5lL5nLZZtTts=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691777788; x=1692382588;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yc08NlpUYdnLIv24Lptdj+fSBDTOBa932kABNWFPLk4=;
        b=lDd7+ydnPmptzyiArNjH+GiTI53luudQSypTbOb+9fPW/949nreZXV8pooHkWt/RPa
         ygBQLEvsrKYRrKy2/EMYX2NzzdNw76L+MoSmzcnMauFDEty/b4wxD4o9/w8DhNsuXdQN
         +ZfUeAWVF06jCr03mggjepUz/8BPqxH2gMzNrZwgOCfdNdTSGIKRai27d1eZ3DL2PGbl
         sTu+aH4QmgDNhI88N+H27rf1MPNhO85CznfzRUxjtKBAhIDiuTIkdNdk2YfuNBKScDMm
         oPIAsonuA5hv1a0WDLh3yPUHB0YAmId9w/U6K9KczFSSKO3lI0ibLDzydOWjNMzlxtZt
         UOMQ==
X-Gm-Message-State: AOJu0Yx1+2vmeLoAdNHqJMNcgq/3Tgv0Nm60jQQoYKY783SmZpMlCIY8
        GVbaRWJRE0K2C8Vjpd8YaygEFa70sFow0wC/KGQVtu+S
X-Google-Smtp-Source: AGHT+IGeHjEO0O/knnArXSI7gHXAXuoO/Y+I0Wz5hMOM+SAqxVfYKV0Scp6gbf4CoD3q6VF00OAwFA==
X-Received: by 2002:a17:907:1c23:b0:98e:3dac:6260 with SMTP id nc35-20020a1709071c2300b0098e3dac6260mr7160651ejc.13.1691777327787;
        Fri, 11 Aug 2023 11:08:47 -0700 (PDT)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id i18-20020a1709061cd200b0098e422d6758sm2498760ejh.219.2023.08.11.11.08.47
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Aug 2023 11:08:47 -0700 (PDT)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-51a52a7d859so6941753a12.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Aug 2023 11:08:47 -0700 (PDT)
X-Received: by 2002:aa7:dad9:0:b0:521:ad49:8493 with SMTP id
 x25-20020aa7dad9000000b00521ad498493mr3461940eds.6.1691777323138; Fri, 11 Aug
 2023 11:08:43 -0700 (PDT)
MIME-Version: 1.0
References: <3710261.1691764329@warthog.procyon.org.uk> <CAHk-=wi1QZ+zdXkjnEY7u1GsVDaBv8yY+m4-9G3R34ihwg9pmQ@mail.gmail.com>
 <3888331.1691773627@warthog.procyon.org.uk>
In-Reply-To: <3888331.1691773627@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 11 Aug 2023 11:08:26 -0700
X-Gmail-Original-Message-ID: <CAHk-=whsKN50RfZAP4EL12djwvMiWYKTca_5AYxPnHNzF7ffvg@mail.gmail.com>
Message-ID: <CAHk-=whsKN50RfZAP4EL12djwvMiWYKTca_5AYxPnHNzF7ffvg@mail.gmail.com>
Subject: Re: [RFC PATCH] iov_iter: Convert iterate*() to inline funcs
To:     David Howells <dhowells@redhat.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Christian Brauner <christian@brauner.io>,
        Matthew Wilcox <willy@infradead.org>, jlayton@kernel.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
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

On Fri, 11 Aug 2023 at 10:07, David Howells <dhowells@redhat.com> wrote:
>
> Hmmm...  It seems that using if-if-if rather than switch() gets optimised
> better in terms of .text space.  The attached change makes things a bit
> smaller (by 69 bytes).

Ack, and that also makes your change look more like the original code
and more as just a plain "turn macros into inline functions".

As a result the code diff initially seems a bit smaller too, but then
at some point it looks like at least clang decides that it can combine
common code and turn those 'ustep' calls into indirect calls off a
conditional register, ie code like

        movq    $memcpy_from_iter, %rax
        movq    $memcpy_from_iter_mc, %r13
        cmoveq  %rax, %r13
        [...]
        movq    %r13, %r11
        callq   __x86_indirect_thunk_r11

Which is absolutely horrible. It might actually generate smaller code,
but with all the speculation overhead, indirect calls are a complete
no-no. They now cause a pipeline flush on a large majority of CPUs out
there.

That code generation is not ok, and the old macro thing didn't
generate it (because it didn't have any indirect calls).

And it turns out that __always_inline on those functions doesn't even
help, because the fact that it's called through an indirect function
pointer means that at least clang just keeps it as an indirect call.

So I think you need to remove the changes you did to
memcpy_from_iter(). The old code was an explicit conditional of direct
calls:

        if (iov_iter_is_copy_mc(i))
                return (void *)copy_mc_to_kernel(to, from, size);
        return memcpy(to, from, size);

and now you do that

                                   iov_iter_is_copy_mc(i) ?
                                   memcpy_from_iter_mc : memcpy_from_iter);

to pass in a function pointer.

Not ok. Not ok at all. It may look clever, but function pointers are
bad. Avoid them like the plague.

            Linus
