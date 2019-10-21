Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA701DF75D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Oct 2019 23:15:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387407AbfJUVPf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Oct 2019 17:15:35 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38122 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726672AbfJUVPf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Oct 2019 17:15:35 -0400
Received: by mail-pf1-f195.google.com with SMTP id h195so9198390pfe.5
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Oct 2019 14:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=2zZijyR1tbxwrYU8/3LWiEppTIlZzmqBCYho/vuKvDo=;
        b=Gs5GzaIM21KWYG4ym9Azfki+CJkUlEeo/6P8Ltns/MFlXgUe/SgXVvg5r4YGfrjreU
         v2+l48WqggGPPtLrclRZrAvduyIOtUvpAuUs0Mj/dskrK5Rs7fRrXvU8pdL8eHNQy7Gc
         NA7wggi06ithDO38yvKmlPBxbaJWOnIb1R5JZvGcM/WScrP7Py9J0hjRemQWoMzh+bHU
         Lzle9BBojDnYGxak4e2A557RHisK8Ic/rfaKezzi8vF0hcYFiyN+eiwjV4NfCb9I4jyE
         Hxuxu+Y0hrFC0lsl2QBYhZaD2uL+Yb44ksIalRGVwYW+OKpnxcvjQsAL38k+yKRcf7T7
         JuDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=2zZijyR1tbxwrYU8/3LWiEppTIlZzmqBCYho/vuKvDo=;
        b=QUm1E3qAzBsoRJwAW0U0DJUHsq34589pR4OOszO2NcMympuVIDG0h4YqIYMFJ4x0AP
         YDjfM/ra80oUKHOGhjsUXt6NC3Mj+0xSG+F3RS6jXj0UuJl/cWd9dBYLEAJE/FOIRz6t
         pw4kVqZ8sljzoyCYoHcOc0GU2BVfOcsWlxMsE0mmX8sG7eDzYfNAw2mLG8ooLve2yMe8
         WfvCT6G3KVpV8NHF2LzxzAPLVtSF57/mGk6QuWj03MTOSPXXKiMXtoyWNrdsuy+t4UCP
         FghKkLmQqwj8/DNcS6yDcuGJAov8sGAPKt2k0opH217PgODOV9DjIfNyB+9lbjGu/otH
         U8jw==
X-Gm-Message-State: APjAAAUd8X6MxwzgYWvw6Kf6Lr4YYVtH9pq9ZjyPfDCRHZoe7ZFf4jsE
        GIo2jhZXUrOwgEAPiQd8uiV1QQ==
X-Google-Smtp-Source: APXvYqzIGPZjoinyyG+4nNI0vLuGctafWPGtmUkw9gkpxdUrmJ/ctp/MgLWGrnHaqshJejutNvfcCg==
X-Received: by 2002:a62:1dd2:: with SMTP id d201mr85780pfd.105.1571692534156;
        Mon, 21 Oct 2019 14:15:34 -0700 (PDT)
Received: from cabot-wlan.adilger.int (S0106a84e3fe4b223.cg.shawcable.net. [70.77.216.213])
        by smtp.gmail.com with ESMTPSA id f89sm15373119pje.20.2019.10.21.14.15.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Oct 2019 14:15:33 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <A501A3E0-1823-41CE-97ED-4C64BE98FAE7@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_B8678ABD-0286-49ED-AC1A-6FA16949963C";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [Project Quota]file owner could change its project ID?
Date:   Mon, 21 Oct 2019 15:15:31 -0600
In-Reply-To: <20191020222529.GA6799@mit.edu>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        Wang Shilong <wangshilong1991@gmail.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Li Xi <lixi@ddn.com>, Wang Shilong <wshilong@ddn.com>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
References: <CAP9B-QmQ-mbWgJwEWrVOMabsgnPwyJsxSQbMkWuFk81-M4dRPQ@mail.gmail.com>
 <20191013164124.GR13108@magnolia>
 <CAP9B-Q=SfhnA6iO7h1TWAoSOfZ+BvT7d8=OE4176FZ3GXiU-xw@mail.gmail.com>
 <20191016213700.GH13108@magnolia>
 <648712FB-0ECE-41F4-B6B8-98BD3168B2A4@dilger.ca>
 <20191017121251.GB25548@mit.edu>
 <6F46FB6C-D1E3-4BB8-B150-B229801EE13B@dilger.ca>
 <20191020222529.GA6799@mit.edu>
X-Mailer: Apple Mail (2.3273)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--Apple-Mail=_B8678ABD-0286-49ED-AC1A-6FA16949963C
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Oct 20, 2019, at 4:25 PM, Theodore Y. Ts'o <tytso@mit.edu> wrote:
>=20
> On Sun, Oct 20, 2019 at 02:19:19PM -0600, Andreas Dilger wrote:
>>> We could also solve the problem by adding an LSM hook called when
>>> there is an attempt to set the project ID, and for people who really
>>> want this, they can create a stackable LSM which enforces whatever
>>> behavior they want.
>>=20
>> So, rather than add a few-line change that decides whether the user
>> is allowed to change the projid for a file, we would instead add =
*more*
>> lines to add a hook, then have to write and load an LSM that is =
called
>> each time?  That seems backward to me.
>=20
> I'm just not sure we've necessarily gotten the semantics right.  For
> example, I could easily see someone else coming out of the woodwork
> saying that The Right Model (tm) is one where users belong to a number
> of projects (much like supplementary group ID's) and you should be
> able to set the project of any file that you own to a project.

Definitely I've thought of that kind of behavior, but it needs a much =
larger
change, and is not clear that anyone actually needs this yet.  It is not
incompatible with the "add an option for root-only (or specific =
GID-only)
'setprojid' permission", but rather would be an enhancement that could =
be
added after the fact (there is no need for it with the "free for all" =
today).
However, I'm uncertain whether any benefit would be had from =
"supplementary
projid" support as you describe or not.

If a user has write permission in a target directory with a different =
projid
then they can easily (with "mv" handling the EXDEV case automatically) =
move
files from a source projid to a target projid by copying the data =
through
userspace.  In this respect, I wonder why ext4 enforces the "can't =
rename
to a target directory with a different projid" restriction that XFS has? =
 It
seems possible (very beneficial even) to change the projid in ext4 when =
a
file is renamed to a different directory, rather than forcing a =
full-file
copy in userspace, which can be very slow if the file is large.

Essentially the permission check for rename() could become "if user has =
write
permission in the target directory with a different projid, then allow =
the
change" since they could just as easily bypass the permissions in =
userspace.

According to Dave's original post this is an "XFS implementation =
detail":
https://www.spinics.net/lists/linux-ext4/msg44738.html

    XFS doesn't transfer the quota from projid to projid because it's
    borderline impossible to correctly track all the metadata
    allocation/free operations that can happen in a rename operation and
    account them to the correct quota. Hence all those corner cases are
    avoided by treating it as EXDEV and forcing userspace to cp/unlink
    the files rather than rename.

    That's really an implementation detail.

If we don't have this problem in ext4 then we don't need to return =
-EXDEV.

However, that is digressing from the original point of "restrict =
permission"
rather than "allow for rename".

> Or perhaps the policy is that you can only change the project ID if
> the project ID has a non-zero project quota.  etc.
>=20
>>> If we think this going to be an speciality request, this might be =
the
>>> better way to go.
>>=20
>> I don't see how this is more "speciality" than regular quota =
enforcement?
>> Just like we impose limits on users and groups, it makes sense to =
impose
>> a limit on a project, instead of just tracking it and then having to =
add
>> extra machinery to impose the limit externally.
>=20
> We *do* have regular quota enforcement.  The question here has nothing
> to do with how quota tracking or enforcement work.  The question is
> about what are the authorization checks and policy surrounding when
> the project ID can modified.

>=20
> Right now the policy is "the owner of the file can set the project ID
> to any integer if it is issued from the initial user namespace;
> otherwise, no changes to the project ID or the PROJINHERIT flag is
> allowed".

IMHO, if any user can arbitrarily change the projid of a file, that =
prevents
effective project quota enforcement.

> Making it be "only root in the inital user namespace is allowed change
> project ID or PROJINHERIT flag" is certain an alternate policy.  Are
> we sure those are the only two possible policies that users might ask
> for?

No, but at the risk of bike-shedding this too much in advance of actual =
user
need for a more complex mechanism, preventing users from arbitrarily =
shedding
quota to other projects seems very useful.  The restrictive and =
traditional
method is to allow only root (uid=3D=3D0) to do this, but modern systems =
try to
avoid this by using e.g. CAP_SYS_RESOURCE (which is used for other quota
changes).  A slightly more flexible method would be to allow a group =
(e.g.
"wheel" or "admin") to also control project IDs for files/directories.  =
This
would default to GID=3D0 to start (root only), or could default to =
GID=3D-1 (any
group can change) to match the current behavior.  Defaulting to GID=3D-1 =
would
have the benefit that the mechanism for restricting "setprojid" could be =
added
but keep the same behavior as today, but make it easy to change if =
desired.

Cheers, Andreas






--Apple-Mail=_B8678ABD-0286-49ED-AC1A-6FA16949963C
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl2uH/MACgkQcqXauRfM
H+DL7w/9G+YRn/3hv5n1YlJBja+m3f2RsOrrUaTdWYq46bEfFe/MfWLOIf/QhHqG
iU2EFACPagHUFlfmh4P0pb8y3kBpGc1e8sETVAfxyGbOMr+tQ+aGBk3ASUMMFU04
2jgT74+EjZHwBSbRVJu42GhGTBT76jDF1Yx/rJ5ZqFlOGNraUO2kURGeCJyN2Wf4
slHdF2Lw7Eq55SnynSNfSE+o9tA7dmrovpCl2XeuC55O/nGhIilhrNgR2ItvXzup
cM8wjMpxv+9y9A+yqZMO3MTmDVGOMcfCeGNcJPn4DFeD6VUq1AaAqBqqiqDNhZuG
Kce/rTbg98Impwl+ixvLAC/gkP8xcJRk3Gh0OeQKeqrmcA8KjbH5PgBNz19PdirA
BJ0J/piPxqF9zE7mWNKtrylAfuJ8zLmSKjXpDWtuuQFMbkzQf2MehCZURsEK5aBH
s3FQSY4PDr5VGTMf+RtKd0+C1cST0OwEaWwf1tX5ftzmdGtH2/gfMNjyrxgzfWUT
Qjzg0wSfDVpMYZfe3RrNxetCwHR8OikAmiMd5iiUwzOdOtXFn9aZXM3NBQc2bCQ1
f+O1i22sQjSsBaqjctnXNHs2Kvvu/vs5neHLk9GE4kd22uE9+UR+yoZX8ZQvYgBV
BX+2wjBCcJg0s7+UVsNICqIeaMGFULpmUR1SkC3udr6ReuE+BQI=
=6IVn
-----END PGP SIGNATURE-----

--Apple-Mail=_B8678ABD-0286-49ED-AC1A-6FA16949963C--
