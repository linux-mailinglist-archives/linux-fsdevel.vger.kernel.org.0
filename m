Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 60055DB8AD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2019 22:52:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437494AbfJQUwa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Oct 2019 16:52:30 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:44395 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728420AbfJQUwa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Oct 2019 16:52:30 -0400
Received: by mail-qk1-f196.google.com with SMTP id u22so3202435qkk.11;
        Thu, 17 Oct 2019 13:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=QMU67ashdr6NIXSp5sxb1ow30I7YwBEELAlQYgNywC8=;
        b=nnuCi8MvIN5FvTlFJcLWAsFvANcNYqrJPttO3XVqBHrrL69Gu2F8yE7+WQRHAk8rod
         PvQs3YROR8NvmAoVxhO+8idIM5Clyk/tHRc1nVqLP29U+yGPkY9zcKqZhzpdvQYaKUNs
         xj5cDts6e1s5SfkrPZV+xtoV+inF3KSjhta23PmmVRJr8OfHHwbWH+O75h//rHKABOJC
         +xC7K3z/W7FrK5arxzfX1AzC52uE1eG/9FEArV1SG0uNel5/w57wZV3f1czHKX4pONBX
         rHGo2V+YRHQJRhaHqogzvdQcSHB/awWpP+2MgngHMA3q46emzr1yV8LZm2qaVkaU1kgS
         /mpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=QMU67ashdr6NIXSp5sxb1ow30I7YwBEELAlQYgNywC8=;
        b=aKVH1dpfU1n1IkXXQObEIgW4Ouzu5fmNQ8/RsCVbPDuaZD6RuQWUHpVKMxr5Tn5vr3
         cQZWFlFlwr+4eIarwHBNMhUb/G0MvH/7X6u7Qe3kdV8+WitcAq4koKccYCOCpqdFw4ib
         WSJMhhH3cuHkkjP0hMlnfUxTYppvsT3EgfgAXx3mWfJgQA3NzEtlRfDh9Mv5i+4grOkh
         MA/t0zHX6PEW5Hnwai1ExGWZ8o0LrqQTAoXzYMF6o4sf5yTsopTE7JnK9lu5kil1/MnX
         w9BCfIWBTuncVYn0mCZSCQgRlLLC6O5Bao0WjlzaFr/0725AnyPqCtNyxXpGE7Mn9uK9
         4A4g==
X-Gm-Message-State: APjAAAX3i2MOTVs4R7fQLTvfspNKw54BxKiLaWkdDxUCzyA/tktpAz27
        7UtOBPFttusKVsmABG6AsIkXlQ4f
X-Google-Smtp-Source: APXvYqzTVyquYc7fl8qSW3Vg5hnSpVIzpoyFXNkHrMBAWrxLDu6oiZgOHBKtEYq5r2MYx95Mfslhzg==
X-Received: by 2002:a37:7b44:: with SMTP id w65mr5312578qkc.403.1571345547902;
        Thu, 17 Oct 2019 13:52:27 -0700 (PDT)
Received: from eaf ([181.47.179.0])
        by smtp.gmail.com with ESMTPSA id e15sm24666qkm.130.2019.10.17.13.52.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2019 13:52:27 -0700 (PDT)
Date:   Thu, 17 Oct 2019 17:52:22 -0300
From:   Ernesto =?utf-8?Q?A=2E_Fern=C3=A1ndez?= 
        <ernesto.mnd.fernandez@gmail.com>
To:     Chuhong Yuan <hslester96@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] hfsplus: add a check for hfs_bnode_find
Message-ID: <20191017205222.GA2662@eaf>
References: <20191016120621.304-1-hslester96@gmail.com>
 <20191017000703.GA4271@eaf>
 <CANhBUQ3vPBAstTMJ25Zt6sR4CcRKWkeR7VKhFXc9aiqQKmW=Ng@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANhBUQ3vPBAstTMJ25Zt6sR4CcRKWkeR7VKhFXc9aiqQKmW=Ng@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 17, 2019 at 09:30:20AM +0800, Chuhong Yuan wrote:
> On Thu, Oct 17, 2019 at 8:07 AM Ernesto A. Fernández
> <ernesto.mnd.fernandez@gmail.com> wrote:
> >
> > Hi,
> >
> > On Wed, Oct 16, 2019 at 08:06:20PM +0800, Chuhong Yuan wrote:
> > > hfs_brec_update_parent misses a check for hfs_bnode_find and may miss
> > > the failure.
> > > Add a check for it like what is done in again.
> > >
> > > Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
> > > ---
> > >  fs/hfsplus/brec.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >
> > > diff --git a/fs/hfsplus/brec.c b/fs/hfsplus/brec.c
> > > index 1918544a7871..22bada8288c4 100644
> > > --- a/fs/hfsplus/brec.c
> > > +++ b/fs/hfsplus/brec.c
> > > @@ -434,6 +434,8 @@ static int hfs_brec_update_parent(struct hfs_find_data *fd)
> > >                       new_node->parent = tree->root;
> > >               }
> > >               fd->bnode = hfs_bnode_find(tree, new_node->parent);
> > > +             if (IS_ERR(fd->bnode))
> > > +                     return PTR_ERR(fd->bnode);
> >
> > You shouldn't just return here, you still hold a reference to new_node.
> > The call to hfs_bnode_find() after the again label seems to be making a
> > similar mistake.
> >
> > I don't think either one can actually fail though, because the parent
> > nodes have all been read and hashed before, haven't they?
> >
> 
> I find that after hfs_bnode_findhash in hfs_bnode_find, there is a test for
> HFS_BNODE_ERROR and may return an error. I'm not sure whether it
> can happen here.

That would require a race between hfs_bnode_find() and hfs_bnode_create(),
but the node has already been created.

> 
> > >               /* create index key and entry */
> > >               hfs_bnode_read_key(new_node, fd->search_key, 14);
> > >               cnid = cpu_to_be32(new_node->this);
> > > --
> > > 2.20.1
> > >
