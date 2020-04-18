Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 305561AF3EA
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Apr 2020 20:56:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728079AbgDRS4E (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 18 Apr 2020 14:56:04 -0400
Received: from smtprelay0197.hostedemail.com ([216.40.44.197]:59352 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726086AbgDRS4D (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 18 Apr 2020 14:56:03 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id BBBA618018500;
        Sat, 18 Apr 2020 18:56:01 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:152:355:379:599:800:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1431:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2553:2559:2562:2895:3138:3139:3140:3141:3142:3353:3622:3865:3868:3870:3871:3874:4321:5007:6119:6742:6743:7875:7903:10004:10400:10848:11026:11232:11658:11914:12043:12296:12297:12555:12740:12895:12986:13069:13311:13357:13894:14096:14097:14181:14659:14721:21080:21451:21627:21660:21740:30054:30060:30064:30070:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:14,LUA_SUMMARY:none
X-HE-Tag: money21_1707d78e8f515
X-Filterd-Recvd-Size: 3611
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf03.hostedemail.com (Postfix) with ESMTPA;
        Sat, 18 Apr 2020 18:55:58 +0000 (UTC)
Message-ID: <6c796219ea79d87093409f2dd1d3bf8e4a157ed7.camel@perches.com>
Subject: Re: [PATCH 6/9] nfsd: fix empty-body warning in nfs4state.c
From:   Joe Perches <joe@perches.com>
To:     Chuck Lever <chuck.lever@oracle.com>,
        Randy Dunlap <rdunlap@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, Bruce Fields <bfields@fieldses.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>, linux-nvdimm@lists.01.org,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        Zzy Wysm <zzy@zzywysm.com>
Date:   Sat, 18 Apr 2020 11:53:44 -0700
In-Reply-To: <CDCF7717-7CBC-47CA-9E83-3A18ECB3AB89@oracle.com>
References: <20200418184111.13401-1-rdunlap@infradead.org>
         <20200418184111.13401-7-rdunlap@infradead.org>
         <CDCF7717-7CBC-47CA-9E83-3A18ECB3AB89@oracle.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, 2020-04-18 at 14:45 -0400, Chuck Lever wrote:
> > On Apr 18, 2020, at 2:41 PM, Randy Dunlap <rdunlap@infradead.org> wrote:
> > 
> > Fix gcc empty-body warning when -Wextra is used:
> > 
> > ../fs/nfsd/nfs4state.c:3898:3: warning: suggest braces around empty body in an ‘else’ statement [-Wempty-body]
> > 
> > Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> > Cc: Linus Torvalds <torvalds@linux-foundation.org>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: "J. Bruce Fields" <bfields@fieldses.org>
> > Cc: Chuck Lever <chuck.lever@oracle.com>
> > Cc: linux-nfs@vger.kernel.org
> 
> I have a patch in my queue that addresses this particular warning,
> but your change works for me too.
> 
> Acked-by: Chuck Lever <chuck.lever@oracle.com>
> 
> Unless Bruce objects.
> 
> 
> > ---
> > fs/nfsd/nfs4state.c |    3 ++-
> > 1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > --- linux-next-20200417.orig/fs/nfsd/nfs4state.c
> > +++ linux-next-20200417/fs/nfsd/nfs4state.c
> > @@ -34,6 +34,7 @@
> > 
> > #include <linux/file.h>
> > #include <linux/fs.h>
> > +#include <linux/kernel.h>
> > #include <linux/slab.h>
> > #include <linux/namei.h>
> > #include <linux/swap.h>
> > @@ -3895,7 +3896,7 @@ nfsd4_setclientid(struct svc_rqst *rqstp
> > 		copy_clid(new, conf);
> > 		gen_confirm(new, nn);
> > 	} else /* case 4 (new client) or cases 2, 3 (client reboot): */
> > -		;
> > +		do_empty();
> > 	new->cl_minorversion = 0;
> > 	gen_callback(new, setclid, rqstp);
> > 	add_to_unconfirmed(new);

This empty else seems silly and could likely be better handled by
a comment above the first if, something like:

	/* for now only handle case 1: probable callback update */
	if (conf && same_verf(&conf->cl_verifier, &clverifier)) {
		copy_clid(new, conf);
		gen_confirm(new, nn);
	}

with no else use.


