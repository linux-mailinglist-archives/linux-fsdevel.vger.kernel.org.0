Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11E1176F0F3
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Aug 2023 19:54:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232439AbjHCRyt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Aug 2023 13:54:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230460AbjHCRyr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Aug 2023 13:54:47 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 302A81718;
        Thu,  3 Aug 2023 10:54:47 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id 46e09a7af769-6bb29b9044dso1187264a34.1;
        Thu, 03 Aug 2023 10:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691085286; x=1691690086;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=D7LTYlYje0TUsKNQaI2LboxS6Qn358z3O478ZJWdmjw=;
        b=r/9Z6eMPIOzREx6Pvs3xpquUvT3EprftDjYwww4EnfyyPnW5aBfE0MIAZ1aDjSzvT9
         WvW0snQ2jDtv0wx2co0Enz7OPaQQ+uP2Tc5JZZj6mOaMBMv6sMc5DqXMUtj2/OlY2m5I
         dJNkbK/PlXasSqx5tQ0VEs7VEmO3sAk7DDPOCDPFsgIKDVOEvkQuC1VSKOCtnjHWUV+n
         W41N2fDtZZ386PLVUyGMiH+4NFmKdqbUPt6T7vbrw8j0bITdmTVKb8imrJzk71tw75QR
         gXGZYRAw18BVMZ6Vx5zBdt2AZlcQcpnIILp3yYQADET8bP4MNIb9cn059OweH5lOPgkY
         xieg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691085286; x=1691690086;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D7LTYlYje0TUsKNQaI2LboxS6Qn358z3O478ZJWdmjw=;
        b=QCeenE2bhEJ7RcIo05PoBQyCcn4SzYenKL1kxmjCjiKlHEKLMBMN9U0SGhSUeMZNAW
         7jbNqMJXH8zqdDo383+mt0NFY0kHilfHijPhFmnIAnbfClZDwqCBeoRvaG+0FmxokgAq
         b0IAbI8ggDIvBkSejZAQgMNbxUmrwCQmDcQdPSG+CxeCSem3qUuPat9z9kQCbV1yj2EL
         GI5p5sBjWBx6/Ast10kSGSVDODt0OVG0feKPdO13TMvpDmB9FvPtV75EHptpjZ4oEi9I
         s2FrIxywT+lOU9Pws7DQc9aF8seiX+RvAqtbuObJxWm4xpgMO4M4uwkk7327/UFCmCYf
         gPCQ==
X-Gm-Message-State: ABy/qLYRDy32hQAo+/M7+Lq0Z93TZgQQSApI+3Z2eWotaBand1VJXcN2
        kwlgGS1Coh7mIgy7lEp/eVVLcrZq5xQyW3fMxdTaQwFCNRc=
X-Google-Smtp-Source: APBJJlFp89+GfmjeUHYM0Ku5hGfuU07pSvxYcwrTJACnuqOchCHvn4E4mKaaLnQHg4iL8fjqbDGTUZp7vuJRWVRtgKI=
X-Received: by 2002:a05:6830:52:b0:6b9:2e88:79cc with SMTP id
 d18-20020a056830005200b006b92e8879ccmr22282451otp.19.1691085286435; Thu, 03
 Aug 2023 10:54:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a8a:1183:0:b0:4f0:1250:dd51 with HTTP; Thu, 3 Aug 2023
 10:54:45 -0700 (PDT)
In-Reply-To: <CAHk-=whQ51+rKrnUYeuw3EgJMv2RJrwd7UO9qCgOkUdJzcirWw@mail.gmail.com>
References: <20230724-vfs-fdget_pos-v1-1-a4abfd7103f3@kernel.org>
 <CAHk-=whfJhag+iEscftpVq=dHTeL7rQopCvH+Pcs8vJHCGNvXQ@mail.gmail.com>
 <20230724-pyjama-papier-9e4cdf5359cb@brauner> <CAHk-=wj2XZqex6kzz7SbdVHwP9fFoOvHSzHj--0KuxyrVO+3-w@mail.gmail.com>
 <20230803095311.ijpvhx3fyrbkasul@f> <CAHk-=whQ51+rKrnUYeuw3EgJMv2RJrwd7UO9qCgOkUdJzcirWw@mail.gmail.com>
From:   Mateusz Guzik <mjguzik@gmail.com>
Date:   Thu, 3 Aug 2023 19:54:45 +0200
Message-ID: <CAGudoHG8X3Uvuj2Y7H9wnk8Rm=igAUvOF2XrzqYGs0wDvTzk2w@mail.gmail.com>
Subject: Re: [PATCH] file: always lock position
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Seth Forshee <sforshee@kernel.org>,
        linux-fsdevel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/3/23, Linus Torvalds <torvalds@linux-foundation.org> wrote:
> On Thu, 3 Aug 2023 at 02:53, Mateusz Guzik <mjguzik@gmail.com> wrote:
>>
>> So yes, atomics remain expensive on x86-64 even on a very moden uarch
>> and their impact is measurable in a syscall like read.
>
> Well, a patch like this should fix it.
>
> I intentionally didn't bother with the alpha osf version of readdir,
> because nobody cares, but I guess we could do this in the header too.
>
> Or we could have split the FMODE_ATOMIC_POS bit into two, and had a
> "ALWAYS" version and a regular version, but just having a
> "fdget_dir()" made it simpler.
>
> So this - together with just reverting commit 20ea1e7d13c1 ("file:
> always lock position for FMODE_ATOMIC_POS") - *should* fix any
> performance regression.
>

That would do it, but I'm uneasy about the partially "gimped" status
of the fd the caller can't do anything about.

I read the thread and still don't get what is the real-world use case
for the thing, a real-world consumer to take a look at would be nice.

As noted in another e-mail, the entire lack of pos locking in stock
kernel is a transient ordeal -- there is a point where the "donor" is
guaranteed to not use it and spot the refcount > 1 for any future use,
using pos locking going forward.

Perhaps, and I'm really just spitballing here, almost all expected use
cases would be 100% fine without pos lock so it all works out as is.
Similarly, if the target is multithreaded it already works as well.

Those who expect "fully qualified" semantics would pass a flag
argument denoting it but would possibly wait indefinitely while the
target is blocked somewhere in the kernel and it is not known if it is
even using the fd. This very well may be a deal breaker though and may
be too cumbersome to implement for real use.

All that said, personally I would either go forward with a "full fix"
(probably not worth it) or take the L and lock for all fds.

-- 
Mateusz Guzik <mjguzik gmail.com>
