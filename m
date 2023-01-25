Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 010DE67BC8C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jan 2023 21:29:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236391AbjAYU3W (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Jan 2023 15:29:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235678AbjAYU3V (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Jan 2023 15:29:21 -0500
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA5BD18B1E;
        Wed, 25 Jan 2023 12:29:20 -0800 (PST)
Received: by mail-vs1-xe2c.google.com with SMTP id 187so20975526vsv.10;
        Wed, 25 Jan 2023 12:29:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=x0eJXQiCeafQhb678t9JAzCgvZC4fwwPxaAWFvK3rXg=;
        b=EwBK25ItUcy1PDOp6CVPNMrqCAsQ2wvL1ys9J8ZStkhoeV16dWpB7y1eQheBoVZmgb
         uL8VOUJqhUzpeQRNupXrNkfzVw1Wh1L2zDE7vmGXsSMKBl4D+aNMQXLX2yR9aYELvY1i
         ls8njRBMasI9lPJ0YNMf4mKZujARiSrWNAR1EFx2e3/2nRJSVaA5kwOg8vSC2H5TxuAS
         Gxe/JAr3bGcBpQUAfvYtJ4aoRsyux0huJc3Ac0eoT/zOE6lMWJXQvx8AW/JLiduUDDAz
         TU4x6NCcsKz9C8bBthKWwQ9lXAYXRzKp2NfGEQkwXDJQrgehdayiUfJA6tSE89Tp7yhv
         TOjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x0eJXQiCeafQhb678t9JAzCgvZC4fwwPxaAWFvK3rXg=;
        b=A8Vg4Eayuj2rmRCERg7bOUv6SYZL1pudtlXVLGNkW2BTAJ6KMyEMPWlBwp2oenUQSs
         sv3JMdDwdSGb1dIKogVkR87wdohSHyQKNb9l0taikY7+F84gwvKqBaL0FCJtV/S996WO
         dxYgsWXoQDdYOJHRw6s+VF2tLXC0ZX3I4BrpAY1IeuUf88cTdc/VtLTdlbqjnYdCKXx6
         jG901hCMGyQl6FhDZsou9FxO1zhUwNQFIFVgB5hDQi02CpNPRovet5/pZJ04M60d+qgp
         dIE5oEVFFZqTTGKyil0BFpcwon9cCdUVX1WT6hzsPkvzudY9e6JYhZIUmjSK2HzHEG63
         yMwA==
X-Gm-Message-State: AO0yUKWUeT2DbqFDD+yok+y8wjJwgR2WZyrgCXQ+mn41XW39f67nsrEh
        db4BY/GAaOA4BCxqgM7UxmrQbzNYQ4cLZCmwvwEyNSZF
X-Google-Smtp-Source: AK7set9SxKMVPC39i/EQHeHs3eIcn8MDkk+ayHfGxcsyXGEq6M4Y55n47XPsp3L4Aaw07umz2w8Y4jSsxHqtMty65wA=
X-Received: by 2002:a67:e0d8:0:b0:3ea:a853:97c4 with SMTP id
 m24-20020a67e0d8000000b003eaa85397c4mr13699vsl.36.1674678559903; Wed, 25 Jan
 2023 12:29:19 -0800 (PST)
MIME-Version: 1.0
References: <cover.1674227308.git.alexl@redhat.com> <CAOQ4uxgGc33_QVBXMbQTnmbpHio4amv=W7ax2vQ1UMet0k_KoA@mail.gmail.com>
 <1ea88c8d1e666b85342374ed7c0ddf7d661e0ee1.camel@redhat.com>
 <CAOQ4uxinsBB-LpGh4h44m6Afv0VT5yWRveDG7sNvE2uJyEGOkg@mail.gmail.com>
 <5fb32a1297821040edd8c19ce796fc0540101653.camel@redhat.com>
 <CAOQ4uxhGX9NVxwsiBMP0q21ZRot6-UA0nGPp1wGNjgmKBjjBBA@mail.gmail.com>
 <20230125041835.GD937597@dread.disaster.area> <CAOQ4uxhqdjRbNFs_LohwXdTpE=MaFv-e8J3D2R57FyJxp_f3nA@mail.gmail.com>
 <87wn5ac2z6.fsf@redhat.com> <CAOQ4uxiPLHHnr2=XH4gN4bAjizH-=4mbZMe_sx99FKuPo-fDMQ@mail.gmail.com>
 <87o7qmbxv4.fsf@redhat.com> <CAOQ4uximBLqXDtq9vDhqR__1ctiiOMhMd03HCFUR_Bh_JFE-UQ@mail.gmail.com>
 <87fsbybvzq.fsf@redhat.com> <CAOQ4uxgos8m72icX+u2_6Gh7eMmctTTt6XZ=BRt3VzeOZH+UuQ@mail.gmail.com>
 <87wn5a9z4m.fsf@redhat.com> <CAOQ4uxi7GHVkaqxsQV6ninD9fhvMAPk1xFRM2aMRFXQZUV-s3Q@mail.gmail.com>
In-Reply-To: <CAOQ4uxi7GHVkaqxsQV6ninD9fhvMAPk1xFRM2aMRFXQZUV-s3Q@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 25 Jan 2023 22:29:08 +0200
Message-ID: <CAOQ4uxiZ4iB82F4i2zMPcyCB8EBFGObdAoBEcar0KE7sA5BoNA@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] Composefs: an opportunistically sharing verified
 image filesystem
To:     Giuseppe Scrivano <gscrivan@redhat.com>
Cc:     Dave Chinner <david@fromorbit.com>,
        Alexander Larsson <alexl@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        brauner@kernel.org, viro@zeniv.linux.org.uk,
        Vivek Goyal <vgoyal@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 25, 2023 at 10:23 PM Amir Goldstein <amir73il@gmail.com> wrote:
>
> On Wed, Jan 25, 2023 at 9:45 PM Giuseppe Scrivano <gscrivan@redhat.com> wrote:
> >
> > Amir Goldstein <amir73il@gmail.com> writes:
> >
> > >> >> I previously mentioned my wish of using it from a user namespace, the
> > >> >> goal seems more challenging with EROFS or any other block devices.  I
> > >> >> don't know about the difficulty of getting overlay metacopy working in a
> > >> >> user namespace, even though it would be helpful for other use cases as
> > >> >> well.
> > >> >>
> > >> >
> > >> > There is no restriction of metacopy in user namespace.
> > >> > overlayfs needs to be mounted with -o userxattr and the overlay
> > >> > xattrs needs to use user.overlay. prefix.
> > >>
> > >> if I specify both userxattr and metacopy=on then the mount ends up in
> > >> the following check:
> > >>
> > >> if (config->userxattr) {
> > >>         [...]
> > >>         if (config->metacopy && metacopy_opt) {
> > >>                 pr_err("conflicting options: userxattr,metacopy=on\n");
> > >>                 return -EINVAL;
> > >>         }
> > >> }
> > >>
> > >
> > > Right, my bad.
> > >
> > >> to me it looks like it was done on purpose to prevent metacopy from a
> > >> user namespace, but I don't know the reason for sure.
> > >>
> > >
> > > With hand crafted metacopy, an unpriv user can chmod
> > > any files to anything by layering another file with different
> > > mode on top of it....
> >
> > I might be missing something obvious about metacopy, so please correct
> > me if I am wrong, but I don't see how it is any different than just
> > copying the file and chowning it.  Of course, as long as overlay uses
> > the same security model so that a file that wasn't originally possible
> > to access must be still blocked, even if referenced through metacopy.
> >
>
> You're right.
> The reason for mutual exclusion maybe related to the
> comment in ovl_check_metacopy_xattr() about EACCES.
> Need to check with Vivek or Miklos.
>
> But get this - you do not need metacopy=on to follow lower inode.
> It should work without metacopy=on.
> metacopy=on only instructs overlayfs whether to copy up data
> or only metadata when changing metadata of lower object, so it is
> not relevant for readonly mount.
>

However, you do need redirect=follow and that one is only mutually
exclusive with userxattr.
Again, need to ask Miklos whether that could be relaxed under
some conditions.

Thanks,
Amir.
