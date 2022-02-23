Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4760F4C0CD6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Feb 2022 07:56:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233368AbiBWG5N (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Feb 2022 01:57:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232040AbiBWG5L (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Feb 2022 01:57:11 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7857E17040
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Feb 2022 22:56:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=OAegp8Jmy07ZUtDPAGPKjgRz1UIz1rSOt58ncg7swEw=; b=c7ByopDDLuzCQiMqjbLc/7o8EU
        eswOvSUt9PXBsVQRC1PHCLmbkgwYL8863j2+9knQ5lC2zBQG4/UizymMnlGT/YsgmBBIQna+fyh9k
        D6bz/s0DSI6aPFXVDq+dPnSUu4wcT9tmo/yaV6FHe87j+mEw/P8AO5OBeeCObkLfYogGQ6useWVtL
        /TVsmH67nGZoImDqpBttmqNvxkSu+Va9EDUdRBqaWOT/9ah1lDUqgdLZrA1KzPA0dmGAqL8REMmtt
        68dgK6nDsEVPCnPTe9s/5/mtH9vnsaBdu2dPnzsigrp4F4VSd/CY6Ct2PjW5tfjSlOagDGXvduind
        rq5QQdaQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nMlZs-00D3Jz-5R; Wed, 23 Feb 2022 06:56:44 +0000
Date:   Tue, 22 Feb 2022 22:56:44 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 07/22] namei: Convert page_symlink() to use
 memalloc_nofs_save()
Message-ID: <YhXarPs59GWWddn6@infradead.org>
References: <20220222194820.737755-1-willy@infradead.org>
 <20220222194820.737755-8-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220222194820.737755-8-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 22, 2022 at 07:48:05PM +0000, Matthew Wilcox (Oracle) wrote:
> Stop using AOP_FLAG_NOFS in favour of the scoped memory API.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
