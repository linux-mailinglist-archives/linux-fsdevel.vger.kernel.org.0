Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2561A70F3B1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 May 2023 12:03:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231446AbjEXKDz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 May 2023 06:03:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbjEXKDu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 May 2023 06:03:50 -0400
Received: from mail-vk1-xa35.google.com (mail-vk1-xa35.google.com [IPv6:2607:f8b0:4864:20::a35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09B8793
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 May 2023 03:03:49 -0700 (PDT)
Received: by mail-vk1-xa35.google.com with SMTP id 71dfb90a1353d-4573e1e6cb9so2849120e0c.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 May 2023 03:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684922628; x=1687514628;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C0ExXWHIoKFI0Uyhm09tS6ikYC2eFhEe7idHE0EGN3M=;
        b=WpkJ3CbhIJ7sjt4PlHkj75V7iyBkJ7L6JA4go1l2KqsrWFagkMFoPxwuDgn8m8qb2O
         tAESwye4v3GDOs6ILZD3sv7hOrpYy1bxYV0zM/7bERyydkcidjTBNjmIkGZFlMU4ng5h
         vXmuNsnoswg+C8qlr3Uaad+9ICqssSF6hWpWcCF3gbAj1BBV5tzzFwaGCKmQGJQ5o9u8
         x9POtwefEsIuv1qzNU1aM6UCMvDbyAYomATt/ecTaCfY2G9ZMCneCNjXDvJbz0fcbjAd
         Pa/b/3rfzMJOac37qKPDRImpq0jKWf/NV2SRn3HLXvRrEQCCpavGnEeilr3npPRmfVms
         gtzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684922628; x=1687514628;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C0ExXWHIoKFI0Uyhm09tS6ikYC2eFhEe7idHE0EGN3M=;
        b=ivnvuHp/rLDtpllYYVw+a/wQKRLWTgZUsZdVzIG3butr/xGqA8PAFWnQ7VPADcoPYD
         jV1CmUEganR/QM6wHE9wv19HrYCqziF4TZksi6KzzyQvMJ/zKsVmLmemvGmV/R0x7sXC
         Y7OvwLw4vGVToq1sqomXqfHA/EYQGXOK0yrwOxCBMhfDS/adA4GS7e9ok5oXCXObiuQ7
         iKgXoMVGKGUR7e+9R6Ppa16+8BtkbfT7aV2QEROSmK+ZAaehoq4o8WPb5GipmI6WjEol
         W9egxd5NrtiFHU57Xy1NsKWXvVznbtHNgEY4ry/GgileMqxIbyNbdEJEhdaQw9w6mObh
         I2eg==
X-Gm-Message-State: AC+VfDyZ1Ha8AAh64cYbx7ntiZcn1ufu1Eji0x4irJ+5kfKAwzY12ESj
        TyH/DZVuprlNI7sBOyz0k9Rtf05W9r6yw1NnDN0=
X-Google-Smtp-Source: ACHHUZ7CkFpCbzs9UGuCxluHCIdzoR7/b3r1fJH8fdW1u4mJcHePe1fdr1SUup3q5R4Brsy/ZZu9r6Jq8OWK9qXTn98=
X-Received: by 2002:a1f:17c1:0:b0:45a:2a47:febe with SMTP id
 184-20020a1f17c1000000b0045a2a47febemr1075217vkx.3.1684922627985; Wed, 24 May
 2023 03:03:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230519125705.598234-1-amir73il@gmail.com> <20230519125705.598234-6-amir73il@gmail.com>
 <CAJfpeguhmZbjP3JLqtUy0AdWaHOkAPWeP827BBWwRFEAUgnUcQ@mail.gmail.com>
In-Reply-To: <CAJfpeguhmZbjP3JLqtUy0AdWaHOkAPWeP827BBWwRFEAUgnUcQ@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 24 May 2023 13:03:37 +0300
Message-ID: <CAOQ4uxhYZqe0-r9knvdW_BWNvfeKapiwReTv4FWr_Px+CB+ENw@mail.gmail.com>
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
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 22, 2023 at 6:20=E2=80=AFPM Miklos Szeredi <miklos@szeredi.hu> =
wrote:
>
> On Fri, 19 May 2023 at 14:57, Amir Goldstein <amir73il@gmail.com> wrote:
> >
> > Extend the passthrough feature by handling asynchronous IO both for rea=
d
> > and write operations.
> >
> > When an AIO request is received, if the request targets a FUSE file wit=
h
> > the passthrough functionality enabled, a new identical AIO request is
> > created.  The new request targets the backing file and gets assigned
> > a special FUSE passthrough AIO completion callback.
> >
> > When the backing file AIO request is completed, the FUSE
> > passthrough AIO completion callback is executed and propagates the
> > completion signal to the FUSE AIO request by triggering its completion
> > callback as well.
>
> Overlayfs added refcounting to the async req (commit 9a2544037600
> ("ovl: fix use after free in struct ovl_aio_req")).  Is that not
> needed for fuse as well?
>
> Would it make sense to try and merge the two implementations?
>

Makes sense - I will look into it.

Thanks,
Amir.
