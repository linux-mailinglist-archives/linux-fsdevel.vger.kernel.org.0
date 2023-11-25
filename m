Return-Path: <linux-fsdevel+bounces-3794-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5B217F8985
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Nov 2023 10:21:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40672B212DB
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Nov 2023 09:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61B46BA2E;
	Sat, 25 Nov 2023 09:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P7UvDOIq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E57610C1;
	Sat, 25 Nov 2023 01:21:39 -0800 (PST)
Received: by mail-yb1-xb2e.google.com with SMTP id 3f1490d57ef6-da3b4b7c6bdso2444584276.2;
        Sat, 25 Nov 2023 01:21:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700904098; x=1701508898; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b2xWkAUf32ZykRBN65j+Q3PFsP2PMbNyWuqxvvlTBpw=;
        b=P7UvDOIqG/2/stPtnqAfHQv/6ISYTGrWOr2E343ZwNnyJ6QkVC94hkDtp4yD8EJ+Dl
         vqvakma+MUMy0W0LgsfDnwdA6lhmw9z3HItAjAm9K/ImisnC1eG0NJppWywJNPFuPpO1
         iVsd5as8izSrziOkFAAXGLrTDVMWaH5edzCdNEdAyxJ3Ua74SRipItkWIt7CzhuyrSjf
         L16DWgKiWKyQvfPpl56FhApyHZErpH0GMdjS9UHIVWuRPRbu8nzQFSg7zrq3McTy5Z1T
         1kwDWCAI/WL7j9lZaF811kBNCfCuLCKAS8ZOUKsEWORxlWhoulEHaG/aEbiU48CLnacy
         E0OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700904098; x=1701508898;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b2xWkAUf32ZykRBN65j+Q3PFsP2PMbNyWuqxvvlTBpw=;
        b=nVGDxhLYuaawHUu5D29lE/ZJzW99ZbaIaEkoCoaQ4sWjAONlB1NwFawOd0xsWTJHZh
         NWc/grQ8Sid56wKBGo+WjUZjB7N0XnE0pClUzXMIpXHEn69Z/V0NBiFLhlDWaiDCHxE7
         PuMZkrhnDWI9cDB7aKpQq061eS0G+Cta66f82vlPS/I5wDuJP8Nl/7KQDNPF0K5As+vc
         c21Yxyoa63hMhj59g9ZGOmIhn6X6kisCieq8yzmsho/Bxl9Fblc7QoIMu2sGaofBQDke
         QgfipS/qZwvG8tYypThjSt1S9TnRDhl8GNMPZU+NJsqlPTpUfiEqDPa1ITtDx6CS6WBE
         4dPA==
X-Gm-Message-State: AOJu0YxF/nk9QkolPr+qTshRPwrPKD1JsZlz+/7B8HuGjujwmTQtVgZL
	/ehw5m5ZntAy7H+/PRoGqjc+dtWwUEbWWD0Yh6k=
X-Google-Smtp-Source: AGHT+IG30HWKwin5EfDZOvVqQbi146zDPdkbyyJoexou3LDBOMIc/mj7dx2YP6n8XzcTDPgfECsvLCcDwpdBEaF3AuI=
X-Received: by 2002:a25:cb8a:0:b0:d81:504f:f883 with SMTP id
 b132-20020a25cb8a000000b00d81504ff883mr1545416ybg.8.1700904098622; Sat, 25
 Nov 2023 01:21:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOQ4uxjssgw1tZrUQvtHHVacSgR9NE0yF8DA3+R5LNFAocCvVQ@mail.gmail.com>
 <000000000000258ac60606589787@google.com> <CAG48ez2UkCR7LMaQfCQVLW4VOZG9CuPDMHG7cBtaAitM=zPBCg@mail.gmail.com>
 <CAG48ez2_XT1XDML756zM2D07BjcJnw22pFiHHrOm-yHvGJHvdw@mail.gmail.com>
In-Reply-To: <CAG48ez2_XT1XDML756zM2D07BjcJnw22pFiHHrOm-yHvGJHvdw@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sat, 25 Nov 2023 11:21:27 +0200
Message-ID: <CAOQ4uxj+enOZJiAJaCRnfb1soFS7aonJjHmLXiP3heQAFQoBqg@mail.gmail.com>
Subject: Re: [syzbot] [overlayfs?] KASAN: invalid-free in ovl_copy_up_one
To: Jann Horn <jannh@google.com>
Cc: syzbot <syzbot+477d8d8901756d1cbba1@syzkaller.appspotmail.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, miklos@szeredi.hu, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 24, 2023 at 5:26=E2=80=AFPM Jann Horn <jannh@google.com> wrote:
>
> On Fri, Nov 24, 2023 at 4:11=E2=80=AFPM Jann Horn <jannh@google.com> wrot=
e:
> >
> > On Wed, Sep 27, 2023 at 5:10=E2=80=AFPM syzbot
> > <syzbot+477d8d8901756d1cbba1@syzkaller.appspotmail.com> wrote:
> > > syzbot has tested the proposed patch and the reproducer did not trigg=
er any issue:
> > >
> > > Reported-and-tested-by: syzbot+477d8d8901756d1cbba1@syzkaller.appspot=
mail.com
> > >
> > > Tested on:
> > >
> > > commit:         8e9b46c4 ovl: do not encode lower fh with upper sb_wr=
i..
> > > git tree:       https://github.com/amir73il/linux.git ovl_want_write
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=3D10d10ffa6=
80000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=3Dbb54ecdfa=
197f132
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=3D477d8d89017=
56d1cbba1
> > > compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils f=
or Debian) 2.40
> >
> > It looks like the fix was submitted without the Reported-by tag, so
> > syzkaller doesn't recognize that the fix has landed... I'll tell
> > syzkaller now which commit the fix is supposed to be in, please
> > correct me if this is wrong:
> >
> > #syz fix: ovl: do not encode lower fh with upper sb_writers held
>
> (Ah, and just for the record: I hadn't realized when writing this that
> the fix was actually in a newer version of the same patch... "git

That is correct.
I am very thankful for syzbot with helping me catch bugs during development
and I would gladly attribute the bot and its owners, but I don't that
Reported-and-tested-by is an adequate tag for a bug that never existed as
far as git history.

Even Tested-by: syzbot could be misleading to stable kernel bots
that may conclude that the patch is a fix that needs to apply to stable.

I am open to suggestions.

Also maybe

#syz correction:

To tell syzbot we are not fixing a bug in upstream, but in a previous
version of a patch that it had tested.

> range-diff 44ef23e481b02df2f17599a24f81cf0045dc5256~1..44ef23e481b02df2f1=
7599a24f81cf0045dc5256
> 5b02bfc1e7e3811c5bf7f0fa626a0694d0dbbd77~1..5b02bfc1e7e3811c5bf7f0fa626a0=
694d0dbbd77"
> shows an added "ovl_get_index_name", I guess that's the fix?)

No, that added ovl_get_index_name() seems like a fluke of the range-diff to=
ol.
All the revisions of this patch always had this same minor change in this l=
ine:

-               err =3D ovl_get_index_name(ofs, c->lowerpath.dentry,
&c->destname);
+               err =3D ovl_get_index_name(ofs, origin, &c->destname);

The fix is obviously in the other part of the range-diff.

Thanks,
Amir.

                if (err)
     -                  return err;
    -+                  goto out;
    ++                  goto out_free_fh;
        } else if (WARN_ON(!c->parent)) {
                /* Disconnected dentry must be copied up to index dir */
     -          return -EIO;
     +          err =3D -EIO;
    -+          goto out;
    ++          goto out_free_fh;
        } else {
                /*
                 * Mark parent "impure" because it may now contain non-pure
    @@ fs/overlayfs/copy_up.c: static int ovl_do_copy_up(struct
ovl_copy_up_ctx *c)
                ovl_end_write(c->dentry);
                if (err)
     -                  return err;
    -+                  goto out;
    ++                  goto out_free_fh;
        }

        /* Should we copyup with O_TMPFILE or with workdir? */
    @@ fs/overlayfs/copy_up.c: static int ovl_do_copy_up(struct
ovl_copy_up_ctx *c)
      out:
        if (to_index)
                kfree(c->destname.name);
    ++out_free_fh:
     +  kfree(fh);
        return err;
      }

