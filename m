Return-Path: <linux-fsdevel+bounces-12703-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D211786293E
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Feb 2024 06:57:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D854B21585
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Feb 2024 05:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EFDBBE5E;
	Sun, 25 Feb 2024 05:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="XtVGY8p+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 519B39443;
	Sun, 25 Feb 2024 05:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708840652; cv=none; b=bfOynNLa3iVIjDKR+NFiOXvMBIoiAxX5fz3ClvGJH/cZka5nwhgnnGpEsFRtyyi+bWd9b/yTd5QmCdW0OyiPKMPIlCNSvS8gY8jr7ctauFBKR4Bz6joupGj42CF4uClmnolK56rqYEDL3QooLwXHAAAEHQDng0k3HBhGwUFef04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708840652; c=relaxed/simple;
	bh=QpPrkM0hEknnX9z72cr5X4Rw6BoHmRfdBG6lB27sycw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V/anwuwg27rgecC/WIReylC05SU448YJKzT+jXzAJWRIK8VYSqbDY2i895hPX3RuXl+TFfcQAxD2Urj6saM5WNxwG/YsW7do0BGEtkoUCgQ/x5lNt64nS+N7byJGLYXwbh3OJIyxcvuu4LnVz14NZqwsSpJRLZrehrgMiHx5+uI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=XtVGY8p+; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=5tyQLvMNT9E4Tr/AbhbZm9ixo5fjkwiuVvjkmXED5iE=;
	t=1708840650; x=1709272650; b=XtVGY8p+effF1uS+uC43CF3IHdFhk/H1r2SiZiEGRS9088L
	3GYR/amv3y4tWVxfbduSwXoRYXo2uMt59MjM5Nw7IfuW1sRto9MnJ8YKhfETHvXBpDoKl/zI59iSS
	dKlDQppV324nD1HMaX9Ddfx01uqasC4vrgEBkZoxccDnNU2JsE3HmE7dJWjWUCcugX1zZyjzF++Ep
	YxZqTm1DUGp351MrI9s+aHfeatcl/3JBv2qPOf4UXqYF8gA8tJEG7gEdboHy80xkVpdiWGGXEnou0
	zZZSQJHPQb5t04P7ADSMpiTXuy9/XXTSBQt7ZJvfIpk+FNXbjVtzp1l1aytSPfWw==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1re7Vv-0008GL-J5; Sun, 25 Feb 2024 06:57:27 +0100
Message-ID: <5b67d22f-ddd6-4b9d-9c86-00976d6b53ca@leemhuis.info>
Date: Sun, 25 Feb 2024 06:57:26 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] 6.8-rc process is unable to exit and consumes a lot
 of cpu
Content-Language: en-US, de-DE
To: Al Viro <viro@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux regressions mailing list <regressions@lists.linux.dev>,
 "Christian Brauner (Microsoft)" <brauner@kernel.org>,
 Matt Heon <mheon@redhat.com>, Ed Santiago <santiago@redhat.com>,
 Linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 Paul Holzinger <pholzing@redhat.com>, LKML <linux-kernel@vger.kernel.org>
References: <6a150ddd-3267-4f89-81bd-6807700c57c1@redhat.com>
 <652928aa-0fb8-425e-87b0-d65176dd2cfa@redhat.com>
 <9b92706b-14c2-4761-95fb-7dbbaede57f4@leemhuis.info>
 <e733c14e-0bdd-41b2-82aa-90c0449aff25@redhat.com>
 <f15ee051-2cfe-461f-991d-d09fd53bad4f@leemhuis.info>
 <c0cbf518-c6d4-4792-ad04-f8b535d41f4e@leemhuis.info>
 <CAHk-=wg9nqLqxr7bPFt4CUzb+w4TqENb+0G1-yJfZbwvRhi29A@mail.gmail.com>
 <ZdqWYplgbHL7xSch@duke.home>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <ZdqWYplgbHL7xSch@duke.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1708840650;e30ad12f;
X-HE-SMSGID: 1re7Vv-0008GL-J5

On 25.02.24 02:22, Al Viro wrote:
> On Sat, Feb 24, 2024 at 03:43:43PM -0800, Linus Torvalds wrote:
>> On Fri, 23 Feb 2024 at 23:00, Thorsten Leemhuis
>> <regressions@leemhuis.info> wrote:
>>>
>>> TWIMC, the quoted mail apparently did not get delivered to Al (I got a
>>> "48 hours on the queue" warning from my hoster's MTA ~10 hours ago).
>>
>> Al's email has been broken for the last almost two weeks - the machine
>> went belly-up in a major way.
>>
>> I bounced the email to his kernel.org email that seems to work,

Thx!

>> but I
>> also think Al ends up being busy trying to get through everything else
>> he missed, in addition to trying to get the machine working again...
> 
> FWIW, I'm pretty sure that it's fixed by #fixes^ (7e4a205fe56b) in
> my tree; I'll send a pull request, both for #fixes and #fixes.pathwalk.rcu

Great, thank you, too!

Ciao, Thorsten



