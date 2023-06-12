Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FAF672BA9E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jun 2023 10:30:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231652AbjFLI3p (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jun 2023 04:29:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233034AbjFLI3X (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jun 2023 04:29:23 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2150B3592;
        Mon, 12 Jun 2023 01:28:36 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id af79cd13be357-75d558c18d0so273958085a.1;
        Mon, 12 Jun 2023 01:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686558514; x=1689150514;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Exe23xwKh/B0XPnEOtD5aO8wr9GD92cH/+7UkLQDjJY=;
        b=WnWitCu6SIUgx1dbDAVUX6AmGfwqCoj4hh53c7CUV8uRAYywclMms3pe2oDfzyoyat
         ij9jmVSw6QbGgcHULp8dnA/eTjSsBy0p3fhI9U3dV0WrE7SvyW0UU6biHKjDdn/56T1B
         2wRgJiev0zFrxwgHpYpvxm8CUCJxTmNfLzLPpQ+y91BgdR/aOF6IigIQtpZIY4aIPEBo
         2Nj+i1RXBahfT8iig4RhDYQlB0aWp1y5KkwNPHTKa9WzbnR8ArCiU4kHxxz0Oifx6sLX
         oZVcgDTAgLyLy3sXfzTPjbt0akSQt9CGzfGjSLaig4eDZUXMpfPdXGnrVzfqzhPyZQwI
         cBvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686558514; x=1689150514;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Exe23xwKh/B0XPnEOtD5aO8wr9GD92cH/+7UkLQDjJY=;
        b=IC7TDg45WeRFUn6Fss1kQ6Y6keEwc6bRs67tRsVS94vL9TD0dHBn1MXFkcJ/fZK2vv
         6p+fi2icpIIH6KeJeYuwXOD8sYen4rJXFAfRwI/RkkZUGsi2h28ECieGSWCQvcRSMRO/
         Cp6T/iNRlRM2dJ/aKzsahvuIrjoZ6/BTLHCpS2IXRCJugtdm2UT11d87LEkdOm8z2SG7
         8f+22wgqND67kvkePjjyrswfO8gtQ7BeJvxA4CTLjJ6f7WWFxwpDqIgcydVQ7P4SBzUV
         dZtGljQ76PC9jSFNXnHwlqUsuBFpotaPxe9hWIl6pPZ4Rllip7SMT+zJuXcUvQXSMUCc
         LRbQ==
X-Gm-Message-State: AC+VfDx1/UNp+u2Mh4xUf25gaZ2dPSXXmkN/Sm7ODAeeHirU6lc8dviK
        jPJmK0gKiUiE+J/HEDYYigDHnnqTFm4riyUYf0ZK2VJUGVM=
X-Google-Smtp-Source: ACHHUZ5n13MtNuuWInFj2+V2Pmkt06FulKMWhqqjGZNvTWnSyqggxTd7VOrZ95z3uzCjvshOnSAyIk+Fx2IVhPypLgE=
X-Received: by 2002:a37:6403:0:b0:75b:25a2:c284 with SMTP id
 y3-20020a376403000000b0075b25a2c284mr6907450qkb.30.1686558514179; Mon, 12 Jun
 2023 01:28:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230611194706.1583818-1-amir73il@gmail.com> <20230611194706.1583818-2-amir73il@gmail.com>
 <ZIai+UWrU9o2UVcJ@infradead.org> <20230612-erwarben-pflaumen-1916e266edf7@brauner>
In-Reply-To: <20230612-erwarben-pflaumen-1916e266edf7@brauner>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 12 Jun 2023 11:28:23 +0300
Message-ID: <CAOQ4uxi0o+OgVT_GSHQwkDtHBf+QoeAycb7pmhOq+2e9-cx+3g@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] fs: use fake_file container for internal files
 with fake f_path
To:     Christian Brauner <brauner@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org
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

On Mon, Jun 12, 2023 at 11:07=E2=80=AFAM Christian Brauner <brauner@kernel.=
org> wrote:
>
> On Sun, Jun 11, 2023 at 09:45:45PM -0700, Christoph Hellwig wrote:
> > On Sun, Jun 11, 2023 at 10:47:05PM +0300, Amir Goldstein wrote:
> > > Overlayfs and cachefiles use open_with_fake_path() to allocate intern=
al
> > > files, where overlayfs also puts a "fake" path in f_path - a path whi=
ch
> > > is not on the same fs as f_inode.
> >
> > But cachefs doesn't, so this needs a better explanation / documentation=
.
> >
> > > Allocate a container struct file_fake for those internal files, that
> > > is used to hold the fake path along with an optional real path.
> >
> > The idea looks sensible, but fake a is a really weird term here.
> > I know open_with_fake_path also uses it, but we really need to
> > come up with a better name, and also good documentation of the
> > concept here.
>
> It's basically a stack so I'd either use struct file_stack or
> struct file_proxy; with a preference for the latter.

Let the bikeshedding begin :)

file_proxy too generic to my taste

How about:

/* File is embedded in backing_file object */
#define FMODE_BACKING           ((__force fmode_t)0x2000000)

This backing_file container may be usable for cachefiles or FUSE
passthrough in the future to store the path of the (netfs/fuse) file that
is backed by the (local) backing file.

We had a short attempt to do the same for ovl - store the ovl path
in the container and not the real_path, to get rid of file_dentry() calls,
but it got complicated so deferreing that for later.

Thanks,
Amir.
