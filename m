Return-Path: <linux-fsdevel+bounces-4727-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB356802AE3
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 05:32:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35B85B207F5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 04:32:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CEDF1EB2C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 04:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hPQWM4gu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7270CF3
	for <linux-fsdevel@vger.kernel.org>; Sun,  3 Dec 2023 20:09:23 -0800 (PST)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-5d4f71f7e9fso25417647b3.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 03 Dec 2023 20:09:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701662962; x=1702267762; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GYEy8kccuU/d4RqwnKbLSWjVNxsFIN3X39pgAqk88hU=;
        b=hPQWM4guKMEQxD47inyd24oqA2s6SnJ5TgqtpCndXN0KR1dplAPskCO4ELfJVTd//j
         Km4lVjWDOpSeeIeLEyEP//+EnJX544L3wPrGdl/GeUOmEC1Bkor6vqaVnZPPFbUKUoxn
         isN+OZKTLV1A0AH/ufBb1VhLYSRgXdZJABX7CV8mWFvVvviTS8lnbXZkaBYBJJdM3NLy
         RPdVk33+LwHWUW/oJt5MWDcKmSNBNKabInSEwmcngBR40dwp2J7zCmFdRRiTt9j3EeUG
         KkIE6ZdOi17fE4iYEgt5KMQhQpWLZT3tE20yREeSS7MhF7xb/V/xUOFK2SPf9m4sM1r/
         KUlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701662962; x=1702267762;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GYEy8kccuU/d4RqwnKbLSWjVNxsFIN3X39pgAqk88hU=;
        b=IDM+l5Fd1mMzWcrKaoPyd1xDTwJi4tiSdhhganqgxQkLPENBNeBaxNMc7JqE7//m+C
         /5IOI8EW1fpIzSCxs+oLTgZiJdNy8O0v1tVXR6FIImRDqrRWSuGJozhOQ5dyI1vAPjFz
         zpAAnPfW4clb/zM4b2PrwSWSx2yIS+ch9Zfy3sqzB7DvFhOH0h9623FIU4dYP+ve9lzI
         KYbRsaGyRdaTAuQ3J8L9e1ROt8LK6dVijNStsGI3wg4QMdwNDhwV3rWi1Tmt0GQrTuV2
         HecOxW/UEuRQo4SxUlEUdiJVx3BDRNNahtuqjH24kDLjNj7LXd5rOPlRWbQhjAOAh19D
         zQZw==
X-Gm-Message-State: AOJu0Yw8zJeOKf/UFuMKGzPWtlgMuw4yoDClb98WqbdJfkVJ81mMiCDY
	UsjdrTYAdvX82fLs+FtOtPVb03agLWvumo0+VmQAZw==
X-Google-Smtp-Source: AGHT+IGtIjOu7QUUMAWbu6y/ebKjsFXSJGR6VL4GtZ4TI3ggL5oP9LK19DHSITX5Fg7tD5y+3IjDQcKZ2xMiwVQZDIc=
X-Received: by 2002:a05:690c:f85:b0:5d7:1940:dd62 with SMTP id
 df5-20020a05690c0f8500b005d71940dd62mr2260818ywb.56.1701662962373; Sun, 03
 Dec 2023 20:09:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231121171643.3719880-1-surenb@google.com> <20231121171643.3719880-6-surenb@google.com>
 <b3c882d2-0135-430c-8179-784f78be0902@arm.com> <a41c759f-78d8-44ed-b708-1bb737a8e6c1@redhat.com>
 <cb3d3b12-abf3-4eda-8d9a-944684d05505@arm.com> <ccdb1080-7a2e-4f98-a4e8-e864fa2db299@redhat.com>
In-Reply-To: <ccdb1080-7a2e-4f98-a4e8-e864fa2db299@redhat.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Sun, 3 Dec 2023 20:09:09 -0800
Message-ID: <CAJuCfpHS63bXkRGE1_G4z-2fDe72BeLka8t5ioSg2OXjbUrHXg@mail.gmail.com>
Subject: Re: [PATCH v5 5/5] selftests/mm: add UFFDIO_MOVE ioctl test
To: David Hildenbrand <david@redhat.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>, akpm@linux-foundation.org, 
	viro@zeniv.linux.org.uk, brauner@kernel.org, shuah@kernel.org, 
	aarcange@redhat.com, lokeshgidra@google.com, peterx@redhat.com, 
	hughd@google.com, mhocko@suse.com, axelrasmussen@google.com, rppt@kernel.org, 
	willy@infradead.org, Liam.Howlett@oracle.com, jannh@google.com, 
	zhangpeng362@huawei.com, bgeffon@google.com, kaleshsingh@google.com, 
	ngeoffray@google.com, jdduke@google.com, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kernel-team@android.com
Content-Type: multipart/mixed; boundary="00000000000066ca67060ba74878"

--00000000000066ca67060ba74878
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 2, 2023 at 2:11=E2=80=AFAM David Hildenbrand <david@redhat.com>=
 wrote:
>
> On 02.12.23 09:04, Ryan Roberts wrote:
> > On 01/12/2023 20:47, David Hildenbrand wrote:
> >> On 01.12.23 10:29, Ryan Roberts wrote:
> >>> On 21/11/2023 17:16, Suren Baghdasaryan wrote:
> >>>> Add tests for new UFFDIO_MOVE ioctl which uses uffd to move source
> >>>> into destination buffer while checking the contents of both after
> >>>> the move. After the operation the content of the destination buffer
> >>>> should match the original source buffer's content while the source
> >>>> buffer should be zeroed. Separate tests are designed for PMD aligned=
 and
> >>>> unaligned cases because they utilize different code paths in the ker=
nel.
> >>>>
> >>>> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> >>>> ---
> >>>>    tools/testing/selftests/mm/uffd-common.c     |  24 +++
> >>>>    tools/testing/selftests/mm/uffd-common.h     |   1 +
> >>>>    tools/testing/selftests/mm/uffd-unit-tests.c | 189 ++++++++++++++=
+++++
> >>>>    3 files changed, 214 insertions(+)
> >>>>
> >>>> diff --git a/tools/testing/selftests/mm/uffd-common.c
> >>>> b/tools/testing/selftests/mm/uffd-common.c
> >>>> index fb3bbc77fd00..b0ac0ec2356d 100644
> >>>> --- a/tools/testing/selftests/mm/uffd-common.c
> >>>> +++ b/tools/testing/selftests/mm/uffd-common.c
> >>>> @@ -631,6 +631,30 @@ int copy_page(int ufd, unsigned long offset, bo=
ol wp)
> >>>>        return __copy_page(ufd, offset, false, wp);
> >>>>    }
> >>>>    +int move_page(int ufd, unsigned long offset, unsigned long len)
> >>>> +{
> >>>> +    struct uffdio_move uffdio_move;
> >>>> +
> >>>> +    if (offset + len > nr_pages * page_size)
> >>>> +        err("unexpected offset %lu and length %lu\n", offset, len);
> >>>> +    uffdio_move.dst =3D (unsigned long) area_dst + offset;
> >>>> +    uffdio_move.src =3D (unsigned long) area_src + offset;
> >>>> +    uffdio_move.len =3D len;
> >>>> +    uffdio_move.mode =3D UFFDIO_MOVE_MODE_ALLOW_SRC_HOLES;
> >>>> +    uffdio_move.move =3D 0;
> >>>> +    if (ioctl(ufd, UFFDIO_MOVE, &uffdio_move)) {
> >>>> +        /* real retval in uffdio_move.move */
> >>>> +        if (uffdio_move.move !=3D -EEXIST)
> >>>> +            err("UFFDIO_MOVE error: %"PRId64,
> >>>> +                (int64_t)uffdio_move.move);
> >>>
> >>> Hi Suren,
> >>>
> >>> FYI this error is triggering in mm-unstable (715b67adf4c8):
> >>>
> >>> Testing move-pmd on anon... ERROR: UFFDIO_MOVE error: -16 (errno=3D16=
,
> >>> @uffd-common.c:648)
> >>>
> >>> I'm running in a VM on Apple M2 (arm64). I haven't debugged any furth=
er, but
> >>> happy to go deeper if you can direct.
> >>
> >> Does it trigger reliably? Which pagesize is that kernel using?
> >
> > Yep, although very occasionally it fails with EAGAIN. 4K kernel; see ot=
her email
> > for full config.
> >
> >>
> >> I can spot that uffd_move_pmd_test()/uffd_move_pmd_handle_fault() uses
> >> default_huge_page_size(), which reads the default hugetlb size.
> >
> > My kernel command line is explicitly seting the default huge page size =
to 2M.
> >
>
> Okay, so that likely won't affect it.
>
> I can only guess that it has to do with the alignment of the virtual
> area we are testing with, and that we do seem to get more odd patterns
> on arm64.
>
> uffd_move_test_common() is a bit more elaborate, but if we aligned the
> src+start area up, surely "step_count" cannot be left unmodified?
>
> So assuming we get either an unaligned source or an unaligned dst from
> mmap(), I am not convinced that we won't be moving areas that are not
> necessarily fully backed by PMDs and maybe don't even fall into the VMA
> of interest?
>
> Not sure if that could trigger the THP splitting issue, though.
>
> But I just quickly scanned that test setup, could be I am missing
> something. It might make sense to just print the mmap'ed range and the
> actual ranges we are trying to move. Maybe something "obvious" can be
> observed.

I was able to reproduce the issue on an Android device and after
implementing David's suggestions to split the large folio and after
replacing default_huge_page_size() with read_pmd_pagesize(), the
move-pmd test started working for me. Ryan, could you please apply
attached patches (over mm-unstable) and try the test again?
Thanks,
Suren.

>
> --
> Cheers,
>
> David / dhildenb
>

--00000000000066ca67060ba74878
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-userfaultfd-split-large-pmd-mapped-folio.patch"
Content-Disposition: attachment; 
	filename="0001-userfaultfd-split-large-pmd-mapped-folio.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_lpqe5cp81>
X-Attachment-Id: f_lpqe5cp81

RnJvbSBjYmQ0MzQ4NDg0OTg2MTkzYzQ1MjM1YmFiYmFlNmUzMDMxOGQ5ZTQ4IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTdXJlbiBCYWdoZGFzYXJ5YW4gPHN1cmVuYkBnb29nbGUuY29t
PgpEYXRlOiBTdW4sIDMgRGVjIDIwMjMgMTk6NTM6NDUgLTA4MDAKU3ViamVjdDogW1BBVENIIDEv
Ml0gdXNlcmZhdWx0ZmQ6IHNwbGl0IGxhcmdlIHBtZC1tYXBwZWQgZm9saW8KClNpZ25lZC1vZmYt
Ynk6IFN1cmVuIEJhZ2hkYXNhcnlhbiA8c3VyZW5iQGdvb2dsZS5jb20+Ci0tLQogbW0vdXNlcmZh
dWx0ZmQuYyB8IDE3ICsrKysrKysrKysrKysrKysrCiAxIGZpbGUgY2hhbmdlZCwgMTcgaW5zZXJ0
aW9ucygrKQoKZGlmZiAtLWdpdCBhL21tL3VzZXJmYXVsdGZkLmMgYi9tbS91c2VyZmF1bHRmZC5j
CmluZGV4IDcxZDAyODFmMTE2Mi4uNmU2ZjY3MjA2N2ZlIDEwMDY0NAotLS0gYS9tbS91c2VyZmF1
bHRmZC5jCisrKyBiL21tL3VzZXJmYXVsdGZkLmMKQEAgLTEzODIsOCArMTM4MiwyNSBAQCBzc2l6
ZV90IG1vdmVfcGFnZXMoc3RydWN0IHVzZXJmYXVsdGZkX2N0eCAqY3R4LCBzdHJ1Y3QgbW1fc3Ry
dWN0ICptbSwKIAkJCS8qIENoZWNrIGlmIHdlIGNhbiBtb3ZlIHRoZSBwbWQgd2l0aG91dCBzcGxp
dHRpbmcgaXQuICovCiAJCQlpZiAobW92ZV9zcGxpdHNfaHVnZV9wbWQoZHN0X2FkZHIsIHNyY19h
ZGRyLCBzcmNfc3RhcnQgKyBsZW4pIHx8CiAJCQkgICAgIXBtZF9ub25lKGRzdF9wbWR2YWwpKSB7
CisJCQkJc3RydWN0IGZvbGlvICpmb2xpbyA9IHBmbl9mb2xpbyhwbWRfcGZuKCpzcmNfcG1kKSk7
CisJCQkJaWYgKCFmb2xpbyB8fCAhUGFnZUFub25FeGNsdXNpdmUoJmZvbGlvLT5wYWdlKSkgewor
CQkJCQlzcGluX3VubG9jayhwdGwpOworCQkJCQllcnIgPSAtRUJVU1k7CisJCQkJCWJyZWFrOwor
CQkJCX0KKwkJCQlmb2xpb19nZXQoZm9saW8pOwogCQkJCXNwaW5fdW5sb2NrKHB0bCk7CiAJCQkJ
c3BsaXRfaHVnZV9wbWQoc3JjX3ZtYSwgc3JjX3BtZCwgc3JjX2FkZHIpOworCQkJCWlmIChmb2xp
b190ZXN0X2xhcmdlKGZvbGlvKSkgeworCQkJCQlmb2xpb19sb2NrKGZvbGlvKTsKKwkJCQkJZXJy
ID0gc3BsaXRfZm9saW8oZm9saW8pOworCQkJCQlmb2xpb191bmxvY2soZm9saW8pOworCQkJCQlp
ZiAoZXJyKSB7CisJCQkJCQlmb2xpb19wdXQoZm9saW8pOworCQkJCQkJYnJlYWs7CisJCQkJCX0K
KwkJCQl9CisJCQkJZm9saW9fcHV0KGZvbGlvKTsKIAkJCQljb250aW51ZTsKIAkJCX0KIAotLSAK
Mi40My4wLnJjMi40NTEuZzg2MzFiYzc0NzItZ29vZwoK
--00000000000066ca67060ba74878
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0002-selftests-mm-use-correct-function-to-obtain-huge-pag.patch"
Content-Disposition: attachment; 
	filename="0002-selftests-mm-use-correct-function-to-obtain-huge-pag.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_lpqe5cox0>
X-Attachment-Id: f_lpqe5cox0

RnJvbSBhYjNlMTM3Y2U5ZWJmM2E5NDllMTRiOWY1NDRhOGEyMTQ0OTM0Zjg2IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTdXJlbiBCYWdoZGFzYXJ5YW4gPHN1cmVuYkBnb29nbGUuY29t
PgpEYXRlOiBTdW4sIDMgRGVjIDIwMjMgMjA6MDQ6MDggLTA4MDAKU3ViamVjdDogW1BBVENIIDIv
Ml0gc2VsZnRlc3RzL21tOiB1c2UgY29ycmVjdCBmdW5jdGlvbiB0byBvYnRhaW4gaHVnZSBwYWdl
CiBzaXplCgpTaWduZWQtb2ZmLWJ5OiBTdXJlbiBCYWdoZGFzYXJ5YW4gPHN1cmVuYkBnb29nbGUu
Y29tPgotLS0KIHRvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL21tL3VmZmQtdW5pdC10ZXN0cy5jIHwg
NCArKy0tCiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQoK
ZGlmZiAtLWdpdCBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL21tL3VmZmQtdW5pdC10ZXN0cy5j
IGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvbW0vdWZmZC11bml0LXRlc3RzLmMKaW5kZXggZTRl
MjcxNTExZGI5Li4wN2M4ZGM0OTA5OTMgMTAwNjQ0Ci0tLSBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRl
c3RzL21tL3VmZmQtdW5pdC10ZXN0cy5jCisrKyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL21t
L3VmZmQtdW5pdC10ZXN0cy5jCkBAIC0xMDk2LDcgKzEwOTYsNyBAQCBzdGF0aWMgdm9pZCB1ZmZk
X21vdmVfaGFuZGxlX2ZhdWx0KHN0cnVjdCB1ZmZkX21zZyAqbXNnLAogc3RhdGljIHZvaWQgdWZm
ZF9tb3ZlX3BtZF9oYW5kbGVfZmF1bHQoc3RydWN0IHVmZmRfbXNnICptc2csCiAJCQkJICAgICAg
IHN0cnVjdCB1ZmZkX2FyZ3MgKmFyZ3MpCiB7Ci0JdWZmZF9tb3ZlX2hhbmRsZV9mYXVsdF9jb21t
b24obXNnLCBhcmdzLCBkZWZhdWx0X2h1Z2VfcGFnZV9zaXplKCkpOworCXVmZmRfbW92ZV9oYW5k
bGVfZmF1bHRfY29tbW9uKG1zZywgYXJncywgcmVhZF9wbWRfcGFnZXNpemUoKSk7CiB9CiAKIHN0
YXRpYyB2b2lkCkBAIC0xMTk5LDcgKzExOTksNyBAQCBzdGF0aWMgdm9pZCB1ZmZkX21vdmVfdGVz
dCh1ZmZkX3Rlc3RfYXJnc190ICp0YXJncykKIAogc3RhdGljIHZvaWQgdWZmZF9tb3ZlX3BtZF90
ZXN0KHVmZmRfdGVzdF9hcmdzX3QgKnRhcmdzKQogewotCXVmZmRfbW92ZV90ZXN0X2NvbW1vbih0
YXJncywgZGVmYXVsdF9odWdlX3BhZ2Vfc2l6ZSgpLAorCXVmZmRfbW92ZV90ZXN0X2NvbW1vbih0
YXJncywgcmVhZF9wbWRfcGFnZXNpemUoKSwKIAkJCSAgICAgIHVmZmRfbW92ZV9wbWRfaGFuZGxl
X2ZhdWx0KTsKIH0KIAotLSAKMi40My4wLnJjMi40NTEuZzg2MzFiYzc0NzItZ29vZwoK
--00000000000066ca67060ba74878--

