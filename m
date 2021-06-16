Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D0023A9DA5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jun 2021 16:34:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234021AbhFPOgo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Jun 2021 10:36:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232825AbhFPOgn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Jun 2021 10:36:43 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A86E5C06175F
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Jun 2021 07:34:36 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id s22so4160138ljg.5
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Jun 2021 07:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EzpE/PF3cfY1eLzFRA73FlZ1JqOIKKJoSDAttfp8rT8=;
        b=aEkpR08iY2BVSl2UA6eAtimz49p6r04XmXetfU00ZlbN8/LmIF3FBGRAx3kjX2HwCO
         C9n5VvNPXa4xruqBOIHjGZSAkFE5wKdNQ8ymaFQoEhHgC2dWyqwBrxUT3tUcDqjctR+l
         tUR2uAhqEhxYU+e1Wf/wCxiCpnkmXDBh1C2i8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EzpE/PF3cfY1eLzFRA73FlZ1JqOIKKJoSDAttfp8rT8=;
        b=TNDoaQlY8tUy5bZB5GrWEer7ST2YPiRwhomgsVLrfaYlvhHFUjoA7YXRzbLFgJaqR5
         dNc2NliRUNqZ5x+lliiGthqj8LXlU8iQiTAjwPePq1CdhvOYIG/3VYcakqEIaLMqueLy
         Q/HHOli55binLMQRtp7cYHnTNc1p3EeEMG5i1u+LDpyvw/rFaaMH1jfm6+uJHRjBvgQ8
         3MQ4nO9u4jUP597aP/Qet+nZ8WDBWw+6hlJWHF7kfeSWEPib6jJotmPqwAIJpDNChKg+
         8f8yxkBbhJDz/HajeRG/6rpl4a9d0u5vZy0SxNtTkkTXDtLswMjVu/ocWNNWHindTFln
         IOQg==
X-Gm-Message-State: AOAM532PmZ4wcsdJrRhJiW+euWBjnnZfp0ly6cWho9x1YcUcp27e8p8m
        kDRnUVRv+BgByC+CAZ486RxmJYRRBbS28NDH6dI=
X-Google-Smtp-Source: ABdhPJxYvXuau03S/HnR6m+c2wgvLdXtT45pb2m6DWqBJ+IZ78Mrz/vB6y2AVmo/bixIQ0OPlMUp8w==
X-Received: by 2002:a05:651c:286:: with SMTP id b6mr83253ljo.373.1623854074838;
        Wed, 16 Jun 2021 07:34:34 -0700 (PDT)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id f9sm267289lft.63.2021.06.16.07.34.33
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jun 2021 07:34:33 -0700 (PDT)
Received: by mail-lj1-f173.google.com with SMTP id e25so4193488ljj.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Jun 2021 07:34:33 -0700 (PDT)
X-Received: by 2002:a2e:9ad5:: with SMTP id p21mr138537ljj.220.1623854073071;
 Wed, 16 Jun 2021 07:34:33 -0700 (PDT)
MIME-Version: 1.0
References: <162375813191.653958.11993495571264748407.stgit@warthog.procyon.org.uk>
 <CAHk-=whARK9gtk0BPo8Y0EQqASNG9SfpF1MRqjxf43OO9F0vag@mail.gmail.com>
 <f2764b10-dd0d-cabf-0264-131ea5829fed@infradead.org> <CAHk-=whPPWYXKQv6YjaPQgQCf+78S+0HmAtyzO1cFMdcqQp5-A@mail.gmail.com>
 <c2002123-795c-20ae-677c-a35ba0e361af@infradead.org> <051421e0-afe8-c6ca-95cd-4dc8cd20a43e@huawei.com>
 <200ea6f7-0182-9da1-734c-c49102663ccc@redhat.com>
In-Reply-To: <200ea6f7-0182-9da1-734c-c49102663ccc@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 16 Jun 2021 07:34:16 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjEThm5Kyockk1kJhd_K-P+972t=SnEj-WX9KcKPW0-Qg@mail.gmail.com>
Message-ID: <CAHk-=wjEThm5Kyockk1kJhd_K-P+972t=SnEj-WX9KcKPW0-Qg@mail.gmail.com>
Subject: Re: [PATCH] afs: fix no return statement in function returning non-void
To:     Tom Rix <trix@redhat.com>
Cc:     Zheng Zengkai <zhengzengkai@huawei.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        David Howells <dhowells@redhat.com>,
        Hulk Robot <hulkci@huawei.com>, linux-afs@lists.infradead.org,
        Marc Dionne <marc.dionne@auristor.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 16, 2021 at 5:56 AM Tom Rix <trix@redhat.com> wrote:
>
> A fix is to use the __noreturn attribute on this function

That's certainly a better thing. It would be better yet to figure out
why BUG() didn't do it automatically.

Without CONFIG_BUG, it looks like powerpc picks up

  #ifndef HAVE_ARCH_BUG
  #define BUG() do {} while (1)

which should still make it pointless to have the return.  But I might
have missed something.

             Linus
