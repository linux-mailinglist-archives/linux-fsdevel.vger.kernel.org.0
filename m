Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B98ADA6C2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2019 09:50:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731367AbfJQHuL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Oct 2019 03:50:11 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41913 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726372AbfJQHuL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Oct 2019 03:50:11 -0400
Received: by mail-wr1-f68.google.com with SMTP id p4so1129015wrm.8;
        Thu, 17 Oct 2019 00:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=oGjvr5hp9EJMVELthmx8VDqL9EDDYsUzQ79Pl9p8iWs=;
        b=d8XbFKyUcvle4NGbuJFQAXvY6UVGdxME8GBF7Wz0yfI03iL3MqQfFX93U4RhJKsr8i
         Cl/mDAVROC8vhtIC5nwLXsItKAXMLZehn626vrwy7Razi6vwp/7v07Q/KIrIkD1IF3/Z
         HGgckLS8BKF7C+R2tNucJsHCEENcee+2ZVqVrs5ZpVHdddzfBkr/57lRRlT0V4TUyoO0
         Nr9zHF1cTQk11nLX7nnOGzMFJ+VVOBDYwVb+EDHICvPG+UIS11RfBXzzf12mzzkFdrvj
         9QqVzEOap/cf27vs9JpJOIjLhbIOJlbdNo68UKqk0NHJ+wsOmCDz57EAh/DAHZrfUeqN
         l2lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=oGjvr5hp9EJMVELthmx8VDqL9EDDYsUzQ79Pl9p8iWs=;
        b=BNh+q3f6UvI6FZss0JNqyM4bpCV7l/C7fkFo696DlucGZOQQm3aBMq0P/Mwn2DyozD
         XfthXMk91DICzT4wzT873PwTK5hX47cpboxlEIQ2aaJAY/PNqWbcEb3mSUZG+fIbMRBN
         YHwb/B2jenbtZEK9ilxdGmGvE9Vw1wSOgZ2yjVCroksimKpbudIGuMAEOlbjlcc5gUwg
         qQKZV8mRu1kxMC5dZ5LQeCz7P17prhjA34FDD2NVYGsrcFEwAsIS1ybxXnsALpoDd9XH
         Vrw66ZWMHlo9ZGSyAKp8CVC2F+lJUP+bEdXHrLW+RDHUx7oVTrlgY17XQQESgRdvdlnJ
         AyqA==
X-Gm-Message-State: APjAAAVgJwdsul4a4+XHLwg3rFwhB/bSQeis4lai4M4X3NiKJenpjeny
        n2Fwp7pn5FlGfYBxRhjsERU=
X-Google-Smtp-Source: APXvYqxxiGQBlJy6UJiI0bKvNipvgqd2D7FO59gwJsgMZMN/WA60a3r82lazYwCSWHeFmn4TieY2Eg==
X-Received: by 2002:a5d:69c8:: with SMTP id s8mr1713270wrw.167.1571298609805;
        Thu, 17 Oct 2019 00:50:09 -0700 (PDT)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id u25sm1366158wml.4.2019.10.17.00.50.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 17 Oct 2019 00:50:08 -0700 (PDT)
Date:   Thu, 17 Oct 2019 09:50:08 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Sasha Levin <sashal@kernel.org>
Cc:     Valdis =?utf-8?Q?Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sasha Levin <alexander.levin@microsoft.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] staging: exfat: add exfat filesystem code to staging
Message-ID: <20191017075008.2uqgdimo3hrktj3i@pali>
References: <20190828160817.6250-1-gregkh@linuxfoundation.org>
 <20190829205631.uhz6jdboneej3j3c@pali>
 <184209.1567120696@turing-police>
 <20190829233506.GT5281@sasha-vm>
 <20190830075647.wvhrx4asnkrfkkwk@pali>
 <20191016140353.4hrncxa5wkx47oau@pali>
 <20191016143113.GS31224@sasha-vm>
 <20191016160349.pwghlg566hh2o7id@pali>
 <20191016203317.GU31224@sasha-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191016203317.GU31224@sasha-vm>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wednesday 16 October 2019 16:33:17 Sasha Levin wrote:
> On Wed, Oct 16, 2019 at 06:03:49PM +0200, Pali Rohár wrote:
> > On Wednesday 16 October 2019 10:31:13 Sasha Levin wrote:
> > > On Wed, Oct 16, 2019 at 04:03:53PM +0200, Pali Rohár wrote:
> > > > On Friday 30 August 2019 09:56:47 Pali Rohár wrote:
> > > > > On Thursday 29 August 2019 19:35:06 Sasha Levin wrote:
> > > > > > With regards to missing specs/docs/whatever - our main concern with this
> > > > > > release was that we want full interoperability, which is why the spec
> > > > > > was made public as-is without modifications from what was used
> > > > > > internally. There's no "secret sauce" that Microsoft is hiding here.
> > > > >
> > > > > Ok, if it was just drop of "current version" of documentation then it
> > > > > makes sense.
> > > > >
> > > > > > How about we give this spec/code time to get soaked and reviewed for a
> > > > > > bit, and if folks still feel (in a month or so?) that there are missing
> > > > > > bits of information related to exfat, I'll be happy to go back and try
> > > > > > to get them out as well.
> > > >
> > > > Hello Sasha!
> > > >
> > > > Now one month passed, so do you have some information when missing parts
> > > > of documentation like TexFAT would be released to public?
> > > 
> > > Sure, I'll see if I can get an approval to open it up.
> > 
> > Ok!
> > 
> > > Can I assume you will be implementing TexFAT support once the spec is
> > > available?
> > 
> > I cannot promise that I would implement something which I do not know
> > how is working... It depends on how complicated TexFAT is and also how
> > future exfat support in kernel would look like.
> > 
> > But I'm interesting in implementing it.
> 
> It looks like the reason this wasn't made public along with the exFAT
> spec is that TexFAT is pretty much dead - it's old, there are no users
> we are aware of, and digging it out of it's grave to make it public is
> actually quite the headache.
> 
> Is this something you actually have a need for? an entity that has a
> requirement for TexFAT?

Hi!

I do not have device with requirements for TexFAT. The first reason why
I wanted to use TexFAT was that it it the only way how to use more FAT
tables (e.g. secondary for backup) and information for that is missing
in released exFAT specification. This could bring better data recovery.

> I'd would rather spend my time elsewhere than digging TexFAT out of it's grave.

Ok.

I was hoping that it would be possible to easily use secondary FAT table
(from TexFAT extension) for redundancy without need to implement full
TexFAT, which could be also backward compatible with systems which do
not implement TexFAT extension at all. Similarly like using FAT32 disk
with two FAT tables is possible also on system which use first FAT
table.

> Is there anything else in the exFAT spec that is missing (and someone
> actually wants/uses)?

Currently I do not know.

-- 
Pali Rohár
pali.rohar@gmail.com
