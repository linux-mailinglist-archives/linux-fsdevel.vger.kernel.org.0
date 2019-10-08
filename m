Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 408AFCF17E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2019 06:09:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729997AbfJHEJi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Oct 2019 00:09:38 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:45398 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725858AbfJHEJg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Oct 2019 00:09:36 -0400
Received: by mail-lj1-f194.google.com with SMTP id q64so15936976ljb.12
        for <linux-fsdevel@vger.kernel.org>; Mon, 07 Oct 2019 21:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bnKFcjxBKN6Qpqxh5XkObDMG8fH2wT4HUjifdtCIY7U=;
        b=LCTCldBdoohmi8kv7PcXweH6uWk7dC5wCVDPU9bVrAuYhDOtJV9+8ZUI3ZUecmGXb8
         63QN/52Kf/NOj4RH1TMXblY6soPXq/L0PBd6sRBHAJAl8T1SAHO0vB0b1ljtolfq8auX
         ZtLweTHsVLVOlJLg/B4F8wbqExDFYmMKBwmPU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bnKFcjxBKN6Qpqxh5XkObDMG8fH2wT4HUjifdtCIY7U=;
        b=tnMXD4qV06nwrowK7hFuKgkkBHmHecDUIg5Be58lZyTtalIVoiLlopcsokg/EkgAo4
         N1kftaoG4F35zjUr905eLYJgh7XWRnUbUQVq3Wf9QxT8tYUrRD6oxpd05iDSYTACiUL0
         8HeV/P49px/aACk9GVHE9NZLbtCd1bJDjKI6zYIvpYpHTeESTVe3Jltm9/6mymuj5KPc
         lgLsZ46kJdOpN/oRxwTC6Qq8XqKA0bzFSWsvjLQn1oehzFTQ3cdhJdjeW/Zx0o1LMQAU
         +spmCx2oQj+PJjWf06qO05PpnZwCwRGS94tF1gMUyMiW3uz+CTr0kHVKl8AoqFhivOpt
         GaSg==
X-Gm-Message-State: APjAAAWv8kYKif9K1Xum5ZIgv17rUmqjvNQ0ZdhTYdJst/hMSJm9GH/w
        Gd0j9cifTnZ+2YR2lW1OKeUID0vofzw=
X-Google-Smtp-Source: APXvYqzMu52R7y7A+Uny/0UylQCJ51pbfeIeMpQopZeDuL95k8LhxsOcWHzmt5jfGN5qZnrJL8KzqA==
X-Received: by 2002:a2e:9e8b:: with SMTP id f11mr16303679ljk.153.1570507772508;
        Mon, 07 Oct 2019 21:09:32 -0700 (PDT)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id v1sm3234976lfa.87.2019.10.07.21.09.30
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Oct 2019 21:09:31 -0700 (PDT)
Received: by mail-lj1-f174.google.com with SMTP id b20so15953371ljj.5
        for <linux-fsdevel@vger.kernel.org>; Mon, 07 Oct 2019 21:09:30 -0700 (PDT)
X-Received: by 2002:a2e:86d5:: with SMTP id n21mr20643986ljj.1.1570507770530;
 Mon, 07 Oct 2019 21:09:30 -0700 (PDT)
MIME-Version: 1.0
References: <20191006222046.GA18027@roeck-us.net> <CAHk-=wgrqwuZJmwbrjhjCFeSUu2i57unaGOnP4qZAmSyuGwMZA@mail.gmail.com>
 <CAHk-=wjRPerXedTDoBbJL=tHBpH+=sP6pX_9NfgWxpnmHC5RtQ@mail.gmail.com>
 <5f06c138-d59a-d811-c886-9e73ce51924c@roeck-us.net> <CAHk-=whAQWEMADgxb_qAw=nEY4OnuDn6HU4UCSDMNT5ULKvg3g@mail.gmail.com>
 <20191007012437.GK26530@ZenIV.linux.org.uk> <CAHk-=whKJfX579+2f-CHc4_YmEmwvMe_Csr0+CPfLAsSAdfDoA@mail.gmail.com>
 <20191007025046.GL26530@ZenIV.linux.org.uk> <CAHk-=whraNSys_Lj=Ut1EA=CJEfw2Uothh+5-WL+7nDJBegWcQ@mail.gmail.com>
 <CAHk-=witTXMGsc9ZAK4hnKnd_O7u8b1eiou-6cfjt4aOcWvruQ@mail.gmail.com> <20191008032912.GQ26530@ZenIV.linux.org.uk>
In-Reply-To: <20191008032912.GQ26530@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 7 Oct 2019 21:09:14 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiAyZmsEp6oQQgHiuaDU0bLj=OVHSGV_OfvHRSXNPYABw@mail.gmail.com>
Message-ID: <CAHk-=wiAyZmsEp6oQQgHiuaDU0bLj=OVHSGV_OfvHRSXNPYABw@mail.gmail.com>
Subject: Re: [PATCH] Convert filldir[64]() from __put_user() to unsafe_put_user()
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="000000000000c7beeb05945e55b8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--000000000000c7beeb05945e55b8
Content-Type: text/plain; charset="UTF-8"

On Mon, Oct 7, 2019 at 8:29 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> For x86?  Sure, why not...  Note, BTW, that for short constant-sized
> copies we *do* STAC/CLAC at the call site - see those
>                 __uaccess_begin_nospec();
> in raw_copy_{from,to}_user() in the switches...

Yeah, an that code almost never actually triggers in practice. The
code is pointless and dead.

The thing is, it's only ever used for the double undescore versions,
and the ones that do have have it are almost never constant sizes in
the first place.

And yes, there's like a couple of cases in the whole kernel.

Just remove those constant size cases. They are pointless and just
complicate our headers and slow down the compile for no good reason.

Try the attached patch, and then count the number of "rorx"
instructions in the kernel. Hint: not many. On my personal config,
this triggers 15 times in the whole kernel build (not counting
modules).

It's not worth it. The "speedup" from using __copy_{to,from}_user()
with the fancy inlining is negligible. All the cost is in the
STAC/CLAC anyway, the code might as well be deleted.

> 1) cross-architecture user_access_begin_dont_use(): on everything
> except x86 it's empty, on x86 - __uaccess_begin_nospec().

No, just do a proper range check, and use user_access_begin()

Stop trying to optimize that range check away. It's a couple of fast
instructions.

The only ones who don't want the range check are the actual kernel
copy ones, but they don't want the user_access_begin() either.

> void *copy_mount_options(const void __user * data)
> {
>         unsigned offs, size;
>         char *copy;
>
>         if (!data)
>                 return NULL;
>
>         copy = kmalloc(PAGE_SIZE, GFP_KERNEL);
>         if (!copy)
>                 return ERR_PTR(-ENOMEM);
>
>         offs = (unsigned long)untagged_addr(data) & (PAGE_SIZE - 1);
>
>         if (copy_from_user(copy, data, PAGE_SIZE - offs)) {
>                 kfree(copy);
>                 return ERR_PTR(-EFAULT);
>         }
>         if (offs) {
>                 if (copy_from_user(copy, data + PAGE_SIZE - offs, offs))
>                         memset(copy + PAGE_SIZE - offs, 0, offs);
>         }
>         return copy;
> }
>
> on the theory that any fault halfway through a page means a race with
> munmap/mprotect/etc. and we can just pretend we'd lost the race entirely.
> And to hell with exact_copy_from_user(), byte-by-byte copying, etc.

Looks reasonable.

              Linus

--000000000000c7beeb05945e55b8
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_k1hbrkuh0>
X-Attachment-Id: f_k1hbrkuh0

ZGlmZiAtLWdpdCBhL2FyY2gveDg2L2luY2x1ZGUvYXNtL3VhY2Nlc3NfNjQuaCBiL2FyY2gveDg2
L2luY2x1ZGUvYXNtL3VhY2Nlc3NfNjQuaAppbmRleCA1Y2QxY2FhOGJjNjUuLmRiNThjNDQzNmNl
MyAxMDA2NDQKLS0tIGEvYXJjaC94ODYvaW5jbHVkZS9hc20vdWFjY2Vzc182NC5oCisrKyBiL2Fy
Y2gveDg2L2luY2x1ZGUvYXNtL3VhY2Nlc3NfNjQuaApAQCAtNjIsNiArNjIsOCBAQCBjb3B5X3Rv
X3VzZXJfbWNzYWZlKHZvaWQgKnRvLCBjb25zdCB2b2lkICpmcm9tLCB1bnNpZ25lZCBsZW4pCiAJ
cmV0dXJuIHJldDsKIH0KIAorI2RlZmluZSBtYXJrZXIoeCkgYXNtIHZvbGF0aWxlKCJyb3J4ICQi
ICN4ICIsJXJheCwlcmR4IikKKwogc3RhdGljIF9fYWx3YXlzX2lubGluZSBfX211c3RfY2hlY2sg
dW5zaWduZWQgbG9uZwogcmF3X2NvcHlfZnJvbV91c2VyKHZvaWQgKmRzdCwgY29uc3Qgdm9pZCBf
X3VzZXIgKnNyYywgdW5zaWduZWQgbG9uZyBzaXplKQogewpAQCAtNzIsMzAgKzc0LDM1IEBAIHJh
d19jb3B5X2Zyb21fdXNlcih2b2lkICpkc3QsIGNvbnN0IHZvaWQgX191c2VyICpzcmMsIHVuc2ln
bmVkIGxvbmcgc2l6ZSkKIAlzd2l0Y2ggKHNpemUpIHsKIAljYXNlIDE6CiAJCV9fdWFjY2Vzc19i
ZWdpbl9ub3NwZWMoKTsKKwkJbWFya2VyKDEpOwogCQlfX2dldF91c2VyX2FzbV9ub3plcm8oKih1
OCAqKWRzdCwgKHU4IF9fdXNlciAqKXNyYywKIAkJCSAgICAgIHJldCwgImIiLCAiYiIsICI9cSIs
IDEpOwogCQlfX3VhY2Nlc3NfZW5kKCk7CiAJCXJldHVybiByZXQ7CiAJY2FzZSAyOgogCQlfX3Vh
Y2Nlc3NfYmVnaW5fbm9zcGVjKCk7CisJCW1hcmtlcigyKTsKIAkJX19nZXRfdXNlcl9hc21fbm96
ZXJvKCoodTE2ICopZHN0LCAodTE2IF9fdXNlciAqKXNyYywKIAkJCSAgICAgIHJldCwgInciLCAi
dyIsICI9ciIsIDIpOwogCQlfX3VhY2Nlc3NfZW5kKCk7CiAJCXJldHVybiByZXQ7CiAJY2FzZSA0
OgogCQlfX3VhY2Nlc3NfYmVnaW5fbm9zcGVjKCk7CisJCW1hcmtlcig0KTsKIAkJX19nZXRfdXNl
cl9hc21fbm96ZXJvKCoodTMyICopZHN0LCAodTMyIF9fdXNlciAqKXNyYywKIAkJCSAgICAgIHJl
dCwgImwiLCAiayIsICI9ciIsIDQpOwogCQlfX3VhY2Nlc3NfZW5kKCk7CiAJCXJldHVybiByZXQ7
CiAJY2FzZSA4OgogCQlfX3VhY2Nlc3NfYmVnaW5fbm9zcGVjKCk7CisJCW1hcmtlcig4KTsKIAkJ
X19nZXRfdXNlcl9hc21fbm96ZXJvKCoodTY0ICopZHN0LCAodTY0IF9fdXNlciAqKXNyYywKIAkJ
CSAgICAgIHJldCwgInEiLCAiIiwgIj1yIiwgOCk7CiAJCV9fdWFjY2Vzc19lbmQoKTsKIAkJcmV0
dXJuIHJldDsKIAljYXNlIDEwOgogCQlfX3VhY2Nlc3NfYmVnaW5fbm9zcGVjKCk7CisJCW1hcmtl
cigxMCk7CiAJCV9fZ2V0X3VzZXJfYXNtX25vemVybygqKHU2NCAqKWRzdCwgKHU2NCBfX3VzZXIg
KilzcmMsCiAJCQkgICAgICAgcmV0LCAicSIsICIiLCAiPXIiLCAxMCk7CiAJCWlmIChsaWtlbHko
IXJldCkpCkBAIC0xMDYsNiArMTEzLDcgQEAgcmF3X2NvcHlfZnJvbV91c2VyKHZvaWQgKmRzdCwg
Y29uc3Qgdm9pZCBfX3VzZXIgKnNyYywgdW5zaWduZWQgbG9uZyBzaXplKQogCQlyZXR1cm4gcmV0
OwogCWNhc2UgMTY6CiAJCV9fdWFjY2Vzc19iZWdpbl9ub3NwZWMoKTsKKwkJbWFya2VyKDE2KTsK
IAkJX19nZXRfdXNlcl9hc21fbm96ZXJvKCoodTY0ICopZHN0LCAodTY0IF9fdXNlciAqKXNyYywK
IAkJCSAgICAgICByZXQsICJxIiwgIiIsICI9ciIsIDE2KTsKIAkJaWYgKGxpa2VseSghcmV0KSkK
QEAgLTEyOSwzMCArMTM3LDM1IEBAIHJhd19jb3B5X3RvX3VzZXIodm9pZCBfX3VzZXIgKmRzdCwg
Y29uc3Qgdm9pZCAqc3JjLCB1bnNpZ25lZCBsb25nIHNpemUpCiAJc3dpdGNoIChzaXplKSB7CiAJ
Y2FzZSAxOgogCQlfX3VhY2Nlc3NfYmVnaW4oKTsKKwkJbWFya2VyKDUxKTsKIAkJX19wdXRfdXNl
cl9hc20oKih1OCAqKXNyYywgKHU4IF9fdXNlciAqKWRzdCwKIAkJCSAgICAgIHJldCwgImIiLCAi
YiIsICJpcSIsIDEpOwogCQlfX3VhY2Nlc3NfZW5kKCk7CiAJCXJldHVybiByZXQ7CiAJY2FzZSAy
OgogCQlfX3VhY2Nlc3NfYmVnaW4oKTsKKwkJbWFya2VyKDUyKTsKIAkJX19wdXRfdXNlcl9hc20o
Kih1MTYgKilzcmMsICh1MTYgX191c2VyICopZHN0LAogCQkJICAgICAgcmV0LCAidyIsICJ3Iiwg
ImlyIiwgMik7CiAJCV9fdWFjY2Vzc19lbmQoKTsKIAkJcmV0dXJuIHJldDsKIAljYXNlIDQ6CiAJ
CV9fdWFjY2Vzc19iZWdpbigpOworCQltYXJrZXIoNTQpOwogCQlfX3B1dF91c2VyX2FzbSgqKHUz
MiAqKXNyYywgKHUzMiBfX3VzZXIgKilkc3QsCiAJCQkgICAgICByZXQsICJsIiwgImsiLCAiaXIi
LCA0KTsKIAkJX191YWNjZXNzX2VuZCgpOwogCQlyZXR1cm4gcmV0OwogCWNhc2UgODoKIAkJX191
YWNjZXNzX2JlZ2luKCk7CisJCW1hcmtlcig1OCk7CiAJCV9fcHV0X3VzZXJfYXNtKCoodTY0ICop
c3JjLCAodTY0IF9fdXNlciAqKWRzdCwKIAkJCSAgICAgIHJldCwgInEiLCAiIiwgImVyIiwgOCk7
CiAJCV9fdWFjY2Vzc19lbmQoKTsKIAkJcmV0dXJuIHJldDsKIAljYXNlIDEwOgogCQlfX3VhY2Nl
c3NfYmVnaW4oKTsKKwkJbWFya2VyKDYwKTsKIAkJX19wdXRfdXNlcl9hc20oKih1NjQgKilzcmMs
ICh1NjQgX191c2VyICopZHN0LAogCQkJICAgICAgIHJldCwgInEiLCAiIiwgImVyIiwgMTApOwog
CQlpZiAobGlrZWx5KCFyZXQpKSB7CkBAIC0xNjQsNiArMTc3LDcgQEAgcmF3X2NvcHlfdG9fdXNl
cih2b2lkIF9fdXNlciAqZHN0LCBjb25zdCB2b2lkICpzcmMsIHVuc2lnbmVkIGxvbmcgc2l6ZSkK
IAkJcmV0dXJuIHJldDsKIAljYXNlIDE2OgogCQlfX3VhY2Nlc3NfYmVnaW4oKTsKKwkJbWFya2Vy
KDY2KTsKIAkJX19wdXRfdXNlcl9hc20oKih1NjQgKilzcmMsICh1NjQgX191c2VyICopZHN0LAog
CQkJICAgICAgIHJldCwgInEiLCAiIiwgImVyIiwgMTYpOwogCQlpZiAobGlrZWx5KCFyZXQpKSB7
Cg==
--000000000000c7beeb05945e55b8--
