Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 039802680D9
	for <lists+linux-fsdevel@lfdr.de>; Sun, 13 Sep 2020 20:44:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726015AbgIMSn6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 13 Sep 2020 14:43:58 -0400
Received: from smtprelay0206.hostedemail.com ([216.40.44.206]:60586 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725949AbgIMSnz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 13 Sep 2020 14:43:55 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 39ABE9888;
        Sun, 13 Sep 2020 18:43:53 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:152:355:379:599:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1540:1568:1593:1594:1711:1714:1730:1747:1777:1792:2393:2559:2562:3138:3139:3140:3141:3142:3622:3653:3866:3870:3873:4250:4321:4605:5007:6117:6119:8660:10004:10400:10848:11026:11232:11658:11914:12043:12297:12438:12683:12740:12895:13019:13069:13148:13230:13311:13357:13894:14181:14659:14721:21080:21451:21627:21939:30054:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: brush59_2c0c5bc27102
X-Filterd-Recvd-Size: 1946
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf08.hostedemail.com (Postfix) with ESMTPA;
        Sun, 13 Sep 2020 18:43:51 +0000 (UTC)
Message-ID: <d1dc86f2792d3e64d1281fc2b5fddaca5fa17b5a.camel@perches.com>
Subject: Re: [PATCH v5 03/10] fs/ntfs3: Add bitmap
From:   Joe Perches <joe@perches.com>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        linux-fsdevel@vger.kernel.org
Cc:     viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
        pali@kernel.org, dsterba@suse.cz, aaptel@suse.com,
        willy@infradead.org, rdunlap@infradead.org, mark@harmstone.com,
        nborisov@suse.com
Date:   Sun, 13 Sep 2020 11:43:50 -0700
In-Reply-To: <20200911141018.2457639-4-almaz.alexandrovich@paragon-software.com>
References: <20200911141018.2457639-1-almaz.alexandrovich@paragon-software.com>
         <20200911141018.2457639-4-almaz.alexandrovich@paragon-software.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 2020-09-11 at 17:10 +0300, Konstantin Komarov wrote:
> This adds bitmap

$ make fs/ntfs3/
  SYNC    include/config/auto.conf.cmd
  CALL    scripts/checksyscalls.sh
  CALL    scripts/atomic/check-atomics.sh
  DESCEND  objtool
  CC      fs/ntfs3/bitfunc.o
  CC      fs/ntfs3/bitmap.o
fs/ntfs3/bitmap.c: In function ‘wnd_rescan’:
fs/ntfs3/bitmap.c:556:4: error: implicit declaration of function ‘page_cache_readahead_unbounded’; did you mean ‘page_cache_ra_unbounded’? [-Werror=implicit-function-declaration]
  556 |    page_cache_readahead_unbounded(
      |    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      |    page_cache_ra_unbounded
cc1: some warnings being treated as errors
make[2]: *** [scripts/Makefile.build:283: fs/ntfs3/bitmap.o] Error 1
make[1]: *** [scripts/Makefile.build:500: fs/ntfs3] Error 2
make: *** [Makefile:1792: fs] Error 2



