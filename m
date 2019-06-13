Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1580343E36
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2019 17:48:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732955AbfFMPsN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Jun 2019 11:48:13 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:43533 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388993AbfFMPsM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Jun 2019 11:48:12 -0400
Received: by mail-yb1-f194.google.com with SMTP id n145so8021099ybg.10;
        Thu, 13 Jun 2019 08:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Xkq/YdawHY9AuiXmEkB+3OobT14SZUYyU9St5zYGj+o=;
        b=uXzeotv4zk7qfijw3fEQ5vg6JsKPhBAQHCeZCfCOqjOx2Xnuf9OdvEQBOXinB+woS2
         hI1neVUjcPGquTrml9AnxmEF7PmnSCFZh8Glj8CTlaip/8U1JglJ9TM6Mx054eGpPE96
         4F+3CyW/Ma4+aO7DWpiTYeQzaCumjqG12JNO79WNRlj55nj83mghTv1pDf6zFNLpYS+z
         iepWP/pDh3TOOBE12p1/0IaePEQ2AmH4fZznHqx6H3MGxIQdSNefM2E4z+6iW5D++Bj9
         46IR/T3Xr3xRzYORk98aeKA6sNG7oIyri8VcU2y9GVCQDDqLb8eKncB19iFJXzHiCTIi
         TnvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Xkq/YdawHY9AuiXmEkB+3OobT14SZUYyU9St5zYGj+o=;
        b=Boe3ihouMj8QEIvQSPzvkfHU8sjPCUg9orXn02FW0f3oie01ylMnmiDjfBJ1MbdL5h
         +XjDTnckPWfd6zjL08AJ87ztgWrkOcAUlaT34ntWKzGEP0lZ5veNcj+XDLrzynaC0v9p
         pYdt8BBKO0pxwQspo+AjSyoEW/TcH1GKvSqlk0jAtPFhm254RePmNlTX/Ltd8IrE4qol
         3Z7izY+mk8XcpvQYpUXhCh0HUQUt3vU+Hw9NCtp33vzXxNbxFwtszMFCRENPUwaGv7NK
         zqz5Iy4zeo/DYByNBzmmjpct9TSpm2M8M6TAL9UjBxgQWoUoxom9l+FOBvGiTTrSTijP
         IgYQ==
X-Gm-Message-State: APjAAAViK2ANgji9kWKLKRDPIVovk9KDgSGhJRf9fargc0E4BDKDasx9
        Cimgeq12X7HyL1rYOZ4AKq34lD+nLkrj1xu0gr8=
X-Google-Smtp-Source: APXvYqyIRGPevL3XhqamH5sE/ZVhimyTnatX3tvfb6bhaD/F8kSRQRK86zvAsuRFTz9pqPESIwdS5F4N+M+tkiXiqtY=
X-Received: by 2002:a25:a081:: with SMTP id y1mr18759713ybh.428.1560440890686;
 Thu, 13 Jun 2019 08:48:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190612172408.22671-1-amir73il@gmail.com> <20190612183156.GA27576@fieldses.org>
 <CAJfpegvj0NHQrPcHFd=b47M-uz2CY6Hnamk_dJvcrUtwW65xBw@mail.gmail.com> <20190613143151.GC2145@fieldses.org>
In-Reply-To: <20190613143151.GC2145@fieldses.org>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 13 Jun 2019 18:47:58 +0300
Message-ID: <CAOQ4uxhXjuqMDbUq_4=oL8QETuUF3bs0V5qE9bNDJDind6F2pQ@mail.gmail.com>
Subject: Re: [PATCH v2] locks: eliminate false positive conflicts for write lease
To:     "J . Bruce Fields" <bfields@fieldses.org>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Jeff Layton <jlayton@poochiereds.net>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux NFS list <linux-nfs@vger.kernel.org>,
        overlayfs <linux-unionfs@vger.kernel.org>
Content-Type: multipart/mixed; boundary="000000000000fb9a57058b3674db"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--000000000000fb9a57058b3674db
Content-Type: text/plain; charset="UTF-8"

On Thu, Jun 13, 2019 at 5:32 PM J . Bruce Fields <bfields@fieldses.org> wrote:
>
> On Thu, Jun 13, 2019 at 04:13:15PM +0200, Miklos Szeredi wrote:
> > On Wed, Jun 12, 2019 at 8:31 PM J . Bruce Fields <bfields@fieldses.org> wrote:
> > >
> > > How do opens for execute work?  I guess they create a struct file with
> > > FMODE_EXEC and FMODE_RDONLY set and they decrement i_writecount.  Do
> > > they also increment i_readcount?  Reading do_open_execat and alloc_file,
> > > looks like it does, so, good, they should conflict with write leases,
> > > which sounds right.
> >
> > Right, but then why this:
> >
> > > > +     /* Eliminate deny writes from actual writers count */
> > > > +     if (wcount < 0)
> > > > +             wcount = 0;
> >
> > It's basically a no-op, as you say.  And it doesn't make any sense
> > logically, since denying writes *should* deny write leases as well...
>
> Yes.  I feel like the negative writecount case is a little nonobvious,
> so maybe replace that by a comment, something like this?:
>
> --b.
>
> diff --git a/fs/locks.c b/fs/locks.c
> index 2056595751e8..379829b913c1 100644
> --- a/fs/locks.c
> +++ b/fs/locks.c
> @@ -1772,11 +1772,12 @@ check_conflicting_open(struct file *filp, const long arg, int flags)
>         if (arg == F_RDLCK && wcount > 0)
>                 return -EAGAIN;
>
> -       /* Eliminate deny writes from actual writers count */
> -       if (wcount < 0)
> -               wcount = 0;
> -
> -       /* Make sure that only read/write count is from lease requestor */
> +       /*
> +        * Make sure that only read/write count is from lease requestor.
> +        * Note that this will result in denying write leases when wcount
> +        * is negative, which is what we want.  (We shouldn't grant
> +        * write leases on files open for execution.)
> +        */
>         if (filp->f_mode & FMODE_WRITE)
>                 self_wcount = 1;
>         else if (filp->f_mode & FMODE_READ)

I'm fine with targeting 5.3 and I'm fine with all suggested changes
and adding some of my own. At this point we no longer need wcount
variable and code becomes more readable without it.
See attached patch (also tested).

Thanks,
Amir.

--000000000000fb9a57058b3674db
Content-Type: text/plain; charset="US-ASCII"; 
	name="v3-0001-locks-eliminate-false-positive-conflicts-for-writ.patch.txt"
Content-Disposition: attachment; 
	filename="v3-0001-locks-eliminate-false-positive-conflicts-for-writ.patch.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_jwuu76r00>
X-Attachment-Id: f_jwuu76r00

RnJvbSBkMWIwMjlhNzc4YzkxMDBiZjFhMjk1YzcwMzUzMTk5MTNlZjI1MzMzIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbWlyIEdvbGRzdGVpbiA8YW1pcjczaWxAZ21haWwuY29tPgpE
YXRlOiBGcmksIDcgSnVuIDIwMTkgMTc6MjQ6MzggKzAzMDAKU3ViamVjdDogW1BBVENIIHYzXSBs
b2NrczogZWxpbWluYXRlIGZhbHNlIHBvc2l0aXZlIGNvbmZsaWN0cyBmb3Igd3JpdGUgbGVhc2UK
CmNoZWNrX2NvbmZsaWN0aW5nX29wZW4oKSBpcyBjaGVja2luZyBmb3IgZXhpc3RpbmcgZmQncyBv
cGVuIGZvciByZWFkIG9yCmZvciB3cml0ZSBiZWZvcmUgYWxsb3dpbmcgdG8gdGFrZSBhIHdyaXRl
IGxlYXNlLiAgVGhlIGNoZWNrIHRoYXQgd2FzCmltcGxlbWVudGVkIHVzaW5nIGlfY291bnQgYW5k
IGRfY291bnQgaXMgYW4gYXBwcm94aW1hdGlvbiB0aGF0IGhhcwpzZXZlcmFsIGZhbHNlIHBvc2l0
aXZlcy4gIEZvciBleGFtcGxlLCBvdmVybGF5ZnMgc2luY2UgdjQuMTksIHRha2VzIGFuCmV4dHJh
IHJlZmVyZW5jZSBvbiB0aGUgZGVudHJ5OyBBbiBvcGVuIHdpdGggT19QQVRIIHRha2VzIGEgcmVm
ZXJlbmNlIG9uCnRoZSBkZW50cnkgYWx0aG91Z2ggdGhlIGZpbGUgY2Fubm90IGJlIHJlYWQgbm9y
IHdyaXR0ZW4uCgpDaGFuZ2UgdGhlIGltcGxlbWVudGF0aW9uIHRvIHVzZSBpX3JlYWRjb3VudCBh
bmQgaV93cml0ZWNvdW50IHRvCmVsaW1pbmF0ZSB0aGUgZmFsc2UgcG9zaXRpdmUgY29uZmxpY3Rz
IGFuZCBhbGxvdyBhIHdyaXRlIGxlYXNlIHRvIGJlCnRha2VuIG9uIGFuIG92ZXJsYXlmcyBmaWxl
LgoKVGhlIGNoYW5nZSBvZiBiZWhhdmlvciB3aXRoIGV4aXN0aW5nIGZkJ3Mgb3BlbiB3aXRoIE9f
UEFUSCBpcyBzeW1tZXRyaWMKdy5yLnQuIGN1cnJlbnQgYmVoYXZpb3Igb2YgbGVhc2UgYnJlYWtl
cnMgLSBhbiBvcGVuIHdpdGggT19QQVRIIGN1cnJlbnRseQpkb2VzIG5vdCBicmVhayBhIHdyaXRl
IGxlYXNlLgoKVGhpcyBpbmNyZWFzZXMgdGhlIHNpemUgb2Ygc3RydWN0IGlub2RlIGJ5IDQgYnl0
ZXMgb24gMzJiaXQgYXJjaHMgd2hlbgpDT05GSUdfRklMRV9MT0NLSU5HIGlzIGRlZmluZWQgYW5k
IENPTkZJR19JTUEgd2FzIG5vdCBhbHJlYWR5CmRlZmluZWQuCgpTaWduZWQtb2ZmLWJ5OiBBbWly
IEdvbGRzdGVpbiA8YW1pcjczaWxAZ21haWwuY29tPgotLS0KIGZzL2xvY2tzLmMgICAgICAgICB8
IDM3ICsrKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0KIGluY2x1ZGUvbGludXgv
ZnMuaCB8ICA0ICsrLS0KIDIgZmlsZXMgY2hhbmdlZCwgMjcgaW5zZXJ0aW9ucygrKSwgMTQgZGVs
ZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZnMvbG9ja3MuYyBiL2ZzL2xvY2tzLmMKaW5kZXggZWMx
ZTRhNWRmNjI5Li42MzM1MTIxMDA4NDIgMTAwNjQ0Ci0tLSBhL2ZzL2xvY2tzLmMKKysrIGIvZnMv
bG9ja3MuYwpAQCAtMTc1MywxMCArMTc1MywxMCBAQCBpbnQgZmNudGxfZ2V0bGVhc2Uoc3RydWN0
IGZpbGUgKmZpbHApCiB9CiAKIC8qKgotICogY2hlY2tfY29uZmxpY3Rpbmdfb3BlbiAtIHNlZSBp
ZiB0aGUgZ2l2ZW4gZGVudHJ5IHBvaW50cyB0byBhIGZpbGUgdGhhdCBoYXMKKyAqIGNoZWNrX2Nv
bmZsaWN0aW5nX29wZW4gLSBzZWUgaWYgdGhlIGdpdmVuIGZpbGUgcG9pbnRzIHRvIGFuIGlub2Rl
IHRoYXQgaGFzCiAgKgkJCSAgICBhbiBleGlzdGluZyBvcGVuIHRoYXQgd291bGQgY29uZmxpY3Qg
d2l0aCB0aGUKICAqCQkJICAgIGRlc2lyZWQgbGVhc2UuCi0gKiBAZGVudHJ5OglkZW50cnkgdG8g
Y2hlY2sKKyAqIEBmaWxwOglmaWxlIHRvIGNoZWNrCiAgKiBAYXJnOgl0eXBlIG9mIGxlYXNlIHRo
YXQgd2UncmUgdHJ5aW5nIHRvIGFjcXVpcmUKICAqIEBmbGFnczoJY3VycmVudCBsb2NrIGZsYWdz
CiAgKgpAQCAtMTc2NCwxOSArMTc2NCwzMyBAQCBpbnQgZmNudGxfZ2V0bGVhc2Uoc3RydWN0IGZp
bGUgKmZpbHApCiAgKiBjb25mbGljdCB3aXRoIHRoZSBsZWFzZSB3ZSdyZSB0cnlpbmcgdG8gc2V0
LgogICovCiBzdGF0aWMgaW50Ci1jaGVja19jb25mbGljdGluZ19vcGVuKGNvbnN0IHN0cnVjdCBk
ZW50cnkgKmRlbnRyeSwgY29uc3QgbG9uZyBhcmcsIGludCBmbGFncykKK2NoZWNrX2NvbmZsaWN0
aW5nX29wZW4oc3RydWN0IGZpbGUgKmZpbHAsIGNvbnN0IGxvbmcgYXJnLCBpbnQgZmxhZ3MpCiB7
CiAJaW50IHJldCA9IDA7Ci0Jc3RydWN0IGlub2RlICppbm9kZSA9IGRlbnRyeS0+ZF9pbm9kZTsK
KwlzdHJ1Y3QgaW5vZGUgKmlub2RlID0gbG9ja3NfaW5vZGUoZmlscCk7CisJaW50IHNlbGZfd2Nv
dW50ID0gMCwgc2VsZl9yY291bnQgPSAwOwogCiAJaWYgKGZsYWdzICYgRkxfTEFZT1VUKQogCQly
ZXR1cm4gMDsKIAotCWlmICgoYXJnID09IEZfUkRMQ0spICYmIGlub2RlX2lzX29wZW5fZm9yX3dy
aXRlKGlub2RlKSkKLQkJcmV0dXJuIC1FQUdBSU47CisJaWYgKGFyZyA9PSBGX1JETENLKQorCQly
ZXR1cm4gaW5vZGVfaXNfb3Blbl9mb3Jfd3JpdGUoaW5vZGUpID8gLUVBR0FJTiA6IDA7CisJZWxz
ZSBpZiAoYXJnICE9IEZfV1JMQ0spCisJCXJldHVybiAwOwogCi0JaWYgKChhcmcgPT0gRl9XUkxD
SykgJiYgKChkX2NvdW50KGRlbnRyeSkgPiAxKSB8fAotCSAgICAoYXRvbWljX3JlYWQoJmlub2Rl
LT5pX2NvdW50KSA+IDEpKSkKKwkvKgorCSAqIE1ha2Ugc3VyZSB0aGF0IG9ubHkgcmVhZC93cml0
ZSBjb3VudCBpcyBmcm9tIGxlYXNlIHJlcXVlc3Rvci4KKwkgKiBOb3RlIHRoYXQgdGhpcyB3aWxs
IHJlc3VsdCBpbiBkZW55aW5nIHdyaXRlIGxlYXNlcyB3aGVuIGlfd3JpdGVjb3VudAorCSAqIGlz
IG5lZ2F0aXZlLCB3aGljaCBpcyB3aGF0IHdlIHdhbnQuICAoV2Ugc2hvdWxkbid0IGdyYW50IHdy
aXRlIGxlYXNlcworCSAqIG9uIGZpbGVzIG9wZW4gZm9yIGV4ZWN1dGlvbi4pCisJICovCisJaWYg
KGZpbHAtPmZfbW9kZSAmIEZNT0RFX1dSSVRFKQorCQlzZWxmX3djb3VudCA9IDE7CisJZWxzZSBp
ZiAoZmlscC0+Zl9tb2RlICYgRk1PREVfUkVBRCkKKwkJc2VsZl9yY291bnQgPSAxOworCisJaWYg
KGF0b21pY19yZWFkKCZpbm9kZS0+aV93cml0ZWNvdW50KSAhPSBzZWxmX3djb3VudCB8fAorCSAg
ICBhdG9taWNfcmVhZCgmaW5vZGUtPmlfcmVhZGNvdW50KSAhPSBzZWxmX3Jjb3VudCkKIAkJcmV0
ID0gLUVBR0FJTjsKIAogCXJldHVybiByZXQ7CkBAIC0xNzg2LDggKzE4MDAsNyBAQCBzdGF0aWMg
aW50CiBnZW5lcmljX2FkZF9sZWFzZShzdHJ1Y3QgZmlsZSAqZmlscCwgbG9uZyBhcmcsIHN0cnVj
dCBmaWxlX2xvY2sgKipmbHAsIHZvaWQgKipwcml2KQogewogCXN0cnVjdCBmaWxlX2xvY2sgKmZs
LCAqbXlfZmwgPSBOVUxMLCAqbGVhc2U7Ci0Jc3RydWN0IGRlbnRyeSAqZGVudHJ5ID0gZmlscC0+
Zl9wYXRoLmRlbnRyeTsKLQlzdHJ1Y3QgaW5vZGUgKmlub2RlID0gZGVudHJ5LT5kX2lub2RlOwor
CXN0cnVjdCBpbm9kZSAqaW5vZGUgPSBsb2Nrc19pbm9kZShmaWxwKTsKIAlzdHJ1Y3QgZmlsZV9s
b2NrX2NvbnRleHQgKmN0eDsKIAlib29sIGlzX2RlbGVnID0gKCpmbHApLT5mbF9mbGFncyAmIEZM
X0RFTEVHOwogCWludCBlcnJvcjsKQEAgLTE4MjIsNyArMTgzNSw3IEBAIGdlbmVyaWNfYWRkX2xl
YXNlKHN0cnVjdCBmaWxlICpmaWxwLCBsb25nIGFyZywgc3RydWN0IGZpbGVfbG9jayAqKmZscCwg
dm9pZCAqKnByCiAJcGVyY3B1X2Rvd25fcmVhZCgmZmlsZV9yd3NlbSk7CiAJc3Bpbl9sb2NrKCZj
dHgtPmZsY19sb2NrKTsKIAl0aW1lX291dF9sZWFzZXMoaW5vZGUsICZkaXNwb3NlKTsKLQllcnJv
ciA9IGNoZWNrX2NvbmZsaWN0aW5nX29wZW4oZGVudHJ5LCBhcmcsIGxlYXNlLT5mbF9mbGFncyk7
CisJZXJyb3IgPSBjaGVja19jb25mbGljdGluZ19vcGVuKGZpbHAsIGFyZywgbGVhc2UtPmZsX2Zs
YWdzKTsKIAlpZiAoZXJyb3IpCiAJCWdvdG8gb3V0OwogCkBAIC0xODc5LDcgKzE4OTIsNyBAQCBn
ZW5lcmljX2FkZF9sZWFzZShzdHJ1Y3QgZmlsZSAqZmlscCwgbG9uZyBhcmcsIHN0cnVjdCBmaWxl
X2xvY2sgKipmbHAsIHZvaWQgKipwcgogCSAqIHByZWNlZGVzIHRoZXNlIGNoZWNrcy4KIAkgKi8K
IAlzbXBfbWIoKTsKLQllcnJvciA9IGNoZWNrX2NvbmZsaWN0aW5nX29wZW4oZGVudHJ5LCBhcmcs
IGxlYXNlLT5mbF9mbGFncyk7CisJZXJyb3IgPSBjaGVja19jb25mbGljdGluZ19vcGVuKGZpbHAs
IGFyZywgbGVhc2UtPmZsX2ZsYWdzKTsKIAlpZiAoZXJyb3IpIHsKIAkJbG9ja3NfdW5saW5rX2xv
Y2tfY3R4KGxlYXNlKTsKIAkJZ290byBvdXQ7CmRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L2Zz
LmggYi9pbmNsdWRlL2xpbnV4L2ZzLmgKaW5kZXggNzlmZmEyOTU4YmQ4Li4yZDU1ZjFiNjQwMTQg
MTAwNjQ0Ci0tLSBhL2luY2x1ZGUvbGludXgvZnMuaAorKysgYi9pbmNsdWRlL2xpbnV4L2ZzLmgK
QEAgLTY5NCw3ICs2OTQsNyBAQCBzdHJ1Y3QgaW5vZGUgewogCWF0b21pY190CQlpX2NvdW50Owog
CWF0b21pY190CQlpX2Rpb19jb3VudDsKIAlhdG9taWNfdAkJaV93cml0ZWNvdW50OwotI2lmZGVm
IENPTkZJR19JTUEKKyNpZiBkZWZpbmVkKENPTkZJR19JTUEpIHx8IGRlZmluZWQoQ09ORklHX0ZJ
TEVfTE9DS0lORykKIAlhdG9taWNfdAkJaV9yZWFkY291bnQ7IC8qIHN0cnVjdCBmaWxlcyBvcGVu
IFJPICovCiAjZW5kaWYKIAl1bmlvbiB7CkBAIC0yODk1LDcgKzI4OTUsNyBAQCBzdGF0aWMgaW5s
aW5lIGJvb2wgaW5vZGVfaXNfb3Blbl9mb3Jfd3JpdGUoY29uc3Qgc3RydWN0IGlub2RlICppbm9k
ZSkKIAlyZXR1cm4gYXRvbWljX3JlYWQoJmlub2RlLT5pX3dyaXRlY291bnQpID4gMDsKIH0KIAot
I2lmZGVmIENPTkZJR19JTUEKKyNpZiBkZWZpbmVkKENPTkZJR19JTUEpIHx8IGRlZmluZWQoQ09O
RklHX0ZJTEVfTE9DS0lORykKIHN0YXRpYyBpbmxpbmUgdm9pZCBpX3JlYWRjb3VudF9kZWMoc3Ry
dWN0IGlub2RlICppbm9kZSkKIHsKIAlCVUdfT04oIWF0b21pY19yZWFkKCZpbm9kZS0+aV9yZWFk
Y291bnQpKTsKLS0gCjIuMTcuMQoK
--000000000000fb9a57058b3674db--
