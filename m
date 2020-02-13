Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF11515C068
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Feb 2020 15:34:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727511AbgBMOeg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Feb 2020 09:34:36 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:33908 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727414AbgBMOeg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Feb 2020 09:34:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=KjjQOSYaN0OsAxz1AYWuwCc8Awm7MXmiPSF9G+9HfOA=; b=WOHb9DMxHgk0Zii+JORq4vQLNZ
        38IO6hDSOQbqM5lPkG2oqepO/vxWUPN/s3u1z4fOkgqCzXKUrGcJZX3jECIJbueY6TuigsxtI1KNT
        5jEadu6G9+0+E4sosJIt84SbIvXN8hKECmkUW2RLxbMOaYoyWYpqovjsKF0WSWWzUwkDu0YXp6UXX
        brVTEfLZZXVYz6UactfF0BCx+MZO4efUjiNaDDSypF/lmfofuns/qoBIFs2Z7eoK0A2Xv8BpYHyQ+
        pX5NAXgJs4wFx8rID+jHcqYW0P23V5Q+jXprdZJ9KhcHxEnUqzXjh5Lozv0Gd2AAPrleRF4hXs3v+
        7Z3xf3hA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j2FZb-0001Bi-Qx; Thu, 13 Feb 2020 14:34:35 +0000
Date:   Thu, 13 Feb 2020 06:34:35 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 05/25] mm: Fix documentation of FGP flags
Message-ID: <20200213143435.GM7778@bombadil.infradead.org>
References: <20200212041845.25879-1-willy@infradead.org>
 <20200212041845.25879-6-willy@infradead.org>
 <20200213135905.wvpeiw7tyma75tsq@box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200213135905.wvpeiw7tyma75tsq@box>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 13, 2020 at 04:59:05PM +0300, Kirill A. Shutemov wrote:
> On Tue, Feb 11, 2020 at 08:18:25PM -0800, Matthew Wilcox wrote:
> > From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> > 
> > We never had PCG flags
> 
> We actually had :P But it's totally different story.
> 
> See git log for include/linux/page_cgroup.h.

Thanks, wording updated.
