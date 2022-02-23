Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 194044C0CFF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Feb 2022 08:06:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238533AbiBWHGh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Feb 2022 02:06:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233602AbiBWHGh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Feb 2022 02:06:37 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F9D96E4DE
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Feb 2022 23:06:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=n6fXZ86UHrk+VTGK7e2PfF6KTt
        0lOWL21tQUSqrXqzb2KOOnHItXiDEaJANmYfrAUi1DVhtc869JGs/1Iq0KlcvLus0XPbQ41YVAn3Y
        Hz3pXeTzh4kY/IW28/QmXI7t9S9OfyKwfO8NZBlxBkyp0eFQNUZWEb3T9DtBFOrMGxqf8/4HGp04r
        BQ0gWRHibFqvixsg2UK8mym9Bf1mUNoAk0/4ePk1VrLKWyvzeunfWDfdOsgnJuw5OSkVBZV+FfQj7
        w/+i3kV4y3zWkCUSgcGqC34umA80s48zo8H2iUl1gJpl8vivBa+JHVlf6jJlyJJMSn+Lpbg932JzB
        Y4WX5cjA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nMliz-00D4Up-Vw; Wed, 23 Feb 2022 07:06:09 +0000
Date:   Tue, 22 Feb 2022 23:06:09 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 22/22] fs: Remove flags parameter from aops->write_begin
Message-ID: <YhXc4TKagycWgnS+@infradead.org>
References: <20220222194820.737755-1-willy@infradead.org>
 <20220222194820.737755-23-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220222194820.737755-23-willy@infradead.org>
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

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
