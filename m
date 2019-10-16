Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B50A4D93E9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2019 16:31:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394067AbfJPObP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Oct 2019 10:31:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:57222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727167AbfJPObP (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Oct 2019 10:31:15 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 64E2E20650;
        Wed, 16 Oct 2019 14:31:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571236274;
        bh=tK6PEB/vdqs3D5dK7xuBVC/lJ+4FHfCBB+s4yE3ld+I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TkTD/cTAgZVUpecgbl5rcJGUqwspFVHGHQ85pwloVeiHDEP+ZjGU4NWtpoBNyPXN0
         xLdLRKj53+aT8+MFBw9Ib+vH1bZxV9DoT0DOdUukov23iaba3oOGlRmtL/GH+iMU2i
         cyVp5wcaxcov0DtfVkAkGiRWEP4B0p1voXlWsMF4=
Date:   Wed, 16 Oct 2019 10:31:13 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc:     Valdis =?utf-8?Q?Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sasha Levin <alexander.levin@microsoft.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] staging: exfat: add exfat filesystem code to staging
Message-ID: <20191016143113.GS31224@sasha-vm>
References: <20190828160817.6250-1-gregkh@linuxfoundation.org>
 <20190829205631.uhz6jdboneej3j3c@pali>
 <184209.1567120696@turing-police>
 <20190829233506.GT5281@sasha-vm>
 <20190830075647.wvhrx4asnkrfkkwk@pali>
 <20191016140353.4hrncxa5wkx47oau@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191016140353.4hrncxa5wkx47oau@pali>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 16, 2019 at 04:03:53PM +0200, Pali Rohár wrote:
>On Friday 30 August 2019 09:56:47 Pali Rohár wrote:
>> On Thursday 29 August 2019 19:35:06 Sasha Levin wrote:
>> > With regards to missing specs/docs/whatever - our main concern with this
>> > release was that we want full interoperability, which is why the spec
>> > was made public as-is without modifications from what was used
>> > internally. There's no "secret sauce" that Microsoft is hiding here.
>>
>> Ok, if it was just drop of "current version" of documentation then it
>> makes sense.
>>
>> > How about we give this spec/code time to get soaked and reviewed for a
>> > bit, and if folks still feel (in a month or so?) that there are missing
>> > bits of information related to exfat, I'll be happy to go back and try
>> > to get them out as well.
>
>Hello Sasha!
>
>Now one month passed, so do you have some information when missing parts
>of documentation like TexFAT would be released to public?

Sure, I'll see if I can get an approval to open it up.

Can I assume you will be implementing TexFAT support once the spec is
available?

-- 
Thanks,
Sasha
