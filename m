Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FFEB6F1816
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Apr 2023 14:34:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345929AbjD1Mea (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Apr 2023 08:34:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346013AbjD1MeH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Apr 2023 08:34:07 -0400
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com [IPv6:2607:f8b0:4864:20::92d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 826D95BBA;
        Fri, 28 Apr 2023 05:34:02 -0700 (PDT)
Received: by mail-ua1-x92d.google.com with SMTP id a1e0cc1a2514c-7724096f768so6335968241.1;
        Fri, 28 Apr 2023 05:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682685241; x=1685277241;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KDNDk+3isv+YK4RfBqqE3Pcr5x4F1GLkRxrPrDq/8i0=;
        b=kt6Kdq8oEnIobXnF23gXP6lAoDdBS8HyLOtUiuMk/bpEdSkmdz2lZpAgS7kaldQoPb
         p55AM8uC1sVpKknV0zxo9kc8U/TAh/bLVri1jpkVwlPEwd+Q7ijSBaXLt8poTcLEXoPB
         4Ey6h3uj+WjWmK1X2q9PxGBJFMvVpu3m//I9VmxF6Q9WUfZM4u2OOup0amLcXKiOFYYG
         fLWr8Jw2cibFLjR7H3Yio/WTHbFPbooKf9CDII20FgV1NrGXmgmQfCud1QOaZr2eDjLN
         sE2/ghnU3sdO7t39vWUfLZ90YxL9EcOXKVpJBQKrWCYM1SzAAOgQnR1Jb6/2gcNR62VU
         7+vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682685241; x=1685277241;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KDNDk+3isv+YK4RfBqqE3Pcr5x4F1GLkRxrPrDq/8i0=;
        b=Y8R3driyVHEP/iHFTvoUkfzQS953r0Qr07bUSwKzPuKCZ3rdrDlcHTDs7yRfqSt5wA
         DIm3BPKE1JvbPTHUvpunF+N1SUfobCenrAtBNJzzX+Onfe4bs6Y7+OI+5kJSL0gBLpAG
         M1OM0D3t44x9ZbRmtKWQaUEG7/mfCefIszPL+gmB7+7BsUZwoRlyKYcEJYDL583e4zNV
         sT7+qrmKDqwAPCTQs0tLEo6YZsJPBNXpRF04id6YG6J2OooaI9b52cTO1uLgOM176ZsO
         NOHczGz+mJe8sE/1fD0pEM3rPBDNzKR70VofCIhxN0PGS+TLjY5WOLQdo7XD4UtV2v6U
         lI1Q==
X-Gm-Message-State: AC+VfDz8nwvnl9nr41S+i5KyM+kcRUbejWLnDOKj/EYQQGTy51MaekPN
        YvppP8Bb0+a/MSjb/CEG/7YfS/ibjGldRx41PkkmkLWg
X-Google-Smtp-Source: ACHHUZ7RtYKzR2uJDqfiWCZJ+zJUeaY2dnhLUgJ2MFmg2wa5boOGW7EvyOxIWa+GVAXlbHteUcBwu+Fl9AcrZEj2ZfY=
X-Received: by 2002:a05:6102:117:b0:42e:5ff9:5dfa with SMTP id
 z23-20020a056102011700b0042e5ff95dfamr2314244vsq.30.1682685241528; Fri, 28
 Apr 2023 05:34:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230425130105.2606684-1-amir73il@gmail.com> <dafbff6baa201b8af862ee3faf7fe948d2a026ab.camel@kernel.org>
 <CAOQ4uxjR0cdjW1Pr1DWAn+dkTd3SbV7CUqeGRh2FeDVBGAdtRw@mail.gmail.com>
 <df31058f662fe9ec9ad1cc59838f288b8aff10f0.camel@kernel.org>
 <CAOQ4uxhWzV7YJ_kPGg_4wHhWAd79_Xgo2uoDY+1K9sEtJcH_cA@mail.gmail.com>
 <20230428114002.3vqve7g76xonjs5f@quack3> <2d0f5a6cd8e9e92f871c95ce586234425e47b719.camel@kernel.org>
In-Reply-To: <2d0f5a6cd8e9e92f871c95ce586234425e47b719.camel@kernel.org>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 28 Apr 2023 15:33:50 +0300
Message-ID: <CAOQ4uxiTWSajKqMKmtL3+GyiHV4EodFDKV3quR+f_tLzQq9ZJQ@mail.gmail.com>
Subject: Re: [RFC][PATCH 0/4] Prepare for supporting more filesystems with fanotify
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org
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

On Fri, Apr 28, 2023 at 3:15=E2=80=AFPM Jeff Layton <jlayton@kernel.org> wr=
ote:
>
> On Fri, 2023-04-28 at 13:40 +0200, Jan Kara wrote:
> > On Thu 27-04-23 22:11:46, Amir Goldstein wrote:
> > > On Thu, Apr 27, 2023 at 7:36=E2=80=AFPM Jeff Layton <jlayton@kernel.o=
rg> wrote:
> > > > > There is also a way to extend the existing API with:
> > > > >
> > > > > Perhstruct file_handle {
> > > > >         unsigned int handle_bytes:8;
> > > > >         unsigned int handle_flags:24;
> > > > >         int handle_type;
> > > > >         unsigned char f_handle[];
> > > > > };
> > > > >
> > > > > AFAICT, this is guaranteed to be backward compat
> > > > > with old kernels and old applications.
> > > > >
> > > >
> > > > That could work. It would probably look cleaner as a union though.
> > > > Something like this maybe?
> > > >
> > > > union {
> > > >         unsigned int legacy_handle_bytes;
> > > >         struct {
> > > >                 u8      handle_bytes;
> > > >                 u8      __reserved;
> > > >                 u16     handle_flags;
> > > >         };
> > > > }
> > >
> > > I have no problem with the union, but does this struct
> > > guarantee that the lowest byte of legacy_handle_bytes
> > > is in handle_bytes for all architectures?
> > >
> > > That's the reason I went with
> > >
> > > struct {
> > >          unsigned int handle_bytes:8;
> > >          unsigned int handle_flags:24;
> > > }
> > >
> > > Is there a problem with this approach?
> >
> > As I'm thinking about it there are problems with both approaches in the
> > uAPI. The thing is: A lot of bitfield details (even whether they are pa=
cked
> > to a single int or not) are implementation defined (depends on the
> > architecture as well as the compiler) so they are not really usable in =
the
> > APIs.
> >
> > With the union, things are well-defined but they would not work for
> > big-endian architectures. We could make the structure layout depend on =
the
> > endianity but that's quite ugly...
> >
>
> Good point. Bitfields just have a bad code-smell anyway.
>
> Another idea would be to allow someone to set handle_bytes to a
> specified value that's larger than the current max of 128 (maybe ~0 or
> something), and use that as an indicator that this is a v2 struct.
>
> So the v2 struct would look something like:
>
> struct file_handle_v2 {
>         unsigned int    legacy_handle_bytes;    // always set to ~0 or wh=
atever
>         unsigned int    flags;
>         int             handle_type;
>         unsigned int    handle_bytes;
>         unsigned char   f_handle[];
>
> };

The three of us are racing with proposals of crazy solutions ;)

I was going to propose:

struct file_handle_v2 {
        union {
                u32 legacy_handle_bytes;
                struct {
                        u16 handle_bytes;
                        u8 handle_flags;
                        u8 reserved;
                };
        };
        int handle_type;
        unsigned char f_handle[];
};

which is similar to your first proposal, but the way to use it would be:

static inline int file_handle_bytes(struct file_handle_v2 *handle)
{
        return (handle->legacy_handle_bytes < MAX_HANDLE_SZ) ?
                handle->legacy_handle_bytes : handle->handle_bytes;
}

I think this works for both LE and BE, because non zero handle_flags
would taint legacy_handle_bytes either way.

>
> ...but now I'm wondering...why do we return -EINVAL when
> f_handle.handle_bytes is > MAX_HANDLE_SZ? Is it really wrong for the
> caller to allocate more space for the resulting file_handle than will be
> needed? That seems wrong too. In fact, name_to_handle_at(2) says:
>
> "The constant MAX_HANDLE_SZ, defined in <fcntl.h>, specifies the maximum
> expected size for a file handle.  It  is  not guaranteed upper limit as
> future filesystems may require more space."
>
> So by returning -EINVAL when handle_bytes is too large, we're probably
> doing the wrong thing there.

Yeh it is very strange, but now it is very convenient too,
so no reason to fix it retroactively.

With the file_handle_v2 I proposed above, new handle_bytes is 16bit
so we won't need to error on large buffer size when using file_handle_v2.

Another odd thing about struct file_handle is that it is not actually
defined in include/uapi header files, although it is defined in the man pag=
e
of name_to_handle_at(2).
That is another thing that we can fix with file_handle_v2.

>
> Using an AT_* flag may be the best plan, actually.

It's true, but perhaps AT_HANDLE_V2 and then the
handle_flags could be easily extended later.

Thanks,
Amir.
