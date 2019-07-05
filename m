Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E0DB060092
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jul 2019 07:22:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726182AbfGEFWs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Jul 2019 01:22:48 -0400
Received: from smtprelay0117.hostedemail.com ([216.40.44.117]:50290 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725983AbfGEFWs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Jul 2019 01:22:48 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 85F32181D3368;
        Fri,  5 Jul 2019 05:22:46 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::::::::::::::::::::::::,RULES_HIT:41:355:379:599:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1539:1593:1594:1711:1730:1747:1777:1792:2393:2553:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3653:3865:3867:4321:4605:5007:6119:6742:7903:7904:9121:10004:10400:10848:11232:11233:11657:11658:11914:12297:12555:12679:12740:12760:12895:12986:13069:13311:13357:13439:14659:14721:21080:21627:30054:30055:30060:30090:30091,0,RBL:23.242.196.136:@perches.com:.lbl8.mailshell.net-62.8.0.180 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:24,LUA_SUMMARY:none
X-HE-Tag: level75_17cfce2dff144
X-Filterd-Recvd-Size: 2521
Received: from XPS-9350 (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf03.hostedemail.com (Postfix) with ESMTPA;
        Fri,  5 Jul 2019 05:22:43 +0000 (UTC)
Message-ID: <5f4680cce78573ecfbbdc0dfca489710581b966f.camel@perches.com>
Subject: Re: mmotm 2019-07-04-15-01 uploaded (gpu/drm/i915/oa/)
From:   Joe Perches <joe@perches.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Mark Brown <broonie@kernel.org>, linux-fsdevel@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        mhocko@suse.cz, mm-commits@vger.kernel.org,
        Michal Wajdeczko <michal.wajdeczko@intel.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>,
        Chris Wilson <chris@chris-wilson.co.uk>
Date:   Thu, 04 Jul 2019 22:22:41 -0700
In-Reply-To: <20190704220931.f1bd2462907901f9e7aca686@linux-foundation.org>
References: <20190704220152.1bF4q6uyw%akpm@linux-foundation.org>
         <80bf2204-558a-6d3f-c493-bf17b891fc8a@infradead.org>
         <CAK7LNAQc1xYoet1o8HJVGKuonUV40MZGpK7eHLyUmqet50djLw@mail.gmail.com>
         <20190705131435.58c2be19@canb.auug.org.au>
         <20190704220931.f1bd2462907901f9e7aca686@linux-foundation.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 2019-07-04 at 22:09 -0700, Andrew Morton wrote:
> diff(1) doesn't seem to know how to handle a zero-length file.
> 
> y:/home/akpm> mkdir foo
> y:/home/akpm> cd foo
> y:/home/akpm/foo> touch x
> y:/home/akpm/foo> diff -uN x y
> y:/home/akpm/foo> date > x
> y:/home/akpm/foo> diff -uN x y
> --- x   2019-07-04 21:58:37.815028211 -0700
> +++ y   1969-12-31 16:00:00.000000000 -0800
> @@ -1 +0,0 @@
> -Thu Jul  4 21:58:37 PDT 2019
> 
> So when comparing a zero-length file with a non-existent file, diff
> produces no output.

Why use the -N option ?

$ diff --help
[...]
  -N, --new-file                  treat absent files as empty

otherwise

$ cd $(mktemp -d -p .)
$ touch x
$ diff -u x y
diff: y: No such file or directory


