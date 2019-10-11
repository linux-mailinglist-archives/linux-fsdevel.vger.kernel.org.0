Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 104B4D360E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2019 02:32:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727587AbfJKAbf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Oct 2019 20:31:35 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:34044 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727177AbfJKAbe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Oct 2019 20:31:34 -0400
Received: by mail-lf1-f67.google.com with SMTP id r22so5736767lfm.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Oct 2019 17:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6KQIXJS5Udq31xzSnClQQSZeps+FhrzYgeAcUAUA6PU=;
        b=JeuC2gx/w7gTNLQ92rY9af/8CotmQsFCuqZDiZ9wsZ4VAsaw/TD2OdFD3Vu+FohN4r
         oeAkelE3JN/HqpmVpTh6dM1qyfOglJI4J2qyus/w1lucezztBOV+uSy8DP0pLac60lWo
         8Oe65x/igi99IVKwWzf0erDJ3oOV6YoqbRV0Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6KQIXJS5Udq31xzSnClQQSZeps+FhrzYgeAcUAUA6PU=;
        b=i56C3q1HvRP8AQBgnOMvnF9jSRmIE7dw3YCRX0zEebqSmRuBj54z8Et8XaDDlIVTsU
         RJEwQU3tggX1qfAvsr38nU04jJ0/t4eYGdhZNXjfO3EAgqYbVrH/pyXF2B8mNgCZ5RA2
         cWKwJllI3NKlxoDCL3OINgEZ2IO0pRthS+30D1U5FXMiXBSJM87H3odmGCGCRPM30J2E
         psMXKVD2n7emH3V3ON6ntK/jVldD/oMkhlWpINv1UqjjSvJ6PUAA4vwddr/sBoNIooWX
         CRbHoU92lGIdIs5SuBYJjDj/JL0zS1xfd/0XiSrWgADYK9ffCRuA7EMvGhqu/YnySfcF
         HKuQ==
X-Gm-Message-State: APjAAAWvKeDwrJagpAtVMKDQiikg9MXfLEsbY0Ey1xD5ASlXNgJB1l3/
        Ovsj4td5HNVlpw+y61XNTZAPaMXVFp8=
X-Google-Smtp-Source: APXvYqz0Yy3gn6ZDEzz2bDPm7kayhnZjGO07b/LUIEJ83Kgmv93uePi8fsQ5klyNbRhrYgLWaWStaA==
X-Received: by 2002:a05:6512:515:: with SMTP id o21mr7506651lfb.189.1570753891695;
        Thu, 10 Oct 2019 17:31:31 -0700 (PDT)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id a14sm1725034lfg.74.2019.10.10.17.31.30
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Oct 2019 17:31:30 -0700 (PDT)
Received: by mail-lj1-f179.google.com with SMTP id q64so7995721ljb.12
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Oct 2019 17:31:30 -0700 (PDT)
X-Received: by 2002:a2e:2b91:: with SMTP id r17mr7894454ljr.1.1570753889932;
 Thu, 10 Oct 2019 17:31:29 -0700 (PDT)
MIME-Version: 1.0
References: <20191007012437.GK26530@ZenIV.linux.org.uk> <CAHk-=whKJfX579+2f-CHc4_YmEmwvMe_Csr0+CPfLAsSAdfDoA@mail.gmail.com>
 <20191007025046.GL26530@ZenIV.linux.org.uk> <CAHk-=whraNSys_Lj=Ut1EA=CJEfw2Uothh+5-WL+7nDJBegWcQ@mail.gmail.com>
 <CAHk-=witTXMGsc9ZAK4hnKnd_O7u8b1eiou-6cfjt4aOcWvruQ@mail.gmail.com>
 <20191008032912.GQ26530@ZenIV.linux.org.uk> <CAHk-=wiAyZmsEp6oQQgHiuaDU0bLj=OVHSGV_OfvHRSXNPYABw@mail.gmail.com>
 <CAHk-=wgOWxqwqCFuP_Bw=Hxxf9njeHJs0OLNGNc63peNd=kRqw@mail.gmail.com>
 <20191010195504.GI26530@ZenIV.linux.org.uk> <CAHk-=wgWRQo0m7TUCK4T_J-3Vqte+p-FWzvT3CB1jJHgX-KctA@mail.gmail.com>
 <20191011001104.GJ26530@ZenIV.linux.org.uk>
In-Reply-To: <20191011001104.GJ26530@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 10 Oct 2019 17:31:13 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgg3jzkk-jObm1FLVYGS8JCTiKppEnA00_QX7Wsm5ieLQ@mail.gmail.com>
Message-ID: <CAHk-=wgg3jzkk-jObm1FLVYGS8JCTiKppEnA00_QX7Wsm5ieLQ@mail.gmail.com>
Subject: Re: [PATCH] Convert filldir[64]() from __put_user() to unsafe_put_user()
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="000000000000a3dcf4059497a30d"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--000000000000a3dcf4059497a30d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 10, 2019 at 5:11 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Thu, Oct 10, 2019 at 03:12:49PM -0700, Linus Torvalds wrote:
>
> > But I've not gotten around to rewriting those disgusting sequences to
> > the unsafe_get/put_user() model. I did look at it, and it requires
> > some changes exactly *because* the _ex() functions are broken and
> > continue, but also because the current code ends up also doing other
> > things inside the try/catch region that you're not supposed to do in a
> > user_access_begin/end() region .
>
> Hmm...  Which one was that?  AFAICS, we have
>         do_sys_vm86: only get_user_ex()
>         restore_sigcontext(): get_user_ex(), set_user_gs()
>         ia32_restore_sigcontext(): get_user_ex()

Try this patch.

It works fine (well, it worked fine the lastr time I tried this, I
might have screwed something up just now: I re-created the patch since
I hadn't saved it).

It's nice and clean, and does

 1 file changed, 9 insertions(+), 91 deletions(-)

by just deleting all the nasty *_ex() macros entirely, replacing them
with unsafe_get/put_user() calls.

And now those try/catch regions actually work like try/catch regions,
and a fault branches to the catch.

BUT.

It does change semantics, and you get warnings like

  arch/x86/ia32/ia32_signal.c: In function =E2=80=98ia32_restore_sigcontext=
=E2=80=99:
  arch/x86/ia32/ia32_signal.c:114:9: warning: =E2=80=98buf=E2=80=99 may be =
used
uninitialized in this function [-Wmaybe-uninitialized]
    114 |  err |=3D fpu__restore_sig(buf, 1);
        |         ^~~~~~~~~~~~~~~~~~~~~~~~
  arch/x86/ia32/ia32_signal.c:64:27: warning: =E2=80=98ds=E2=80=99 may be u=
sed
uninitialized in this function [-Wmaybe-uninitialized]
     64 |  unsigned int pre =3D (seg) | 3;  \
        |                           ^
  arch/x86/ia32/ia32_signal.c:74:18: note: =E2=80=98ds=E2=80=99 was declare=
d here
...
  arch/x86/kernel/signal.c: In function =E2=80=98restore_sigcontext=E2=80=
=99:
  arch/x86/kernel/signal.c:152:9: warning: =E2=80=98buf=E2=80=99 may be use=
d
uninitialized in this function [-Wmaybe-uninitialized]
    152 |  err |=3D fpu__restore_sig(buf, IS_ENABLED(CONFIG_X86_32));
        |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

because it's true: those things reall may not be initialized, because
the catch thing could have jumped out.

So the code actually needs to properly return the error early, or
initialize the segments that didn't get loaded to 0, or something.

And when I posted that, Luto said "just get rid of the get_user_ex()
entirely, instead of changing semantics of the existing ones to be
sane.

Which is probably right. There aren't that many.

I *thought* there were also cases of us doing some questionably things
inside the get_user_try sections, but those seem to have gotten fixed
already independently, so it's really just the "make try/catch really
try/catch" change that needs some editing of our current broken stuff
that depends on it not actually *catching* exceptions, but on just
continuing on to the next one.

                Linus

--000000000000a3dcf4059497a30d
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_k1ldzs220>
X-Attachment-Id: f_k1ldzs220

IGFyY2gveDg2L2luY2x1ZGUvYXNtL3VhY2Nlc3MuaCB8IDEwMCArKysrLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDkgaW5zZXJ0aW9ucygrKSwg
OTEgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvYXJjaC94ODYvaW5jbHVkZS9hc20vdWFjY2Vz
cy5oIGIvYXJjaC94ODYvaW5jbHVkZS9hc20vdWFjY2Vzcy5oCmluZGV4IDYxZDkzZjA2MmEzNi4u
ZTg3ZDg5MTFkYzUzIDEwMDY0NAotLS0gYS9hcmNoL3g4Ni9pbmNsdWRlL2FzbS91YWNjZXNzLmgK
KysrIGIvYXJjaC94ODYvaW5jbHVkZS9hc20vdWFjY2Vzcy5oCkBAIC0xOTMsMjMgKzE5MywxMiBA
QCBfX3R5cGVvZl9fKF9fYnVpbHRpbl9jaG9vc2VfZXhwcihzaXplb2YoeCkgPiBzaXplb2YoMFVM
KSwgMFVMTCwgMFVMKSkKIAkJICAgICA6IDogIkEiICh4KSwgInIiIChhZGRyKQkJCVwKIAkJICAg
ICA6IDogbGFiZWwpCiAKLSNkZWZpbmUgX19wdXRfdXNlcl9hc21fZXhfdTY0KHgsIGFkZHIpCQkJ
CQlcCi0JYXNtIHZvbGF0aWxlKCJcbiIJCQkJCQlcCi0JCSAgICAgIjE6CW1vdmwgJSVlYXgsMCgl
MSlcbiIJCQlcCi0JCSAgICAgIjI6CW1vdmwgJSVlZHgsNCglMSlcbiIJCQlcCi0JCSAgICAgIjM6
IgkJCQkJCVwKLQkJICAgICBfQVNNX0VYVEFCTEVfRVgoMWIsIDJiKQkJCQlcCi0JCSAgICAgX0FT
TV9FWFRBQkxFX0VYKDJiLCAzYikJCQkJXAotCQkgICAgIDogOiAiQSIgKHgpLCAiciIgKGFkZHIp
KQotCiAjZGVmaW5lIF9fcHV0X3VzZXJfeDgoeCwgcHRyLCBfX3JldF9wdSkJCQkJXAogCWFzbSB2
b2xhdGlsZSgiY2FsbCBfX3B1dF91c2VyXzgiIDogIj1hIiAoX19yZXRfcHUpCVwKIAkJICAgICA6
ICJBIiAoKHR5cGVvZigqKHB0cikpKSh4KSksICJjIiAocHRyKSA6ICJlYngiKQogI2Vsc2UKICNk
ZWZpbmUgX19wdXRfdXNlcl9nb3RvX3U2NCh4LCBwdHIsIGxhYmVsKSBcCiAJX19wdXRfdXNlcl9n
b3RvKHgsIHB0ciwgInEiLCAiIiwgImVyIiwgbGFiZWwpCi0jZGVmaW5lIF9fcHV0X3VzZXJfYXNt
X2V4X3U2NCh4LCBhZGRyKQlcCi0JX19wdXRfdXNlcl9hc21fZXgoeCwgYWRkciwgInEiLCAiIiwg
ImVyIikKICNkZWZpbmUgX19wdXRfdXNlcl94OCh4LCBwdHIsIF9fcmV0X3B1KSBfX3B1dF91c2Vy
X3goOCwgeCwgcHRyLCBfX3JldF9wdSkKICNlbmRpZgogCkBAIC0yODksMzEgKzI3OCw2IEBAIGRv
IHsJCQkJCQkJCQlcCiAJfQkJCQkJCQkJXAogfSB3aGlsZSAoMCkKIAotLyoKLSAqIFRoaXMgZG9l
c24ndCBkbyBfX3VhY2Nlc3NfYmVnaW4vZW5kIC0gdGhlIGV4Y2VwdGlvbiBoYW5kbGluZwotICog
YXJvdW5kIGl0IG11c3QgZG8gdGhhdC4KLSAqLwotI2RlZmluZSBfX3B1dF91c2VyX3NpemVfZXgo
eCwgcHRyLCBzaXplKQkJCQlcCi1kbyB7CQkJCQkJCQkJXAotCV9fY2hrX3VzZXJfcHRyKHB0cik7
CQkJCQkJXAotCXN3aXRjaCAoc2l6ZSkgewkJCQkJCQlcCi0JY2FzZSAxOgkJCQkJCQkJXAotCQlf
X3B1dF91c2VyX2FzbV9leCh4LCBwdHIsICJiIiwgImIiLCAiaXEiKTsJCVwKLQkJYnJlYWs7CQkJ
CQkJCVwKLQljYXNlIDI6CQkJCQkJCQlcCi0JCV9fcHV0X3VzZXJfYXNtX2V4KHgsIHB0ciwgInci
LCAidyIsICJpciIpOwkJXAotCQlicmVhazsJCQkJCQkJXAotCWNhc2UgNDoJCQkJCQkJCVwKLQkJ
X19wdXRfdXNlcl9hc21fZXgoeCwgcHRyLCAibCIsICJrIiwgImlyIik7CQlcCi0JCWJyZWFrOwkJ
CQkJCQlcCi0JY2FzZSA4OgkJCQkJCQkJXAotCQlfX3B1dF91c2VyX2FzbV9leF91NjQoKF9fdHlw
ZW9mX18oKnB0cikpKHgpLCBwdHIpOwlcCi0JCWJyZWFrOwkJCQkJCQlcCi0JZGVmYXVsdDoJCQkJ
CQkJXAotCQlfX3B1dF91c2VyX2JhZCgpOwkJCQkJXAotCX0JCQkJCQkJCVwKLX0gd2hpbGUgKDAp
Ci0KICNpZmRlZiBDT05GSUdfWDg2XzMyCiAjZGVmaW5lIF9fZ2V0X3VzZXJfYXNtX3U2NCh4LCBw
dHIsIHJldHZhbCwgZXJycmV0KQkJCVwKICh7CQkJCQkJCQkJXApAQCAtMzM0LDEzICsyOTgsOSBA
QCBkbyB7CQkJCQkJCQkJXAogCQkgICAgIDogIm0iIChfX20oX19wdHIpKSwgIm0iIF9fbSgoKHUz
MiBfX3VzZXIgKikoX19wdHIpKSArIDEpLAlcCiAJCSAgICAgICAiaSIgKGVycnJldCksICIwIiAo
cmV0dmFsKSk7CQkJXAogfSkKLQotI2RlZmluZSBfX2dldF91c2VyX2FzbV9leF91NjQoeCwgcHRy
KQkJCSh4KSA9IF9fZ2V0X3VzZXJfYmFkKCkKICNlbHNlCiAjZGVmaW5lIF9fZ2V0X3VzZXJfYXNt
X3U2NCh4LCBwdHIsIHJldHZhbCwgZXJycmV0KSBcCiAJIF9fZ2V0X3VzZXJfYXNtKHgsIHB0ciwg
cmV0dmFsLCAicSIsICIiLCAiPXIiLCBlcnJyZXQpCi0jZGVmaW5lIF9fZ2V0X3VzZXJfYXNtX2V4
X3U2NCh4LCBwdHIpIFwKLQkgX19nZXRfdXNlcl9hc21fZXgoeCwgcHRyLCAicSIsICIiLCAiPXIi
KQogI2VuZGlmCiAKICNkZWZpbmUgX19nZXRfdXNlcl9zaXplKHgsIHB0ciwgc2l6ZSwgcmV0dmFs
LCBlcnJyZXQpCQkJXApAQCAtMzkwLDQxICszNTAsNiBAQCBkbyB7CQkJCQkJCQkJXAogCQkgICAg
IDogIj1yIiAoZXJyKSwgbHR5cGUoeCkJCQkJXAogCQkgICAgIDogIm0iIChfX20oYWRkcikpLCAi
aSIgKGVycnJldCksICIwIiAoZXJyKSkKIAotLyoKLSAqIFRoaXMgZG9lc24ndCBkbyBfX3VhY2Nl
c3NfYmVnaW4vZW5kIC0gdGhlIGV4Y2VwdGlvbiBoYW5kbGluZwotICogYXJvdW5kIGl0IG11c3Qg
ZG8gdGhhdC4KLSAqLwotI2RlZmluZSBfX2dldF91c2VyX3NpemVfZXgoeCwgcHRyLCBzaXplKQkJ
CQlcCi1kbyB7CQkJCQkJCQkJXAotCV9fY2hrX3VzZXJfcHRyKHB0cik7CQkJCQkJXAotCXN3aXRj
aCAoc2l6ZSkgewkJCQkJCQlcCi0JY2FzZSAxOgkJCQkJCQkJXAotCQlfX2dldF91c2VyX2FzbV9l
eCh4LCBwdHIsICJiIiwgImIiLCAiPXEiKTsJCVwKLQkJYnJlYWs7CQkJCQkJCVwKLQljYXNlIDI6
CQkJCQkJCQlcCi0JCV9fZ2V0X3VzZXJfYXNtX2V4KHgsIHB0ciwgInciLCAidyIsICI9ciIpOwkJ
XAotCQlicmVhazsJCQkJCQkJXAotCWNhc2UgNDoJCQkJCQkJCVwKLQkJX19nZXRfdXNlcl9hc21f
ZXgoeCwgcHRyLCAibCIsICJrIiwgIj1yIik7CQlcCi0JCWJyZWFrOwkJCQkJCQlcCi0JY2FzZSA4
OgkJCQkJCQkJXAotCQlfX2dldF91c2VyX2FzbV9leF91NjQoeCwgcHRyKTsJCQkJXAotCQlicmVh
azsJCQkJCQkJXAotCWRlZmF1bHQ6CQkJCQkJCVwKLQkJKHgpID0gX19nZXRfdXNlcl9iYWQoKTsJ
CQkJCVwKLQl9CQkJCQkJCQlcCi19IHdoaWxlICgwKQotCi0jZGVmaW5lIF9fZ2V0X3VzZXJfYXNt
X2V4KHgsIGFkZHIsIGl0eXBlLCBydHlwZSwgbHR5cGUpCQkJXAotCWFzbSB2b2xhdGlsZSgiMToJ
bW92Iml0eXBlIiAlMSwlInJ0eXBlIjBcbiIJCVwKLQkJICAgICAiMjpcbiIJCQkJCQlcCi0JCSAg
ICAgIi5zZWN0aW9uIC5maXh1cCxcImF4XCJcbiIJCQkJXAotICAgICAgICAgICAgICAgICAgICAg
IjM6eG9yIml0eXBlIiAlInJ0eXBlIjAsJSJydHlwZSIwXG4iCQlcCi0JCSAgICAgIiAgam1wIDJi
XG4iCQkJCQlcCi0JCSAgICAgIi5wcmV2aW91c1xuIgkJCQkJXAotCQkgICAgIF9BU01fRVhUQUJM
RV9FWCgxYiwgM2IpCQkJCVwKLQkJICAgICA6IGx0eXBlKHgpIDogIm0iIChfX20oYWRkcikpKQot
CiAjZGVmaW5lIF9fcHV0X3VzZXJfbm9jaGVjayh4LCBwdHIsIHNpemUpCQkJXAogKHsJCQkJCQkJ
CVwKIAlfX2xhYmVsX18gX19wdV9sYWJlbDsJCQkJCVwKQEAgLTQ4MCwyNyArNDA1LDI1IEBAIHN0
cnVjdCBfX2xhcmdlX3N0cnVjdCB7IHVuc2lnbmVkIGxvbmcgYnVmWzEwMF07IH07CiAJcmV0dmFs
ID0gX19wdXRfdXNlcl9mYWlsZWQoeCwgYWRkciwgaXR5cGUsIHJ0eXBlLCBsdHlwZSwgZXJycmV0
KTsJXAogfSB3aGlsZSAoMCkKIAotI2RlZmluZSBfX3B1dF91c2VyX2FzbV9leCh4LCBhZGRyLCBp
dHlwZSwgcnR5cGUsIGx0eXBlKQkJCVwKLQlhc20gdm9sYXRpbGUoIjE6CW1vdiJpdHlwZSIgJSJy
dHlwZSIwLCUxXG4iCQlcCi0JCSAgICAgIjI6XG4iCQkJCQkJXAotCQkgICAgIF9BU01fRVhUQUJM
RV9FWCgxYiwgMmIpCQkJCVwKLQkJICAgICA6IDogbHR5cGUoeCksICJtIiAoX19tKGFkZHIpKSkK
LQogLyoKICAqIHVhY2Nlc3NfdHJ5IGFuZCBjYXRjaAogICovCiAjZGVmaW5lIHVhY2Nlc3NfdHJ5
CWRvIHsJCQkJCQlcCi0JY3VycmVudC0+dGhyZWFkLnVhY2Nlc3NfZXJyID0gMDsJCQkJXAorCV9f
bGFiZWxfXyBfX3VhY2Nlc3NfY2F0Y2hfZWZhdWx0OwkJCQlcCiAJX191YWNjZXNzX2JlZ2luKCk7
CQkJCQkJXAogCWJhcnJpZXIoKTsKIAogI2RlZmluZSB1YWNjZXNzX3RyeV9ub3NwZWMgZG8gewkJ
CQkJCVwKLQljdXJyZW50LT50aHJlYWQudWFjY2Vzc19lcnIgPSAwOwkJCQlcCisJX19sYWJlbF9f
IF9fdWFjY2Vzc19jYXRjaF9lZmF1bHQ7CQkJCVwKIAlfX3VhY2Nlc3NfYmVnaW5fbm9zcGVjKCk7
CQkJCQlcCiAKICNkZWZpbmUgdWFjY2Vzc19jYXRjaChlcnIpCQkJCQkJXAogCV9fdWFjY2Vzc19l
bmQoKTsJCQkJCQlcCi0JKGVycikgfD0gKGN1cnJlbnQtPnRocmVhZC51YWNjZXNzX2VyciA/IC1F
RkFVTFQgOiAwKTsJCVwKKwkoZXJyKSA9IDA7CQkJCQkJCVwKKwlicmVhazsJCQkJCQkJCVwKK19f
dWFjY2Vzc19jYXRjaF9lZmF1bHQ6CQkJCQkJCVwKKwlfX3VhY2Nlc3NfZW5kKCk7CQkJCQkJXAor
CShlcnIpID0gLUVGQVVMVDsJCQkJCQlcCiB9IHdoaWxlICgwKQogCiAvKioKQEAgLTU2MiwxNyAr
NDg1LDEyIEBAIHN0cnVjdCBfX2xhcmdlX3N0cnVjdCB7IHVuc2lnbmVkIGxvbmcgYnVmWzEwMF07
IH07CiAjZGVmaW5lIGdldF91c2VyX3RyeQkJdWFjY2Vzc190cnlfbm9zcGVjCiAjZGVmaW5lIGdl
dF91c2VyX2NhdGNoKGVycikJdWFjY2Vzc19jYXRjaChlcnIpCiAKLSNkZWZpbmUgZ2V0X3VzZXJf
ZXgoeCwgcHRyKQlkbyB7CQkJCQlcCi0JdW5zaWduZWQgbG9uZyBfX2d1ZV92YWw7CQkJCQlcCi0J
X19nZXRfdXNlcl9zaXplX2V4KChfX2d1ZV92YWwpLCAocHRyKSwgKHNpemVvZigqKHB0cikpKSk7
CVwKLQkoeCkgPSAoX19mb3JjZSBfX3R5cGVvZl9fKCoocHRyKSkpX19ndWVfdmFsOwkJCVwKLX0g
d2hpbGUgKDApCisjZGVmaW5lIGdldF91c2VyX2V4KHgsIHB0cikJdW5zYWZlX2dldF91c2VyKHgs
IHB0ciwgX191YWNjZXNzX2NhdGNoX2VmYXVsdCkKIAogI2RlZmluZSBwdXRfdXNlcl90cnkJCXVh
Y2Nlc3NfdHJ5CiAjZGVmaW5lIHB1dF91c2VyX2NhdGNoKGVycikJdWFjY2Vzc19jYXRjaChlcnIp
CiAKLSNkZWZpbmUgcHV0X3VzZXJfZXgoeCwgcHRyKQkJCQkJCVwKLQlfX3B1dF91c2VyX3NpemVf
ZXgoKF9fdHlwZW9mX18oKihwdHIpKSkoeCksIChwdHIpLCBzaXplb2YoKihwdHIpKSkKKyNkZWZp
bmUgcHV0X3VzZXJfZXgoeCwgcHRyKQl1bnNhZmVfcHV0X3VzZXIoeCwgcHRyLCBfX3VhY2Nlc3Nf
Y2F0Y2hfZWZhdWx0KQogCiBleHRlcm4gdW5zaWduZWQgbG9uZwogY29weV9mcm9tX3VzZXJfbm1p
KHZvaWQgKnRvLCBjb25zdCB2b2lkIF9fdXNlciAqZnJvbSwgdW5zaWduZWQgbG9uZyBuKTsK
--000000000000a3dcf4059497a30d--
