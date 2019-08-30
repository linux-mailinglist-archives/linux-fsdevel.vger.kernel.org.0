Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A0E9A3632
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2019 14:04:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727521AbfH3MEi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Aug 2019 08:04:38 -0400
Received: from sonic312-23.consmr.mail.gq1.yahoo.com ([98.137.69.204]:43459
        "EHLO sonic312-23.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727410AbfH3MEi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Aug 2019 08:04:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1567166677; bh=3dnpKGsS+OuKzlzxbOlDQHhsBySeMNk6jgiZI/YORp4=; h=Date:From:To:Cc:Subject:References:In-Reply-To:From:Subject; b=o0X8nnr3IP6v52GpCtlks05j1+LcaEgdmvj6zrHlVWy/L+ZM6T/Tbp+Qjn9LRIgsNdmlR+PJHpLqvF65dzxnnXE3vvmSEUFhcCK3f8DbRDV8qexbecd7xb/YD81zDboZ/xnXfMFWwsZg7CXZj3F0VJBQlTxWo5hWrr8zrurWykG0TwouRw09+rnH2q7yQMIGzvwFn70Z37Q2BFtyg8j77XS0qIIV4IGYi4/y2wyWrVl8FqLvTDUT0qdiBljFdFpMTpmLhKEZwyAKopYorPSUJ+/FL093SuUhgn1jV7sKqGkLN9D45SAjDuxVXvye19JogHdzGzZ/p5orLDDZAABAfg==
X-YMail-OSG: tLGm94MVM1lgTkycx0A6Qp6pt1TMIWZWvvQHgABks2L_KU5hq5j0MBLAvm86FVm
 _PoQEcB0IDeYv7JwOX9IrtYEnHiOGk6LfY0NbUmzWFAZOAyzBwhpRLNyySTrLuZyG1lKnc1SNucU
 DC.JLja.Dvf5KkeSZCGjJfsS3rC3t2q5w0JcPa.LyALbosKFQs_kQpIw8TtiA4FjOWE2j7gNJ0Ly
 7LfifrdQK1bvU0Kng3RgGo7WPUZD1fz9clYnzyto85QaBiAqySg.HUL_KdjILEt95egseUsXv2zF
 scQiG9PNhp.dHKfzATZesJ4ONNk1UqdaqtnIAJsABjPFuM1l6OzMykrn8hE8I3D4G64Y2jfHQMlA
 zUUq212474oBOIEi62rcN2V2z4Lau9XwKE_09COyHeXbgunFps6HcNjnCMxStmhqyUDzZ6du9L0t
 sSjAv7b85f34QjSjjGW9r_5Pe2J2AukSNXgyerZZXD3ckuehjrqDUZi84AdURZdLuzLLMkjRnLrS
 JBH7WFQti24pjL.brQiwlwB_s4TWR6pcJi1RTMwJTC_uueswZRH_RCWT47kYIW.98Ccxdi2tZmXA
 cJWZKkettpegBEk9YF3jzetclqEMO2OcflVVRF16D65K2B99LboFX9Osn2SGd3h6tGjrEKyUmnkl
 IlpaCjHD9.VIqKRuYCteRnP5V4b9fOkDGKQzVSMjyPkPds6jNtuffqX8d.Nhtiz4J18.14NTURdD
 YzBZsshxjlv3mvb3ooXKvxKsntlzUa5ZInINO43G6LFliOpDpNNhIV1JMTvSG8aN5WLqReOJeX1h
 U1_uF1X0gbbMVgW8XR8SmTZPl5fCaQMHsqRqsP7neiUSTV13jebXyEOD7qmKqo_FNp1E.R4lNFXC
 lZIo0VUaUOdBNHslkLHo5yIsUxiWBNwSmOI8ANqTIsAgBeFk0WNbuDZTMTBM4KmtVLHYDH.NF0ok
 XWDMCaoWuAOmovgPYnPY2PoghauA3q2QLP3HTIINQUa9JSEAMeD1jyOwmprcRXlx2NkE1nrDAMaD
 pSLekSp27R7uOGI7lN6OP6qSol.yndelbJJTZ9UPsd61zuiyE79fx8M2MyXi2srBYzJ1kgRtAOJ.
 p.CGDu3LXRrQw0mvXU8D2ax5PfJy8wy0C9e.Jx4.tnROvSVm0CPbKZ_3H6ZzlatvgwcxfZYiqUKS
 goASo8RToc2WLr6CbFmg8nmtRt9PxupcSNrXbdEjOVeRwO.HCi7RJQcgLYQu7bmieAjP6q1GbCrg
 cEqdErOMY9iUJkSRoqdKzkfr3Z6vi7hs-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic312.consmr.mail.gq1.yahoo.com with HTTP; Fri, 30 Aug 2019 12:04:37 +0000
Received: by smtp428.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 7ab41f8c227fcd099f8ed0410cccad50;
          Fri, 30 Aug 2019 12:04:33 +0000 (UTC)
Date:   Fri, 30 Aug 2019 20:04:20 +0800
From:   Gao Xiang <hsiangkao@aol.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Gao Xiang <gaoxiang25@huawei.com>, devel@driverdev.osuosl.org,
        Christoph Hellwig <hch@infradead.org>,
        Valdis =?gbk?Q?Kl=A8=A5tnieks?= <valdis.kletnieks@vt.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Sasha Levin <alexander.levin@microsoft.com>,
        linux-fsdevel@vger.kernel.org,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Subject: Re: [PATCH] staging: exfat: add exfat filesystem code to staging
Message-ID: <20190830120419.GB10981@hsiangkao-HP-ZHAN-66-Pro-G1>
References: <20190829103749.GA13661@infradead.org>
 <20190829111810.GA23393@kroah.com>
 <20190829151144.GJ23584@kadam>
 <20190829152757.GA125003@architecture4>
 <20190829154346.GK23584@kadam>
 <20190829155127.GA136563@architecture4>
 <20190829160441.GA141079@architecture4>
 <20190830083445.GL23584@kadam>
 <20190830084333.GA193084@architecture4>
 <20190830112612.GF8372@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190830112612.GF8372@kadam>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Dan,

On Fri, Aug 30, 2019 at 02:26:12PM +0300, Dan Carpenter wrote:
> On Fri, Aug 30, 2019 at 04:43:33PM +0800, Gao Xiang wrote:
> > Hi Dan,
> > 
> > On Fri, Aug 30, 2019 at 11:34:45AM +0300, Dan Carpenter wrote:
> > > On Fri, Aug 30, 2019 at 12:04:41AM +0800, Gao Xiang wrote:
> > > > Anyway, I'm fine to delete them all if you like, but I think majority of these
> > > > are meaningful.
> > > > 
> > > > data.c-		/* page is already locked */
> > > > data.c-		DBG_BUGON(PageUptodate(page));
> > > > data.c-
> > > > data.c:		if (unlikely(err))
> > > > data.c-			SetPageError(page);
> > > > data.c-		else
> > > > data.c-			SetPageUptodate(page);
> > > 
> > > If we cared about speed here then we would delete the DBG_BUGON() check
> > > because that's going to be expensive.  The likely/unlikely annotations
> > > should be used in places a reasonable person thinks it will make a
> > > difference to benchmarks.
> > 
> > DBG_BUGON will be a no-op ((void)x) in non-debugging mode,
> 
> It expands to:
> 
> 	((void)PageUptodate(page));
> 
> Calling PageUptodate() doesn't do anything, but it isn't free.  The
> time it takes to do that function call completely negates any speed up
> from using likely/unlikely.
> 
> I'm really not trying to be a jerk...

You are right, I recalled that PageUptodate is not as simple as it implys.
Yes, those are all removed now... I am ok with that,
thanks for your suggestion :)

Thanks,
Gao Xiang

> 
> regards,
> dan carpenter
>
 
