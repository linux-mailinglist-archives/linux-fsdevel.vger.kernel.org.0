Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FD6E72B9F7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jun 2023 10:14:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbjFLIN7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jun 2023 04:13:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231650AbjFLINm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jun 2023 04:13:42 -0400
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 679A010C7;
        Mon, 12 Jun 2023 01:13:19 -0700 (PDT)
Received: by mail-vs1-xe32.google.com with SMTP id ada2fe7eead31-43b4ffbaec6so1105006137.0;
        Mon, 12 Jun 2023 01:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686557597; x=1689149597;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aKtQOPZeb/boarFRe9Thy1PsA/qXJLSZos8Miv7kPW0=;
        b=Xp35kLNT9dG77tcqVK8Sor2cdgmboJgXBspMiyhFVAb1Ttjcy1bDQYmHYLSBe0lIJD
         +PKD57rNEG8a76iXhpuEZNTsySuP9B28GTR8QfQlxqsJDQY3DvO0OjNbQ89dQA70n2xS
         lBxZDZ3T8PahMr7l9AouHwS/3j0Ux3nLYZgYQ5+/6WqWlpBluIKqI191oSnQZ7r+j5K1
         1lJVj1xZiJeNO0TFtG/zN8uIMeKyoE4BCxK7ByS2VRSXTGIiUisbkhvUYNp4mJherO14
         TaJ8Gc5QfdpeRgWhoKAFodKupo4dZmbcaIg53SeQNskfbOtnzyAMM5AaYB2+uVxurq6W
         F2FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686557597; x=1689149597;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aKtQOPZeb/boarFRe9Thy1PsA/qXJLSZos8Miv7kPW0=;
        b=VZHTFYTko5QmOpZzEjIh4uRgk4Bm5C23tst9pBltr9/bfgoVw24GLW7sXAXM9csfSS
         n8YaKx0TvV/q/ajWeiIifaE6lhzruIk5GL87rAzb+8hagD62px9ICdxeDbxNn9k7QdgE
         +aTdSV0t9LolCdAmNXBPZa+PWqMQ6oj+RYlI/pTvjVAn4kJCaA/3iYF/6Z/pbjztdgwo
         v91orXc0PsauCrGjqNuZfFmN/v9/HeQTlEhqtQkRooYj4HHAjWPH0iF2Zu6t/uoa0iYd
         5pHGJuN+zoP8KacnikNZSpuenk8Mk1y66lwJvUp3m9LbKYiWFb3sWvqTetRDEnM43qNZ
         O0ng==
X-Gm-Message-State: AC+VfDwF4BLYhez9JHNmQUjtNcizMnqjbJDQnft3bquzQtdNl51wEmXY
        +9bhllMAM6AyeNwYpskcT6wGL47WEN3UcWPHxhGIzih631M=
X-Google-Smtp-Source: ACHHUZ6ofolgkTDmRQ0cqlLgXP9VZbM7u8pg4zj4WZacOS56b3PEYF/r3sIVYfachxxtnbT3Plhq9GD1VO0Aq5LzyRo=
X-Received: by 2002:a67:f495:0:b0:43b:1b9c:6283 with SMTP id
 o21-20020a67f495000000b0043b1b9c6283mr2966906vsn.28.1686557597644; Mon, 12
 Jun 2023 01:13:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230611132732.1502040-1-amir73il@gmail.com> <20230611132732.1502040-3-amir73il@gmail.com>
 <ZIagx5ObeBDeXmni@infradead.org> <CAOQ4uxjm4nXc4cHFCnk69RC2yshBmFBxMTuVxH3QQRm_6LRcSw@mail.gmail.com>
 <ZIa81+M0HeOzVQQb@infradead.org>
In-Reply-To: <ZIa81+M0HeOzVQQb@infradead.org>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 12 Jun 2023 11:13:06 +0300
Message-ID: <CAOQ4uxjJ-a_SWq12j8w7KhocyBuZLMTdOSPko0eRFvzVdjT_bA@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] fs: introduce f_real_path() helper
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Christian Brauner <brauner@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 12, 2023 at 9:36=E2=80=AFAM Christoph Hellwig <hch@infradead.or=
g> wrote:
>
> On Mon, Jun 12, 2023 at 09:28:40AM +0300, Amir Goldstein wrote:
> > On Mon, Jun 12, 2023 at 7:36=E2=80=AFAM Christoph Hellwig <hch@infradea=
d.org> wrote:
> > >
> > > On Sun, Jun 11, 2023 at 04:27:31PM +0300, Amir Goldstein wrote:
> > > > Overlayfs knows the real path of underlying dentries.  Add an optio=
nal
> > > > struct vfsmount out argument to ->d_real(), so callers could compos=
e the
> > > > real path.
> > > >
> > > > Add a helper f_real_path() that uses this new interface to return t=
he
> > > > real path of f_inode, for overlayfs internal files whose f_path if =
a
> > > > "fake" overlayfs path and f_inode is the underlying real inode.
> > >
> > > I really don't like this ->d_real nagic.  Most callers of it
> > > really can't ever be on overlayfs.
> >
> > Which callers are you referring to?
>
> Most users of file_dentry are inside file systems and will never
> see the overlayfs path.
>

Ay ay ay.
I suspected that this is what you meant and I do not blame you.
There is no documentation and it is hard to understand what is going on
even harder to understand why that is going on...

Before "ovl: stack file ops" series, a file opened from ovl (over xfs) path
would have ovl f_path and xfs f_inode, as well as xfs f_ops, so indeed xfs
code had to be careful, but so did a lot of generic vfs code.

After ovl stacked f_ops, a file opened from ovl (over xfs) path has an
ovl f_path and an ovl f_inode, so a lot of hacks could be removed from
generic vfs code (e.g. locks_inode() macro).

Alas, for every ovl file, there is an "internal/real" file (stashed in
file->f_private)
which is opened by open_with_fake_path().
This "internal/real" file has ovl f_path and xfs f_inode, so xfs could
not get rid
of file_dentry() just yet.

Currently, the reason for the fake f_path hack is that the same internal fi=
le
is assigned as ->vm_file in ovl_mmap(), ovl does not implement stacked aops
and some users of ->vm_file need the "fake" ovl path.

Anyway, the first step is to introduce the ovl internal file container.
Next, we will use the real_path for file_dentry() and we can see if we
can get rid of some of these file_dentry() uses.

Thanks,
Amir.
