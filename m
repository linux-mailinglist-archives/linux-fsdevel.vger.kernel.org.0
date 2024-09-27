Return-Path: <linux-fsdevel+bounces-30212-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B1C09987CF6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Sep 2024 04:18:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01262B21ACE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Sep 2024 02:18:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 375CB16C451;
	Fri, 27 Sep 2024 02:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Ow5/E/yV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 437322AE84;
	Fri, 27 Sep 2024 02:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727403494; cv=none; b=cZ5G7nLIqV216INBjpE86FFbonqnIge2Kcgnlp34yZph8K9MRel+LqSJ0514/xQAPoreMGGts68LooPEBJ+L6n8K0hvPvKQkWHVRIwbTod6zqwSr1ovc1cjFMati9sxt4aeCfL5ysqCtN4RioeIdy30g807+6epvILmLKjQlyig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727403494; c=relaxed/simple;
	bh=Q8XmPJ4iAfsRaKmreIHD8vW7v2ivqKMnyBTMhAdDPfA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Uj4+XHTm4bsYT72bAD9oftFkLvOnwRGaIQkBv0ypRle5vRzdVP46KEiSt6iJ1ggl8JI7jPRaoJIDHrmihBcRMabOUX30EWfaRE5z2Y/UskL8eD6x6LEmu3VR68vCuDarjLpwo2psfGkHK96Q55gHR87M76Jchkvrtdn2Y3IX0Kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Ow5/E/yV; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1727403489; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=/r/tjBNR+IWRjvp0HptBoGnx5lgEQTTKVUb3akceKm8=;
	b=Ow5/E/yVKmhtIML0B8j1g1GcM0yBq5hqnUT1JSsGDf5eiLNarO6qjvxXnYNMXsPoPc5Rrq3KqCC1QkC8d5xdqNiAok/s/ncj5DbqvjSzsmaNY2Cfy7dEn4+K2Cyn+vS+G3fqYWUBfaGG7aOgf/Mxf3hog9+5oEt35rpda4WCOsE=
Received: from 30.244.152.118(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WFokCVX_1727403487)
          by smtp.aliyun-inc.com;
          Fri, 27 Sep 2024 10:18:08 +0800
Message-ID: <7739346c-b98e-4359-b0d2-44cd73ae55f0@linux.alibaba.com>
Date: Fri, 27 Sep 2024 10:18:06 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 03/24] erofs: add Errno in Rust
To: Ariel Miculas <amiculas@cisco.com>
Cc: Benno Lossin <benno.lossin@proton.me>, rust-for-linux@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 LKML <linux-kernel@vger.kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Al Viro <viro@zeniv.linux.org.uk>, Gary Guo <gary@garyguo.net>,
 linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org
References: <80cd0899-f14c-42f4-a0aa-3b8fa3717443@linux.alibaba.com>
 <20240925214518.fvig2n6cop3sliqy@amiculas-l-PF3FCGJH>
 <be7a42b2-ae52-4d51-9b0c-ed0304db3bdf@linux.alibaba.com>
 <0ca4a948-589a-4e2c-9269-827efb3fb9ef@linux.alibaba.com>
 <20240926081007.6amk4xfuo6l4jhsc@amiculas-l-PF3FCGJH>
 <54bf7cc6-a62a-44e9-9ff0-ca2e334d364f@linux.alibaba.com>
 <20240926095140.fej2mys5dee4aar2@amiculas-l-PF3FCGJH>
 <5f5e006b-d13b-45a5-835d-57a64d450a1a@linux.alibaba.com>
 <20240926110151.52cuuidfpjtgwnjd@amiculas-l-PF3FCGJH>
 <ec17a30e-c63a-4615-8784-69aef2bb2bae@linux.alibaba.com>
 <20240926124959.n7i33p4fonp2op27@amiculas-l-PF3FCGJH>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20240926124959.n7i33p4fonp2op27@amiculas-l-PF3FCGJH>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/9/26 20:50, Ariel Miculas wrote:
> On 24/09/26 07:23, Gao Xiang wrote:

...

>>>
>>> It might be a fair comparison, but that's not how container images are
>>> distributed. You're trying to argue that I should just use EROFS and I'm
>>
>> First, OCI layer is just distributed like what I said.
>>
>> For example, I could introduce some common blobs to keep
>> chunks as chunk dictionary.   And then the each image
>> will be just some index, and all data will be
>> deduplicated.  That is also what Nydus works.
> 
> I don't really follow what Nydus does. Here [1] it says they're using
> fixed size chunks of 1 MB. Where is the CDC step exactly?

Dragonfly Nydus uses fixed-size chunks of 1MiB by default with
limited external blobs as chunk dictionaries.  And ComposeFS
uses per-file blobs.

Currently, Both are all EROFS users using different EROFS
features.  EROFS itself supports fixed-size chunks (unencoded),
variable-sized extents (encoded, CDC optional) and limited
external blobs.

Honestly, for your testload (10 versions of ubuntu:jammy), I
don't think CDC made a significant difference in the final
result compared to per-file blobs likewise.  Because most of
the files in these images are identical, I think there are
only binary differences due to CVE fixes or similar issues.
Maybe delta compression could do more help, but I never try
this.  So as I asked in [1], does ComposeFS already meet your
requirement?

Again, EROFS could keep every different extent (or each chunk,
whatever) as a seperate file with minor update, it's a trivial
stuff for some userspace archive system, but IMO it's
controversal for an in-tree kernel filesystem.

[1] https://github.com/project-machine/puzzlefs/issues/114#issuecomment-2369971291

Thanks,
Gao Xiang

