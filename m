Return-Path: <linux-fsdevel+bounces-78410-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gAc/OQd7n2lmcQQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78410-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Feb 2026 23:43:19 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C28C619E694
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Feb 2026 23:43:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 05B0C3007A69
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Feb 2026 22:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4445A355819;
	Wed, 25 Feb 2026 22:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="nsrj0T6H"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C943D349B15
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Feb 2026 22:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=148.163.135.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772059393; cv=pass; b=QZZ6fy+GCZ7h2hGLngyVqAirfNT2t5YKTe9QAbAAwFe+VfGiw41MNT44MjBqonen9iNtY4l737nDihQyE3j2bRYOtW3ZWGVmmONrTixeaEtNDyISWHKmxXnikcmtJrSevkdEiDTc5Bw7+Y3kvNgGtqHhChMlAmEoz//z5gUBVTE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772059393; c=relaxed/simple;
	bh=pDtBt1IUvockGTD9sAkNQUVYnZ2xavhQA7l7ZDVpiZY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KzwjqhoTBS3aFWBT9+cR1snhvxhb6+t+xpLK2LAjeG20+MhhAStp7H+0zFTveBC3ke06te23eWBhGRs4YEOFvmiLQSdSo5d123Xm5RGrZ7M+J2yPzhdS3KQTVp3xCkHKttw2MHWOYHxh2AEV35QLpPD7CkwI1Cq99yshQnR17LY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=nsrj0T6H; arc=pass smtp.client-ip=148.163.135.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Received: from pps.filterd (m0167069.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61PMg5mb1328727
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Feb 2026 17:43:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=pDtB
	t1IUvockGTD9sAkNQUVYnZ2xavhQA7l7ZDVpiZY=; b=nsrj0T6HCt6fbehQN3aM
	mCW3EK4O0E/cM/Qy7KmXDptiP9Si3inQNFYIQScWj2MSnIVqk1bh6Ulf2iHVeiyG
	jOkKvI97CiUm8nbFeOE8ZSU6uEg9o21CwOqyT0zDJZaulMCy+81avk/zmfLBGPpH
	8zS2au6AvembXSGV6xYbFUcUF5MKKn8LhyrXp7Sf7rQ/fIjdSv01VirEFwBfgwbZ
	WZtyfKQt0yCgnh9sFSfrI9pnPAcpLvFJNu3YOATmrfvTleq6h4woEObun258q4a+
	8GChmZaWdoX1h6JiicGPjWZ3UYKC3TK6vAzSf9/FhEcslwYYazjWijqQesgqf0ma
	CA==
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com [209.85.128.198])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4chx6v5yby-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Feb 2026 17:43:12 -0500 (EST)
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-797b0076763so3361957b3.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Feb 2026 14:43:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772059391; cv=none;
        d=google.com; s=arc-20240605;
        b=lu5SvJWo29Hv7JClOfeSABJEcIZr4JHyzCK4zFUURsGQJh8qJCoj80X/MD3ouH6T/c
         sxCgdQlPJ82biP/S8TFsQm11Aa2pSCK2fBK6Rz1IzZ5CXC2qYnuBU2PNov/gfLjOZ9ER
         Fp/Zg9DFdNCwv1Cez9m4YhEO9heTXprVrzDpeTuxsVHz0F/TrcYnQ8v6q9PKLSVfWZK+
         /9PuzGwkwXOgpvAM5vjZNlYYx7y+3LwMP3j2jWHBAa59IBWtozeoThhpiUNS2RNZmjVY
         6mGdyDOUz0dRodvI3c99SuJCoRl+WTpAho8jEMZvSNwE6xm/3X14RmoJmdeHpK5ZrPCC
         2Wwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=pDtBt1IUvockGTD9sAkNQUVYnZ2xavhQA7l7ZDVpiZY=;
        fh=bWWp0tpCY4b0zfN3ydeqAsSWcAv1KPjoYavlBBCS0AU=;
        b=cj251fev4KIrS50C10ddCSYKrQwSNLQfx2ek6RRr1sJYOdC99WRAv504SkGEcRjRNH
         mw8aDVvMxVbV7QEcthkJ7yZ2P3FJFdTev3rvaaoXtAehrlJ2rh1479kNc6YURJ5Mdt9S
         WOJp3KNrPCkRJWctpAa1i6PJywXw+2wYs1yMRPN3O6QfK1cZtjrD22D5/6/0j62xBjpb
         grcuXqomrut562cDfJQLKIX0tgAdPTblOn3bnoRduAFyYez49WEpWbCgf+MeWemv32OC
         SXm5MHi7/Yf4QivuIS4bOSmXnLNrX8Ag+w/yAwsNcXDajdsxpiWz0HJ7Dr0Xp7PJC2HD
         ER1A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772059391; x=1772664191;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pDtBt1IUvockGTD9sAkNQUVYnZ2xavhQA7l7ZDVpiZY=;
        b=w+q+wNkwxJjVkAofmTGV+woJZ2MyY26Wx3PxmbRVpzc97pKAPqV7kuZef3uhqxYOQC
         o3KYgGy3Oulb/2dSFEjtrBC5tdWXrIzMeZeJ926Rv7Xf+YgIVJzp2Wl8lHs6rWRL3v3Q
         tkCRD4LiJtsuuLXVw38GfTtJJ58rpf0U+rhoKMZ89HcGiSFKUbsPP4+yjeGUsQJYEyWd
         wdLLrcFTWDKZwilu07HwwXJW7PQEa+LD5/rO9IBuc9qTeLSy6htls1CkVe/+WMnYb7lf
         A8gcXI3j+G4zApMVmLGss2VznQhz0IwlNakKv9MVbymepfmNuTF5RpgAuPlYuVT3Yxvj
         STsg==
X-Forwarded-Encrypted: i=1; AJvYcCVZeK6/Un6FWE7ztDC+8cZWCxfWl90UkYhEs6mgJ4NTO2hg6zU2ICO+e36hwb+yvjfB/ChsoWTRSotGsIdV@vger.kernel.org
X-Gm-Message-State: AOJu0Yys7b8elh/H6CNHlH+LLKCh4/5i0FzPWaHJVIRPxNIC+M2Dgg3b
	Sb4DiZUU5aaZmAcubHFMpCrO/OT3Y7HgeB4iW7dmA4AQNz+QBnPm5TleuX4AOaKTBkG0+qwnepS
	A3SZOnC0zzBVs1jOlGlflsvQPNnak6CoQWZjVQ769HGyWzhQeYMLQUU/jKqQMRC22+cvP1J7d2s
	qMfAPCuM4/UjjNWT5K9Xxx0t+objHPxC92Vkt05Q==
X-Gm-Gg: ATEYQzxTG8Plywoy4384wKvBUche3Dg39bz9EKjp3zjANOmqSL7Um0IQLwCAggJMFzc
	lLsdAy+YLvI6+vaW5IECgB4gZGuvtYhHka4qWhQ/hAtCjYsmt0lVPkyqZbt1pMvbK2oKcD1YPqh
	q7TEp4hNN4IjOkL9WTGc5gWKmLKLgDY02j2BC7xehQtKDlyNUB3p2KEgiYu/rEbFvds+ieO2wPK
	DEAJYH1
X-Received: by 2002:a05:690c:4d8a:b0:794:e72a:f664 with SMTP id 00721157ae682-7986ff6368dmr23925647b3.60.1772059391036;
        Wed, 25 Feb 2026 14:43:11 -0800 (PST)
X-Received: by 2002:a05:690c:4d8a:b0:794:e72a:f664 with SMTP id
 00721157ae682-7986ff6368dmr23925517b3.60.1772059390662; Wed, 25 Feb 2026
 14:43:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260218-blk-dontcache-v1-1-fad6675ef71f@columbia.edu> <35866783-2312-4e31-904d-3746510eaf56@kernel.dk>
In-Reply-To: <35866783-2312-4e31-904d-3746510eaf56@kernel.dk>
From: Tal Zussman <tz2294@columbia.edu>
Date: Wed, 25 Feb 2026 17:42:59 -0500
X-Gm-Features: AaiRm51munUdTrnZZ7c7FkAWOz4juVf_xR9vg2o7Xlz46s_YpnQLMylaXhWKvd8
Message-ID: <CAKha_so5z7S6vD-betDLr=GREewxnWxeK9qawhZq8yKt=TD2XA@mail.gmail.com>
Subject: Re: [PATCH RFC] block: enable RWF_DONTCACHE for block devices
To: Jens Axboe <axboe@kernel.dk>
Cc: "Tigran A. Aivazian" <aivazian.tigran@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Namjae Jeon <linkinjeon@kernel.org>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        Yuezhang Mo <yuezhang.mo@sony.com>, Dave Kleikamp <shaggy@kernel.org>,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>,
        Viacheslav Dubeyko <slava@dubeyko.com>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Bob Copeland <me@bobcopeland.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, jfs-discussion@lists.sourceforge.net,
        linux-nilfs@vger.kernel.org, ntfs3@lists.linux.dev,
        linux-karma-devel@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: uQF-U9B43GeYFPrsmKOEMZ65cg4Piq4M
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI1MDIxNyBTYWx0ZWRfX45lpp0m1c8J3
 NfIRgP3flwc9uuBKf+HeLvd/+iqPY8f6FKAFkUhm1a9x0RSteCq2Ie/B+iVLNkURNffwP+asC3R
 tM56bGqOmVy4jKr/NsTtXUxdXmyTQjTE2c866XfPfdBMrkN1aCFM7OmQBSzaxeCRocKFP2a7Pb9
 2OEy1rWVNH83rMhgHxXQPIvGf9Fuw/0pKwIJKJbEopblZBazJFXPs66xhWebIb8juFLvr59RjbG
 bmwjCgnAa5euhuJnWTvR8WdiL6QZVJhNQcLy9VtjYMMaEnRFPUKqp5ltMC0uKI0+s1IP70mmxse
 fcy7LhskoHumnzT70dFNMuUshTBYfiC2is2mkgdIOiPhIx3OX1C3BhJbfv6ZxxmB3maJe2Yl1Y8
 /ti/bzzylgv+moJ97/Rs64+jjiNV9PwUAOdP3yeUzf8zLdsg0l9JDyRrbFYn0n/MGTK8XMPKE+Q
 Hps6Z+HtoPP3oE85alw==
X-Authority-Analysis: v=2.4 cv=FqMIPmrq c=1 sm=1 tr=0 ts=699f7b00 cx=c_pps
 a=g1v0Z557R90hA0UpD/5Yag==:117 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10
 a=x7bEGLp0ZPQA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22
 a=JR4YdQiviy7OQf72WyZ1:22 a=VwQbUJbxAAAA:8 a=VNoZ5ujv9kIkDPz7VAoA:9
 a=QEXdDO2ut3YA:10 a=MFSWADHSvvjO3QEy5MdX:22
X-Proofpoint-ORIG-GUID: uQF-U9B43GeYFPrsmKOEMZ65cg4Piq4M
X-Proofpoint-Virus-Version: vendor=nai engine=6800 definitions=11712
 signatures=596818
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 malwarescore=0 adultscore=0 impostorscore=10
 spamscore=0 bulkscore=10 lowpriorityscore=10 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602250217
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[columbia.edu,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[columbia.edu:s=pps01];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-78410-lists,linux-fsdevel=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,zeniv.linux.org.uk,kernel.org,suse.cz,samsung.com,sony.com,dubeyko.com,paragon-software.com,bobcopeland.com,vger.kernel.org,lists.sourceforge.net,lists.linux.dev];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tz2294@columbia.edu,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[columbia.edu:+];
	NEURAL_HAM(-0.00)[-0.992];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[columbia.edu:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C28C619E694
X-Rspamd-Action: no action

On Thu, Feb 19, 2026 at 10:24=E2=80=AFAM Jens Axboe <axboe@kernel.dk> wrote=
:
> On 2/18/26 2:13 PM, Tal Zussman wrote:
> > Block device buffered reads and writes already pass through
> > filemap_read() and iomap_file_buffered_write() respectively, both of
> > which handle IOCB_DONTCACHE. Enable RWF_DONTCACHE for block device file=
s
> > by setting FOP_DONTCACHE in def_blk_fops.
> >
> > For CONFIG_BUFFER_HEAD paths, thread the kiocb through
> > block_write_begin() so that buffer_head-based I/O can use DONTCACHE
> > behavior as well. Callers without a kiocb context (e.g. nilfs2 recovery=
)
> > pass NULL, which preserves the existing behavior.
> >
> > This support is useful for databases that operate on raw block devices,
> > among other userspace applications.
>
> OOO right now so I'll take a real look when I'm back, but when I
> originally did this work, it's not the issue side that's the issue. It's
> the pruning done from completion context, and you need to ensure that's
> sane context for that (non-irq).

Thanks for taking a look! That was very helpful feedback.
I sent out a v2 hopefully addressing that here:
https://lore.kernel.org/lkml/20260225-blk-dontcache-v2-0-70e7ac4f7108@colum=
bia.edu/

> --
> Jens Axboe

