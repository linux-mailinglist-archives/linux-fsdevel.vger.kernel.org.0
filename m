Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA32C220F85
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jul 2020 16:36:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729088AbgGOOf5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Jul 2020 10:35:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728849AbgGOOfz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Jul 2020 10:35:55 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A5F9C08C5DB
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Jul 2020 07:35:55 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id b92so3060952pjc.4
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Jul 2020 07:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=yhR2xx3ll78zXx4v/LleHZDLIGASUAw7oXjwdcYoQnM=;
        b=MBTmhayGzIbypNDEFm2+paSuwfcC+PzqE85tReoauMa8/vlEuTbLPAXgN9+8qVkcNT
         yGNU7gl/zluURp9BUENw3LJ4rFqKK/8Ff3aRUbs7uTkYSeZwW3aDJgw4Kt3y+YyUVgap
         0Zoy3gWJ2MC50r6ZcK2DVZ/eywPJseJ4IQfjEcO37x2ua0wTNQCE2y3Qf9A5N9IFiZH3
         TV20PfmuxIw8NVCsuD+kmZ/Sgqsg/HqB0qdOSMeiMCizUz5tGze/hYcp6asxJeM5mtMB
         DgMTMy20N6K6A7ufGOkrKyndioWzeqygDTq2Q7VudYC1FYDBSTz+eJgpCU7AeeAih/Ao
         uuaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=yhR2xx3ll78zXx4v/LleHZDLIGASUAw7oXjwdcYoQnM=;
        b=qkxNcW5tggxFUHf72HhdWUXMcF2M4CxsSHD0YZ63s7+DsnWYNPISjV8uTyC8eREFTU
         Iy2mdHdVlvCmSyOH6JxCue7sY1i8Glea9ZyRulm6cv3BSQW7iUWDIla3UAPDMgjfr9JT
         AzZDNKteuG3a1i9EdAtKPsuCQaAKodKVhZpn4V5HE0iII2nzn8D0QN43kDeg6jvA7LOS
         onMuBuDlLg31mOznEaUfBaNDjppCOQw1yQfrXZ1fNo2qCPMWXB9nJ3TERKB+stIT9eKj
         1TurFwrrnrZBUNkpzdHxqPaHhOrM0BCCWIBXoBJMWalO1er9dca0fytgbtYN03dJfOe3
         W7Uw==
X-Gm-Message-State: AOAM530idsKNHzfl9wTS2FIVE6g3uBHWdMmmCvo65rt6gii7GeWeBbwZ
        5l8UxOCv1GlbO8H/EmFzDLNCsA==
X-Google-Smtp-Source: ABdhPJx+DB3uxvOEpxqYRcjJv7aAG86vLrcHnfdyXOzjYxTb/HN/VlnnEvVbdEuur4NmvWF0oRc3Vw==
X-Received: by 2002:a17:90a:7406:: with SMTP id a6mr9616376pjg.152.1594823753194;
        Wed, 15 Jul 2020 07:35:53 -0700 (PDT)
Received: from ?IPv6:2601:646:c200:1ef2:14c:4e33:547f:e274? ([2601:646:c200:1ef2:14c:4e33:547f:e274])
        by smtp.gmail.com with ESMTPSA id y7sm2101353pfq.69.2020.07.15.07.35.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jul 2020 07:35:51 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: strace of io_uring events?
Date:   Wed, 15 Jul 2020 07:35:50 -0700
Message-Id: <D9FAB37B-D059-4137-A115-616237D78640@amacapital.net>
References: <CAJfpegu3EwbBFTSJiPhm7eMyTK2MzijLUp1gcboOo3meMF_+Qg@mail.gmail.com>
Cc:     strace-devel@lists.strace.io, io-uring@vger.kernel.org,
        Pavel Begunkov <asml.silence@gmail.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <CAJfpegu3EwbBFTSJiPhm7eMyTK2MzijLUp1gcboOo3meMF_+Qg@mail.gmail.com>
To:     Miklos Szeredi <miklos@szeredi.hu>,
        Kees Cook <keescook@chromium.org>,
        Christian Brauner <christian.brauner@ubuntu.com>
X-Mailer: iPhone Mail (17F80)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Jul 15, 2020, at 4:12 AM, Miklos Szeredi <miklos@szeredi.hu> wrote:
>=20
> =EF=BB=BFHi,
>=20
> This thread is to discuss the possibility of stracing requests
> submitted through io_uring.   I'm not directly involved in io_uring
> development, so I'm posting this out of  interest in using strace on
> processes utilizing io_uring.
>=20
> io_uring gives the developer a way to bypass the syscall interface,
> which results in loss of information when tracing.  This is a strace
> fragment on  "io_uring-cp" from liburing:
>=20
> io_uring_enter(5, 40, 0, 0, NULL, 8)    =3D 40
> io_uring_enter(5, 1, 0, 0, NULL, 8)     =3D 1
> io_uring_enter(5, 1, 0, 0, NULL, 8)     =3D 1
> ...
>=20
> What really happens are read + write requests.  Without that
> information the strace output is mostly useless.
>=20
> This loss of information is not new, e.g. calls through the vdso or
> futext fast paths are also invisible to strace.  But losing filesystem
> I/O calls are a major blow, imo.
>=20
> What do people think?
>=20
> =46rom what I can tell, listing the submitted requests on
> io_uring_enter() would not be hard.  Request completion is
> asynchronous, however, and may not require  io_uring_enter() syscall.
> Am I correct?
>=20
> Is there some existing tracing infrastructure that strace could use to
> get async completion events?  Should we be introducing one?
>=20
>=20

Let=E2=80=99s add some seccomp folks. We probably also want to be able to ru=
n seccomp-like filters on io_uring requests. So maybe io_uring should call i=
nto seccomp-and-tracing code for each action.=
