Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 486AA3D0CB3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jul 2021 13:09:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232908AbhGUJmL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Jul 2021 05:42:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:43158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238302AbhGUJMI (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Jul 2021 05:12:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5B23060200;
        Wed, 21 Jul 2021 09:52:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626861165;
        bh=VT9+LI6Lt+/7TVCfUKU9HBWfSnU57SlrgOAtOcc4KPU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BCnUbr8hgIZs98WK/QRCZiaT1C07yymWULH5upDie9k9ZMrwTzVI43BMnsJjdfDtf
         Y2gcpM2lCn4aHJI6oSQLbdCKAYvN2DeBe1B8CY/mMAPw8JhL00Jy7dZXTNG2MLo+M/
         q2j6lZDgJuooz1C2eT6A7Tl6IB8qqO6Xm+aBSYpXe75hT7hPljouf2gu1eWgVuNgHy
         KBMQmwoIqxeYSQdcpv2hj9nULGGIFvS9EBOiCJW65XWxKGgqjjkLGq1qajS49dXLLO
         jgCyNDqZQWzmnK3eXwJrVIkdNk3wu5LNLHuEZaMPH6pDjMeSNMQZg7Ngh1+AOTEPww
         5kZ/wvxPta97Q==
Date:   Wed, 21 Jul 2021 12:52:39 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v14 051/138] mm: Add folio_pfn()
Message-ID: <YPfuZ8WYFVRoChqe@kernel.org>
References: <20210715033704.692967-1-willy@infradead.org>
 <20210715033704.692967-52-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210715033704.692967-52-willy@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 15, 2021 at 04:35:37AM +0100, Matthew Wilcox (Oracle) wrote:
> This is the folio equivalent of page_to_pfn().
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  include/linux/mm.h | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)

Acked-by: Mike Rapoport <rppt@linux.ibm.com>
