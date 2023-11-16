Return-Path: <linux-fsdevel+bounces-2961-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 473507EE480
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Nov 2023 16:38:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CAB62B20BA0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Nov 2023 15:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A23B358BF;
	Thu, 16 Nov 2023 15:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M/FvYkxK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A2FA11D;
	Thu, 16 Nov 2023 07:38:15 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2c509d5ab43so13640551fa.0;
        Thu, 16 Nov 2023 07:38:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700149093; x=1700753893; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DMIjDbu+Lair72CGj2Kst+Jg+KBTbdO+3ZYbTSukwbA=;
        b=M/FvYkxKv78VeuLZ9EjTR7itvuzxwTdnJElkVhTM58PcgNgiuIKuLdhXcbdfmHEX/s
         Qp5gaqqTl/YhZlN3ZRtULDT3cNnZ+tB8cSI9NShiBPZfHH/HNDXB4WIKG8cgt0jO82E+
         uDnfIFttNFjJ8lZiNA0EuAV6dxQp3KKPfK+/u6qZTf3M2+hLbTwk6XgDJBWdCwHCETT2
         A+C1LjS9W+/IBCA+6FRto1izW47MwAAjXZSkpT8OLFjl5W+DyNann2PyTzDSEdkSt85R
         3kr2m6VpeAkzQUl6ACy1WjLEu9fa/c6JrtOSVsu3FsNIkExeWjQTd0/5WeTk1i0yUG8C
         CLZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700149093; x=1700753893;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DMIjDbu+Lair72CGj2Kst+Jg+KBTbdO+3ZYbTSukwbA=;
        b=JKcUNTNrrVkpkCIaEIX7Ocnh/YzHZNlopnw24F8uMpSYESP6k+A4fx/IywdRWKwjJ8
         7kHtsw5dW6JoII5GCoXEeUjw/8srk5b0vi2RiMTCIjLVXQ3ch2DFu+g9OOi4ws/mhrCS
         UvaodqfI9nJFJp6fGCJOZCIS82sIfhqp35JO4daPTCnpCy+PrSg68u7XALrJuZuZ5CRk
         5snCkHq4RZ/GpY9MMynfF7GFDqsJq8U4iH91zqU/dN3B59f6/QBjwkOzKBaQBVh4Dxor
         WfjFn2aaQUmEIAKM0/2EF7KIE6gZVIDNywFGre6QgUyHJWO0ZnCDZ8fbAoqEMIEmLD02
         rlmg==
X-Gm-Message-State: AOJu0YxqwZp/wsE+lr4Yi64jQgnoZVuAjE6n8Hk5vtSily409ozo9JW6
	0BQ1QAAkzE0qPMFM6Zz36KSBdwByBPLgxAzQRJU=
X-Google-Smtp-Source: AGHT+IG1fdGaJQajef2978+PV4LZ/rM0rLVlWCg7oFRB/06sgDG3PW4A0flVpBqT2cVzGxzBJlBh3y/w/dbUUIV2Rfo=
X-Received: by 2002:a2e:9f47:0:b0:2c5:31de:6c02 with SMTP id
 v7-20020a2e9f47000000b002c531de6c02mr6529795ljk.15.1700149093016; Thu, 16 Nov
 2023 07:38:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <000000000000773fa7060a31e2cc@google.com> <CANaxB-yrvmv134dwTcMD9q5chXvm3YU1pDFhqvaRA8M1Gn7Guw@mail.gmail.com>
 <ZVVoCT_gNvbZg93f@x1n>
In-Reply-To: <ZVVoCT_gNvbZg93f@x1n>
From: Andrei Vagin <avagin@gmail.com>
Date: Thu, 16 Nov 2023 07:38:00 -0800
Message-ID: <CANaxB-zLxs2=gNgWTqstLvyPK8mSwpEu2ob35TtaKWheMejZOQ@mail.gmail.com>
Subject: Re: [syzbot] [fs?] WARNING in pagemap_scan_pmd_entry
To: Peter Xu <peterx@redhat.com>
Cc: syzbot <syzbot+e94c5aaf7890901ebf9b@syzkaller.appspotmail.com>, 
	Muhammad Usama Anjum <musamaanjum@gmail.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 15, 2023 at 4:53=E2=80=AFPM Peter Xu <peterx@redhat.com> wrote:
>
> Hi, Andrei, Muhammad,
>
> I had a look (as it triggered the guard I added before..), and I think I
> know what happened.  So far I think it's a question to the new ioctl()
> interface, which I'd like to double check with you all.  See below.
>
> On Wed, Nov 15, 2023 at 01:07:18PM -0800, Andrei Vagin wrote:
> > Cc: Peter and Muhammad
> >
> > On Wed, Nov 15, 2023 at 6:41=E2=80=AFAM syzbot
> > <syzbot+e94c5aaf7890901ebf9b@syzkaller.appspotmail.com> wrote:
> > >
> > > Hello,
> > >
> > > syzbot found the following issue on:
> > >
> > > HEAD commit:    c42d9eeef8e5 Merge tag 'hardening-v6.7-rc2' of git://=
git.k..
> > > git tree:       upstream
> > > console+strace: https://syzkaller.appspot.com/x/log.txt?x=3D13626650e=
80000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=3D84217b7fc=
4acdc59
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=3De94c5aaf789=
0901ebf9b
> > > compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils f=
or Debian) 2.40
> > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D15d73be=
0e80000
> > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D13670da8e=
80000
> > >
> > > Downloadable assets:
> > > disk image: https://storage.googleapis.com/syzbot-assets/a595d90eb9af=
/disk-c42d9eee.raw.xz
> > > vmlinux: https://storage.googleapis.com/syzbot-assets/c1e726fedb94/vm=
linux-c42d9eee.xz
> > > kernel image: https://storage.googleapis.com/syzbot-assets/cb43ae262d=
09/bzImage-c42d9eee.xz
> > >
> > > IMPORTANT: if you fix the issue, please add the following tag to the =
commit:
> > > Reported-by: syzbot+e94c5aaf7890901ebf9b@syzkaller.appspotmail.com
> > >
> > > ------------[ cut here ]------------
> > > WARNING: CPU: 1 PID: 5071 at arch/x86/include/asm/pgtable.h:403 pte_u=
ffd_wp arch/x86/include/asm/pgtable.h:403 [inline]
>
> This is the guard I added to detect writable bit set even if uffd-wp bit =
is
> not yet cleared.  It means something obviously wrong happened.
>
> Here afaict the wrong thing is ioctl(PAGEMAP_SCAN) allows applying uffd-w=
p
> bit to VMA that is not even registered with userfault.  Then what happene=
d
> is when the page is written, do_wp_page() will try to reuse the anonymous
> page with the uffd-wp bit set, set W bit on top of it.

Thank you for looking at this.

>
> Below change works for me:
>
> =3D=3D=3D8<=3D=3D=3D
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index ef2eb12906da..8a2500fa4580 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -1987,6 +1987,12 @@ static int pagemap_scan_test_walk(unsigned long st=
art, unsigned long end,
>                 vma_category |=3D PAGE_IS_WPALLOWED;
>         else if (p->arg.flags & PM_SCAN_CHECK_WPASYNC)
>                 return -EPERM;
> +       else
> +               /*
> +                * Neither has the VMA enabled WP tracking, nor does the
> +                * user want to explicit fail the walk.  Skip the vma.
> +                */
> +               return 1;

In this case, I think we need to check the PM_SCAN_WP_MATCHING flag
and skip these vma-s only if it is set.

If PM_SCAN_WP_MATCHING isn't set, this ioctl returns page flags and
can be used without the intention of tracking memory changes.

>
>         if (vma->vm_flags & VM_PFNMAP)
>                 return 1;
> =3D=3D=3D8<=3D=3D=3D
>
> This is based on my reading of the pagemap scan flags:
>
> - Write-protect the pages. The ``PM_SCAN_WP_MATCHING`` is used to write-p=
rotect
>   the pages of interest. The ``PM_SCAN_CHECK_WPASYNC`` aborts the operati=
on if
>   non-Async Write Protected pages are found. The ``PM_SCAN_WP_MATCHING`` =
can be
>   used with or without ``PM_SCAN_CHECK_WPASYNC``.
>
> If PM_SCAN_CHECK_WPASYNC is used to enforce the check, we need to skip th=
e
> vma that is not registered properly.  Does it look reasonable to you?

I think the idea here could be to report page flags but doesn't
write-protect such pages.

Thanks,
Andrei

