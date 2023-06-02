Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5C9571FE61
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Jun 2023 11:55:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234774AbjFBJzu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Jun 2023 05:55:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233860AbjFBJzt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Jun 2023 05:55:49 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 225A3E2
        for <linux-fsdevel@vger.kernel.org>; Fri,  2 Jun 2023 02:55:47 -0700 (PDT)
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com [209.85.128.198])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 9B3C23F438
        for <linux-fsdevel@vger.kernel.org>; Fri,  2 Jun 2023 09:55:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1685699745;
        bh=QspZhkhWQdQD4gUpwkhMOqtT5VUHoWWx+XNQWeKyt9w=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=KOSr1/OJnvLrqBe2Q7dz7yusG49kznQGHJMtgu06eiuQBp5u1WVo4X+OoECvl0ocv
         v7DFYvMk3N1Ig3PNny2CnZNi9j0lTTf79I/7ngXE0mQI2L7qui2Gx8JGmc5c3d0Hps
         eG+8SYjZskjnDrAYQbRxukRC3TS7R8hD2SzJQ1X5lXz8eyFdM3WRZqlQ5CS10oWVBp
         /nLJMw1zBjvLGIJcPFSus3th36GwrDSbkQfyhk72XyJ+kaCnG0zmaINrydUBxCqYBE
         7CSmEpVy2YnlyuVlO5UggvqQ30e5O/4filBEUwHCkSjagwUpvCcRWh5Rj61sJlPJSi
         gpj3yDL95hFUg==
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-56536dd5f79so28725847b3.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 02 Jun 2023 02:55:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685699744; x=1688291744;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QspZhkhWQdQD4gUpwkhMOqtT5VUHoWWx+XNQWeKyt9w=;
        b=TL/roIJcNprNegJpIyijlINCZLqXEzMDaaHVVOiYUXGZ4RGDgTqC+CC+7Nb90+IoJA
         6yps56d60lRt2zoAGGnOOXoUqCuTq3qliqeS6h0PgXZPaOGbMCB5uegoxcJLMiUR8JjC
         Svisr+Q9eaz7c6GRHdmtlfOkiPZreZVvidFB058Jz4ZbD/SkQHeQrq4ecs17YktMEhlM
         gn+VvI15LVX8ylqmxiMNKnm/6d8ntmI+0WAU0Vx1AerhmRThfqFhmW4C7kJNWUCz8edW
         BW6ODrkcvBcUChvaMw5Nsx7PaXaaFj0mdFNBVmyQOEg1/gQs/UU85KqwD+spG84VUU4f
         eJcQ==
X-Gm-Message-State: AC+VfDyYeRryYCMZ3KtGS25ct/WEIQVARcXRAL1+AwJFhq09yhZFRMR8
        V1z9GA0e+c01ynKyhkduKhT5pj9FNge6NI6UCESPUe116/ymkxTPvw5fPwQd5Ax0zK+WKBgKTrg
        CBmtbMkARLNWCmSsyRqVZi9lDQcP0WgZVAxsFS028TNwVf3kAyxrBOXTDXt4=
X-Received: by 2002:a25:e7c6:0:b0:bad:1131:97bc with SMTP id e189-20020a25e7c6000000b00bad113197bcmr2366572ybh.41.1685699744723;
        Fri, 02 Jun 2023 02:55:44 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7xqfL1hiKe4JZ/3nKmZFmT86k0j0WRUaU81ssaYFKnGfEyCwmCVtufdRzhBHmNUG0gg9Jp58iN+OC4DNkHnaQ=
X-Received: by 2002:a25:e7c6:0:b0:bad:1131:97bc with SMTP id
 e189-20020a25e7c6000000b00bad113197bcmr2366559ybh.41.1685699744492; Fri, 02
 Jun 2023 02:55:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230524153316.476973-1-aleksandr.mikhalitsyn@canonical.com>
 <20230524153316.476973-2-aleksandr.mikhalitsyn@canonical.com> <64672c51-498a-2a0c-4d4e-caca145fa744@redhat.com>
In-Reply-To: <64672c51-498a-2a0c-4d4e-caca145fa744@redhat.com>
From:   Aleksandr Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Date:   Fri, 2 Jun 2023 11:55:33 +0200
Message-ID: <CAEivzxepeiBa+uwRKuddCZaxvzqLEj9ZDp4byr0jZkUA94CxSw@mail.gmail.com>
Subject: Re: [PATCH v2 01/13] fs: export mnt_idmap_get/mnt_idmap_put
To:     Xiubo Li <xiubli@redhat.com>
Cc:     brauner@kernel.org, stgraber@ubuntu.com,
        linux-fsdevel@vger.kernel.org, Ilya Dryomov <idryomov@gmail.com>,
        Jeff Layton <jlayton@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Seth Forshee <sforshee@kernel.org>, ceph-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 2, 2023 at 3:17=E2=80=AFAM Xiubo Li <xiubli@redhat.com> wrote:
>
>
> On 5/24/23 23:33, Alexander Mikhalitsyn wrote:
> > These helpers are required to support idmapped mounts in the Cephfs.
> >
> > Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.c=
om>
> > ---
> >   fs/mnt_idmapping.c            | 2 ++
> >   include/linux/mnt_idmapping.h | 3 +++
> >   2 files changed, 5 insertions(+)
> >
> > diff --git a/fs/mnt_idmapping.c b/fs/mnt_idmapping.c
> > index 4905665c47d0..5a579e809bcf 100644
> > --- a/fs/mnt_idmapping.c
> > +++ b/fs/mnt_idmapping.c
> > @@ -256,6 +256,7 @@ struct mnt_idmap *mnt_idmap_get(struct mnt_idmap *i=
dmap)
> >
> >       return idmap;
> >   }
> > +EXPORT_SYMBOL(mnt_idmap_get);
> >
> >   /**
> >    * mnt_idmap_put - put a reference to an idmapping
> > @@ -271,3 +272,4 @@ void mnt_idmap_put(struct mnt_idmap *idmap)
> >               kfree(idmap);
> >       }
> >   }
> > +EXPORT_SYMBOL(mnt_idmap_put);
> > diff --git a/include/linux/mnt_idmapping.h b/include/linux/mnt_idmappin=
g.h
> > index 057c89867aa2..b8da2db4ecd2 100644
> > --- a/include/linux/mnt_idmapping.h
> > +++ b/include/linux/mnt_idmapping.h
> > @@ -115,6 +115,9 @@ static inline bool vfsgid_eq_kgid(vfsgid_t vfsgid, =
kgid_t kgid)
> >
> >   int vfsgid_in_group_p(vfsgid_t vfsgid);
> >
> > +struct mnt_idmap *mnt_idmap_get(struct mnt_idmap *idmap);
> > +void mnt_idmap_put(struct mnt_idmap *idmap);
> > +
> >   vfsuid_t make_vfsuid(struct mnt_idmap *idmap,
> >                    struct user_namespace *fs_userns, kuid_t kuid);
> >
>
> Hi Alexander,

Hi, Xiubo!

>
> This needs the "fs/mnt_idmapping.c" maintainer's ack.

Sure, I hope that Christian will take a look.

Thanks,
Alex

>
> Thanks
>
> - Xiubo
>
