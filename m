Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56E9C6E174C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Apr 2023 00:25:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbjDMWZP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Apr 2023 18:25:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjDMWZO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Apr 2023 18:25:14 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05B9683DB
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Apr 2023 15:25:12 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id v9so21991370pjk.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Apr 2023 15:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20221208.gappssmtp.com; s=20221208; t=1681424711; x=1684016711;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=UE9pw/25DICsCap5W2dQF5Wx4YeJB8skavcxU8NkTRw=;
        b=m9iGOz1Ofvf28CCNygZDIpKU3eTeMyy9/aNE3DKpUQWp83aCRtNyrJOd08Kh/YJDsM
         eOyKEb2sXDyjvDr+mLepf3zavW8W3xQpkdZQJfO1jPsrR258EVBS0wImn3GSGMQfB95t
         9aPhHwUUyGawdhrm/+kR8+GlN41PXGmo9aWUPQObxaogNDppBkE+/nNX+wbJcz4F1S0p
         15rf/aTwTBsGbaRYwWVhnZogs2XWnVPZk6Ny1Kq4d1lIEPeBeUr2PNMZghaLlKkyCkYo
         XHFhfV3lsc4z7+ntAAAiKivHOWviCY5CLvVr/ScYNbBh4bv/+Mph66/gv7Lpb/Temcj4
         kvPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681424711; x=1684016711;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UE9pw/25DICsCap5W2dQF5Wx4YeJB8skavcxU8NkTRw=;
        b=AYO8AAd5y55X0jX70Yu0FbxEmnePAvVfQ1durEqqX8bi3d0TZcCfLX6ulOkpwynCJQ
         tmKY8LPJhU/78URj60T6vc+3Uf2iJyxlV3IpQCbp8KuyIWup+hpgUniiz517x/a5AcZM
         sUuEckRoqHd0eWFbxlbzjeugL6bJwYAavsoJvZ94fkEDp5xSqljmSArO+KNXQQXNuz+8
         5goGUCBq9r18NwMtDmPlzegE63/ZJmAvoF5c0FKeoBhuq4CcLgDBYugBxXtdrlY1VJTI
         b4Bc/Z7udPsvy09rURmUGbIRaYMxeU9ElAOIt9bZKrRYexsOB82pEzBrnNhLOlGVP6vw
         hHiQ==
X-Gm-Message-State: AAQBX9fDPs2gZRkHtBRGq3cprAjZOPGozpXoPwIpcPYLvTfnQC8hgSLO
        +L24+zq1Qf62c5BpGJdGCLksEg==
X-Google-Smtp-Source: AKy350aGwgw4mfUSJN5T+Cz9AkadUrE5Ro8GAFgj9J8O+SqZdGVbLLU4GyarulvXu+hBM858vGyPZQ==
X-Received: by 2002:a17:902:fa04:b0:1a2:8940:6db8 with SMTP id la4-20020a170902fa0400b001a289406db8mr368725plb.69.1681424711421;
        Thu, 13 Apr 2023 15:25:11 -0700 (PDT)
Received: from cabot.adilger.int (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id c3-20020a170902aa4300b0019aaab3f9d7sm1936768plr.113.2023.04.13.15.25.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Apr 2023 15:25:10 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <36DC40CE-87DB-4395-80E1-052FFA29D01A@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_208EE4D6-7E84-4809-B4B9-C0C1086C49C0";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: allowing for a completely cached umount(2) pathwalk
Date:   Thu, 13 Apr 2023 16:25:05 -0600
In-Reply-To: <95ee689c76bf034fa2fe9fade0bccdb311f3a04f.camel@kernel.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Dave Wysochanski <dwysocha@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-nfs <linux-nfs@vger.kernel.org>,
        David Howells <dhowells@redhat.com>, NeilBrown <neilb@suse.de>,
        Christoph Hellwig <hch@lst.de>
To:     Jeff Layton <jlayton@kernel.org>
References: <95ee689c76bf034fa2fe9fade0bccdb311f3a04f.camel@kernel.org>
X-Mailer: Apple Mail (2.3273)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--Apple-Mail=_208EE4D6-7E84-4809-B4B9-C0C1086C49C0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Apr 13, 2023, at 4:00 PM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> David Wysochanski posted this a week ago:
>=20
>    =
https://lore.kernel.org/linux-nfs/CALF+zOnizN1KSE=3DV095LV6Mug8dJirqk7eN1j=
oX8L1-EroohPA@mail.gmail.com/
>=20
> It describes a situation where there are nested NFS mounts on a =
client,
> and one of the intermediate mounts ends up being unexported from the
> server. In a situation like this, we end up being unable to pathwalk
> down to the child mount of these unreachable dentries and can't =
unmount
> anything, even as root.
>=20
> A decade ago, we did some work to make the kernel not revalidate the
> leaf dentry on a umount [1]. This helped some similar sorts of =
problems
> but it doesn't help if the problem is an intermediate dentry.
>=20
> The idea at the time was that umount(2) is a special case: We are
> specifically looking to stop using the mount, so there's nothing to be
> gained by revalidating its root dentry and inode.
>=20
> Based on the problem Dave describes, I'd submit that umount(2) is
> special in another way too: It's intended to manipulate the mount =
table
> of the local host, so contacting the backing store (the NFS server in
> this case) during a pathwalk doesn't really help anything. All we care
> about is getting to the right spot in the mount tree.
>=20
> A "modest" proposal:
> --------------------
> This is still somewhat handwavy, but what if we were to make umount(2)
> an even more special case for the pathwalk? For the umount(2) =
pathwalk,
> we could:
>=20
> 1/ walk down the dentry tree without calling ->d_revalidate: We don't
> care about changes that might have happened remotely. All we care =
about
> is walking down the cached dentries as they are at that moment.
>=20
> 2/ disallow ->lookup operations: a umount is about removing an =
existing
> mount, so the dentries had better already be there.
>=20
> 3/ skip inode ->permission checks. We don't want to check with the
> server about our permission to walk the path when we're looking to
> unmount. We're walking down the path on the _local_ machine so we can
> unuse it. The server should have no say-so in the matter. (We probably
> would want to require CAP_SYS_ADMIN or CAP_DAC_READ_SEARCH for this of
> course).
>=20
> We might need other safety checks too that I haven't considered yet.
>=20
> Is this a terrible idea? Are there potentially problems with
> containerized setups if we were to do something like this? Are there
> better ways to solve this problem (and others like it)? Maybe this =
would
> be best done with a new UMOUNT_CACHED flag for umount2()?
> --
> [1] 8033426e6bdb vfs: allow umount to handle mountpoints without
> revalidating them

This would be great.  This has been a problem when unmounting the
filesystem ever since "umount" was changed to stat() the mountpoint
by path before unmount, added in util-linux 2.19 (FC15, el7, SLES12).

Cheers, Andreas






--Apple-Mail=_208EE4D6-7E84-4809-B4B9-C0C1086C49C0
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmQ4gUIACgkQcqXauRfM
H+Bddg/9GzEeFBVgnT2Z4Ej9FZsg84QM2l11xydLLLeC541se7aSYhDBDTen/UMA
HFetu21BPEfdVYii4DpIx1QnIU5dTcWwJZJpMAs17UNrPfINSCmN5X2v2/PPcwFq
Ckzzu5pZlTvasxPpzHY6EBIDrNXHPCtShTA41zIX/fV54FSmPoNcJ3yxLDYIISUg
PEFkbUM9tGwcarhRXRVFw1U9cmNZqfqt+VmGzS58jwkGANSg7h5pUHdIe/gLmxgH
5E+LieuEhvLdmMcwXMOXjh0ixpbsO8tnvSWewcah7luhJ4+GDxUySed3ewIgT7Zh
awPyHsV40dHLS6MWl2qG0+7tB4D8Ns/Crswtk0pYtmWbyYngSyuqXzB0le95us9J
8gmObgyAlUFXwnFVg1TPTXlIz/ZofnaA1PIIiAaOH8Hv5OuSZ54aJNAyKsE6LY6x
jmB0YEr49w040gVizaSaZkZTaBeRbhmmmt1QRWc3B4E6pCEJaRBTOF/59LzCSb3O
BIospm+k3T2WUljcQHvp9epIJSCM1xx2jpadP904Vz70ySRmfdK15oTmgB8ymydW
FDcxDCS0uuE/br9dk5qYKgCrZfpPX4FuBXNP6G0Wa++7r4iRDm0WEhYbzK7AsLaM
N4HRWAXW9cf1aRBjiW7u+iMgWdtu4yg62YMCvpv49sQr2uIcKhM=
=4KpA
-----END PGP SIGNATURE-----

--Apple-Mail=_208EE4D6-7E84-4809-B4B9-C0C1086C49C0--
