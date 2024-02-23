Return-Path: <linux-fsdevel+bounces-12593-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AF8F8617DA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Feb 2024 17:28:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CADB1C242DF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Feb 2024 16:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A68C6FD5;
	Fri, 23 Feb 2024 16:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sandeen.net header.i=@sandeen.net header.b="WINGCfQt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sandeen.net (sandeen.net [63.231.237.45])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BF8A8287B
	for <linux-fsdevel@vger.kernel.org>; Fri, 23 Feb 2024 16:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.231.237.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708705683; cv=none; b=M42BPXskP3LFhokwu/d/wTmRqDjoDiKIu6TQ+On8f4rQGcKKeUNdbvbiTLAg5gLQqROlDANO3rBlPXzJ8zOjBZUTQl54WM3ITBXvhTVwGTkobasuBpE7IGi81GKLg114qLBWAFXKfci58r594+18QIWrYXxFttyBZyClHOpMo2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708705683; c=relaxed/simple;
	bh=1yufVWqi9qLXF5cHvdSndJZG7zCzk94YId/24Xt3ZW4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ATg65bpJ9ZGyP+hi98hk2BAMXAi5tA0z8Bb1qSu+DEpfKGYTPEkorfg5VCUzopQo5lERBU7v4ArsRsKWIiVTNtmx+paxZ653JYyG8wNd49uNx2NWqGNfFRIl08ij/AgvKSkSqtyifESbEY7s2dctu7olI5XmmxmfbQwGf2HN8Ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sandeen.net; spf=pass smtp.mailfrom=sandeen.net; dkim=pass (2048-bit key) header.d=sandeen.net header.i=@sandeen.net header.b=WINGCfQt; arc=none smtp.client-ip=63.231.237.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sandeen.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sandeen.net
Received: from [10.0.0.71] (usg [10.0.0.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by sandeen.net (Postfix) with ESMTPSA id E46EF22E2;
	Fri, 23 Feb 2024 10:27:54 -0600 (CST)
DKIM-Filter: OpenDKIM Filter v2.11.0 sandeen.net E46EF22E2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sandeen.net;
	s=default; t=1708705675;
	bh=3lNxhhEs6H/gCJpS3WTE+5pknP1Mzfg8NWN5lsL+DXc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=WINGCfQtjN53X98JXGSXbBFWMHUldKUu/mVoWsqujamkczoFDgIdBHFDWyahsbiXS
	 xw4Ro/j8LubvsaIw+MvSK91cdcgNeIbd+mEsGQwEhPmwdbICQuZUcC5sfbz0VEpuJj
	 cDrLTqnF2aJY9lX7G3AgKwRL5xeTaxIKGyhH+OfacMvDtkxWlvlnDy4oSsghHFgIWI
	 sBN7Qb5iY8Im7E4IsVNjX6Hyk6sKB8xYEfLr1e0nFs1A7FZB2PrSL+yQY8ignQMkm+
	 WdNKQx7CS8r98eoOzgyjTezoYKsXM+uwogXPyCLPURlWYBP51esW1G6JOne4tqpU2j
	 t9NlqyPLx0Q+A==
Message-ID: <4dd8f956-ab65-4c46-995c-892fa9cca283@sandeen.net>
Date: Fri, 23 Feb 2024 10:27:54 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] vfs: always log mount API fs context messages to
 dmesg
Content-Language: en-US
To: Christian Brauner <brauner@kernel.org>, Eric Sandeen <sandeen@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, David Howells <dhowells@redhat.com>,
 Alexander Viro <aviro@redhat.com>, Bill O'Donnell <billodo@redhat.com>,
 Karel Zak <kzak@redhat.com>
References: <9934ed50-5760-4326-a921-cee0239355b0@redhat.com>
 <20240223-beraten-pilzbefall-6ca15beab35b@brauner>
From: Eric Sandeen <sandeen@sandeen.net>
In-Reply-To: <20240223-beraten-pilzbefall-6ca15beab35b@brauner>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/23/24 9:06 AM, Christian Brauner wrote:
> On Thu, Feb 22, 2024 at 09:22:52AM -0600, Eric Sandeen wrote:
>> As filesystems are converted to the new mount API, informational messages,
>> errors, and warnings are being routed through infof, errorf, and warnf
>> type functions provided by the mount API, which places these messages in
>> the log buffer associated with the filesystem context rather than
>> in the kernel log / dmesg.
>>
>> However, userspace is not yet extracting these messages, so they are
>> essentially getting lost. mount(8) still refers the user to dmesg(1)
>> on failure.
> 
> I mean sure we can do this. But we should try without a Kconfig option
> for this.
> 
> But mount(8) and util-linux have been switched to the new mount api in
> v2.39 and libmount already has the code to read and print the error
> messages:
> 
> https://github.com/util-linux/util-linux/blob/7ca98ca6aab919f271a15e40276cbb411e62f0e4/libmount/src/hook_mount.c#L68

*nod*

> but it's hidden behind DEBUG.

Yup.

> So to me it seems much easier to just make
> util-linux and log those extra messages than start putting them into
> dmesg. Can't we try that first?

Sounds fine. Since we're trying to get a few more filesystems
converted (hopefully all!) I just wanted to be sure that doing so
doesn't end up losing useful information for the user.

I guess we could do conversions in 2 passes, and wait to switch to
warnf() and friends until util-linux makes use of it, but I'd hoped to
not have to touch everything twice, hence thinking about logging to
dmesg in the short term.

But there are downsides and complexities to that as well. I'm not
wedded to it, hence the RFC. :)

Let's see what kzak thinks? We could also just delay any conversions
that would need to pipe information through warnf().

Thanks,
-Eric

