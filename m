Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F06DF738154
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jun 2023 13:11:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232024AbjFUJly (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Jun 2023 05:41:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232012AbjFUJlO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Jun 2023 05:41:14 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96F811BF1
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Jun 2023 02:40:33 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-57015b368c3so49930257b3.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Jun 2023 02:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1687340433; x=1689932433;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gybbZJh87t3Qbe/MI3uBbaP9SdOn3CjaNUEl9acnWiU=;
        b=LMsWpjK/zwBZNA1C5SJA9i5BdNGjDeTVa2OgQLr/7lE4liaOh5aUKAM7KRFsGokN8A
         dm8Zr0tt2azGKtuRNawsivTN9vPbiUN9S4IHK7njdo7Kut7rp9jW7k2fntYJ1XCXFUNE
         B9RGljUqsGrDN2R+e43B6gpPxoySxfiXM6dQI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687340433; x=1689932433;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gybbZJh87t3Qbe/MI3uBbaP9SdOn3CjaNUEl9acnWiU=;
        b=EOomvI08UcF7AE7Uf7NRSLSfExS3YZ5+Rw9YPMQkDXsC8gS0HAnyr0QK7hSktoPpXz
         l4Tn3tDHE24qFbytXyyMgONDDIcHKTaMHzJzZha+8f6Z7fqbhprLl3PRGeb7zbklnucC
         KSpe3ZA+7TQyKJEJpX+4ZAiBV+5b9Kbd5enmL2fm0Uce8Fb9lSUONzFlWy4D/OtdEf6k
         jZiLjn4WXOyVRccsv97xfae9aHWYWa+wNYfhNqnWQ6Au0CslS7HulQBdrf+Ll0WmPhGi
         xMVI9IplPb1XNixKd/cLE3lWS6oaUsFaH2PIPrs+wdllLo4lKJk6NvgZFHtpEgBtgGAT
         CdSg==
X-Gm-Message-State: AC+VfDwUzpmo+FQ/36mzVXV4cP9s+qUisWd19HtneiivGHgjItx7DGMK
        bS3djfp5nvMcp/A99wB2HIJL5POv0l+zzFaPd55tTQ==
X-Google-Smtp-Source: ACHHUZ6Xo6f+HdwrjmUZ92VYxxeamu+uiO1MAEKtWfZVchSbMrG/0dyJ7p/uTcOURmMpfhQ1An4kwnDTzD4qwozqoag=
X-Received: by 2002:a0d:eb89:0:b0:56d:3d83:15cb with SMTP id
 u131-20020a0deb89000000b0056d3d8315cbmr13588007ywe.44.1687340432773; Wed, 21
 Jun 2023 02:40:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230620151328.1637569-1-keiichiw@chromium.org>
 <20230620151328.1637569-3-keiichiw@chromium.org> <CAJfpegton83boLEL7n-Tf6ON4Nq_g2=mTus7vhX2n0C+yuUC4w@mail.gmail.com>
 <CADgJSGGDeu_dPduBuK7N324oJ9641VKv2+fAVAbDY=-itsFjEQ@mail.gmail.com> <CAJfpegtNjAELur_AtqiGdO6LJRDyT+WQ1UKtG-o=Em0rAhOKMg@mail.gmail.com>
In-Reply-To: <CAJfpegtNjAELur_AtqiGdO6LJRDyT+WQ1UKtG-o=Em0rAhOKMg@mail.gmail.com>
From:   Keiichi Watanabe <keiichiw@chromium.org>
Date:   Wed, 21 Jun 2023 18:40:21 +0900
Message-ID: <CAD90VcZeoagh7a-0qA1SudJ3v53fvyr7t2iwGx_+dnAL7M=jnw@mail.gmail.com>
Subject: Re: [PATCH 2/3] fuse: Add negative_dentry_timeout option
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     =?UTF-8?B?SnVuaWNoaSBVZWthd2EgKOS4iuW3nee0lOS4gCk=?= 
        <uekawa@google.com>, LKML <linux-kernel@vger.kernel.org>,
        mhiramat@google.com, takayas@chromium.org, drosen@google.com,
        sarthakkukreti@google.com, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 21, 2023 at 1:07=E2=80=AFPM Miklos Szeredi <miklos@szeredi.hu> =
wrote:
>
> On Wed, 21 Jun 2023 at 00:53, Junichi Uekawa (=E4=B8=8A=E5=B7=9D=E7=B4=94=
=E4=B8=80) <uekawa@google.com> wrote:
> >
> > Hi
> >
> >
> >
> > 2023=E5=B9=B46=E6=9C=8821=E6=97=A5(=E6=B0=B4) 4:28 Miklos Szeredi <mikl=
os@szeredi.hu>:
> >>
> >> On Tue, 20 Jun 2023 at 17:14, Keiichi Watanabe <keiichiw@chromium.org>=
 wrote:
> >> >
> >> > Add `negative_dentry_timeout` mount option for FUSE to cache negativ=
e
> >> > dentries for the specified duration.
> >>
> >> This is already possible, no kernel changes needed.  See e.g.
> >> xmp_init() in libfuse/example/passthrough.c.
> >>
> >
> > Thank you for the pointer!
> >
> > So reading libfuse/fuse.c, fuse_lib_lookup does a reply with e.ino=3D0 =
err=3D0 (instead of ENOENT) with e.entry_timeout=3Dnegative_timeout,
> > for each lookup (and there's no global configuration but that's okay) ?
>
> Yes.


Oh, good to know!
I could make it work in our VMM (crosvm) without any kernel changes.
https://crrev.com/c/4630879
Thanks a lot!

Keiichi


>
>
> Thanks,
> Miklos
