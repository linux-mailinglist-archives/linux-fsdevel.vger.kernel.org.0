Return-Path: <linux-fsdevel+bounces-21066-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BBB258FD2EF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jun 2024 18:30:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7035F1F22C0B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jun 2024 16:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A42214594D;
	Wed,  5 Jun 2024 16:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sandeen.net header.i=@sandeen.net header.b="ZVTDVofG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sandeen.net (sandeen.net [63.231.237.45])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8709E4642D
	for <linux-fsdevel@vger.kernel.org>; Wed,  5 Jun 2024 16:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.231.237.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717605030; cv=none; b=WQC8ffbLDVPswOKm5CG3q5xuslyHJR6Atrjg9hMLgZMzt5p603rj8TCSoOejVHGghSKsEumxRJBaIeUBjCG1xzqEh+YbD+Jtl3EC3d1YwdL9EwBgegia0dwkCs+4LCwFfWqYsofCyG242sNWbwMM5FhQ+/pm+FReoHMD/rUNVqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717605030; c=relaxed/simple;
	bh=poXdErzsadQbTxHGxQ1BJGATyqzgb3e9WNXXPmygZtI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sFACY6s/LsblMuzU/0VRD4GKb62c6KG2aTO8XJHvXMvZ1Vg9TpNBwd3pPaopo79h5rx5go/uU4EjaJWMiUFIgZlFeO085eRwRGzrtfy5P8Z8tKOukqNOCrsyyG3w5bMhCCOFckUyIxIem1enKeB1ayEA6ByBA+r5eZq1FifZYMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sandeen.net; spf=pass smtp.mailfrom=sandeen.net; dkim=pass (2048-bit key) header.d=sandeen.net header.i=@sandeen.net header.b=ZVTDVofG; arc=none smtp.client-ip=63.231.237.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sandeen.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sandeen.net
Received: from [10.0.0.71] (usg [10.0.0.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by sandeen.net (Postfix) with ESMTPSA id 08D4311671;
	Wed,  5 Jun 2024 11:30:20 -0500 (CDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sandeen.net 08D4311671
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sandeen.net;
	s=default; t=1717605021;
	bh=v4b0Yfwhb5Bz8tOnnNZ3n2UifLtoDhazko+6+5dr87A=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ZVTDVofGRWqKOd6n45zdlnW2HRGbyMiDCTB4VKGLRQvaIoearZ1xZvRSuOhu5YJju
	 bszKII/9rtVmEcnXlFrqeZ88vqvY+Gzcz+rKvdNN+TZbPRroHROIN2WBeNHuZoUoiY
	 nEqgveYt1mD+Rfd01mK93QG4DXTBy2Rg3NuenGEuUDq9UhRVJwieNujPxwNmHeGCxb
	 tfaYazgstGfOJg09OVQuHpfJyYLYYUCs3nd2f87g7zcHaYvvc1W64c3RiDTZw2dlCj
	 trhoVmYRGKjGru4F+B9ss8dAceaiTHqwmckNSFthan/hg6d/9Yuu1BK8DdB1C0r6NQ
	 3TO76WbuJWo0Q==
Message-ID: <2508590b-54db-4f52-ac55-e5014fffabb9@sandeen.net>
Date: Wed, 5 Jun 2024 11:30:20 -0500
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] fs_parse: add uid & gid option parsing helpers
To: Christian Brauner <brauner@kernel.org>, Eric Sandeen <sandeen@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, David Howells <dhowells@redhat.com>,
 Bill O'Donnell <billodo@redhat.com>
References: <8b06d4d4-3f99-4c16-9489-c6cc549a3daf@redhat.com>
 <20240605-moralisieren-nahegehen-90101b576679@brauner>
Content-Language: en-US
From: Eric Sandeen <sandeen@sandeen.net>
In-Reply-To: <20240605-moralisieren-nahegehen-90101b576679@brauner>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/5/24 9:35 AM, Christian Brauner wrote:
> On Tue, Jun 04, 2024 at 12:17:39PM -0500, Eric Sandeen wrote:
>> Multiple filesystems take uid and gid as options, and the code to
>> create the ID from an integer and validate it is standard boilerplate
>> that can be moved into common parsing helper functions, so do that for
>> consistency and less cut&paste.
>>
>> This also helps avoid the buggy pattern noted by Seth Jenkins at
>> https://lore.kernel.org/lkml/CALxfFW4BXhEwxR0Q5LSkg-8Vb4r2MONKCcUCVioehXQKr35eHg@mail.gmail.com/
>> because uid/gid parsing will fail before any assignment in most
>> filesystems.
>>
>> With this in place, filesystem parsing is simplified, as in
>> the patch at
>> https://git.kernel.org/pub/scm/linux/kernel/git/sandeen/linux.git/commit/?h=mount-api-uid-helper&id=480d0d3c6699abfbb174b1bf2ab2bbeeec4fe911
>>
>> Note that FS_USERNS_MOUNT filesystems still need to do additional
>> checking with k[ug]id_has_mapping(), I think.
>>
>> Thoughts? Is this useful / worthwhile? If so I can send a proper
>> 2-patch series ccing the dozen or so filesystems the 2nd patch will
>> touch. :)
>>
>> Signed-off-by: Eric Sandeen <sandeen@redhat.com>
>> ---
> 
> Seems worthwhile to me. Ideally you'd funnel through the fc->user_ns smh
> so we can do the k[ug]id_has_mapping() checks right in these parsing
> helpers.

Yep that bothered me too, but we don't have fc here and getting to it looks...
tricky. And on a sidebar with Al he seemed to not want that in here, though
I'm not quite sure why not.

(the reason we don't have fc in the parsers now is because of changes made to
support RBD in 7f5d38141e30)

Perhaps it's worth getting this far, and fight that battle another day?

Thanks,
-Eric



