Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D0FB6558EC
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Dec 2022 08:23:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230222AbiLXHXk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 24 Dec 2022 02:23:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiLXHXj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 24 Dec 2022 02:23:39 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BC5E12AC8;
        Fri, 23 Dec 2022 23:23:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=csQpFt194NaQSHnEsZ8BPfgu8fkSSDQxFUuCGH0WoTU=; b=0cS81+MaLcw6kdaiRvmbxDyDRl
        em2V7cx6f/StYkcetqkbtWdwHkBXGI2u1DDEf0tX57hImyitsYSuEXr+696mLXBoZmohq+ITbPG5z
        Fy5G960ddclrcfB+ZX7oQe/jpM3JkuGvejbtNBzRm/NmBnCYGPM5UKPoUNRcc4X94vHplm4l28+V1
        HW6yvxLq1n7vPXp90ZKQX/iBNwWXmDZ7l3zuPftYj2m+F8poyvKrqpjnjEbQhcVpL5U7+Es0SJOqV
        qTSOavKYkiOwXjFev7LiJ7HXCV0k/SruDAs5ssDOv034autIQNzM2rw/+RnLbop7gsAivv5sfpQrW
        XhTcguAw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p8ysY-00FwUb-Bg; Sat, 24 Dec 2022 07:23:34 +0000
Date:   Fri, 23 Dec 2022 23:23:34 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Andreas =?iso-8859-1?Q?Gr=FCnbacher?= 
        <andreas.gruenbacher@gmail.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, cluster-devel@redhat.com
Subject: Re: [RFC v3 4/7] iomap: Add iomap_folio_prepare helper
Message-ID: <Y6ao9tiimcg/DFGl@infradead.org>
References: <20221216150626.670312-1-agruenba@redhat.com>
 <20221216150626.670312-5-agruenba@redhat.com>
 <Y6XDhb2IkNOdaT/t@infradead.org>
 <CAHpGcMLzTrn3ZUB4S8gjpz+aGj+R1hAu38m-PL5rVj-W-0G2ZA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHpGcMLzTrn3ZUB4S8gjpz+aGj+R1hAu38m-PL5rVj-W-0G2ZA@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Dec 23, 2022 at 10:05:05PM +0100, Andreas Grünbacher wrote:
> > I'd name this __iomap_get_folio to match __filemap_get_folio.
> 
> I was looking at it from the filesystem point of view: this helper is
> meant to be used in ->folio_prepare() handlers, so
> iomap_folio_prepare() seemed to be a better name than
> __iomap_get_folio().

Well, I think the right name for the methods that gets a folio is
probably ->folio_get anyway.
