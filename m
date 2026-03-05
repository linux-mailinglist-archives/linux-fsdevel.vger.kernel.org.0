Return-Path: <linux-fsdevel+bounces-79455-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CFRYFAfiqGnzyAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79455-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Mar 2026 02:53:11 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BBD5620A05C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Mar 2026 02:53:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 37FF0300F155
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Mar 2026 01:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3798223F431;
	Thu,  5 Mar 2026 01:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cv4Ln1cR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4777C1DDC3F
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Mar 2026 01:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772675587; cv=pass; b=eZVwkqJOCy0RKaFGSfAxBZGl1bZAmooMNjI9XgcoaD/jS6+HDfZmsfH9g57koDmRAjglyO3Q0jm0Emzlo5Zy1Qy4bPFV4DJKVJu6pCElMmyr4br1h1sL9CXMxmpMCkB1VdHmnD2f2C2iIK8+VrNUBQRltNslSKsShRkuh67fkEc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772675587; c=relaxed/simple;
	bh=ntIWI44XhbzJ01+Ixe9KyoWroMqp700hFYczqbHV8RM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lV/PRiCR8RwzZydX4ATiPMMi+im/WtNkVtxKpPuFu5hCZx6khgvETJsIlaUJxRq+1cU852TA9dwgDzK0XQ+eVBXR+EqRGIXQQY/5yG3LSLLk/UWKN6TovPWON4CnD+CNEBh2iOL6B/3d72EaSCMiuWYuY4lkbHatnLbXqhQptsI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cv4Ln1cR; arc=pass smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5a12c19affeso266007e87.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Mar 2026 17:53:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772675584; cv=none;
        d=google.com; s=arc-20240605;
        b=B+Fb47IqqjIFtbSAetaprhPi3gxfgoB2BAb+cvSY2ws6bAv5NJCDL6bFs1DuD3Sv4h
         ooKv30N7DH6vHG/zzX8XshaszXgkAPmJKYI4uNYlWVY1KJStP3zxOqs3rpfJnCAqObow
         gF13f4cDDcgdoLnRx52lzPL/Fq+QDZq3tJUQZUmBvykMFNI4zI1pfyeEx3VuXeumDAam
         eTpTqbTOiN2Ishy5NLLYlktu0KUKJGYHS6cmBqRaYwUy0ZHEv4jSxn1QJpP5GqNMGOj3
         Co3/7MxXh3TZ/4AHVeP5Lz4uH3FDrHPMTLUNVUKdRRXZWIfJ23wyzvOCPXz3LZ89Psbk
         UuAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1x2qBOSDCDv48vE0uZ55r6XBT7XPXD+iHbyKvfP+UBY=;
        fh=7VWht2BXuybY6evhxAqlQcg8eFood6b+PxwNwjIoML8=;
        b=XJ2OkwxgubEhDivDtOd7HsmYHovAytzMK+S9QzXwbI+725U7jPXZ8TEK2j4Tdld/cg
         xIF1ACDUjthhI8fK+E44K7hpDD8twl/JMDr6oY+9QQzgYeXwxVnqKjPo6K3JJBhwBPLK
         vkmRDzentej45vj1cgmqRKU88R4RKUYafCtWixS8ZuSZOI3FkRYnqwlIBPgwjFwTJIzx
         l8aqVMnhHomQhSWKvVUO+rT/lBFQjVUyVL0B/SaJmRwtHDZ9/6bRCWyW5IDPdypFe2yC
         p0qZ4p0OkJNgWDsADxGNv8CamC1fLwlEZfctUnh6N8gsAvt9JIMiBAyzr2qHdHMDUHah
         uNPA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772675584; x=1773280384; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1x2qBOSDCDv48vE0uZ55r6XBT7XPXD+iHbyKvfP+UBY=;
        b=Cv4Ln1cRaRR8X4H7lOXl6LemvUe5PrKmSikZhZ6ZcjJrilV2FCtEOkni5hPt5NtrAE
         45sS0DUPqhFHLENjta2gtnWzuZUEr+vLwUhPz0IjCTuJ31VKrqbzLw3T5Mt3K1esFDA3
         xbT2A5zPwD8aCw+mDhfT90CqSeVdAEbiFatXbGeRCDYGYzelCAczlQwM1gIxCfAhyyBy
         YXg+TLc7PxMuQF+LARD0lw6caBepHtbBnx1v+DphBb4N+QjP4ITNtrs3KReS6m8oFLFL
         3uglRylTB+OX8RGRJPswHQw0g7Y0AqM01Ztv+/fUU+Ly6mb3uJ1UKpeG+n1suUJjFHow
         wZqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772675584; x=1773280384;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1x2qBOSDCDv48vE0uZ55r6XBT7XPXD+iHbyKvfP+UBY=;
        b=iBBqV7b1mZYentIyTCkDm3F8LJ9292usJZ6pSRGUQfxgDz9mRtiGMrurQT5SCv0j8w
         eGIM9/iEik/0GQEQbLGXLc4Wj6VxG0whu4IO5Y9wY2+fSpoJAt5TnkzFQeUUz42Wj0uN
         2cKClxRS64NoPjic/AHtEdCMZ8T/3uynfTmz/BJO2BSsG+vRXfxpWKTbRKIElgQf4Hyl
         2nl6o78rIXu6TNsoilzumIXCxtt6M2toolerQdTNm9wjq1cSE89bnUv9OFuMG1J/3IOQ
         YpYX+4d6id2d5RQ/ZHx8eu24fA1NYq8nwZKoit/6Xur0ns2kR4OPqpjwR8x/kswSB64n
         JIcA==
X-Forwarded-Encrypted: i=1; AJvYcCX6wHmF9EdWvfBxIoyGhVoNNzIvu8zDYng+lE82vDFjOjYWiaaS8eNHy56pMYc3jypk3SN4LHRCTOeZTGvm@vger.kernel.org
X-Gm-Message-State: AOJu0Ywm8mJkJBsCJ3cdpx7APrvmcJvGeQJ0roTKCcr1uDeXaGrW6T+B
	GEs9JZXT9XdSGS/+ArTq8r59KbStOAT9DxmTrLYtLTl6xTaq4pV6e/2U6TXuzF+/aKQlgmg8WDa
	xmAd805Nt2t9DfkfTqy1TwboGAhLuLNc=
X-Gm-Gg: ATEYQzwY6obypdKdD1mqUeQk6JYyd1+B1sKxjKr71lW6RA878EfSsAQmGpzkCce/D0H
	2aJlnKGCqsmUy1ntLjrYK+eSu0zeyUKytixha1lelXwhWpVMgQ235clbNtj6fGmkoveWk23d7jT
	ttyodjrf72I61kiS1XjWfbdy9BApMVv7AoZ0w3wu3ykis/DN44E3oULIePAbzvvcNjnKRzZRnC0
	TWr/RKn4ESZmu5aQPFklQa5Co3bllO7YVd7dksctF/jr16Kgma2rDE7HdYJ8LrMea++Z/oAJTnc
	SkJeCUA=
X-Received: by 2002:a05:6512:6c4:b0:5a1:298d:ef15 with SMTP id
 2adb3069b0e04-5a131f23fbamr185869e87.18.1772675584101; Wed, 04 Mar 2026
 17:53:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260303082807.750679-1-hyc.lee@gmail.com> <aaguv09zaPCgdzWO@infradead.org>
 <5c670210661f30038070616c65492fa2a96b028c.camel@ibm.com> <aajObSSRGVXG3sI_@hyunchul-PC02>
 <532c5cdf12ced8eee5e5a93efe592937b63b889d.camel@ibm.com>
In-Reply-To: <532c5cdf12ced8eee5e5a93efe592937b63b889d.camel@ibm.com>
From: Hyunchul Lee <hyc.lee@gmail.com>
Date: Thu, 5 Mar 2026 10:52:52 +0900
X-Gm-Features: AaiRm51ahB9I_Hmu83wc8wKKdJf2BzKKHxxLSSl0G04_l8twTYUqv7Q2mcnhndE
Message-ID: <CANFS6bZm3G9HA3X5Bi2_KGZDNGuguQzG44-cMcQHto2+qe_05g@mail.gmail.com>
Subject: Re: [PATCH] hfsplus: limit sb_maxbytes to partition size
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Cc: "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>, "frank.li@vivo.com" <frank.li@vivo.com>, 
	"slava@dubeyko.com" <slava@dubeyko.com>, "hch@infradead.org" <hch@infradead.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "cheol.lee@lge.com" <cheol.lee@lge.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: BBD5620A05C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-79455-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hyclee@gmail.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,mail.gmail.com:mid,bootlin.com:url]
X-Rspamd-Action: no action

2026=EB=85=84 3=EC=9B=94 5=EC=9D=BC (=EB=AA=A9) AM 9:47, Viacheslav Dubeyko=
 <Slava.Dubeyko@ibm.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On Thu, 2026-03-05 at 09:29 +0900, Hyunchul Lee wrote:
> > On Wed, Mar 04, 2026 at 08:04:30PM +0000, Viacheslav Dubeyko wrote:
> > > On Wed, 2026-03-04 at 05:08 -0800, Christoph Hellwig wrote:
> > > > On Tue, Mar 03, 2026 at 05:28:07PM +0900, Hyunchul Lee wrote:
> > > > > s_maxbytes currently is set to MAX_LFS_FILESIZE,
> > > > > which allows writes beyond the partition size.
> > > >
> > > > The "partition size" does not matter here.  s_maxbytes is the maxim=
um
> > > > size supported by the format and has nothing to do with the actual =
space
> > > > allocated to the file system (which in Linux terminology would be t=
he
> > > > block device and not the partition anyway).
> > > >
> > > > >
> > > > > As a result,
> > > > > large-offset writes on small partitions can fail late
> > > > > with ENOSPC.
> > > >
> > > > That sounds like some other check is missing in hfsplus, but it
> > > > should be about the available free space, not the device size.
> > > >
> > >
> > > I agree with Christoph.
> > >
> > > But, frankly speaking, I don't quite follow which particular issue is=
 under fix
> > > here. I can see that generic/268 failure has been mentioned. However,=
 I can see
> > > this:
> > >
> > > sudo ./check generic/268
> > > FSTYP         -- hfsplus
> > > PLATFORM      -- Linux/x86_64 hfsplus-testing-0001 6.19.0-rc1+ #95 SM=
P
> > > PREEMPT_DYNAMIC Thu Feb 19 15:29:55 PST 2026
> > > MKFS_OPTIONS  -- /dev/loop51
> > > MOUNT_OPTIONS -- /dev/loop51 /mnt/scratch
> > >
> > > generic/268       [not run] Reflink not supported by scratch filesyst=
em type:
> > > hfsplus
> > > Ran: generic/268
> > > Not run: generic/268
> > > Passed all 1 tests
> > >
> > > Which particular issue is under fix?
> >
> > Sorry it's generic/285, not generic/268.
> > in generic/285, there is a test that creates a hole exceeding the block
> > size and appends small data to the file. hfsplus fails because it fills
> > the block device and returns ENOSPC. However if it returns EFBIG
> > instead, the test is skipped.
> >
> > For writes like xfs_io -c "pwrite 8t 512", should fops->write_iter
> > returns ENOSPC, or would it be better to return EFBIG?
> > >
>
> Current hfsplus_file_extend() implementation doesn't support holes. I ass=
ume you
> mean this code [1]:
>
>         len =3D hip->clump_blocks;
>         start =3D hfsplus_block_allocate(sb, sbi->total_blocks, goal, &le=
n);
>         if (start >=3D sbi->total_blocks) {
>                 start =3D hfsplus_block_allocate(sb, goal, 0, &len);
>                 if (start >=3D goal) {
>                         res =3D -ENOSPC;
>                         goto out;
>                 }
>         }
>
> Am I correct?
>
Yes,

hfsplus_write_begin()
  cont_write_begin()
    cont_expand_zero()

1) xfs_io -c "pwrite 8t 512"
2) hfsplus_begin_write() is called with offset 2^43 and length 512
3) cont_expand_zero() allocates and zeroes out one block repeatedly
for the range
0 to 2^43 - 1. To achieve this, hfsplus_write_begin() is called repeatedly.
4) hfsplus_write_begin() allocates one block through hfsplus_get_block() =
=3D>
hfsplus_file_extend()

> Do you mean that calling logic expects -EFBIG? Potentially, if we tries t=
o
> extend the file, then -EFBIG could be more appropriate. But it needs to c=
heck
> the whole call trace.

generic/285 creates a hole by pwrite at offset 2^43 + @ and handle the
error as follow:
https://github.com/kdave/xfstests/blob/master/src/seek_sanity_test.c#L271

if (errno =3D=3D EFBIG) {
  fprintf(stdout, "Test skipped as fs doesn't support so large files.\n");
  ret =3D 0

>
> Thanks,
> Slava.
>
> [1] https://elixir.bootlin.com/linux/v6.19/source/fs/hfsplus/extents.c#L4=
63



--=20
Thanks,
Hyunchul

