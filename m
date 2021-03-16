Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B29F033DB18
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Mar 2021 18:40:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233815AbhCPRkZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Mar 2021 13:40:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231851AbhCPRkJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Mar 2021 13:40:09 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BED47C06174A;
        Tue, 16 Mar 2021 10:40:08 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id p7so62268343eju.6;
        Tue, 16 Mar 2021 10:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=i5kkHQ8E1HhgPS/MAR9lcva5tZR4bT7RdY4xuS+LLgA=;
        b=WY5l3rsXRRLyx3+gegGnEUA4abaaHaV5DIPGHMIj9UEHqPj0QUFTIMoaWTO5VmWhzd
         1Pb8NkJ5/wqvQ8n177F58yYUDCqH6xt/KcYXCVGFPw59HwQpAAdK7oOJmmhtzfcgL8Gs
         7jpx9RSp7L7uJL9NgcrCS2c6JKG2LF9VxUI9rlh0SiQK2+nq0j8G3MCJfkcycNSYzsEW
         AUzJmNetI9vbcIK14UCVeZUxlMDz1IB3Tg0NyeMJOqsZc1L8rqpQDxzN/xAPBmnGIrNV
         JdBYkXalymKP7fI9PtSmcHwtaXS4wVAwWHqRojulgsSJhLAgV5Nt1U3BDgw4PYK0TBQf
         TzbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=i5kkHQ8E1HhgPS/MAR9lcva5tZR4bT7RdY4xuS+LLgA=;
        b=YkCIEc4u4UPuNJfI6xBEzmVzknAFHcOlyltgpteWQ1+PuSTN2bpOdMZvHGm5fGb7G/
         Y5auy2cWhEIPseN98ft64Kyfz+ijOf9KOS01bNmcchjKXFgvP6Vvn2VqHwlWwS11bxHG
         vRcwH109MA+mgtmsT7xbhawBkXFofiqEF4X/4HhlIDqiwVe3YKvHtpWS8cC+VzKGelF9
         RXA3SvD0/QOWh7k3nUe95hItk4wCd6MCCteN80w2zF5zq3iGN5Rq2cmM2WhzBYvut4Ed
         b9b6iSm+sHWipUFFpdVMHHiHpNmg5F7uJSGXKgKCS5LSt9S3EQ2J7wtysrZonEMgcsqT
         W/lg==
X-Gm-Message-State: AOAM533NJ/U0mF/kFO0nLkeYE0HbQZ2zNYnOcOJvGiLGWBjv1S+2iiOV
        KNvbbFrd9ug5eRtErf0YHhxtzVEasiUzOxI2MQ==
X-Google-Smtp-Source: ABdhPJwvdZuSQbD7ZSg1tEitXgR4MqXVWi/4APt2EpFSbFXPcRxzvNBCMJiH1UXcx9oSt+IVAV1ORngTKevkSKesqL4=
X-Received: by 2002:a17:906:7c48:: with SMTP id g8mr31326205ejp.138.1615916407556;
 Tue, 16 Mar 2021 10:40:07 -0700 (PDT)
MIME-Version: 1.0
References: <87v9a7w8q7.fsf@suse.com> <20210304095026.782-1-aaptel@suse.com>
 <45b64990-b879-02d3-28e5-b896af0502c4@gmail.com> <87sg52t2xj.fsf@suse.com>
 <139a3729-9460-7272-b1d7-c2feb5679ee9@talpey.com> <87eegltxzd.fsf@suse.com>
 <d602e3e4-721a-a1c5-3375-1c9899da4383@talpey.com> <878s6ttwhd.fsf@suse.com>
 <23052c07-8050-4eb8-d2de-506c60dbed7d@talpey.com> <871rcltiw9.fsf@suse.com>
 <CAKywueREp5mib_4gmofwekrT=GhqoZo1kEmmUmNeqghG0EYYwQ@mail.gmail.com> <87pmzzs7lv.fsf@suse.com>
In-Reply-To: <87pmzzs7lv.fsf@suse.com>
From:   Pavel Shilovsky <piastryyy@gmail.com>
Date:   Tue, 16 Mar 2021 10:39:56 -0700
Message-ID: <CAKywueQPr2H69wvju=U8aKHQw_SA4hB76BObzZVZPppKJnk++A@mail.gmail.com>
Subject: Re: [PATCH v4] flock.2: add CIFS details
To:     =?UTF-8?Q?Aur=C3=A9lien_Aptel?= <aaptel@suse.com>
Cc:     Tom Talpey <tom@talpey.com>,
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

Sure. Thanks!

I would put more details from
https://docs.microsoft.com/en-us/windows/win32/api/fileapi/nf-fileapi-lockf=
ileex
:

"""
  Another important side-effect is that the locks are not advisory anymore:
  any IO on an exclusively locked file will always fail with EACCES
  when done from a separate file descriptor; write calls on
  a file locked for shared access will fail with EACCES when done
  from any file descriptor including the one used to lock the file.
"""

Thoughts?

--
Best regards,
Pavel Shilovsky

=D0=B2=D1=82, 16 =D0=BC=D0=B0=D1=80. 2021 =D0=B3. =D0=B2 03:42, Aur=C3=A9li=
en Aptel <aaptel@suse.com>:
>
> Pavel Shilovsky <piastryyy@gmail.com> writes:
> > It is not only about writing to a locked file. It is also about any IO
> > against a locked file if such a file is locked through another file
> > handle. Right?
>
> Yes that was implied, the write was a simple example to illustrate. I'll
> update to make it more generic:
>
>   Another important side-effect is that the locks are not advisory anymor=
e:
>   any IO on a locked file will always fail with EACCES,
>   even when done from a separate file descriptor.
>
> If you have comments please provide direct text suggestion to save time.
>
> Cheers,
> --
> Aur=C3=A9lien Aptel / SUSE Labs Samba Team
> GPG: 1839 CB5F 9F5B FB9B AA97  8C99 03C8 A49B 521B D5D3
> SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 N=C3=BCrnberg,=
 DE
> GF: Felix Imend=C3=B6rffer, Mary Higgins, Sri Rasiah HRB 247165 (AG M=C3=
=BCnchen)
>
