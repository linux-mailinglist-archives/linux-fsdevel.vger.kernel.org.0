Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9231A3AA12D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jun 2021 18:23:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235271AbhFPQZP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Jun 2021 12:25:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24332 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235279AbhFPQZO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Jun 2021 12:25:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623860587;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zx7YyWxObSgQ3AARWzsKqBj+Jwmxzr3yV4ImeZmYiso=;
        b=GXTW5VByxYLOSHYh9FbpLrKvIpiMekcJHaeg2wHesBxI4xF1wl+0NXd9az2jSGXXcuFh1a
        33LSJv8dJ7Dka18V+FwRd8f269DUNd45rBrWggtxk4oQepIfPdoS8jhphngz+jjt+GMvHb
        VXleF+yBbft+6mcUUpr7NA0L+2pbs7M=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-405-tcYhNW5bMWqMS-2kF0qRMQ-1; Wed, 16 Jun 2021 12:22:06 -0400
X-MC-Unique: tcYhNW5bMWqMS-2kF0qRMQ-1
Received: by mail-oi1-f199.google.com with SMTP id h67-20020aca53460000b02901f9abff7c53so1331943oib.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Jun 2021 09:22:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=zx7YyWxObSgQ3AARWzsKqBj+Jwmxzr3yV4ImeZmYiso=;
        b=dCJNf9JQ0VaHUayNNnHttK/556obQCkMpbVlDF8bfpfwO/B6MFDHV9ppPDKh4op+kq
         Vjw/yYEcj5vPInIv/VEobGVLtzJn4DLT+2njtQ1giRuAfgYB1pW4EIQ9pia1CwE5uwr2
         juhAPpTT9zGQAUFwzoZWHiQ4Pk8XF+OrHDKSzBr+fjFYM9cZIJm79rLQEt0vl0Ag/HGT
         J38a2GNLQ2e02O2wh+0/XreQ4gqaQV6MrDfP1uuXjnYgdKpmBsF9+ONIbAQWQQ8iDiJ7
         1Iwkym+IRiU07SII+PDoJpMP4ZMsiX97SB1qPBMae+4ovpth9nmMRCix1LnNq6suTPnW
         0EfA==
X-Gm-Message-State: AOAM533TB/UnmRzAsBLlD2jgBM0EtBMbhkpVOtTV9WQp5pqPYEP/cqsn
        eyzSj8EKtIvG/7O0/AkI61hr1H3rWcLqsyQe8LJSLmu7ekWISrudbWh9aN7KYp7LTZwcm0F7VmD
        stHzRUUmxW1IXuf4sXKSZJ1PiFw==
X-Received: by 2002:a05:6830:1bf7:: with SMTP id k23mr634424otb.206.1623860525304;
        Wed, 16 Jun 2021 09:22:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzOpiMEWLaI9ZVfcTiMnktDFGsastIpKNz5sl9Bmv84fu1NFJcJQvLypehL7oAjbtR9BC6kAA==
X-Received: by 2002:a05:6830:1bf7:: with SMTP id k23mr634408otb.206.1623860525115;
        Wed, 16 Jun 2021 09:22:05 -0700 (PDT)
Received: from localhost.localdomain (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id y7sm506227oix.36.2021.06.16.09.22.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jun 2021 09:22:04 -0700 (PDT)
Subject: Re: [PATCH] afs: fix no return statement in function returning
 non-void
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Zheng Zengkai <zhengzengkai@huawei.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        David Howells <dhowells@redhat.com>,
        Hulk Robot <hulkci@huawei.com>, linux-afs@lists.infradead.org,
        Marc Dionne <marc.dionne@auristor.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <162375813191.653958.11993495571264748407.stgit@warthog.procyon.org.uk>
 <CAHk-=whARK9gtk0BPo8Y0EQqASNG9SfpF1MRqjxf43OO9F0vag@mail.gmail.com>
 <f2764b10-dd0d-cabf-0264-131ea5829fed@infradead.org>
 <CAHk-=whPPWYXKQv6YjaPQgQCf+78S+0HmAtyzO1cFMdcqQp5-A@mail.gmail.com>
 <c2002123-795c-20ae-677c-a35ba0e361af@infradead.org>
 <051421e0-afe8-c6ca-95cd-4dc8cd20a43e@huawei.com>
 <200ea6f7-0182-9da1-734c-c49102663ccc@redhat.com>
 <CAHk-=wjEThm5Kyockk1kJhd_K-P+972t=SnEj-WX9KcKPW0-Qg@mail.gmail.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <9d7873b6-e35c-ae38-9952-a1df443b2aea@redhat.com>
Date:   Wed, 16 Jun 2021 09:22:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CAHk-=wjEThm5Kyockk1kJhd_K-P+972t=SnEj-WX9KcKPW0-Qg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 6/16/21 7:34 AM, Linus Torvalds wrote:
> On Wed, Jun 16, 2021 at 5:56 AM Tom Rix <trix@redhat.com> wrote:
>> A fix is to use the __noreturn attribute on this function
> That's certainly a better thing. It would be better yet to figure out
> why BUG() didn't do it automatically.
>
> Without CONFIG_BUG, it looks like powerpc picks up
>
>    #ifndef HAVE_ARCH_BUG
>    #define BUG() do {} while (1)
>
> which should still make it pointless to have the return.  But I might
> have missed something.

This looks like a problem the generic BUG().

with CONFIG_BUG=y, the *.i is

static int afs_dir_set_page_dirty(struct page *page)
{
  do { __asm__ __volatile__( "1:    " "twi 31, 0, 0" "\n" ".section 
__bug_table,\"aw\"\n" "2:\t.4byte 1b - 2b, %0 - 2b\n" "\t.short %1, 
%2\n" ".org 2b+%3\n" ".previous\n" : : "i" ("fs/afs/dir.c"), "i" (50), 
"i" (0), "i" (sizeof(struct bug_entry))); do { ; asm volatile(""); 
__builtin_unreachable(); } while (0); } while (0);
}
BUG() expanded from
#define BUG() do {                        \
     BUG_ENTRY("twi 31, 0, 0", 0);                \
     unreachable();                        \
} while (0)


with CONFIG_BUG=n, the *.i is

static int afs_dir_set_page_dirty(struct page *page)
{
  do {} while (1);
}

BUG() expanded from
  do {} while (1)

to fix, add an unreachable() to the generic BUG()

diff --git a/include/asm-generic/bug.h b/include/asm-generic/bug.h
index f152b9bb916f..b250e06d7de2 100644
--- a/include/asm-generic/bug.h
+++ b/include/asm-generic/bug.h
@@ -177,7 +177,10 @@ void __warn(const char *file, int line, void 
*caller, unsigned taint,

  #else /* !CONFIG_BUG */
  #ifndef HAVE_ARCH_BUG
-#define BUG() do {} while (1)
+#define BUG() do {                                             \
+               do {} while (1);                                \
+               unreachable();                                  \
+       } while (0)
  #endif

the new *.i

static int afs_dir_set_page_dirty(struct page *page)
{
  do { do {} while (1); do { ; asm volatile(""); 
__builtin_unreachable(); } while (0); } while (0);
}

The assembly is unchanged.

The key being the unreachable builtin

ref: gcc docs https://gcc.gnu.org/onlinedocs/gcc/Other-Builtins.html

" ... without the __builtin_unreachable, GCC issues a
   warning that control reaches the end of a non-void function."

Tom

>
>               Linus
>

