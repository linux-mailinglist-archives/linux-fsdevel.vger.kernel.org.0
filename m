Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9225072E348
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jun 2023 14:46:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242403AbjFMMqT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Jun 2023 08:46:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242086AbjFMMqR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Jun 2023 08:46:17 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DE6110EC
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Jun 2023 05:46:16 -0700 (PDT)
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com [209.85.219.197])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 2D6013F272
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Jun 2023 12:46:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1686660375;
        bh=DJyvntNK5zxh7HK+mp4W1WMoJPxy7nqBJlYeYzOf6Og=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=Pkja2DqtESh9d+TMgoRK0JBCtotZf60iugjn+jyYL33czHh1e9ZL3PMAJ12+ZZQMU
         qdZ4oF4dZWZqL6P9kLkbI58b3n7nwxD/nMb/l2wiAADXJWL/3Et67HzgUUShywK/Ep
         v0XTa51au8kIMjZUbcmC0CRA6WeP/rZJx4BEfHLunDwY/7I4pOizD3VxoqE2zyZgeA
         Zi6W4+jvkk+Yg5i3d9QrTrfRr1meryfb5ZzEMTmE9HA2XQHZVmq6j4gwqgHgOIRQ4H
         7FkLfml0YtzJ2t4YGGKBNkkT9KPDrUxKRXGn07HAlfFTk0ie8lGFYFyMETYdD0QF6i
         awYY4VeZPuj3w==
Received: by mail-yb1-f197.google.com with SMTP id 3f1490d57ef6-bce1d7a8d2aso1828169276.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Jun 2023 05:46:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686660374; x=1689252374;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DJyvntNK5zxh7HK+mp4W1WMoJPxy7nqBJlYeYzOf6Og=;
        b=EVdgvP2xATFoCK6wYoYRZSVPo829zXutJuPKRSjMvfNSIvM7ibSWCoM1qL8Vg9AQjX
         JNgjlQcVZkNsd4NfLIbiXw9GG0wqqAWk5MIct6B6CyrF47t4HIas0OYbEYOeV62Kqura
         HcdT15HveyFLM9b/taIlaKlT82+4YruGoXBljB4WvOAGGOkGBpUyTLf7pYj+O2q3stUJ
         t7dUtf7tbQP1coT6AA9WkQOTIAxHuijrLLfyvR5XQ2sv4zU/zhvRgeFwFcTB3Nt78wVn
         6dMkGEX1wxwpQRfr/D7uTyWc3vFLfn7fBE7r1CC/E0nj9ousp5D522VVkcv96kiyvFuL
         34Ug==
X-Gm-Message-State: AC+VfDy+l7SACaq783PLasMKAW0bboj4aPPYxFbUpt+dPK8nurnat5qK
        eIB5koonI2w5ubr+LRWdRLqmRdR9XFNfPuest2nE/h/dH5K/4Na7uscnY1Z26tIFROgjCvsy1lD
        2LFxuhU9FjxE15HlN9JSfhQyL8Rgz38HXOQfQoKC27B6832e7SFzjJ9TO9k4=
X-Received: by 2002:a25:ba88:0:b0:ba8:3b3d:3dc0 with SMTP id s8-20020a25ba88000000b00ba83b3d3dc0mr1176566ybg.65.1686660374088;
        Tue, 13 Jun 2023 05:46:14 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6ByVyQMc1FDiM+BMPWPp5Yh34Hpj01MWgfV11RE/419O9gOrGZrLRNRl5YaWKNn5smLlZPr5vjNJmpBm2O3JM=
X-Received: by 2002:a25:ba88:0:b0:ba8:3b3d:3dc0 with SMTP id
 s8-20020a25ba88000000b00ba83b3d3dc0mr1176550ybg.65.1686660373803; Tue, 13 Jun
 2023 05:46:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230608154256.562906-1-aleksandr.mikhalitsyn@canonical.com>
 <f3864ed6-8c97-8a7a-f268-dab29eb2fb21@redhat.com> <CAEivzxcRsHveuW3nrPnSBK6_2-eT4XPvza3kN2oogvnbVXBKvQ@mail.gmail.com>
 <20230609-alufolie-gezaubert-f18ef17cda12@brauner> <CAEivzxc_LW6mTKjk46WivrisnnmVQs0UnRrh6p0KxhqyXrErBQ@mail.gmail.com>
 <ac1c6817-9838-fcf3-edc8-224ff85691e0@redhat.com>
In-Reply-To: <ac1c6817-9838-fcf3-edc8-224ff85691e0@redhat.com>
From:   Aleksandr Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Date:   Tue, 13 Jun 2023 14:46:02 +0200
Message-ID: <CAEivzxeZ6fDgYMnjk21qXYz13tHqZa8rP-cZ2jdxkY0eX+dOjw@mail.gmail.com>
Subject: Re: [PATCH v5 00/14] ceph: support idmapped mounts
To:     Xiubo Li <xiubli@redhat.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        Gregory Farnum <gfarnum@redhat.com>, stgraber@ubuntu.com,
        linux-fsdevel@vger.kernel.org, Ilya Dryomov <idryomov@gmail.com>,
        Jeff Layton <jlayton@kernel.org>, ceph-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 13, 2023 at 3:43=E2=80=AFAM Xiubo Li <xiubli@redhat.com> wrote:
>
>
> On 6/9/23 18:12, Aleksandr Mikhalitsyn wrote:
> > On Fri, Jun 9, 2023 at 12:00=E2=80=AFPM Christian Brauner <brauner@kern=
el.org> wrote:
> >> On Fri, Jun 09, 2023 at 10:59:19AM +0200, Aleksandr Mikhalitsyn wrote:
> >>> On Fri, Jun 9, 2023 at 3:57=E2=80=AFAM Xiubo Li <xiubli@redhat.com> w=
rote:
> >>>>
> >>>> On 6/8/23 23:42, Alexander Mikhalitsyn wrote:
> >>>>> Dear friends,
> >>>>>
> >>>>> This patchset was originally developed by Christian Brauner but I'l=
l continue
> >>>>> to push it forward. Christian allowed me to do that :)
> >>>>>
> >>>>> This feature is already actively used/tested with LXD/LXC project.
> >>>>>
> >>>>> Git tree (based on https://github.com/ceph/ceph-client.git master):
> >>> Hi Xiubo!
> >>>
> >>>> Could you rebase these patches to 'testing' branch ?
> >>> Will do in -v6.
> >>>
> >>>> And you still have missed several places, for example the following =
cases:
> >>>>
> >>>>
> >>>>      1    269  fs/ceph/addr.c <<ceph_netfs_issue_op_inline>>
> >>>>                req =3D ceph_mdsc_create_request(mdsc, CEPH_MDS_OP_GE=
TATTR,
> >>>> mode);
> >>> +
> >>>
> >>>>      2    389  fs/ceph/dir.c <<ceph_readdir>>
> >>>>                req =3D ceph_mdsc_create_request(mdsc, op, USE_AUTH_M=
DS);
> >>> +
> >>>
> >>>>      3    789  fs/ceph/dir.c <<ceph_lookup>>
> >>>>                req =3D ceph_mdsc_create_request(mdsc, op, USE_ANY_MD=
S);
> >>> We don't have an idmapping passed to lookup from the VFS layer. As I
> >>> mentioned before, it's just impossible now.
> >> ->lookup() doesn't deal with idmappings and really can't otherwise you
> >> risk ending up with inode aliasing which is really not something you
> >> want. IOW, you can't fill in inode->i_{g,u}id based on a mount's
> >> idmapping as inode->i_{g,u}id absolutely needs to be a filesystem wide
> >> value. So better not even risk exposing the idmapping in there at all.
> > Thanks for adding, Christian!
> >
> > I agree, every time when we use an idmapping we need to be careful with
> > what we map. AFAIU, inode->i_{g,u}id should be based on the filesystem
> > idmapping (not mount),
> > but in this case, Xiubo want's current_fs{u,g}id to be mapped
> > according to an idmapping.
> > Anyway, it's impossible at now and IMHO, until we don't have any
> > practical use case where
> > UID/GID-based path restriction is used in combination with idmapped
> > mounts it's not worth to
> > make such big changes in the VFS layer.
> >
> > May be I'm not right, but it seems like UID/GID-based path restriction
> > is not a widespread
> > feature and I can hardly imagine it to be used with the container
> > workloads (for instance),
> > because it will require to always keep in sync MDS permissions
> > configuration with the
> > possible UID/GID ranges on the client. It looks like a nightmare for sy=
sadmin.
> > It is useful when cephfs is used as an external storage on the host, bu=
t if you
> > share cephfs with a few containers with different user namespaces idmap=
ping...
>
> Hmm, while this will break the MDS permission check in cephfs then in
> lookup case. If we really couldn't support it we should make it to
> escape the check anyway or some OPs may fail and won't work as expected.

Hi Xiubo!

Disabling UID/GID checks on the MDS side looks reasonable. IMHO the
most important checks are:
- open
- mknod/mkdir/symlink/rename
and for these checks we already have an idmapping.

Also, I want to add that it's a little bit unusual when permission
checks are done against the caller UID/GID.
Usually, if we have opened a file descriptor and, for instance, passed
this file descriptor through a unix socket then
file descriptor holder will be able to use it in accordance with the
flags (O_RDONLY, O_RDWR, ...).
We also have ->f_cred on the struct file that contains credentials of
the file opener and permission checks are usually done
based on this. But in cephfs we are always using syscall caller's
credentials. It makes cephfs file descriptor "not transferable"
in terms of permission checks.

Kind regards,
Alex

>
> @Greg
>
> For the lookup requests the idmapping couldn't get the mapped UID/GID
> just like all the other requests, which is needed by the MDS permission
> check. Is that okay to make it disable the check for this case ? I am
> afraid this will break the MDS permssions logic.
>
> Any idea ?
>
> Thanks
>
> - Xiubo
>
>
> > Kind regards,
> > Alex
> >
>
