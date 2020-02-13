Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D77A15CD14
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Feb 2020 22:18:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727883AbgBMVSu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Feb 2020 16:18:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:39938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727772AbgBMVSu (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Feb 2020 16:18:50 -0500
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 79A212168B;
        Thu, 13 Feb 2020 21:18:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581628728;
        bh=OkNvY2w0dvReTlOIT/xPq+MCO9x3gBl/PCgEcq7lswU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KZKY1cQB/rgKkEJgSbRvsTvKKJcsKi3UjZZcLC47f3X/o3xt7rlccd+seIbMKVk1C
         9AbGj4phYitBsYG8mdPWREqt1bU4xkOG1UyckNUB1b5NUO8AoA3kJByKTNFTHCEtRm
         r2dsnHwaOWfNtpJSrPscLtT5Efn4sgI4JRPSGLeQ=
Date:   Thu, 13 Feb 2020 16:18:47 -0500
From:   Sasha Levin <sashal@kernel.org>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc:     Valdis =?utf-8?Q?Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sasha Levin <alexander.levin@microsoft.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] staging: exfat: add exfat filesystem code to staging
Message-ID: <20200213211847.GA1734@sasha-vm>
References: <20190829205631.uhz6jdboneej3j3c@pali>
 <184209.1567120696@turing-police>
 <20190829233506.GT5281@sasha-vm>
 <20190830075647.wvhrx4asnkrfkkwk@pali>
 <20191016140353.4hrncxa5wkx47oau@pali>
 <20191016143113.GS31224@sasha-vm>
 <20191016160349.pwghlg566hh2o7id@pali>
 <20191016203317.GU31224@sasha-vm>
 <20191017075008.2uqgdimo3hrktj3i@pali>
 <20200213000656.hx5wdofkcpg7aoyo@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200213000656.hx5wdofkcpg7aoyo@pali>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 13, 2020 at 01:06:56AM +0100, Pali Rohár wrote:
>Hello!
>
>On Thursday 17 October 2019 09:50:08 Pali Rohár wrote:
>> On Wednesday 16 October 2019 16:33:17 Sasha Levin wrote:
>> > On Wed, Oct 16, 2019 at 06:03:49PM +0200, Pali Rohár wrote:
>> > > On Wednesday 16 October 2019 10:31:13 Sasha Levin wrote:
>> > > > On Wed, Oct 16, 2019 at 04:03:53PM +0200, Pali Rohár wrote:
>> > > > > On Friday 30 August 2019 09:56:47 Pali Rohár wrote:
>> > > > > > On Thursday 29 August 2019 19:35:06 Sasha Levin wrote:
>> > > > > > > With regards to missing specs/docs/whatever - our main concern with this
>> > > > > > > release was that we want full interoperability, which is why the spec
>> > > > > > > was made public as-is without modifications from what was used
>> > > > > > > internally. There's no "secret sauce" that Microsoft is hiding here.
>> > > > > >
>> > > > > > Ok, if it was just drop of "current version" of documentation then it
>> > > > > > makes sense.
>> > > > > >
>> > > > > > > How about we give this spec/code time to get soaked and reviewed for a
>> > > > > > > bit, and if folks still feel (in a month or so?) that there are missing
>> > > > > > > bits of information related to exfat, I'll be happy to go back and try
>> > > > > > > to get them out as well.
>> > > > >
>> > > > > Hello Sasha!
>> > > > >
>> > > > > Now one month passed, so do you have some information when missing parts
>> > > > > of documentation like TexFAT would be released to public?
>> > > >
>> > > > Sure, I'll see if I can get an approval to open it up.
>> > >
>> > > Ok!
>> > >
>> > > > Can I assume you will be implementing TexFAT support once the spec is
>> > > > available?
>> > >
>> > > I cannot promise that I would implement something which I do not know
>> > > how is working... It depends on how complicated TexFAT is and also how
>> > > future exfat support in kernel would look like.
>> > >
>> > > But I'm interesting in implementing it.
>> >
>> > It looks like the reason this wasn't made public along with the exFAT
>> > spec is that TexFAT is pretty much dead - it's old, there are no users
>> > we are aware of, and digging it out of it's grave to make it public is
>> > actually quite the headache.
>> >
>> > Is this something you actually have a need for? an entity that has a
>> > requirement for TexFAT?
>>
>> Hi!
>>
>> I do not have device with requirements for TexFAT. The first reason why
>> I wanted to use TexFAT was that it it the only way how to use more FAT
>> tables (e.g. secondary for backup) and information for that is missing
>> in released exFAT specification. This could bring better data recovery.
>>
>> > I'd would rather spend my time elsewhere than digging TexFAT out of it's grave.
>>
>> Ok.
>>
>> I was hoping that it would be possible to easily use secondary FAT table
>> (from TexFAT extension) for redundancy without need to implement full
>> TexFAT, which could be also backward compatible with systems which do
>> not implement TexFAT extension at all. Similarly like using FAT32 disk
>> with two FAT tables is possible also on system which use first FAT
>> table.
>
>By the chance, is there any possibility to release TexFAT specification?
>Usage of more FAT tables (even for Linux) could help with data recovery.

This would be a major pain in the arse to pull off (even more that
releasing exFAT itself) because TexFAT is effectively dead and no one
here cares about it. It's not even the case that there are devices which
are now left unsupported, the whole TexFAT scheme is just dead and gone.

Could I point you to the TexFAT patent instead
(https://patents.google.com/patent/US7613738B2/en)? It describes well
how TexFAT used to work.

>> > Is there anything else in the exFAT spec that is missing (and someone
>> > actually wants/uses)?
>>
>> Currently I do not know.
>
>I found one missing thing:
>
>In released exFAT specification is not written how are Unicode code
>points above U+FFFF represented in exFAT upcase table. Normally in
>UTF-16 are Unicode code points above U+FFFF represented by surrogate
>pairs but compression format of exFAT upcase table is not clear how to
>do it there.
>
>Are you able to send question about this problem to relevant MS people?
>
>New Linux implementation of exfat which is waiting on mailing list just
>do not support Unicode code points above U+FFFF in exFAT upcase table.

Sure, I'll forward this question on. I'll see if I can get someone from
their team who could be available to answer questions such as these in
the future - Microsoft is interested in maintaining compatiblity between
Linux and Windows exFAT implementations.

-- 
Thanks,
Sasha
