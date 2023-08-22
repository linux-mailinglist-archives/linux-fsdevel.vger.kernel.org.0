Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BABA4783DC3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Aug 2023 12:18:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234683AbjHVKSr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Aug 2023 06:18:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234701AbjHVKSr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Aug 2023 06:18:47 -0400
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DC041B0;
        Tue, 22 Aug 2023 03:18:42 -0700 (PDT)
Received: by mail-vs1-xe2a.google.com with SMTP id ada2fe7eead31-44d3e4ad403so939899137.0;
        Tue, 22 Aug 2023 03:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692699521; x=1693304321;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wl4gDEQfnBfsjoQ6NjFakdQvyEEOmqK6yqB6WYPcMdw=;
        b=CI3QbXWV3ZTw6YdJ4LTcpdCNOIWtx1/sXsMoyjpnwV+yWPHNHA63blhHWli7pLWZLk
         QUjYS+BsAp8BKY2mg2qacgDMZsL0lwSVt/+PrbQiNFNLMT8x9ZOWG7apXRnhqe0y8olc
         SHJezq/AA5pLnqk+U8emwwGirERTia28XKbYyFMV6lU3qxNykIFso0o8NzXLMJQZXP+u
         dbmuacpD899AGUGoImwGBttq2jPlCxa2NfHP4s48ADOnqudrB4pZnbKYrlRzxH3LnLwU
         9PAGKd4H2OrJwH3kmtMgX3gbcQmyFX+dWRq8yV7unNFYDBKwy2B0qHsn6Wi62tDu42NU
         woyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692699521; x=1693304321;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wl4gDEQfnBfsjoQ6NjFakdQvyEEOmqK6yqB6WYPcMdw=;
        b=Cx+dgjPGn6pRksPWffvmu7CMlRnvGXWVMoOLI0fSy5K1G0Mi9KixjDELqR/F3WGJNc
         zyarwICGYTMu0NcGXQlCFFsDWGb+RuDo/6VYaMJ6m91PB1UxFKPkz38XcJv+FPRGZ6lJ
         sPcWo2zSznroqNBkfZl5npm9XD4yUlgNKvamnSBGVoVmJ3aBBVkyH6UG9a+HeEpSVKFF
         0kjfF884HdCSdCbOwW8SccyY4D6M2BXSteSz9VSbEBAOx8M3IOsCsaC2+VZOVFpHnoR9
         dXoCYR2cyLTC9dpLj9OpWGh/NwFo5IunzKvsdWdkWPAbIvFmIM77Eb/sOnKusRe2AJ4R
         jwqw==
X-Gm-Message-State: AOJu0YzFI7sa2UI9VoezlQLk0Co0+W4yA1vSuba8I4//Ufvv4edfNL0o
        DP5NcXR+kCV/BKHk5XXGDb80lkf4f+d8aTR5F3M=
X-Google-Smtp-Source: AGHT+IF1FIfQvECOD74OzDdmY5EY3yQh4kOOvB9ea53R0KKJ5E1My8vF38B45k2doaRgZ4QsslCXCBaJV5kpD60mTCw=
X-Received: by 2002:a05:6102:354f:b0:447:6cd9:42ce with SMTP id
 e15-20020a056102354f00b004476cd942cemr8044574vss.8.1692699521139; Tue, 22 Aug
 2023 03:18:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230519125705.598234-1-amir73il@gmail.com> <20230519125705.598234-6-amir73il@gmail.com>
 <CAJfpeguhmZbjP3JLqtUy0AdWaHOkAPWeP827BBWwRFEAUgnUcQ@mail.gmail.com>
 <CAOQ4uxhYZqe0-r9knvdW_BWNvfeKapiwReTv4FWr_Px+CB+ENw@mail.gmail.com> <CAOQ4uxhBeFSV7TFuWXBgJZuu-eJBjKcsshDdxCz-fie0MqwVcw@mail.gmail.com>
In-Reply-To: <CAOQ4uxhBeFSV7TFuWXBgJZuu-eJBjKcsshDdxCz-fie0MqwVcw@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 22 Aug 2023 13:18:30 +0300
Message-ID: <CAOQ4uxirdrsaHPyctxRgSMxb2mBHJCJqB12Eof02CnouExKgzQ@mail.gmail.com>
Subject: Re: [PATCH v13 05/10] fuse: Handle asynchronous read and write in passthrough
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Daniel Rosenberg <drosen@google.com>,
        Paul Lawrence <paullawrence@google.com>,
        Alessio Balsini <balsini@android.com>,
        fuse-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org,
        overlayfs <linux-unionfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 21, 2023 at 6:27=E2=80=AFPM Amir Goldstein <amir73il@gmail.com>=
 wrote:
>
> On Wed, May 24, 2023 at 1:03=E2=80=AFPM Amir Goldstein <amir73il@gmail.co=
m> wrote:
> >
> > On Mon, May 22, 2023 at 6:20=E2=80=AFPM Miklos Szeredi <miklos@szeredi.=
hu> wrote:
> > >
> > > On Fri, 19 May 2023 at 14:57, Amir Goldstein <amir73il@gmail.com> wro=
te:
> > > >
> > > > Extend the passthrough feature by handling asynchronous IO both for=
 read
> > > > and write operations.
> > > >
> > > > When an AIO request is received, if the request targets a FUSE file=
 with
> > > > the passthrough functionality enabled, a new identical AIO request =
is
> > > > created.  The new request targets the backing file and gets assigne=
d
> > > > a special FUSE passthrough AIO completion callback.
> > > >
> > > > When the backing file AIO request is completed, the FUSE
> > > > passthrough AIO completion callback is executed and propagates the
> > > > completion signal to the FUSE AIO request by triggering its complet=
ion
> > > > callback as well.
> > >
> > > Overlayfs added refcounting to the async req (commit 9a2544037600
> > > ("ovl: fix use after free in struct ovl_aio_req")).  Is that not
> > > needed for fuse as well?
> > >
> > > Would it make sense to try and merge the two implementations?
> > >
> >
> > Makes sense - I will look into it.
>
>
> Hi Miklos,
>
> Getting back to this.
> Did you mean something like that? (only compile tested)
>
> https://github.com/amir73il/linux/commits/backing_fs
>
> If yes, then I wonder:
> 1. Is the difference between FUSE_IOCB_MASK and OVL_IOCB_MASK
>     (i.e. the APPEND flag) intentional?
> 2. What would be the right way to do ovl_copyattr() on io completion?
>     Pass another completion handler to read/write helpers?
>     This seems a bit ugly. Do you have a nicer idea?
>

Hmm. Looking closer, ovl_copyattr() in ovl_aio_cleanup_handler()
seems a bit racy as it is not done under inode_lock().

I wonder if it is enough to fix that by adding the lock or if we need
to resort to a more complicated scheme like FUSE_I_SIZE_UNSTABLE
for overlayfs aio?

Thanks,
Amir.
