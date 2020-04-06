Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A814E19F1AA
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Apr 2020 10:36:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726608AbgDFIgK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Apr 2020 04:36:10 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:37884 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726595AbgDFIgK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Apr 2020 04:36:10 -0400
Received: by mail-ed1-f67.google.com with SMTP id de14so18195794edb.4
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 Apr 2020 01:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rpWT0MDD1UpkdCBjt4GwmUUuDmZT2CiV8oFjv2FSbJc=;
        b=FIQ2U20CLFrpOgJbE6xj4ai+Rnc4E5kQ/LBDi4blhwf+5onbkwT/M+Gd5RPhR9tnuv
         zaaYj6J4xLttvLdfS72P9zuIAxhckvPYgRuzZ8VPVpsP7V/K+suG3F4D0oaBg313A6jW
         uq/Nox6b6glJaYpZBI+S86tXlw5VzZk0oNqH4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rpWT0MDD1UpkdCBjt4GwmUUuDmZT2CiV8oFjv2FSbJc=;
        b=f4LeNH267AzzE0PXtfYGlNH1dZNGpJumARPcwKOEgFKEsU/3j/FrObpQadh/TNxJV6
         acNzUfPnhCsl3hQvrrfvSt/DO2jMbUAv418Op8xSP+vdEUKtJ2tCFtDPcvwjC+MdhCOf
         RhFl4HTxWIpj9oJb8qROkIhuV4LbMAEIxPDq0dz+y8uqGFATjoZePd5mzL8uGoxf4eeZ
         ShOQxxDJQAVPCv2f1Ldnq3GyI2tah85VSDjHpXml0o1r8rO3Og/DdVCSUIOfz5v51Cii
         yYJtsyvB4l3PP5o+ziD9fCMM/uF/0mdDk3srdA9UVEq7zz1RppSVZg+CuI0RAfs3vtQW
         xMHw==
X-Gm-Message-State: AGi0PuYGeJjdu/+qXeTeey1oa+81p7qMYCWSe5K0Bs70lxkw5kS4Vt/g
        lwMWzwxfJh0jdbzgwIWze6B0SmzuTnfGkiUXwN155w==
X-Google-Smtp-Source: APiQypJ0bW8RYsjPXbL9qEMFPDykIG2LZMaBEua5O/565lR8NmnrhrWeVSiFufYz/Cw5fwNDYVzxnpNff+6Uaebhdd0=
X-Received: by 2002:a05:6402:160e:: with SMTP id f14mr18573307edv.301.1586162167356;
 Mon, 06 Apr 2020 01:36:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200401144109.GA29945@gardel-login> <CAJfpegs3uDzFTE4PCjZ7aZsEh8b=iy_LqO1DBJoQzkP+i4aBmw@mail.gmail.com>
 <2590640.1585757211@warthog.procyon.org.uk> <CAJfpegsXqxizOGwa045jfT6YdUpMxpXET-yJ4T8qudyQbCGkHQ@mail.gmail.com>
 <36e45eae8ad78f7b8889d9d03b8846e78d735d28.camel@themaw.net>
 <CAJfpegsCDWehsTRQ9UJYuQnghnE=M8L0_bJBTTPA+Upu87t90w@mail.gmail.com>
 <27994c53034c8f769ea063a54169317c3ee62c04.camel@themaw.net>
 <20200403111144.GB34663@gardel-login> <CAJfpeguQAw+Mgc8QBNd+h3KV8=Y-SOGT7TB_N_54wa8MCoOSzg@mail.gmail.com>
 <20200403151223.GB34800@gardel-login> <20200403203024.GB27105@fieldses.org>
In-Reply-To: <20200403203024.GB27105@fieldses.org>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 6 Apr 2020 10:35:55 +0200
Message-ID: <CAJfpegvxnp8N-o-iTXzj0UnYZbDPfms1zpwcHf1tdhRJ4au3Og@mail.gmail.com>
Subject: Re: Upcoming: Notifications, FS notifications and fsinfo()
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     Lennart Poettering <mzxreary@0pointer.de>,
        Ian Kent <raven@themaw.net>,
        David Howells <dhowells@redhat.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>, dray@redhat.com,
        Karel Zak <kzak@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Steven Whitehouse <swhiteho@redhat.com>,
        Jeff Layton <jlayton@redhat.com>, andres@anarazel.de,
        keyrings@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Aleksa Sarai <cyphar@cyphar.com>
Content-Type: multipart/mixed; boundary="0000000000008acd9805a29b28ff"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--0000000000008acd9805a29b28ff
Content-Type: text/plain; charset="UTF-8"

On Fri, Apr 3, 2020 at 10:30 PM J. Bruce Fields <bfields@fieldses.org> wrote:
>
> On Fri, Apr 03, 2020 at 05:12:23PM +0200, Lennart Poettering wrote:
> > BTW, while we are at it: one more thing I'd love to see exposed by
> > statx() is a simple flag whether the inode is a mount point. There's
> > plenty code that implements a test like this all over the place, and
> > it usually isn't very safe. There's one implementation in util-linux
> > for example (in the /usr/bin/mountpoint binary), and another one in
> > systemd. Would be awesome to just have a statx() return flag for that,
> > that would make things *so* much easier and more robust. because in
> > fact most code isn't very good that implements this, as much of it
> > just compares st_dev of the specified file and its parent. Better code
> > compares the mount ID, but as mentioned that's not as pretty as it
> > could be so far...
>
> nfs-utils/support/misc/mountpoint.c:check_is_mountpoint() stats the file
> and ".." and returns true if they have different st_dev or the same
> st_ino.  Comparing mount ids sounds better.
>
> So anyway, yes, everybody reinvents the wheel here, and this would be
> useful.  (And, yes, we want to know for the vfsmount, we don't care
> whether the same inode is used as a mountpoint someplace else.)

Attaching a patch.

There's some ambiguity about what is a "mountpoint" and what these
tools are interested in.  My guess is that they are not interested in
an object being a mount point (something where another object is
mounted) but being a mount root (this is the object mounted at the
mount point).  I.e

fd = open("/mnt", O_PATH);
mount("/bin", "/mnt", NULL, MS_BIND, NULL);
statx(AT_FDCWD, "/mnt", 0, 0, &stx1);
statx(fd, "", AT_EMPTY_PATH, 0, &stx2);
printf("mount_root(/mnt) = %c, mount_root(fd) = %c\n",
    stx1.stx_attributes & STATX_ATTR_MOUNT_ROOT ? 'y' : 'n',
    stx2.stx_attributes & STATX_ATTR_MOUNT_ROOT ? 'y' : 'n');

Would print:
mount_root(/mnt) = y, mount_root(fd) = n

Thanks,
Miklos

--0000000000008acd9805a29b28ff
Content-Type: text/x-patch; charset="US-ASCII"; name="statx-add-mount_root.patch"
Content-Disposition: attachment; filename="statx-add-mount_root.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_k8o7ysgp0>
X-Attachment-Id: f_k8o7ysgp0

RnJvbTogTWlrbG9zIFN6ZXJlZGkgPG1zemVyZWRpQHJlZGhhdC5jb20+ClN1YmplY3Q6IHN0YXR4
OiBhZGQgbW91bnRfcm9vdAoKRGV0ZXJtaW5pbmcgd2hldGhlciBhIHBhdGggb3IgZmlsZSBkZXNj
cmlwdG9yIHJlZmVycyB0byBhIG1vdW50cG9pbnQgKG9yCm1vcmUgcHJlY2lzZWx5IGEgbW91bnQg
cm9vdCkgaXMgbm90IHRyaXZpYWwgdXNpbmcgY3VycmVudCB0b29scy4KCkFkZCBhIGZsYWcgdG8g
c3RhdHggdGhhdCBpbmRpY2F0ZXMgd2hldGhlciB0aGUgcGF0aCBvciBmZCByZWZlcnMgdG8gdGhl
CnJvb3Qgb2YgYSBtb3VudCBvciBub3QuCgpSZXBvcnRlZC1ieTogTGVubmFydCBQb2V0dGVyaW5n
IDxtenhyZWFyeUAwcG9pbnRlci5kZT4KUmVwb3J0ZWQtYnk6IEouIEJydWNlIEZpZWxkcyA8YmZp
ZWxkc0BmaWVsZHNlcy5vcmc+ClNpZ25lZC1vZmYtYnk6IE1pa2xvcyBTemVyZWRpIDxtc3plcmVk
aUByZWRoYXQuY29tPgotLS0KIGZzL3N0YXQuYyAgICAgICAgICAgICAgICAgfCAgICAzICsrKwog
aW5jbHVkZS91YXBpL2xpbnV4L3N0YXQuaCB8ICAgIDEgKwogMiBmaWxlcyBjaGFuZ2VkLCA0IGlu
c2VydGlvbnMoKykKCi0tLSBhL2luY2x1ZGUvdWFwaS9saW51eC9zdGF0LmgKKysrIGIvaW5jbHVk
ZS91YXBpL2xpbnV4L3N0YXQuaApAQCAtMTcyLDYgKzE3Miw3IEBAIHN0cnVjdCBzdGF0eCB7CiAj
ZGVmaW5lIFNUQVRYX0FUVFJfTk9EVU1QCQkweDAwMDAwMDQwIC8qIFtJXSBGaWxlIGlzIG5vdCB0
byBiZSBkdW1wZWQgKi8KICNkZWZpbmUgU1RBVFhfQVRUUl9FTkNSWVBURUQJCTB4MDAwMDA4MDAg
LyogW0ldIEZpbGUgcmVxdWlyZXMga2V5IHRvIGRlY3J5cHQgaW4gZnMgKi8KICNkZWZpbmUgU1RB
VFhfQVRUUl9BVVRPTU9VTlQJCTB4MDAwMDEwMDAgLyogRGlyOiBBdXRvbW91bnQgdHJpZ2dlciAq
LworI2RlZmluZSBTVEFUWF9BVFRSX01PVU5UX1JPT1QJCTB4MDAwMDIwMDAgLyogUm9vdCBvZiBh
IG1vdW50ICovCiAjZGVmaW5lIFNUQVRYX0FUVFJfVkVSSVRZCQkweDAwMTAwMDAwIC8qIFtJXSBW
ZXJpdHkgcHJvdGVjdGVkIGZpbGUgKi8KIAogCi0tLSBhL2ZzL3N0YXQuYworKysgYi9mcy9zdGF0
LmMKQEAgLTIwMiw2ICsyMDIsOSBAQCBpbnQgdmZzX3N0YXR4KGludCBkZmQsIGNvbnN0IGNoYXIg
X191c2VyCiAJZXJyb3IgPSB2ZnNfZ2V0YXR0cigmcGF0aCwgc3RhdCwgcmVxdWVzdF9tYXNrLCBm
bGFncyk7CiAJc3RhdC0+bW50X2lkID0gcmVhbF9tb3VudChwYXRoLm1udCktPm1udF9pZDsKIAlz
dGF0LT5yZXN1bHRfbWFzayB8PSBTVEFUWF9NTlRfSUQ7CisJaWYgKHBhdGgubW50LT5tbnRfcm9v
dCA9PSBwYXRoLmRlbnRyeSkKKwkJc3RhdC0+YXR0cmlidXRlcyB8PSBTVEFUWF9BVFRSX01PVU5U
X1JPT1Q7CisJc3RhdC0+YXR0cmlidXRlc19tYXNrIHw9IFNUQVRYX0FUVFJfTU9VTlRfUk9PVDsK
IAlwYXRoX3B1dCgmcGF0aCk7CiAJaWYgKHJldHJ5X2VzdGFsZShlcnJvciwgbG9va3VwX2ZsYWdz
KSkgewogCQlsb29rdXBfZmxhZ3MgfD0gTE9PS1VQX1JFVkFMOwo=
--0000000000008acd9805a29b28ff--
