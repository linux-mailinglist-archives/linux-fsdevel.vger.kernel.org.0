Return-Path: <linux-fsdevel+bounces-72005-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DCF5CDADF0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Dec 2025 01:00:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7AF96303E3DE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Dec 2025 00:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD37727713;
	Wed, 24 Dec 2025 00:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cs.ucla.edu header.i=@cs.ucla.edu header.b="K+c26Y5F"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.cs.ucla.edu (mail.cs.ucla.edu [131.179.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C0A2C11CA
	for <linux-fsdevel@vger.kernel.org>; Wed, 24 Dec 2025 00:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=131.179.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766534409; cv=none; b=e++CNPXmyGVYwFrmMTbxDl08ocugGyVhXfs1tHReas0ByCyDqu4d3TAUrS3ugE1VrNkRXyKEn3adnVjJA/UPnI7Thono7OeUB6eGOWExarPBUYgd1n/2JeQXAsjNpkutANK0KU8els1R5DnDY+nC5ZPssb8V50nQO/mzlzNLu+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766534409; c=relaxed/simple;
	bh=T8H17ErY2UxWS+/CB5yUOEGHlMqaIJQoGM+wz3401rQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kCY782HHTaVNCREGAGFix7j3oD9QRUtHNQe4zWtPoeXxvv1Lci1mvOjVomezISpGbd6dzDR47coftZsjfK9iDGzhnXfCRmnBmPpaEk4XfkJtfIsOuMVvHhRr1tsVt7WuZ6zkWwpAgzq/YyF7vu6uwPDt3Ahw85lpZgNoA1Z/s0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.ucla.edu; spf=pass smtp.mailfrom=cs.ucla.edu; dkim=pass (2048-bit key) header.d=cs.ucla.edu header.i=@cs.ucla.edu header.b=K+c26Y5F; arc=none smtp.client-ip=131.179.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.ucla.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.ucla.edu
Received: from localhost (localhost [127.0.0.1])
	by mail.cs.ucla.edu (Postfix) with ESMTP id 11E693C03E9ED;
	Tue, 23 Dec 2025 16:00:07 -0800 (PST)
Received: from mail.cs.ucla.edu ([127.0.0.1])
 by localhost (mail.cs.ucla.edu [127.0.0.1]) (amavis, port 10032) with ESMTP
 id cl-nGPGlD9me; Tue, 23 Dec 2025 16:00:07 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	by mail.cs.ucla.edu (Postfix) with ESMTP id DAEA13C03E9F4;
	Tue, 23 Dec 2025 16:00:06 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.cs.ucla.edu DAEA13C03E9F4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cs.ucla.edu;
	s=9D0B346E-2AEB-11ED-9476-E14B719DCE6C; t=1766534406;
	bh=XzUxjJss1m93snz+IKguTdLjbfmyCqXLGpJizRHmPPM=;
	h=Message-ID:Date:MIME-Version:To:From;
	b=K+c26Y5FLcPsNUS+q/8sQ3HnBxXrK7sRXdv979Xbtq7R5cXbCrmJkyCVdjtQf6rkL
	 aCTqJe111gptIW0zDUNvxjkOMfH0NoGNfqMOFPCqZ3ahY/39UW8lmGNBvZe0i8xzjF
	 QvgAlVh6Tu6I9ShoHBjZftHyVt1du9wEjiyJGm5cxGFNE+dhlfukF6KsQeE6Br+3Pl
	 ds3tCjSfAN7014c/Zsv0jiaqpMSEsuCnVdezrx1FuIKmM7OB8NmTNCUkVkh6nOvyIL
	 Nb22nvhLRXuqG7Hk0vWjx9LXumX/RIP4Z70vsHGgs524gJ4mhBb7UoFCE7efvGbkOm
	 qkbFbxM561bnA==
X-Virus-Scanned: amavis at mail.cs.ucla.edu
Received: from mail.cs.ucla.edu ([127.0.0.1])
 by localhost (mail.cs.ucla.edu [127.0.0.1]) (amavis, port 10026) with ESMTP
 id I25W-adrIkW2; Tue, 23 Dec 2025 16:00:06 -0800 (PST)
Received: from penguin.cs.ucla.edu (47-154-25-30.fdr01.snmn.ca.ip.frontiernet.net [47.154.25.30])
	by mail.cs.ucla.edu (Postfix) with ESMTPSA id B46793C03E9ED;
	Tue, 23 Dec 2025 16:00:06 -0800 (PST)
Message-ID: <d11040d8-287d-45f9-920c-5d9e25e380ab@cs.ucla.edu>
Date: Tue, 23 Dec 2025 16:00:06 -0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: cat: adjust the maximum data copied by copy_file_range
To: Matteo Croce <technoboy85@gmail.com>
Cc: Collin Funk <collin.funk1@gmail.com>, coreutils@gnu.org,
 =?UTF-8?Q?P=C3=A1draig_Brady?= <P@draigbrady.com>,
 linux-fsdevel@vger.kernel.org
References: <CAFnufp2ZD5u6pp84xtTcZKqQWtmtwN8n_d7-9UpqoUJUsEwwAA@mail.gmail.com>
 <87345fxayu.fsf@gmail.com> <8cd912f2-587b-45ff-a3aa-951272f1f538@cs.ucla.edu>
 <CAFnufp0zMe04Hh41-z6Yi8RTc0gZ7i74F6zRBDqOS5k9DZu2TQ@mail.gmail.com>
 <dabc0311-8872-4744-89ec-82a3170880b1@draigBrady.com>
 <CAFnufp35pGf6SDYRxf8YW17tdT0sTTXt_SXnPjpdWtg4ndojZA@mail.gmail.com>
 <4b3d3a05-09db-4a6a-80e2-8d6131d56366@cs.ucla.edu>
 <CAFnufp26+PnkY2OM=5NMvxDxrBf3F=FfoKBU8e0XVu4im6ZU0g@mail.gmail.com>
 <6831a0c6-baa1-4fbb-b021-4de4026922ab@cs.ucla.edu>
 <CAFnufp1z=-BfUVEX+wiiv+Y5f-fGbzBTZYwwhXM7VFGxAQLexQ@mail.gmail.com>
 <1a8636a8-bc53-4bb8-9ecb-677c0514efa2@cs.ucla.edu>
 <CAFnufp072=wSfU4TUY7DcymJCqY5VYw2dqxt=OAY3Op3zZwEpw@mail.gmail.com>
 <7e74a2c1-3053-4c2a-b1de-967d3d4f58a1@cs.ucla.edu>
 <CAFnufp0Dtg1=mKaCgSHnossVE4h41uzigw5WMTy6wkOO90sskg@mail.gmail.com>
Content-Language: en-US
From: Paul Eggert <eggert@cs.ucla.edu>
Organization: UCLA Computer Science Department
In-Reply-To: <CAFnufp0Dtg1=mKaCgSHnossVE4h41uzigw5WMTy6wkOO90sskg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-12-23 15:24, Matteo Croce wrote:
> copy_file_range(0, NULL, 1, NULL, 9223372035781033984, 0) = 0
> read(0, 0xffff273fc000, 262144)         = -1 EINVAL (Invalid argument)

Yes, the idea is to not trust copy_file_range all that much, and to 
finish off with a classic read/write loop to make sure things are OK, as 
we've run into so many squirrelly file systems where copy_file_range 
doesn't copy everything. Ironically here the classic code runs into the 
'read' kernel bug whereas copy_file_range works.

