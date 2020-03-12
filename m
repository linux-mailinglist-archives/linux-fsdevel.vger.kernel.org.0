Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC12018354F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Mar 2020 16:45:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727881AbgCLPpz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Mar 2020 11:45:55 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:34897 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727714AbgCLPpy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Mar 2020 11:45:54 -0400
Received: by mail-oi1-f193.google.com with SMTP id k8so4478370oik.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Mar 2020 08:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=stapelberg-ch.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fDsYWMR0jqauJc8EeIwuCKXIYa+QJ1rz1Yuuag5P300=;
        b=peVR3vk14oplklJnEWWpQisuDcIrrkm4U++PX62sRvNHP6Buj12jwMEPT0UNzAwenw
         Jc7C31Aa9JYaa8n25i4Uvj5EqOVHjKQj+aL7ioOqY26HVlvNymX6cpGUtS+usYemN4p+
         7D9Kdq7GfSqRF28X7ierk5kpf8fXRtfJuM5WJ3lBU3YknwCYUefPnCRPqIwyPVBdgfOg
         FbVatIAl3Ev/LIDod5gQjncXVa2YJu2aa72qrqTcOlvn56uOpXs3UqTfIUKyWU+Xj47M
         7GtNGyOySBgw3NwlCvsCmTx30GcZblCyXjIMRi4jOinYZ+wQGfZgVbzEPgYcMQYfe8Td
         VtbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fDsYWMR0jqauJc8EeIwuCKXIYa+QJ1rz1Yuuag5P300=;
        b=Wl2xkE2Q+OnBY7gyUvAyzOSUOrCDpXq8ASXYFry15hzpU69vbgja+vmlc9RYjzK1sI
         x2z40PW0cNwaBs6FSHETYzTdBMqAJLrflx2XHvnokNTnY6gccJ0dDvBJq14D1xs7Bk7c
         cjiqhUI2lq/LqV5OCxd4TIQbbEhZLGJZKwnogQchrvZug9FPVjW7JxrhuJjt7LzvD2K1
         4Zo7icURHBz8Z6KFzV+LN1TO1atLcGjmXQBU8PQe5XipveNUQPAXXMqqlWXRd/E3DIKN
         JsiH7DgZxvG7GCuOnmruvYwU2gpN03VVnttApfAc/QA+V8wC7SAz6O1ADRTLxsMEXM2E
         PY6Q==
X-Gm-Message-State: ANhLgQ3tInCdzjiRW3audHf5UHqPhjJzI18/z3TYcRhD/EKVRhy4MAH2
        PUzOhdPgKHgO3kUtRy5tn385uqOx2RBzXNF/iFjJ8Q==
X-Google-Smtp-Source: ADFU+vv1GY9vm4e3SAoIM6ERkhqYefcFqPgIi7Zy8b6put+hApLXBGwMf/vtzE3kFEPh1CagMtTr8r7zbG2ql7LTfzs=
X-Received: by 2002:aca:c45:: with SMTP id i5mr2887334oiy.111.1584027952521;
 Thu, 12 Mar 2020 08:45:52 -0700 (PDT)
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
 <CANnVG6n=_PhhpgLo2ByGeJrrAaNOLond3GQJhobge7Ob2hfJrQ@mail.gmail.com>
 <CAJfpegsWwsmzWb6C61NXKh=TEGsc=TaSSEAsixbBvw_qF4R6YQ@mail.gmail.com> <CANnVG6n=ySfe1gOr=0ituQidp56idGARDKHzP0hv=ERedeMrMA@mail.gmail.com>
In-Reply-To: <CANnVG6n=ySfe1gOr=0ituQidp56idGARDKHzP0hv=ERedeMrMA@mail.gmail.com>
From:   Michael Stapelberg <michael+lkml@stapelberg.ch>
Date:   Thu, 12 Mar 2020 16:45:41 +0100
Message-ID: <CANnVG6=hU=CUYf+SgR4y5jp5xJPn6LDY2XkR2+Ecn+fYmUGhBA@mail.gmail.com>
Subject: Re: [fuse-devel] Writing to FUSE via mmap extremely slow (sometimes)
 on some machines?
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Tejun Heo <tj@kernel.org>,
        Jack Smith <smith.jack.sidman@gmail.com>,
        fuse-devel <fuse-devel@lists.sourceforge.net>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Content-Type: multipart/mixed; boundary="0000000000006d26c905a0aa3f34"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--0000000000006d26c905a0aa3f34
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Find attached a patch which introduces a min_bw and max_bw limit for a
backing_dev_info. As outlined in the commit description, this can be
used to work around the issue until we have a better understanding of
how a real solution would look like.

Could we include this change in Linux? What would be the next step?

Thanks,

On Mon, Mar 9, 2020 at 4:11 PM Michael Stapelberg
<michael+lkml@stapelberg.ch> wrote:
>
> Thanks for clarifying. I have modified the mmap test program (see
> attached) to optionally read in the entire file when the WORKAROUND=3D
> environment variable is set, thereby preventing the FUSE reads in the
> write phase. I can now see a batch of reads, followed by a batch of
> writes.
>
> What=E2=80=99s interesting: when polling using =E2=80=9Cwhile :; do grep =
^Bdi
> /sys/kernel/debug/bdi/0:93/stats; sleep 0.1; done=E2=80=9D and running th=
e
> mmap test program, I see:
>
> BdiDirtied:            3566304 kB
> BdiWritten:            3563616 kB
> BdiWriteBandwidth:       13596 kBps
>
> BdiDirtied:            3566304 kB
> BdiWritten:            3563616 kB
> BdiWriteBandwidth:       13596 kBps
>
> BdiDirtied:            3566528 kB (+224 kB) <-- starting to dirty pages
> BdiWritten:            3564064 kB (+448 kB) <-- starting to write
> BdiWriteBandwidth:       10700 kBps <-- only bandwidth update!
>
> BdiDirtied:            3668224 kB (+ 101696 kB) <-- all pages dirtied
> BdiWritten:            3565632 kB (+1568 kB)
> BdiWriteBandwidth:       10700 kBps
>
> BdiDirtied:            3668224 kB
> BdiWritten:            3665536 kB (+ 99904 kB) <-- all pages written
> BdiWriteBandwidth:       10700 kBps
>
> BdiDirtied:            3668224 kB
> BdiWritten:            3665536 kB
> BdiWriteBandwidth:       10700 kBps
>
> This seems to suggest that the bandwidth measurements only capture the
> rising slope of the transfer, but not the bulk of the transfer itself,
> resulting in inaccurate measurements. This effect is worsened when the
> test program doesn=E2=80=99t pre-read the output file and hence the kerne=
l
> gets fewer FUSE write requests out.
>
> On Mon, Mar 9, 2020 at 3:36 PM Miklos Szeredi <miklos@szeredi.hu> wrote:
> >
> > On Mon, Mar 9, 2020 at 3:32 PM Michael Stapelberg
> > <michael+lkml@stapelberg.ch> wrote:
> > >
> > > Here=E2=80=99s one more thing I noticed: when polling
> > > /sys/kernel/debug/bdi/0:93/stats, I see that BdiDirtied and BdiWritte=
n
> > > remain at their original values while the kernel sends FUSE read
> > > requests, and only goes up when the kernel transitions into sending
> > > FUSE write requests. Notably, the page dirtying throttling happens in
> > > the read phase, which is most likely why the write bandwidth is
> > > (correctly) measured as 0.
> > >
> > > Do we have any ideas on why the kernel sends FUSE reads at all?
> >
> > Memory writes (stores) need the memory page to be up-to-date wrt. the
> > backing file before proceeding.   This means that if the page hasn't
> > yet been cached by the kernel, it needs to be read first.
> >
> > Thanks,
> > Miklos

--0000000000006d26c905a0aa3f34
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-backing_dev_info-introduce-min_bw-max_bw-limits.patch"
Content-Disposition: attachment; 
	filename="0001-backing_dev_info-introduce-min_bw-max_bw-limits.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_k7oxbe600>
X-Attachment-Id: f_k7oxbe600

RnJvbSAxMGM1ZmQwNDEyYWI3MWMxNGNjYTdhNjZjMjQwN2JmZTNiYjg2MWFmIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBNaWNoYWVsIFN0YXBlbGJlcmcgPHN0YXBlbGJlcmdAZ29vZ2xl
LmNvbT4KRGF0ZTogVHVlLCAxMCBNYXIgMjAyMCAxNTo0ODoyMCArMDEwMApTdWJqZWN0OiBbUEFU
Q0hdIGJhY2tpbmdfZGV2X2luZm86IGludHJvZHVjZSBtaW5fYncvbWF4X2J3IGxpbWl0cwoKVGhp
cyBhbGxvd3Mgd29ya2luZyBhcm91bmQgbG9uZy1zdGFuZGluZyBzaWduaWZpY2FudCBwZXJmb3Jt
YW5jZSBpc3N1ZXMgd2hlbgp1c2luZyBtbWFwIHdpdGggZmlsZXMgb24gRlVTRSBmaWxlIHN5c3Rl
bXMgc3VjaCBhcyBPYmpGUy4KClRoZSBwYWdlLXdyaXRlYmFjayBjb2RlIHRyaWVzIHRvIG1lYXN1
cmUgaG93IHF1aWNrIGZpbGUgc3lzdGVtIGJhY2tpbmcgZGV2aWNlcwphcmUgYWJsZSB0byB3cml0
ZSBkYXRhLgoKVW5mb3J0dW5hdGVseSwgb3VyIHVzYWdlIHBhdHRlcm4gc2VlbXMgdG8gaGl0IGFu
IHVuZm9ydHVuYXRlIGNvZGUgcGF0aDogdGhlCmtlcm5lbCBvbmx5IGV2ZXIgbWVhc3VyZXMgdGhl
IChub24tcmVwcmVzZW50YXRpdmUpIHJpc2luZyBzbG9wZSBvZiB0aGUgc3RhcnRpbmcKdHJhbnNm
ZXIsIGJ1dCB0aGUgdHJhbnNmZXIgaXMgYWxyZWFkeSBvdmVyIGJlZm9yZSBpdCBjb3VsZCBwb3Nz
aWJseSBtZWFzdXJlIHRoZQpyZXByZXNlbnRhdGl2ZSBzdGVhZHktc3RhdGUuCgpBcyBhIGNvbnNl
cXVlbmNlLCB0aGUgRlVTRSB3cml0ZSBiYW5kd2lkdGggc2lua3Mgc3RlYWRpbHkgZG93biB0byAw
ICghKSBhbmQKaGVhdmlseSB0aHJvdHRsZXMgcGFnZSBkaXJ0eWluZyBpbiBwcm9ncmFtcyB0cnlp
bmcgdG8gd3JpdGUgdG8gRlVTRS4KClRoaXMgcGF0Y2ggYWRkcyBhIGtub2Igd2hpY2ggYWxsb3dz
IGF2b2lkaW5nIHRoaXMgc2l0dWF0aW9uIGVudGlyZWx5IG9uIGEKcGVyLWZpbGUtc3lzdGVtIGJh
c2lzIGJ5IHJlc3RyaWN0aW5nIHRoZSBtaW5pbXVtL21heGltdW0gYmFuZHdpZHRoLgoKVGhlcmUg
YXJlIG5vIG5lZ2F0aXZlIGVmZmVjdHMgZXhwZWN0ZWQgZnJvbSBhcHBseWluZyB0aGlzIHBhdGNo
LgoKU2VlIGFsc28gdGhlIGRpc2N1c3Npb24gb24gdGhlIExpbnV4IEtlcm5lbCBNYWlsaW5nIExp
c3Q6CgpodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC1mc2RldmVsL0NBTm5WRzZuPXlTZmUx
Z09yPTBpdHVRaWRwNTZpZEdBUkRLSHpQMGh2PUVSZWRlTXJNQUBtYWlsLmdtYWlsLmNvbS8KClRv
IGluc3BlY3QgdGhlIG1lYXN1cmVkIGJhbmR3aWR0aCwgY2hlY2sgdGhlIEJkaVdyaXRlQmFuZHdp
ZHRoIGZpZWxkIGluCmUuZy4gL3N5cy9rZXJuZWwvZGVidWcvYmRpLzA6OTMvc3RhdHMuCgpUbyBw
aW4gdGhlIG1lYXN1cmVkIGJhbmR3aWR0aCB0byBpdHMgZGVmYXVsdCBvZiAxMDAgTUIvcywgdXNl
OgoKICAgIGVjaG8gMjU2MDAgPiAvc3lzL2NsYXNzL2JkaS8wOjQyL21pbl9idwogICAgZWNobyAy
NTYwMCA+IC9zeXMvY2xhc3MvYmRpLzA6NDIvbWF4X2J3Ci0tLQogaW5jbHVkZS9saW51eC9iYWNr
aW5nLWRldi1kZWZzLmggfCAgMiArKwogaW5jbHVkZS9saW51eC9iYWNraW5nLWRldi5oICAgICAg
fCAgMyArKysKIG1tL2JhY2tpbmctZGV2LmMgICAgICAgICAgICAgICAgIHwgNDAgKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysKIG1tL3BhZ2Utd3JpdGViYWNrLmMgICAgICAgICAgICAg
IHwgMjkgKysrKysrKysrKysrKysrKysrKysrKysKIDQgZmlsZXMgY2hhbmdlZCwgNzQgaW5zZXJ0
aW9ucygrKQoKZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvYmFja2luZy1kZXYtZGVmcy5oIGIv
aW5jbHVkZS9saW51eC9iYWNraW5nLWRldi1kZWZzLmgKaW5kZXggNGZjODdkZWUwMDVhLi5hMjli
Y2I4YTc5OWQgMTAwNjQ0Ci0tLSBhL2luY2x1ZGUvbGludXgvYmFja2luZy1kZXYtZGVmcy5oCisr
KyBiL2luY2x1ZGUvbGludXgvYmFja2luZy1kZXYtZGVmcy5oCkBAIC0yMDAsNiArMjAwLDggQEAg
c3RydWN0IGJhY2tpbmdfZGV2X2luZm8gewogCXVuc2lnbmVkIGludCBjYXBhYmlsaXRpZXM7IC8q
IERldmljZSBjYXBhYmlsaXRpZXMgKi8KIAl1bnNpZ25lZCBpbnQgbWluX3JhdGlvOwogCXVuc2ln
bmVkIGludCBtYXhfcmF0aW8sIG1heF9wcm9wX2ZyYWM7CisJdTY0IG1pbl9idzsKKwl1NjQgbWF4
X2J3OwogCiAJLyoKIAkgKiBTdW0gb2YgYXZnX3dyaXRlX2J3IG9mIHdicyB3aXRoIGRpcnR5IGlu
b2Rlcy4gID4gMCBpZiB0aGVyZSBhcmUKZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvYmFja2lu
Zy1kZXYuaCBiL2luY2x1ZGUvbGludXgvYmFja2luZy1kZXYuaAppbmRleCBmODgxOTdjMWZmYzIu
LjQ0OTBiZDAzYWVjMSAxMDA2NDQKLS0tIGEvaW5jbHVkZS9saW51eC9iYWNraW5nLWRldi5oCisr
KyBiL2luY2x1ZGUvbGludXgvYmFja2luZy1kZXYuaApAQCAtMTExLDYgKzExMSw5IEBAIHN0YXRp
YyBpbmxpbmUgdW5zaWduZWQgbG9uZyB3Yl9zdGF0X2Vycm9yKHZvaWQpCiBpbnQgYmRpX3NldF9t
aW5fcmF0aW8oc3RydWN0IGJhY2tpbmdfZGV2X2luZm8gKmJkaSwgdW5zaWduZWQgaW50IG1pbl9y
YXRpbyk7CiBpbnQgYmRpX3NldF9tYXhfcmF0aW8oc3RydWN0IGJhY2tpbmdfZGV2X2luZm8gKmJk
aSwgdW5zaWduZWQgaW50IG1heF9yYXRpbyk7CiAKK2ludCBiZGlfc2V0X21pbl9idyhzdHJ1Y3Qg
YmFja2luZ19kZXZfaW5mbyAqYmRpLCB1NjQgbWluX2J3KTsKK2ludCBiZGlfc2V0X21heF9idyhz
dHJ1Y3QgYmFja2luZ19kZXZfaW5mbyAqYmRpLCB1NjQgbWF4X2J3KTsKKwogLyoKICAqIEZsYWdz
IGluIGJhY2tpbmdfZGV2X2luZm86OmNhcGFiaWxpdHkKICAqCmRpZmYgLS1naXQgYS9tbS9iYWNr
aW5nLWRldi5jIGIvbW0vYmFja2luZy1kZXYuYwppbmRleCA2MmYwNWY2MDVmYjUuLjVjMTBkNDQy
NTk3NiAxMDA2NDQKLS0tIGEvbW0vYmFja2luZy1kZXYuYworKysgYi9tbS9iYWNraW5nLWRldi5j
CkBAIC0yMDEsNiArMjAxLDQ0IEBAIHN0YXRpYyBzc2l6ZV90IG1heF9yYXRpb19zdG9yZShzdHJ1
Y3QgZGV2aWNlICpkZXYsCiB9CiBCRElfU0hPVyhtYXhfcmF0aW8sIGJkaS0+bWF4X3JhdGlvKQog
CitzdGF0aWMgc3NpemVfdCBtaW5fYndfc3RvcmUoc3RydWN0IGRldmljZSAqZGV2LAorCQlzdHJ1
Y3QgZGV2aWNlX2F0dHJpYnV0ZSAqYXR0ciwgY29uc3QgY2hhciAqYnVmLCBzaXplX3QgY291bnQp
Cit7CisJc3RydWN0IGJhY2tpbmdfZGV2X2luZm8gKmJkaSA9IGRldl9nZXRfZHJ2ZGF0YShkZXYp
OworCXVuc2lnbmVkIGxvbmcgbG9uZyBsaW1pdDsKKwlzc2l6ZV90IHJldDsKKworCXJldCA9IGtz
dHJ0b3VsbChidWYsIDEwLCAmbGltaXQpOworCWlmIChyZXQgPCAwKQorCQlyZXR1cm4gcmV0Owor
CisJcmV0ID0gYmRpX3NldF9taW5fYncoYmRpLCBsaW1pdCk7CisJaWYgKCFyZXQpCisJCXJldCA9
IGNvdW50OworCisJcmV0dXJuIHJldDsKK30KK0JESV9TSE9XKG1pbl9idywgYmRpLT5taW5fYncp
CisKK3N0YXRpYyBzc2l6ZV90IG1heF9id19zdG9yZShzdHJ1Y3QgZGV2aWNlICpkZXYsCisJCXN0
cnVjdCBkZXZpY2VfYXR0cmlidXRlICphdHRyLCBjb25zdCBjaGFyICpidWYsIHNpemVfdCBjb3Vu
dCkKK3sKKwlzdHJ1Y3QgYmFja2luZ19kZXZfaW5mbyAqYmRpID0gZGV2X2dldF9kcnZkYXRhKGRl
dik7CisJdW5zaWduZWQgbG9uZyBsb25nIGxpbWl0OworCXNzaXplX3QgcmV0OworCisJcmV0ID0g
a3N0cnRvdWxsKGJ1ZiwgMTAsICZsaW1pdCk7CisJaWYgKHJldCA8IDApCisJCXJldHVybiByZXQ7
CisKKwlyZXQgPSBiZGlfc2V0X21heF9idyhiZGksIGxpbWl0KTsKKwlpZiAoIXJldCkKKwkJcmV0
ID0gY291bnQ7CisKKwlyZXR1cm4gcmV0OworfQorQkRJX1NIT1cobWF4X2J3LCBiZGktPm1heF9i
dykKKwogc3RhdGljIHNzaXplX3Qgc3RhYmxlX3BhZ2VzX3JlcXVpcmVkX3Nob3coc3RydWN0IGRl
dmljZSAqZGV2LAogCQkJCQkgIHN0cnVjdCBkZXZpY2VfYXR0cmlidXRlICphdHRyLAogCQkJCQkg
IGNoYXIgKnBhZ2UpCkBAIC0yMTYsNiArMjU0LDggQEAgc3RhdGljIHN0cnVjdCBhdHRyaWJ1dGUg
KmJkaV9kZXZfYXR0cnNbXSA9IHsKIAkmZGV2X2F0dHJfcmVhZF9haGVhZF9rYi5hdHRyLAogCSZk
ZXZfYXR0cl9taW5fcmF0aW8uYXR0ciwKIAkmZGV2X2F0dHJfbWF4X3JhdGlvLmF0dHIsCisJJmRl
dl9hdHRyX21pbl9idy5hdHRyLAorCSZkZXZfYXR0cl9tYXhfYncuYXR0ciwKIAkmZGV2X2F0dHJf
c3RhYmxlX3BhZ2VzX3JlcXVpcmVkLmF0dHIsCiAJTlVMTCwKIH07CmRpZmYgLS1naXQgYS9tbS9w
YWdlLXdyaXRlYmFjay5jIGIvbW0vcGFnZS13cml0ZWJhY2suYwppbmRleCAyY2FmNzgwYTQyZTcu
LmM3YzllZWJjNGM1NiAxMDA2NDQKLS0tIGEvbW0vcGFnZS13cml0ZWJhY2suYworKysgYi9tbS9w
YWdlLXdyaXRlYmFjay5jCkBAIC03MTMsNiArNzEzLDIyIEBAIGludCBiZGlfc2V0X21heF9yYXRp
byhzdHJ1Y3QgYmFja2luZ19kZXZfaW5mbyAqYmRpLCB1bnNpZ25lZCBtYXhfcmF0aW8pCiB9CiBF
WFBPUlRfU1lNQk9MKGJkaV9zZXRfbWF4X3JhdGlvKTsKIAoraW50IGJkaV9zZXRfbWluX2J3KHN0
cnVjdCBiYWNraW5nX2Rldl9pbmZvICpiZGksIHU2NCBtaW5fYncpCit7CisJc3Bpbl9sb2NrX2Jo
KCZiZGlfbG9jayk7CisJYmRpLT5taW5fYncgPSBtaW5fYnc7CisJc3Bpbl91bmxvY2tfYmgoJmJk
aV9sb2NrKTsKKwlyZXR1cm4gMDsKK30KKworaW50IGJkaV9zZXRfbWF4X2J3KHN0cnVjdCBiYWNr
aW5nX2Rldl9pbmZvICpiZGksIHU2NCBtYXhfYncpCit7CisJc3Bpbl9sb2NrX2JoKCZiZGlfbG9j
ayk7CisJYmRpLT5tYXhfYncgPSBtYXhfYnc7CisJc3Bpbl91bmxvY2tfYmgoJmJkaV9sb2NrKTsK
KwlyZXR1cm4gMDsKK30KKwogc3RhdGljIHVuc2lnbmVkIGxvbmcgZGlydHlfZnJlZXJ1bl9jZWls
aW5nKHVuc2lnbmVkIGxvbmcgdGhyZXNoLAogCQkJCQkgICB1bnNpZ25lZCBsb25nIGJnX3RocmVz
aCkKIHsKQEAgLTEwODAsNiArMTA5NiwxNiBAQCBzdGF0aWMgdm9pZCB3Yl9wb3NpdGlvbl9yYXRp
byhzdHJ1Y3QgZGlydHlfdGhyb3R0bGVfY29udHJvbCAqZHRjKQogCWR0Yy0+cG9zX3JhdGlvID0g
cG9zX3JhdGlvOwogfQogCitzdGF0aWMgdTY0IGNsYW1wX2J3KHN0cnVjdCBiYWNraW5nX2Rldl9p
bmZvICpiZGksIHU2NCBidykgeworCWlmIChiZGktPm1pbl9idyA+IDAgJiYgYncgPCBiZGktPm1p
bl9idykgeworCSAgYncgPSBiZGktPm1pbl9idzsKKwl9CisJaWYgKGJkaS0+bWF4X2J3ID4gMCAm
JiBidyA+IGJkaS0+bWF4X2J3KSB7CisJICBidyA9IGJkaS0+bWF4X2J3OworCX0KKwlyZXR1cm4g
Ync7Cit9CisKIHN0YXRpYyB2b2lkIHdiX3VwZGF0ZV93cml0ZV9iYW5kd2lkdGgoc3RydWN0IGJk
aV93cml0ZWJhY2sgKndiLAogCQkJCSAgICAgIHVuc2lnbmVkIGxvbmcgZWxhcHNlZCwKIAkJCQkg
ICAgICB1bnNpZ25lZCBsb25nIHdyaXR0ZW4pCkBAIC0xMTAzLDEyICsxMTI5LDE1IEBAIHN0YXRp
YyB2b2lkIHdiX3VwZGF0ZV93cml0ZV9iYW5kd2lkdGgoc3RydWN0IGJkaV93cml0ZWJhY2sgKndi
LAogCWJ3ICo9IEhaOwogCWlmICh1bmxpa2VseShlbGFwc2VkID4gcGVyaW9kKSkgewogCQlidyA9
IGRpdjY0X3VsKGJ3LCBlbGFwc2VkKTsKKwkJYncgPSBjbGFtcF9idyh3Yi0+YmRpLCBidyk7CiAJ
CWF2ZyA9IGJ3OwogCQlnb3RvIG91dDsKIAl9CiAJYncgKz0gKHU2NCl3Yi0+d3JpdGVfYmFuZHdp
ZHRoICogKHBlcmlvZCAtIGVsYXBzZWQpOwogCWJ3ID4+PSBpbG9nMihwZXJpb2QpOwogCisJYncg
PSBjbGFtcF9idyh3Yi0+YmRpLCBidyk7CisKIAkvKgogCSAqIG9uZSBtb3JlIGxldmVsIG9mIHNt
b290aGluZywgZm9yIGZpbHRlcmluZyBvdXQgc3VkZGVuIHNwaWtlcwogCSAqLwotLSAKMi4yNS4x
Cgo=
--0000000000006d26c905a0aa3f34--
