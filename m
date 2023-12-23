Return-Path: <linux-fsdevel+bounces-6814-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B64E881D2A7
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Dec 2023 07:20:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E3F12839AA
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Dec 2023 06:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6C9E8F7E;
	Sat, 23 Dec 2023 06:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UIbLFhXa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C44E18BEC;
	Sat, 23 Dec 2023 06:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-67f47b15fa3so16935516d6.1;
        Fri, 22 Dec 2023 22:20:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703312421; x=1703917221; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j3swqIpA3Pn1kI9NI9NJCq9zWAp1pO/v0osTwtHc8TM=;
        b=UIbLFhXaq0iHhPYMulH6Y0CjhTv8Q9I9wYsqUuUyZnE/o+PiRQ7r9Itoec7IsCMg64
         AuSIdh9Qo9+XIZ9LTNRz59YrsIIseX+RRkXnAvVAKqc2pFkm+TEOYEBcawdn6B+6IlSo
         4O8qQUEgt47jxCT5B0sAQP1ETGdrXJyID5LTdARDdcoz1Ecey0H4GiXIf2wqM0Kyhu6q
         7fE4dBmMsPf6uLPZmnVLClddynCrJDIJiP3wk80Ksj0/1yiarpfDMa+v8ZllItGkrLml
         YaHbSdC1FI+M2NEuEZcJhIuJMWocKU4ES3QpNXlV9uNKhhJkcKXT0Ihugmq+3O8A9RZ7
         OU+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703312421; x=1703917221;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j3swqIpA3Pn1kI9NI9NJCq9zWAp1pO/v0osTwtHc8TM=;
        b=Un0o5hVqQ/J/mtBiBSshNDQijeV69ZGwrUSTbr19MSrfu5RjbY5UBeE13ZTgdhdhpj
         W6AdNp+gzR6TWobVhmLzA2qxAGnEkLQxu561ZTUVWMy9JhsGdM5KjYUPG1IoXOUhg/PW
         wJv8SApEHbfa+GtjLzpMEoyB6QMbU97xve0rZbTz1+EExaAr6OWH3YF7EsgqyNUScpMB
         NBElPjU8NchmyDveD9Y2xCB/l10d29VB+v3MT9xwmYYZJeTaJC9dnG9zdARw1yOKwQml
         Uo82KgYXM/NzwqHweInbp6nCy2uOnXaIrl/KD6dFbDjOaTMlBJbdiVpSwD3iFN3yVZn1
         4CDg==
X-Gm-Message-State: AOJu0YwGV5+90vRBoHF7NYscGV1Z1Rz5LbQ0IlOrG/M9FiN30blrdcY2
	MwRGsRN4nUf8/njlT4qMj8haByUDMIUom7Pb4aE=
X-Google-Smtp-Source: AGHT+IGX+1U3ybuq14sXkiiR2hbRazhcHZ5cQy0wNNwdfonLJ7hFI9WplhjO0FnabReCR3nqtqcPt6rG7Cg5QVkujvI=
X-Received: by 2002:ad4:558f:0:b0:67f:aec9:6929 with SMTP id
 f15-20020ad4558f000000b0067faec96929mr706549qvx.71.1703312421122; Fri, 22 Dec
 2023 22:20:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231215211608.6449-1-krisman@suse.de> <20231219231222.GI38652@quark.localdomain>
 <87a5q1eecy.fsf_-_@mailhost.krisman.be>
In-Reply-To: <87a5q1eecy.fsf_-_@mailhost.krisman.be>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sat, 23 Dec 2023 08:20:09 +0200
Message-ID: <CAOQ4uxjhWPB6W+EFyuE-eYbLHehOGRLSfs6K62+h8-f9izJG-A@mail.gmail.com>
Subject: Re: [PATCH] ovl: Reject mounting case-insensitive filesystems
To: Gabriel Krisman Bertazi <krisman@suse.de>
Cc: Eric Biggers <ebiggers@kernel.org>, viro@zeniv.linux.org.uk, jaegeuk@kernel.org, 
	tytso@mit.edu, linux-f2fs-devel@lists.sourceforge.net, 
	linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 23, 2023 at 6:23=E2=80=AFAM Gabriel Krisman Bertazi <krisman@su=
se.de> wrote:
>
> Eric Biggers <ebiggers@kernel.org> writes:
>
> > On Fri, Dec 15, 2023 at 04:16:00PM -0500, Gabriel Krisman Bertazi wrote=
:
> >> [Apologies for the quick spin of a v2.  The only difference are a coup=
le
> >> fixes to the build when CONFIG_UNICODE=3Dn caught by LKP and detailed =
in
> >> each patch changelog.]
> >>
> >> When case-insensitive and fscrypt were adapted to work together, we mo=
ved the
> >> code that sets the dentry operations for case-insensitive dentries(d_h=
ash and
> >> d_compare) to happen from a helper inside ->lookup.  This is because f=
scrypt
> >> wants to set d_revalidate only on some dentries, so it does it only fo=
r them in
> >> d_revalidate.
> >>
> >> But, case-insensitive hooks are actually set on all dentries in the fi=
lesystem,
> >> so the natural place to do it is through s_d_op and let d_alloc handle=
 it [1].
> >> In addition, doing it inside the ->lookup is a problem for case-insens=
itive
> >> dentries that are not created through ->lookup, like those coming
> >> open-by-fhandle[2], which will not see the required d_ops.
> >>
> >> This patchset therefore reverts to using sb->s_d_op to set the dentry =
operations
> >> for case-insensitive filesystems.  In order to set case-insensitive ho=
oks early
> >> and not require every dentry to have d_revalidate in case-insensitive
> >> filesystems, it introduces a patch suggested by Al Viro to disable d_r=
evalidate
> >> on some dentries on the fly.
> >>
> >> It survives fstests encrypt and quick groups without regressions.  Bas=
ed on
> >> v6.7-rc1.
> >>
> >> [1] https://lore.kernel.org/linux-fsdevel/20231123195327.GP38156@ZenIV=
/
> >> [2] https://lore.kernel.org/linux-fsdevel/20231123171255.GN38156@ZenIV=
/
> >>
> >> Gabriel Krisman Bertazi (8):
> >>   dcache: Add helper to disable d_revalidate for a specific dentry
> >>   fscrypt: Drop d_revalidate if key is available
> >>   libfs: Merge encrypted_ci_dentry_ops and ci_dentry_ops
> >>   libfs: Expose generic_ci_dentry_ops outside of libfs
> >>   ext4: Set the case-insensitive dentry operations through ->s_d_op
> >>   f2fs: Set the case-insensitive dentry operations through ->s_d_op
> >>   libfs: Don't support setting casefold operations during lookup
> >>   fscrypt: Move d_revalidate configuration back into fscrypt
> >
> > Thanks Gabriel, this series looks good.  Sorry that we missed this when=
 adding
> > the support for encrypt+casefold.
> >
> > It's slightly awkward that some lines of code added by patches 5-6 are =
removed
> > in patch 8.  These changes look very hard to split up, though, so you'v=
e
> > probably done about the best that can be done.
> >
> > One question/request: besides performance, the other reason we're so ca=
reful
> > about minimizing when ->d_revalidate is set for fscrypt is so that over=
layfs
> > works on encrypted directories.  This is because overlayfs is not compa=
tible
> > with ->d_revalidate.  I think your solution still works for that, since
> > DCACHE_OP_REVALIDATE will be cleared after the first call to
> > fscrypt_d_revalidate(), and when checking for usupported dentries overl=
ayfs does
> > indeed check for DCACHE_OP_REVALIDATE instead of ->d_revalidate directl=
y.
> > However, that does rely on that very first call to ->d_revalidate actua=
lly
> > happening before the check is done.  It would be nice to verify that
> > overlayfs+fscrypt indeed continues to work, and explicitly mention this
> > somewhere (I don't see any mention of overlayfs+fscrypt in the series).
>
> Hi Eric,
>
> From my testing, overlayfs+fscrypt should work fine.  I tried mounting
> it on top of encrypted directories, with and without key, and will add
> this information to the commit message.  If we adopt the suggestion from
> Al in the other subthread, even better, we won't need the first
> d_revalidate to happen before the check, so I'll adopt that.
>
> While looking into overlayfs, I found another reason we would need this
> patchset.  A side effect of not configuring ->d_op through s_d_op is
> that the root dentry won't have d_op set.  While this is fine for
> casefold, because we forbid the root directory from being
> case-insensitive, we can trick overlayfs into mounting a
> filesystem it can't handle.
>
> Even with this merged, and as Christian said in another thread regarding
> ecryptfs, we should handle this explicitly.  Something like below.
>
> Amir, would you consider this for -rc8?

IIUC, this fixes a regression from v5.10 with a very low likelihood of
impact on anyone in the real world, so what's the rush?
I would rather that you send this fix along with your patch set.

Feel free to add:

Acked-by: Amir Goldstein <amir73il@gmail.com>

after fixing nits below

>
> -- >8 --
> Subject: [PATCH] ovl: Reject mounting case-insensitive filesystems
>
> overlayfs relies on the filesystem setting DCACHE_OP_HASH or
> DCACHE_OP_COMPARE to reject mounting over case-insensitive directories.
>
> Since commit bb9cd9106b22 ("fscrypt: Have filesystems handle their
> d_ops"), we set ->d_op through a hook in ->d_lookup, which
> means the root dentry won't have them, causing the mount to accidentally
> succeed.
>
> In v6.7-rc7, the following sequence will succeed to mount, but any
> dentry other than the root dentry will be a "weird" dentry to ovl and
> fail with EREMOTE.
>
>   mkfs.ext4 -O casefold lower.img
>   mount -O loop lower.img lower
>   mount -t overlay -o lowerdir=3Dlower,upperdir=3Dupper,workdir=3Dwork ov=
l /mnt
>
> Mounting on a subdirectory fails, as expected, because DCACHE_OP_HASH
> and DCACHE_OP_COMPARE are properly set by ->lookup.
>
> Fix by explicitly rejecting superblocks that allow case-insensitive
> dentries.
>
> Fixes: bb9cd9106b22 ("fscrypt: Have filesystems handle their d_ops")
> Signed-off-by: Gabriel Krisman Bertazi <krisman@suse.de>
> ---
>  fs/overlayfs/params.c | 2 ++
>  include/linux/fs.h    | 9 +++++++++
>  2 files changed, 11 insertions(+)
>
> diff --git a/fs/overlayfs/params.c b/fs/overlayfs/params.c
> index 3fe2dde1598f..99495f079644 100644
> --- a/fs/overlayfs/params.c
> +++ b/fs/overlayfs/params.c
> @@ -286,6 +286,8 @@ static int ovl_mount_dir_check(struct fs_context *fc,=
 const struct path *path,
>         if (!d_is_dir(path->dentry))
>                 return invalfc(fc, "%s is not a directory", name);
>

Please add a comment to explain why this is needed to prevent post
mount lookup failures.

> +       if (sb_has_encoding(path->mnt->mnt_sb))
> +               return invalfc(fc, "caseless filesystem on %s not support=
ed", name);
>

I have not seen you use the term "caseless" on the list since 2018. old hab=
its?
Please use the term "case-insensitive" and please move the
ovl_dentry_weird() check
below this one, because when trying to mount overlayfs over non-root
case-insensitive
directory, the more specific error message is more useful.

Thanks,
Amir.

