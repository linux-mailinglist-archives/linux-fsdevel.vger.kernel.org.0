Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DB5C782D3F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Aug 2023 17:27:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236291AbjHUP1a (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Aug 2023 11:27:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234196AbjHUP13 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Aug 2023 11:27:29 -0400
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com [IPv6:2607:f8b0:4864:20::92e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E299FD9
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Aug 2023 08:27:27 -0700 (PDT)
Received: by mail-ua1-x92e.google.com with SMTP id a1e0cc1a2514c-79ddb700ad4so985543241.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Aug 2023 08:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692631647; x=1693236447;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gVBJzbMwdZfagVX+N/vgd+WYgKb9rnxZ7o2AiRL4i2c=;
        b=pT+PlG2vClEXK1ZjrEQfS2U/7xMWMcZdRK2gIYL5xTItoxwjLXPn6TRglFV2aidjqy
         1P4/hbJjwFLln9kpCqZFOiwjNC1DV1H55N5h4KA218HTJFw9alpW2AktTDtucHUyxG57
         qQ/W9hvW8zybkgJy/WRZQ0R03GErWYiipZj+ZwEoXCyRNPGiWGNuW0sy65t9afhe+3u3
         A2ijKiqj7BKf9tmTfXnFclKnoLgPQW5JGs5z15FiBuYFtKgJzK0eqkJWRMZZxLGyxSnw
         VHLJSoGP6WKnQZiTQEo9ejCYTZY4dsFXlwFk62/EhQcludkfQlOc062HsTEcqfpD+tYA
         aVbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692631647; x=1693236447;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gVBJzbMwdZfagVX+N/vgd+WYgKb9rnxZ7o2AiRL4i2c=;
        b=D8tuR30iKvVNqg3mU9psYDmvcYzomPpsKFFFzt4u0WLozCerT7qmpU8s7IrjGnLTSu
         1TvKpFxUyB62FbIYUfrcMDVgNzakaw3Nx9e053z03kb4tORd+vKQMAOxhDoOd3IvYlJl
         gArRcAdJRYRMXVUOmniZzfmOuZYcrw6qQ7jnSGyki9PvAmKOwbb2n9WBWlNzT2Eh7+yv
         RNEkSHmmDACxSWlvW3strqQLZb1nb9dd6LXpO8E5AZTGwXzHTupZYhnal7MdkWsW7oxc
         lVhGRcr4PZlYD3Rz0FTq4NeijUptWphlwZfXvq9dFjEoD+uNuwkmxaWM2b9n60Rs/ulB
         S45A==
X-Gm-Message-State: AOJu0YwOe3JRVH4niJog5jYe+DAzgbBQc21lkD4R8GwsLY65Xh5AjVZo
        9FIWlXeDlBa1S8BdMUnvUMFkPH6ka/Qt6Dx9yOc=
X-Google-Smtp-Source: AGHT+IFydGBA9z+dSxUF4PNutx0CYlqoNVricwByinDGrigY5wVk9247HD4Uv27rf/p4mE3t3cLjSsV8OTWsEps9nTs=
X-Received: by 2002:a05:6102:4a7:b0:440:a8c8:f34 with SMTP id
 r7-20020a05610204a700b00440a8c80f34mr5732941vsa.3.1692631646930; Mon, 21 Aug
 2023 08:27:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230519125705.598234-1-amir73il@gmail.com> <20230519125705.598234-6-amir73il@gmail.com>
 <CAJfpeguhmZbjP3JLqtUy0AdWaHOkAPWeP827BBWwRFEAUgnUcQ@mail.gmail.com> <CAOQ4uxhYZqe0-r9knvdW_BWNvfeKapiwReTv4FWr_Px+CB+ENw@mail.gmail.com>
In-Reply-To: <CAOQ4uxhYZqe0-r9knvdW_BWNvfeKapiwReTv4FWr_Px+CB+ENw@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 21 Aug 2023 18:27:15 +0300
Message-ID: <CAOQ4uxhBeFSV7TFuWXBgJZuu-eJBjKcsshDdxCz-fie0MqwVcw@mail.gmail.com>
Subject: Re: [PATCH v13 05/10] fuse: Handle asynchronous read and write in passthrough
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Daniel Rosenberg <drosen@google.com>,
        Paul Lawrence <paullawrence@google.com>,
        Alessio Balsini <balsini@android.com>,
        fuse-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org
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

On Wed, May 24, 2023 at 1:03=E2=80=AFPM Amir Goldstein <amir73il@gmail.com>=
 wrote:
>
> On Mon, May 22, 2023 at 6:20=E2=80=AFPM Miklos Szeredi <miklos@szeredi.hu=
> wrote:
> >
> > On Fri, 19 May 2023 at 14:57, Amir Goldstein <amir73il@gmail.com> wrote=
:
> > >
> > > Extend the passthrough feature by handling asynchronous IO both for r=
ead
> > > and write operations.
> > >
> > > When an AIO request is received, if the request targets a FUSE file w=
ith
> > > the passthrough functionality enabled, a new identical AIO request is
> > > created.  The new request targets the backing file and gets assigned
> > > a special FUSE passthrough AIO completion callback.
> > >
> > > When the backing file AIO request is completed, the FUSE
> > > passthrough AIO completion callback is executed and propagates the
> > > completion signal to the FUSE AIO request by triggering its completio=
n
> > > callback as well.
> >
> > Overlayfs added refcounting to the async req (commit 9a2544037600
> > ("ovl: fix use after free in struct ovl_aio_req")).  Is that not
> > needed for fuse as well?
> >
> > Would it make sense to try and merge the two implementations?
> >
>
> Makes sense - I will look into it.


Hi Miklos,

Getting back to this.
Did you mean something like that? (only compile tested)

https://github.com/amir73il/linux/commits/backing_fs

If yes, then I wonder:
1. Is the difference between FUSE_IOCB_MASK and OVL_IOCB_MASK
    (i.e. the APPEND flag) intentional?
2. What would be the right way to do ovl_copyattr() on io completion?
    Pass another completion handler to read/write helpers?
    This seems a bit ugly. Do you have a nicer idea?

Thanks,
Amir.
