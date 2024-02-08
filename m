Return-Path: <linux-fsdevel+bounces-10854-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DA2784EB4B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 23:09:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4C501F24A17
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 22:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6FA44F5EA;
	Thu,  8 Feb 2024 22:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="HHhUTNHw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC474F611;
	Thu,  8 Feb 2024 22:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707430145; cv=none; b=XAHI3DQzTrVnFlPLeyqgEEg6J1pSIzrzZjbnovRCHEy7o9o0wvRtSQh/EtepGJe8RyerV7yuYK530kWMysN/rhGEFs4Ay622DO/jkok9jc2/+huQLLClAmfQxzesI2kmAASRGZr3LcvbzSRoJMrqdjpgMxkuZG433A4Db1sH89c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707430145; c=relaxed/simple;
	bh=kv1G4rauL0V/ovkZqlyZV/zCcYxt4nw+B1HaObpBsBg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IpCfYU8qr6REcU5myVaBq+W0HcUEXgOreO1cpfpo5BKlUJeYyTUnIYO3W2Hc/mOIoZceM+67fgo21WxcOydfdVYVWaCaR26sauGJcFbC6MYbRnAZfzolPgYLdMmmKZaWzUSBxtzOHyJqbQHom+tMoNQXnpqOoDlT9tBPHDSbX9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=HHhUTNHw; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1707430142;
	bh=kv1G4rauL0V/ovkZqlyZV/zCcYxt4nw+B1HaObpBsBg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=HHhUTNHwp9t4GjQ6d/I8PbBxZ5Ysc2qEEV48aH3lVN1VoGAv71YymOYZyjOFWPGMd
	 4SWLdtwlCkB5t2w+1ELwTPFHxTxxuha5Qxjd5h8qyTccFlmpSB/a7d1RmAW7d+vZE2
	 q/a5IoQJ3CEfwEgxipUsLOBDKGi1bpWHfP47Vw94wLHOsjm2DoP3neVCVsFgrAwah4
	 vvA8ewXKzgrCnLgx4wejOxSONJJHYgBAy6pqeYLy32KpZTKnoJjwCfdEknNRXwE2+3
	 5eXO3k9W9vD4setJ/qKQQVlQ/I+pavp1S/Pu537Q1V3SZrJwiKFTHXnFYFBq8AR41q
	 zWLNcSgcR+RYg==
Received: from [172.16.0.134] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4TWB322PvSzY2X;
	Thu,  8 Feb 2024 17:09:02 -0500 (EST)
Message-ID: <72457cf2-c8c3-4c3e-b5d7-c39f55669812@efficios.com>
Date: Thu, 8 Feb 2024 17:09:08 -0500
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 05/12] virtio: Treat alloc_dax() -EOPNOTSUPP failure as
 non-fatal
Content-Language: en-US
To: Dan Williams <dan.j.williams@intel.com>, Arnd Bergmann <arnd@arndb.de>,
 Dave Chinner <david@fromorbit.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Matthew Wilcox <willy@infradead.org>, Russell King <linux@armlinux.org.uk>,
 linux-arch@vger.kernel.org, linux-cxl@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-xfs@vger.kernel.org, dm-devel@lists.linux.dev, nvdimm@lists.linux.dev,
 linux-s390@vger.kernel.org, Alasdair Kergon <agk@redhat.com>,
 Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>
References: <20240208184913.484340-1-mathieu.desnoyers@efficios.com>
 <20240208184913.484340-6-mathieu.desnoyers@efficios.com>
 <65c549aa701cb_afa42943d@dwillia2-xfh.jf.intel.com.notmuch>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <65c549aa701cb_afa42943d@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-02-08 16:37, Dan Williams wrote:
[...]
>> +DEFINE_FREE(cleanup_dax, struct dax_dev *, if (!IS_ERR_OR_NULL(_T)) virtio_fs_cleanup_dax(_T))
> 
> This IS_ERR_OR_NULL is ok because dax_dev is initialized to NULL, but
> maybe this could just be IS_ERR() and then initialize @dax_dev to
> ERR_PTR(-EOPNOTSUPP)?

Done.

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


