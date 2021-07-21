Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 769E33D0C03
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jul 2021 12:13:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237252AbhGUJGn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Jul 2021 05:06:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:33520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237458AbhGUIvK (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Jul 2021 04:51:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9DDB76120C;
        Wed, 21 Jul 2021 09:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626859868;
        bh=DYecg8FPofJjrOsazwDJetR5J9b+C4k/9PSIGvZf4Fc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qY94IqcMXZ46tAAz3fKhubn7loYjnpzxPt0jd2nKCrJ4QIS6SOsxQgVYEvAIYXM2S
         MlzAut7IPNj/JrY7pX6eb/6rdsirbh69SBwloh3IAGLVk39q3mIUEWv3ccS07xKqUh
         rQTi03XwZPGxJ6OAxAvZpaKwtcszDRlN2urZeM+PK/EMT85xWmo4sivziS5AY96Si2
         smf9UuCGHGGKKNX0h1Xk/e4yGGyKI4Lz2kUPX9QV/I1ESIRXHAAtSepU/p5k68Xvg4
         +myLTXAp2pyemY4qNRZ+kfKkKg4IqnFf8zzjKaLPIfn381fNWTUL+HVLjp/aqrxn5x
         h8/IbcZtHpFOA==
Date:   Wed, 21 Jul 2021 12:31:03 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v14 033/138] mm: Add folio_nid()
Message-ID: <YPfpV9K7zV454+dj@kernel.org>
References: <20210715033704.692967-1-willy@infradead.org>
 <20210715033704.692967-34-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210715033704.692967-34-willy@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 15, 2021 at 04:35:19AM +0100, Matthew Wilcox (Oracle) wrote:
> This is the folio equivalent of page_to_nid().
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> ---
>  include/linux/mm.h | 5 +++++
>  1 file changed, 5 insertions(+)

Acked-by: Mike Rapoport <rppt@linux.ibm.com>
