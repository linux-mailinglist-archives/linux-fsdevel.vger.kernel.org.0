Return-Path: <linux-fsdevel+bounces-45809-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1C22A7C806
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Apr 2025 09:44:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65B827A813F
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Apr 2025 07:43:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFD381CAA64;
	Sat,  5 Apr 2025 07:44:00 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA5F215AF6;
	Sat,  5 Apr 2025 07:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743839040; cv=none; b=m8GqIbFB8JzlkBjeS6JPVVg/+c4aF3Zbi33vK+PjIW9K7PszMK8Aaull6XEs6rN9oUqNKn06HX5k02E2Pp5y+GhNyPKGUrHCl+j51kOvBuPCesL0VTKxHDNYyC40wSPjOhSFs6RagyMcXFgIHFMJ5ZxmP+BCsYk+4XCMGKAt9GI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743839040; c=relaxed/simple;
	bh=0LUP14LmWesBPAsxBEvQb6xYnuZfcBhUaCYe7j9olQY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qx2otDgHsxqZYmt9es7jdo9jjTQJkf7SpydJtOnzlp5ntNhuc4WdgOe2eWQ3HDv7NNcjB9LwktbMceLOOOi4GVCy+S1YPK1+VH953GpbAieJm5EUsyeOp/EbnExueHOzZvkaPj2i5LL3SsKJ0RBB8E76eARpt/scuhv16Ta0V+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.2] (ip5f5af06b.dynamic.kabel-deutschland.de [95.90.240.107])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id ACAF361E6479B;
	Sat, 05 Apr 2025 09:43:29 +0200 (CEST)
Message-ID: <417f41b3-b343-46ca-9efe-fa815e85bdd3@molgen.mpg.de>
Date: Sat, 5 Apr 2025 09:43:29 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] Chrome and VSCode breakage with the commit
 b9b588f22a0c
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Chuck Lever <chuck.lever@oracle.com>, Takashi Iwai <tiwai@suse.de>,
 linux-fsdevel@vger.kernel.org, stable@vger.kernel.org,
 regressions@lists.linux.dev, linux-kernel@vger.kernel.org,
 Christian Brauner <brauner@kernel.org>
References: <874j0lvy89.wl-tiwai@suse.de> <87wmc83uaf.wl-tiwai@suse.de>
 <445aeb83-5d84-4b4b-8d87-e7f17c97e6bf@oracle.com>
 <16e0466d-1f16-4e9a-9799-4c01bd2bb005@molgen.mpg.de>
 <2025040551-catatonic-reflex-2ebf@gregkh>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <2025040551-catatonic-reflex-2ebf@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Greg,


Thank you for replying on a Saturday.

Am 05.04.25 um 09:29 schrieb Greg KH:
> On Sat, Apr 05, 2025 at 08:32:13AM +0200, Paul Menzel wrote:

>> Am 29.03.25 um 15:57 schrieb Chuck Lever:
>>> On 3/29/25 8:17 AM, Takashi Iwai wrote:
>>>> On Sun, 23 Feb 2025 09:53:10 +0100, Takashi Iwai wrote:
>>
>>>>> we received a bug report showing the regression on 6.13.1 kernel
>>>>> against 6.13.0.  The symptom is that Chrome and VSCode stopped working
>>>>> with Gnome Scaling, as reported on openSUSE Tumbleweed bug tracker
>>>>>     https://bugzilla.suse.com/show_bug.cgi?id=1236943
>>>>>
>>>>> Quoting from there:
>>>>> """
>>>>> I use the latest TW on Gnome with a 4K display and 150%
>>>>> scaling. Everything has been working fine, but recently both Chrome
>>>>> and VSCode (installed from official non-openSUSE channels) stopped
>>>>> working with Scaling.
>>>>> ....
>>>>> I am using VSCode with:
>>>>> `--enable-features=UseOzonePlatform --enable-features=WaylandWindowDecorations --ozone-platform-hint=auto` and for Chrome, I select `Preferred Ozone platform` == `Wayland`.
>>>>> """
>>>>>
>>>>> Surprisingly, the bisection pointed to the backport of the commit
>>>>> b9b588f22a0c049a14885399e27625635ae6ef91 ("libfs: Use d_children list
>>>>> to iterate simple_offset directories").
>>>>>
>>>>> Indeed, the revert of this patch on the latest 6.13.4 was confirmed to
>>>>> fix the issue.  Also, the reporter verified that the latest 6.14-rc
>>>>> release is still affected, too.
>>>>>
>>>>> For now I have no concrete idea how the patch could break the behavior
>>>>> of a graphical application like the above.  Let us know if you need
>>>>> something for debugging.  (Or at easiest, join to the bugzilla entry
>>>>> and ask there; or open another bug report at whatever you like.)
>>>>>
>>>>> BTW, I'll be traveling tomorrow, so my reply will be delayed.
>>
>>>>> #regzbot introduced: b9b588f22a0c049a14885399e27625635ae6ef91
>>>>> #regzbot monitor: https://bugzilla.suse.com/show_bug.cgi?id=1236943
>>>>
>>>> After all, this seems to be a bug in Chrome and its variant, which was
>>>> surfaced by the kernel commit above: as the commit changes the
>>>> directory enumeration, it also changed the list order returned from
>>>> libdrm drmGetDevices2(), and it screwed up the application that worked
>>>> casually beforehand.  That said, the bug itself has been already
>>>> present.  The Chrome upstream tracker:
>>>>     https://issuetracker.google.com/issues/396434686
>>>>
>>>> #regzbot invalid: problem has always existed on Chrome and related code
>>
>>> Thank you very much for your report and for chasing this to conclusion.
>> Doesn’t marking this an invalid contradict Linux’ no regression policy to
>> never break user space, so users can always update the Linux kernel?
>> Shouldn’t this commit still be reverted, and another way be found keeping
>> the old ordering?
>>
>> Greg, Sasha, in stable/linux-6.13.y the two commits below would need to be
>> reverted:
>>
>> 180c7e44a18bbd7db89dfd7e7b58d920c44db0ca
>> d9da7a68a24518e93686d7ae48937187a80944ea
>>
>> For stable/linux-6.12.y:
>>
>> 176d0333aae43bd0b6d116b1ff4b91e9a15f88ef
>> 639b40424d17d9eb1d826d047ab871fe37897e76
> 
> Unless the changes are also reverted in Linus's tree, we'll be keeping
> these in.  Please work with the maintainers to resolve this in mainline
> and we will be glad to mirror that in the stable trees as well.

Commit b9b588f22a0c (libfs: Use d_children list to iterate simple_offset 
directories) does not have a Fixes: tag or Cc: stable@vger.kernel.org. I 
do not understand, why it was applied to the stable series at all [1], 
and cannot be reverted when it breaks userspace?


Kind regards,

Paul


[1]: https://docs.kernel.org/process/stable-kernel-rules.html

