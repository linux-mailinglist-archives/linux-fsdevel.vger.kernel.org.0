Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0031819A2AF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Apr 2020 01:59:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731579AbgCaX7M (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 31 Mar 2020 19:59:12 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:37082 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731470AbgCaX7M (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 31 Mar 2020 19:59:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=DATbq8Z9XaQxpnxF+/qBI3Pq2poGmIJLp4uomGvU1I8=; b=sWVw0rKiUHxWiQdi67l4spDG4q
        pCxj7Pnans4Sq/7rkoUA6nk6zC7cp1uVerzfcVrNCQ76EBiG5ndtZkgNvkd2CnC3Qa4SEkF6wNL19
        DWpaS3sp51wro5vZj8rKSLMPtNTPgnliWe6ewPIaqkQKI99D/dlSfl9dtyZ79eCTUL+mBMwhDXe2G
        Jl6JtpglN24zC19Nrt+hlDn9M9P1ybFyYAIe/1WEl7/NxHOMuIfVMJiROQILKWYqb32h5xC69HkzP
        H5Ic+hhn+ahDg6pM65Fk1lyFQ0jjIEFw5Rx3SIFFen42LtD05Xkq3OSopShm2qvEugg63DlxZkwQj
        C0+nWMEw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jJQmm-0003ZF-6M; Tue, 31 Mar 2020 23:59:12 +0000
Date:   Tue, 31 Mar 2020 16:59:12 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Wei Yang <richard.weiyang@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/9] XArray: entry in last level is not expected to be a
 node
Message-ID: <20200331235912.GD21484@bombadil.infradead.org>
References: <20200330123643.17120-1-richard.weiyang@gmail.com>
 <20200330123643.17120-6-richard.weiyang@gmail.com>
 <20200330124842.GY22483@bombadil.infradead.org>
 <20200330141558.soeqhstone2liqud@master>
 <20200330142821.GD22483@bombadil.infradead.org>
 <20200331134208.gfkyym6n3gpgk3x3@master>
 <20200331164212.GC21484@bombadil.infradead.org>
 <20200331220440.roq4pv6wk7tq23gx@master>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200331220440.roq4pv6wk7tq23gx@master>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 31, 2020 at 10:04:40PM +0000, Wei Yang wrote:
> cc -I. -I../../include -g -Og -Wall -D_LGPL_SOURCE -fsanitize=address -fsanitize=undefined   -c -o main.o main.c
> In file included from ./linux/../../../../include/linux/radix-tree.h:15,
>                  from ./linux/radix-tree.h:5,
>                  from main.c:10:
> ./linux/rcupdate.h:5:10: fatal error: urcu.h: No such file or directory
>     5 | #include <urcu.h>
>       |          ^~~~~~~~
> compilation terminated.
> make: *** [<builtin>: main.o] Error 1

Oh, you need liburcu installed.  On Debian, that's liburcu-dev ... probably
liburcu-devel on Red Hat style distros.
