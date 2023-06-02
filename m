Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D64C71FE76
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Jun 2023 12:01:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234819AbjFBKBn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Jun 2023 06:01:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234404AbjFBKBm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Jun 2023 06:01:42 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9702132
        for <linux-fsdevel@vger.kernel.org>; Fri,  2 Jun 2023 03:01:39 -0700 (PDT)
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com [209.85.219.199])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 5B39A3F554
        for <linux-fsdevel@vger.kernel.org>; Fri,  2 Jun 2023 10:01:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1685700098;
        bh=PKNtDbottNuLJdyVIGlhFnFpP8QTQu4OZKg/JyUGkhk=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=lgE6WVVxTvAkU3TWKRLBHO9fbsZjApyzuC+M+LweIkmCiT0XHlIJAoxAVackSmHSH
         1sPAYaxyaLAVUp9/i26wZP7HVFNq20gILmXlc98nBxBh7IsphrE2gnC1EWkcWZeULq
         ea47pdPz5//sr69fEFG9yU84nDwj7W84O9n5PchMtAHr7tSQ7348hLlEja7Cr8s3IH
         9/Y0temOgbts4zEhecpmw1AxzM8g/I9clK1Dr0m72DfIy/rvzNOw9ZoFbyziJLFALg
         0/3tf44T3sry+a4pUhEDLZJ7jwPdAxJlvOOEG8k49ckOSlqbZTCxlDXrxuaDe1Rfpd
         1E6MNVQMKmmqg==
Received: by mail-yb1-f199.google.com with SMTP id 3f1490d57ef6-bad1c8dce48so2632418276.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 02 Jun 2023 03:01:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685700093; x=1688292093;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PKNtDbottNuLJdyVIGlhFnFpP8QTQu4OZKg/JyUGkhk=;
        b=BqdaSfomEiAv5ix/Zm3Qyf1S98vEy8rZ7z2jmW6D6cgyYxTQmlnrupThJ5Zr4BLq6v
         PwKy0+iXbB25VDt0BKnxjZBbT0/sKoWk5ri1XaxbzIzZ9Fg/INPqYr50ewF4Vl6jaFhp
         UvQgyVMTXaXk303/LFDZnFYA/Bo55XwRddKif90jZgdbeGE6PKsXZLiJaYYdQnCW16em
         TWMnLXXOv6tQbGdvjf5jR/jMvtJTabjpWNGKjErfCo3ovyePRPEkIS8DV/VmgOrUT9yx
         kzavKXpy0IrsXh/GDDE9kR/rDU6cCyl4hhPcRoTMn5jkO3Un+RNm8bS/1iC4ZFxoGKYh
         JPNw==
X-Gm-Message-State: AC+VfDyuYSeXsCdsWyUz0ru4BeitEfhSH+JHRw8j/DSqTv4smnxnQ5GQ
        ftQT1L25PmwEK/fhodfzr1dLT3hGJKSW/rXV8Yehx6T/OtNBmya0/4A1nRyp2Y0BKjqfxgyNTIT
        +XMyz4wduPile5uxMzan44GeqViVuTVu8Wcm/79XGFH94MFd8o0/XmOHHjn0=
X-Received: by 2002:a25:b10a:0:b0:bad:fda:38b0 with SMTP id g10-20020a25b10a000000b00bad0fda38b0mr2926227ybj.8.1685700093148;
        Fri, 02 Jun 2023 03:01:33 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6uGdnI9bsplYr05ZfRFT1eZFOE4pvsrHpydKKJOVJxG6hixRLigiqu4OQeW9nF8ToeBUIkwhCAu98lsQ97VHg=
X-Received: by 2002:a25:b10a:0:b0:bad:fda:38b0 with SMTP id
 g10-20020a25b10a000000b00bad0fda38b0mr2926211ybj.8.1685700092817; Fri, 02 Jun
 2023 03:01:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230524153316.476973-1-aleksandr.mikhalitsyn@canonical.com>
 <20230524153316.476973-4-aleksandr.mikhalitsyn@canonical.com>
 <ec6d6cf4-a1f9-ac45-d23d-b69805d81c02@redhat.com> <CAEivzxe6t08UDv6ksKfqS6BP1HaunMxr2LTGZULX5_uQ5gaT=w@mail.gmail.com>
 <39a15aa6-f7ce-91c2-392d-591f4c079ad8@redhat.com> <CAEivzxefBRPozUPQxYgVh0gOpjsovtBuJ3w9BoqSizpST_YxTA@mail.gmail.com>
 <fc6ea2e2-3f61-d91d-2336-a73907f5311f@redhat.com>
In-Reply-To: <fc6ea2e2-3f61-d91d-2336-a73907f5311f@redhat.com>
From:   Aleksandr Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Date:   Fri, 2 Jun 2023 12:01:21 +0200
Message-ID: <CAEivzxcnbTA2OrV=UewBxw+iib_8a7wSNoodvA30-77k+C3pmA@mail.gmail.com>
Subject: Re: [PATCH v2 03/13] ceph: handle idmapped mounts in create_request_message()
To:     Xiubo Li <xiubli@redhat.com>
Cc:     brauner@kernel.org, stgraber@ubuntu.com,
        linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org,
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

On Fri, Jun 2, 2023 at 2:41=E2=80=AFAM Xiubo Li <xiubli@redhat.com> wrote:
>
>
> On 6/2/23 02:29, Aleksandr Mikhalitsyn wrote:
> > On Thu, Jun 1, 2023 at 4:29=E2=80=AFAM Xiubo Li <xiubli@redhat.com> wro=
te:
> >>
> >> On 6/1/23 00:32, Aleksandr Mikhalitsyn wrote:
> >>> On Mon, May 29, 2023 at 5:52=E2=80=AFAM Xiubo Li <xiubli@redhat.com> =
wrote:
> >>>> On 5/24/23 23:33, Alexander Mikhalitsyn wrote:
> >>>>> From: Christian Brauner <christian.brauner@ubuntu.com>
> >>>>>
> >>>>> Inode operations that create a new filesystem object such as ->mkno=
d,
> >>>>> ->create, ->mkdir() and others don't take a {g,u}id argument explic=
itly.
> >>>>> Instead the caller's fs{g,u}id is used for the {g,u}id of the new
> >>>>> filesystem object.
> >>>>>
> >>>>> Cephfs mds creation request argument structures mirror this filesys=
tem
> >>>>> behavior. They don't encode a {g,u}id explicitly. Instead the calle=
r's
> >>>>> fs{g,u}id that is always sent as part of any mds request is used by=
 the
> >>>>> servers to set the {g,u}id of the new filesystem object.
> >>>>>
> >>>>> In order to ensure that the correct {g,u}id is used map the caller'=
s
> >>>>> fs{g,u}id for creation requests. This doesn't require complex chang=
es.
> >>>>> It suffices to pass in the relevant idmapping recorded in the reque=
st
> >>>>> message. If this request message was triggered from an inode operat=
ion
> >>>>> that creates filesystem objects it will have passed down the releva=
nt
> >>>>> idmaping. If this is a request message that was triggered from an i=
node
> >>>>> operation that doens't need to take idmappings into account the ini=
tial
> >>>>> idmapping is passed down which is an identity mapping and thus is
> >>>>> guaranteed to leave the caller's fs{g,u}id unchanged.,u}id is sent.
> >>>>>
> >>>>> The last few weeks before Christmas 2021 I have spent time not just
> >>>>> reading and poking the cephfs kernel code but also took a look at t=
he
> >>>>> ceph mds server userspace to ensure I didn't miss some subtlety.
> >>>>>
> >>>>> This made me aware of one complication to solve. All requests send =
the
> >>>>> caller's fs{g,u}id over the wire. The caller's fs{g,u}id matters fo=
r the
> >>>>> server in exactly two cases:
> >>>>>
> >>>>> 1. to set the ownership for creation requests
> >>>>> 2. to determine whether this client is allowed access on this serve=
r
> >>>>>
> >>>>> Case 1. we already covered and explained. Case 2. is only relevant =
for
> >>>>> servers where an explicit uid access restriction has been set. That=
 is
> >>>>> to say the mds server restricts access to requests coming from a
> >>>>> specific uid. Servers without uid restrictions will grant access to
> >>>>> requests from any uid by setting MDS_AUTH_UID_ANY.
> >>>>>
> >>>>> Case 2. introduces the complication because the caller's fs{g,u}id =
is
> >>>>> not just used to record ownership but also serves as the {g,u}id us=
ed
> >>>>> when checking access to the server.
> >>>>>
> >>>>> Consider a user mounting a cephfs client and creating an idmapped m=
ount
> >>>>> from it that maps files owned by uid 1000 to be owned uid 0:
> >>>>>
> >>>>> mount -t cephfs -o [...] /unmapped
> >>>>> mount-idmapped --map-mount 1000:0:1 /idmapped
> >>>>>
> >>>>> That is to say if the mounted cephfs filesystem contains a file "fi=
le1"
> >>>>> which is owned by uid 1000:
> >>>>>
> >>>>> - looking at it via /unmapped/file1 will report it as owned by uid =
1000
> >>>>>      (One can think of this as the on-disk value.)
> >>>>> - looking at it via /idmapped/file1 will report it as owned by uid =
0
> >>>>>
> >>>>> Now, consider creating new files via the idmapped mount at /idmappe=
d.
> >>>>> When a caller with fs{g,u}id 1000 creates a file "file2" by going
> >>>>> through the idmapped mount mounted at /idmapped it will create a fi=
le
> >>>>> that is owned by uid 1000 on-disk, i.e.:
> >>>>>
> >>>>> - looking at it via /unmapped/file2 will report it as owned by uid =
1000
> >>>>> - looking at it via /idmapped/file2 will report it as owned by uid =
0
> >>>>>
> >>>>> Now consider an mds server that has a uid access restriction set an=
d
> >>>>> only grants access to requests from uid 0.
> >>>>>
> >>>>> If the client sends a creation request for a file e.g. /idmapped/fi=
le2
> >>>>> it will send the caller's fs{g,u}id idmapped according to the idmap=
ped
> >>>>> mount. So if the caller has fs{g,u}id 1000 it will be mapped to {g,=
u}id
> >>>>> 0 in the idmapped mount and will be sent over the wire allowing the
> >>>>> caller access to the mds server.
> >>>>>
> >>>>> However, if the caller is not issuing a creation request the caller=
's
> >>>>> fs{g,u}id will be send without the mount's idmapping applied. So if=
 the
> >>>>> caller that just successfully created a new file on the restricted =
mds
> >>>>> server sends a request as fs{g,u}id 1000 access will be refused. Th=
is
> >>>>> however is inconsistent.
> >>>>>
> >>>>>    From my perspective the root of the problem lies in the fact tha=
t
> >>>>> creation requests implicitly infer the ownership from the {g,u}id t=
hat
> >>>>> gets sent along with every mds request.
> >>>>>
> >>>>> I have thought of multiple ways of addressing this problem but the =
one I
> >>>>> prefer is to give all mds requests that create a filesystem object =
a
> >>>>> proper, separate {g,u}id field entry in the argument struct. This i=
s,
> >>>>> for example how ->setattr mds requests work.
> >>>>>
> >>>>> This way the caller's fs{g,u}id can be used consistenly for server
> >>>>> access checks and is separated from the ownership for new filesyste=
m
> >>>>> objects.
> >>>>>
> >>>>> Servers could then be updated to refuse creation requests whenever =
the
> >>>>> {g,u}id used for access checking doesn't match the {g,u}id used for
> >>>>> creating the filesystem object just as is done for setattr requests=
 on a
> >>>>> uid restricted server. But I am, of course, open to other suggestio=
ns.
> >>>>>
> >>>>> Cc: Jeff Layton <jlayton@kernel.org>
> >>>>> Cc: Ilya Dryomov <idryomov@gmail.com>
> >>>>> Cc: ceph-devel@vger.kernel.org
> >>>>> Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
> >>>>> Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonic=
al.com>
> >>>>> ---
> >>>>>     fs/ceph/mds_client.c | 22 ++++++++++++++++++----
> >>>>>     1 file changed, 18 insertions(+), 4 deletions(-)
> >>>>>
> >>>>> diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> >>>>> index 810c3db2e369..e4265843b838 100644
> >>>>> --- a/fs/ceph/mds_client.c
> >>>>> +++ b/fs/ceph/mds_client.c
> >>>>> @@ -2583,6 +2583,8 @@ static struct ceph_msg *create_request_messag=
e(struct ceph_mds_session *session,
> >>>>>         void *p, *end;
> >>>>>         int ret;
> >>>>>         bool legacy =3D !(session->s_con.peer_features & CEPH_FEATU=
RE_FS_BTIME);
> >>>>> +     kuid_t caller_fsuid;
> >>>>> +     kgid_t caller_fsgid;
> >>>>>
> >>>>>         ret =3D set_request_path_attr(req->r_inode, req->r_dentry,
> >>>>>                               req->r_parent, req->r_path1, req->r_i=
no1.ino,
> >>>>> @@ -2651,10 +2653,22 @@ static struct ceph_msg *create_request_mess=
age(struct ceph_mds_session *session,
> >>>>>
> >>>>>         head->mdsmap_epoch =3D cpu_to_le32(mdsc->mdsmap->m_epoch);
> >>>>>         head->op =3D cpu_to_le32(req->r_op);
> >>>>> -     head->caller_uid =3D cpu_to_le32(from_kuid(&init_user_ns,
> >>>>> -                                              req->r_cred->fsuid))=
;
> >>>>> -     head->caller_gid =3D cpu_to_le32(from_kgid(&init_user_ns,
> >>>>> -                                              req->r_cred->fsgid))=
;
> >>>>> +     /*
> >>>>> +      * Inode operations that create filesystem objects based on t=
he
> >>>>> +      * caller's fs{g,u}id like ->mknod(), ->create(), ->mkdir() e=
tc. don't
> >>>>> +      * have separate {g,u}id fields in their respective structs i=
n the
> >>>>> +      * ceph_mds_request_args union. Instead the caller_{g,u}id fi=
eld is
> >>>>> +      * used to set ownership of the newly created inode by the md=
s server.
> >>>>> +      * For these inode operations we need to send the mapped fs{g=
,u}id over
> >>>>> +      * the wire. For other cases we simple set req->r_mnt_idmap t=
o the
> >>>>> +      * initial idmapping meaning the unmapped fs{g,u}id is sent.
> >>>>> +      */
> >>>>> +     caller_fsuid =3D from_vfsuid(req->r_mnt_idmap, &init_user_ns,
> >>>>> +                                     VFSUIDT_INIT(req->r_cred->fsu=
id));
> >>>>> +     caller_fsgid =3D from_vfsgid(req->r_mnt_idmap, &init_user_ns,
> >>>>> +                                     VFSGIDT_INIT(req->r_cred->fsg=
id));
> >>>>> +     head->caller_uid =3D cpu_to_le32(from_kuid(&init_user_ns, cal=
ler_fsuid));
> >>>>> +     head->caller_gid =3D cpu_to_le32(from_kgid(&init_user_ns, cal=
ler_fsgid));
> >>>> Hi Alexander,
> >>> Dear Xiubo,
> >>>
> >>> Thanks for paying attention to this series!
> >>>
> >>>> You didn't answer Jeff and Greg's concerns in the first version
> >>>> https://www.spinics.net/lists/ceph-devel/msg53356.html.
> >>> I've tried to respin discussion in the -v1 thread:
> >>> https://lore.kernel.org/all/20230519134420.2d04e5f70aad15679ab566fc@c=
anonical.com/
> >>>
> >>> No one replied, so I decided to send rebased and slightly changed -v2=
,
> >>> where I've fixed this:
> >>> https://lore.kernel.org/all/041afbfd171915d62ab9a93c7a35d9c9d5c5bf7b.=
camel@kernel.org/
> >>>
> >>>> I am also confused as Greg mentioned. If we just map the ids as 1000=
:0
> >>>> and created a file and then map the ids 1000:10, then the file could=
n't
> >>>> be accessible, right ? Is this normal and as expected ?
> >>> This can be a problem only if filtering based on the UID is turned on
> >>> on the server side (which is a relatively rare case).
> >>>
> >>> idmapped mounts are not about mapping a caller UID/GID, idmapped
> >>> mounts are about mapping inode owner's UID/GID.
> >>> So, for example if you have UID 1000 (on disk) and have an idmapping
> >>> 1000:0 then it will be shown as owned by 0.
> >> My understanding was that on the disk the files' owner UID should be
> >> 1000 always, while in the client side it will show file's owner as the
> >> mapped UID 0 with an idmapping 1000:0.
> > Hi, Xiubo!
> >
> >> This should be the same as what you mentioned above, right ?
> > Right.
> >
> > Let me show a real output from a real command line experiment :-)
> >
> > 1. Mount cephfs
> >
> > mount.ceph admin@XYZ.cephfs=3D/ /mnt/ceph -o
> > mon_addr=3D127.0.0.1:6789,secret=3Dvery_secret_key
> >
> > 2. Make 1000:1000 a root dentry owner (it will be convenient because
> > we want to use mapping 1000:0:1 for simplicity)
> >
> > chown 1000:1000 /mnt/ceph
> >
> > 3. create an idmapped mount based on a regular /mnt/ceph mount using a
> > mount-idmapped tool that was written by Christian.
> > [ taken from https://raw.githubusercontent.com/brauner/mount-idmapped/m=
aster/mount-idmapped.c
> > ]
> >
> > ./mount-idmapped --map-mount b:1000:0:1 /mnt/ceph /mnt/ceph_idmapped
> >
> > "b" stands for "both", so we are creating a mapping of length 1 for
> > both UID and GID.
> > 1000 is a UID/GID "on-disk", 0 is a mapped UID/GID.
> >
> > 4. Just to be precise, let's look at which UID/GID we have now.
> >
> > root@ubuntu:/home/ubuntu# ls -lan /mnt/ceph
> > total 4
> > drwxrwxrwx 2 1000 1000    0 Jun  1 17:51 .
> > drwxr-xr-x 4    0    0 4096 Jun  1 16:55 ..
> >
> > root@ubuntu:/home/ubuntu# ls -lan /mnt/ceph_idmapped
> > total 4
> > drwxrwxrwx 2 0 0    0 Jun  1 17:51 .
> > drwxr-xr-x 4 0 0 4096 Jun  1 16:55 ..
> >
> > 5. Now let's create a bunch of files with different owners and through
> > different mounts (idmapped/non-idmapped).
> >
> > 5.1. Create a file from 0:0 through the idmapped mount (it should
> > appear as 1000:1000 on disk)
> > root@ubuntu:/home/ubuntu# sudo -u#0 -g#0 touch
> > /mnt/ceph_idmapped/created_through_idmapped_mnt_with_uid0
> >
> > 5.2. Create a file from 1000:1000 through the idmapped mount (should
> > fail because 1000:1000 is not a valid UID/GID as it can't be mapped
> > back to the "on-disk" UID/GID set).
> > root@ubuntu:/home/ubuntu# sudo -u#1000 -g#1000 touch
> > /mnt/ceph_idmapped/created_through_idmapped_mnt_with_uid1000
> > touch: cannot touch
> > '/mnt/ceph_idmapped/created_through_idmapped_mnt_with_uid1000': Value
> > too large for defined data type
> >
> > ... and we've got EOVERFLOW. That's correct!
> >
> > 5.3. Create a file from 0:0 but through the regular mount. (it should
> > appear as overflowuid(=3D65534) in idmapped mount, because 0:0 on-disk
> > is not mapped to the UID/GID set).
> >
> > root@ubuntu:/home/ubuntu# sudo -u#0 -g#0 touch
> > /mnt/ceph/created_directly_with_uid0
> >
> > 5.4. Create a file from 1000:1000 but through the regular mount. (it
> > should appear as 0:0 in idmapped mount, because 1000 (on-disk) mapped
> > to 0).
> >
> > root@ubuntu:/home/ubuntu# sudo -u#1000 -g#1000 touch
> > /mnt/ceph/created_directly_with_uid1000
> >
> > 6. Now let's look on the result:
> >
> > root@ubuntu:/home/ubuntu# ls -lan /mnt/ceph
> > total 4
> > drwxrwxrwx 2 1000 1000    3 Jun  1 17:54 .
> > drwxr-xr-x 4    0    0 4096 Jun  1 16:55 ..
> > -rw-r--r-- 1    0    0    0 Jun  1 17:54 created_directly_with_uid0
> > -rw-rw-r-- 1 1000 1000    0 Jun  1 17:54 created_directly_with_uid1000
> > -rw-r--r-- 1 1000 1000    0 Jun  1 17:53 created_through_idmapped_mnt_w=
ith_uid0
> >
> > root@ubuntu:/home/ubuntu# ls -lan /mnt/ceph_idmapped
> > total 4
> > drwxrwxrwx 2     0     0    3 Jun  1 17:54 .
> > drwxr-xr-x 4     0     0 4096 Jun  1 16:55 ..
> > -rw-r--r-- 1 65534 65534    0 Jun  1 17:54 created_directly_with_uid0
> > -rw-rw-r-- 1     0     0    0 Jun  1 17:54 created_directly_with_uid100=
0
> > -rw-r--r-- 1     0     0    0 Jun  1 17:53
> > created_through_idmapped_mnt_with_uid0
> >
> >>> If you create a file from a user with UID 0 then you will get UID 100=
0
> >>> on disk. To achieve that, we map a current user fs{g,u}id
> >>> when sending a creation request according to the idmapping mount to
> >>> make things consistent.
> >> As you know the cephfs MDSs will use the creation requests' caller UID
> >> as the owner's UID when creating new inodes.
> > Yes, that's why we have to map a caller UID to end up with the correct
> > value of a file owner.
> >
> Hmm, I think my understanding was incorrect. This patch here is trying
> to get the correct value of UID 1000 from a mapped mount, which the UID 0=
.
>
>
> >> Which means that if the creation requests switches to use the mapped U=
ID
> >> 0 as the caller UID then the file's owner will be UID 0 instead of UID
> >> 1000 in cephfs MDSs. Does this what this patch want to do ?
> > In my example we have a caller with UID equal 0, then the mapped UID
> > will be 1000. So, the file will be created with UID =3D 1000.
>
> Okay, thanks for your above example it helped me to understand the idmap
> logic. Before I tried to read the xfstests test cases and VFS code about
> the idmap but didn't totally done yet.

Yeah, it's not trivial (especially when it's combined with a network
filesystem ;-) ).
But Christian had written a good documentation about mount idmappings:
https://github.com/torvalds/linux/blob/master/Documentation/filesystems/idm=
appings.rst

>
> I will test and review the patches again today or next week.

Huge thanks, Xiubo!

>
> Thanks
>
> - Xiubo
>
> >>
> >>>    But when a user opens a file,
> >>> we are sending UID/GID as they are without applying an idmapping.
> >> If my understanding is correct above, then when opening the file with
> >> non-mapped UID 1000 it may fail because the files' owner is UID 0.
> >>
> >> Correct me if my understanding is wrong.
> >>
> >>>    Of
> >>> course, generic_permission() kernel helper is aware of
> >>> mount idmapping
> >> Yeah, this was also what I thought it should be.
> >>
> >> There is another client auth feature [1] for cephfs. The MDS will allo=
w
> >> us to set a path restriction for specify UID, more detail please see [=
2]:
> >>
> >>    allow rw path=3D/dir1 uid=3D1000 gids=3D1000
> >>
> >> This may cause the creation requests to fail if you set the caller UID
> >> to the mapped UID.
> > Yes, that can be a problem of course. But it will only affect users
> > who want to use this feature and it doesn't open any security holes.
> > It's just a limitation of this approach. Unfortunately it's barely
> > fixable without massive VFS changes and until we have no real use
> > cases
> > for this combination of idmapped mounts + MDS UID/GID-based path
> > restriction we are not sure that it makes sense to implement this
> > right now.
> >
> >>
> >> [1] https://docs.ceph.com/en/latest/cephfs/client-auth/
> >> [2] https://tracker.ceph.com/issues/59388
> > Thanks, I'll take a look closer at that!
> >
> > Thanks for closely looking into this patchset, Xiubo!
> >
> > Kind regards,
> > Alex
> >
> >>
> >> Thanks
> >>
> >> - Xiubo
> >>
> >>> and before open request will go to the server we will
> >>> check that current user is allowed to open this file (and during
> >>> this check UID/GID of a current user and UID/GID of the file owner
> >>> will be properly compared). I.e. this issue is only relevant for the
> >>> case
> >>> when we have additional permission checks on the network file system
> >>> server side.
> >>>
> >>>> IMO the idmapping should be client-side feature and we should make i=
t
> >>>> consistent by using the unmapped fs{g,u}id always here.
> >>> To make the current user fs{g,u}id always idmapped we need to make
> >>> really big changes in the VFS layer. And it's not obvious
> >>> that it justifies the cost. Because this particular feature with
> >>> Cephfs idmapped mounts is already used/tested with LXD/LXC workloads
> >>> and it works perfectly well. And as far as I know, LXD/LXC were the
> >>> first idmapped mount adopters. IMHO, it's better to
> >>> start from this approach and if someone will want to extend this
> >>> functionality for network filesystems and want to map fs{g,u}id which
> >>> are sent over the
> >>> wire we will take a look at that. Because anyway, integration with
> >>> Cephfs is important for the LXD project and we are looking closely at
> >>> this.
> >>>
> >>> Kind regards,
> >>> Alex
> >>>
> >>>> Thanks
> >>>>
> >>>> - Xiubo
> >>>>
> >>>>>         head->ino =3D cpu_to_le64(req->r_deleg_ino);
> >>>>>         head->args =3D req->r_args;
> >>>>>
>
