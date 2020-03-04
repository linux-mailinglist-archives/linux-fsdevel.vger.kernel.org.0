Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4343A179AE2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Mar 2020 22:26:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388386AbgCDV0Y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Mar 2020 16:26:24 -0500
Received: from smtprelay0215.hostedemail.com ([216.40.44.215]:45176 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2388364AbgCDV0Y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Mar 2020 16:26:24 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 0BF45100E7B42;
        Wed,  4 Mar 2020 21:26:23 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 50,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:967:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1542:1593:1594:1711:1730:1747:1777:1792:2194:2199:2393:2525:2553:2561:2564:2682:2685:2693:2828:2859:2902:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3355:3622:3865:3866:3867:3868:3870:3871:3872:3873:3874:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4250:4321:5007:6119:7514:7903:7974:8985:9025:9108:10004:10400:10848:10967:11232:11658:11914:12043:12050:12296:12297:12555:12663:12740:12760:12895:12986:13161:13184:13229:13439:13618:13846:14096:14097:14181:14659:14721:21080:21325:21433:21451:21627:21740:21749:21811:21939:21972:30003:30054:30070:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: top47_1a6fca43cfd3c
X-Filterd-Recvd-Size: 3754
Received: from XPS-9350.home (unknown [47.151.143.254])
        (Authenticated sender: joe@perches.com)
        by omf18.hostedemail.com (Postfix) with ESMTPA;
        Wed,  4 Mar 2020 21:26:21 +0000 (UTC)
Message-ID: <ed040dd417d578e1ab4491d116c6ac1431142385.camel@perches.com>
Subject: Re: [PATCH] MAINTAINERS: adjust to filesystem doc ReST conversion
From:   Joe Perches <joe@perches.com>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 04 Mar 2020 13:24:48 -0800
In-Reply-To: <20200304212846.0c79c6da@coco.lan>
References: <20200304072950.10532-1-lukas.bulwahn@gmail.com>
         <20200304131035.731a3947@lwn.net> <20200304212846.0c79c6da@coco.lan>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 2020-03-04 at 21:28 +0100, Mauro Carvalho Chehab wrote:
> Em Wed, 4 Mar 2020 13:10:35 -0700
> Jonathan Corbet <corbet@lwn.net> escreveu:
> 
> > On Wed,  4 Mar 2020 08:29:50 +0100
> > Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:
> > 
> > > Mauro's patch series <cover.1581955849.git.mchehab+huawei@kernel.org>
> > > ("[PATCH 00/44] Manually convert filesystem FS documents to ReST")
> > > converts many Documentation/filesystems/ files to ReST.
> > > 
> > > Since then, ./scripts/get_maintainer.pl --self-test complains with 27
> > > warnings on Documentation/filesystems/ of this kind:
> > > 
> > >   warning: no file matches F: Documentation/filesystems/...
> > > 
> > > Adjust MAINTAINERS entries to all files converted from .txt to .rst in the
> > > patch series and address the 27 warnings.
> > > 
> > > Link: https://lore.kernel.org/linux-erofs/cover.1581955849.git.mchehab+huawei@kernel.org
> > > Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> > > ---
> > > Mauro, please ack.
> > > Jonathan, pick pick this patch for doc-next.  
> > 
> > Sigh, I need to work a MAINTAINERS check into my workflow...
> > 
> > Thanks for fixing these, but ... what tree did you generate the patch
> > against?  I doesn't come close to applying to docs-next.
> 
> I'm starting to suspect that maybe the best workflow would be to just 
> apply the patches at docs-next keeping links broken, and then run
> ./scripts/documentation-file-ref-check --fix by the end of a merge
> window, addressing such breakages.

I'm not sure at all that that script will always do the
right thing with MAINTAINERS, but it seems to work OK
except for some renames where a .txt file was directly
renamed to a .rst file in the same directory where there
was a similarly named file in a different directory.

Likely the direct rename of a filename extension from
.txt to .rst should always be applied by the script.

Anyway, for -next as of today:

$ git diff --shortstat
 64 files changed, 116 insertions(+), 116 deletions(-)

> There are usually lots of churn outside the merge window.
> 
> Another alternative would be to split the MAINTAINERS file on a
> per-subsystem basis. If I remember well, someone proposed this once at
> LKML. I vaguely remember that there were even a patch (or RFC)
> adding support for such thing for get_maintainers.pl.

Yeah.  get_maintainer.pl does work if the MAINTAINERS
file is split up a few different ways.

There was also a tool to do the MAINTAINERS split.
https://lore.kernel.org/patchwork/patch/817857/

I doubt that would matter at all given today's tools and
the general mechanisms of maintainers renaming files and
not running checkpatch in the first place.


