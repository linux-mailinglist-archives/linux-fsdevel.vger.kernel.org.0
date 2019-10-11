Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1564BD400E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2019 14:57:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727907AbfJKM5g (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Oct 2019 08:57:36 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:38564 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727855AbfJKM5g (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Oct 2019 08:57:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=3teS1WMqAIK9N4oZ2ukn6IY9Aqbb8SHdv9W8ghsmLVY=; b=NLBL9xqesi2Uo4slNCpqUUrcL
        IR5M9tvouyIGU3/MA/3MO7VOwdL/D0lvLv7SNH0XEIoVSbHNjnmxrnS+/GkyRbESqhNORPjZWMsoM
        sDzpRSPzeisGchlVSC1zctnmDbJyI2Q5glX9x2OnQXuqWNOqHqu9DNn3KLAqbpYHupQQh/Rabx/7B
        U7CEPrzqd+DdXLlFURYqmKlv5nOQguv4U0MQrDYd3Q98I7U9PFD05RSi/JjtQQIh7ydAAaF9I6e+q
        fHaL8DUyZXGUeqMtjrRAg4ZbdS+l4lzLNaO+yGvwql3frb+8F2SCuAUEbExMNK4ziBKu83EpouJ+V
        xQH4CpScw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iIuUB-0001dH-DH; Fri, 11 Oct 2019 12:57:35 +0000
Date:   Fri, 11 Oct 2019 05:57:35 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Brian Foster <bfoster@redhat.com>
Cc:     Dave Chinner <david@fromorbit.com>, linux-xfs@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 04/26] xfs: Improve metadata buffer reclaim accountability
Message-ID: <20191011125735.GB13167@infradead.org>
References: <20191009032124.10541-1-david@fromorbit.com>
 <20191009032124.10541-5-david@fromorbit.com>
 <20191011123939.GD61257@bfoster>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191011123939.GD61257@bfoster>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 11, 2019 at 08:39:39AM -0400, Brian Foster wrote:
> Seems reasonable, but for inodes we also spread the ili zone. Should we
> not be consistent with bli's as well?

Btw, can we please kill off the stupid KM_ZONE_* flags?  We only use
each of them less than a hand ful of places, and they make reading the
code much harder.
