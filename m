Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5F4D19B857
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Apr 2020 00:20:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733101AbgDAWUB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Apr 2020 18:20:01 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:43488 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732385AbgDAWUB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Apr 2020 18:20:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Cn/ndoIwzwK43LpR6SDiN0Eo3un+SI37/NqAeATzZdA=; b=WTskXwYClkflxWhu6scBAWo21K
        figHGRnz54kd7bZNx6lipvYypoSxX08cf0z0c7VeJqqJ3CtOKecwJisPzU8sUxAFUKOnLoqxD2OGG
        DuyQbWym7FOBnJdDjx5jl8hRPHPyvvgXXh8BWAohB3SFLyJqR+ckder+cvuJDf2eKoVMgI6QI0sPX
        7km/3OKPobqmRjagir1ygAIEdrcMvTJbl0+1nL5ZUZv1Hu6Z31H1vYbIpMSUinkCwlaqg8Tl5/JaO
        qAbQ0zYhvHki4ZhdeS0u8RNFzurFATm4PBqtsDh7m3haRFwDUJ+5HCKjOzgtRMJkJzEVcQVai6VFm
        D4ABlSyw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jJliK-0007eG-Vv; Wed, 01 Apr 2020 22:20:00 +0000
Date:   Wed, 1 Apr 2020 15:20:00 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Wei Yang <richard.weiyang@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/9] XArray: entry in last level is not expected to be a
 node
Message-ID: <20200401222000.GK21484@bombadil.infradead.org>
References: <20200330123643.17120-1-richard.weiyang@gmail.com>
 <20200330123643.17120-6-richard.weiyang@gmail.com>
 <20200330124842.GY22483@bombadil.infradead.org>
 <20200330141558.soeqhstone2liqud@master>
 <20200330142821.GD22483@bombadil.infradead.org>
 <20200331134208.gfkyym6n3gpgk3x3@master>
 <20200331164212.GC21484@bombadil.infradead.org>
 <20200331220440.roq4pv6wk7tq23gx@master>
 <20200331235912.GD21484@bombadil.infradead.org>
 <20200401221021.v6igvcpqyeuo2cws@master>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200401221021.v6igvcpqyeuo2cws@master>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 01, 2020 at 10:10:21PM +0000, Wei Yang wrote:
> On Tue, Mar 31, 2020 at 04:59:12PM -0700, Matthew Wilcox wrote:
> >On Tue, Mar 31, 2020 at 10:04:40PM +0000, Wei Yang wrote:
> >> cc -I. -I../../include -g -Og -Wall -D_LGPL_SOURCE -fsanitize=address -fsanitize=undefined   -c -o main.o main.c
> >> In file included from ./linux/../../../../include/linux/radix-tree.h:15,
> >>                  from ./linux/radix-tree.h:5,
> >>                  from main.c:10:
> >> ./linux/rcupdate.h:5:10: fatal error: urcu.h: No such file or directory
> >>     5 | #include <urcu.h>
> >>       |          ^~~~~~~~
> >> compilation terminated.
> >> make: *** [<builtin>: main.o] Error 1
> >
> >Oh, you need liburcu installed.  On Debian, that's liburcu-dev ... probably
> >liburcu-devel on Red Hat style distros.
> 
> The bad news is I didn't find the package on Fedora.

Really?  https://www.google.com/search?q=fedora+liburcu has the -devel
package as the second hit from https://pkgs.org/search/?q=liburcu
