Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B685F33C53B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Mar 2021 19:06:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232058AbhCOSGN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Mar 2021 14:06:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232797AbhCOSGE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Mar 2021 14:06:04 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22658C06174A;
        Mon, 15 Mar 2021 11:06:04 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id bx7so18425802edb.12;
        Mon, 15 Mar 2021 11:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=dtKlKHFRajPvI7CSMUOEG4ze6C8H0xz+Hxml/vouBM0=;
        b=NshHy0liKI2h07+tos8pGxEzNZ3I684y+UdGmC8CNKz0cG1wSGBvVsbpGtCVUscnuM
         NABJbNYx99oPZiRvcjFPtN0JXQthg5ribz0zRKoXjesSlDFSWsov2AYwSee3wd0Gk8eI
         ZEqRKwI9uiR+VLyWUl+4a7KS77ahiEtlhTF29n3QMw/jM4gf9CUtuNabUszBz+JyTnbN
         AnAhDO9P1ObiYO8OsjlY1h8jUi9iEUcGbpdhhDxPEhPhFlT3RbcqZUS5S3CDU2jcUaP4
         Kxp4xODeLAza4Ye7+qaI/0lBvudju0ARq2zt/l+Tni2OVZnkMJfNHHWqSMluPiGnVrhh
         +cZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=dtKlKHFRajPvI7CSMUOEG4ze6C8H0xz+Hxml/vouBM0=;
        b=cndgwcflTRmx03fEo5E6l+StQPTI/GbzNaR+U94kv388uqYxokCiafbFXVbDjgBBpW
         M5hsMoy4EqYdPYSRgZqcDlyUoDirMU/ICJ1NOS8T6dQcQboGnbBi/4NNz8yEOEdV9f9V
         QHLNTsackfa9mMVEHyO9QQ7fpqWQTy8jFUgGseZAPhuuMZmIklcW89LFlJ6eSpv0qkyn
         ZchNxfXGECdRouaHrAoybZ+GxlJgeEe/nwikqn0Zhn168EqStBzhQl0mv9Wjr2Z3/5xn
         3hV2MYXF5uwWhn464ZOz7s9jCMmpis2m1wQ1Qtge5/38ylVNV3b5qZO0AeII8B0K60pk
         NuwQ==
X-Gm-Message-State: AOAM5300gvfPJO7WZHzjvWriHKFu9AboiMMgOBjOMdGuvsCWh7ogoF2t
        KpB4L4wLl9/R6XEQO19VCp3j78jwAGCGLjrWRFw1zVw/Mg==
X-Google-Smtp-Source: ABdhPJzBy+4gMbICPjfDzgy0t8kR3JjU4gv+tunKC6UAZ22iY4j8lQZokca/okQu4FhiOjdMXOyGELlf+UUQCuzfqc0=
X-Received: by 2002:a05:6402:3089:: with SMTP id de9mr31845095edb.10.1615831562875;
 Mon, 15 Mar 2021 11:06:02 -0700 (PDT)
MIME-Version: 1.0
References: <87v9a7w8q7.fsf@suse.com> <20210304095026.782-1-aaptel@suse.com>
 <45b64990-b879-02d3-28e5-b896af0502c4@gmail.com> <87sg52t2xj.fsf@suse.com>
 <139a3729-9460-7272-b1d7-c2feb5679ee9@talpey.com> <87eegltxzd.fsf@suse.com>
 <d602e3e4-721a-a1c5-3375-1c9899da4383@talpey.com> <878s6ttwhd.fsf@suse.com>
 <23052c07-8050-4eb8-d2de-506c60dbed7d@talpey.com> <871rcltiw9.fsf@suse.com>
In-Reply-To: <871rcltiw9.fsf@suse.com>
From:   Pavel Shilovsky <piastryyy@gmail.com>
Date:   Mon, 15 Mar 2021 11:05:51 -0700
Message-ID: <CAKywueREp5mib_4gmofwekrT=GhqoZo1kEmmUmNeqghG0EYYwQ@mail.gmail.com>
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

=D1=87=D1=82, 11 =D0=BC=D0=B0=D1=80. 2021 =D0=B3. =D0=B2 14:41, Aur=C3=A9li=
en Aptel <aaptel@suse.com>:


Hi Aurelien,

>
> Ok, then I agree with your last paragraph. Here's the current version, wi=
th semantic newlines:
>
>  In Linux kernels up to 5.4, flock() is not propagated over SMB.
>  A file with such locks will not appear locked for remote clients.
>
>  Since Linux 5.5, flock() locks are emulated with SMB byte-range locks on=
 the entire file.
>  Similarly to NFS, this means that fcntl(2) and flock() locks interact wi=
th one another.
>  Another important side-effect is that the locks are not advisory anymore=
:
>  a write on a locked file will always fail with EACCES.

It is not only about writing to a locked file. It is also about any IO
against a locked file if such a file is locked through another file
handle. Right?

--
Best regards,
Pavel Shilovsky
