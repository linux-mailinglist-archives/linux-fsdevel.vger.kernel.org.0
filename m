Return-Path: <linux-fsdevel+bounces-58176-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8AEEB2AAC5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Aug 2025 16:36:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F7BD5662AF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Aug 2025 14:23:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95CED34AAF0;
	Mon, 18 Aug 2025 14:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="jCeY6Wzi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7611433EB0C;
	Mon, 18 Aug 2025 14:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755526410; cv=none; b=g9W4l7HMt/rCru1kcqbl6p539Y1u8RbPSZ8HS5bn+C67FDnaLDWsqav5arJfOw0FKjG9HPp/A5emN+fRdz5/HtdAAJ3PqfPkPu4Z0hxB5n8mosIWFFn0EG9FoDIYTT00nZR79/NCrMhN2q77qe9w/p30uLckxuoUhB2GyQ6cJ+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755526410; c=relaxed/simple;
	bh=slTdFjNbMBJz6AMZSXjoyF0+/Fsphhx7R5Y/Vv0FOlc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DZbYwMTnIEEOxpwEs8O3bG8VYlZwpzbmNnG75uZPjLfuwQ0BlHJGN+rsIYBYVQ73eYl3/TKgkCHmGw/DwbOz5YyYbxYKPnrHLsfKOSvU2BNcQ5kcieKI7PY0zgAQD96kM6CCdT7qRpb4xTXo3Wp7Wnvkf/6icXFtZoLlJQk/vdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=jCeY6Wzi; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=o6GRpL/mAObuPoCyKrPNr7o0vvavbQGubBgwRvw5whs=; b=jCeY6WziSIP5OzbPpQ7BwxFkWI
	TKgSH3AgHGetyB77jm4DRRsJBtc867tLEmL2aTlz8od7PAZgleB6YyjuWo+bilXaStiEKZY5+ewAx
	YKU8ITWZZvRl1scxXNstp7ZGRDrxMRntirhASNddc6AWDjBPKwQYfNwswnNxkpQ6B6r/gTIbkZBmZ
	l5FP4120vjmDhoH3Ee8YQu0prouKCVBiR8ReIeZjFQiXqbG3tNJru/h4OQN7qY8Xr9W5u4dt+lt2p
	B8w6qYo37rDzReDWQIpgkD4iZuyk0jw+lCalLUWlnATVT6ihydL5bW1EE5BmWK1xMqXffVIzFIxfW
	7Fi7FhKw==;
Received: from [152.250.7.37] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1uo0be-00Fs6o-Eb; Mon, 18 Aug 2025 16:13:02 +0200
Message-ID: <4b225908-f788-413b-ba07-57a0d6012145@igalia.com>
Date: Mon, 18 Aug 2025 11:12:58 -0300
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iomap: use largest_zero_folio() in iomap_dio_zero()
To: Christoph Hellwig <hch@infradead.org>,
 Christian Brauner <brauner@kernel.org>
Cc: "Darrick J . Wong" <djwong@kernel.org>,
 "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 mcgrof@kernel.org, gost.dev@samsung.com, linux-xfs@vger.kernel.org,
 Pankaj Raghav <p.raghav@samsung.com>
References: <20250814142137.45469-1-kernel@pankajraghav.com>
 <20250815-gauner-brokkoli-1855864a9dff@brauner>
 <aKKu7jN6HrcXt3WC@infradead.org>
Content-Language: en-US
From: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
In-Reply-To: <aKKu7jN6HrcXt3WC@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Em 18/08/2025 01:41, Christoph Hellwig escreveu:
> On Fri, Aug 15, 2025 at 04:02:58PM +0200, Christian Brauner wrote:
>> On Thu, 14 Aug 2025 16:21:37 +0200, Pankaj Raghav (Samsung) wrote:
>>> iomap_dio_zero() uses a custom allocated memory of zeroes for padding
>>> zeroes. This was a temporary solution until there was a way to request a
>>> zero folio that was greater than the PAGE_SIZE.
>>>
>>> Use largest_zero_folio() function instead of using the custom allocated
>>> memory of zeroes. There is no guarantee from largest_zero_folio()
>>> function that it will always return a PMD sized folio. Adapt the code so
>>> that it can also work if largest_zero_folio() returns a ZERO_PAGE.
>>>
>>> [...]
>>
>> Applied to the vfs-6.18.iomap branch of the vfs/vfs.git tree.
>> Patches in the vfs-6.18.iomap branch should appear in linux-next soon.
> 
> Hmm, AFAIK largest_zero_folio just showed up in mm.git a few days ago.
> Wouldn't it be better to queue up this change there?
> 
> 

Indeed, compiling vfs/vfs.all as of today fails with:

fs/iomap/direct-io.c:281:36: error: implicit declaration of function 
‘largest_zero_folio’; did you mean ‘is_zero_folio’? 
[-Wimplicit-function-declaration]

Reverting "iomap: use largest_zero_folio() in iomap_dio_zero()" fixes 
the compilation.


