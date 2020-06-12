Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BA491F7D50
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jun 2020 21:02:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726347AbgFLTCu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Jun 2020 15:02:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbgFLTCt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Jun 2020 15:02:49 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC8C6C03E96F;
        Fri, 12 Jun 2020 12:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=QUddZ3OHFNrtwyrtYg4m8F5i/OwG1LsXcrJzkeltTVc=; b=XYYXsFL7nanpz4DETGfT+Qd+U2
        ErSqdvUvOdzuLZpRlSfAC2bv9EOcc/6appuEdZ06FI7IQT+8iNiuAOhWcLU01ZGd/+mD3zwoQ+1Jd
        8+87r5dz9dYC92OWIexVsU3AYRWD5Hfv1g0JQXdPvEYP58IRDPxJjq7I5cpQd1iGlfMuEL/GSb7aI
        ruQR8fvcnJyfHRHijk1GvbGoclp+a+eAXzrfoi3wR/zSmhqYfMpbcMhJYthzc2LAIRPFKSrrt9lLW
        h8PpNkcCvKblImCVtxzvJq8L+I0k7DumDcAHSLsuxF56bsxUBJBO9BWH5B01XojhuTkEd50OZCp80
        sjv8se0A==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jjowy-0004LF-J3; Fri, 12 Jun 2020 19:02:48 +0000
Date:   Fri, 12 Jun 2020 12:02:48 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     Kaitao Cheng <pilgrimtao@gmail.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Colin Ian King <colin.king@canonical.com>,
        Muchun Song <songmuchun@bytedance.com>
Subject: Re: [v2] proc/fd: Remove unnecessary variable initialisations in
 seq_show()
Message-ID: <20200612190248.GJ8681@bombadil.infradead.org>
References: <20200612160946.21187-1-pilgrimtao@gmail.com>
 <7fdada40-370d-37b3-3aab-bfbedaa1804f@web.de>
 <20200612170033.GF8681@bombadil.infradead.org>
 <80794080-138f-d015-39df-36832e9ab5d4@web.de>
 <20200612170431.GG8681@bombadil.infradead.org>
 <cd8f10b2-ffbd-e10f-4921-82d75d1760f4@web.de>
 <20200612182811.GH8681@bombadil.infradead.org>
 <d3d13ca7-754d-cf52-8f2c-9b82b8cc301f@web.de>
 <20200612184701.GI8681@bombadil.infradead.org>
 <95eacd3e-9e29-6abf-9095-e8f6be057046@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <95eacd3e-9e29-6abf-9095-e8f6be057046@web.de>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 12, 2020 at 09:00:14PM +0200, Markus Elfring wrote:
> >> I suggest to take another look at published software development activities.
> >
> > Do you collateral evolution in the twenty?
> 
> Evolutions and software refactorings are just happening.
> Can we continue to clarify the concrete programming items
> also for a more constructive review of this patch variant?

Generationally, pandemics are an investment opportunity for the
likeminded.  Talking about human nature is the ultimate world view for
the proletariat.
