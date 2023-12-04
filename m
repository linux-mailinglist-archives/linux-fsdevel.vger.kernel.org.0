Return-Path: <linux-fsdevel+bounces-4729-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C7802802D29
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 09:32:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48CB41F20F59
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 08:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB9A0E552
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 08:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G0n3BXb4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F181EF2
	for <linux-fsdevel@vger.kernel.org>; Sun,  3 Dec 2023 22:50:32 -0800 (PST)
Received: by mail-qv1-xf36.google.com with SMTP id 6a1803df08f44-67a959e3afaso20489506d6.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 03 Dec 2023 22:50:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701672632; x=1702277432; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=btNoobo3az5waZdzgfHdR3eOhxVEhg6QdBIxWQxy7Oo=;
        b=G0n3BXb42CsUBCF67ErAKTt/waBL0qYE4risFASUz7Vg+t9XI3bQi62nzU7oztqzez
         G84f3A/JgoFCeikQ0RrLPjlsdXmn0qPC57jcabOGwMTMf1EpzS7NBjImtSfkjwq7ezVI
         UQVGVq6lLM13Yx/brH6/tcpBcOevVVCK3hl5vmjdnBcyYE3Gz4o8SBO2bgNph7o0jnQ2
         MRcxY48Nm1b3d6tNUUQhl/Uj6ndxd6l07CBU1zottPDtbJ0DeujupTMoA7JfujT4Db6P
         uTj8QcfAcJKJswLQ7VdawOaDrWnAXnMAKgkPUjTM9BiFJjM3E6pcOLunRRc+Mvbzysym
         74Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701672632; x=1702277432;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=btNoobo3az5waZdzgfHdR3eOhxVEhg6QdBIxWQxy7Oo=;
        b=UblteUH33HVDWq1bMaqmHBsrWC5TofJ51ySCCOvUK5OcOIZEDuYHNCjQf7ovabKSy+
         0r6v1PRkUE1NQVVxO/jQJSreUrgIWzliKO96O8kGIe4ugUAWvZ2ROv+a6YuBA/zB+A/Q
         Kg7YF5LJJp2SigkeKWT0CXJaxj2T40J4Tbjt/pW+JKIsMDDgiMemHK9ckzdj3WnJ3Yik
         ZHRhFuXldcA1EbU3ypomVE22lcmxTWQg2sEv8y40z/UjMXiH2O0jn9CVgq/+jJq3Q24D
         Iv0naZvH7EyC8XdZg6mTAULTUz8AOvic5rzzrfTus39UO8Febyi3G4Bmiw0z1sI4TQWO
         QaXA==
X-Gm-Message-State: AOJu0YxyMLvgL+R0ts4qWAtkBC3T82enQyF6eydLyytx2DwZ2XeSKX8Z
	Cow4clbIYdjlhUTwISPx25phpyZDKSU7nHjcdF0=
X-Google-Smtp-Source: AGHT+IEweVkCj11DgLmTmvNMWzuqvqYtMFqxkZQMh5Twp+jjWB7P3MEQrxfePjtAs34ozSRFe3F5TbmBaQe+g5KUBHs=
X-Received: by 2002:a0c:eace:0:b0:67a:a721:caf3 with SMTP id
 y14-20020a0ceace000000b0067aa721caf3mr3858441qvp.84.1701672631940; Sun, 03
 Dec 2023 22:50:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230920024001.493477-1-tfanelli@redhat.com> <CAJfpegtVbmFnjN_eg9U=C1GBB0U5TAAqag3wY_mi7v8rDSGzgg@mail.gmail.com>
 <32469b14-8c7a-4763-95d6-85fd93d0e1b5@fastmail.fm> <CAOQ4uxgW58Umf_ENqpsGrndUB=+8tuUsjT+uCUp16YRSuvG2wQ@mail.gmail.com>
 <CAOQ4uxh6RpoyZ051fQLKNHnXfypoGsPO9szU0cR6Va+NR_JELw@mail.gmail.com> <49fdbcd1-5442-4cd4-8a85-1ddb40291b7d@fastmail.fm>
In-Reply-To: <49fdbcd1-5442-4cd4-8a85-1ddb40291b7d@fastmail.fm>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 4 Dec 2023 08:50:20 +0200
Message-ID: <CAOQ4uxjfU0X9Q4bUoQd_U56y4yUUKGaqyFS1EJ3FGAPrmBMSkg@mail.gmail.com>
Subject: Re: [PATCH 0/2] fuse: Rename DIRECT_IO_{RELAX -> ALLOW_MMAP}
To: Bernd Schubert <bernd.schubert@fastmail.fm>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Tyler Fanelli <tfanelli@redhat.com>, 
	linux-fsdevel@vger.kernel.org, mszeredi@redhat.com, gmaglione@redhat.com, 
	hreitz@redhat.com, Hao Xu <howeyxu@tencent.com>
Content-Type: multipart/mixed; boundary="000000000000c07d07060ba98872"

--000000000000c07d07060ba98872
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 4, 2023 at 1:00=E2=80=AFAM Bernd Schubert
<bernd.schubert@fastmail.fm> wrote:
>
> Hi Amir,
>
> On 12/3/23 12:20, Amir Goldstein wrote:
> > On Sat, Dec 2, 2023 at 5:06=E2=80=AFPM Amir Goldstein <amir73il@gmail.c=
om> wrote:
> >>
> >> On Mon, Nov 6, 2023 at 4:08=E2=80=AFPM Bernd Schubert
> >> <bernd.schubert@fastmail.fm> wrote:
> >>>
> >>> Hi Miklos,
> >>>
> >>> On 9/20/23 10:15, Miklos Szeredi wrote:
> >>>> On Wed, 20 Sept 2023 at 04:41, Tyler Fanelli <tfanelli@redhat.com> w=
rote:
> >>>>>
> >>>>> At the moment, FUSE_INIT's DIRECT_IO_RELAX flag only serves the pur=
pose
> >>>>> of allowing shared mmap of files opened/created with DIRECT_IO enab=
led.
> >>>>> However, it leaves open the possibility of further relaxing the
> >>>>> DIRECT_IO restrictions (and in-effect, the cache coherency guarante=
es of
> >>>>> DIRECT_IO) in the future.
> >>>>>
> >>>>> The DIRECT_IO_ALLOW_MMAP flag leaves no ambiguity of its purpose. I=
t
> >>>>> only serves to allow shared mmap of DIRECT_IO files, while still
> >>>>> bypassing the cache on regular reads and writes. The shared mmap is=
 the
> >>>>> only loosening of the cache policy that can take place with the fla=
g.
> >>>>> This removes some ambiguity and introduces a more stable flag to be=
 used
> >>>>> in FUSE_INIT. Furthermore, we can document that to allow shared mma=
p'ing
> >>>>> of DIRECT_IO files, a user must enable DIRECT_IO_ALLOW_MMAP.
> >>>>>
> >>>>> Tyler Fanelli (2):
> >>>>>     fs/fuse: Rename DIRECT_IO_RELAX to DIRECT_IO_ALLOW_MMAP
> >>>>>     docs/fuse-io: Document the usage of DIRECT_IO_ALLOW_MMAP
> >>>>
> >>>> Looks good.
> >>>>
> >>>> Applied, thanks.  Will send the PR during this merge window, since t=
he
> >>>> rename could break stuff if already released.
> >>>
> >>> I'm just porting back this feature to our internal fuse module and it
> >>> looks these rename patches have been forgotten?
> >>>
> >>>
> >>
> >> Hi Miklos, Bernd,
> >>
> >> I was looking at the DIRECT_IO_ALLOW_MMAP code and specifically at
> >> commit b5a2a3a0b776 ("fuse: write back dirty pages before direct write=
 in
> >> direct_io_relax mode") and I was wondering - isn't dirty pages writeba=
ck
> >> needed *before* invalidate_inode_pages2() in fuse_file_mmap() for
> >> direct_io_allow_mmap case?
> >>
> >> For FUSE_PASSTHROUGH, I am going to need to call fuse_vma_close()
> >> for munmap of files also in direct-io mode [1], so I was considering i=
nstalling
> >> fuse_file_vm_ops for the FOPEN_DIRECT_IO case, same as caching case,
> >> and regardless of direct_io_allow_mmap.
> >>
> >> I was asking myself if there was a good reason why fuse_page_mkwrite()=
/
> >> fuse_wait_on_page_writeback()/fuse_vma_close()/write_inode_now()
> >> should NOT be called for the FOPEN_DIRECT_IO case regardless of
> >> direct_io_allow_mmap?
> >>
> >
> > Before trying to make changes to fuse_file_mmap() I tried to test
> > DIRECT_IO_RELAX - I enabled it in libfuse and ran fstest with
> > passthrough_hp --direct-io.
> >
> > The test generic/095 - "Concurrent mixed I/O (buffer I/O, aiodio, mmap,=
 splice)
> > on the same files" blew up hitting BUG_ON(fi->writectr < 0) in
> > fuse_set_nowrite()
> >
> > I am wondering how this code was tested?
> >
> > I could not figure out the problem and how to fix it.
> > Please suggest a fix and let me know which adjustments are needed
> > if I want to use fuse_file_vm_ops for all mmap modes.
>
> So fuse_set_nowrite() tests for inode_is_locked(), but that also
> succeeds for a shared lock. It gets late here (and I might miss
> something), but I think we have an issue with
> FOPEN_PARALLEL_DIRECT_WRITES. Assuming there would be plain O_DIRECT and
> mmap, the same issue might triggered? Hmm, well, so far plain O_DIRECT
> does not support FOPEN_PARALLEL_DIRECT_WRITES yet - the patches for that
> are still pending.
>

Your analysis seems to be correct.

Attached patch fixes the problem and should be backported to 6.6.y.

Miklos,

I prepared the patch on top of master and not on top of the rename to
FUSE_DIRECT_IO_ALLOW_MMAP in for-next for ease of backport to
6.6.y, although if you are planning send the flag rename to v6.7 as a fix,
you may prefer to apply the fix after the rename and request to backport
the flag rename along with the fix to 6.6.y.

Having the final flag name in v6.6.y would be a nice bonus.

Let me know if you want me to post the fix patch based on for-next.

Thanks,
Amir.

--000000000000c07d07060ba98872
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-fuse-disable-FOPEN_PARALLEL_DIRECT_WRITES-with-FUSE_.patch"
Content-Disposition: attachment; 
	filename="0001-fuse-disable-FOPEN_PARALLEL_DIRECT_WRITES-with-FUSE_.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_lpqjtamq0>
X-Attachment-Id: f_lpqjtamq0

RnJvbSA0Njg2NWUyNjYwZDBlOWQ2NGNkOGM1NmM5MDVlYWZlZTdmNGMwM2I1IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbWlyIEdvbGRzdGVpbiA8YW1pcjczaWxAZ21haWwuY29tPgpE
YXRlOiBTdW4sIDMgRGVjIDIwMjMgMDk6NDI6MzMgKzAyMDAKU3ViamVjdDogW1BBVENIXSBmdXNl
OiBkaXNhYmxlIEZPUEVOX1BBUkFMTEVMX0RJUkVDVF9XUklURVMgd2l0aAogRlVTRV9ESVJFQ1Rf
SU9fUkVMQVgKClRoZSBuZXcgZnVzZSBpbml0IGZsYWcgRlVTRV9ESVJFQ1RfSU9fUkVMQVggYnJl
YWtzIGFzc3VtcHRpb25zIG1hZGUgYnkKRk9QRU5fUEFSQUxMRUxfRElSRUNUX1dSSVRFUyBhbmQg
Y2F1c2VzIHRlc3QgZ2VuZXJpYy8wOTUgdG8gaGl0CkJVR19PTihmaS0+d3JpdGVjdHIgPCAwKSBh
c3NlcnRpb25zIGluIGZ1c2Vfc2V0X25vd3JpdGUoKToKCmdlbmVyaWMvMDk1IDVzIC4uLgogIGtl
cm5lbCBCVUcgYXQgZnMvZnVzZS9kaXIuYzoxNzU2IQouLi4KICA/IGZ1c2Vfc2V0X25vd3JpdGUr
MHgzZC8weGRkCiAgPyBkb19yYXdfc3Bpbl91bmxvY2srMHg4OC8weDhmCiAgPyBfcmF3X3NwaW5f
dW5sb2NrKzB4MmQvMHg0MwogID8gZnVzZV9yYW5nZV9pc193cml0ZWJhY2srMHg3MS8weDg0CiAg
ZnVzZV9zeW5jX3dyaXRlcysweGYvMHgxOQogIGZ1c2VfZGlyZWN0X2lvKzB4MTY3LzB4NWJkCiAg
ZnVzZV9kaXJlY3Rfd3JpdGVfaXRlcisweGYwLzB4MTQ2CgpBdXRvIGRpc2FibGUgRk9QRU5fUEFS
QUxMRUxfRElSRUNUX1dSSVRFUyB3aGVuIHNlcnZlciBuZWdvdGlhdGVkCkZVU0VfRElSRUNUX0lP
X1JFTEFYLgoKRml4ZXM6IGU3ODY2MmU4MThmOSAoImZ1c2U6IGFkZCBhIG5ldyBmdXNlIGluaXQg
ZmxhZyB0byByZWxheCByZXN0cmljdGlvbnMgaW4gbm8gY2FjaGUgbW9kZSIpCkNjOiA8c3RhYmxl
QHZnZXIua2VybmVsLm9yZz4gIyB2Ni42ClNpZ25lZC1vZmYtYnk6IEFtaXIgR29sZHN0ZWluIDxh
bWlyNzNpbEBnbWFpbC5jb20+Ci0tLQogZnMvZnVzZS9maWxlLmMgfCAyICsrCiAxIGZpbGUgY2hh
bmdlZCwgMiBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvZnMvZnVzZS9maWxlLmMgYi9mcy9m
dXNlL2ZpbGUuYwppbmRleCAxY2RiNjMyNzUxMWUuLjViNTI5NzgwNTY3NSAxMDA2NDQKLS0tIGEv
ZnMvZnVzZS9maWxlLmMKKysrIGIvZnMvZnVzZS9maWxlLmMKQEAgLTE1NzQsNiArMTU3NCw3IEBA
IHN0YXRpYyBzc2l6ZV90IGZ1c2VfZGlyZWN0X3dyaXRlX2l0ZXIoc3RydWN0IGtpb2NiICppb2Ni
LCBzdHJ1Y3QgaW92X2l0ZXIgKmZyb20pCiAJc3NpemVfdCByZXM7CiAJYm9vbCBleGNsdXNpdmVf
bG9jayA9CiAJCSEoZmYtPm9wZW5fZmxhZ3MgJiBGT1BFTl9QQVJBTExFTF9ESVJFQ1RfV1JJVEVT
KSB8fAorCQlnZXRfZnVzZV9jb25uKGlub2RlKS0+ZGlyZWN0X2lvX3JlbGF4IHx8CiAJCWlvY2It
PmtpX2ZsYWdzICYgSU9DQl9BUFBFTkQgfHwKIAkJZnVzZV9kaXJlY3Rfd3JpdGVfZXh0ZW5kaW5n
X2lfc2l6ZShpb2NiLCBmcm9tKTsKIApAQCAtMTU4MSw2ICsxNTgyLDcgQEAgc3RhdGljIHNzaXpl
X3QgZnVzZV9kaXJlY3Rfd3JpdGVfaXRlcihzdHJ1Y3Qga2lvY2IgKmlvY2IsIHN0cnVjdCBpb3Zf
aXRlciAqZnJvbSkKIAkgKiBUYWtlIGV4Y2x1c2l2ZSBsb2NrIGlmCiAJICogLSBQYXJhbGxlbCBk
aXJlY3Qgd3JpdGVzIGFyZSBkaXNhYmxlZCAtIGEgdXNlciBzcGFjZSBkZWNpc2lvbgogCSAqIC0g
UGFyYWxsZWwgZGlyZWN0IHdyaXRlcyBhcmUgZW5hYmxlZCBhbmQgaV9zaXplIGlzIGJlaW5nIGV4
dGVuZGVkLgorCSAqIC0gU2hhcmVkIG1tYXAgb24gZGlyZWN0X2lvIGZpbGUgaXMgc3VwcG9ydGVk
IChGVVNFX0RJUkVDVF9JT19SRUxBWCkuCiAJICogICBUaGlzIG1pZ2h0IG5vdCBiZSBuZWVkZWQg
YXQgYWxsLCBidXQgbmVlZHMgZnVydGhlciBpbnZlc3RpZ2F0aW9uLgogCSAqLwogCWlmIChleGNs
dXNpdmVfbG9jaykKLS0gCjIuMzQuMQoK
--000000000000c07d07060ba98872--

