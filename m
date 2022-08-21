Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E892E59B146
	for <lists+linux-fsdevel@lfdr.de>; Sun, 21 Aug 2022 04:11:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236495AbiHUCGY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 20 Aug 2022 22:06:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233554AbiHUCGW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 20 Aug 2022 22:06:22 -0400
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10198186FE;
        Sat, 20 Aug 2022 19:06:22 -0700 (PDT)
Received: by mail-vs1-xe31.google.com with SMTP id o123so7958328vsc.3;
        Sat, 20 Aug 2022 19:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=1a9o11nrbt8l9Dxa/LaB4FbQcO2jVF1njMU4jgfxm10=;
        b=jGjRAf+/Zn4r3ujXn4UvUUVpAX5jvYKaTvbrmkGU2XKN1L3ikzvepj9LTAyhVhfRNG
         bAJzOraVqNEZewDYYgrv7/tg9rv4mStI+XBRdE/xIqJ28tciheGtSYEUpM2KvdnR6HY9
         162Eq8VnLusezz7ecYmVZhQryNI1o8tlNph6UZSMpDIzIKQy5rwX5yxgOFpAcTK050HP
         A2GxM2TSGySBjRtYPrbFbUxNtTSO7zL8z6Rh1BwlR81Ne3PUOArkYhkEBHge8vXQ67et
         s45mPXf0QG0FusKgInmaxQUBshUU8jKtb8FctphrbNvF4DMe+WMXK2pQRwwat5z94RAC
         gaZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=1a9o11nrbt8l9Dxa/LaB4FbQcO2jVF1njMU4jgfxm10=;
        b=HkviydYWHEOUsgTVwDO5gKvnwzjplChYbtgvMPCDqq5Y/yANOIJcJstRa+dsHRGSn0
         Jrr9u2zugySIfDyiUPH6NwufsD4sRIbNNBaAow6fQAlR6YKpWqLYmqqogVw22cyH5Oqg
         1xVEsTDV0SlGeMzssbApRh6aCBGxzg62IrD/OgzqQw8lGP2rm4iV7rflSlaTwcFLIGag
         DlRRn73Up2DwYA8OR1fHJRZU/VJgcqsp79kaJx+//LQcT6mkzWrYWXcP/zrvT05Md7Gr
         t3kHRxBCzJ0q6t31FjmXommo80qvN47JWx+BrJQi+ExcNEPj3ry/f/MaNo8w7c+gP8OF
         p7aQ==
X-Gm-Message-State: ACgBeo30VOg2CqWejUUzoHAI2weUi2yUR7695SmR6umOV1p4C3hBm0wx
        5xLrx5dJhpZVwvDZJuh+f8kV7TIeDS4NUUz8RBU=
X-Google-Smtp-Source: AA6agR5K87YPtaxh3q3HxU04dWcBu+cE//vPS9Jl1hznEx/UtUZNy7IWOBFYRoYLq2johEBaMsV0IlXkTrCPapAhANU=
X-Received: by 2002:a05:6102:3e82:b0:38a:ab1a:2702 with SMTP id
 m2-20020a0561023e8200b0038aab1a2702mr5195779vsv.29.1661047580975; Sat, 20 Aug
 2022 19:06:20 -0700 (PDT)
MIME-Version: 1.0
References: <Yv2qoNQg48rtymGE@ZenIV> <Yv2rCqD7M8fAhq5v@ZenIV>
 <CAKYAXd-Xsih1TKTbM0kTGmjQfpkbpp7d3u9E7USuwmiSXLVvBw@mail.gmail.com>
 <Yv6igFDtDa0vmq6H@ZenIV> <CAKYAXd-6fT5qG2VmVG6Q51Z8-_79cjKhERHDatR_z62w19+p1Q@mail.gmail.com>
 <YwBZPCy0RBc9hwIk@ZenIV> <CAKYAXd9DGgLJ=-hcdADXVZUqp2aYRkGr2YKpfUND6S_GuaWgWQ@mail.gmail.com>
 <YwD+y2cXpcenIHlW@ZenIV>
In-Reply-To: <YwD+y2cXpcenIHlW@ZenIV>
From:   Steve French <smfrench@gmail.com>
Date:   Sat, 20 Aug 2022 21:06:09 -0500
Message-ID: <CAH2r5msb_n2LxUAPGRzDfFRfJ7HFv2SrAb1N5_nKJVscJH04bQ@mail.gmail.com>
Subject: Re: [PATCH 4/5] ksmbd: don't open-code %pf
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Namjae Jeon <linkinjeon@kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>
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

merged into ksmbd-for-next

On Sat, Aug 20, 2022 at 10:34 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Sat, Aug 20, 2022 at 02:44:29PM +0900, Namjae Jeon wrote:
> > > OK...  FWIW, I've another ksmbd patch hanging around and it might be
> > > less PITA if I put it + those two patches into never-rebased branch
> > > (for-ksmbd) for ksmbd folks to pull from.  Fewer pointless conflicts
> > > that way...
> > Okay, Thanks for this. I'm trying to resend "ksmbd: fix racy issue
> > from using ->d_parent and ->d_name" patch to you, but It conflict with
> > these patches:)
> > We will pull them from that branch if you create it.
>
> OK, pull request follows:
>
> The following changes since commit 568035b01cfb107af8d2e4bd2fb9aea22cf5b868:
>
>   Linux 6.0-rc1 (2022-08-14 15:50:18 -0700)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-ksmbd
>
> for you to fetch changes up to f2ea6d96500dd8947467f774d70700c1ba3ed8ef:
>
>   ksmbd: constify struct path (2022-08-20 10:54:48 -0400)
>
> ----------------------------------------------------------------
> assorted ksmbd cleanups
>
> Al Viro <viro@zeniv.linux.org.uk>
>
> ----------------------------------------------------------------
> Al Viro (3):
>       ksmbd: don't open-code file_path()
>       ksmbd: don't open-code %pD
>       ksmbd: constify struct path
>
>  fs/ksmbd/misc.c    |  2 +-
>  fs/ksmbd/misc.h    |  2 +-
>  fs/ksmbd/smb2pdu.c | 33 ++++++++++++++++-----------------
>  fs/ksmbd/smbacl.c  |  6 +++---
>  fs/ksmbd/smbacl.h  |  6 +++---
>  fs/ksmbd/vfs.c     | 18 ++++++++----------
>  fs/ksmbd/vfs.h     |  2 +-
>  7 files changed, 33 insertions(+), 36 deletions(-)



-- 
Thanks,

Steve
