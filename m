Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56B3D1F7C10
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jun 2020 19:04:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726577AbgFLREc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Jun 2020 13:04:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726290AbgFLREb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Jun 2020 13:04:31 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8AE5C03E96F;
        Fri, 12 Jun 2020 10:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=qjz2DxxHjX1AszTx5TAMHcOt/ERrUE8Sugt/lsPH6Xc=; b=Vj26xR7ZuawPvLWBqn3Dp7Z/mB
        foePpiqYcNhO/KOnBf/9iVcaLzEmkioc4Vm9ZD1wyER2Zzvq5pUWbKqqXFLQJcL+aGKSiVn8GQEOQ
        dKHKcTEMFs/Oisp9/YgzxjMle8ejH68iA5Wwye7yq20NCS5mtAUPpCLK9QFQ0h8kKRTJFhNqOBxTk
        65Elfcmjbp3UkrHCBikiH8bgGRkwpzVrlrehDRPnO//TfYrLCQa0d7a67Di4dTtogpUVDnrR1OTTQ
        xaZwNSkUE7I2J2OLiQosgQKBmF5Z5aI26Ty87WT2jjjf41RN5tExvTYvqc1I+f8lHFO4cZfcRYHMv
        ajEoWyOQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jjn6V-00048n-8I; Fri, 12 Jun 2020 17:04:31 +0000
Date:   Fri, 12 Jun 2020 10:04:31 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     Kaitao Cheng <pilgrimtao@gmail.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Colin Ian King <colin.king@canonical.com>,
        Muchun Song <songmuchun@bytedance.com>
Subject: Re: [PATCH v2] proc/fd: Remove unnecessary variable initialisations
 in seq_show()
Message-ID: <20200612170431.GG8681@bombadil.infradead.org>
References: <20200612160946.21187-1-pilgrimtao@gmail.com>
 <7fdada40-370d-37b3-3aab-bfbedaa1804f@web.de>
 <20200612170033.GF8681@bombadil.infradead.org>
 <80794080-138f-d015-39df-36832e9ab5d4@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <80794080-138f-d015-39df-36832e9ab5d4@web.de>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 12, 2020 at 07:03:49PM +0200, Markus Elfring wrote:
> >>> 'files' will be immediately reassigned. 'f_flags' and 'file' will be
> >>> overwritten in the if{} or seq_show() directly exits with an error.
> >>> so we don't need to consume CPU resources to initialize them.
> >>
> >> I suggest to improve also this change description.
> >>
> >> * Should the mentioned identifiers refer to variables?
> >>
> >> * Will another imperative wording be preferred?
> >>   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?id=b791d1bdf9212d944d749a5c7ff6febdba241771#n151
> >>
> >> * I propose to extend the patch a bit more.
> >>   How do you think about to convert the initialisation for the variable “ret”
> >>   also into a later assignment?
> >
> > Please stop commenting on people's changelogs.  You add no value.
> 
> Would you like to clarify concrete software development ideas?

Yes.  Learn something deeply, then your opinion will have value.
