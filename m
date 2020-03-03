Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D17C5177957
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Mar 2020 15:42:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729617AbgCCOky (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Mar 2020 09:40:54 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:33211 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726766AbgCCOkx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Mar 2020 09:40:53 -0500
Received: by mail-ot1-f67.google.com with SMTP id a20so3230227otl.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Mar 2020 06:40:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/mBWi97cRQrHShTl1wrJlc6BFZ2cxgJKMQ2xHrdnm0o=;
        b=CrqZYCge8xKex30AAOHdpb0X5fD036JnHc2WvUXS0REQgZ4bU3rWlAlHCJ7350y6/q
         Vlc0QA4cUYJ6GGYyIHxmwoQuxu9rZ3SV7ScZsy460bxcGCTSmhH0znlPJ8ioY1vCqu3f
         pKvh7iLZb4C7L6aGAl/AmTDdazhseXNLBtvB3zKNBDckQmes2vUe9LmZBay+1fSBICiJ
         dZ+P5ZDkHh9H7JYdpds2XJ4Wgqbk4fXxUHh5UGbZQ2qy8Oy7jfxZAgQEnrcLsk/vt+IL
         XqvrpfzAP/USd+K1viA+k9OwkXLq2EwdIKML34OB8ZWksYGLjRuXZvCSjdYu1mOIwtjq
         4JDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/mBWi97cRQrHShTl1wrJlc6BFZ2cxgJKMQ2xHrdnm0o=;
        b=OPn/A+QoIH9UCw2Ea8Tb15pliV2Yjvw18yVyhc5pCxu5Eqy9UsNG6949JmMDZIGsOf
         LbVo6JkguBcxuir3As4Jdr3n6j6CpNg7Vg/Nhr6a6dwnTXwnWRRITThXeeJ+gNvR0r3M
         FoFfrtsGyom3rXwW+rCa3n8YgDcr8OrD/3YCaEeXocjc390gWlg14qirSJ58ovzwdKjG
         FOY96OYWwgc1fwLLG3oodnoZi6e7rpcO0JOPikx5zQkfVvAxETqLOxXvLVduVFLZbpyK
         im2LbJJ/d2ERpiM8IRI6Yv26PUGDV2l5xZKePQUrqR3lrGOhAy+odSvo+6o6KzVRwke0
         ZzeA==
X-Gm-Message-State: ANhLgQ2BQvQivEC5wXy4qePvj54leTU7HB972WjN11mcDomaLHNjSE7/
        KqKTXKGfSS2Vwo000X6ozLKFgNJuXcIoXOPgcr4JCQ==
X-Google-Smtp-Source: ADFU+vu2yfaWH2buwSbocuTlemn870P5bOwMPwqx/zPpaBU68d+JJKh9qyzCZC8XdU+TPpl8/WgjPAFlQtdumGuIKqM=
X-Received: by 2002:a05:6830:1d6e:: with SMTP id l14mr3567202oti.32.1583246452097;
 Tue, 03 Mar 2020 06:40:52 -0800 (PST)
MIME-Version: 1.0
References: <0403cda7345e34c800eec8e2870a1917a8c07e5c.camel@themaw.net>
 <CAJfpegtu6VqhPdcudu79TX3e=_NZaJ+Md3harBGV7Bg_-+fR8Q@mail.gmail.com>
 <1509948.1583226773@warthog.procyon.org.uk> <CAJfpegtOwyaWpNfjomRVOt8NKqT94O5n4-LOHTR7YZT9fadVHA@mail.gmail.com>
 <20200303113814.rsqhljkch6tgorpu@ws.net.home> <20200303130347.GA2302029@kroah.com>
 <20200303131434.GA2373427@kroah.com> <CAJfpegt0aQVvoDeBXOu2xZh+atZQ+q5uQ_JRxe46E8cZ7sHRwg@mail.gmail.com>
 <20200303134316.GA2509660@kroah.com> <CAJfpegtFyZqSRzo3uuXp1S2_jJJ29DL=xAwKjpEGvyG7=AzabA@mail.gmail.com>
 <20200303142958.GB47158@kroah.com>
In-Reply-To: <20200303142958.GB47158@kroah.com>
From:   Jann Horn <jannh@google.com>
Date:   Tue, 3 Mar 2020 15:40:24 +0100
Message-ID: <CAG48ez1sdUJzp85oqBw8vCpc3E4Sb26M9pj2zHhnKpb-1+f4vg@mail.gmail.com>
Subject: Re: [PATCH 00/17] VFS: Filesystem information and notifications [ver #17]
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Miklos Szeredi <miklos@szeredi.hu>, Karel Zak <kzak@redhat.com>,
        David Howells <dhowells@redhat.com>,
        Ian Kent <raven@themaw.net>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Steven Whitehouse <swhiteho@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 3, 2020 at 3:30 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Tue, Mar 03, 2020 at 03:10:50PM +0100, Miklos Szeredi wrote:
> > On Tue, Mar 3, 2020 at 2:43 PM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Tue, Mar 03, 2020 at 02:34:42PM +0100, Miklos Szeredi wrote:
> >
> > > > If buffer is too small to fit the whole file, return error.
> > >
> > > Why?  What's wrong with just returning the bytes asked for?  If someone
> > > only wants 5 bytes from the front of a file, it should be fine to give
> > > that to them, right?
> >
> > I think we need to signal in some way to the caller that the result
> > was truncated (see readlink(2), getxattr(2), getcwd(2)), otherwise the
> > caller might be surprised.
>
> But that's not the way a "normal" read works.  Short reads are fine, if
> the file isn't big enough.  That's how char device nodes work all the
> time as well, and this kind of is like that, or some kind of "stream" to
> read from.
>
> If you think the file is bigger, then you, as the caller, can just pass
> in a bigger buffer if you want to (i.e. you can stat the thing and
> determine the size beforehand.)
>
> Think of the "normal" use case here, a sysfs read with a PAGE_SIZE
> buffer.  That way userspace "knows" it will always read all of the data
> it can from the file, we don't have to do any seeking or determining
> real file size, or anything else like that.
>
> We return the number of bytes read as well, so we "know" if we did a
> short read, and also, you could imply, if the number of bytes read are
> the exact same as the number of bytes of the buffer, maybe the file is
> either that exact size, or bigger.
>
> This should be "simple", let's not make it complex if we can help it :)
>
> > > > Verify that the number of bytes read matches the file size, otherwise
> > > > return error (may need to loop?).
> > >
> > > No, we can't "match file size" as sysfs files do not really have a sane
> > > "size".  So I don't want to loop at all here, one-shot, that's all you
> > > get :)
> >
> > Hmm.  I understand the no-size thing.  But looping until EOF (i.e.
> > until read return zero) might be a good idea regardless, because short
> > reads are allowed.
>
> If you want to loop, then do a userspace open/read-loop/close cycle.
> That's not what this syscall should be for.
>
> Should we call it: readfile-only-one-try-i-hope-my-buffer-is-big-enough()?  :)

So how is this supposed to work in e.g. the following case?

========================================
$ cat map_lots_and_read_maps.c
#include <sys/mman.h>
#include <fcntl.h>
#include <unistd.h>

int main(void) {
  for (int i=0; i<1000; i++) {
    mmap(NULL, 0x1000, (i&1)?PROT_READ:PROT_NONE,
MAP_PRIVATE|MAP_ANONYMOUS, -1, 0);
  }
  int maps = open("/proc/self/maps", O_RDONLY);
  static char buf[0x100000];
  int res;
  do {
    res = read(maps, buf, sizeof(buf));
  } while (res > 0);
}
$ gcc -o map_lots_and_read_maps map_lots_and_read_maps.c
$ strace -e trace='!mmap' ./map_lots_and_read_maps
execve("./map_lots_and_read_maps", ["./map_lots_and_read_maps"],
0x7ffebd297ac0 /* 51 vars */) = 0
brk(NULL)                               = 0x563a1184f000
access("/etc/ld.so.preload", R_OK)      = -1 ENOENT (No such file or directory)
openat(AT_FDCWD, "/etc/ld.so.cache", O_RDONLY|O_CLOEXEC) = 3
fstat(3, {st_mode=S_IFREG|0644, st_size=208479, ...}) = 0
close(3)                                = 0
openat(AT_FDCWD, "/lib/x86_64-linux-gnu/libc.so.6", O_RDONLY|O_CLOEXEC) = 3
read(3, "\177ELF\2\1\1\3\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0\320l\2\0\0\0\0\0"...,
832) = 832
fstat(3, {st_mode=S_IFREG|0755, st_size=1820104, ...}) = 0
mprotect(0x7fb5c2d1a000, 1642496, PROT_NONE) = 0
close(3)                                = 0
arch_prctl(ARCH_SET_FS, 0x7fb5c2eb6500) = 0
mprotect(0x7fb5c2eab000, 12288, PROT_READ) = 0
mprotect(0x563a103e4000, 4096, PROT_READ) = 0
mprotect(0x7fb5c2f12000, 4096, PROT_READ) = 0
munmap(0x7fb5c2eb7000, 208479)          = 0
openat(AT_FDCWD, "/proc/self/maps", O_RDONLY) = 3
read(3, "563a103e1000-563a103e2000 r--p 0"..., 1048576) = 4075
read(3, "7fb5c2985000-7fb5c2986000 ---p 0"..., 1048576) = 4067
read(3, "7fb5c29d8000-7fb5c29d9000 r--p 0"..., 1048576) = 4067
read(3, "7fb5c2a2b000-7fb5c2a2c000 ---p 0"..., 1048576) = 4067
read(3, "7fb5c2a7e000-7fb5c2a7f000 r--p 0"..., 1048576) = 4067
read(3, "7fb5c2ad1000-7fb5c2ad2000 ---p 0"..., 1048576) = 4067
read(3, "7fb5c2b24000-7fb5c2b25000 r--p 0"..., 1048576) = 4067
read(3, "7fb5c2b77000-7fb5c2b78000 ---p 0"..., 1048576) = 4067
read(3, "7fb5c2bca000-7fb5c2bcb000 r--p 0"..., 1048576) = 4067
read(3, "7fb5c2c1d000-7fb5c2c1e000 ---p 0"..., 1048576) = 4067
read(3, "7fb5c2c70000-7fb5c2c71000 r--p 0"..., 1048576) = 4067
read(3, "7fb5c2cc3000-7fb5c2cc4000 ---p 0"..., 1048576) = 4078
read(3, "7fb5c2eca000-7fb5c2ecb000 r--p 0"..., 1048576) = 2388
read(3, "", 1048576)                    = 0
exit_group(0)                           = ?
+++ exited with 0 +++
$
========================================

The kernel is randomly returning short reads *with different lengths*
that are vaguely around PAGE_SIZE, no matter how big the buffer
supplied by userspace is. And while repeated read() calls will return
consistent state thanks to the seqfile magic, repeated readfile()
calls will probably return garbage with half-complete lines.
