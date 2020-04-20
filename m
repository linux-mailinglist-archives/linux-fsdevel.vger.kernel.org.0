Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE9CC1B073E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Apr 2020 13:19:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726164AbgDTLTc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Apr 2020 07:19:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725773AbgDTLTa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Apr 2020 07:19:30 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9413DC061A10
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Apr 2020 04:19:29 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id g14so7707305otg.10
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Apr 2020 04:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=e29Sh5IimfCKpqH0hBK++S43Pnt0kxeDo73Bk32ebac=;
        b=eKT98z0rlqPd4Kddmlbg2xii0nzNK7Sm2cE/Q6/CBrjGOOjyYbLacaC4mYzeDR8qth
         NYoIsJE4FH1XfuGxFDuyzVazcMc0nCSjEa9a4BoVe6619W6MbmSZiDGTwBJLCugjX94j
         D++G15LhNNY0COTf7B9pMxjnmtdEZE97ilXLn6lh33Dn7MvW638xIp/BR1nPmPfMviBj
         FNpPjQkGh5S1hvic5k0OhT1PISv5NGV872ANVVrLN6U9lQn+WmLvNxb4D1kstjbjuRyG
         Wqu/og9QYMpF+EUzjWCQLy6X/P3KWKVVBWPwxR1/geHYWXhhugNMNhDt7ZGW+Ch5fDZt
         CTWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e29Sh5IimfCKpqH0hBK++S43Pnt0kxeDo73Bk32ebac=;
        b=OIfrZr/f6rJxO3KDc6zIcPveE5DafP+m+/0No7Bg8/VBwIZCAGNrqyZfgt/nFpTQee
         vVlvU1IM+wc9m0uNx60UV694XeE2CyoF8gp6okeNDJQYZRPIiIKpfdT1MhNRJqYse/EV
         1OoMyGU+iCnk82Eyeu+/HYoqNThYNRzZcVwV8mROgPakkBCliQkq3pQjnn2l7/fjYa+s
         STZD/dQXqFRG18gjpiLqBK10lCcYivsgUeg8eUf1CTrW3GxGnsHYcKEV30U6bkUanwXo
         jZcSVuzWWpkme8KvKel/TRgovPDyDIguxbMj3vpbxoBTyj+82KwLOf4JZ+vRHcYgzsW5
         CAow==
X-Gm-Message-State: AGi0PuagvCuzmO/rryivIzYRkysOAqY0rIjhUxEVfN+qdEf5Z3dfrCQh
        NjxxClrp0qmSCKQXHfCY2C7IeAFrGJyrgespiWTobg==
X-Google-Smtp-Source: APiQypISlIaSdLEv9rD1htlLD8VkbzpN2m6GxaJB8UzqhFJFyFLfmU6fCYcTBRnsKquAseuGmbeStBgIrDCH+Py5D9A=
X-Received: by 2002:a05:6830:22dc:: with SMTP id q28mr8665535otc.221.1587381568875;
 Mon, 20 Apr 2020 04:19:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200331133536.3328-1-linus.walleij@linaro.org>
In-Reply-To: <20200331133536.3328-1-linus.walleij@linaro.org>
From:   Peter Maydell <peter.maydell@linaro.org>
Date:   Mon, 20 Apr 2020 12:19:17 +0100
Message-ID: <CAFEAcA9Gep1HN+7WJHencp9g2uUBLhagxdgjHf-16AOdP5oOjg@mail.gmail.com>
Subject: Re: [PATCH] fcntl: Add 32bit filesystem mode
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        QEMU Developers <qemu-devel@nongnu.org>,
        Florian Weimer <fw@deneb.enyo.de>,
        Andy Lutomirski <luto@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 31 Mar 2020 at 14:37, Linus Walleij <linus.walleij@linaro.org> wrote:
>
> It was brought to my attention that this bug from 2018 was
> still unresolved: 32 bit emulators like QEMU were given
> 64 bit hashes when running 32 bit emulation on 64 bit systems.
>
> This adds a fcntl() operation to set the underlying filesystem
> into 32bit mode even if the file hanle was opened using 64bit
> mode without the compat syscalls.
>
> Programs that need the 32 bit file system behavior need to
> issue a fcntl() system call such as in this example:
>
>   #define F_SET_FILE_32BIT_FS (1024 + 15)
>
>   int main(int argc, char** argv) {
>     DIR* dir;
>     int err;
>     int fd;
>
>     dir = opendir("/boot");
>     fd = dirfd(dir);
>     err = fcntl(fd, F_SET_FILE_32BIT_FS);
>     if (err) {
>       printf("fcntl() failed! err=%d\n", err);
>       return 1;
>     }
>     printf("dir=%p\n", dir);
>     printf("readdir(dir)=%p\n", readdir(dir));
>     printf("errno=%d: %s\n", errno, strerror(errno));
>     return 0;
>   }

I gave this a try with a modified QEMU, but it doesn't seem
to fix the problem. Here's the relevant chunk of the strace
output from stracing a QEMU that's running a 32-bit guest
binary that issues a getdents64 and fails (it's the 'readdir-bug'
test case from the launchpad bug):

openat(AT_FDCWD, ".", O_RDONLY|O_NONBLOCK|O_CLOEXEC|O_DIRECTORY) = 3
fcntl(3, 0x40f /* F_??? */, 0x3)        = 0
fstat(3, {st_dev=makedev(0, 16), st_ino=4637237, st_mode=S_IFDIR|0755,
st_nlink=12, st_uid=1000, st_gid=1000, st_blksize=8192, st_blocks=8,
st_size=4096, st_atime=1587380917 /*
2020-04-20T11:08:37.756174607+0000 */, st_atime_nsec=756174607,
st_mtime=1587380910 /* 2020-04-20T11:08:30.356230179+0000 */,
st_mtime_nsec=356230179, st_ctime=1587380910 /*
2020-04-20T11:08:30.356230179+0000 */, st_ctime_nsec=356230179}) = 0
fstat(1, {st_dev=makedev(0, 2), st_ino=9017, st_mode=S_IFCHR|0600,
st_nlink=1, st_uid=0, st_gid=0, st_blksize=4096, st_blocks=0,
st_rdev=makedev(5, 1), st_atime=1587381196 /* 2020-04-20T11:13:16+0000
*/, st_atime_nsec=0, st_mtime=1587381196 /* 2020-04-20T11:13:16+0000
*/, st_mtime_nsec=0, st_ctime=1587381042 /*
2020-04-20T11:10:42.484981152+0000 */, st_ctime_nsec=484981152}) = 0
ioctl(1, TCGETS, {c_iflags=0x2502, c_oflags=0x5, c_cflags=0xcbd,
c_lflags=0x8a3b, c_line=0,
c_cc="\x03\x1c\x7f\x15\x04\x00\x01\x00\x11\x13\x1a\x00\x12\x0f\x17\x16\x00\x00\x00"})
= 0
write(1, "dir=0x76128\n", 12)           = 12
getdents64(3, [{d_ino=1, d_off=273341893525646730, d_reclen=24,
d_type=DT_DIR, d_name=".."}, {d_ino=4637239, d_off=849308795555391993,
d_reclen=24, d_type=DT_DIR, d_name="etc"}, {d_ino=4587984,
d_off=1620709961571101518, d_reclen=24, d_type=DT_LNK, d_name="usr"},
{d_ino=4637238, d_off=2787937917159437645, d_reclen=24, d_type=DT_DIR,
d_name="dev"}, {d_ino=4637244, d_off=3015508490233103491, d_reclen=24,
d_type=DT_DIR, d_name="sys"}, {d_ino=4587608,
d_off=3551089360661460833, d_reclen=24, d_type=DT_LNK, d_name="lib"},
{d_ino=4637246, d_off=3857320197951442970, d_reclen=24, d_type=DT_DIR,
d_name="var"}, {d_ino=4637242, d_off=4103122318823701457, d_reclen=24,
d_type=DT_DIR, d_name="proc"}, {d_ino=4587541,
d_off=4252201186220906002, d_reclen=24, d_type=DT_LNK, d_name="bin"},
{d_ino=4637245, d_off=4386533378951587638, d_reclen=24, d_type=DT_DIR,
d_name="tmp"}, {d_ino=4637241, d_off=4883206313583644962, d_reclen=24,
d_type=DT_DIR, d_name="host"}, {d_ino=4637237,
d_off=4941119754928488586, d_reclen=24, d_type=DT_DIR, d_name="."},
{d_ino=4637243, d_off=5301154723342888169, d_reclen=24, d_type=DT_DIR,
d_name="root"}, {d_ino=4587838, d_off=6989908915879243400,
d_reclen=32, d_type=DT_LNK, d_name="lib64"}, {d_ino=4587679,
d_off=7356513223657690979, d_reclen=32, d_type=DT_REG,
d_name="strace.log"}, {d_ino=4587847, d_off=7810090083157553519,
d_reclen=24, d_type=DT_LNK, d_name="sbin"}, {d_ino=4637240,
d_off=8254997891991845677, d_reclen=24, d_type=DT_DIR, d_name="home"},
{d_ino=4637248, d_off=9223372036854775807, d_reclen=24, d_type=DT_DIR,
d_name="virt"}], 32768) = 448
write(1, "readdir(dir)=(nil)\n", 19)    = 19
write(1, "errno=75: Value too large for de"..., 48) = 48
exit_group(0)                           = ?


We open fd 3 to read '.'; we issue the new fcntl, which
succeeds. Then there's some unrelated stuff operating on
stdout. Then we do a getdents64(), but the d_off values
we get back are still 64 bits. The guest binary doesn't
like those, so it fails. My expectation was that we would
get back d_off values here that were in the 32 bit range.

(To be clear, the guest binary here is doing a getdents64(),
which QEMU translates into a host getdents64().)

thanks
-- PMM
