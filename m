Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 05E10DA32D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2019 03:30:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390358AbfJQBae (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Oct 2019 21:30:34 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:36746 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727399AbfJQBae (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Oct 2019 21:30:34 -0400
Received: by mail-ed1-f66.google.com with SMTP id h2so340267edn.3;
        Wed, 16 Oct 2019 18:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=GAfZW1RYy/75Aar0SXMizy6rKAqi9JFRLF5URSEqIpI=;
        b=k7/ry6Ero0YzuURA/xA9xbMAA6yPYTUP6151cK7Zak8HoyeDYZ+4mRr0gyNVKSQKHq
         9N9MWZXRSCSHn8gF5rr71WJSJ/sUe1UZSG13nuICR7JiXPtjTKs1nPKML1cDUvBdhatI
         JguoeRloTBLp2gaV54RYhWkwK46IJbVT+D7/nyHMlWr4RBKebu1Y5n1KLcpboopRIQaW
         T7tLEXEZvVuyE6QeWjt0MzcXonwml3ILn7DnbQPTZmIFymZUpz94KzGdAKeBH9yDzOvF
         0toBYMlglp063jDZbF8DYWF3tEz5lQmpqghkkVOgd1E+htECxfwND2P/VTAnFTzaFrLH
         23aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=GAfZW1RYy/75Aar0SXMizy6rKAqi9JFRLF5URSEqIpI=;
        b=dTuM5a3ufUAKudQPNCgROEOjKWU2CCu518HCcS3pvV1Ls0xgEzr4er9GbkJbxRBxej
         kbSyJRCFRy9WTUgCaKhq/2i4/dzhc3mgWM+88f1HVt9k1AL13FQBRgFvKw9TyiGpkiuB
         wtQ3gS0EcHNCsFnb+aMfZMHSHsUIsq4x7DKRcdUDwxEq5oc28vDjN2g8Fi7Xj7W2z5E9
         BWBAq5Zvsm//vg/AyrO+U+mFT8F4nT0Qm5k+k+ddt76TEHzkuKU57ValUqFGQCsjvyXN
         myrKcaWlJLHgoybPI5Scq/KW34gqcl1ENWvOwM6NbCYVPzMJ74Vr+7WQ5BuIscofnRRS
         aP3w==
X-Gm-Message-State: APjAAAVNRGt6BeA6mT/XbqtEZxLcASdDfGToA02KToJfNJ5VxaLEkfY1
        14jefjojRo2v+0lxf0I1nWaWMtkKouc6aJYhIpk=
X-Google-Smtp-Source: APXvYqw8j8qmNjAy4xzi1iXU+8YIXbZStik7ik4UWxIpJADNMM0tIebRvR38BXhsq4HZnpufVFdgIImbM8TZDwMmYZI=
X-Received: by 2002:a17:906:76c9:: with SMTP id q9mr1180960ejn.53.1571275831840;
 Wed, 16 Oct 2019 18:30:31 -0700 (PDT)
MIME-Version: 1.0
References: <20191016120621.304-1-hslester96@gmail.com> <20191017000703.GA4271@eaf>
In-Reply-To: <20191017000703.GA4271@eaf>
From:   Chuhong Yuan <hslester96@gmail.com>
Date:   Thu, 17 Oct 2019 09:30:20 +0800
Message-ID: <CANhBUQ3vPBAstTMJ25Zt6sR4CcRKWkeR7VKhFXc9aiqQKmW=Ng@mail.gmail.com>
Subject: Re: [PATCH 2/2] hfsplus: add a check for hfs_bnode_find
To:     =?UTF-8?Q?Ernesto_A=2E_Fern=C3=A1ndez?= 
        <ernesto.mnd.fernandez@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 17, 2019 at 8:07 AM Ernesto A. Fern=C3=A1ndez
<ernesto.mnd.fernandez@gmail.com> wrote:
>
> Hi,
>
> On Wed, Oct 16, 2019 at 08:06:20PM +0800, Chuhong Yuan wrote:
> > hfs_brec_update_parent misses a check for hfs_bnode_find and may miss
> > the failure.
> > Add a check for it like what is done in again.
> >
> > Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
> > ---
> >  fs/hfsplus/brec.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/fs/hfsplus/brec.c b/fs/hfsplus/brec.c
> > index 1918544a7871..22bada8288c4 100644
> > --- a/fs/hfsplus/brec.c
> > +++ b/fs/hfsplus/brec.c
> > @@ -434,6 +434,8 @@ static int hfs_brec_update_parent(struct hfs_find_d=
ata *fd)
> >                       new_node->parent =3D tree->root;
> >               }
> >               fd->bnode =3D hfs_bnode_find(tree, new_node->parent);
> > +             if (IS_ERR(fd->bnode))
> > +                     return PTR_ERR(fd->bnode);
>
> You shouldn't just return here, you still hold a reference to new_node.
> The call to hfs_bnode_find() after the again label seems to be making a
> similar mistake.
>
> I don't think either one can actually fail though, because the parent
> nodes have all been read and hashed before, haven't they?
>

I find that after hfs_bnode_findhash in hfs_bnode_find, there is a test for
HFS_BNODE_ERROR and may return an error. I'm not sure whether it
can happen here.

> >               /* create index key and entry */
> >               hfs_bnode_read_key(new_node, fd->search_key, 14);
> >               cnid =3D cpu_to_be32(new_node->this);
> > --
> > 2.20.1
> >
