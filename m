Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EF673E54F3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Aug 2021 10:16:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238012AbhHJIQt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Aug 2021 04:16:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237067AbhHJIQq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Aug 2021 04:16:46 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3479C0613D3;
        Tue, 10 Aug 2021 01:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=0Hg3yOCCfu/9tRoCTP06JBGmFtKzhXisBZBHnJVIdds=; b=eohOY9euFtdixTb9+gqI8eoqOi
        bdcEojOW8XSgc7Ck4b2o/akIxMbVNNvbkmNrjiOIpjpzwF28xPA8z0CR6t62oX+29yKEMniLNETlK
        vG2uncJQItW0EDddy4ujCRNtNMjUG7SW91JtQ9JLnyfHAa7w/QRgEvVxDCMdNNIDPgu+eOiVklmUb
        6sDkeLYnBwwx6NW+yJ36C/07q9Nhrkj4itAHqT1wlh3I9jqmbusAAp27zx0wEsNDjXYcpcCxHpLEQ
        zMm9e9cYGk16iCNnNXPy6GJrcE+EzU1L6/yrYhPCEFcdLBB2cKq5xsqeMAMu0ATY88dI5MH79i3ec
        OPgfdqTw==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mDMv2-00Bsta-CL; Tue, 10 Aug 2021 08:15:37 +0000
Date:   Tue, 10 Aug 2021 09:15:28 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Vishal Moola <vishal.moola@gmail.com>
Cc:     vishal.moola@gmail.c, willy@infradead.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] Page Cache Allowing Hard Interrupts
Message-ID: <YRI1oLdiueUbBVwb@infradead.org>
References: <20210730213630.44891-1-vishal.moola@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210730213630.44891-1-vishal.moola@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Stupid question, but where do we ever do page cache interaction from
soft irq context?
