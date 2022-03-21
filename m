Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 181BF4E2573
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Mar 2022 12:51:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346829AbiCULwe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Mar 2022 07:52:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344272AbiCULwd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Mar 2022 07:52:33 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B5845522A;
        Mon, 21 Mar 2022 04:51:05 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id i4so11618209qti.7;
        Mon, 21 Mar 2022 04:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1bHq03jNRnCRtDNxwCXciuil1CSKlUgULr0uZ0a2LW8=;
        b=iygiQUIqr3rmsvG7usVOfDxILLl7YQM4495zPlxxtygKNQZtBkT8HREnO9oTXDXaBA
         iNWGOMtsZnUrqmzvXimmq3ckXyyqoUfzfQBlnCUVVIaweLE9yorNOIks+VYYH5SNqK9X
         0R0QXJfESbVqxW6R/zsn0yRxpC/40snDVUUGQIt0heeTDqJRporPNBw/AOJSAouboovh
         lVfPKdSZmFiF/Q5sVeA4NuA5recitstmMyq1VFzW/OH0Y5Rl8Vd1pa5oyS7EkuS6f04R
         1szbJU57ACnt6pu7HkYxqRMDPiAuZjRsHH47DEtnaOdXt9UQ3n7Q9pq/piR4XJntd5RX
         1+iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1bHq03jNRnCRtDNxwCXciuil1CSKlUgULr0uZ0a2LW8=;
        b=MMdeXF0jIQfoEVvTkd/Rn95MFCHQvQMJemYt7PaPMdK2IQ2pOl1Y8mEGZX8F3XFjhY
         dcE0WRkhkmxH6EwmCf8ABaos2NyQ5MrkA3n3du2rZJ8W2geBSh8zC1YJLdt7MyI3PlTo
         MMmgZX7D8/ilFqf1PoV+TO0+5ezkIHLaYNuXe+Cz22N/rCAmyq/ZgB7sTByfti84/2Cz
         CcrkaV9OgGi0DA7NCOLDoITM0K64h4YPK0G8KCfWon2Hs4TPA8pCx9h/6C+oEJ8Tdrr3
         mDUzjJP8sehkWics1zX8ENJN/apqRWhYLmhrrn4uY+I64EewzlEOx000+XsisdKN2dJ+
         mtzQ==
X-Gm-Message-State: AOAM530A0FCEDF1WFQwn3FGOnu8Hm89Amh7Vp/cftIuNNVg1BihPqGyi
        fdOkR0/DhtmCkBPrHNWlSgEoJ0EPqWEjCym5DTm10io0
X-Google-Smtp-Source: ABdhPJyU5+hHh6+zzWHBO+Dqfa3hRra6qckaDVUnu3EYahpKFTecOt25UR/7q5Vn27iw/SximUAoVqzwK6rydNTKtfM=
X-Received: by 2002:a05:622a:1996:b0:2e0:ffd3:a2d5 with SMTP id
 u22-20020a05622a199600b002e0ffd3a2d5mr15757989qtc.390.1647863464594; Mon, 21
 Mar 2022 04:51:04 -0700 (PDT)
MIME-Version: 1.0
References: <CAPmgiUJVaACDyWkEhpC5Tfk233t-Tw6_f-Y99KLUDqv6dEq0tw@mail.gmail.com>
 <YjMFTSKZp9eX/c4k@localhost.localdomain> <CAPmgiUJsd-gdq=JG1rF8BHfpADeS45rcVWwnC2qKE=7W1EryiQ@mail.gmail.com>
 <YjdVHgildbWO7diJ@localhost.localdomain> <CAPmgiUK90T212icXkSJ2vSiCjXbUqO-fptNLL7NF6SMDAyTtRg@mail.gmail.com>
 <YjhWCuybOW9RT47L@localhost.localdomain>
In-Reply-To: <YjhWCuybOW9RT47L@localhost.localdomain>
From:   cael <juanfengpy@gmail.com>
Date:   Mon, 21 Mar 2022 19:50:53 +0800
Message-ID: <CAPmgiUJnS4Z7+=-9WOaQ28jBASWwa+ocYzKRScU3D0qdKUW1xg@mail.gmail.com>
Subject: Re: [PATCH] proc: fix dentry/inode overinstantiating under /proc/${pid}/net
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     akpm@linux-foundation.org, viro@zeniv.linux.org.uk,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
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

I see, I will test on my system.

Alexey Dobriyan <adobriyan@gmail.com> =E4=BA=8E2022=E5=B9=B43=E6=9C=8821=E6=
=97=A5=E5=91=A8=E4=B8=80 18:40=E5=86=99=E9=81=93=EF=BC=9A
>
> On Mon, Mar 21, 2022 at 05:15:02PM +0800, hui li wrote:
> > Alexey Dobriyan <adobriyan@gmail.com> =E4=BA=8E2022=E5=B9=B43=E6=9C=882=
1=E6=97=A5=E5=91=A8=E4=B8=80 00:24=E5=86=99=E9=81=93=EF=BC=9A
> > >
> > > When a process exits, /proc/${pid}, and /proc/${pid}/net dentries are=
 flushed.
> > > However some leaf dentries like /proc/${pid}/net/arp_cache aren't.
> > > That's because respective PDEs have proc_misc_d_revalidate() hook whi=
ch
> > > returns 1 and leaves dentries/inodes in the LRU.
> > >
> > > Force revalidation/lookup on everything under /proc/${pid}/net by inh=
eriting
> > > proc_net_dentry_ops.
> > >
> > > Fixes: c6c75deda813 ("proc: fix lookup in /proc/net subdirectories af=
ter setns(2)")
> > > Reported-by: hui li <juanfengpy@gmail.com>
> > > Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
> > > ---
> > >
> > >  fs/proc/generic.c  |    4 ++++
> > >  fs/proc/proc_net.c |    3 +++
> > >  2 files changed, 7 insertions(+)
> > >
> > > --- a/fs/proc/generic.c
> > > +++ b/fs/proc/generic.c
> > > @@ -448,6 +448,10 @@ static struct proc_dir_entry *__proc_create(stru=
ct proc_dir_entry **parent,
> > >         proc_set_user(ent, (*parent)->uid, (*parent)->gid);
> > >
> > >         ent->proc_dops =3D &proc_misc_dentry_ops;
> > > +       /* Revalidate everything under /proc/${pid}/net */
> > > +       if ((*parent)->proc_dops =3D=3D &proc_net_dentry_ops) {
> > > +               pde_force_lookup(ent);
> > > +       }
> > >
> > >  out:
> > >         return ent;
> > > --- a/fs/proc/proc_net.c
> > > +++ b/fs/proc/proc_net.c
> > > @@ -376,6 +376,9 @@ static __net_init int proc_net_ns_init(struct net=
 *net)
> > >
> > >         proc_set_user(netd, uid, gid);
> > >
> > > +       /* Seed dentry revalidation for /proc/${pid}/net */
> > > +       pde_force_lookup(netd);
> > > +
> > >         err =3D -EEXIST;
> > >         net_statd =3D proc_net_mkdir(net, "stat", netd);
> > >         if (!net_statd)
>
> > proc_misc_dentry_ops is a general ops for dentry under /proc, except
> > for "/proc/${pid}/net"=EF=BC=8Cother dentries may also use there own op=
s too,
> > so I think change proc_misc_d_delete may be better?
> > see patch under: https://lkml.org/lkml/2022/3/17/319
>
> I don't think so.
>
> proc_misc_d_delete covers "everything else" part under /proc/ and
> /proc/net which are 2 separate trees. Now /proc/net/ requires
> revalidation because of
>
>         commit c6c75deda81344c3a95d1d1f606d5cee109e5d54
>         proc: fix lookup in /proc/net subdirectories after setns(2)
>
> so the bug is that the above commit was applied only partially.
> In particular, /proc/*/net/stat/arp_cache was created with
> proc_create_seq_data(), avoiding proc_net_* APIs.
>
> And there is probably the same "lookup after setns find wrong file"
> if you search hard enough in /proc/*/net/
>
> This is the logic. Please test on your systems.
