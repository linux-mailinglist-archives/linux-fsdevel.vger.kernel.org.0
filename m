Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 615816AC470
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Mar 2023 16:09:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbjCFPJn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Mar 2023 10:09:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbjCFPJl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Mar 2023 10:09:41 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDAF222A1C
        for <linux-fsdevel@vger.kernel.org>; Mon,  6 Mar 2023 07:09:25 -0800 (PST)
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com [209.85.219.197])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id ABAA13F125
        for <linux-fsdevel@vger.kernel.org>; Mon,  6 Mar 2023 14:09:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1678111782;
        bh=f2v5CEMXX3gXYzLE99k6iR0CRvXpbrxSSolJwoueXz0=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=SlQwnjT7VEbeYpqtOcUcAuTHRPdcpBXqypW5y9CxwEBsiAyv7WZ+Ch2MMROQS+zCa
         LnolPdfUEBVOk4Pu7dNORAukjiK2RnY2bJXiEA6bGlcwoEb8jNRBHJF5JQrhNn4p8i
         /8U6GiV5TBbZf83NfqNX/pM4RocT4I2lLkj9GvFu+X/UqZVVk7H4nCkjA4K+0luZhO
         7sFgDzYDGLaKN+d0IM6psFJSs/wUQGEn3KWL0v+ZlGmx6GdaKZNbVdvd4A5ZBAaFiB
         BoivTMRaDwfzbrwZIIplmGjM1EStHzPJrkABD+FnRXfrSy3XdX+kIjBXlVwtXUDP7A
         8g2wPu04jJhMg==
Received: by mail-yb1-f197.google.com with SMTP id o3-20020a257303000000b00a131264017aso10694310ybc.20
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 Mar 2023 06:09:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678111782;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f2v5CEMXX3gXYzLE99k6iR0CRvXpbrxSSolJwoueXz0=;
        b=tjaqaRJ24T4BIuyBoULDJKHYgTwwwc1tZKvwxVRE5iJ/D89mYWOT1xk8Lfnf0LjnGZ
         6I74su3aASs/PCZM09S/FwywE/4hvQ+iNYl1lcgMWjWLAEbBooDhOxwCBOkifBigFEDU
         Jh/Tloxj9eEvMMqZAnnuzCcEXDM2zWzZoWLfgb0UiVLBadtwC/oZPPcg4DEWyvhOW4GQ
         2Qxvw1bTenL4nJ//dH8INE9AOreinOZB63OrIuGicE7RtyXffmSyRZi2JxFMdZreEu+C
         Xw1tYLQ1ULAtbvkFKxwKbQYA6hx2VgdnMY2AS4e3yQWkuaeNbtAc2sXCYBvlqufbdfkG
         rmxQ==
X-Gm-Message-State: AO0yUKXM8spT7IXqtNn+Q912UUjSrQOYLkiMFTNqoBvF5uwk4un/CeLe
        eO82C4WBkUhi1dyayeEhFjLyVLKa7dDPrvT9+CvgDpMdt7UYjszp7B3GT2TznSds9GD/qCDSA7C
        wZ0XhYfdZfMe/Jykm2bUsB/UiRWYHUVwwx9mCZSZC2KBtZVNQizze6Y+2uz0=
X-Received: by 2002:a81:af52:0:b0:52e:b48f:7349 with SMTP id x18-20020a81af52000000b0052eb48f7349mr6964038ywj.6.1678111782230;
        Mon, 06 Mar 2023 06:09:42 -0800 (PST)
X-Google-Smtp-Source: AK7set/qGKtb7f/W60UbxpJV4lHpxUt88fYIdqGi3qnpEpEAIFHYbXk+SL7tIS3T0MF+znhipcG5v3sWI+bgGQWdtDc=
X-Received: by 2002:a81:af52:0:b0:52e:b48f:7349 with SMTP id
 x18-20020a81af52000000b0052eb48f7349mr6964020ywj.6.1678111782030; Mon, 06 Mar
 2023 06:09:42 -0800 (PST)
MIME-Version: 1.0
References: <20230220193754.470330-1-aleksandr.mikhalitsyn@canonical.com>
 <20230220193754.470330-8-aleksandr.mikhalitsyn@canonical.com> <381a19bb-d17e-b48b-8259-6287dbe170df@fastmail.fm>
In-Reply-To: <381a19bb-d17e-b48b-8259-6287dbe170df@fastmail.fm>
From:   Aleksandr Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Date:   Mon, 6 Mar 2023 15:09:31 +0100
Message-ID: <CAEivzxf8HKs2FJwTohzGVcb0TRNy9QJbEALC3dni3zx+tOb9Gg@mail.gmail.com>
Subject: Re: [RFC PATCH 7/9] fuse: add fuse device ioctl(FUSE_DEV_IOC_REINIT)
To:     Bernd Schubert <bernd.schubert@fastmail.fm>
Cc:     mszeredi@redhat.com, Al Viro <viro@zeniv.linux.org.uk>,
        Amir Goldstein <amir73il@gmail.com>,
        =?UTF-8?Q?St=C3=A9phane_Graber?= <stgraber@ubuntu.com>,
        Seth Forshee <sforshee@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Andrei Vagin <avagin@gmail.com>,
        Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        criu@openvz.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 3, 2023 at 8:26=E2=80=AFPM Bernd Schubert
<bernd.schubert@fastmail.fm> wrote:
>
>
>
> On 2/20/23 20:37, Alexander Mikhalitsyn wrote:
> > This ioctl aborts fuse connection and then reinitializes it,
> > sends FUSE_INIT request to allow a new userspace daemon
> > to pick up the fuse connection.
> >
> > Cc: Miklos Szeredi <mszeredi@redhat.com>
> > Cc: Al Viro <viro@zeniv.linux.org.uk>
> > Cc: Amir Goldstein <amir73il@gmail.com>
> > Cc: St=C3=83=C2=A9phane Graber <stgraber@ubuntu.com>
> > Cc: Seth Forshee <sforshee@kernel.org>
> > Cc: Christian Brauner <brauner@kernel.org>
> > Cc: Andrei Vagin <avagin@gmail.com>
> > Cc: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
> > Cc: linux-fsdevel@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org
> > Cc: criu@openvz.org
> > Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.c=
om>
> > ---
> >   fs/fuse/dev.c             | 132 +++++++++++++++++++++++++++++++++++++=
+
> >   include/uapi/linux/fuse.h |   1 +
> >   2 files changed, 133 insertions(+)
> >
> > diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> > index 737764c2295e..0f53ffd63957 100644
> > --- a/fs/fuse/dev.c
> > +++ b/fs/fuse/dev.c
> > @@ -2187,6 +2187,112 @@ void fuse_abort_conn(struct fuse_conn *fc)
> >   }
> >   EXPORT_SYMBOL_GPL(fuse_abort_conn);
> >
> > +static int fuse_reinit_conn(struct fuse_conn *fc)
> > +{
> > +     struct fuse_iqueue *fiq =3D &fc->iq;
> > +     struct fuse_dev *fud;
> > +     unsigned int i;
> > +
> > +     if (fc->conn_gen + 1 < fc->conn_gen)
> > +             return -EOVERFLOW;
> > +
> > +     fuse_abort_conn(fc);
> > +     fuse_wait_aborted(fc);
>
> Shouldn't this also try to flush all data first?

I think we should. Thanks for pointing to that!

I've read all your comments and I'll prepare -v2 series soon.

Thanks a lot, Bernd!

>
