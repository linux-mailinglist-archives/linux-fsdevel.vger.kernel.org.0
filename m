Return-Path: <linux-fsdevel+bounces-69688-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id DC0BBC811D0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Nov 2025 15:46:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6E822347450
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Nov 2025 14:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B1A62848A0;
	Mon, 24 Nov 2025 14:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b="Ty6kuuU+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from hr2.samba.org (hr2.samba.org [144.76.82.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 786A61C01;
	Mon, 24 Nov 2025 14:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.82.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763995597; cv=none; b=VObh2wgOHNqOzwOuujI/7S3bLfZmizmOO99etpVfwQWKjB4fihL6nyCjmkMJktgxQMEy4FxXvexnHIBc25ty7iCRivuoCvJUpae+OdkwTfFQPeNuhjE5hPlTjpwd2hdQUpRymf+Fvw0MMEpjNUmlmsjPt3lOoatda0EDs6AV7rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763995597; c=relaxed/simple;
	bh=2Kl2yuM7OfN4iNrXvpg2vqZ2QaIxr3Hx/veU3F1gEqc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ryH9w/QCaEdaamgu+jfCpDGcOXlSRsBDh5w+6I7xfGnEHJW5a5K5fwpsyoTVsOivi7fMrL+B2GcJq8p/4feCeD7F9H401jVEzFPSW9+F1ILXar/Ky8u1HV+aWeRsxn/y+P3OmRCCXU6Hm20V0KdT6wQ+dSVMT9VJWfCDhsa+TtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org; spf=pass smtp.mailfrom=samba.org; dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b=Ty6kuuU+; arc=none smtp.client-ip=144.76.82.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samba.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
	s=42; h=From:Cc:To:Date:Message-ID;
	bh=9/T2HyyPJ92ThKUD+xRT7Ar+Uv9/yCuNRYXHiRrYqzg=; b=Ty6kuuU+6nFpz/DmLPeg3P1Xuu
	j8uqVJnhlnwQ//xr01T4ArEU4wEdHBLeRAp6CIptnaSatUJLs8k2yBjUaYCF1IU++1F1qvFTfhO9K
	v/mChXn23TV9NJXgqe+69tYHbaBLSesXBQb5hsejln38laQ4iSq9G4zqC82CA4TYEY85AuiuFeOAh
	mzZUD6YQpTefVCWsypIQ6hcqpUVu0cIzIYq7jZYiyYsbuKmthVVs+6/6WX8qxDV6AzgBxnh3bxwYx
	XBDFcr8HNaFJK7QI76A3UBofEnQrn/vPjNiD6gUfixk2enYZ/Xh+mGk/9d66CwJSeYgQtLaGe4AF+
	kUfsv7FN8pI0gslLPABmY5mMHZ92fXERHpLu7HqhcxC6rnhEh35M9VThIE6DjU1fOoknypV+m6+k+
	+adnNxM7weatczEjclUGPePihnHqx8JEv0PQ04noK0Z2JI42OsSD/e1mD7BiMaFowmelzJypj0aiJ
	cdHhoPbmBE1smn0gGCNc9sjk;
Received: from [127.0.0.2] (localhost [127.0.0.1])
	by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__ECDSA_SECP256R1_SHA256__CHACHA20_POLY1305:256)
	(Exim)
	id 1vNXpp-00FQEE-0Z;
	Mon, 24 Nov 2025 14:46:33 +0000
Message-ID: <b14a083e-d754-48a9-b480-1344a07479aa@samba.org>
Date: Mon, 24 Nov 2025 15:46:32 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 07/11] cifs: Clean up some places where an extra kvec[]
 was required for rfc1002
To: David Howells <dhowells@redhat.com>
Cc: Steve French <sfrench@samba.org>, Paulo Alcantara <pc@manguebit.org>,
 Shyam Prasad N <sprasad@microsoft.com>, linux-cifs@vger.kernel.org,
 netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, Tom Talpey <tom@talpey.com>
References: <ad8ef7da-db2a-4033-8701-cf2fc61b8a1d@samba.org>
 <7b897d50-f637-4f96-ba64-26920e314739@samba.org>
 <20251124124251.3565566-1-dhowells@redhat.com>
 <20251124124251.3565566-8-dhowells@redhat.com>
 <3635951.1763995018@warthog.procyon.org.uk>
 <3639864.1763995480@warthog.procyon.org.uk>
Content-Language: en-US
From: Stefan Metzmacher <metze@samba.org>
In-Reply-To: <3639864.1763995480@warthog.procyon.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Am 24.11.25 um 15:44 schrieb David Howells:
> Stefan Metzmacher <metze@samba.org> wrote:
> 
>> Ok, I can just squash as well as the EIO changes below my branch
>> I'll hopefully be able to post later today or tomorrow.
>>
>> My idea would be that my branch would replace ksmbd-for-next
>> and add your any my changes on top.
> 
> I've merged in your requested changes and repushed my branch.

Great thanks!
metze

