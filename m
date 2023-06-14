Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BC3572FEDF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jun 2023 14:40:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235540AbjFNMkJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Jun 2023 08:40:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244714AbjFNMjz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Jun 2023 08:39:55 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA1DB19BC
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Jun 2023 05:39:51 -0700 (PDT)
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com [209.85.219.198])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id DC8273F188
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Jun 2023 12:39:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1686746388;
        bh=DJmITB5tAKBPU4poxuY/XUAm3YwXRszR2NsDhhIbI60=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=imGzi1i3g83VmlbG5Mc+sltizfsC4PzsCArjDNRsAChw2KxPoLvoR6jAbyqx73SBD
         mg22eNnZoiyieiiUciFvN7FXaRsBEs8UDRjhw7JT99o7BpenFaUA/X/vbpsaImmQAV
         ixwf51Nbu2KDZEDHkztleW8/2pzV8bkvW15YErlDBY1UlF8OsTE7u09pGRIy4vMqaw
         vp/wg6ADymvsaWIZMttWSmQrULreXeSF00Jb4oFFUkDtztNfGfV7Ot28VDaF+Ov5f5
         2QM50gxZTI5dGsTn+gTfxdPZfZQatbUMwH5WjwoTDH9+Rpj5XLuCv31TDMf0UrIhj2
         Y0mMAG4L5OnhQ==
Received: by mail-yb1-f198.google.com with SMTP id 3f1490d57ef6-bce829aca1bso752461276.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Jun 2023 05:39:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686746388; x=1689338388;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DJmITB5tAKBPU4poxuY/XUAm3YwXRszR2NsDhhIbI60=;
        b=QHDjwTi/wr72VbTKGrfLLU8Ohb6WU9uQDtdgLsr30OYE7p03tmUJ4uvFkwFTakBdNk
         2nTt+QwLy3Huset/D1zHA9r4ptDQQku59AzclILeb/E7JOBEDN+XK+T4Ku2jU2VmOWdb
         PCpl/0FRlBnXBC9aLtO/EYcro50d/5PS4g+7OXhwcpGhIKZcWtw0GMlOdvH5sS9RhnEh
         alctn51LV2voWC7RvyiLLryaPqxBQeV4RPXkI0CtlM6/Jm9iJHiDeNPONFXXXpTJoCKH
         0MsX9XYWIEvkNqOp7TAzuLuiKz+vsTGVwnGlYsFRlhvv3saers0wEQDR10PpHbXljQP5
         3PNw==
X-Gm-Message-State: AC+VfDzb31b7vet3YurAOBckoljI55yuJlqb6tl8d5s0Ar/7q4WDJ8sg
        o6+bZN3fd9/l15Ud3wE/UIPpV47Zr2zn2sNh/PCk7RMoUkoyBKSHVMXsNCKVztRHlTHL/5dCHcN
        JD6S7HBmpgGlGOd8w3IjvuMPm5KGy4hHzdfhmiO3RT3ije6C3ZdjzT1Mxp3g=
X-Received: by 2002:a25:dfcc:0:b0:bac:26e5:9463 with SMTP id w195-20020a25dfcc000000b00bac26e59463mr2450381ybg.61.1686746387745;
        Wed, 14 Jun 2023 05:39:47 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ48Gb426BrSNTPGl6U5yd6BpIZx4OkH7EKxSx4YA/rRF4VRrsx63JzCab3C94CovjoQmMXC2aBWQdwBFt5b69U=
X-Received: by 2002:a25:dfcc:0:b0:bac:26e5:9463 with SMTP id
 w195-20020a25dfcc000000b00bac26e59463mr2450358ybg.61.1686746387410; Wed, 14
 Jun 2023 05:39:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230608154256.562906-1-aleksandr.mikhalitsyn@canonical.com>
 <f3864ed6-8c97-8a7a-f268-dab29eb2fb21@redhat.com> <CAEivzxcRsHveuW3nrPnSBK6_2-eT4XPvza3kN2oogvnbVXBKvQ@mail.gmail.com>
 <20230609-alufolie-gezaubert-f18ef17cda12@brauner> <CAEivzxc_LW6mTKjk46WivrisnnmVQs0UnRrh6p0KxhqyXrErBQ@mail.gmail.com>
 <ac1c6817-9838-fcf3-edc8-224ff85691e0@redhat.com> <CAJ4mKGby71qfb3gd696XH3AazeR0Qc_VGYupMznRH3Piky+VGA@mail.gmail.com>
 <977d8133-a55f-0667-dc12-aa6fd7d8c3e4@redhat.com>
In-Reply-To: <977d8133-a55f-0667-dc12-aa6fd7d8c3e4@redhat.com>
From:   Aleksandr Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Date:   Wed, 14 Jun 2023 14:39:36 +0200
Message-ID: <CAEivzxcBBJV6DOGzy5S7=TUjrXZfVaGaJX5z7WFzYq1w4MdtiA@mail.gmail.com>
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
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 14, 2023 at 3:53=E2=80=AFAM Xiubo Li <xiubli@redhat.com> wrote:
>
>
> On 6/13/23 22:53, Gregory Farnum wrote:
> > On Mon, Jun 12, 2023 at 6:43=E2=80=AFPM Xiubo Li <xiubli@redhat.com> wr=
ote:
> >>
> >> On 6/9/23 18:12, Aleksandr Mikhalitsyn wrote:
> >>> On Fri, Jun 9, 2023 at 12:00=E2=80=AFPM Christian Brauner <brauner@ke=
rnel.org> wrote:
> >>>> On Fri, Jun 09, 2023 at 10:59:19AM +0200, Aleksandr Mikhalitsyn wrot=
e:
> >>>>> On Fri, Jun 9, 2023 at 3:57=E2=80=AFAM Xiubo Li <xiubli@redhat.com>=
 wrote:
> >>>>>> On 6/8/23 23:42, Alexander Mikhalitsyn wrote:
> >>>>>>> Dear friends,
> >>>>>>>
> >>>>>>> This patchset was originally developed by Christian Brauner but I=
'll continue
> >>>>>>> to push it forward. Christian allowed me to do that :)
> >>>>>>>
> >>>>>>> This feature is already actively used/tested with LXD/LXC project=
.
> >>>>>>>
> >>>>>>> Git tree (based on https://github.com/ceph/ceph-client.git master=
):
> >>>>> Hi Xiubo!
> >>>>>
> >>>>>> Could you rebase these patches to 'testing' branch ?
> >>>>> Will do in -v6.
> >>>>>
> >>>>>> And you still have missed several places, for example the followin=
g cases:
> >>>>>>
> >>>>>>
> >>>>>>       1    269  fs/ceph/addr.c <<ceph_netfs_issue_op_inline>>
> >>>>>>                 req =3D ceph_mdsc_create_request(mdsc, CEPH_MDS_OP=
_GETATTR,
> >>>>>> mode);
> >>>>> +
> >>>>>
> >>>>>>       2    389  fs/ceph/dir.c <<ceph_readdir>>
> >>>>>>                 req =3D ceph_mdsc_create_request(mdsc, op, USE_AUT=
H_MDS);
> >>>>> +
> >>>>>
> >>>>>>       3    789  fs/ceph/dir.c <<ceph_lookup>>
> >>>>>>                 req =3D ceph_mdsc_create_request(mdsc, op, USE_ANY=
_MDS);
> >>>>> We don't have an idmapping passed to lookup from the VFS layer. As =
I
> >>>>> mentioned before, it's just impossible now.
> >>>> ->lookup() doesn't deal with idmappings and really can't otherwise y=
ou
> >>>> risk ending up with inode aliasing which is really not something you
> >>>> want. IOW, you can't fill in inode->i_{g,u}id based on a mount's
> >>>> idmapping as inode->i_{g,u}id absolutely needs to be a filesystem wi=
de
> >>>> value. So better not even risk exposing the idmapping in there at al=
l.
> >>> Thanks for adding, Christian!
> >>>
> >>> I agree, every time when we use an idmapping we need to be careful wi=
th
> >>> what we map. AFAIU, inode->i_{g,u}id should be based on the filesyste=
m
> >>> idmapping (not mount),
> >>> but in this case, Xiubo want's current_fs{u,g}id to be mapped
> >>> according to an idmapping.
> >>> Anyway, it's impossible at now and IMHO, until we don't have any
> >>> practical use case where
> >>> UID/GID-based path restriction is used in combination with idmapped
> >>> mounts it's not worth to
> >>> make such big changes in the VFS layer.
> >>>
> >>> May be I'm not right, but it seems like UID/GID-based path restrictio=
n
> >>> is not a widespread
> >>> feature and I can hardly imagine it to be used with the container
> >>> workloads (for instance),
> >>> because it will require to always keep in sync MDS permissions
> >>> configuration with the
> >>> possible UID/GID ranges on the client. It looks like a nightmare for =
sysadmin.
> >>> It is useful when cephfs is used as an external storage on the host, =
but if you
> >>> share cephfs with a few containers with different user namespaces idm=
apping...
> >> Hmm, while this will break the MDS permission check in cephfs then in
> >> lookup case. If we really couldn't support it we should make it to
> >> escape the check anyway or some OPs may fail and won't work as expecte=
d.
> > I don't pretend to know the details of the VFS (or even our linux
> > client implementation), but I'm confused that this is apparently so
> > hard. It looks to me like we currently always fill in the "caller_uid"
> > with "from_kuid(&init_user_ns, req->r_cred->fsuid))". Is this actually
> > valid to begin with? If it is, why can't the uid mapping be applied on
> > that?
> >
> > As both the client and the server share authority over the inode's
> > state (including things like mode bits and owners), and need to do
> > permission checking, being able to tell the server the relevant actor
> > is inherently necessary. We also let admins restrict keys to
> > particular UID/GID combinations as they wish, and it's not the most
> > popular feature but it does get deployed. I would really expect a user
> > of UID mapping to be one of the *most* likely to employ such a
> > facility...maybe not with containers, but certainly end-user homedirs
> > and shared spaces.
> >
> > Disabling the MDS auth checks is really not an option. I guess we
> > could require any user employing idmapping to not be uid-restricted,
> > and set the anonymous UID (does that work, Xiubo, or was it the broken
> > one? In which case we'd have to default to root?). But that seems a
> > bit janky to me.
>
> Yeah, this also seems risky.
>
> Instead disabling the MDS auth checks there is another option, which is
> we can prevent  the kclient to be mounted or the idmapping to be
> applied. But this still have issues, such as what if admins set the MDS
> auth caps after idmap applied to the kclients ?

Hi Xiubo,

I thought about this too and came to the same conclusion, that UID/GID base=
d
restriction can be applied dynamically, so detecting it on mount-time
helps not so much.

>
> IMO there have 2 options: the best way is to fix this in VFS if
> possible. Else to add one option to disable the corresponding MDS auth
> caps in ceph if users want to support the idmap feature.

Dear colleagues,
Dear Xiubo,

Let me try to summarize the previous discussions about cephfs idmapped
mount support.

This discussion about the need of caller's UID/GID mapping is started
from the first
version of this patchset in this [1] thread. Let'me quote Christian here:
> Since the idmapping is a property of the mount and not a property of the
> caller the caller's fs{g,u}id aren't mapped. What is mapped are the
> inode's i{g,u}id when accessed from a particular mount.
>
> The fs{g,u}id are only ever mapped when a new filesystem object is
> created. So if I have an idmapped mount that makes it so that files
> owned by 1000 on-disk appear to be owned by uid 0 then a user with uid 0
> creating a new file will create files with uid 1000 on-disk when going
> through that mount. For cephfs that'd be the uid we would be sending
> with creation requests as I've currently written it.

This is a key part of this discussion. Idmapped mounts is not a way to prox=
ify
caller's UID/GID, but idmapped mounts are designed to perform UID/GID mappi=
ng
of inode's owner's UID/GID. Yes, these concepts look really-really
close and from
the first glance it looks like it's just an equivalent thing. But they are =
not.

From my understanding, if someone wants to verify caller UID/GID then he sh=
ould
take an unmapped UID/GID and verify it. It's not important if the
caller does something
through an idmapped mount or not, from_kuid(&init_user_ns, req->r_cred->fsu=
id))
literally "UID of the caller in a root user namespace". But cephfs
mount can be used
from any user namespace (yes, cephfs can't be mounted in user namespaces, b=
ut it
can be inherited during CLONE_NEWNS, or used as a detached mount with
open_tree/move_mount).
What I want to say by providing this example is that even now, without
idmapped mounts
we have kinda close problem, that UID/GID based restriction will be
based on the host's (!),
root user namespace, UID/GID-s even if the caller sits inside the user
namespace. And we don't care,
right? Why it's a problem with an idmapped mounts? If someone wants to
control caller's UID/GID
on the MDS side he just needs to take hosts UID/GIDs and use them in
permission rules. That's it.

Next point is that technically idmapped mounts don't break anything,
if someone starts using
idmapped mounts with UID/GID-based restrictions he will get -EACCESS.
Why is this a problem?
A user will check configuration, read the clarification in the
documentation about idmapped mounts
in cephfs and find a warning that these are not fully compatible
things right now.

IMHO, there is only one real problem (which makes UID/GID-based
restrictions is not fully compatible with
an idmapped mounts). Is that we have to map caller's UID/GID according
to a mount idmapping when we
creating a new inode (mknod, mkdir, symlink, open(O_CREAT)). But it's
only because the caller's UID/GIDs are
used as the owner's UID/GID for newly created inode. Ideally, we need
to have two fields in ceph request,
one for a caller's UID/GID and another one for inode owner UID/GID.
But this requires cephfs protocol modification
(yes, it's a bit painful. But global VFS changes are painful too!). As
Christian pointed this is a reason why
he went this way in the first patchset version.

Maybe I'm not right, but both options to properly fix that VFS API
changes or cephfs protocol modification
are too expensive until we don't have a real requestors with a good
use case for idmapped mounts + UID/GID
based permissions. We already have a real and good use case for
idmapped mounts in Cephfs for LXD/LXC.
IMHO, it's better to move this thing forward step by step, because VFS
API/cephfs protocol changes will
take a really big amount of time and it's not obvious that it's worth
it, moreover it's not even clear that VFS API
change is the right way to deal with this problem. It seems to me that
Cephfs protocol change seems like a
more proper way here. At the same time I fully understand that you are
not happy about this option.

Just to conclude, we don't have any kind of cephfs degradation here,
all users without idmapping will not be affected,
all users who start using mount idmappings with cephfs will be aware
of this limitation.

[1] https://lore.kernel.org/all/20220105141023.vrrbfhti5apdvkz7@wittgenstei=
n/

Kind regards,
Alex

>
> Thanks
>
> - Xiubo
>
> > -Greg
> >
> >> @Greg
> >>
> >> For the lookup requests the idmapping couldn't get the mapped UID/GID
> >> just like all the other requests, which is needed by the MDS permissio=
n
> >> check. Is that okay to make it disable the check for this case ? I am
> >> afraid this will break the MDS permssions logic.
> >>
> >> Any idea ?
> >>
> >> Thanks
> >>
> >> - Xiubo
> >>
> >>
> >>> Kind regards,
> >>> Alex
> >>>
>
