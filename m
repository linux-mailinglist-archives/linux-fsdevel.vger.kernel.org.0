Return-Path: <linux-fsdevel+bounces-6815-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC0BE81D2AC
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Dec 2023 07:23:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37FAA1F232B7
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Dec 2023 06:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6C1963D8;
	Sat, 23 Dec 2023 06:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IIwIPu+P"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B31806108;
	Sat, 23 Dec 2023 06:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-67ad5b37147so15735456d6.2;
        Fri, 22 Dec 2023 22:22:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703312573; x=1703917373; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jdy/jEn9rjZcaWc0z9psfXWLkfhGOHPMtnjcr7zVpzU=;
        b=IIwIPu+PYig4tyOMnrbHImJ0UskE9ErNvbau7MWH42zYCTarZTEj3lE6vrtrq4Onau
         JpIdYF2GYTqsEs2XhNQAkWIi/2NK843GjQvHhD58mOkz9y51nlBoWMXJ/YKr8RMr7uxQ
         78nCrOsyaSLy9zMXDF8uEeh19Ye4jykZah+9f1i0WGL7b0LIRZX8FW8MKasy5DLjDIf9
         f80ZJ7FW9/V6UIfGSNIQkLYSOXHT3x33ej44UWXrdRG331vFrxHf3ZOfCsSn+8IUj3pN
         9G56HVy7TYSXnqoBrav8Wlv5LcXkR+A16Vum+CEbNJKphYa/mOkPTk3EFHsejAHMYhWh
         um+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703312573; x=1703917373;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jdy/jEn9rjZcaWc0z9psfXWLkfhGOHPMtnjcr7zVpzU=;
        b=vuBxtgxZyKqthX2V43f6GtRPGkam9aPI/GsfC23EagdRWMHDsiEEttWxZHjHOOo166
         /ngBrUvbELcBEWCI3yO3L7bYmquHyqJ8FTx8RITNW6OEkKamkJWUMhAqGFRRlvvqxJTR
         89B/wLjmxTHeq8jwwidEWAYF0k2f2ykVBFgQdncX9zdJfSkVPElIP9OPxWgj7OiE3FSn
         JAjxY/zaiuBlZ+4Zmyi7VdiYwLw1HhAC5sCK94zIJeK2eeEvE9mPKQ+c3VcjnDl2tRbw
         TuCoXaM7GofOb5o9o/CaGzjji7RZh8tMUR9oJyHAKo0LGGiMrGyHOZJGQ0wxdknLWHGE
         sBZg==
X-Gm-Message-State: AOJu0YyTlc1N/VzNvmR1vsOZ0zezaExbu17OBAFl4VIYl2jRnknCQGAl
	q1iO604DzTrlHDPez0VNvo3bjaORBdAqDAisZ8U=
X-Google-Smtp-Source: AGHT+IEbpHx0UjQt0tA2wOgdSg4sPIFGOPPWcYwiG8Jt0Z/j1OXlw5MMd1Q0/mII/unVN8S7cWkwBlwQ5BFmKEWEb74=
X-Received: by 2002:ad4:5c83:0:b0:67f:568d:2914 with SMTP id
 o3-20020ad45c83000000b0067f568d2914mr4869054qvh.46.1703312573502; Fri, 22 Dec
 2023 22:22:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231215211608.6449-1-krisman@suse.de> <20231219231222.GI38652@quark.localdomain>
 <87a5q1eecy.fsf_-_@mailhost.krisman.be> <CAOQ4uxjhWPB6W+EFyuE-eYbLHehOGRLSfs6K62+h8-f9izJG-A@mail.gmail.com>
In-Reply-To: <CAOQ4uxjhWPB6W+EFyuE-eYbLHehOGRLSfs6K62+h8-f9izJG-A@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sat, 23 Dec 2023 08:22:42 +0200
Message-ID: <CAOQ4uxgiZwQf9cHn6p5j6FFO4Hre4dJF1a-7ss+6A64hFJPt2g@mail.gmail.com>
Subject: Re: [PATCH] ovl: Reject mounting case-insensitive filesystems
To: Gabriel Krisman Bertazi <krisman@suse.de>
Cc: Eric Biggers <ebiggers@kernel.org>, viro@zeniv.linux.org.uk, jaegeuk@kernel.org, 
	tytso@mit.edu, linux-f2fs-devel@lists.sourceforge.net, 
	linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	overlayfs <linux-unionfs@vger.kernel.org>, Miklos Szeredi <miklos@szeredi.hu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

[CC: overlayfs]

On Sat, Dec 23, 2023 at 8:20=E2=80=AFAM Amir Goldstein <amir73il@gmail.com>=
 wrote:
>
> On Sat, Dec 23, 2023 at 6:23=E2=80=AFAM Gabriel Krisman Bertazi <krisman@=
suse.de> wrote:
> >
> > Eric Biggers <ebiggers@kernel.org> writes:
> >
> > > On Fri, Dec 15, 2023 at 04:16:00PM -0500, Gabriel Krisman Bertazi wro=
te:
> > >> [Apologies for the quick spin of a v2.  The only difference are a co=
uple
> > >> fixes to the build when CONFIG_UNICODE=3Dn caught by LKP and detaile=
d in
> > >> each patch changelog.]
> > >>
> > >> When case-insensitive and fscrypt were adapted to work together, we =
moved the
> > >> code that sets the dentry operations for case-insensitive dentries(d=
_hash and
> > >> d_compare) to happen from a helper inside ->lookup.  This is because=
 fscrypt
> > >> wants to set d_revalidate only on some dentries, so it does it only =
for them in
> > >> d_revalidate.
> > >>
> > >> But, case-insensitive hooks are actually set on all dentries in the =
filesystem,
> > >> so theandand natural place to do it is through s_d_op and let d_allo=
c handle it [1].
> > >> In addition, doing it inside the ->lookup is a problem for case-inse=
nsitive
> > >> dentries that are not created through ->lookup, like those coming
> > >> open-by-fhandle[2], which will not see the required d_ops.
> > >>
> > >> This patchset therefore reverts to using sb->s_d_op to set the dentr=
y operations
> > >> for case-insensitive filesystems.  In order to set case-insensitive =
hooks early
> > >> and not require every dentry to have d_revalidate in case-insensitiv=
e
> > >> filesystems, it introduces a patch suggested by Al Viro to disable d=
_revalidate
> > >> on some dentries on the fly.
> > >>
> > >> It survives fstests encrypt and quick groups without regressions.  B=
ased on
> > >> v6.7-rc1.
> > >>
> > >> [1] https://lore.kernel.org/linux-fsdevel/20231123195327.GP38156@Zen=
IV/
> > >> [2] https://lore.kernel.org/linux-fsdevel/20231123171255.GN38156@Zen=
IV/
> > >>
> > >> Gabriel Krisman Bertazi (8):
> > >>   dcache: Add helper to disable d_revalidate for a specific dentry
> > >>   fscrypt: Drop d_revalidate if key is available
> > >>   libfs: Merge encrypted_ci_dentry_ops and ci_dentry_ops
> > >>   libfs: Expose generic_ci_dentry_ops outside of libfs
> > >>   ext4: Set the case-insensitive dentry operations through ->s_d_op
> > >>   f2fs: Set the case-insensitive dentry operations through ->s_d_op
> > >>   libfs: Don't support setting casefold operations during lookup
> > >>   fscrypt: Move d_revalidate configuration back into fscrypt
> > >
> > > Thanks Gabriel, this series looks good.  Sorry that we missed this wh=
en adding
> > > the support for encrypt+casefold.
> > >
> > > It's slightly awkward that some lines of code added by patches 5-6 ar=
e removed
> > > in patch 8.  These changes look very hard to split up, though, so you=
've
> > > probably done about the best that can be done.
> > >
> > > One question/request: besides performance, the other reason we're so =
careful
> > > about minimizing when ->d_revalidate is set for fscrypt is so that ov=
erlayfs
> > > works on encrypted directories.  This is because overlayfs is not com=
patible
> > > with ->d_revalidate.  I think your solution still works for that, sin=
ce
> > > DCACHE_OP_REVALIDATE will be cleared after the first call to
> > > fscrypt_d_revalidate(), and when checking for usupported dentries ove=
rlayfs does
> > > indeed check for DCACHE_OP_REVALIDATE instead of ->d_revalidate direc=
tly.
> > > However, that does rely on that very first call to ->d_revalidate act=
ually
> > > happening before the check is done.  It would be nice to verify that
> > > overlayfs+fscrypt indeed continues to work, and explicitly mention th=
is
> > > somewhere (I don't see any mention of overlayfs+fscrypt in the series=
).
> >
> > Hi Eric,
> >
> > From my testing, overlayfs+fscrypt should work fine.  I tried mounting
> > it on top of encrypted directories, with and without key, and will add
> > this information to the commit message.  If we adopt the suggestion fro=
m
> > Al in the other subthread, even better, we won't need the first
> > d_revalidate to happen before the check, so I'll adopt that.
> >
> > While looking into overlayfs, I found another reason we would need this
> > patchset.  A side effect of not configuring ->d_op through s_d_op is
> > that the root dentry won't have d_op set.  While this is fine for
> > casefold, because we forbid the root directory from being
> > case-insensitive, we can trick overlayfs into mounting a
> > filesystem it can't handle.
> >
> > Even with this merged, and as Christian said in another thread regardin=
g
> > ecryptfs, we should handle this explicitly.  Something like below.
> >
> > Amir, would you consider this for -rc8?
>
> IIUC, this fixes a regression from v5.10 with a very low likelihood of
> impact on anyone in the real world, so what's the rush?
> I would rather that you send this fix along with your patch set.
>
> Feel free to add:
>
> Acked-by: Amir Goldstein <amir73il@gmail.com>
>
> after fixing nits below
>
> >
> > -- >8 --
> > Subject: [PATCH] ovl: Reject mounting case-insensitive filesystems
> >
> > overlayfs relies on the filesystem setting DCACHE_OP_HASH or
> > DCACHE_OP_COMPARE to reject mounting over case-insensitive directories.
> >
> > Since commit bb9cd9106b22 ("fscrypt: Have filesystems handle their
> > d_ops"), we set ->d_op through a hook in ->d_lookup, which
> > means the root dentry won't have them, causing the mount to accidentall=
y
> > succeed.
> >
> > In v6.7-rc7, the following sequence will succeed to mount, but any
> > dentry other than the root dentry will be a "weird" dentry to ovl and
> > fail with EREMOTE.
> >
> >   mkfs.ext4 -O casefold lower.img
> >   mount -O loop lower.img lower
> >   mount -t overlay -o lowerdir=3Dlower,upperdir=3Dupper,workdir=3Dwork =
ovl /mnt
> >
> > Mounting on a subdirectory fails, as expected, because DCACHE_OP_HASH
> > and DCACHE_OP_COMPARE are properly set by ->lookup.
> >
> > Fix by explicitly rejecting superblocks that allow case-insensitive
> > dentries.
> >
> > Fixes: bb9cd9106b22 ("fscrypt: Have filesystems handle their d_ops")
> > Signed-off-by: Gabriel Krisman Bertazi <krisman@suse.de>
> > ---
> >  fs/overlayfs/params.c | 2 ++
> >  include/linux/fs.h    | 9 +++++++++
> >  2 files changed, 11 insertions(+)
> >
> > diff --git a/fs/overlayfs/params.c b/fs/overlayfs/params.c
> > index 3fe2dde1598f..99495f079644 100644
> > --- a/fs/overlayfs/params.c
> > +++ b/fs/overlayfs/params.c
> > @@ -286,6 +286,8 @@ static int ovl_mount_dir_check(struct fs_context *f=
c, const struct path *path,
> >         if (!d_is_dir(path->dentry))
> >                 return invalfc(fc, "%s is not a directory", name);
> >
>
> Please add a comment to explain why this is needed to prevent post
> mount lookup failures.
>
> > +       if (sb_has_encoding(path->mnt->mnt_sb))
> > +               return invalfc(fc, "caseless filesystem on %s not suppo=
rted", name);
> >
>
> I have not seen you use the term "caseless" on the list since 2018. old h=
abits?
> Please use the term "case-insensitive" and please move the
> ovl_dentry_weird() check
> below this one, because when trying to mount overlayfs over non-root
> case-insensitive
> directory, the more specific error message is more useful.
>
> Thanks,
> Amir.

