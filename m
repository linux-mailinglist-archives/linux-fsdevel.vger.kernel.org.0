Return-Path: <linux-fsdevel+bounces-23551-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0804092E1CC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jul 2024 10:15:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 883C4B23856
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jul 2024 08:15:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F6E7156228;
	Thu, 11 Jul 2024 08:14:03 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from air.basealt.ru (air.basealt.ru [194.107.17.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9135915217F;
	Thu, 11 Jul 2024 08:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.107.17.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720685643; cv=none; b=uDCYalDJJbOFbnTD/y5rQwOXnJccZ68DUHHUOw+b9ujKyqo73OpkmVXeYu0W/3TRptb+Xfanr8a+C6MKch+efpH0LbnVpTEa4SoF4HxZnjcVuKF/vz/EnsamwjJDp0hTaj3NMvuGMEnJTm8fdvCH+HTL3ncSKQv2wIgo14DTqk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720685643; c=relaxed/simple;
	bh=9noRXAQFo9bH77pQhyhU8JQGqy3FQwmsoYj1QuO107Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TSbGBQPyx/zb54b3OWGa+kuwr+DGTT6CvNCYuuVBuRRjrwyMF/Gmotb6AqhMncJOyo9Pbys6F/osJOHj6m6XbmTHyHS8B2b5QSJL/RQsblSzckV95bOymlKUxaLjOTwPOrQHIzkkkgBWpvxfbx2QBlz3ifQBJDcGHNuxt8jQcdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=194.107.17.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: by air.basealt.ru (Postfix, from userid 490)
	id CDF4C2F20251; Thu, 11 Jul 2024 08:13:58 +0000 (UTC)
X-Spam-Level: 
Received: from [192.168.0.102] (unknown [178.76.204.78])
	by air.basealt.ru (Postfix) with ESMTPSA id 419612F20260;
	Thu, 11 Jul 2024 08:13:58 +0000 (UTC)
Message-ID: <4bf1acdd-9ab3-2e83-d491-79039c6d0e92@basealt.ru>
Date: Thu, 11 Jul 2024 11:13:57 +0300
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 fs/bfs 0/2] bfs: fix null-ptr-deref and possible
 warning in bfs_move_block() func
Content-Language: en-US
To: Markus Elfring <Markus.Elfring@web.de>
Cc: stable@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 lvc-patches@linuxtesting.org, "Tigran A. Aivazian"
 <aivazian.tigran@gmail.com>, dutyrok@altlinux.org,
 linux-fsdevel@vger.kernel.org
References: <20240711073238.44399-1-kovalev@altlinux.org>
 <5c191e5d-b64c-4e3c-9f70-9cd3371a3142@web.de>
From: kovalev@altlinux.org
In-Reply-To: <5c191e5d-b64c-4e3c-9f70-9cd3371a3142@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

11.07.2024 10:47, Markus Elfring wrote:
> …
>> [PATCHv2 fs/bfs 1/2] bfs: prevent null pointer dereference in bfs_move_block()
> …
> 
> I find it usually helpful to separate the version identifier from the previous key word.
> 
> How do you think about to improve the outline another bit (also for the cover letter)?

I will take your recommendation into account when submitting the next 
versions, if there are any comments on the patches themselves.

> Regards,
> Markus

-- 
Thanks,
Vasiliy Kovalev

