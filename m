Return-Path: <linux-fsdevel+bounces-49657-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 02946AC0482
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 May 2025 08:20:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 564761BA5AF4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 May 2025 06:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56022221735;
	Thu, 22 May 2025 06:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="bAQsoRJ8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A12771AF0B5;
	Thu, 22 May 2025 06:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747894834; cv=none; b=eC9CIdFezi2eViWxgRcw78CaP3jQhAEgXz//PP77dch8mnyeM9s/R0cUyWAZmG2hiCV7luqz3E6G3p052CbQWxpRK7WnI0uJ69rEc+OgwSpHqetnSymWIh9OT8E5gd/87j0yMXq3qI1qNA0NwUgkesam5EBzJnJEWujzsAwS0zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747894834; c=relaxed/simple;
	bh=3sWViiZaf9RhENi7473FExg7j1NIW1+ICKGOTV5yJyc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YlZprFZL1rIlYZrBNC+ERiGM8dInq/TDrJedcGUEhlgHMQ8mihdyC0dC7sHHKYelIyXVQgW+grlqdS7vPtJHKN7NBcAOXnAwbqvKIzLRwibhSUsVaGqaEidtBQ5OuwT0lWPpMEkV/Untw1l0R97k5QVn7kKxJJZJK+6ISPQfcu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=bAQsoRJ8; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=kiRPMbGvX4N7MDqUbh2hwhW3nBE5n+0fzxaK4sfzW48=; b=bAQsoRJ8pQBUwCHUnq9KRGF2t5
	5bf6INLPShE6UWjyx2uyzRMiNLzm1PhRq55ap8xTB5zaLFusTGFKuZYIkKDF7jiUe1YSVknf1JASf
	bR1RHPx4Mmq+FlT65YOBlXAdsWsr/p84ni/wUribMo1E7+E+d1KQOu6ArDgyFDKxdKjzqkjQr0O9N
	K99FUQi4aIfYUdhE6P3d+VBU1zniOtycYNixTxTOLmG162yPiZpMFkdWBnJkHTm5voomI8+0PGrwj
	dH5UgV3CoQRowl8o0X8ACcKGPvRoK975x5ujao6DHDEPffnqeTGLEQp/ovaeMmcN/7gjtAYRGDjAV
	fhT45Ixg==;
Received: from [191.204.192.64] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1uHzI3-00BZzW-Kh; Thu, 22 May 2025 08:20:27 +0200
Message-ID: <32f30f6d-e995-4f00-a8ec-31100a634a38@igalia.com>
Date: Thu, 22 May 2025 03:20:23 -0300
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ovl: Allow mount options to be parsed on remount
To: Christian Brauner <brauner@kernel.org>,
 Amir Goldstein <amir73il@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-unionfs@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-dev@igalia.com,
 linux-fsdevel@vger.kernel.org
References: <20250521-ovl_ro-v1-1-2350b1493d94@igalia.com>
 <CAOQ4uxgXP8WrgLvtR6ar+OncP6Fh0JLVO0+K+NtDX1tGa2TVxA@mail.gmail.com>
 <20250521-blusen-bequem-4857e2ce9155@brauner>
Content-Language: en-US
From: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
In-Reply-To: <20250521-blusen-bequem-4857e2ce9155@brauner>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Christian, Amir,

Thanks for the feedback :)

Em 21/05/2025 08:20, Christian Brauner escreveu:
> On Wed, May 21, 2025 at 12:35:57PM +0200, Amir Goldstein wrote:
>> On Wed, May 21, 2025 at 8:45 AM André Almeida <andrealmeid@igalia.com> wrote:
>>>

[...]

>>
>> I see the test generic/623 failure - this test needs to be fixed for overlay
>> or not run on overlayfs.
>>
>> I do not see those other 5 failures although before running the test I did:
>> export LIBMOUNT_FORCE_MOUNT2=always
>>
>> Not sure what I am doing differently.
>>

I have created a smaller reproducer for this, have a look:

  mkdir -p ovl/lower ovl/upper ovl/merge ovl/work ovl/mnt
  sudo mount -t overlay overlay -o lowerdir=ovl/lower,upperdir=ovl/ 
upper,workdir=ovl/work ovl/mnt
  sudo mount ovl/mnt -o remount,ro

And this returns:

  mount: /tmp/ovl/mnt: fsconfig() failed: overlay: No changes allowed in 
  reconfigure.
        dmesg(1) may have more information after failed mount system call.

However, when I use mount like this:

  sudo mount -t overlay overlay -o remount,ro ovl/mnt

mount succeeds. Having a look at strace, I found out that the first 
mount command tries to set lowerdir to "ovl/lower" again, which will to 
return -EINVAL from ovl_parse_param():

    fspick(3, "", FSPICK_NO_AUTOMOUNT|FSPICK_EMPTY_PATH) = 4
    fsconfig(4, FSCONFIG_SET_STRING, "lowerdir", "/tmp/ovl/lower", 0) = 
-1 EINVAL (Invalid argument)

Now, the second mount command sets just the "ro" flag, which will return 
after vfs_parse_sb_flag(), before getting to ovl_parse_param():

    fspick(3, "", FSPICK_NO_AUTOMOUNT|FSPICK_EMPTY_PATH) = 4
    fsconfig(4, FSCONFIG_SET_FLAG, "ro", NULL, 0) = 0

After applying my patch and running the first mount command again, we 
can set that this flag is set only after setting all the strings:

    fsconfig(4, FSCONFIG_SET_STRING, "lowerdir", "/tmp/ovl/lower", 0) = 0
    fsconfig(4, FSCONFIG_SET_STRING, "upperdir", "/tmp/ovl/upper", 0) = 0
    fsconfig(4, FSCONFIG_SET_STRING, "workdir", "/tmp/ovl/work", 0) = 0
    fsconfig(4, FSCONFIG_SET_STRING, "uuid", "on", 0) = 0
    fsconfig(4, FSCONFIG_SET_FLAG, "ro", NULL, 0) = 0

I understood that the patch that I proposed is wrong, and now I wonder 
if the kernel needs to be fixed at all, or if the bug is how mount is 
using fsconfig() in the first mount command?

Thanks,
	André

