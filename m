Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0DEB715B5A8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Feb 2020 01:07:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729300AbgBMAG7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Feb 2020 19:06:59 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35475 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727117AbgBMAG7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Feb 2020 19:06:59 -0500
Received: by mail-wr1-f68.google.com with SMTP id w12so4537427wrt.2;
        Wed, 12 Feb 2020 16:06:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=O1BPoQAiHeJ08USRykHnfve8Vnu0iANnJABo4Mj2ZQI=;
        b=tj+mP1zAB0okAO0Qbox6Xr40Gl5RTa+LpO0tTucHh94zQmdcttrnjSmMPggZL7Omrb
         KMOQpssxKHuklM1GatXDJm/OIJ1Hj0hcl2w1gBsTG7XPXZrsUhXK0Qozxx4wLFVIiSuC
         U+oeBNUpHfdI+RxZg+rcxzbaus5JnNeWAUJaohS54mXtOJDT+jsI95qDeCvPsbQ0hEKY
         a2b6cXiLn7pWr58zqzByitCv3K7G02nmeNyZmTGT78Fs0zdIy2atCDnXto9ZTYIMWCQi
         nus08pk1xSiCZfN/FWJ/MF8z6qo5fIvCEmhg+mTxUFr5Q3faUkLvNnmsJy3REklo0F2T
         pyvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=O1BPoQAiHeJ08USRykHnfve8Vnu0iANnJABo4Mj2ZQI=;
        b=EsZnyryA5n7xQk9/2oQ/v1QYcRhuFxD7+rV9gkWCkLQhRO2LWCIQaptv2SunVwyyr6
         i7V7LCOYRiiDKeYCbgy1ll/46qXqe1D/7zdN0KzgIKfwLeO39lmGPXVwUUEXdjkpNfpO
         c5QbzM3o+Yl766d0UefyoFn2/tpZVHaqh6eNDry7HK2RHgNCs9tW56sEX3zbyRZB3AKr
         J6ktTrMVHbkv4u97sl0FoWf4O2SCEcLvS5Rm7LajNQr4EAPL4jZ6BCKl3Rr/zphBJfYC
         Qs2MbcXam0e6xj8t+WfM/VDY9zB5aLgacmt1/REp6ZPo3HExvTeCnYsdvVpfPl9NlyOY
         Wd4Q==
X-Gm-Message-State: APjAAAXHofPyf70m5Wi0Gjed5DVpJNHn6Ng58/wnFwIqqD0Sj0AflHTc
        fiUH/MfP3+UY5a/54cG+VHY=
X-Google-Smtp-Source: APXvYqzDTIe/LANGqzA7FtUhatpdgNkWPN6BGhpgz26N4uJtntPDqrvFQ8Zm6hEdzXfBDuOlod1mDQ==
X-Received: by 2002:adf:ffc5:: with SMTP id x5mr18300916wrs.92.1581552417568;
        Wed, 12 Feb 2020 16:06:57 -0800 (PST)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id z19sm504912wmi.43.2020.02.12.16.06.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2020 16:06:56 -0800 (PST)
Date:   Thu, 13 Feb 2020 01:06:56 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Sasha Levin <sashal@kernel.org>
Cc:     Valdis =?utf-8?Q?Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sasha Levin <alexander.levin@microsoft.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] staging: exfat: add exfat filesystem code to staging
Message-ID: <20200213000656.hx5wdofkcpg7aoyo@pali>
References: <20190828160817.6250-1-gregkh@linuxfoundation.org>
 <20190829205631.uhz6jdboneej3j3c@pali>
 <184209.1567120696@turing-police>
 <20190829233506.GT5281@sasha-vm>
 <20190830075647.wvhrx4asnkrfkkwk@pali>
 <20191016140353.4hrncxa5wkx47oau@pali>
 <20191016143113.GS31224@sasha-vm>
 <20191016160349.pwghlg566hh2o7id@pali>
 <20191016203317.GU31224@sasha-vm>
 <20191017075008.2uqgdimo3hrktj3i@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191017075008.2uqgdimo3hrktj3i@pali>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello!

On Thursday 17 October 2019 09:50:08 Pali Rohár wrote:
> On Wednesday 16 October 2019 16:33:17 Sasha Levin wrote:
> > On Wed, Oct 16, 2019 at 06:03:49PM +0200, Pali Rohár wrote:
> > > On Wednesday 16 October 2019 10:31:13 Sasha Levin wrote:
> > > > On Wed, Oct 16, 2019 at 04:03:53PM +0200, Pali Rohár wrote:
> > > > > On Friday 30 August 2019 09:56:47 Pali Rohár wrote:
> > > > > > On Thursday 29 August 2019 19:35:06 Sasha Levin wrote:
> > > > > > > With regards to missing specs/docs/whatever - our main concern with this
> > > > > > > release was that we want full interoperability, which is why the spec
> > > > > > > was made public as-is without modifications from what was used
> > > > > > > internally. There's no "secret sauce" that Microsoft is hiding here.
> > > > > >
> > > > > > Ok, if it was just drop of "current version" of documentation then it
> > > > > > makes sense.
> > > > > >
> > > > > > > How about we give this spec/code time to get soaked and reviewed for a
> > > > > > > bit, and if folks still feel (in a month or so?) that there are missing
> > > > > > > bits of information related to exfat, I'll be happy to go back and try
> > > > > > > to get them out as well.
> > > > >
> > > > > Hello Sasha!
> > > > >
> > > > > Now one month passed, so do you have some information when missing parts
> > > > > of documentation like TexFAT would be released to public?
> > > > 
> > > > Sure, I'll see if I can get an approval to open it up.
> > > 
> > > Ok!
> > > 
> > > > Can I assume you will be implementing TexFAT support once the spec is
> > > > available?
> > > 
> > > I cannot promise that I would implement something which I do not know
> > > how is working... It depends on how complicated TexFAT is and also how
> > > future exfat support in kernel would look like.
> > > 
> > > But I'm interesting in implementing it.
> > 
> > It looks like the reason this wasn't made public along with the exFAT
> > spec is that TexFAT is pretty much dead - it's old, there are no users
> > we are aware of, and digging it out of it's grave to make it public is
> > actually quite the headache.
> > 
> > Is this something you actually have a need for? an entity that has a
> > requirement for TexFAT?
> 
> Hi!
> 
> I do not have device with requirements for TexFAT. The first reason why
> I wanted to use TexFAT was that it it the only way how to use more FAT
> tables (e.g. secondary for backup) and information for that is missing
> in released exFAT specification. This could bring better data recovery.
> 
> > I'd would rather spend my time elsewhere than digging TexFAT out of it's grave.
> 
> Ok.
> 
> I was hoping that it would be possible to easily use secondary FAT table
> (from TexFAT extension) for redundancy without need to implement full
> TexFAT, which could be also backward compatible with systems which do
> not implement TexFAT extension at all. Similarly like using FAT32 disk
> with two FAT tables is possible also on system which use first FAT
> table.

By the chance, is there any possibility to release TexFAT specification?
Usage of more FAT tables (even for Linux) could help with data recovery.

> > Is there anything else in the exFAT spec that is missing (and someone
> > actually wants/uses)?
> 
> Currently I do not know.

I found one missing thing:

In released exFAT specification is not written how are Unicode code
points above U+FFFF represented in exFAT upcase table. Normally in
UTF-16 are Unicode code points above U+FFFF represented by surrogate
pairs but compression format of exFAT upcase table is not clear how to
do it there.

Are you able to send question about this problem to relevant MS people?

New Linux implementation of exfat which is waiting on mailing list just
do not support Unicode code points above U+FFFF in exFAT upcase table.

-- 
Pali Rohár
pali.rohar@gmail.com
