Return-Path: <linux-fsdevel+bounces-62878-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 23802BA3C0B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Sep 2025 15:05:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3AFAF7AB4AE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Sep 2025 13:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC1782F5A0C;
	Fri, 26 Sep 2025 13:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R+hGShpQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40673279907;
	Fri, 26 Sep 2025 13:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758891923; cv=none; b=hWoPvt/cDc17tRGcMSmyzIxIDIG9coKN9YZetZF72/l2WfxVdCJagzrVa1mpS640tDvhRbdCzt/NGgtkenhwJspo5Ps1oFZIV11BAH4Ohr+kZ9PdynmLxyvfRuRmw0Z38SGLJIIYfxtjISaiMOqNx6SC7cMB3GdhFtRPOMfG/pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758891923; c=relaxed/simple;
	bh=+drV6HJHMDiVWXsRI1t2fojc5Ew0Gr1Z3BP7jR4SjQA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SXXvQpmDGkVluY01nFnw5fzcGDW6BIAg/otN2xWWVEtCv6iCexzqBKRJQHseoc6B5AHT0zkPgfqUB9aU6Fhz0qoxlL448/Jr/e7EwZWk5vIaWudE0pTzfJJnbalMAVm/VFEw15hmi9No7At9+d6ccSgYXAJTyYCidKlvh3hkpYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R+hGShpQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 736E4C4CEF4;
	Fri, 26 Sep 2025 13:05:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758891922;
	bh=+drV6HJHMDiVWXsRI1t2fojc5Ew0Gr1Z3BP7jR4SjQA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=R+hGShpQWYEqjAySfOn5yg/y2FmA7HWRFYY5oGCNKU9UigdPJUx4wzd0v3HBSjca/
	 zKqf40OKcovmkY8fwgJivElnLItgkr64JU6s7h+dBVwhyeOLozHpKvMUJtr57uKWBX
	 QSg8mrpnTP1hjGiZDYg7j6m6DuGGibEyPRbe4YJ5Ht920XH30LO/EzbeIboJNNyvHO
	 2KUdu9//DiGV/0UXV4KwYOv73xENzBefMA0fvycw9I81asq1VSRR7KPEXlX8QETzk9
	 q36ya5/31OB3puSfp6nix25vSSqGwKdqgFWI+EhCUXm+zmXXdn4jWUm+QudLUCpybX
	 fbeH/1PxyCaJQ==
Message-ID: <39397920-3dc0-4295-b34d-67a298bf861b@kernel.org>
Date: Fri, 26 Sep 2025 09:05:21 -0400
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] fs: Plumb case sensitivity bits into statx
To: Jeff Layton <jlayton@kernel.org>, linux-fsdevel@vger.kernel.org,
 linux-nfs@vger.kernel.org
Cc: Chuck Lever <chuck.lever@oracle.com>,
 Volker Lendecke <Volker.Lendecke@sernet.de>
References: <20250925151140.57548-1-cel@kernel.org>
 <ad767899918d26817e44f1af213a8dfdce26508a.camel@kernel.org>
Content-Language: en-US
From: Chuck Lever <cel@kernel.org>
Organization: kernel.org
In-Reply-To: <ad767899918d26817e44f1af213a8dfdce26508a.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/26/25 3:00 AM, Jeff Layton wrote:
>> diff --git a/include/uapi/linux/stat.h b/include/uapi/linux/stat.h
>> index 1686861aae20..e929b30d64b6 100644
>> --- a/include/uapi/linux/stat.h
>> +++ b/include/uapi/linux/stat.h
>> @@ -219,6 +219,7 @@ struct statx {
>>  #define STATX_SUBVOL		0x00008000U	/* Want/got stx_subvol */
>>  #define STATX_WRITE_ATOMIC	0x00010000U	/* Want/got atomic_write_* fields */
>>  #define STATX_DIO_READ_ALIGN	0x00020000U	/* Want/got dio read alignment info */
>> +#define STATX_CASE_INFO		0x00040000U	/* Want/got case folding info */
>>
>>
> Do you intend to expose this new attribute to userland? If not, then it
> should probably snuggle up next to STATX_CHANGE_COOKIE. If so, then you
> need to claim a field for it in struct statx, and populate it.

As I mentioned in the patch description, exposing to user space can be
done as a next step if we decide to pursue this proposal further. Yes,
that is something I have in mind.


-- 
Chuck Lever

