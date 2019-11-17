Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA4A1FFB75
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Nov 2019 20:21:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726089AbfKQTVL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 17 Nov 2019 14:21:11 -0500
Received: from mail-lj1-f174.google.com ([209.85.208.174]:43825 "EHLO
        mail-lj1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726070AbfKQTVL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 17 Nov 2019 14:21:11 -0500
Received: by mail-lj1-f174.google.com with SMTP id y23so16284157ljh.10
        for <linux-fsdevel@vger.kernel.org>; Sun, 17 Nov 2019 11:21:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9o5Rr6p1RxZ72tpzaroFaDH4nHZbfJkcGWlbwHGYPZo=;
        b=ZiMIfR4AjFv/jhJFvFDre8SMJgUYCcl09+lxkMQQln87OoLJxqOTuFWC2+NlCK6IzF
         u6sYFWIKTKt15f/nAGiW7KCsuPofIkYwXcJZdnFE6CQDl4mFvmD4d7wAH5sfYedZulRS
         DaN+XYEks/6P7slQYw+1ukPouZeoxF412AFXc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9o5Rr6p1RxZ72tpzaroFaDH4nHZbfJkcGWlbwHGYPZo=;
        b=saaTn7qA9d5rYz8tT55GoyV8ZGsqEypveNC6btgkTFXAYtiVM54JG3mCJVftq8Rd6D
         qhxVqJQEaZT0Zj2yHPv3+QyxxgvKx6cvIRivzlpo2sQRuQHl/ReQEGeKWCLDP52O5tOW
         47uq84mjQ6RfG6UXbMlTZqeUrlDtvp8mGeTkueA4SyEjlapc3jUcSYccSXViljEcdFyD
         Mdb38rF5tLJKMipeNvHZcNeJq+WUSL7ugWVQYct84AT6LD91Vk1kEBnPyQ3GQRqwTW+D
         Vls8sDnmS/rYv1vaiMUMUnzeNyLz/O7DYPzje9Xz4Lci94a0g9Pa9qoF8ADcBaBCWR7E
         y1WA==
X-Gm-Message-State: APjAAAWr9g5RGmOF4SfFGYG0ag7QwF3QpM5N3lIQvtxZO+Ga++wYB60v
        xIPvTWYezexHVZ8BTQ6vYMmysbSB92I=
X-Google-Smtp-Source: APXvYqy6pVtIvhhCKXW1BD5rjxKL+GxvYNRLNdiwQ4Ow3cq1fIAjdN586AaaqdSEEmKIoTeyfD+Jqg==
X-Received: by 2002:a2e:8ed1:: with SMTP id e17mr18664238ljl.52.1574018468002;
        Sun, 17 Nov 2019 11:21:08 -0800 (PST)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id h2sm6377095lfd.58.2019.11.17.11.21.05
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Nov 2019 11:21:06 -0800 (PST)
Received: by mail-lj1-f170.google.com with SMTP id k15so16314449lja.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 17 Nov 2019 11:21:05 -0800 (PST)
X-Received: by 2002:a2e:8919:: with SMTP id d25mr18387414lji.97.1574018465184;
 Sun, 17 Nov 2019 11:21:05 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=wjp6yR-gBNYXPzrHQHq+wX_t6WfwrF_S3EEUq9ccz3vng@mail.gmail.com>
 <CANn89i+OBZOq-q4GWAxKVRau6nHYMo3v4y-c1vUb_O8nvra1RQ@mail.gmail.com>
 <CAHk-=wg6Zaf09i0XNgCmOzKKWnoAPMfA7WX9OY1Ow1YtF0ZP3A@mail.gmail.com>
 <CANn89i+hRhweL2N=r1chMpWKU2ue8fiQO=dLxGs9sgLFbgHEWQ@mail.gmail.com>
 <CANn89iJiuOkKc2AVmccM8z9e_d4zbV61K-3z49ao1UwRDdFiHw@mail.gmail.com>
 <CAHk-=wgkwBjQWyDQi8mu06DXr_v_4zui+33fk3eK89rPof5b+A@mail.gmail.com>
 <CAHk-=whFejio0dC3T3a-5wuy9aum45unqacxkFpt5yo+-J502w@mail.gmail.com>
 <20191112165033.GA7905@deco.navytux.spb.ru> <CAHk-=witx+fY-no_UTNhsxXvZnOaFLM80Q8so6Mvm6hUTjZdGg@mail.gmail.com>
 <CAHk-=whPFjpOEfU5N4qz_gGC8_=NLh1VkBLm09K1S1Gcma5pzA@mail.gmail.com> <20191117185623.GA22280@deco.navytux.spb.ru>
In-Reply-To: <20191117185623.GA22280@deco.navytux.spb.ru>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 17 Nov 2019 11:20:48 -0800
X-Gmail-Original-Message-ID: <CAHk-=whdm7qeqydbnC_EGDaiWcG-F-oe09o8T3ChORLnRZFE=w@mail.gmail.com>
Message-ID: <CAHk-=whdm7qeqydbnC_EGDaiWcG-F-oe09o8T3ChORLnRZFE=w@mail.gmail.com>
Subject: Re: KCSAN: data-race in __alloc_file / __alloc_file
To:     Kirill Smelkov <kirr@nexedi.com>
Cc:     Eric Dumazet <edumazet@google.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Alan Stern <stern@rowland.harvard.edu>,
        Marco Elver <elver@google.com>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        syzbot <syzbot+3ef049d50587836c0606@syzkaller.appspotmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>
Content-Type: multipart/mixed; boundary="0000000000007cedf905978fbbbb"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--0000000000007cedf905978fbbbb
Content-Type: text/plain; charset="UTF-8"

On Sun, Nov 17, 2019 at 10:56 AM Kirill Smelkov <kirr@nexedi.com> wrote:
>
>   I'd like to take a time break for now.
>   I will try to return to this topic after finishing my main work first.
>   I apologize for the inconvenience. )

Sure, no problem, appreciate that you're looking at it.

I *think* the pipe and socket case should be fixed by something like
this, but it is entirely and utterly untested.

              Linus

--0000000000007cedf905978fbbbb
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_k33dxwzp0>
X-Attachment-Id: f_k33dxwzp0

IGZzL3BpcGUuYyAgICB8IDYgKysrKy0tCiBuZXQvc29ja2V0LmMgfCAxICsKIDIgZmlsZXMgY2hh
bmdlZCwgNSBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2ZzL3Bp
cGUuYyBiL2ZzL3BpcGUuYwppbmRleCA4YTJhYjJmOTc0YmQuLmRlNmRlZTU1OWQ0MSAxMDA2NDQK
LS0tIGEvZnMvcGlwZS5jCisrKyBiL2ZzL3BpcGUuYwpAQCAtNzgzLDYgKzc4Myw3IEBAIGludCBj
cmVhdGVfcGlwZV9maWxlcyhzdHJ1Y3QgZmlsZSAqKnJlcywgaW50IGZsYWdzKQogCX0KIAogCWYt
PnByaXZhdGVfZGF0YSA9IGlub2RlLT5pX3BpcGU7CisJc3RyZWFtX29wZW4oaW5vZGUsIGYpOwog
CiAJcmVzWzBdID0gYWxsb2NfZmlsZV9jbG9uZShmLCBPX1JET05MWSB8IChmbGFncyAmIE9fTk9O
QkxPQ0spLAogCQkJCSAgJnBpcGVmaWZvX2ZvcHMpOwpAQCAtNzkxLDYgKzc5Miw3IEBAIGludCBj
cmVhdGVfcGlwZV9maWxlcyhzdHJ1Y3QgZmlsZSAqKnJlcywgaW50IGZsYWdzKQogCQlmcHV0KGYp
OwogCQlyZXR1cm4gUFRSX0VSUihyZXNbMF0pOwogCX0KKwlzdHJlYW1fb3Blbihpbm9kZSwgZik7
CiAJcmVzWzBdLT5wcml2YXRlX2RhdGEgPSBpbm9kZS0+aV9waXBlOwogCXJlc1sxXSA9IGY7CiAJ
cmV0dXJuIDA7CkBAIC05MzEsOSArOTMzLDkgQEAgc3RhdGljIGludCBmaWZvX29wZW4oc3RydWN0
IGlub2RlICppbm9kZSwgc3RydWN0IGZpbGUgKmZpbHApCiAJX19waXBlX2xvY2socGlwZSk7CiAK
IAkvKiBXZSBjYW4gb25seSBkbyByZWd1bGFyIHJlYWQvd3JpdGUgb24gZmlmb3MgKi8KLQlmaWxw
LT5mX21vZGUgJj0gKEZNT0RFX1JFQUQgfCBGTU9ERV9XUklURSk7CisJc3RyZWFtX29wZW4oaW5v
ZGUsIGZpbHApOwogCi0Jc3dpdGNoIChmaWxwLT5mX21vZGUpIHsKKwlzd2l0Y2ggKGZpbHAtPmZf
bW9kZSAmIChGTU9ERV9SRUFEIHwgRk1PREVfV1JJVEUpKSB7CiAJY2FzZSBGTU9ERV9SRUFEOgog
CS8qCiAJICogIE9fUkRPTkxZCmRpZmYgLS1naXQgYS9uZXQvc29ja2V0LmMgYi9uZXQvc29ja2V0
LmMKaW5kZXggNmE5YWI3YThiMWQyLi4zYzZkNjBlYWRmN2EgMTAwNjQ0Ci0tLSBhL25ldC9zb2Nr
ZXQuYworKysgYi9uZXQvc29ja2V0LmMKQEAgLTQwNCw2ICs0MDQsNyBAQCBzdHJ1Y3QgZmlsZSAq
c29ja19hbGxvY19maWxlKHN0cnVjdCBzb2NrZXQgKnNvY2ssIGludCBmbGFncywgY29uc3QgY2hh
ciAqZG5hbWUpCiAKIAlzb2NrLT5maWxlID0gZmlsZTsKIAlmaWxlLT5wcml2YXRlX2RhdGEgPSBz
b2NrOworCXN0cmVhbV9vcGVuKFNPQ0tfSU5PREUoc29jayksIGZpbGUpOwogCXJldHVybiBmaWxl
OwogfQogRVhQT1JUX1NZTUJPTChzb2NrX2FsbG9jX2ZpbGUpOwo=
--0000000000007cedf905978fbbbb--
