Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3D61377B35
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 May 2021 06:26:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbhEJE1v (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 May 2021 00:27:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbhEJE1u (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 May 2021 00:27:50 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FDB2C061573;
        Sun,  9 May 2021 21:26:46 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id w13so792706ilv.11;
        Sun, 09 May 2021 21:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vrW6spNhSrHQfksBCubidylUZF4PsPIbB3rPZO64ujI=;
        b=maMV82VdZ+6NVY1H1vUwxTqXy0nXFpllHSIJ/tyCXiwj9kE0LCybDNLh4PhzoP7aVE
         YoOi2jEd7ZfhUFyLEa2yiFCg2G0lnQ52DEOXXYCtn+JOxlrmUytOXJxIbXydU8ixOHvl
         q1XrwslzrWDiizvyPzeB4pwn9kb6bKR0zDi4/3ued811MlgT5DJwX8fqzElF7rEmEiIN
         JC1UvngquTTbQYaZNe00U3qPgFxpW3hvPUDuPWo14ZnNrUuGRfh0RtTx+nHEP5F8Ehwz
         cmCrTFy6AKYWTdpWHwxxlGQrBH6jXLvfNog9Itvgv9e4VJR0tF3D+Qr2sN4gbzL9V/MQ
         DjIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vrW6spNhSrHQfksBCubidylUZF4PsPIbB3rPZO64ujI=;
        b=MrOPpdZ5wANG5RnpxJLylN6Mm4toHi2jkJracIDxw1maW/t5STCrufNo1joPikN0ei
         bbkohS8pe6eW/glliM635/VuUZ+Kf1TkPINZPqmM+1Gkv0BOWuC7D+6PvYdr3WHbrIyM
         2geS80O9JfPcd9FyXTqOnhdU0GbckIl03D80sJ+LXHh8jjqidqSNYE3P+GuvOKCWYr1U
         IlddQHaQKx2bO8bM0CwNYOGUcYB1415hzeDR16UqAm5c7zSL422fBWoslOTJisuK9TlT
         zFVp8PEBipp/wlWGEv/TO/tXAxekMjlYfeEbfIBRGYddcNOmwEfTp4bBezD1B879K1t4
         m+nA==
X-Gm-Message-State: AOAM533kkS1afMP1RqTZRF+ekS6EK0axVodxt/GZRqbax3oJsXAspWv6
        q57MBJyw5EKbPU/YjHap4qIc0KtlgRy+TRJ0KXc=
X-Google-Smtp-Source: ABdhPJxrhdp8bUdHz5FwO47aZSX+yN3CdPcXDTAW/eIBd6hg2GtSC8JJuxS00T9WmDG2mjyZ7CDbKZl2xrtx3BZ15gU=
X-Received: by 2002:a92:de0c:: with SMTP id x12mr20195626ilm.275.1620620806016;
 Sun, 09 May 2021 21:26:46 -0700 (PDT)
MIME-Version: 1.0
References: <20210509213930.94120-1-alx.manpages@gmail.com>
 <20210509213930.94120-12-alx.manpages@gmail.com> <a95d7a31-2345-8e1e-78d7-a1a8f7161565@gmail.com>
In-Reply-To: <a95d7a31-2345-8e1e-78d7-a1a8f7161565@gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 10 May 2021 07:26:35 +0300
Message-ID: <CAOQ4uxgB+sZ08jB+mFXuPJfTSJUV+Re5XKQ=hN7A4xfYo0dj6A@mail.gmail.com>
Subject: Re: [PATCH] copy_file_range.2: Update cross-filesystem support for 5.12
To:     "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Cc:     Alejandro Colomar <alx.manpages@gmail.com>,
        linux-man <linux-man@vger.kernel.org>,
        Luis Henriques <lhenriques@suse.de>,
        Greg KH <gregkh@linuxfoundation.org>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Jeff Layton <jlayton@kernel.org>,
        Steve French <sfrench@samba.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Dave Chinner <dchinner@redhat.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Ian Lance Taylor <iant@google.com>,
        Luis Lozano <llozano@chromium.org>,
        Andreas Dilger <adilger@dilger.ca>,
        Olga Kornievskaia <aglo@umich.edu>,
        Christoph Hellwig <hch@infradead.org>,
        ceph-devel <ceph-devel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        samba-technical <samba-technical@lists.samba.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Walter Harms <wharms@bfs.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 10, 2021 at 3:01 AM Michael Kerrisk (man-pages)
<mtk.manpages@gmail.com> wrote:
>
> Hi Alex,
>
> On 5/10/21 9:39 AM, Alejandro Colomar wrote:
> > Linux 5.12 fixes a regression.

Nope.
That never happened:
https://lore.kernel.org/linux-fsdevel/8735v4tcye.fsf@suse.de/

> >
> > Cross-filesystem (introduced in 5.3) copies were buggy.
> >
> > Move the statements documenting cross-fs to BUGS.
> > Kernels 5.3..5.11 should be patched soon.
> >
> > State version information for some errors related to this.
>
> Thanks. Patch applied.

I guess that would need to be reverted...

Thanks,
Amir.
