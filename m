Return-Path: <linux-fsdevel+bounces-13775-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00AC6873C60
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Mar 2024 17:35:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 322ED1C243C9
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Mar 2024 16:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93A23132482;
	Wed,  6 Mar 2024 16:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sandeen.net header.i=@sandeen.net header.b="KUwpBUpU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sandeen.net (sandeen.net [63.231.237.45])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 155A7D534
	for <linux-fsdevel@vger.kernel.org>; Wed,  6 Mar 2024 16:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.231.237.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709742913; cv=none; b=RfsYyTLY/dfhItKGSxHQp2aTVRnX618UcwyF5j3XQlpo/8rdpD9DI8YG+8S6hE4hnwZhowwKk0MsiLTY+LjsjyEBqyMYkBdHOATIIeDWsWO1MCWQUww2WpEE/kr/vSyXD73lpV7A66XxVbBCuwQsVyWChDThNq4lbdQAGqD/ohU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709742913; c=relaxed/simple;
	bh=tO4U4nSmbcB3KDa13lvz7hm0EfA6Stm2Zg77UXfwdfc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l7JJFA4s+UkuYtecar7sKtq9HviO6mphS1DYaIM2RO5RefCCVlKWoFoQxYET/E3cGVbGMHEDzZxBADexnl0qppjD72tt+Hk1HyB3UtrIOl1oFFMKMPkRFHGbl8FPus10Zj2A/4dZNlKgV5DHCIsl+qFGawTEyNebjvv/4uVqows=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sandeen.net; spf=pass smtp.mailfrom=sandeen.net; dkim=pass (2048-bit key) header.d=sandeen.net header.i=@sandeen.net header.b=KUwpBUpU; arc=none smtp.client-ip=63.231.237.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sandeen.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sandeen.net
Received: from [10.0.0.71] (usg [10.0.0.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by sandeen.net (Postfix) with ESMTPSA id 40237328A01;
	Wed,  6 Mar 2024 10:35:03 -0600 (CST)
DKIM-Filter: OpenDKIM Filter v2.11.0 sandeen.net 40237328A01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sandeen.net;
	s=default; t=1709742903;
	bh=4lu66U4BmxG3ZL6YfCUweUycXcbcYvvPxoidjX9z99U=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=KUwpBUpUmuMD0LucIpJfkQ7nTH9NYaD0xMV05AmmleKJMpM51A0/XIHaTBPt1rrkf
	 m2qk7eunQbIA/6FIIFsGDa4YtOsjPm0R/XeCWKvQK7bzNOJR0FnGis2w7T8chA7Cd2
	 cmqrrdPQTBprbAWUP9xPJA6U+s3p3nkEVQwO2O7p6gVC84LmYqU6YTQlSdUIhCEqHK
	 3aXm3YlnvJqA8URcbfJZd69xs2WClNCW/mxoYFln+NmEzNLlIA81DhQLJtiEWMhMTF
	 o+VzkVVQc4B39wZXjL8D75cpWvzfcae7j45RCQuop1ykzKNuyBeQFcgKLv7WRzDuGj
	 z66hG02oJlTwQ==
Message-ID: <49751ee4-d2ce-4db9-af85-f9acf65a4b85@sandeen.net>
Date: Wed, 6 Mar 2024 10:35:02 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] vfs: Convert debugfs to use the new mount API
Content-Language: en-US
To: Christian Brauner <brauner@kernel.org>, Miklos Szeredi <miklos@szeredi.hu>
Cc: Eric Sandeen <sandeen@redhat.com>, linux-fsdevel@vger.kernel.org,
 Steven Rostedt <rostedt@goodmis.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Bill O'Donnell
 <billodo@redhat.com>, David Howells <dhowells@redhat.com>
References: <cfdebcc3-b9de-4680-a764-6bdf37c0accb@redhat.com>
 <49d1f108-46e3-443f-85a3-6dd730c5d076@redhat.com>
 <20240306-beehrt-abweichen-a9124be7665a@brauner>
 <CAJfpeguCKgMPBbD_ESD+Voxq5ChS9nGQFdYrA4+YWBz17yFADA@mail.gmail.com>
 <20240306-alimente-tierwelt-01d46f2b9de7@brauner>
From: Eric Sandeen <sandeen@sandeen.net>
In-Reply-To: <20240306-alimente-tierwelt-01d46f2b9de7@brauner>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/6/24 6:17 AM, Christian Brauner wrote:
> On Wed, Mar 06, 2024 at 01:13:05PM +0100, Miklos Szeredi wrote:
>> On Wed, 6 Mar 2024 at 11:57, Christian Brauner <brauner@kernel.org> wrote:
>>
>>> There's a tiny wrinkle though. We currently have no way of letting
>>> userspace know whether a filesystem supports the new mount API or not
>>> (see that mount option probing systemd does we recently discussed). So
>>> if say mount(8) remounts debugfs with mount options that were ignored in
>>> the old mount api that are now rejected in the new mount api users now
>>> see failures they didn't see before.

Oh, right - the problem is the new mount API rejects unknown options
internally, right?

>>> For the user it's completely intransparent why that failure happens. For
>>> them nothing changed from util-linux's perspective. So really, we should
>>> probably continue to ignore old mount options for backward compatibility.
>>
>> The reject behavior could be made conditional on e.g. an fsopen() flag.
> 
> and fspick() which I think is more relevant.
> 
>>
>> I.e. FSOPEN_REJECT_UNKNOWN would make unknown options be always
>> rejected.  Without this flag fsconfig(2) would behave identically
>> before/after the conversion.
> 
> Yeah, that would work. That would only make sense if we make all
> filesystems reject unknown mount options by default when they're
> switched to the new mount api imho. When we recognize the request comes
> from the old mount api fc->oldapi we continue ignoring as we did before.
> If it comes from the new mount api we reject unless
> FSOPEN/FSPICK_REJECT_UKNOWN was specified.

Ok, good point. Just thinking out loud, I guess an fsopen/fspick flag does
make more sense than i.e. each filesystem deciding whether it should reject
unknown options in its ->init_fs_context(), for consistency?

Right now it looks like the majority of filesystems do reject unknown
options internally, already.

(To muddy the waters more, other inconsistencies I've thought about are
re: how the fileystem handles remount. For example, which options are
remountable and which are not, and should non-remountable options fail?
Also whether the filesystem internally preserves the original set of
options and applies the new set as a delta, or whether it treats the
new set as the exact set of options requested post-remount, but that's
probably a topic for another day.)

-Eric

