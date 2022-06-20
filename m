Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCC2955107A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jun 2022 08:39:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238694AbiFTGjj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Jun 2022 02:39:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230121AbiFTGji (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Jun 2022 02:39:38 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06C75DEE0;
        Sun, 19 Jun 2022 23:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=AaV9zsbAcToZWU93ArUl8ifsbd8pf8pNoJuicLCD97Y=; b=CdMxhUWELXIkD1RJMV8bL+5S2h
        8Y3lpSzD2TIYolAU49Jy+g8lne7sNpMgq+C9DSIqdbYrdg/BtEulIm39OrvooUDfTRW9tWJT4Logb
        17cv5ZfMNB72VlUSXIRtDFxI6jdq0tr4TYONeKVVgepqRA6gqjKbw8ccOpHVEP3PgOXJCyhyxzPhv
        1jZvEZe2IyGUz2tMJFF/LAWvOMl9nBc9WUyUaxmbHaVkNJfeHUyDpjjdxTi5myl9v/Es1RyuZBqn2
        912Ru/dyY1JWkEdYncKagYWnEJvy11aEZKD8mDIk/4JtxeocOR5+qmjaos5H8c0f7igze7UEy8YaT
        3f6h+l3g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o3B4T-00GSNg-Ij; Mon, 20 Jun 2022 06:39:37 +0000
Date:   Sun, 19 Jun 2022 23:39:37 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Ritesh Harjani <ritesh.list@gmail.com>
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Jan Kara <jack@suse.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [RFC 2/3] fs/buffer: Drop useless return value of submit_bh
Message-ID: <YrAWKVBjR/HCxcz8@infradead.org>
References: <cover.1655703466.git.ritesh.list@gmail.com>
 <77274d2a2030f6ee06901496f9c5fbe8779127a3.1655703467.git.ritesh.list@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <77274d2a2030f6ee06901496f9c5fbe8779127a3.1655703467.git.ritesh.list@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 20, 2022 at 11:28:41AM +0530, Ritesh Harjani wrote:
> submit_bh always returns 0. This patch drops the useless return value of
> submit_bh from __sync_dirty_buffer(). Once all of submit_bh callers are
> cleaned up, we can make it's return type as void.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
