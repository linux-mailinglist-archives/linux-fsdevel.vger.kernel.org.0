Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2CB3582B52
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2019 07:57:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731559AbfHFF5p (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Aug 2019 01:57:45 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:53058 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725798AbfHFF5p (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Aug 2019 01:57:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=j0OFKi5V39Sb3bwFscefMidUs4ndmFs7fX33s9yMejs=; b=pw3U34ipSoi9mKxJ+NTSLNOpA
        3R9rRO1geSBe8FhsxEk3T35Kkym3drbjhCVyzim8ThIbjxbAc/78UWCaDTPQKd/Pd7Dck2onQudus
        1jQ/iOPsn3qyvjHwAWCz89EV/ZEXwZCcoaI7YvFaw4KrbRlTrkNjoTZkWQuYcCarnGqKBj5tLVw8o
        buRfPdQ8urHHzBWIp9ihvwZmINpmRjn9bKx7xMbPE2cbev2S9NIC7LHzm70w7PgSe5K2RrkYD4m/x
        Q29yhVu4rRX0hVv7gO794blvA9G9mArOjgRsTNkTH5gTfOzfeNlw5RGdyWpzgD6fsLJ5mck/jWPvb
        +K5HvAbYQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1husTg-0000yA-VN; Tue, 06 Aug 2019 05:57:44 +0000
Date:   Mon, 5 Aug 2019 22:57:44 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [RFC] [PATCH 00/24] mm, xfs: non-blocking inode reclaim
Message-ID: <20190806055744.GC25736@infradead.org>
References: <20190801021752.4986-1-david@fromorbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190801021752.4986-1-david@fromorbit.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Dave,

do you have a git tree available to look over the whole series?
