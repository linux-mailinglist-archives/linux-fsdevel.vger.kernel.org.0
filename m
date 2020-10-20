Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D03EE29361B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Oct 2020 09:53:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405475AbgJTHxP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Oct 2020 03:53:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728676AbgJTHxO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Oct 2020 03:53:14 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F807C061755;
        Tue, 20 Oct 2020 00:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ClWPa4AkLnnBnYkDIyiYUv/9clx3J7jmiEl5C8bh0VM=; b=LdPWmfbS1LtE/LHhG7DtxoOFuI
        cltHDUTqFsQ1MQvZyFVvtOyK/gTUkyWHi/TWI41pmu4myCdTCVh/9ZzRLt21vBwLmvlxd4ZTktnZx
        k9JhbxkG04ZSHbzwO/S8KWO5tcN2BBJlgsvAyi2dKtVIkja9jahd5goiPi0X+1JFo1OMJPzzJw+sf
        FRIrbxCB8HgimHx0AzkHgATOSMorXHEbCqH12XjGNE1BKxQo68xxl8yzV6HIJ3shsdSApJRlbRnjz
        dXvPQgwexYdxJ999PdRjdUv+iZZwtSHtsUfw2ldJLECWo16+N9zrcJGZjZeH62/bZEDa1FBgi051z
        7YEx4PpA==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kUmSB-0004se-3w; Tue, 20 Oct 2020 07:53:07 +0000
Date:   Tue, 20 Oct 2020 08:53:07 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     torvalds@linux-foundation.org, Takashi Iwai <tiwai@suse.de>,
        dwysocha@redhat.com, linux-kernel@vger.kernel.org,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-afs@lists.infradead.org
Subject: Re: [PATCH] cachefiles: Drop superfluous readpages aops NULL check
Message-ID: <20201020075307.GA17780@infradead.org>
References: <160311941493.2265023.9116264838885193100.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <160311941493.2265023.9116264838885193100.stgit@warthog.procyon.org.uk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hmm,

what prevents us from killing of the last ->readpages instance?
Leaving half-finished API conversions in the tree usually doesn't end
well..
