Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 520DD544708
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jun 2022 11:15:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239621AbiFIJPA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Jun 2022 05:15:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230290AbiFIJO6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Jun 2022 05:14:58 -0400
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60FEE175B9;
        Thu,  9 Jun 2022 02:14:57 -0700 (PDT)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-f2e0a41009so30286312fac.6;
        Thu, 09 Jun 2022 02:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ON3Pub6AHUCAeH8SyvUYJIu2FNlMbAkSzqXkvKSDFAg=;
        b=GQGMNkYUeeI8CBd4rHlhZMbMb3aFVGJ622JnZaJbfYjMOpW//pg9bwsiKfnK+KtyZC
         F29KG67ibpRAlUQu9L1mqeQcodqCjp9/KVh9r6Ti7s796zZ3e8qyxKXfqhMSzmJJMghQ
         6SZufhAgEm44JFBmc+9PPeey4LVGSlAsGyTfrb9LHB2sf9pEhGdb37aQhPXIzGeajfYN
         b/wxtKuV3vTHRRv+2ldMn71jxtWrYfKDRN+O5EaMewxuHfIRmvxQofwtB7T57uX2WajW
         APkEsAfzBlAbvHo2/bB27eDOq3IZxXij2keapnpqY4F7LFS03IwsbLgtOmw2xuMeK3zZ
         fzWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ON3Pub6AHUCAeH8SyvUYJIu2FNlMbAkSzqXkvKSDFAg=;
        b=eqACfIByrlPzVoeheDyoiFwiMvmBfdzrH/1SwN1Ls6iTURLonGStk1Qg5C0iX54xji
         HRrtwR5zWHXRnDxncUMneDdjE6Y+PONkG16a+muu1UwGOOpdoHglMb9LF2kd7zskx0CD
         yMKsfK4Wq5vmCsq4PIagzBAl3Xmzf/d5utTRnREczF2qCq5f14rlKY+j4UHARPhQJq+V
         e5hgZi3snTUiRMcnoA9fB2eJnHwWdFBty85XhFA3wpTNc1c8Q6fMgVROv+cQKhN5crCe
         2tb/nWRlfSuUIctMaP4+4vzB7WUTuTDSu+nadTDnRXJ26dgkUz+YbT/WwnCDd55NVJN8
         ipng==
X-Gm-Message-State: AOAM530ccIUCSVjHgAQ722zsfJvKXsLjhAQWjPC45vjWCuOaW/m0Ywef
        CODQ3/OpivkX8qEr8L+JLAZOaCnwyWw3Zi67j2cSgqSt7JQ=
X-Google-Smtp-Source: ABdhPJzWx9LlUR4RR9d3X0CrSWaKeVIEBnxlZ2i8BI3KROIhC0JPG2YUtffi0CqhLJ9fUXX1WO98fAvFtA5FNkwvUeQ=
X-Received: by 2002:a05:6870:e40c:b0:f3:2f32:7c3d with SMTP id
 n12-20020a056870e40c00b000f32f327c3dmr1152770oag.71.1654766096472; Thu, 09
 Jun 2022 02:14:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220607153139.35588-1-cgzones@googlemail.com>
 <08A11E25-0208-4B4F-8759-75C1841E7017@dilger.ca> <CAOQ4uxh1QG_xJ0Ffh=wKksxWKm1ioazmc8SxeYYH9yHT1PMasg@mail.gmail.com>
In-Reply-To: <CAOQ4uxh1QG_xJ0Ffh=wKksxWKm1ioazmc8SxeYYH9yHT1PMasg@mail.gmail.com>
From:   =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date:   Thu, 9 Jun 2022 11:14:45 +0200
Message-ID: <CAJ2a_DdpvaXxoWKJhVww3=xGcp5n4O3LZ+n5dZMh8pUb9WZM_w@mail.gmail.com>
Subject: Re: [RFC PATCH] f*xattr: allow O_PATH descriptors
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Andreas Dilger <adilger@dilger.ca>,
        SElinux list <selinux@vger.kernel.org>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-man <linux-man@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 9 Jun 2022 at 06:36, Amir Goldstein <amir73il@gmail.com> wrote:
>
> On Wed, Jun 8, 2022 at 9:01 PM Andreas Dilger <adilger@dilger.ca> wrote:
> >
> > On Jun 7, 2022, at 9:31 AM, Christian G=C3=B6ttsche <cgzones@googlemail=
.com> wrote:
> > >
> > > From: Miklos Szeredi <mszeredi@redhat.com>
> > >
> > > Support file descriptors obtained via O_PATH for extended attribute
> > > operations.
> > >
> > > Extended attributes are for example used by SELinux for the security
> > > context of file objects. To avoid time-of-check-time-of-use issues wh=
ile
> > > setting those contexts it is advisable to pin the file in question an=
d
> > > operate on a file descriptor instead of the path name. This can be
> > > emulated in userspace via /proc/self/fd/NN [1] but requires a procfs,
> > > which might not be mounted e.g. inside of chroots, see[2].
> >
> > Will this allow get/set xattrs directly on symlinks?  That is one probl=
em
> > that we have with some of the xattrs that are inherited on symlinks, bu=
t
> > there is no way to change them.  Allowing setxattr directly on a symlin=
k
> > would be very useful.
>
> It is possible.
> See: https://github.com/libfuse/libfuse/pull/514
>

Does it really? (It should not since xtattr(7) mentions some quota
related issues.)
In my tests setting extended attributes via O_PATH on symlinks fails
with ENOTSUP (even as root), except for special ones, like
"security.selinux".

> That's why Miklos withdrew this patch:
> https://lore.kernel.org/linux-fsdevel/CAOssrKeV7g0wPg4ozspG4R7a+5qARqWdG+=
GxWtXB-MCfbVM=3D9A@mail.gmail.com/
>
> Thanks,
> Amir.
