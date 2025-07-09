Return-Path: <linux-fsdevel+bounces-54393-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EC57AFF456
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 00:03:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3D6C175C30
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Jul 2025 22:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D842E23C501;
	Wed,  9 Jul 2025 22:03:42 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A02E13D2B2;
	Wed,  9 Jul 2025 22:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752098622; cv=none; b=L+mwFj4D59ORqY4FJKJsvWoLtdFjWSOxqOs1UoIIwTYZQIkL8vIHDKLZfehQuT7MaR38lbtkrfZB2LgkQwdMm782h0u0iW74btyz26pmkYpS813LsSbJ4iurHM9U6mNabtuK3YEqOHZ1uXocTp6kVSQfwPE351GZ21gR5VFqjqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752098622; c=relaxed/simple;
	bh=OSlNipfL8acGfxBPuYcCjdhJaWK0Nj+mUkPNpzpq8h0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BJhcPXycDi5/1xJ2ofrPi6W4X4OxeF8BgfpCvOEKsyEZsY+sb2Ne8X5qfVz1vuqORInZ6DpEBiqdyIvR/tZnayBXUdA81e7rXcqX19uGIH3Cq5so+1oRLsPOaCYqnto4+QQ+YTvC8yJc35sDu3gnc3eM7IDySOzAuTmxn+C4E0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 569M3Kc1078763;
	Thu, 10 Jul 2025 07:03:20 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 569M3KgL078760
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 10 Jul 2025 07:03:20 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <3efa3d2a-e98f-43ee-91dd-5aeefcff75e1@I-love.SAKURA.ne.jp>
Date: Thu, 10 Jul 2025 07:03:18 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hfsplus: don't use BUG_ON() in
 hfsplus_create_attributes_file()
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>,
        "frank.li@vivo.com" <frank.li@vivo.com>,
        "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
        "slava@dubeyko.com" <slava@dubeyko.com>,
        "brauner@kernel.org" <brauner@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <54358ab7-4525-48ba-a1e5-595f6b107cc6@I-love.SAKURA.ne.jp>
 <4ce5a57c7b00bbd77d7ad6c23f0dcc55f99c3d1a.camel@ibm.com>
 <72c9d0c2-773c-4508-9d2d-e24703ff26e1@vivo.com>
 <427a9432-95a5-47a8-ba42-1631c6238486@I-love.SAKURA.ne.jp>
 <127b250a6bb701c631bedf562b3ee71eeb55dc2c.camel@ibm.com>
 <dc0add8a-85fc-41dd-a4a6-6f7cb10e8350@I-love.SAKURA.ne.jp>
 <316f8d5b06aed08bd979452c932cbce2341a8a56.camel@ibm.com>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <316f8d5b06aed08bd979452c932cbce2341a8a56.camel@ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Virus-Status: clean
X-Anti-Virus-Server: fsav205.rs.sakura.ne.jp

On 2025/07/10 3:33, Viacheslav Dubeyko wrote:
> My worry that we could have a race condition here. Let's imagine that two
> threads are trying to call __hfsplus_setxattr() and both will try to create the
> Attributes File. Potentially, we could end in situation when inode could have
> not zero size during hfsplus_create_attributes_file() in one thread because
> another thread in the middle of Attributes File creation. Could we double check
> that we don't have the race condition here? Otherwise, we need to make much
> cleaner fix of this issue.

I think that there is some sort of race window, for
https://elixir.bootlin.com/linux/v6.15.5/source/fs/hfsplus/xattr.c#L145
explains that if more than one thread concurrently reached

	if (!HFSPLUS_SB(inode->i_sb)->attr_tree) {
		err = hfsplus_create_attributes_file(inode->i_sb);
		if (unlikely(err))
			goto end_setxattr;
	}

path, all threads except one thread will fail with -EAGAIN.


