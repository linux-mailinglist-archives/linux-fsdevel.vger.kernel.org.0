Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5B1715A281
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2020 08:59:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728393AbgBLH7A (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Feb 2020 02:59:00 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:45235 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727669AbgBLH67 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Feb 2020 02:58:59 -0500
Received: by mail-oi1-f193.google.com with SMTP id v19so1145741oic.12
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Feb 2020 23:58:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=stapelberg-ch.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+gfCeGVf1+C6H+B7Y7Cv1jC8wNsWdETJ4+jIe0R9/HA=;
        b=O9JVJqX9m8hYGFPU4CRTUSanQgJSsniqg79vog0h5MuWoIFVVMHKz0wjsaXiGlsjKq
         q3y3w4GoAycW1jj/lLe0UGA7dFeG0BcgHaLOXkbXMzmOHAXAKywJSkCJAHpUmuy7QtO9
         lbffL2ZVPM7BSsjUqBcyJJq97/ArVsl39meURQZYp7H946aAX6VWWKc2WP7Dq4B1bGXF
         cIjU3Wjv0PuFj/x+GritqwoB99xIODZRtBVUHRIs7pwn6s4I5x0EgupDPj6QcVl6HnOS
         dQDzcJJKVxYMJIfEp6KQwrjnuz9j6cX6byyXLpUpG9QTOYnKEcb/PTekqpHiRNUdWFY1
         GtfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+gfCeGVf1+C6H+B7Y7Cv1jC8wNsWdETJ4+jIe0R9/HA=;
        b=HVRYA846pa/9LDCHvl6eOVVLpjcHTBsdqgWY/rd19Sv6LsNUudG+3hFNpoEzhjPB4s
         BBD8msn+efaS4ePQaap1VGitkSI03eVHorn5gi+nTrTkAVP5+PTBv9xBB1KMzOVm+84N
         4YtbJo8NZqkYfum/wWoUTGBjRuADtSaabJezZ9SWaJgggQLXmrSi6iuNfc9XDWcIMsjo
         aFJ9bNimzX5aF9J65MMK058Jr6NA8VS+WCTVN8bIU/BGOLWaEfc0TwKQRu9jmOyg3TSX
         9CBxGQwCRfFpS9u1crdFEI8cxN0iS6+/xwuo8+dvJDrjAGHE2we35otV6g6zioke4OhK
         kexw==
X-Gm-Message-State: APjAAAW1jOUiD+Ay+r/FrAcTyRE8snW+ssaWgFQq7lCVzHoxlBAKdMs9
        /svFnh4XVvw4IeHlyc7vVG2FzEgXf+YefjQWAyEYTw==
X-Google-Smtp-Source: APXvYqyihgfPdh+cTb8/ZFqn4kCxLLTio71MqKbIopYNfnqlfwl09rcj7ZGZ158u3JZSfWq6mdZjsUTvokEg44pdx0k=
X-Received: by 2002:a54:4f04:: with SMTP id e4mr5137716oiy.111.1581494338133;
 Tue, 11 Feb 2020 23:58:58 -0800 (PST)
MIME-Version: 1.0
References: <CAJfpegtUAHPL9tsFB85ZqjAfy0xwz7ATRcCtLbzFBo8=WnCvLw@mail.gmail.com>
 <20200209080918.1562823-1-michael+lkml@stapelberg.ch> <CAJfpegv4iL=bW3TXP3F9w1z6-LUox8KiBmw7UBcWE-0jiK0YsA@mail.gmail.com>
In-Reply-To: <CAJfpegv4iL=bW3TXP3F9w1z6-LUox8KiBmw7UBcWE-0jiK0YsA@mail.gmail.com>
From:   Michael Stapelberg <michael+lkml@stapelberg.ch>
Date:   Wed, 12 Feb 2020 08:58:47 +0100
Message-ID: <CANnVG6kYh6M30mwBHcGeFf=fhqKmWKPeUj2GYbvNgtq0hm=gXQ@mail.gmail.com>
Subject: Re: Still a pretty bad time on 5.4.6 with fuse_request_end.
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     fuse-devel <fuse-devel@lists.sourceforge.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kyle Sanderson <kyle.leet@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Sure: here=E2=80=99s a backtrace and req->args printed:

(gdb) bt full
#0  0xffffffff82000ff3 in __x86_indirect_thunk_r8 () at
arch/x86/lib/retpoline.S:40
No locals.
#1  0xffffffff8137ec68 in fuse_request_end (fc=3D0xffff88813a57be00,
req=3D0xffff88813a5a3770) at fs/fuse/dev.c:329
        fiq =3D 0xffff88813a57be48
        async =3D true
#2  0xffffffff81382d88 in fuse_dev_do_write (fud=3D0xffff88813a57be00,
cs=3D0xffffc90002fafa00, nbytes=3D4294967294) at fs/fuse/dev.c:1912
        err =3D 0
        fc =3D 0xffff88813a57be00
        fpq =3D 0xffff888132815f48
        req =3D 0xffff88813a5a3770
        oh =3D {
          len =3D 16,
          error =3D -2,
          unique =3D 66942
        }
#3  0xffffffff81382e69 in fuse_dev_write (iocb=3D0xffffc900008cbe48,
from=3D0xffffc900008cbe20) at fs/fuse/dev.c:1934
        cs =3D {
          write =3D 0,
          req =3D 0xffff88813a5a3770,
          iter =3D 0xffffc900008cbe20,
          pipebufs =3D 0x0 <fixed_percpu_data>,
          currbuf =3D 0x0 <fixed_percpu_data>,
          pipe =3D 0x0 <fixed_percpu_data>,
          nr_segs =3D 0,
          pg =3D 0x0 <fixed_percpu_data>,
          len =3D 0,
          offset =3D 24,
          move_pages =3D 0
        }
        fud =3D 0xffff888132815f40
#4  0xffffffff8120122e in call_write_iter (file=3D<optimized out>,
iter=3D<optimized out>, kio=3D<optimized out>) at
./include/linux/fs.h:1901
No locals.
#5  new_sync_write (filp=3D0xffff888119886b00, buf=3D<optimized out>,
len=3D<optimized out>, ppos=3D0xffffc900008cbee8) at fs/read_write.c:483
        iov =3D {
          iov_base =3D 0xc0008ec008,
          iov_len =3D 16
        }
        kiocb =3D {
          ki_filp =3D 0xffff888119886b00,
          ki_pos =3D 0,
          ki_complete =3D 0x0 <fixed_percpu_data>,
          private =3D 0x0 <fixed_percpu_data>,
          ki_flags =3D 0,
          ki_hint =3D 0,
          ki_ioprio =3D 0,
          ki_cookie =3D 0
        }
        iter =3D {
          type =3D 5,
          iov_offset =3D 0,
          count =3D 0,
          {
            iov =3D 0xffffc900008cbe20,
            kvec =3D 0xffffc900008cbe20,
            bvec =3D 0xffffc900008cbe20,
            pipe =3D 0xffffc900008cbe20
          },
          {
            nr_segs =3D 0,
            {
              head =3D 0,
              start_head =3D 0
            }
          }
        }
        ret =3D <optimized out>
#6  0xffffffff812012e4 in __vfs_write (file=3D<optimized out>,
p=3D<optimized out>, count=3D<optimized out>, pos=3D<optimized out>) at
fs/read_write.c:496
No locals.
#7  0xffffffff81203f04 in vfs_write (pos=3D<optimized out>, count=3D16,
buf=3D<optimized out>, file=3D<optimized out>) at fs/read_write.c:558
        ret =3D 16
        ret =3D <optimized out>
#8  vfs_write (file=3D0xffff888119886b00, buf=3D0xc0008ec008 "\020",
count=3D16, pos=3D0xffffc900008cbee8) at fs/read_write.c:542
        ret =3D 16
#9  0xffffffff812041b2 in ksys_write (fd=3D<optimized out>,
buf=3D0xc0008ec008 "\020", count=3D16) at fs/read_write.c:611
        pos =3D 0
        ppos =3D <optimized out>
        f =3D <optimized out>
        ret =3D 824643076104
#10 0xffffffff81204245 in __do_sys_write (count=3D<optimized out>,
buf=3D<optimized out>, fd=3D<optimized out>) at fs/read_write.c:623
No locals.
#11 __se_sys_write (count=3D<optimized out>, buf=3D<optimized out>,
fd=3D<optimized out>) at fs/read_write.c:620
        ret =3D <optimized out>
        ret =3D <optimized out>
#12 __x64_sys_write (regs=3D<optimized out>) at fs/read_write.c:620
No locals.
#13 0xffffffff810028a8 in do_syscall_64 (nr=3D<optimized out>,
regs=3D0xffffc900008cbf58) at arch/x86/entry/common.c:294
        ti =3D <optimized out>
#14 0xffffffff81e0007c in entry_SYSCALL_64 () at arch/x86/entry/entry_64.S:=
175
No locals.
#15 0x0000000000000000 in ?? ()
No symbol table info available.

(gdb) p *req->args
$5 =3D {
  nodeid =3D 18446683600620026424,
  opcode =3D 2167928246,
  in_numargs =3D 65535,
  out_numargs =3D 65535,
  force =3D false,
  noreply =3D false,
  nocreds =3D false,
  in_pages =3D false,
  out_pages =3D false,
  out_argvar =3D true,
  page_zeroing =3D true,
  page_replace =3D false,
  in_args =3D {{
      size =3D 978828800,
      value =3D 0x2fafce0
    }, {
      size =3D 978992728,
      value =3D 0xffffffff8138efaa <fuse_alloc_forget+26>
    }, {
      size =3D 50002688,
      value =3D 0xffffffff8138635f <fuse_lookup_name+255>
    }},
  out_args =3D {{
      size =3D 570,
      value =3D 0xffffc90002fafb10
    }, {
      size =3D 6876,
      value =3D 0x3000000001adc
    }},
  end =3D 0x1000100000001
}

Independently, as a separate test, I have also modified the source like thi=
s:

bool async;
bool async_early =3D req->args->end;

if (test_and_set_bit(FR_FINISHED, &req->flags))
goto put_request;

async =3D req->args->end;

=E2=80=A6and printed the value of async and async_early. async is true,
async_early is false.

Perhaps some other routine is modifying the request, and checking
req->args->end early enough masks that bug?

On Tue, Feb 11, 2020 at 11:55 AM Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> On Sun, Feb 9, 2020 at 9:09 AM <michael+lkml@stapelberg.ch> wrote:
> >
> > From: Michael Stapelberg <michael+lkml@stapelberg.ch>
> >
> > Hey,
> >
> > I recently ran into this, too. The symptom for me is that processes usi=
ng the
> > affected FUSE file system hang indefinitely, sync(2) system calls hang
> > indefinitely, and even triggering an abort via echo 1 >
> > /sys/fs/fuse/connections/*/abort does not get the file system unstuck (=
there is
> > always 1 request still pending). Only removing power will get the machi=
ne
> > unstuck.
> >
> > I=E2=80=99m triggering this when building packages for https://distr1.o=
rg/, which uses a
> > FUSE daemon (written in Go using the jacobsa/fuse package) to provide p=
ackage
> > contents.
> >
> > I bisected the issue to commit
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/comm=
it/?id=3D2b319d1f6f92a4ced9897678113d176ee16ae85d
> >
> > With that commit, I run into a kernel oops within =E2=89=881 minute aft=
er starting my
> > batch build. With the commit before, I can batch build for many minutes=
 without
> > issues.
>
> Pretty weird.   I'm not seeing how this could change behavior, as the
> args->end value is not changed after being initialized, and so moving
> the test later should not make a difference.
>
> Could you print out the complete contents of req->args?
>
> Thanks,
> Miklos
