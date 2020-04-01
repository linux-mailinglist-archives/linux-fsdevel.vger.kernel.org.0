Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 07F8119ACF1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Apr 2020 15:34:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732677AbgDANer (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Apr 2020 09:34:47 -0400
Received: from mail-ed1-f48.google.com ([209.85.208.48]:34306 "EHLO
        mail-ed1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732605AbgDANer (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Apr 2020 09:34:47 -0400
Received: by mail-ed1-f48.google.com with SMTP id o1so11369076edv.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 01 Apr 2020 06:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vvMhsyalHgLR7BhFwzAsPtNqVbCXBf3wROS4TZNwS2o=;
        b=dJzquYYlrEleQ255CNcwNKohJNgWkZ0preJPVYpCjZ+FTERm/igjSD889iQgLotvB1
         JQTsU14tWQbRa+xx5icx3fWophVuRCJKg4X4IpINCAHbIH15Qx5oUFEtINoXlKljmYRt
         8kD7k4R6FT5gPp47zwJs/pvfUjM25V9X6ksiw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vvMhsyalHgLR7BhFwzAsPtNqVbCXBf3wROS4TZNwS2o=;
        b=oF7t5nIAjf9q0tyFfYlFtcMVBkolkhKhdw49jfNfTriIUrzDHtVOOaqGQixxSAUEPY
         v83rhVoz1zJ8cMG/vC/uhX2Ir8t2koMhWMQ5dLl0K0pNJLaLdvuh0WnfwKXPrKJdk9Pi
         8tfkClj+L/tqRTnHvxZOetD1Y1cQaAarGjYFdQBCzMIZCerG+VgaIX+rsphuTfOO4dzS
         avyWPNhmY9rEt4CGN80hNeRaWzvxV3bDxD0ha7/K5Z2302LhoMJIqQJdcC62JFcs5Zfx
         XXM8P+vYGZpA/87u5L6QcIC5KN6wIz5tXMNdTQTlSWVe39KFNRlkVXsZAqquyg7teZse
         r4UQ==
X-Gm-Message-State: ANhLgQ3EB1PdEwtDcuUsWvH9k4sq/Xv4/m2jfD7Z2ejXmNXlnJHHr/sE
        FcxuWww/ByZelFQp8iTN+kbZS4DXYgBQ24UO8YxVug==
X-Google-Smtp-Source: ADFU+vtrF9QMVj3daT1dm0uQWwcAkf/pmHNzlVbS9TuTi0vF12GbPKTIN11J7V3H+UIvcSUdkirmtjYjIySZ1J7mpqg=
X-Received: by 2002:a17:906:6545:: with SMTP id u5mr11392194ejn.27.1585748082818;
 Wed, 01 Apr 2020 06:34:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200330211700.g7evnuvvjenq3fzm@wittgenstein> <1445647.1585576702@warthog.procyon.org.uk>
 <2418286.1585691572@warthog.procyon.org.uk> <20200401090445.6t73dt7gz36bv4rh@ws.net.home>
In-Reply-To: <20200401090445.6t73dt7gz36bv4rh@ws.net.home>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 1 Apr 2020 15:34:31 +0200
Message-ID: <CAJfpeguu52VuLAzjFH4rJJ7WYLB5ag8y+r3VMb-0bqH8c-uJUg@mail.gmail.com>
Subject: Re: Upcoming: Notifications, FS notifications and fsinfo()
To:     Karel Zak <kzak@redhat.com>
Cc:     David Howells <dhowells@redhat.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>, dray@redhat.com,
        Miklos Szeredi <mszeredi@redhat.com>,
        Steven Whitehouse <swhiteho@redhat.com>,
        Jeff Layton <jlayton@redhat.com>, Ian Kent <raven@themaw.net>,
        andres@anarazel.de, keyrings@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lennart Poettering <lennart@poettering.net>,
        Aleksa Sarai <cyphar@cyphar.com>
Content-Type: multipart/mixed; boundary="0000000000002e407205a23abf26"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--0000000000002e407205a23abf26
Content-Type: text/plain; charset="UTF-8"

On Wed, Apr 1, 2020 at 11:05 AM Karel Zak <kzak@redhat.com> wrote:
>
> On Tue, Mar 31, 2020 at 10:52:52PM +0100, David Howells wrote:
> > Christian Brauner <christian.brauner@ubuntu.com> wrote:
> >
> > > querying all properties of a mount atomically all-at-once,
> >
> > I don't actually offer that, per se.
> >
> > Having an atomic all-at-once query for a single mount is actually quite a
> > burden on the system.  There's potentially a lot of state involved, much of
> > which you don't necessarily need.
>
> If all means "all possible attributes" than it is unnecessary, for
> example ext4 timestamps or volume uuid/label are rarely necessary.
> We usually need together (as consistent set):
>
>     source
>     mountpoint
>     FS type
>     FS root (FSINFO_ATTR_MOUNT_PATH)
>     FS options (FSINFO_ATTR_CONFIGURATION)
>     VFS attributes
>     VFS propagation flags
>     mount ID
>     parent ID
>     devno (or maj:min)

This is trivial with mountfs (reuse format of /proc/PID/mountinfo):

# cat /mnt/30/info
30 20 0:14 / /mnt rw,relatime - mountfs none rw

Attached patch applies against readfile patch.

We might want something more generic, and it won't get any simpler:

 mount.h          |    1 +
 mountfs/super.c  |   12 +++++++++++-
 proc_namespace.c |    2 +-
 3 files changed, 13 insertions(+), 2 deletions(-)

Thanks,
Miklos

--0000000000002e407205a23abf26
Content-Type: text/x-patch; charset="US-ASCII"; name="mountfs-info.patch"
Content-Disposition: attachment; filename="mountfs-info.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_k8hdan1o0>
X-Attachment-Id: f_k8hdan1o0

LS0tCiBmcy9tb3VudC5oICAgICAgICAgIHwgICAgMSArCiBmcy9tb3VudGZzL3N1cGVyLmMgIHwg
ICAxMiArKysrKysrKysrKy0KIGZzL3Byb2NfbmFtZXNwYWNlLmMgfCAgICAyICstCiAzIGZpbGVz
IGNoYW5nZWQsIDEzIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCgotLS0gYS9mcy9tb3Vu
dC5oCisrKyBiL2ZzL21vdW50LmgKQEAgLTE4NiwzICsxODYsNCBAQCB2b2lkIG1vdW50ZnNfY3Jl
YXRlKHN0cnVjdCBtb3VudCAqbW50KTsKIGV4dGVybiB2b2lkIG1vdW50ZnNfcmVtb3ZlKHN0cnVj
dCBtb3VudCAqbW50KTsKIGludCBtb3VudGZzX2xvb2t1cF9pbnRlcm5hbChzdHJ1Y3QgdmZzbW91
bnQgKm0sIHN0cnVjdCBwYXRoICpwYXRoKTsKIAoraW50IHNob3dfbW91bnRpbmZvKHN0cnVjdCBz
ZXFfZmlsZSAqbSwgc3RydWN0IHZmc21vdW50ICptbnQpOwotLS0gYS9mcy9tb3VudGZzL3N1cGVy
LmMKKysrIGIvZnMvbW91bnRmcy9zdXBlci5jCkBAIC0yMiw3ICsyMiw3IEBAIHN0cnVjdCBtb3Vu
dGZzX2VudHJ5IHsKIAogc3RhdGljIGNvbnN0IGNoYXIgKm1vdW50ZnNfYXR0cnNbXSA9IHsKIAki
cm9vdCIsICJtb3VudHBvaW50IiwgImlkIiwgInBhcmVudCIsICJvcHRpb25zIiwgImNoaWxkcmVu
IiwKLQkiZ3JvdXAiLCAibWFzdGVyIiwgInByb3BhZ2F0ZV9mcm9tIiwgImNvdW50ZXIiCisJImdy
b3VwIiwgIm1hc3RlciIsICJwcm9wYWdhdGVfZnJvbSIsICJjb3VudGVyIiwgImluZm8iCiB9Owog
CiAjZGVmaW5lIE1PVU5URlNfSU5PKGlkKSAoKCh1bnNpZ25lZCBsb25nKSBpZCArIDEpICogXApA
QCAtMTI2LDExICsxMjYsMjEgQEAgc3RhdGljIGludCBtb3VudGZzX2F0dHJfc2hvdyhzdHJ1Y3Qg
c2VxXwogCQlpZiAoSVNfTU5UX1NMQVZFKG1udCkpIHsKIAkJCWdldF9mc19yb290KGN1cnJlbnQt
PmZzLCAmcm9vdCk7CiAJCQl0bXAgPSBnZXRfZG9taW5hdGluZ19pZChtbnQsICZyb290KTsKKwkJ
CXBhdGhfcHV0KCZyb290KTsKIAkJCWlmICh0bXApCiAJCQkJc2VxX3ByaW50ZihzZiwgIiVpXG4i
LCB0bXApOwogCQl9CiAJfSBlbHNlIGlmIChzdHJjbXAobmFtZSwgImNvdW50ZXIiKSA9PSAwKSB7
CiAJCXNlcV9wcmludGYoc2YsICIldVxuIiwgYXRvbWljX3JlYWQoJm1udC0+bW50X3RvcG9sb2d5
X2NoYW5nZXMpKTsKKwl9IGVsc2UgaWYgKHN0cmNtcChuYW1lLCAiaW5mbyIpID09IDApIHsKKwkJ
c3RydWN0IHByb2NfbW91bnRzIHAgPSB7fTsKKworCQlXQVJOX09OKHNmLT5wcml2YXRlKTsKKwkJ
c2YtPnByaXZhdGUgPSAmcDsKKwkJZ2V0X2ZzX3Jvb3QoY3VycmVudC0+ZnMsICZwLnJvb3QpOwor
CQllcnIgPSBzaG93X21vdW50aW5mbyhzZiwgbSk7CisJCXBhdGhfcHV0KCZwLnJvb3QpOworCQlz
Zi0+cHJpdmF0ZSA9IE5VTEw7CiAJfSBlbHNlIHsKIAkJV0FSTl9PTigxKTsKIAkJZXJyID0gLUVJ
TzsKLS0tIGEvZnMvcHJvY19uYW1lc3BhY2UuYworKysgYi9mcy9wcm9jX25hbWVzcGFjZS5jCkBA
IC0xMTAsNyArMTEwLDcgQEAgc3RhdGljIGludCBzaG93X3Zmc21udChzdHJ1Y3Qgc2VxX2ZpbGUg
KgogCXJldHVybiBlcnI7CiB9CiAKLXN0YXRpYyBpbnQgc2hvd19tb3VudGluZm8oc3RydWN0IHNl
cV9maWxlICptLCBzdHJ1Y3QgdmZzbW91bnQgKm1udCkKK2ludCBzaG93X21vdW50aW5mbyhzdHJ1
Y3Qgc2VxX2ZpbGUgKm0sIHN0cnVjdCB2ZnNtb3VudCAqbW50KQogewogCXN0cnVjdCBwcm9jX21v
dW50cyAqcCA9IG0tPnByaXZhdGU7CiAJc3RydWN0IG1vdW50ICpyID0gcmVhbF9tb3VudChtbnQp
Owo=
--0000000000002e407205a23abf26--
