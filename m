Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A4CE679943
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jan 2023 14:28:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234191AbjAXN2V (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Jan 2023 08:28:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232855AbjAXN2V (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Jan 2023 08:28:21 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58B5C3250D
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Jan 2023 05:28:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=dFj4PXIWzhbmUJOFmzQNt1qgtQ8syeC3KliuYY5z/vY=; b=YtI5pBnU7nAY4zfcQVdo75dB+2
        WP4HqMTVpaWbbB5elQ3ybh7Nlncf/oq7wIuEYZ7ZuMVY7HAg8Akf2oHOvUB/ahHe0O7h97ni54s9f
        wogeQWudq4SVi4YR0dlpN0iPhHjkz+Zh/IQnU0IrzVkQ3jyvabNStI4E4qyqdEk2eUd9PmLiP4fkV
        sNYueHRVcXQJEGqkgEw37PsSTL48y5PmJNBueqLGRIa0GBqP56hfWR4iVuLuEUkTSBQOHRo0RwUtR
        Ki7OJA+JbiQZvgjMwVe4hUpTbgT/VS6XIlveJ2Kgc657s+q213dKW7tjdkwuvqDD5wuIIuaK0rPfP
        aBEqesaA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pKJLY-003z19-0a; Tue, 24 Jan 2023 13:28:20 +0000
Date:   Tue, 24 Jan 2023 05:28:19 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 08/10] udf: Mark aops implementation static
Message-ID: <Y8/c82tHHo19U6CB@infradead.org>
References: <20230124120221.31585-1-jack@suse.cz>
 <20230124120628.24449-8-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230124120628.24449-8-jack@suse.cz>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
