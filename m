Return-Path: <linux-fsdevel+bounces-44685-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 31516A6B5D0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Mar 2025 09:12:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F70A1890F7B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Mar 2025 08:12:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E97BF1EF0B1;
	Fri, 21 Mar 2025 08:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="FabnZBuY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFE7717C210;
	Fri, 21 Mar 2025 08:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742544760; cv=none; b=M6M1QGOLISNa0nmLDAlKaBgodXG7Lvb8algVLTOe5/8YRueInEXezk04phutdr3ecjqYd64LBo/3mh8ZLMPxodH+QFamlveUgYy2cYYEE9Bp/C8lC9IHz75WrktxZ/0/dTlhIO8PSUhQmtJDpg5TNNctZmpGB3p/uvfXgW4Fu58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742544760; c=relaxed/simple;
	bh=wGfzEWPpygiK1wyV0x3JeeyT7tKy9VOPiDSFvpNIzAs=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=lpd4lnvIIH8K13vkAsVRdJA7Z/z1m4UMpH3qm69EQD7jk7MywCnW1cbDPqzSN07wjzv+/JaoE5s98oFTUX91+b8EFI4POdwfSy+WwkARfZyCllY3Xh4Vd5r41GMH+kJgryDLryBGNcxO4YtA6hjTjPoUIFtQYDVxBNGu+ifmE84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=FabnZBuY; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1742544751; x=1743149551; i=quwenruo.btrfs@gmx.com;
	bh=+ijUDGEw6Fvvl6L6SrQh/GH8G3Na7UQFyI4Vx8TYCH4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:From:Subject:
	 Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=FabnZBuYPpw+vQiCkRrASWdu5qioFUAhzoFS9w6/3WKXJA1ghcqyFJOo5usRqTTq
	 ahe4PEZyOhhfzcr8ScgLyoDatT2Uaw1B5D+DZSpvTaoAHZfOCdoNPZoFHsnh1DGa1
	 kj13vjYQ5wZzvVORhtyuirk/Mj9axCbDCotZqs/UL6Rpi8PQBeBwiS2LVHuVd+h9o
	 VdsQv27Dn6rWHxSGB4sxpdp0wFuy5wBTpLk1b2HNdcy0VYJHqNNeq0QlS0TmxSpTi
	 wruRhPFJamh5Q6Qcj6Sr8EJygR5EeT2bHyyX/IwlI2bnnlEhyZ7XBE1vbnJTbskWk
	 /O/OgClBK2rX1Lhjkw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M9Wyy-1tq1BR0sse-009FsO; Fri, 21
 Mar 2025 09:12:29 +0100
Message-ID: <1f7da968-4a4c-4d3e-8014-5c2e89d65faa@gmx.com>
Date: Fri, 21 Mar 2025 18:42:25 +1030
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 linux-xfs@vger.kernel.org, linux-btrfs <linux-btrfs@vger.kernel.org>,
 Christian Brauner <brauner@kernel.org>
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Iomap buffered write short copy handling (with full folio uptodate)
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
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:wMBm8PcAtXEO62IRgnlAgFed2UyQ34c5wROvD+U3mdEbELu1rT9
 k+ji0sTZHT4PzZVdG091NcRVYxROT7bt1GD++XoZ6c7T4/N2yASZG5Dqs6k2uu4U73j3Ghu
 OKkqIif8Sr/lOxHzDR+xBCfGbC5jtJ3nsT+gUsMJVI/LhGyP+1+xurxEZykCgj0ykHR7miP
 ZA9TVKv9+G3uatgVsNwTw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:9AcLx2fmiCM=;CuZoKZvrrzEqWu1sLHmgJlk15cU
 wFxc//+ILoXp+yEtArhoYFLuN+LsifBcFauEHeIttlEoATxqTFVxJ480EVh1ffa8MBfQ4o6G5
 CrW549OV0PNURpOqYhTu2lKjhMVQIAuzTztcOvLD6rWpXn9GfyUHlol6Cl+5v/9OCcxAWG6IJ
 0dVMDnYlAQ9QLq7H/e0tJTSTa8I0i2X2IkKtN8w/Ckshmk4OeSrh/0COUhx9wJLTdnC7lrQ0p
 Lbhq5YicMwODe6zDgd00GUk6mfraxSU3QsvonaF9FzDYvBT0m2c+oRdQLaHKwpjXxpyQ+Gm6q
 M8o+9zKMHN8r6LHv96600xwZhGocmkI05RojO2NmG1d8y0+vpRJTHN/L0hlscyzO+x1YrziOC
 eN6Ce3Ka/529Kd+peOPLrE62yipuBPsKYjxqaMke9vtmrR7BY2cocWKdKduHxQBsde6uEeCNT
 UM/8tKtCHHEIjhQw7YvYe+N/1a/pv20w//hUnoyZxONtPnNilFM5+DGABgzpIr7uM5TmB2ozo
 //P0yRqtx84WlCq5SlEifQZDEp/e/c78xEPzjKnULc4Z/ng/pRqbSEpq1tvyVSEkjGocCg8jD
 t7jIxhS2EpI3Tc+8Z+NkzVZCUivdcdbQSHkGFoKodH3j5yScFnLVRpDYYkSOnfI21oDTDWIWq
 oXgSUYbvjwUXww52ZSRBRtIqqm8k+qLLpAJsNCzcIzG7Bcoud19OdSZjs+wNgNZyMiIc33hnI
 7J3AzvLYSG+82y38o0tp2zxlBteNcN9cOPdUouk3fSDvm4X65pmiSiiP0xgiW9y23TPzKb4Hs
 oPtfcFgbT80R6AClHZSMccjv+0xd8LYFsmnf6rdN96yk9Gkz5u8TM9jgoPD0/ATn3/gT4sA7J
 7djBfrMXNvVstgNDX6dE69pOqBTgUCTNvd7wmc+QhBEk97zw9yKWY80aEGnv52odQ/4u0afSZ
 JqAU/JCGv0YRj3Okbvw0Aqs54SmZrvx/YFODGqBJlQYFC8mL//JLNx3syrM+Yl9HgLRUp7+3L
 L8yfpl6uu9P4F1lvogQrn/gkJaOlJ4y89F7B5Iqt1X97Wg+bLLIShrmXXLCQcRATDCaPlN4de
 r4/gfFjmlfPOJgetDuXKeFVJMYrPAP5aFB6RBeEkZmgP+P37h2ksOfsTiMlc0rSH8iyWfb8iG
 Yn+RJHiCYHIJ6LPQ2xlDxNQI9n8zNlUfop7xwzoz2l8u8gJWJp8W27DwFzgm8ax0vnVwcAF1D
 NaoTn2jjm6DV6PO8EnkZhiWSu7e7DdlTl6T3gZdHonXutR/gJTfcXzJp67n6EX7ygWTulR1Gz
 BsW2TvdszXZQVaMhv3q28UzHF+89doz8zpd8yAH/eIxGvrdwatJAWdNPrN5nhZ2jPST37h0bE
 qA4N6etWM9NMrG/GO0F8BLOhBx6IV4U2gPszRDrbf+USSd3qLtyAOf+jIud31wpl3lnKYchPB
 M0WSJxBQ46Mv+VRgarQkhILT1ZkE=

Hi,

I'm wondering if the current iomap short copy handler can handle the
following case correctly:

The fs block size is 4K, page size is 4K, the buffered write is into
file range [0, 4K), the fs is always doing data COW.

The folio at file offset 0 is already uptodate, and the folio size is
also 4K.

- ops->iomap_begin() got called for the range [0, 4K) from iomap_iter()
   The fs reserved space of one block of data, and some extra metadata
   space.

- copy_folio_from_iter_atomic() only copied 1K bytes

- iomap_write_end() returned true
   Since the folio is already uptodate, we can handle the short copy.
   The folio is marked dirty and uptodate.

- __iomap_put_folio() unlocked and put the folio

- Now a writeback was triggered for that folio at file offset 0
   The folio got properly written to disk.

   But remember we have only reserved one block of data space, and that
   reserved space is consumed by this writeback.

   What's worse is, the fs can even do a snapshot of that involved inode,
   so that the current copy of that 1K short-written block will not be
   freed.

- copy_folio_from_iter_atomic() copied the remaining 3K bytes
   All these happens inside the do {} while () loop of
   iomap_write_iter(), thus no iomap_begin() callback can be triggered to
   allocate extra space.

- __iomap_put_folio() unlocked and put the folio 0 again.

- Now a writeback got started for that folio at file offset 0 again
   This requires another free data block from the fs.

In that case, iomap_begin() only reserved one block of data.
But in the end, we wrote 2 blocks of data due to short copy.

I'm wondering what's the proper handling of short copy during buffered
write.

Is there any special locking I missed preventing the folio from being
written back halfway?
Or is it just too hard to trigger such case in the real world?

Thanks,
Qu

