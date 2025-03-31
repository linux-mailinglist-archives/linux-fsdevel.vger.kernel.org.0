Return-Path: <linux-fsdevel+bounces-45317-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7194A76120
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Mar 2025 10:15:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66B463A5F52
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Mar 2025 08:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8AD61D90C8;
	Mon, 31 Mar 2025 08:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="rn6gP9Tr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AFA0157A5A;
	Mon, 31 Mar 2025 08:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743408919; cv=none; b=eL/ug6rFNneyuLbXx29QJZ0kkFA0927ziRgf2+glVzFRtrk0wyLsVe/2da9LFlVUV4toyLHcnaf4WBEXotZfLTsdG0PhW2Of4s20QamZmPlDv4MTaN6WNKFAQOFWe6RfAQ/eNIxWw4x1UmETsUZvY4iETtnQCSmcVS+fZV751qY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743408919; c=relaxed/simple;
	bh=/K1LqsVggHmL0UhIvJIi4z7UtHYa7X4m1Mt1UAfv840=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=ijFZDtLLWLE2/hbZkTR3J8vJBVZSH2T1cEH73LpTT7s1A9nKTiwdqpEa/2sJ2iJ8v6aULzPKg2pPVFoeolTsnwtpwzcvYYQnDPpAiAnHBCKCYfLThRta06bnZExhmtrdJFJ4cemX2jOZZ2OiArC6zEEfOalZwjxNFBZjA1/4u/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=rn6gP9Tr; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1743408914; x=1744013714; i=quwenruo.btrfs@gmx.com;
	bh=6+9wgwyWz1ODyntJIKBnB7YG1IaQT7gJbMSQb5t6zjc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:From:Subject:
	 Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=rn6gP9Tray5TjP+E67J2mSKMkVfYYt+GRk5uMfa4EHdCRZdew1Qa+pehbSdrw5LQ
	 x0LJssO0r30FUqtvWT9vRmYgAtph9jKtZ1E8TRRqnnzj2xN18gM+rXKCAZGyLrecf
	 nfN0IPtvjkr068lqqxVr8IRqLb5ylbeuIcF2HAHT3cJXYX6nB0UToqfn+iZJZMtKR
	 SCDu7sq5tNRXMr3fhq6R78nlAhrSl/3qi4LKtpUOqBrjNDTfKxMkmqC7DsNGREh9+
	 Gea1FToDFLCrmEHyndwzdWrctYj8sQXPGEbgul7uzEpLPIoQ8oAzKT3BaidAqrBs9
	 0/ckWM5nGCX8RB6pVQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M5wPb-1u15yL0c6F-002zPq; Mon, 31
 Mar 2025 10:15:14 +0200
Message-ID: <17517804-1c6b-4b96-a608-8c3d80e5f6dd@gmx.com>
Date: Mon, 31 Mar 2025 18:45:10 +1030
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Linux Memory Management List <linux-mm@kvack.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 linux-fsdevel@vger.kernel.org, linux-btrfs <linux-btrfs@vger.kernel.org>
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNIlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT7CwJQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCZxF1YAUJEP5a
 sQAKCRDCPZHzoSX+qF+mB/9gXu9C3BV0omDZBDWevJHxpWpOwQ8DxZEbk9b9LcrQlWdhFhyn
 xi+l5lRziV9ZGyYXp7N35a9t7GQJndMCFUWYoEa+1NCuxDs6bslfrCaGEGG/+wd6oIPb85xo
 naxnQ+SQtYLUFbU77WkUPaaIU8hH2BAfn9ZSDX9lIxheQE8ZYGGmo4wYpnN7/hSXALD7+oun
 tZljjGNT1o+/B8WVZtw/YZuCuHgZeaFdhcV2jsz7+iGb+LsqzHuznrXqbyUQgQT9kn8ZYFNW
 7tf+LNxXuwedzRag4fxtR+5GVvJ41Oh/eygp8VqiMAtnFYaSlb9sjia1Mh+m+OBFeuXjgGlG
 VvQFzsBNBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAHCwHwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCZxF1gQUJEP5a0gAK
 CRDCPZHzoSX+qHGpB/kB8A7M7KGL5qzat+jBRoLwB0Y3Zax0QWuANVdZM3eJDlKJKJ4HKzjo
 B2Pcn4JXL2apSan2uJftaMbNQbwotvabLXkE7cPpnppnBq7iovmBw++/d8zQjLQLWInQ5kNq
 Vmi36kmq8o5c0f97QVjMryHlmSlEZ2Wwc1kURAe4lsRG2dNeAd4CAqmTw0cMIrR6R/Dpt3ma
 +8oGXJOmwWuDFKNV4G2XLKcghqrtcRf2zAGNogg3KulCykHHripG3kPKsb7fYVcSQtlt5R6v
 HZStaZBzw4PcDiaAF3pPDBd+0fIKS6BlpeNRSFG94RYrt84Qw77JWDOAZsyNfEIEE0J6LSR/
Subject: Proper way to copy de-compressed data into a bio, in folio style?
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Pa4eZ9t2BG9WOipM89ch+BIP1XwXRZchgff3EFxuT5AXR4Okz5q
 jJFfpZO1Jx92mLwuXcbayJXYbzeBthY2ITTzDFwpJAXZ8mHdbt9ULRdhbaU+gUcUvz2rb8A
 MimQ6d+dZ66eE7Lt6puoXE7i0LPJU8GcYoUSjA2bK63RaCo4Va9KD7uo/ORs+4mRn+CdTDO
 B7PH3rU65lNdEvYhmCAuA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:3VKqjzBD2Qw=;v70ybC2+N2w66XEpL5vQYf0gqu9
 agtAhwOgsibrjNR6MjyLDxxbu31pLTIQC5Mza+hmRTPk199PseFSxZ1/HMKyP5C08C9cgGHk2
 5joFU8ohOPnqR9T8BF6SIh9WyclM3Uh8TRdA25JcaEl4V6fpbNGA73/zHQwC8VqK/C5Un/slC
 ARmZiKmlAfnwG0eMNR14pgsWPnv0jQVSLBb2CusvJAImXwaf1Zy+aWI9im94HLDspu/tWsW2K
 pbYr4210lee3VdHRDh55/bLRwb5Ek9EbUsDqV0vf/2clphLKM6TbEb3FfprK9ZIK0C1OzRKjj
 korKmp8PNz3P1UglynGWk9NjaibiBnNXxo9Lqz+C+H7gaxKJoL0CSgc98Qj7DxjGY1vvVqtEW
 wzeeTym0kJYtpvQ6ojj+uJMadokPWP6H7i6/6PnBKxXaIFzRG/EmGpBQc0eNi3x9flWelC+Al
 lVyokOjOHgUvMOZNKQVQO3EmaWQHOhQN3ZTYuSpqovJixVo0N+CI7/SwHxEKcSphHyu2PqQnW
 eTkcAOCgKv2oPTedSNmtPi/dq2gK0qbCRyLjJeL1fYd9FF7zLFSQ9pkb9nNWzu2QTmxlv1G+o
 3jt7RsUkVSPgq1bdXUO+A5y5vA0TDvqCrNy5609Pj29M/KxU35NiiMQ19484dQBTNTAKIOyds
 Nic1GQ00+E9crER3fKIoExEqgXLXrVHlh9G0mYns2ZLPF38Rggn9CHDUQH9zF0+GNnLZxjzwT
 3Tp37wvq0KAHf6k9fe0OFoq+qqC5jAtnqoS2Kaa7p2bGaTs+YmNkMcj2GDaGSqCqQ4u9sESzy
 w4ySrWo2w+KvkJ/jSnm2BbvVwfPaLc3d+bVyN1dRFbJlZQMMlx/ehVGqRscep4++5fI85Mx87
 vmDTbToj1faqrnL82m264aVZDZ0wKaF+aEwtvONB+ZPjyu/tj+zz20jHoktuzC5nXYh7eqzzO
 YYPNIFp3dk5AqElYB1PaAEeLJcXYHIyqvBR9DWfXdCvtr9ojwumTVSCy2USjnJnCvYnnXUXkQ
 vUQnO6qbIDSrb+IayO7ChgGXZALLoqarZH3j5wMRMLWsSiuGP8/jue5+6sQHL1liYPwyhJ3zr
 3bSYKQwEbfD07xXyirnlBh4UUdQhJT+wCZhRn2ttrw7a0B0uJcmmLn0ydeDsUQcvrAkz5nLkr
 BoKVSDVHSXafD2al9EU2vrEsduDDFdUGU838fIY/Ub7BPrd2rBJeqmbs0u0PaqiEAy0j//yWm
 6H90CfjNhW7Hh3EnslGmUpIX0g1sQdLJ4kbJgxPORC8yrz72ge7S1qpxHLzgvlqivLCH+VhBF
 mGlj3Rsa9up2N7czkgPBYOuWaLt10ub0TnBoxxqSJLsUXt4DdiMhW/FI0i90RdC/q/Oy2gRk0
 Ca5UVdz55weef3osq9UxX6bwqdm3k0IemziT3AdNLS5ZvDgqh9C24cUts7brY/G081+Z56s8Y
 qLnAsxA==

Hi,

The seemingly easy question has some very interesting extra requirements:

1. The bio contains contig file map folios
    The folios may be large.
    So page_offset() on bv_page (using single-page bvec) is no longer
    reliable, one has to call page_pgoff() instead.

2. The data may not cover the bio range
    So we need some range comparison and skip if the data range doesn't
    cover the bio range.

3. The bio may have been advanced
    E.g. previous de-compressed range has been copied, but the remaining
    part still needs to be fulfilled.

    And we need to use the bv_page's file offset to calculate the real
    beginning of the range to copy.

The current btrfs code is doing single page bvec iteration, and handling
point 2 and 3 well.
(btrfs_decompress_buf2page() in fs/btrfs/compression.c)

Point 1 was not causing problem until the incoming large data folio
support, and can be easily fixed with page_pgoff() convertion.


But since we're here, I'm also wondering can we do it better with a
folio or multi-page bvec way?

The current folio bio iteration helper can only start from the beginning
of a bio (bio_for_each_folio_all() and bio_first_folio()), thus it's not
a good fit for point 3.

On the other hand, I'm having some internal code to convert a bio_vec
into a folio and offset inside the folio already.
Thus I'm wondering can we provide something like bio_for_each_folio()?
Or is it too niche that only certain fs can benefit from?

Thanks,
Qu

