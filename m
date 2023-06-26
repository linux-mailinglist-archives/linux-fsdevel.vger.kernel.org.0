Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49CE273DE17
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jun 2023 13:49:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230003AbjFZLtp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Jun 2023 07:49:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbjFZLto (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Jun 2023 07:49:44 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42E891AA
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Jun 2023 04:49:42 -0700 (PDT)
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com [209.85.219.198])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 893E93F0F8
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Jun 2023 11:49:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1687780179;
        bh=SkktNo4E/0s7QKbN6YpAzSM3/V8UkU4phNXLLQD/vlk=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=ohXsRUDRoxBckEsmyIdOPc/zMEfYV3TenjWNepHRWCrp3HBfwqeR3GUKWSSmmckhr
         whhazEfe3zjMmUre/9qg1DfUK/tsC+DrRWv6J3cwp920vvcVX1xmBMdKsCV6AxxZ35
         ehVwGFxtk7LziiRL/5BLQuVQ/Olbwg51gYyC648BtLJj7l6fWmuMlZewFxSrF7+c5k
         CpsVDxWCI5pwVidsMGcHYjNURqhr907XW3L9YnfkGILhuZ3EeGc4txCsSHbl5WvWSB
         xy+ec4R2m6yMWPTbDtO9UtCi4g4Dqsinf3qFcu3ZNq3n+gjOBpMxZjceqwlqFF2/Sy
         5VDxC75NG6WXg==
Received: by mail-yb1-f198.google.com with SMTP id 3f1490d57ef6-bd6df68105cso4649113276.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Jun 2023 04:49:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687780178; x=1690372178;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SkktNo4E/0s7QKbN6YpAzSM3/V8UkU4phNXLLQD/vlk=;
        b=Fvcq/SfZQN+nHChVLFZSu1d6wTlEI5zCOKgUfBDPgf+Zgfs1OnR+9q+F9u0RRnZpkF
         txGH/tJ0I6AgC8RiPK2tuW2x8YuM06nysJ93Od3L7bdpmnbHrFyrAa9OpPnX5+d7EnLH
         nuDD1SQxztHGzJCVKLhat/m2tF6Ap1GJVkijMKZ3hJemI4HtfRxL1yOw0ZYhPGbWQ/Jr
         +Cj9o5rPPICTf7Kjr2na8slr30n5B8RVjWsDAAj+UiOLU8Wb/Th1Z4Okp0zI44MtLqwf
         gewU8kkmpQnqF6sGubmXzduIra8Dk4dObqBBanaPLPEUA4BSYQK1IyGB2FPK7bY99g/f
         cLCQ==
X-Gm-Message-State: AC+VfDxo1v3qj5/jQp7poZHTnv49xW5RO66zH+OzbBHImuXkCwTDKIaG
        BGyrLr6XyqYr949WwKexKSH/5sgKapEo6z7brfDXGTIyPjtz6lywn2WjWb6OUMTce1vy/X3rLVL
        8VQzLyHAj58RqWTMssC3JYNMw+ZpU6qd7AN/AVvbjoCFqs6CTHtoX57KEU6k=
X-Received: by 2002:a25:4fd4:0:b0:c00:514c:55f with SMTP id d203-20020a254fd4000000b00c00514c055fmr12566176ybb.47.1687780178629;
        Mon, 26 Jun 2023 04:49:38 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4gOuF0Yoe62/3EKcneuR0gY+4P9xXY339dBnM45ZMCVrydc2zdkwiR0X0tFxSfR4Ye1SpnkWCaNSTYoUDTWo8=
X-Received: by 2002:a25:4fd4:0:b0:c00:514c:55f with SMTP id
 d203-20020a254fd4000000b00c00514c055fmr12566171ybb.47.1687780178400; Mon, 26
 Jun 2023 04:49:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230608154256.562906-1-aleksandr.mikhalitsyn@canonical.com>
 <f3864ed6-8c97-8a7a-f268-dab29eb2fb21@redhat.com> <CAEivzxcRsHveuW3nrPnSBK6_2-eT4XPvza3kN2oogvnbVXBKvQ@mail.gmail.com>
 <20230609-alufolie-gezaubert-f18ef17cda12@brauner> <CAEivzxc_LW6mTKjk46WivrisnnmVQs0UnRrh6p0KxhqyXrErBQ@mail.gmail.com>
 <ac1c6817-9838-fcf3-edc8-224ff85691e0@redhat.com> <CAJ4mKGby71qfb3gd696XH3AazeR0Qc_VGYupMznRH3Piky+VGA@mail.gmail.com>
 <977d8133-a55f-0667-dc12-aa6fd7d8c3e4@redhat.com> <CAEivzxcr99sERxZX17rZ5jW9YSzAWYvAjOOhBH+FqRoso2=yng@mail.gmail.com>
 <626175e2-ee91-0f1a-9e5d-e506aea366fa@redhat.com> <64241ff0-9af3-6817-478f-c24a0b9de9b3@redhat.com>
 <CAEivzxeF51ZEKhQ-0M35nooZ7_cZgk1-q75-YbkeWpZ9RuHG4A@mail.gmail.com>
 <4c4f73d8-8238-6ab8-ae50-d83c1441ac05@redhat.com> <CAEivzxeQGkemxVwJ148b_+OmntUAWkdL==yMiTMN+GPyaLkFPg@mail.gmail.com>
In-Reply-To: <CAEivzxeQGkemxVwJ148b_+OmntUAWkdL==yMiTMN+GPyaLkFPg@mail.gmail.com>
From:   Aleksandr Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Date:   Mon, 26 Jun 2023 13:49:27 +0200
Message-ID: <CAEivzxeBNOeufOraU27Y+qVApVjAoLhzwPnw0HSkqSt6P3MV9w@mail.gmail.com>
Subject: Re: [PATCH v5 00/14] ceph: support idmapped mounts
To:     Xiubo Li <xiubli@redhat.com>
Cc:     Gregory Farnum <gfarnum@redhat.com>,
        Christian Brauner <brauner@kernel.org>, stgraber@ubuntu.com,
        linux-fsdevel@vger.kernel.org, Ilya Dryomov <idryomov@gmail.com>,
        Jeff Layton <jlayton@kernel.org>, ceph-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 26, 2023 at 1:23=E2=80=AFPM Aleksandr Mikhalitsyn
<aleksandr.mikhalitsyn@canonical.com> wrote:
>
> On Mon, Jun 26, 2023 at 4:12=E2=80=AFAM Xiubo Li <xiubli@redhat.com> wrot=
e:
> >
> >
> > On 6/24/23 15:11, Aleksandr Mikhalitsyn wrote:
> > > On Sat, Jun 24, 2023 at 3:37=E2=80=AFAM Xiubo Li <xiubli@redhat.com> =
wrote:
> > >> [...]
> > >>
> > >>   > > >
> > >>   > > > I thought about this too and came to the same conclusion, th=
at
> > >> UID/GID
> > >>   > > > based
> > >>   > > > restriction can be applied dynamically, so detecting it on m=
ount-time
> > >>   > > > helps not so much.
> > >>   > > >
> > >>   > > For this you please raise one PR to ceph first to support this=
, and in
> > >>   > > the PR we can discuss more for the MDS auth caps. And after th=
e PR
> > >>   > > getting merged then in this patch series you need to check the
> > >>   > > corresponding option or flag to determine whether could the id=
map
> > >>   > > mounting succeed.
> > >>   >
> > >>   > I'm sorry but I don't understand what we want to support here. D=
o we
> > >> want to
> > >>   > add some new ceph request that allows to check if UID/GID-based
> > >>   > permissions are applied for
> > >>   > a particular ceph client user?
> > >>
> > >> IMO we should prevent user to set UID/GID-based permisions caps from
> > >> ceph side.
> > >>
> > >> As I know currently there is no way to prevent users to set MDS auth
> > >> caps, IMO in ceph side at least we need one flag or option to disabl=
e
> > >> this once users want this fs cluster sever for idmap mounts use case=
.
> > > How this should be visible from the user side? We introducing a new
> > > kernel client mount option,
> > > like "nomdscaps", then pass flag to the MDS and MDS should check that
> > > MDS auth permissions
> > > are not applied (on the mount time) and prevent them from being
> > > applied later while session is active. Like that?
> > >
> > > At the same time I'm thinking about protocol extension that adds 2
> > > additional fields for UID/GID. This will allow to correctly
> > > handle everything. I wanted to avoid any changes to the protocol or
> > > server-side things. But if we want to change MDS side,
> > > maybe it's better then to go this way?
>
> Hi Xiubo,
>
> >
> > There is another way:
> >
> > For each client it will have a dedicated client auth caps, something li=
ke:
> >
> > client.foo
> >    key: *key*
> >    caps: [mds] allow r, allow rw path=3D/bar
> >    caps: [mon] allow r
> >    caps: [osd] allow rw tag cephfs data=3Dcephfs_a
>
> Do we have any infrastructure to get this caps list on the client side
> right now?
> (I've taken a quick look through the code and can't find anything
> related to this.)

I've found your PR that looks related https://github.com/ceph/ceph/pull/480=
27

>
> >
> > When mounting this client with idmap enabled, then we can just check th=
e
> > above [mds] caps, if there has any UID/GID based permissions set, then
> > fail the mounting.
>
> understood
>
> >
> > That means this kind client couldn't be mounted with idmap enabled.
> >
> > Also we need to make sure that once there is a mount with idmap enabled=
,
> > the corresponding client caps couldn't be append the UID/GID based
> > permissions. This need a patch in ceph anyway IMO.
>
> So, yeah we will need to effectively block cephx permission changes if
> there is a client mounted with
> an active idmapped mount. Sounds as something that require massive
> changes on the server side.
>
> At the same time this will just block users from using idmapped mounts
> along with UID/GID restrictions.
>
> If you want me to change server-side anyways, isn't it better just to
> extend cephfs protocol to properly
> handle UID/GIDs with idmapped mounts? (It was originally proposed by Chri=
stian.)
> What we need to do here is to add a separate UID/GID fields for ceph
> requests those are creating a new inodes
> (like mknod, symlink, etc).
>
> Kind regards,
> Alex
>
> >
> > Thanks
> >
> > - Xiubo
> >
> >
> >
> >
> >
> > >
> > > Thanks,
> > > Alex
> > >
> > >> Thanks
> > >>
> > >> - Xiubo
> > >>
> >
