Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34E1575801B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Jul 2023 16:49:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233435AbjGROts (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Jul 2023 10:49:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233489AbjGROti (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Jul 2023 10:49:38 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17DFF198E
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Jul 2023 07:49:23 -0700 (PDT)
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com [209.85.128.199])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 740D83FA70
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Jul 2023 14:49:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1689691761;
        bh=IM4aj7I8gS7KjUQ1X0JqquASRDWbaArHq24JJYD7Q/0=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=dhqDIMTdgMGGSm76tojxlo99lJ7qoJXODtxN8gvGdpISxfROSvy8oIzyYb3orMVCg
         vev4c3fGwXCVMtKTKyZsPBAhQRzBMBWDVwVgEAuW5PIKntnKm4rg/utm+k/caVxxBp
         74F3sAvqnJkj61e5tgiuyxX2V9ZwZ7LXzXqSR0jg6+os1KEvBZ1GNGwtyv0rcK1l8W
         5tgJhajV2cCgtcp+RZGJM1dtX7Jsj8B+Tv4PDREMBO2YoJEF6sGBO1Vaqzf+kwyn6T
         Mcx1be/Rrd9B0kLwPpqtpd5H+D6sC+4iz3eCeiYMlxTWIQ1zTY43NcZ14zyZGpMDK8
         xsbDii4yEXtQw==
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-579dd7e77f5so55724117b3.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Jul 2023 07:49:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689691760; x=1692283760;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IM4aj7I8gS7KjUQ1X0JqquASRDWbaArHq24JJYD7Q/0=;
        b=b8WJBc+0SokaI6xVJJ+s/AMuzURsjQVDhGolm2EdNN4jPrTTkaynmXrMC8sWXl88Xm
         abqx2kK3baJAx6kQc1/mTurKDkqoDkHGkbhw5fGHU1w2cYgr8kVgDJ+Hi/3GtpM/amGg
         rwCJa2swouXZ652F4gwFNiKJ1SAZ6OZE5jovj0FQ3U5Xeevg/aKlk+xpj0Rw2wIx1HZo
         xT9D83UQnitmPqzM268lZQ/6NGP4gA3u4fyW7MRunJ6uTMLwAYA6HCfWPX5L/ziMe4kq
         mWaubATmiL3C2JBkfct3OqxehE9tnWnc6Dc/KRQwIn1SPS0+kLM5K3tuwiiAnUPzhOM5
         P3wA==
X-Gm-Message-State: ABy/qLaoQI4Zh2ZUjM3ZLNBd9LJeDkVoUKrBMOI//KimT4Qmpr0M/6xR
        CDBB8ZGMXa2w1aIgi9pCG8/rA0p2RglSlNghGl702XV/zJYBNVPift+JkF7iAnLfYBX5gQJrnWx
        eBLPnEYJ3OGOI6U6lwtN4cPfaYaWesFPWfuFO7A9EQMIkLssMTLHXd2XT4b8=
X-Received: by 2002:a25:69cf:0:b0:ced:271:950a with SMTP id e198-20020a2569cf000000b00ced0271950amr78208ybc.47.1689691760237;
        Tue, 18 Jul 2023 07:49:20 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEO5qmMwH1xISjXxhCuGErM/YJwcJjm9liml+VmeP8mLgBzoicOArXKHvg54FsKEo3BJ05HcHs69CXUkcIr7qU=
X-Received: by 2002:a25:69cf:0:b0:ced:271:950a with SMTP id
 e198-20020a2569cf000000b00ced0271950amr78169ybc.47.1689691759053; Tue, 18 Jul
 2023 07:49:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230608154256.562906-1-aleksandr.mikhalitsyn@canonical.com>
 <f3864ed6-8c97-8a7a-f268-dab29eb2fb21@redhat.com> <CAEivzxcRsHveuW3nrPnSBK6_2-eT4XPvza3kN2oogvnbVXBKvQ@mail.gmail.com>
 <20230609-alufolie-gezaubert-f18ef17cda12@brauner> <CAEivzxc_LW6mTKjk46WivrisnnmVQs0UnRrh6p0KxhqyXrErBQ@mail.gmail.com>
 <ac1c6817-9838-fcf3-edc8-224ff85691e0@redhat.com> <CAJ4mKGby71qfb3gd696XH3AazeR0Qc_VGYupMznRH3Piky+VGA@mail.gmail.com>
 <977d8133-a55f-0667-dc12-aa6fd7d8c3e4@redhat.com> <CAEivzxcr99sERxZX17rZ5jW9YSzAWYvAjOOhBH+FqRoso2=yng@mail.gmail.com>
 <626175e2-ee91-0f1a-9e5d-e506aea366fa@redhat.com> <64241ff0-9af3-6817-478f-c24a0b9de9b3@redhat.com>
 <CAEivzxeF51ZEKhQ-0M35nooZ7_cZgk1-q75-YbkeWpZ9RuHG4A@mail.gmail.com>
 <4c4f73d8-8238-6ab8-ae50-d83c1441ac05@redhat.com> <CAEivzxeQGkemxVwJ148b_+OmntUAWkdL==yMiTMN+GPyaLkFPg@mail.gmail.com>
 <0a42c5d0-0479-e60e-ac84-be3b915c62d9@redhat.com> <CAEivzxcskn8WxcOo0PDHMascFRdYTD0Lr5Uo4fj3deBjDviOXA@mail.gmail.com>
 <8121882a-0823-3a60-e108-0ff7bae5c0c9@redhat.com>
In-Reply-To: <8121882a-0823-3a60-e108-0ff7bae5c0c9@redhat.com>
From:   Aleksandr Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Date:   Tue, 18 Jul 2023 16:49:08 +0200
Message-ID: <CAEivzxcaJQvYyutAL8xapvoer06c97uVSVC729pUE=4_z4m_CA@mail.gmail.com>
Subject: Re: [PATCH v5 00/14] ceph: support idmapped mounts
To:     Xiubo Li <xiubli@redhat.com>
Cc:     Gregory Farnum <gfarnum@redhat.com>,
        Christian Brauner <brauner@kernel.org>, stgraber@ubuntu.com,
        linux-fsdevel@vger.kernel.org, Ilya Dryomov <idryomov@gmail.com>,
        Jeff Layton <jlayton@kernel.org>, ceph-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 18, 2023 at 3:45=E2=80=AFAM Xiubo Li <xiubli@redhat.com> wrote:
>
>
> On 7/14/23 20:57, Aleksandr Mikhalitsyn wrote:
> > On Tue, Jul 4, 2023 at 3:09=E2=80=AFAM Xiubo Li <xiubli@redhat.com> wro=
te:
> >> Sorry, not sure, why my last reply wasn't sent out.
> >>
> >> Do it again.
> >>
> >>
> >> On 6/26/23 19:23, Aleksandr Mikhalitsyn wrote:
> >>> On Mon, Jun 26, 2023 at 4:12=E2=80=AFAM Xiubo Li<xiubli@redhat.com>  =
wrote:
> >>>> On 6/24/23 15:11, Aleksandr Mikhalitsyn wrote:
> >>>>> On Sat, Jun 24, 2023 at 3:37=E2=80=AFAM Xiubo Li<xiubli@redhat.com>=
  wrote:
> >>>>>> [...]
> >>>>>>
> >>>>>>     > > >
> >>>>>>     > > > I thought about this too and came to the same conclusion=
, that
> >>>>>> UID/GID
> >>>>>>     > > > based
> >>>>>>     > > > restriction can be applied dynamically, so detecting it =
on mount-time
> >>>>>>     > > > helps not so much.
> >>>>>>     > > >
> >>>>>>     > > For this you please raise one PR to ceph first to support =
this, and in
> >>>>>>     > > the PR we can discuss more for the MDS auth caps. And afte=
r the PR
> >>>>>>     > > getting merged then in this patch series you need to check=
 the
> >>>>>>     > > corresponding option or flag to determine whether could th=
e idmap
> >>>>>>     > > mounting succeed.
> >>>>>>     >
> >>>>>>     > I'm sorry but I don't understand what we want to support her=
e. Do we
> >>>>>> want to
> >>>>>>     > add some new ceph request that allows to check if UID/GID-ba=
sed
> >>>>>>     > permissions are applied for
> >>>>>>     > a particular ceph client user?
> >>>>>>
> >>>>>> IMO we should prevent user to set UID/GID-based permisions caps fr=
om
> >>>>>> ceph side.
> >>>>>>
> >>>>>> As I know currently there is no way to prevent users to set MDS au=
th
> >>>>>> caps, IMO in ceph side at least we need one flag or option to disa=
ble
> >>>>>> this once users want this fs cluster sever for idmap mounts use ca=
se.
> >>>>> How this should be visible from the user side? We introducing a new
> >>>>> kernel client mount option,
> >>>>> like "nomdscaps", then pass flag to the MDS and MDS should check th=
at
> >>>>> MDS auth permissions
> >>>>> are not applied (on the mount time) and prevent them from being
> >>>>> applied later while session is active. Like that?
> >>>>>
> >>>>> At the same time I'm thinking about protocol extension that adds 2
> >>>>> additional fields for UID/GID. This will allow to correctly
> >>>>> handle everything. I wanted to avoid any changes to the protocol or
> >>>>> server-side things. But if we want to change MDS side,
> >>>>> maybe it's better then to go this way?
> >>> Hi Xiubo,
> >>>
> >>>> There is another way:
> >>>>
> >>>> For each client it will have a dedicated client auth caps, something=
 like:
> >>>>
> >>>> client.foo
> >>>>      key: *key*
> >>>>      caps: [mds] allow r, allow rw path=3D/bar
> >>>>      caps: [mon] allow r
> >>>>      caps: [osd] allow rw tag cephfs data=3Dcephfs_a
> >>> Do we have any infrastructure to get this caps list on the client sid=
e
> >>> right now?
> >>> (I've taken a quick look through the code and can't find anything
> >>> related to this.)
> >> I am afraid there is no.
> >>
> >> But just after the following ceph PR gets merged it will be easy to do=
 this:
> >>
> >> https://github.com/ceph/ceph/pull/48027
> >>
> >> This is still under testing.
> >>
> >>>> When mounting this client with idmap enabled, then we can just check=
 the
> >>>> above [mds] caps, if there has any UID/GID based permissions set, th=
en
> >>>> fail the mounting.
> >>> understood
> >>>
> >>>> That means this kind client couldn't be mounted with idmap enabled.
> >>>>
> >>>> Also we need to make sure that once there is a mount with idmap enab=
led,
> >>>> the corresponding client caps couldn't be append the UID/GID based
> >>>> permissions. This need a patch in ceph anyway IMO.
> >>> So, yeah we will need to effectively block cephx permission changes i=
f
> >>> there is a client mounted with
> >>> an active idmapped mount. Sounds as something that require massive
> >>> changes on the server side.
> >> Maybe no need much, it should be simple IMO. But I am not 100% sure.
> >>
> >>> At the same time this will just block users from using idmapped mount=
s
> >>> along with UID/GID restrictions.
> >>>
> >>> If you want me to change server-side anyways, isn't it better just to
> >>> extend cephfs protocol to properly
> >>> handle UID/GIDs with idmapped mounts? (It was originally proposed by =
Christian.)
> >>> What we need to do here is to add a separate UID/GID fields for ceph
> >>> requests those are creating a new inodes
> >>> (like mknod, symlink, etc).
> > Dear Xiubo,
> >
> > I'm sorry for delay with reply, I've missed this message accidentally.
> >
> >> BTW, could you explain it more ? How could this resolve the issue we a=
re
> >> discussing here ?
> > This was briefly mentioned here
> > https://lore.kernel.org/all/20220105141023.vrrbfhti5apdvkz7@wittgenstei=
n/#t
> > by Christian. Let me describe it in detail.
> >
> > In the current approach we apply mount idmapping to
> > head->caller_{uid,gid} fields
> > to make mkdir/mknod/symlink operations set a proper inode owner
> > uid/gid in according with an idmapping.
>
> Sorry for late.
>
> I still couldn't get how this could resolve the lookup case.
>
> For a lookup request the caller_{uid, gid} still will be the mapped
> {uid, gid}, right ?

No, the idea is to stop mapping a caller_{uid, gid}. And to add a new
fields like
inode_owner_{uid, gid} which will be idmapped (this field will be specific =
only
for those operations that create a new inode).

>
And also the same for other non-create requests. If
> so this will be incorrect for the cephx perm checks IMO.

Thanks,
Alex

>
> Thanks
>
> - Xiubo
>
>
> > This makes a problem with path-based UID/GID restriction mechanism,
> > because it uses head->caller_{uid,gid} fields
> > to check if UID/GID is permitted or not.
> >
> > So, the problem is that we have one field in ceph request for two
> > different needs - to control permissions and to set inode owner.
> > Christian pointed that the most saner way is to modify ceph protocol
> > and add a separate field to store inode owner UID/GID,
> > and only this fields should be idmapped, but head->caller_{uid,gid}
> > will be untouched.
> >
> > With this approach, we will not affect UID/GID-based permission rules
> > with an idmapped mounts at all.
> >
> > Kind regards,
> > Alex
> >
> >> Thanks
> >>
> >> - Xiubo
> >>
> >>
> >>> Kind regards,
> >>> Alex
> >>>
> >>>> Thanks
> >>>>
> >>>> - Xiubo
> >>>>
> >>>>
> >>>>
> >>>>
> >>>>
> >>>>> Thanks,
> >>>>> Alex
> >>>>>
> >>>>>> Thanks
> >>>>>>
> >>>>>> - Xiubo
> >>>>>>
>
