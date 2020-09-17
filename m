Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69E1A26E6F0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Sep 2020 22:52:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726456AbgIQUwn convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Sep 2020 16:52:43 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:41570 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726180AbgIQUwn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Sep 2020 16:52:43 -0400
X-Greylist: delayed 346 seconds by postgrey-1.27 at vger.kernel.org; Thu, 17 Sep 2020 16:52:41 EDT
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id D044C6074023;
        Thu, 17 Sep 2020 22:46:53 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id b95lGeAHKEV9; Thu, 17 Sep 2020 22:46:53 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 465F4607403B;
        Thu, 17 Sep 2020 22:46:53 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id hHdZoVyeGGFV; Thu, 17 Sep 2020 22:46:53 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 139CF6074023;
        Thu, 17 Sep 2020 22:46:53 +0200 (CEST)
Date:   Thu, 17 Sep 2020 22:46:52 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        v9fs-developer@lists.sourceforge.net,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-afs@lists.infradead.org,
        ceph-devel <ceph-devel@vger.kernel.org>,
        linux-cifs@vger.kernel.org, ecryptfs@vger.kernel.org,
        linux-um <linux-um@lists.infradead.org>,
        linux-mtd <linux-mtd@lists.infradead.org>
Message-ID: <482280458.101023.1600375612958.JavaMail.zimbra@nod.at>
In-Reply-To: <20200917151050.5363-12-willy@infradead.org>
References: <20200917151050.5363-1-willy@infradead.org> <20200917151050.5363-12-willy@infradead.org>
Subject: Re: [PATCH 11/13] ubifs: Tell the VFS that readpage was synchronous
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF78 (Linux)/8.8.12_GA_3809)
Thread-Topic: ubifs: Tell the VFS that readpage was synchronous
Thread-Index: p/3vZsFlTtSUPnLB3kKvb/O8V+m25A==
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

----- Ursprüngliche Mail -----
> Von: "Matthew Wilcox" <willy@infradead.org>
> An: "linux-fsdevel" <linux-fsdevel@vger.kernel.org>
> CC: "Matthew Wilcox" <willy@infradead.org>, "linux-mm" <linux-mm@kvack.org>, v9fs-developer@lists.sourceforge.net,
> "linux-kernel" <linux-kernel@vger.kernel.org>, linux-afs@lists.infradead.org, "ceph-devel"
> <ceph-devel@vger.kernel.org>, linux-cifs@vger.kernel.org, ecryptfs@vger.kernel.org, "linux-um"
> <linux-um@lists.infradead.org>, "linux-mtd" <linux-mtd@lists.infradead.org>, "richard" <richard@nod.at>
> Gesendet: Donnerstag, 17. September 2020 17:10:48
> Betreff: [PATCH 11/13] ubifs: Tell the VFS that readpage was synchronous

> The ubifs readpage implementation was already synchronous, so use
> AOP_UPDATED_PAGE to avoid cycling the page lock.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
> fs/ubifs/file.c | 16 ++++++++++------
> 1 file changed, 10 insertions(+), 6 deletions(-)

For ubifs, jffs2 and hostfs:

Acked-by: Richard Weinberger <richard@nod.at>

Thanks,
//richard
