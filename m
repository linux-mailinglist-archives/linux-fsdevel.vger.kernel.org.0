Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD395538464
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 May 2022 17:15:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233727AbiE3PDm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 May 2022 11:03:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243025AbiE3PBW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 May 2022 11:01:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFAE91742B4
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 May 2022 07:00:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 01D30B80DA8
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 May 2022 14:00:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5778C385B8
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 May 2022 14:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653919227;
        bh=nade3m6D8kJPOZMdjlWL5mfSEPUN53NjKlDBZBuiMWs=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=GaLHCQfSAk5Tp91Btvyovou86PSWaDATCKBZIZMhi/wE9YA3QF9ucPBv0szAxZlXi
         NrJVacaCkw9T5QFPI3tBdSqgz18e/EqbdZnQ+oVG0N3WLPjpBgAzAaAU+pV7VIWvKW
         lLn7IxtckyKTk79c0JW2dUgEnTqA08tXqd/bQqrU8v1yVIlztKhKf7X/2MQDVJgA2b
         bzYMjWSZH0TAi/+aV83xbKrYvBtTrQQLDtCBCpN6/gx90lD39B4ix3LcJqPZtVxG4u
         D2608ttWZI3hImCM8xjh8HqTdFwMLZbxXjlU972MSyD8aTgIWeFbh/3zkhJJL2o1cg
         ae0JVmNPLrzpg==
Received: by mail-wr1-f54.google.com with SMTP id t6so14787735wra.4
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 May 2022 07:00:27 -0700 (PDT)
X-Gm-Message-State: AOAM533BkDoHg+GvqqMjaT7O5WRAixC67093eLT9D4xwhy64SFSCvdZ1
        cJQVmM0jZMrv0pSN30aeL0nsiVJKrtgNc8kuv1U=
X-Google-Smtp-Source: ABdhPJyUkIl9wWyoozAbidd9ZiP3y28dDMzugIJjF5VxLhga2Mjt8z7KsVxTdFJf9cGT+n9K++s+4D7bm/XDYPjsGd4=
X-Received: by 2002:a5d:4e48:0:b0:210:18bb:6aa1 with SMTP id
 r8-20020a5d4e48000000b0021018bb6aa1mr13518514wrt.62.1653919225898; Mon, 30
 May 2022 07:00:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:ee4e:0:0:0:0:0 with HTTP; Mon, 30 May 2022 07:00:20
 -0700 (PDT)
In-Reply-To: <alpine.LRH.2.02.2205300746310.21817@file01.intranet.prod.int.rdu2.redhat.com>
References: <20220524075112.5438df32.ref@yahoo.es> <20220524075112.5438df32@yahoo.es>
 <alpine.LRH.2.02.2205240501130.17784@file01.intranet.prod.int.rdu2.redhat.com>
 <20220524113314.71fe17f0@yahoo.es> <20220525130538.38fd3d35@yahoo.es>
 <20220527072629.332b078d@yahoo.es> <20220527080211.15d631be@yahoo.es>
 <alpine.LRH.2.02.2205271338250.20527@file01.intranet.prod.int.rdu2.redhat.com>
 <20220528061836.22230f86@yahoo.es> <20220530131524.7fb5640d@yahoo.es> <alpine.LRH.2.02.2205300746310.21817@file01.intranet.prod.int.rdu2.redhat.com>
From:   Namjae Jeon <linkinjeon@kernel.org>
Date:   Mon, 30 May 2022 23:00:20 +0900
X-Gmail-Original-Message-ID: <CAKYAXd-BZK9iG-Od0-60eFOjQ76uSfOJit6k13bR96A_o-wCwA@mail.gmail.com>
Message-ID: <CAKYAXd-BZK9iG-Od0-60eFOjQ76uSfOJit6k13bR96A_o-wCwA@mail.gmail.com>
Subject: Re: [PATCH] ntfs3: provide block_invalidate_folio to fix memory leak
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     manualinux@yahoo.es,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        ntfs3@lists.linux.dev, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

2022-05-30 21:00 GMT+09:00, Mikulas Patocka <mpatocka@redhat.com>:
>
>
> On Mon, 30 May 2022, manualinux@yahoo.es wrote:
>
>>
>> Hello again,
>>
>> When you have time, try moving a large file from a SpadFS partition to
>> an NTFS partition mounted with the NTFS3 driver and with a 5.18 kernel,
>> and then, move the same file back again, to the SpadFS partition. At
>> that very moment is when the size of the file remains permanently in
>> the system memory (in my particular case). This does not happen if we
>> do it to another Linux file system, nor does it happen if we do it from
>> a NTFS partition to another XFS or Ext4 partition.
>>
>> So no ccache or anything, I swap files quite often between the SpadFS
>> partition and an external hard disk with an NTFS partition. Anyway,
>> this problem is really unusual, and it must have some technical
>> explanation, because with the ntfs-3g driver this doesn't happen.
>>
>> If this information is of any use to you I will be satisfied.
>>
>> Regards,
>>
>> Jos=C3=A9 Luis Lara Carrascal - Webmaster de Manualinux - GNU/Linux en
>> Espa=C3=B1ol (https://manualinux.es)
>
> Hi
>
> SpadFS is innocent here :)
>
> The NTFS3 driver in the kernel 5.18 contains the same bug as SpadFS did -
> missing the invalidate_folio method. This patch adds this method and fixe=
s
> the bug.
>
> Mikulas
>
>
>
> Author: Mikulas Patocka <mpatocka@redhat.com>
>
> The ntfs3 filesystem lacks the 'invalidate_folio' method and it causes
> memory leak. If you write to the filesystem and then unmount it, the
> cached written data are not freed and they are permanently leaked.
>
> Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
> Reported-by: Jos=C3=A9 Luis Lara Carrascal <manualinux@yahoo.es>
> Fixes: 7ba13abbd31e ("fs: Turn block_invalidatepage into
> block_invalidate_folio")
> Cc: stable@vger.kernel.org	# v5.18

Reviewed-by: Namjae Jeon <linkinjeon@kernel.org>
>
> ---
>  fs/ntfs3/inode.c |    1 +
>  1 file changed, 1 insertion(+)
>
> Index: linux-2.6/fs/ntfs3/inode.c

> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.orig/fs/ntfs3/inode.c	2022-05-16 16:57:24.000000000 +0200
> +++ linux-2.6/fs/ntfs3/inode.c	2022-05-30 13:36:45.000000000 +0200
linux-2.6 ? Probably you will submit the patch again ?

> @@ -1951,6 +1951,7 @@ const struct address_space_operations nt
>  	.direct_IO	=3D ntfs_direct_IO,
>  	.bmap		=3D ntfs_bmap,
>  	.dirty_folio	=3D block_dirty_folio,
> +	.invalidate_folio =3D block_invalidate_folio,
>  };
>
>  const struct address_space_operations ntfs_aops_cmpr =3D {
