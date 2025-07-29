Return-Path: <linux-fsdevel+bounces-56275-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32FE3B15422
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Jul 2025 22:12:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B5D6561832
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Jul 2025 20:12:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CED092BDC10;
	Tue, 29 Jul 2025 20:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=cybernetics.com header.i=@cybernetics.com header.b="bfWYl46t"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.cybernetics.com (mail.cybernetics.com [72.215.153.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B11F2BD5A3
	for <linux-fsdevel@vger.kernel.org>; Tue, 29 Jul 2025 20:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=72.215.153.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753819958; cv=none; b=LbCYp+Im0+wLUghJRfmnF+EDHR5zk0UO/i29iEkSgyBT+2rF1iz0N2mCTAyoLpWGwjhL+XCWbrPXXpxHF0nHELd12PxpEglsmZay2L+bpfgOfegexHhRuisIxNTwlx4qRXRRtnhunt3NHbyhIz2Y1BZ0Dam6+Nal9f/yDSVBPZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753819958; c=relaxed/simple;
	bh=TLqZ3K3G8pT3V00OXKgBt+8XJkZHle7uIDj7ge3vXRc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WApiyMnoov4TFj28bptkXtwAC8yJkY8HIaREg34DsiG2bcu0ullV0I1jMxr4n2UXowkm9gW7w7wLc1adAwh1uJSzBq8QMOmmNDY/kbQbg7iG9k1zovDdv4GGB6NOF9Md0hafEnLpmsIxf960GRXbsSPGBEEfPpcEQfpBAUVgrfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cybernetics.com; spf=pass smtp.mailfrom=cybernetics.com; dkim=fail (1024-bit key) header.d=cybernetics.com header.i=@cybernetics.com header.b=bfWYl46t reason="signature verification failed"; arc=none smtp.client-ip=72.215.153.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cybernetics.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cybernetics.com
Received: from cybernetics.com ([10.10.4.126]) by mail.cybernetics.com with ESMTP id HMboJofUymKmKC7Y; Tue, 29 Jul 2025 16:12:35 -0400 (EDT)
X-Barracuda-Envelope-From: tonyb@cybernetics.com
X-Barracuda-RBL-Trusted-Forwarder: 10.10.4.126
X-ASG-Whitelist: Client
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=cybernetics.com; s=mail;
	bh=RQCFIUWU5fd0elOWoWAsjEllXgLsRj/FlWICOM44UoM=;
	h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Content-Language:Subject:MIME-Version:Date:Message-ID; b=bfWYl46t5/A3oqn5HGcK
	7jdIOuv+1TwgSlFR4Bm+Otw6fqlNY0E7NkL+bbApE969ogcbIQ8JzEJJMxSGvOf5DwWw2Si1NSoiU
	40/OUGOv27nKo+16r7oKF5z2v1/75N6dK6NuFXyQLc8uCkuDKglZ1+kDgQMSNMqy3RsTfiyXn4=
Received: from [10.157.2.224] (HELO [192.168.200.1])
  by cybernetics.com (CommuniGate SPEC SMTP 8.0.5)
  with ESMTPS id 14114145; Tue, 29 Jul 2025 16:12:35 -0400
Message-ID: <c5f853ad-9675-454a-9838-125304ae94ef@cybernetics.com>
X-Barracuda-RBL-Trusted-Forwarder: 10.157.2.224
Date: Tue, 29 Jul 2025 16:12:34 -0400
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] iomap: align writeback to RAID stripe boundaries
Content-Language: en-US
X-ASG-Orig-Subj: Re: [PATCH 2/2] iomap: align writeback to RAID stripe boundaries
To: Matthew Wilcox <willy@infradead.org>
Cc: Song Liu <song@kernel.org>, Yu Kuai <yukuai3@huawei.com>,
 Christian Brauner <brauner@kernel.org>, "Darrick J. Wong"
 <djwong@kernel.org>, linux-raid@vger.kernel.org, linux-xfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <55deda1d-967d-4d68-a9ba-4d5139374a37@cybernetics.com>
 <aIkVHBsC6M5ZHGzQ@casper.infradead.org>
 <17323677-08b1-46c3-90a8-5418d0bde9fe@cybernetics.com>
 <aIkeMTMJbdvNxjqf@casper.infradead.org>
From: Tony Battersby <tonyb@cybernetics.com>
In-Reply-To: <aIkeMTMJbdvNxjqf@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
X-Barracuda-Connect: UNKNOWN[10.10.4.126]
X-Barracuda-Start-Time: 1753819955
X-Barracuda-URL: https://10.10.4.122:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at cybernetics.com
X-Barracuda-Scan-Msg-Size: 4232
X-Barracuda-BRTS-Status: 1
Content-Transfer-Encoding: quoted-printable
X-ASG-Debug-ID: 1753819955-1cf43947df829b0001-kl68QG

On 7/29/25 15:17, Matthew Wilcox wrote:
> Hm.  Maybe something like this would be more clear?
>
> (contents and indeed name of iomap_should_split_ioend() very much TBD)
>
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 9f541c05103b..429890fb7763 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -1684,6 +1684,7 @@ static int iomap_add_to_ioend(struct iomap_writep=
age_ctx *wpc,
>  	struct iomap_folio_state *ifs =3D folio->private;
>  	size_t poff =3D offset_in_folio(folio, pos);
>  	unsigned int ioend_flags =3D 0;
> +	unsigned thislen;
>  	int error;
> =20
>  	if (wpc->iomap.type =3D=3D IOMAP_UNWRITTEN)
> @@ -1704,8 +1705,16 @@ static int iomap_add_to_ioend(struct iomap_write=
page_ctx *wpc,
>  				ioend_flags);
>  	}
> =20
> -	if (!bio_add_folio(&wpc->ioend->io_bio, folio, len, poff))
> +	thislen =3D iomap_should_split_ioend(wpc, pos, len);
> +
> +	if (!bio_add_folio(&wpc->ioend->io_bio, folio, thislen, poff))
> +		goto new_ioend;
> +	if (thislen < len) {
> +		pos +=3D thislen;
> +		len -=3D thislen;
> +		wbc_account_cgroup_owner(wbc, folio, thislen);
>  		goto new_ioend;
> +	}
> =20
>  	if (ifs)
>  		atomic_add(len, &ifs->write_bytes_pending);


How is this?=C2=A0 Does ioend_flags need to be recomputed (particularly
IOMAP_IOEND_BOUNDARY) when processing the remainder of the folio?

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index fb4519158f3a..0967e6fd62a1 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1669,6 +1669,39 @@ static bool iomap_can_add_to_ioend(struct iomap_wr=
itepage_ctx *wpc, loff_t pos,
 	return true;
 }
=20
+static unsigned int iomap_should_split_ioend(struct iomap_writepage_ctx =
*wpc,
+		loff_t pos, unsigned int len)
+{
+	struct queue_limits *lim =3D bdev_limits(wpc->iomap.bdev);
+
+	if ((lim->features & BLK_FEAT_RAID_PARTIAL_STRIPES_EXPENSIVE) &&
+	    !(wpc->iomap.flags & IOMAP_F_ANON_WRITE)) {
+		unsigned int io_align =3D lim->io_opt >> SECTOR_SHIFT;
+
+		/* Split sequential writes along io_align boundaries. */
+		if (io_align) {
+			sector_t lba =3D bio_end_sector(&wpc->ioend->io_bio);
+			unsigned int mod =3D lba % io_align;
+			unsigned int max_len;
+
+			/*
+			 * If the end sector is already aligned and the bio is
+			 * nonempty, then start a new bio for the remainder.
+			 */
+			if (!mod && wpc->ioend->io_bio.bi_iter.bi_size)
+				return 0;
+
+			/*
+			 * Clip the end of the bio to the alignment boundary.
+			 */
+			max_len =3D (io_align - mod) << SECTOR_SHIFT;
+			if (len > max_len)
+				len =3D max_len;
+		}
+	}
+	return len;
+}
+
 /*
  * Test to see if we have an existing ioend structure that we could appe=
nd to
  * first; otherwise finish off the current ioend and start another.
@@ -1688,6 +1721,7 @@ static int iomap_add_to_ioend(struct iomap_writepag=
e_ctx *wpc,
 	struct iomap_folio_state *ifs =3D folio->private;
 	size_t poff =3D offset_in_folio(folio, pos);
 	unsigned int ioend_flags =3D 0;
+	unsigned int thislen;
 	int error;
=20
 	if (wpc->iomap.type =3D=3D IOMAP_UNWRITTEN)
@@ -1708,11 +1742,14 @@ static int iomap_add_to_ioend(struct iomap_writep=
age_ctx *wpc,
 				ioend_flags);
 	}
=20
-	if (!bio_add_folio(&wpc->ioend->io_bio, folio, len, poff))
+	thislen =3D iomap_should_split_ioend(wpc, pos, len);
+	if (!thislen)
+		goto new_ioend;
+	if (!bio_add_folio(&wpc->ioend->io_bio, folio, thislen, poff))
 		goto new_ioend;
=20
 	if (ifs)
-		atomic_add(len, &ifs->write_bytes_pending);
+		atomic_add(thislen, &ifs->write_bytes_pending);
=20
 	/*
 	 * Clamp io_offset and io_size to the incore EOF so that ondisk
@@ -1755,11 +1792,18 @@ static int iomap_add_to_ioend(struct iomap_writep=
age_ctx *wpc,
 	 * Note that this defeats the ability to chain the ioends of
 	 * appending writes.
 	 */
-	wpc->ioend->io_size +=3D len;
+	wpc->ioend->io_size +=3D thislen;
 	if (wpc->ioend->io_offset + wpc->ioend->io_size > end_pos)
 		wpc->ioend->io_size =3D end_pos - wpc->ioend->io_offset;
=20
-	wbc_account_cgroup_owner(wbc, folio, len);
+	wbc_account_cgroup_owner(wbc, folio, thislen);
+
+	if (thislen < len) {
+		pos +=3D thislen;
+		len -=3D thislen;
+		goto new_ioend;
+	}
+
 	return 0;
 }
=20

--=20
2.43.0


