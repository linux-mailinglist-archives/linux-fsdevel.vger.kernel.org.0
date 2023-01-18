Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6C52671F00
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jan 2023 15:09:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231264AbjAROJO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Jan 2023 09:09:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231182AbjAROIp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Jan 2023 09:08:45 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C40845AB4A;
        Wed, 18 Jan 2023 05:49:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ETxjjLavmaOPEk6TMO4SM/B8zpeLHudHeOG1qhddvao=; b=hAR2gX1Pw47/qODWU9DVegMS5A
        D8pvpfpJ2BXZzvDOP+nXPk+QDo11Ts2C2Dl+M0C9uAROmmtDL98WIPQWB+/nXt5smB/6BCpptgGgX
        bg9DKVD0VH8XTVWV65efkX90EiE3qviQrIRz93V3QBGhP5EEQwbYtGM84boO6EggBEWnmotO4EWRT
        x4etztl7bwy7NVeZonMeVNPPf2c7JMHaJIIHYh5WmqpYL95TjrM8xu1dbAHYj6twiFdsYuCJxv2yt
        aTwuePNEhlrkJlqPHzlNYyJbffb6y+usI0wsg2b2I49eQKZ119h1Qa33+eLqM/V9K8ptO36BIttTU
        +kqU5QAg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pI8oT-0001wu-Q6; Wed, 18 Jan 2023 13:49:13 +0000
Date:   Wed, 18 Jan 2023 13:49:13 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>, linux-afs@lists.infradead.org,
        linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        cluster-devel@redhat.com, linux-mm@kvack.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-nilfs@vger.kernel.org
Subject: Re: [PATCH 2/9] mm: make mapping_get_entry available outside of
 filemap.c
Message-ID: <Y8f42T6Bd9RdT06O@casper.infradead.org>
References: <20230118094329.9553-1-hch@lst.de>
 <20230118094329.9553-3-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230118094329.9553-3-hch@lst.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 18, 2023 at 10:43:22AM +0100, Christoph Hellwig wrote:
> mapping_get_entry is useful for page cache API users that need to know
> about xa_value internals.  Rename it and make it available in pagemap.h.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
