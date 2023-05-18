Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 091AD708442
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 May 2023 16:51:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231560AbjEROv3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 May 2023 10:51:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230429AbjEROv1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 May 2023 10:51:27 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB89AE0;
        Thu, 18 May 2023 07:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3mZIdjdwmGV3vHJtoYg7DQ3SuIOvMS80eB6u6Bs15tI=; b=EWIaLZzYUsB86gY+qMQv2bTjfz
        0XSwH+bXuzLuCc0p2ov+FjeIYjLd2uf3MUrNbldWzbM03hEpLLng6wxgHRw3nybERuKFuatxLiXCp
        sfhMlu2D9/m3OVJv54RC5iG1GWMPDvqsNVH3E+Gt25NAvE/q1gMNubVlU+d84ogJzdMlvfL0qBRMC
        8Gzgfp7m9Z1gXva3ESFU4MUy4tEqq6AIXedgYT/jcyYrx41/PWv7PIDWjvjgZH1QnAoyDLyQ4gfrB
        yPCNy1LL/wIRhVGtDSFR0kcSuGcwbJjQkBBJk6mhC0q6qnhyaV3kgpSwRk8ytw+PWTfySh60apdFv
        SMF/1R2g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pzeyQ-00DETE-2H;
        Thu, 18 May 2023 14:51:22 +0000
Date:   Thu, 18 May 2023 07:51:22 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>, corbet@lwn.net,
        jake@lwn.net, djwong@kernel.org, dchinner@redhat.com,
        ritesh.list@gmail.com, rgoldwyn@suse.com, jack@suse.cz,
        linux-doc@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        p.raghav@samsung.com, da.gomez@samsung.com, rohan.puri@samsung.com
Subject: Re: [PATCH] Documentation: add initial iomap kdoc
Message-ID: <ZGY7aumgDgU0jIK0@infradead.org>
References: <20230518144037.3149361-1-mcgrof@kernel.org>
 <ZGY61jQfExQc2j71@infradead.org>
 <ZGY7G8gIvWCi0ONT@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZGY7G8gIvWCi0ONT@bombadil.infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 18, 2023 at 07:50:03AM -0700, Luis Chamberlain wrote:
> On Thu, May 18, 2023 at 07:48:54AM -0700, Christoph Hellwig wrote:
> > > +**iomap** allows filesystems to query storage media for data using *byte ranges*. Since block
> > > +mapping are provided for a *byte ranges* for cache data in memory, in the page cache, naturally
> > 
> > Without fixing your line length I can't even read this mess..
> 
> I thought we are at 100?

Ony for individual lines and when it improves readability (whatever
that means).  But multiple to long lines, especially full of text
are completely unreadable in a terminal.
