Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D84B5D9BDF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2019 22:33:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437212AbfJPUdU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Oct 2019 16:33:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:60666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2437191AbfJPUdU (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Oct 2019 16:33:20 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E813A21835;
        Wed, 16 Oct 2019 20:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571257999;
        bh=sQAsOokFGnvVh7DS3xyle/w6+XO8DmU7j1JEW0OM9Fo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XzJv7/wfqu3xTvxwOOLAHx9YgE0jusDtYf8bb0I8IMrUHsMrMlj4Q7lpfLy+Wxjjp
         F1Op02SgoaPr3iyJEAflgDFNGr9ja7Na9Nzm4hQfkhXgV6f7LpM4/1ekCf9Xm1Cd3i
         8PeRy74qwWNd9UkMoQw3SLDSA3n2pLGjFzo4oQ8w=
Date:   Wed, 16 Oct 2019 16:33:17 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc:     Valdis =?utf-8?Q?Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sasha Levin <alexander.levin@microsoft.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] staging: exfat: add exfat filesystem code to staging
Message-ID: <20191016203317.GU31224@sasha-vm>
References: <20190828160817.6250-1-gregkh@linuxfoundation.org>
 <20190829205631.uhz6jdboneej3j3c@pali>
 <184209.1567120696@turing-police>
 <20190829233506.GT5281@sasha-vm>
 <20190830075647.wvhrx4asnkrfkkwk@pali>
 <20191016140353.4hrncxa5wkx47oau@pali>
 <20191016143113.GS31224@sasha-vm>
 <20191016160349.pwghlg566hh2o7id@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191016160349.pwghlg566hh2o7id@pali>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 16, 2019 at 06:03:49PM +0200, Pali Rohár wrote:
>On Wednesday 16 October 2019 10:31:13 Sasha Levin wrote:
>> On Wed, Oct 16, 2019 at 04:03:53PM +0200, Pali Rohár wrote:
>> > On Friday 30 August 2019 09:56:47 Pali Rohár wrote:
>> > > On Thursday 29 August 2019 19:35:06 Sasha Levin wrote:
>> > > > With regards to missing specs/docs/whatever - our main concern with this
>> > > > release was that we want full interoperability, which is why the spec
>> > > > was made public as-is without modifications from what was used
>> > > > internally. There's no "secret sauce" that Microsoft is hiding here.
>> > >
>> > > Ok, if it was just drop of "current version" of documentation then it
>> > > makes sense.
>> > >
>> > > > How about we give this spec/code time to get soaked and reviewed for a
>> > > > bit, and if folks still feel (in a month or so?) that there are missing
>> > > > bits of information related to exfat, I'll be happy to go back and try
>> > > > to get them out as well.
>> >
>> > Hello Sasha!
>> >
>> > Now one month passed, so do you have some information when missing parts
>> > of documentation like TexFAT would be released to public?
>>
>> Sure, I'll see if I can get an approval to open it up.
>
>Ok!
>
>> Can I assume you will be implementing TexFAT support once the spec is
>> available?
>
>I cannot promise that I would implement something which I do not know
>how is working... It depends on how complicated TexFAT is and also how
>future exfat support in kernel would look like.
>
>But I'm interesting in implementing it.

It looks like the reason this wasn't made public along with the exFAT
spec is that TexFAT is pretty much dead - it's old, there are no users
we are aware of, and digging it out of it's grave to make it public is
actually quite the headache.

Is this something you actually have a need for? an entity that has a
requirement for TexFAT? I'd would rather spend my time elsewhere than
digging TexFAT out of it's grave.

Is there anything else in the exFAT spec that is missing (and someone
actually wants/uses)?

-- 
Thanks,
Sasha
