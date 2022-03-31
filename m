Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CDA44EDAE9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Mar 2022 15:50:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236438AbiCaNvx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 31 Mar 2022 09:51:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237043AbiCaNvw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 31 Mar 2022 09:51:52 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6588D13A1CC
        for <linux-fsdevel@vger.kernel.org>; Thu, 31 Mar 2022 06:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=IKA66qYXVaGCcBKp/Myeu4QCaJFoPCNhdwBDezWnt9o=; b=QE5yeTYGMfIJ/hYTvpCj61bhMt
        j4qMKoedr4dK//k6ZNi/lpCeGOx0oUS89h6yT5YHXkLt0sw9PTOD0SDr3joXxjytTk7jlVLrWkyDZ
        IDNhwbESJ1Gg5PRsrSK+uWSwE84ik/njWiYVtM3zQ1WsYIa5eNDTG5/Qc0Gq00IRhe8SWSTCiS0gt
        wlpRb/ubO+gOO82cXqLtyaNfIuhl8aOOUdUuduvNBYmDauQDc8c1lRxLiR1qBU2Eoq76D5G52HGLx
        9sthGNVK/MpKdSO+QAH6ezeaLAlcKG+yjEk5jDV8WysUq6MVw9/IvB9zAcdFVYUAP2jmAPLecl4/q
        wZdu8Zvw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nZvBb-002I10-Dn; Thu, 31 Mar 2022 13:50:03 +0000
Date:   Thu, 31 Mar 2022 14:50:03 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 13/12] mm: remove the pages argument to read_pages
Message-ID: <YkWxi/IoPCKvw6Rj@casper.infradead.org>
References: <20220330144930.315951-1-willy@infradead.org>
 <YkWgC4l5wQFsZD5D@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YkWgC4l5wQFsZD5D@infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 31, 2022 at 05:35:23AM -0700, Christoph Hellwig wrote:
> From: Christoph Hellwig <hch@lst.de>
> 
> This is always an empty list or NULL with the removal of the ->readahead
> support, so remove it.

Thanks, I meant to do this and forgot.  Added this patch.
