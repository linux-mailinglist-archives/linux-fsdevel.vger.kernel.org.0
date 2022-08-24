Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 785F35A01AF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Aug 2022 21:00:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239547AbiHXTAw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Aug 2022 15:00:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239633AbiHXTAu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Aug 2022 15:00:50 -0400
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F05CBB851
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Aug 2022 12:00:48 -0700 (PDT)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-11ba6e79dd1so21988305fac.12
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Aug 2022 12:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=fjATRPE4m83dckDCIc8OGRxnjlPksG8X6iPw0ydnz/g=;
        b=OFes1KyQ5IWJewh4On/mqFjyS9IYL+/2BQOpEhwzvRnMN1Woi/vf7JbPVhedRpkDz/
         Pd9lADPzWrkaoZ97kmoV/6PBvTMYPj4AtHqs5JOqP8lAndXh3ix/TRey9LEF4kBMCm2l
         AwCK9jVi768DMiNjjAKSE6J42WwU7XrMMDA4EZIkBKRU6IFigu9GjTmvAfklDhlPhE6I
         sqG3/Fr+LxnD2LPNw1rjdwMvamUHZUBfveQE5c3rHfOfhi/9a72uxDNeQrXkXg73Ax6E
         DZEXMhbWwTG0aTc9Z68ED5IHupAu8p1+n4FjQW7mgU9rX2WoKTMJBU0ncP+FEV9dEI2Q
         x4Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=fjATRPE4m83dckDCIc8OGRxnjlPksG8X6iPw0ydnz/g=;
        b=SC42RA9d8lcDi1sOXL7/q+VBSqjh1lHyzg60PBBPEB57CTiu27m2kslZZu2Ef78WC9
         SqYgTsKp0DiuQQPT0TTXy00zIjUa/HuTpP2/o3qjtBv5QuEo/sVRStDDOkc7QWZctufU
         af1aPAVE7Ul1exwxtgQj0BteN/YozwNi7LbkVygXVtpeH17mVWbv/tGrxnpPOEGqKDy7
         O8jf0wIQ1TiyldQHG7K4h3dFbMJc/t7xfNwfV/XyI+4QVCEWvzAO6KiC9a6gt/ufHORG
         suc6EhdXz/Ii8hZ+4NWylEXf47JN2+r3E3qGru2BFgwVt1np7N7vJTLH0Nx9eVZXDSR1
         3ZIg==
X-Gm-Message-State: ACgBeo0KVSV6z3zJ97aEgSSc4W10RL+KoSgru6JSo6q9dGdhjGwM/mP3
        Qjc0IFdPvame+v4RpkOyypcfJmA9et+sL3DcvowbjK4kQmY=
X-Google-Smtp-Source: AA6agR6dmJt4QfNyqc4L39igPlAU/Rlixc4K3tcFcuxJaomjMcNtUbkT4h0KsNvE6tscC81KAVnKQweaCifHwnFUH7U=
X-Received: by 2002:a05:6870:310:b0:f1:f473:a53f with SMTP id
 m16-20020a056870031000b000f1f473a53fmr4489944oaf.34.1661367648134; Wed, 24
 Aug 2022 12:00:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200728234513.1956039-1-ytht.net@gmail.com> <CAJfpegv=8gc1W80e0=33dEcdQb4OgVWKBVXi3jNDKVWV1fWetA@mail.gmail.com>
In-Reply-To: <CAJfpegv=8gc1W80e0=33dEcdQb4OgVWKBVXi3jNDKVWV1fWetA@mail.gmail.com>
From:   lepton <ytht.net@gmail.com>
Date:   Wed, 24 Aug 2022 12:00:37 -0700
Message-ID: <CALqoU4wtPnMPqWZF=DjHApZRA58Vruwa3X3sQxR9UkugZJOgwg@mail.gmail.com>
Subject: Re: [PATCH] fuse: Add filesystem attribute in sysfs control dir.
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-fsdevel@vger.kernel.org
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

On Mon, Aug 22, 2022 at 6:37 AM Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> On Wed, 29 Jul 2020 at 01:45, Lepton Wu <ytht.net@gmail.com> wrote:
> >
> > With this, user space can have more control to just abort some kind of
> > fuse connections. Currently, in Android, it will write to abort file
> > to abort all fuse connections while in some cases, we'd like to keep
> > some fuse connections. This can help that.
>
> You can grep the same info from /proc/self/mountinfo.  Why does that not work?
Hi Miklos, thanks for this hint. That will work. But the code in user
space will be more complicated and not straightforward.
For now, I can see 2 issues with mountinfo:
1.  one connection could have multiple entries under
/proc/self/mountinfo if there are bind mounts,  user space code needs
to handle that.
2.  /proc/self/mountinfo is limited by namespace, so in theory, some
connection under /sys/fs/fuse/connections  could be missed in it.
While this isn't an issue
for the current android code, maybe it could get broken in the future.

Overall, I am feeling my kernel patch is a straightforward and simple
solution and it's just one more attribute under
/sys/fs/fuse/connections, may I know if there are any downsides to
doing this?

Thanks!
>
> Thanks,
> Miklos
