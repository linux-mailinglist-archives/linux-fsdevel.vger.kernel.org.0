Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27FE74DDADE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Mar 2022 14:50:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236856AbiCRNvg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Mar 2022 09:51:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236847AbiCRNvf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Mar 2022 09:51:35 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E69AEF4606;
        Fri, 18 Mar 2022 06:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=9QCcpNkDMmy8WarV6TWNsU1p+/IGAtNQ1g1Iawnak2g=; b=in9ZKghmvV/js8WUDCBEqSIEsU
        lfVjU8AWwKk2roGiPFZgB43IcUrfyYE2GKnRlWqu8W07uN2aUYlhafO5NUeA12Yr1TcrvTDLvsKLt
        go7mYV5WTwNHNxZ6Hmk8xtZd0talGlWPXanK2yLzYZ8xTkEgNtnN6IbG6kMJziyJ8RcG4jHfDCgFk
        Hf9yS8lVqKPAzoQVgv9ZYmXL5OxDHARGz7JieQDheJk8O2EEZHaHcDdwBenoth0gN+qWdohDixK4l
        EZ+oSj/QYfbvyyioYe9W/wHs/6ZbLsYbIoT3ZI+pUHkMPz8nKw+DR1QTZ+sc0lxewcYQ+BDk4dDL2
        /zPgRArQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nVCzb-007z9p-MV; Fri, 18 Mar 2022 13:50:11 +0000
Date:   Fri, 18 Mar 2022 13:50:11 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     David Laight <David.Laight@aculab.com>
Cc:     'Baoquan He' <bhe@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "yangtiezhu@loongson.cn" <yangtiezhu@loongson.cn>,
        "amit.kachhap@arm.com" <amit.kachhap@arm.com>,
        "hch@lst.de" <hch@lst.de>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v4 4/4] fs/proc/vmcore: Use iov_iter_count()
Message-ID: <YjSOExYBbpZ7Hw8Z@casper.infradead.org>
References: <20220318093706.161534-1-bhe@redhat.com>
 <20220318093706.161534-5-bhe@redhat.com>
 <1592a861bd9e46e5adf1431ad6bbd25c@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1592a861bd9e46e5adf1431ad6bbd25c@AcuMS.aculab.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 18, 2022 at 01:48:07PM +0000, David Laight wrote:
> For some definition of 'cleaner' :-)
> 
> iter->count is clearly a simple, cheap structure member lookup.
> OTOH iov_iter_count(iter) might be an expensive traversal of
> the vector (or worse).
> 
> So a quick read of the code by someone who isn't an expert
> in the iov functions leaves them wondering what is going on
> or having to spend time locating the definition ...

Thank you for having an opinion.  Al's opinion, as the iov_iter
maintainer, trumps yours.
