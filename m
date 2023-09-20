Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6E837A77C7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Sep 2023 11:42:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234131AbjITJmd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Sep 2023 05:42:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232338AbjITJmb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Sep 2023 05:42:31 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A8349E
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Sep 2023 02:42:25 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-5315b70c50dso3163483a12.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Sep 2023 02:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1695202943; x=1695807743; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sPlkIvPDxHBu09fqyp3+rcJT14SZCmXx3kcNtFIsNHA=;
        b=LGF3wy/6BP4rTpA6OxATm+cFbrSp6xO2/sdYSRGAWvmYx5uWsUg4bX9XoMxEn/TDNV
         dNIVYIQTG9Nlp81YE/newR0T6Gjyn6tniBBQYECLoy68eQ+5/1if1b3H26FE33HGS7f2
         9SlpEDjT+Mu48kunkBlt8MPOogVSxX3m2Ffi8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695202943; x=1695807743;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sPlkIvPDxHBu09fqyp3+rcJT14SZCmXx3kcNtFIsNHA=;
        b=AWm2E8ylCP5YS2Nf0wFoMvgs7fwa2AqknV2b4KYRKjh5e/zy07X5bljEKsymaa6gDC
         NspWSpFzv1PTpnJupI7OELtX3BBwwHMKim/D9AY3epz7P1g69X9AZ1hWvjW+Pr5fnZcM
         sUtqY+isKt9TIhUMpt1XMpOCEt484/GfUScKu9gmobSm+m/h+xo4vvW13hrU8F0vy0M2
         ssNYBtqGVEeMBHJsdVFF903pxZhKEREO10fYU36aaCTSXsz2Raam4vN94/FvGHKn5Y+W
         jXu2kJQRBFkit2DJUXDNpSqDgab2XmC6raV9Mxzj/2LhYMXJMhM5sbDa6eT4eW9rrTQ9
         RK9A==
X-Gm-Message-State: AOJu0YwBg0Z4gWMeZ9ruNnA+ZM79tXzbiLwDT9huxS9mFWp82A7OKBUl
        2jodq+HrHxeXh9FUpWswOhT5gQc+RMHU8x20Mx/GVA==
X-Google-Smtp-Source: AGHT+IGbxlevBwR6/CUZrxHt/0KkW1ezOx8b8uj9MHT64X1QkBY9+uMrq/r34Kpm3OqbttRaWQsd2frU9FSaMrU6P3Y=
X-Received: by 2002:a17:907:78d0:b0:9a9:f136:3aa4 with SMTP id
 kv16-20020a17090778d000b009a9f1363aa4mr1616580ejc.38.1695202943718; Wed, 20
 Sep 2023 02:42:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230914-salzig-manifest-f6c3adb1b7b4@brauner>
 <CAJfpegs-sDk0++FjSZ_RuW5m-z3BTBQdu4T9QPtWwmSZ1_4Yvw@mail.gmail.com>
 <20230914-lockmittel-verknallen-d1a18d76ba44@brauner> <CAJfpegt-VPZP3ou-TMQFs1Xupj_iWA5ttC2UUFKh3E43EyCOQQ@mail.gmail.com>
 <20230918-grafik-zutreffen-995b321017ae@brauner> <CAOssrKfS79=+F0h=XPzJX2E6taxAPmEJEYPi4VBNQjgRR5ujqw@mail.gmail.com>
 <20230918-hierbei-erhielten-ba5ef74a5b52@brauner> <CAJfpegtaGXoZkMWLnk3PcibAvp7kv-4Yobo=UJj943L6v3ctJQ@mail.gmail.com>
 <20230918-stuhl-spannend-9904d4addc93@brauner> <CAJfpegvxNhty2xZW+4MM9Gepotii3CD1p0fyvLDQB82hCYzfLQ@mail.gmail.com>
 <20230918-bestialisch-brutkasten-1fb34abdc33c@brauner> <CAJfpegvTiK=RM+0y07h-2vT6Zk2GCu6F98c=_CNx8B1ytFtO-g@mail.gmail.com>
 <20230919003800.93141-1-mattlloydhouse@gmail.com> <CAJfpegs6g8JQDtaHsECA_12ss_8KXOHVRH9gwwPf5WamzxXOWQ@mail.gmail.com>
 <20230919212840.144314-1-mattlloydhouse@gmail.com>
In-Reply-To: <20230919212840.144314-1-mattlloydhouse@gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 20 Sep 2023 11:42:11 +0200
Message-ID: <CAJfpeguMf7ouiW79iey1i68kYnCcvcpEXLpUNf+CF=aNWxXO2Q@mail.gmail.com>
Subject: Re: [RFC PATCH 2/3] add statmnt(2) syscall
To:     Matthew House <mattlloydhouse@gmail.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-man@vger.kernel.org,
        linux-security-module@vger.kernel.org, Karel Zak <kzak@redhat.com>,
        Ian Kent <raven@themaw.net>,
        David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        Amir Goldstein <amir73il@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 19 Sept 2023 at 23:28, Matthew House <mattlloydhouse@gmail.com> wrote:

> More generally speaking, the biggest reason I dislike the current single-
> buffer interface is that the output is "all or nothing": either the caller
> has enough space in the buffer to store every single string, or it's unable
> to get any fields at all, just an -EOVERFLOW. There's no room for the
> caller to say that it just wants the integer fields and doesn't care about
> the strings. Thus, to reliably call statmnt() on an arbitrary mount, the
> ability to dynamically allocate memory is effectively mandatory. The only
> real solution to this would be additional statx-like flags to select the
> returned strings.

It's already there:

#define STMT_MNT_ROOT 0x00000008U /* Want/got mnt_root  */
#define STMT_MNT_POINT 0x00000010U /* Want/got mnt_point */
#define STMT_FS_TYPE 0x00000020U /* Want/got fs_type */

For example, it's perfectly fine to do the following, and it's
guaranteed not to return EOVERFLOW:

        struct statmnt st;
        unsigned int mask = STMT_SB_BASIC | STMT_MNT_BASIC;

        ret = statmount(mnt_id, mask, &st, sizeof(st), flags);

> Besides that, if the caller is written in standard C but doesn't want to
> use malloc(3) to allocate the buffer, then its helper function must be
> written very carefully (with a wrapper struct around the header and data)
> to satisfy the aliasing rules, which forbid programs from using a struct
> statmnt * pointer to read from a declared char[N] array.

I think you interpret aliasing rules incorrectly.  The issue with
aliasing is if you access the same piece of memory though different
types.  Which is not the case here.  In fact with the latest
incarnation of the interface[1] there's no need to access the
underlying buffer at all:

        printf("mnt_root: <%s>\n", st->str + st->mnt_root);

So the following is perfectly safe to do (as long as you don't care
about buffer overflow):

        char buf[10000];
        struct statmnt *st = (void *) buf;

        ret = statmount(mnt_id, mask, st, sizeof(buf), flags);

If you do care about handling buffer overflows, then dynamic
allocation is the only sane way.

And before you dive into how this is going to be horrible because the
buffer size needs to be doubled an unknown number of times, think a
bit:  have you *ever* seen a line in /proc/self/mountinfo longer than
say 1000 characters?   So if the buffer starts out at 64k, how often
will this doubling happen?   Right: practically never.  Adding
complexity to handle this case is nonsense, as I've said many times.
And there is definitely nonzero complexity involved (just see the
special casing in getxattr and listxattr implementations all over the
place).

Thanks,
Miklos

[1] git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/vfs.git#statmount-v2
