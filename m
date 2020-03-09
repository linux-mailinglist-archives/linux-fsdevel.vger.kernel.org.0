Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03A4B17E32C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Mar 2020 16:11:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbgCIPL4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Mar 2020 11:11:56 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:32982 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726814AbgCIPLz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Mar 2020 11:11:55 -0400
Received: by mail-oi1-f193.google.com with SMTP id q81so10504396oig.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Mar 2020 08:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=stapelberg-ch.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Pe7aGFw1rGoFxsniL3x3JXEjzeRykIDaBsTSdNntehk=;
        b=kck6cnyFOnxDUrLv5kIPXBPcnnmUki5xOjXr0Ll4OdHSy9KRg2k9gembkzBAaB3FX5
         YPKdeBOoBICplH3R0P3Ed92zr6aRtUoTIDA70hEJ9QwnOjuCP9Ef9dPUv/ya0desWlpF
         aDZ86yQD48xEpu+1br/0JM2DvbncR38vrrZl+yDLUFLS/Y/q1wz+QvcwkRNGVD26+ifB
         KXjRXNmiuJUXdBeZZyBGwAlevBcE4k/dWyBBzHI/uAdRPyD7svpfAaE0cUy9QPFQw8oz
         F6Ek57Q0dfX71YBJOmGimLGdMQkJZGL52HgkqIN8movB/Hxy/ZtMPhYZmEWA9D4y5/dS
         VrRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Pe7aGFw1rGoFxsniL3x3JXEjzeRykIDaBsTSdNntehk=;
        b=c9p2SMtxAcldm39Djo+FjqS4/QXlvzxnBVuDTMTAjOWc3WgGwYmig3zVNv9pm+WHPd
         +rI1jS9gZr8JyLdgZa9Wtq8o9CUzCqISaXs8cC7RY+NLLLsWfu/dC2PExh8CQUsTszuD
         WM1lFlAMJqEn7o+hclXWu6SsjSfQfQBGX2T87ofmZWMn0Bo3iO7drMCe1FjxfPOiOyWn
         ttxZ0cs47fgTjkWPurENzMKNWkOR3rwy/VLdxJ51IbZBMzKaoBgXIg8aVwxaELH5zz1Y
         fsP8HIrhzpX3P+n5DiZUQGimK4PCObczU7VHSvkatiovqS7g9QnWJano+8ksFlmSOKMX
         hJUw==
X-Gm-Message-State: ANhLgQ2d4csMULGsyhmHtXHr9tWI6mMeW51Pgg/L38ofPIf40MZuH1XP
        khakVoofb9U4+oatZgXtb/pyJeLArsNRyG40kKst+g==
X-Google-Smtp-Source: ADFU+vus//NY1DKPpgrUSxgdA5Fo4qf81eTNXVXm9Fv6HrbESdN4nB6VGYPe85+xgUn+zMyQzxroKyM/OOowOynLuMI=
X-Received: by 2002:aca:a98a:: with SMTP id s132mr4183617oie.75.1583766712761;
 Mon, 09 Mar 2020 08:11:52 -0700 (PDT)
MIME-Version: 1.0
References: <CANnVG6kZzN1Ja0EmxG3pVTdMx8Kf8fezGWBtCYUzk888VaFThg@mail.gmail.com>
 <CACQJH27s4HKzPgUkVT+FXWLGqJAAMYEkeKe7cidcesaYdE2Vog@mail.gmail.com>
 <CANnVG6=Ghu5r44mTkr0uXx_ZrrWo2N5C_UEfM59110Zx+HApzw@mail.gmail.com>
 <CAJfpegvzhfO7hg1sb_ttQF=dmBeg80WVkV8srF3VVYHw9ybV0w@mail.gmail.com>
 <CANnVG6kSJJw-+jtjh-ate7CC3CsB2=ugnQpA9ACGFdMex8sftg@mail.gmail.com>
 <CAJfpegtkEU9=3cvy8VNr4SnojErYFOTaCzUZLYvMuQMi050bPQ@mail.gmail.com>
 <20200303130421.GA5186@mtj.thefacebook.com> <CANnVG6=i1VmWF0aN1tJo5+NxTv6ycVOQJnpFiqbD7ZRVR6T4=Q@mail.gmail.com>
 <20200303141311.GA189690@mtj.thefacebook.com> <CANnVG6=9mYACk5tR2xD08r_sGWEeZ0rHZAmJ90U-8h3+iSMvbA@mail.gmail.com>
 <20200303142512.GC189690@mtj.thefacebook.com> <CANnVG6=yf82CcwmdmawmjTP2CskD-WhcvkLnkZs7hs0OG7KcTg@mail.gmail.com>
 <CANnVG6n=_PhhpgLo2ByGeJrrAaNOLond3GQJhobge7Ob2hfJrQ@mail.gmail.com> <CAJfpegsWwsmzWb6C61NXKh=TEGsc=TaSSEAsixbBvw_qF4R6YQ@mail.gmail.com>
In-Reply-To: <CAJfpegsWwsmzWb6C61NXKh=TEGsc=TaSSEAsixbBvw_qF4R6YQ@mail.gmail.com>
From:   Michael Stapelberg <michael+lkml@stapelberg.ch>
Date:   Mon, 9 Mar 2020 16:11:41 +0100
Message-ID: <CANnVG6n=ySfe1gOr=0ituQidp56idGARDKHzP0hv=ERedeMrMA@mail.gmail.com>
Subject: Re: [fuse-devel] Writing to FUSE via mmap extremely slow (sometimes)
 on some machines?
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Tejun Heo <tj@kernel.org>,
        Jack Smith <smith.jack.sidman@gmail.com>,
        fuse-devel <fuse-devel@lists.sourceforge.net>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Content-Type: multipart/mixed; boundary="00000000000052a69505a06d6c41"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--00000000000052a69505a06d6c41
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for clarifying. I have modified the mmap test program (see
attached) to optionally read in the entire file when the WORKAROUND=3D
environment variable is set, thereby preventing the FUSE reads in the
write phase. I can now see a batch of reads, followed by a batch of
writes.

What=E2=80=99s interesting: when polling using =E2=80=9Cwhile :; do grep ^B=
di
/sys/kernel/debug/bdi/0:93/stats; sleep 0.1; done=E2=80=9D and running the
mmap test program, I see:

BdiDirtied:            3566304 kB
BdiWritten:            3563616 kB
BdiWriteBandwidth:       13596 kBps

BdiDirtied:            3566304 kB
BdiWritten:            3563616 kB
BdiWriteBandwidth:       13596 kBps

BdiDirtied:            3566528 kB (+224 kB) <-- starting to dirty pages
BdiWritten:            3564064 kB (+448 kB) <-- starting to write
BdiWriteBandwidth:       10700 kBps <-- only bandwidth update!

BdiDirtied:            3668224 kB (+ 101696 kB) <-- all pages dirtied
BdiWritten:            3565632 kB (+1568 kB)
BdiWriteBandwidth:       10700 kBps

BdiDirtied:            3668224 kB
BdiWritten:            3665536 kB (+ 99904 kB) <-- all pages written
BdiWriteBandwidth:       10700 kBps

BdiDirtied:            3668224 kB
BdiWritten:            3665536 kB
BdiWriteBandwidth:       10700 kBps

This seems to suggest that the bandwidth measurements only capture the
rising slope of the transfer, but not the bulk of the transfer itself,
resulting in inaccurate measurements. This effect is worsened when the
test program doesn=E2=80=99t pre-read the output file and hence the kernel
gets fewer FUSE write requests out.

On Mon, Mar 9, 2020 at 3:36 PM Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> On Mon, Mar 9, 2020 at 3:32 PM Michael Stapelberg
> <michael+lkml@stapelberg.ch> wrote:
> >
> > Here=E2=80=99s one more thing I noticed: when polling
> > /sys/kernel/debug/bdi/0:93/stats, I see that BdiDirtied and BdiWritten
> > remain at their original values while the kernel sends FUSE read
> > requests, and only goes up when the kernel transitions into sending
> > FUSE write requests. Notably, the page dirtying throttling happens in
> > the read phase, which is most likely why the write bandwidth is
> > (correctly) measured as 0.
> >
> > Do we have any ideas on why the kernel sends FUSE reads at all?
>
> Memory writes (stores) need the memory page to be up-to-date wrt. the
> backing file before proceeding.   This means that if the page hasn't
> yet been cached by the kernel, it needs to be read first.
>
> Thanks,
> Miklos

--00000000000052a69505a06d6c41
Content-Type: text/x-csrc; charset="US-ASCII"; name="mmap.c"
Content-Disposition: attachment; filename="mmap.c"
Content-Transfer-Encoding: base64
Content-ID: <f_k7kl7x8h0>
X-Attachment-Id: f_k7kl7x8h0

I2luY2x1ZGUgPHN5cy90eXBlcy5oPgojaW5jbHVkZSA8c3lzL3N0YXQuaD4KI2luY2x1ZGUgPHN5
cy9tbWFuLmg+IAojaW5jbHVkZSA8ZmNudGwuaD4KI2luY2x1ZGUgPHN0cmluZy5oPgojaW5jbHVk
ZSA8c3RkaW8uaD4KI2luY2x1ZGUgPHN0ZGxpYi5oPgojaW5jbHVkZSA8dW5pc3RkLmg+CiNpbmNs
dWRlIDxzdGRpbnQuaD4KCi8qCiAqIEFuIGltcGxlbWVudGF0aW9uIG9mIGNvcHkgKCJjcCIpIHRo
YXQgdXNlcyBtZW1vcnkgbWFwcy4gIFZhcmlvdXMKICogZXJyb3IgY2hlY2tpbmcgaGFzIGJlZW4g
cmVtb3ZlZCB0byBwcm9tb3RlIHJlYWRhYmlsaXR5CiAqLwoKLy8gV2hlcmUgd2Ugd2FudCB0aGUg
c291cmNlIGZpbGUncyBtZW1vcnkgbWFwIHRvIGxpdmUgaW4gdmlydHVhbCBtZW1vcnkKLy8gVGhl
IGRlc3RpbmF0aW9uIGZpbGUgcmVzaWRlcyBpbW1lZGlhdGVseSBhZnRlciB0aGUgc291cmNlIGZp
bGUKI2RlZmluZSBNQVBfTE9DQVRJT04gMHg2MTAwCgppbnQgbWFpbiAoaW50IGFyZ2MsIGNoYXIg
KmFyZ3ZbXSkgewogaW50IGZkaW4sIGZkb3V0OwogY2hhciAqc3JjLCAqZHN0Owogc3RydWN0IHN0
YXQgc3RhdGJ1ZjsKIG9mZl90IGZpbGVTaXplID0gMDsKCiBpZiAoYXJnYyAhPSAzKSB7CiAgIHBy
aW50ZiAoInVzYWdlOiBhLm91dCA8ZnJvbWZpbGU+IDx0b2ZpbGU+XG4iKTsKICAgZXhpdCgwKTsK
IH0KCiAvKiBvcGVuIHRoZSBpbnB1dCBmaWxlICovCiBpZiAoKGZkaW4gPSBvcGVuIChhcmd2WzFd
LCBPX1JET05MWSkpIDwgMCkgewogICBwcmludGYgKCJjYW4ndCBvcGVuICVzIGZvciByZWFkaW5n
XG4iLCBhcmd2WzFdKTsKICAgZXhpdCgwKTsKIH0KCiAvKiBvcGVuL2NyZWF0ZSB0aGUgb3V0cHV0
IGZpbGUgKi8KIGlmICgoZmRvdXQgPSBvcGVuIChhcmd2WzJdLCBPX1JEV1IgfCBPX0NSRUFUIHwg
T19UUlVOQywgMDYwMCkpIDwgMCkgewogICBwcmludGYgKCJjYW4ndCBjcmVhdGUgJXMgZm9yIHdy
aXRpbmdcbiIsIGFyZ3ZbMl0pOwogICBleGl0KDApOwogfQogCiAvKiBmaW5kIHNpemUgb2YgaW5w
dXQgZmlsZSAqLwogZnN0YXQgKGZkaW4sJnN0YXRidWYpIDsKIGZpbGVTaXplID0gc3RhdGJ1Zi5z
dF9zaXplOwogCiAvKiBnbyB0byB0aGUgbG9jYXRpb24gY29ycmVzcG9uZGluZyB0byB0aGUgbGFz
dCBieXRlICovCiBpZiAobHNlZWsgKGZkb3V0LCBmaWxlU2l6ZSAtIDEsIFNFRUtfU0VUKSA9PSAt
MSkgewogICBwcmludGYgKCJsc2VlayBlcnJvclxuIik7CiAgIGV4aXQoMCk7CiB9CiAKIC8qIHdy
aXRlIGEgZHVtbXkgYnl0ZSBhdCB0aGUgbGFzdCBsb2NhdGlvbiAqLwogd3JpdGUgKGZkb3V0LCAi
IiwgMSk7CiAKIC8qIAogICogbWVtb3J5IG1hcCB0aGUgaW5wdXQgZmlsZS4gIE9ubHkgdGhlIGZp
cnN0IHR3byBhcmd1bWVudHMgYXJlCiAgKiBpbnRlcmVzdGluZzogMSkgdGhlIGxvY2F0aW9uIGFu
ZCAyKSB0aGUgc2l6ZSBvZiB0aGUgbWVtb3J5IG1hcCAKICAqIGluIHZpcnR1YWwgbWVtb3J5IHNw
YWNlLiBOb3RlIHRoYXQgdGhlIGxvY2F0aW9uIGlzIG9ubHkgYSAiaGludCI7CiAgKiB0aGUgT1Mg
Y2FuIGNob29zZSB0byByZXR1cm4gYSBkaWZmZXJlbnQgdmlydHVhbCBtZW1vcnkgYWRkcmVzcy4K
ICAqIFRoaXMgaXMgaWxsdXN0cmF0ZWQgYnkgdGhlIHByaW50ZiBjb21tYW5kIGJlbG93LgogKi8K
CiBzcmMgPSBtbWFwICgodm9pZCopIE1BUF9MT0NBVElPTiwgZmlsZVNpemUsIAoJICAgICBQUk9U
X1JFQUQsIE1BUF9TSEFSRUQgfCBNQVBfUE9QVUxBVEUsIGZkaW4sIDApOwoKIC8qIG1lbW9yeSBt
YXAgdGhlIG91dHB1dCBmaWxlIGFmdGVyIHRoZSBpbnB1dCBmaWxlICovCiBkc3QgPSBtbWFwICgo
dm9pZCopIE1BUF9MT0NBVElPTiArIGZpbGVTaXplICwgZmlsZVNpemUgLCAKCSAgICAgUFJPVF9S
RUFEIHwgUFJPVF9XUklURSwgTUFQX1NIQVJFRCwgZmRvdXQsIDApOwoKCiBwcmludGYoInBpZDog
JWRcbiIsIGdldHBpZCgpKTsKIHByaW50ZigiTWFwcGVkIHNyYzogMHglcCAgYW5kIGRzdDogMHgl
cFxuIixzcmMsZHN0KTsKCiBpZiAoZ2V0ZW52KCJXT1JLQVJPVU5EIikgIT0gTlVMTCkgewogICBw
cmludGYoIndvcmthcm91bmQ6IHJlYWRpbmcgb3V0cHV0IGZpbGUgYmVmb3JlIGRpcnR5aW5nIGl0
cyBwYWdlc1xuIik7CiAgIHVpbnQ4X3Qgc3VtID0gMDsKICAgdWludDhfdCAqcHRyID0gKHVpbnQ4
X3QqKWRzdDsKICAgZm9yIChvZmZfdCBpID0gMDsgaSA8IGZpbGVTaXplOyBpKyspIHsKICAgICBz
dW0gKz0gKnB0cjsKICAgICBwdHIrKzsKICAgfQogICBwcmludGYoInN1bTogJWRcbiIsIHN1bSk7
CiAgIHNsZWVwKDEpOwogICBwcmludGYoIndyaXRpbmdcbiIpOwogfQoKIC8qIENvcHkgdGhlIGlu
cHV0IGZpbGUgdG8gdGhlIG91dHB1dCBmaWxlICovCiBtZW1jcHkgKGRzdCwgc3JjLCBmaWxlU2l6
ZSk7CgogcHJpbnRmKCJtZW1jcHkgZG9uZVxuIik7CgogLy8gd2Ugc2hvdWxkIHByb2JhYmx5IHVu
bWFwIG1lbW9yeSBhbmQgY2xvc2UgdGhlIGZpbGVzCn0gLyogbWFpbiAqLwo=
--00000000000052a69505a06d6c41--
