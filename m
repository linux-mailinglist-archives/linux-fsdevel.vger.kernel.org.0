Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CC5433E1D9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Mar 2021 00:05:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbhCPXEi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Mar 2021 19:04:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbhCPXER (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Mar 2021 19:04:17 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA084C06174A;
        Tue, 16 Mar 2021 16:04:16 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id u4so23510727edv.9;
        Tue, 16 Mar 2021 16:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=9Ibz/MKaorBJiGtv7aHxDLxxLWyi7tGgMy03wQkEJrU=;
        b=KSqbbJPleL8QUEYg4kkb4pJp3oyUtVJWBvUCExaEu5C3Ncq94p13+08jjoW36LtR9R
         v9R+4f2WTnB1ffAcqIP+jaGcgHap2j7AAS9RMj1mlu921ET7XmPWcjrRXsU+9F8XpWT8
         z34i/1H7+LkLb7cwfvw00jTyzwNY5v+qkaFLhWS4BJMe/GDIXebViOUK1Ix8opdmJKSl
         sWS5x34OXzmvCuFe6YoCysJK71WsyLhAJ+wOmMVTmYbbFXR4TAF2fLKyUxQ5oTVAhe9h
         hxc514TKfyMUJgpU4hP2SAbHuEiI/1HgCSkTiB21kDQNyORrxtTYVQwODfJMuHj0mAq/
         0xdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9Ibz/MKaorBJiGtv7aHxDLxxLWyi7tGgMy03wQkEJrU=;
        b=Jsy8O5rUcYlBqlL9S2VjZkdxzz2p0eewfptNMASIDEtPeDndLNkerCkiq9nN1PXrbS
         t8i74iRmPNxSWnwwWwTFbkVCY05Tr4y+dnwGbgCecioumy+iRcvRtjT8mPap7WGkIfUk
         IYbMwqjWkfaAHVT0dHqJZvGfjD0sHqJnzJr8WQnG3scBUTIdJC4lVXuqNRnnvPiFEfvy
         DgWUgfz54JybNVLg5q/9BH8kZuPRZGFQ3QkfGmO02Ohcp9TBRkJjbLYLQ+v330ETIKa5
         qIpj3vOEXf36DTe2TQzyd1HBpLD9/+ZYXf15TO2JM2HZnrPAewoojfqz0O9PaPdVsHM/
         NvTw==
X-Gm-Message-State: AOAM531FEO6OGP9u6RUeqqVmLzjVu1XXNtt11yGfeCDrrVOcNQPIvm/8
        Cs77pL7J0BeAUvEz9+EUgxAybTCEfjEmgArk69ZqIHAgYw==
X-Google-Smtp-Source: ABdhPJyZaVdX7Pws79Bf3CzR1evP2Jbwaf9sVyGgtA4VitRZknR+/UED9a1+jT4siw7vsHc/VTQtXSA+64xzTMXTjoY=
X-Received: by 2002:a05:6402:17e9:: with SMTP id t9mr38817270edy.211.1615935855478;
 Tue, 16 Mar 2021 16:04:15 -0700 (PDT)
MIME-Version: 1.0
References: <87v9a7w8q7.fsf@suse.com> <20210304095026.782-1-aaptel@suse.com>
 <45b64990-b879-02d3-28e5-b896af0502c4@gmail.com> <87sg52t2xj.fsf@suse.com>
 <139a3729-9460-7272-b1d7-c2feb5679ee9@talpey.com> <87eegltxzd.fsf@suse.com>
 <d602e3e4-721a-a1c5-3375-1c9899da4383@talpey.com> <878s6ttwhd.fsf@suse.com>
 <23052c07-8050-4eb8-d2de-506c60dbed7d@talpey.com> <871rcltiw9.fsf@suse.com>
 <CAKywueREp5mib_4gmofwekrT=GhqoZo1kEmmUmNeqghG0EYYwQ@mail.gmail.com>
 <87pmzzs7lv.fsf@suse.com> <CAKywueQPr2H69wvju=U8aKHQw_SA4hB76BObzZVZPppKJnk++A@mail.gmail.com>
 <f25b6d85-0299-9557-2eb9-6c7666c8ea6e@talpey.com>
In-Reply-To: <f25b6d85-0299-9557-2eb9-6c7666c8ea6e@talpey.com>
From:   Pavel Shilovsky <piastryyy@gmail.com>
Date:   Tue, 16 Mar 2021 16:04:04 -0700
Message-ID: <CAKywueQkELXyRjihtD2G=vswVuaeoeyMjrDfqTQeVF_NoRVm6A@mail.gmail.com>
Subject: Re: [PATCH v4] flock.2: add CIFS details
To:     Tom Talpey <tom@talpey.com>
Cc:     =?UTF-8?Q?Aur=C3=A9lien_Aptel?= <aaptel@suse.com>,
        "Alejandro Colomar (man-pages)" <alx.manpages@gmail.com>,
        Steve French <smfrench@gmail.com>,
        linux-cifs <linux-cifs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        mtk.manpages@gmail.com, linux-man@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Make sense to make it simpler. Then I would just propose a minor fix -
to remove "even" on the last line because IO from the same file
descriptor is allowed.

"""
  Another important side-effect is that the locks are not advisory anymore:
  any IO on a locked file will always fail with EACCES,
  when done from a separate file descriptor.
"""
--
Best regards,
Pavel Shilovsky

=D0=B2=D1=82, 16 =D0=BC=D0=B0=D1=80. 2021 =D0=B3. =D0=B2 12:42, Tom Talpey =
<tom@talpey.com>:
>
> On 3/16/2021 1:39 PM, Pavel Shilovsky wrote:
> > Sure. Thanks!
> >
> > I would put more details from
> > https://docs.microsoft.com/en-us/windows/win32/api/fileapi/nf-fileapi-l=
ockfileex
> > :
> >
> > """
> >    Another important side-effect is that the locks are not advisory any=
more:
> >    any IO on an exclusively locked file will always fail with EACCES
> >    when done from a separate file descriptor; write calls on
> >    a file locked for shared access will fail with EACCES when done
> >    from any file descriptor including the one used to lock the file.
> > """
> >
> > Thoughts?
>
> I think it'll be important to define what "exclusive" and "shared"
> mean from a Linux/POSIX API perspective, and that will get into dragon
> territory. I don't think it's a good idea to attempt that in this
> manpage. It is best to leave Windows semantics, and interop with
> Windows clients, out of it.
>
> IOW, I personally prefer Aur=C3=A9lien's simple version for now.
>
> Tom.
>
> >
> > --
> > Best regards,
> > Pavel Shilovsky
> >
> > =D0=B2=D1=82, 16 =D0=BC=D0=B0=D1=80. 2021 =D0=B3. =D0=B2 03:42, Aur=C3=
=A9lien Aptel <aaptel@suse.com>:
> >>
> >> Pavel Shilovsky <piastryyy@gmail.com> writes:
> >>> It is not only about writing to a locked file. It is also about any I=
O
> >>> against a locked file if such a file is locked through another file
> >>> handle. Right?
> >>
> >> Yes that was implied, the write was a simple example to illustrate. I'=
ll
> >> update to make it more generic:
> >>
> >>    Another important side-effect is that the locks are not advisory an=
ymore:
> >>    any IO on a locked file will always fail with EACCES,
> >>    even when done from a separate file descriptor.
> >>
> >> If you have comments please provide direct text suggestion to save tim=
e.
> >>
> >> Cheers,
> >> --
> >> Aur=C3=A9lien Aptel / SUSE Labs Samba Team
> >> GPG: 1839 CB5F 9F5B FB9B AA97  8C99 03C8 A49B 521B D5D3
> >> SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 N=C3=BCrnbe=
rg, DE
> >> GF: Felix Imend=C3=B6rffer, Mary Higgins, Sri Rasiah HRB 247165 (AG M=
=C3=BCnchen)
> >>
> >
