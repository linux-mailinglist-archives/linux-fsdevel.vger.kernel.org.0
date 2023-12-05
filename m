Return-Path: <linux-fsdevel+bounces-4835-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AD00A804A2F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Dec 2023 07:35:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4BABAB209C7
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Dec 2023 06:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADE96DF6B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Dec 2023 06:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="evI5LMcF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9853CA;
	Mon,  4 Dec 2023 21:01:16 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id 3f1490d57ef6-daf26d84100so3519792276.3;
        Mon, 04 Dec 2023 21:01:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701752476; x=1702357276; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ylB6tl8v6jO1VPySOnRISUwym4+3Pn1Vco6nga8IZeA=;
        b=evI5LMcFMoH5+BP1H1fwNz7ImKcLeRMKba16mx9W07v7h8XukDlqdo75hCaVMVskZm
         o78iGJ5YLOMFv3r0Xr7Jhh01xbAIMWFqEqH87RiKEFDPK8LnlZLY4mVtj4vxdWv1P2Rl
         uQC2cUufAWBMkTe+/Hm24XH3Msab26mmJ/P5RHUlto9WEwBKClWhDv8kmO4eT2BgYDqw
         qWVqUZptTYu1+5h+YoSkthiIWhuLKGvpZbpxag0R+fwjqzSV3h6yZapzn0qT95K9Txf8
         d96cjqUohCjAdM/pzGR2n8bYQxEyo4Tvr4UyIU+fhwldre/VV5wEdUmXDvJGENO1HTyu
         srsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701752476; x=1702357276;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ylB6tl8v6jO1VPySOnRISUwym4+3Pn1Vco6nga8IZeA=;
        b=AOI3mMZ5TMIVa7L+L67UsSvruT6HvV3s7/njQOC8mlEiv2+zRwP/arzm0knzagRgSX
         gH2yP4y0wBZ+FqL+f3da73wP9d/4yMIv7A8LNapgUmZ5LFrhMTagUh2PaGYbj15ILKLn
         r6RV/KXVAM1eC8JA66WvrvY/Y0/cHWompEsFvIbhobRLU5bXwfzY0aSQmZH60AVz/Giy
         8JLFbvrTp0ovsCCs5q+dUVcOnE0Ty+ReqUJ2uZ5heZZ0+87nJeNPNd13kkLSGsZ6+h0O
         hQg8JOmPjHlaZiHPYnixncPJ6bAxARLvj9eAxID5JmMBhUEVMEHNbt4oMHh9ATd9BKzm
         keQw==
X-Gm-Message-State: AOJu0YymPzoWtfayuWZrcXSyMapLWPKbt4HLUxkhVBxgkAKA02ditj2M
	+ICtP6OxkrfND0gn90u3ghwyZuIzqEklc1H8ENs=
X-Google-Smtp-Source: AGHT+IG2HWrIP4R3ZuDAYqDiJ5uUWXACTgq9WMyJm8N+amUcEtXDX09cQhC7jwUbVaDQwcFjtjEm8cj7e8Uu6j9Wid4=
X-Received: by 2002:a25:8d0b:0:b0:d9b:eb86:2b26 with SMTP id
 n11-20020a258d0b000000b00d9beb862b26mr3204170ybl.21.1701752475945; Mon, 04
 Dec 2023 21:01:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231130141624.3338942-4-amir73il@gmail.com> <20231205001620.4566-1-spasswolf@web.de>
 <CAOQ4uxiw8a+zh-x2a+A+EEZOFj1KYrBQucCvDv6s9w0XeDW-ZA@mail.gmail.com>
In-Reply-To: <CAOQ4uxiw8a+zh-x2a+A+EEZOFj1KYrBQucCvDv6s9w0XeDW-ZA@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 5 Dec 2023 07:01:04 +0200
Message-ID: <CAOQ4uxg-4NSysxmviKxDhnrA5P455T074ku=F24Wa5KJnCgspQ@mail.gmail.com>
Subject: Re: [PATCH] fs: read_write: make default in vfs_copy_file_range() reachable
To: Bert Karwatzki <spasswolf@web.de>, Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, axboe@kernel.dk, dhowells@redhat.com, hch@lst.de, 
	jlayton@kernel.org, josef@toxicpanda.com, linux-fsdevel@vger.kernel.org, 
	miklos@szeredi.hu, viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000d341cf060bbc1fb5"

--000000000000d341cf060bbc1fb5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 5, 2023 at 5:45=E2=80=AFAM Amir Goldstein <amir73il@gmail.com> =
wrote:
>
> On Tue, Dec 5, 2023 at 2:16=E2=80=AFAM Bert Karwatzki <spasswolf@web.de> =
wrote:
> >
> > If vfs_copy_file_range() is called with (flags & COPY_FILE_SPLICE =3D=
=3D 0)
> > and both file_out->f_op->copy_file_range and file_in->f_op->remap_file_=
range
> > are NULL, too, the default call to do_splice_direct() cannot be reached=
.
> > This patch adds an else clause to make the default reachable in all
> > cases.
> >
> > Signed-off-by: Bert Karwatzki <spasswolf@web.de>
>
> Hi Bert,
>
> Thank you for testing and reporting this so early!!
>
> I would edit the commit message differently, but anyway, I think that
> the fix should be folded into commit 05ee2d85cd4a ("fs: use
> do_splice_direct() for nfsd/ksmbd server-side-copy").
>
> Since I end up making a mistake every time I touch this code,
> I also added a small edit to your patch below, that should make the logic
> more clear to readers. Hopefully, that will help me avoid making a mistak=
e
> the next time I touch this code...
>
> Would you mind testing my revised fix, so we can add:
>   Tested-by: Bert Karwatzki <spasswolf@web.de>
> when folding it into the original patch?
>

Attached an even cleaner version of the fix patch for you to test.
I tested fstests check -g copy_range on ext4.
My fault was that I had tested earlier only on xfs and overlayfs
(the two other cases in the if/else if statement).

Thanks,
Amir.

> > ---
> >  fs/read_write.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/fs/read_write.c b/fs/read_write.c
> > index e0c2c1b5962b..3599c54bd26d 100644
> > --- a/fs/read_write.c
> > +++ b/fs/read_write.c
> > @@ -1554,6 +1554,8 @@ ssize_t vfs_copy_file_range(struct file *file_in,=
 loff_t pos_in,
> >                 /* fallback to splice */
> >                 if (ret <=3D 0)
> >                         splice =3D true;
> > +       } else {
>
> This is logically correct because of the earlier "same sb" check in
> generic_copy_file_checks(), but we better spell out the logic here as wel=
l:
>
> +            } else if (file_inode(file_in)->i_sb =3D=3D
> file_inode(file_out)->i_sb) {
> +                    /* Fallback to splice for same sb copy for
> backward compat */
>
> > +               splice =3D true;
> >         }
> >
> >         file_end_write(file_out);
> > --
> > 2.39.2
> >
> > Since linux-next-20231204 I noticed that it was impossible to start the
> > game Path of Exile (using the steam client). I bisected the error to
> > commit 05ee2d85cd4ace5cd37dc24132e3fd7f5142ebef. Reverting this commit
> > in linux-next-20231204 made the game start again and after inserting
> > printks into vfs_copy_file_range() I found that steam (via python3)
> > calls this function with (flags & COPY_FILE_SPLICE =3D=3D 0),
> > file_out->f_op->copy_file_range =3D=3D NULL and
> > file_in->f_op->remap_file_range =3D=3D NULL so the default is never rea=
ched.
> > This patch adds a catch all else clause so the default is reached in
> > all cases. This patch fixes the describe issue with steam and Path of
> > Exile.
> >
> > Bert Karwatzki

--000000000000d341cf060bbc1fb5
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-fs-fix-vfs_copy_file_range-for-files-on-same-sb.patch"
Content-Disposition: attachment; 
	filename="0001-fs-fix-vfs_copy_file_range-for-files-on-same-sb.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_lprvdg970>
X-Attachment-Id: f_lprvdg970

RnJvbSAzM2ViM2NhZWFjYjUyYTQ2ZjgwODk4NDk2OWM4MDg1MjhkMTBlZTAxIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbWlyIEdvbGRzdGVpbiA8YW1pcjczaWxAZ21haWwuY29tPgpE
YXRlOiBUdWUsIDUgRGVjIDIwMjMgMDY6MjY6NTcgKzAyMDAKU3ViamVjdDogW1BBVENIXSBmczog
Zml4IHZmc19jb3B5X2ZpbGVfcmFuZ2UoKSBmb3IgZmlsZXMgb24gc2FtZSBzYgoKY29weV9maWxl
LXJhbmdlKCkgc2hvdWxkIGZhbGxiYWNrIHRvIHNwbGljZSB3aXRoIHR3byBmaWxlcyBvbiBzYW1l
IHNiCnRoYXQgZG9lcyBub3QgaW1wbGVtZW50IC0+Y29weV9maWxlX3JhbmdlKCkgbm9yIC0+cmVt
YXBfZmlsZV9yYW5nZSgpLgoKRml4ZXM6IDA0MmU0ZDlkMTdhZSAoImZzOiB1c2Ugc3BsaWNlX2Nv
cHlfZmlsZV9yYW5nZSgpIGlubGluZSBoZWxwZXIiKQpSZXBvcnRlZC1ieTogQmVydCBLYXJ3YXR6
a2kgPHNwYXNzd29sZkB3ZWIuZGU+ClNpZ25lZC1vZmYtYnk6IEFtaXIgR29sZHN0ZWluIDxhbWly
NzNpbEBnbWFpbC5jb20+Ci0tLQogZnMvcmVhZF93cml0ZS5jIHwgNyArKysrKy0tCiAxIGZpbGUg
Y2hhbmdlZCwgNSBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2Zz
L3JlYWRfd3JpdGUuYyBiL2ZzL3JlYWRfd3JpdGUuYwppbmRleCBlMGMyYzFiNTk2MmIuLjAxYTE0
NTcwMDE1YiAxMDA2NDQKLS0tIGEvZnMvcmVhZF93cml0ZS5jCisrKyBiL2ZzL3JlYWRfd3JpdGUu
YwpAQCAtMTUxNCw2ICsxNTE0LDcgQEAgc3NpemVfdCB2ZnNfY29weV9maWxlX3JhbmdlKHN0cnVj
dCBmaWxlICpmaWxlX2luLCBsb2ZmX3QgcG9zX2luLAogewogCXNzaXplX3QgcmV0OwogCWJvb2wg
c3BsaWNlID0gZmxhZ3MgJiBDT1BZX0ZJTEVfU1BMSUNFOworCWJvb2wgc2FtZXNiID0gZmlsZV9p
bm9kZShmaWxlX2luKS0+aV9zYiA9PSBmaWxlX2lub2RlKGZpbGVfb3V0KS0+aV9zYjsKIAogCWlm
IChmbGFncyAmIH5DT1BZX0ZJTEVfU1BMSUNFKQogCQlyZXR1cm4gLUVJTlZBTDsKQEAgLTE1NDUs
OCArMTU0Niw3IEBAIHNzaXplX3QgdmZzX2NvcHlfZmlsZV9yYW5nZShzdHJ1Y3QgZmlsZSAqZmls
ZV9pbiwgbG9mZl90IHBvc19pbiwKIAkJcmV0ID0gZmlsZV9vdXQtPmZfb3AtPmNvcHlfZmlsZV9y
YW5nZShmaWxlX2luLCBwb3NfaW4sCiAJCQkJCQkgICAgICBmaWxlX291dCwgcG9zX291dCwKIAkJ
CQkJCSAgICAgIGxlbiwgZmxhZ3MpOwotCX0gZWxzZSBpZiAoIXNwbGljZSAmJiBmaWxlX2luLT5m
X29wLT5yZW1hcF9maWxlX3JhbmdlICYmCi0JCSAgIGZpbGVfaW5vZGUoZmlsZV9pbiktPmlfc2Ig
PT0gZmlsZV9pbm9kZShmaWxlX291dCktPmlfc2IpIHsKKwl9IGVsc2UgaWYgKCFzcGxpY2UgJiYg
ZmlsZV9pbi0+Zl9vcC0+cmVtYXBfZmlsZV9yYW5nZSAmJiBzYW1lc2IpIHsKIAkJcmV0ID0gZmls
ZV9pbi0+Zl9vcC0+cmVtYXBfZmlsZV9yYW5nZShmaWxlX2luLCBwb3NfaW4sCiAJCQkJZmlsZV9v
dXQsIHBvc19vdXQsCiAJCQkJbWluX3QobG9mZl90LCBNQVhfUldfQ09VTlQsIGxlbiksCkBAIC0x
NTU0LDYgKzE1NTQsOSBAQCBzc2l6ZV90IHZmc19jb3B5X2ZpbGVfcmFuZ2Uoc3RydWN0IGZpbGUg
KmZpbGVfaW4sIGxvZmZfdCBwb3NfaW4sCiAJCS8qIGZhbGxiYWNrIHRvIHNwbGljZSAqLwogCQlp
ZiAocmV0IDw9IDApCiAJCQlzcGxpY2UgPSB0cnVlOworCX0gZWxzZSBpZiAoc2FtZXNiKSB7CisJ
CS8qIEZhbGxiYWNrIHRvIHNwbGljZSBmb3Igc2FtZSBzYiBjb3B5IGZvciBiYWNrd2FyZCBjb21w
YXQgKi8KKwkJc3BsaWNlID0gdHJ1ZTsKIAl9CiAKIAlmaWxlX2VuZF93cml0ZShmaWxlX291dCk7
Ci0tIAoyLjM0LjEKCg==
--000000000000d341cf060bbc1fb5--

