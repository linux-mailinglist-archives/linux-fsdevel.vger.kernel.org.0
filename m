Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27BA37B6860
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Oct 2023 13:55:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232048AbjJCLzy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Oct 2023 07:55:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231912AbjJCLzx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Oct 2023 07:55:53 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03473B3;
        Tue,  3 Oct 2023 04:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=mVhl1EFgEQiL6EvwBF97O1BN6Zsdh23wRYztd++wDpo=; b=FAOEdJEJtL1N+WoMeHhe0ZZYvB
        imQpIOVlWl3blIVpoSIu1D9592Igo9ybneWq74SWuuVT9XXts4nNwuugYkUETTyjOfab9MX87R3/w
        A8DJYR7Bef91gFCVcpMp1FL4pBPfGwCmd1HpZkouoMfGkUBLl8v6Etu5MExhi88xFp0WTuCvlvgfG
        1bO8irH+YlwvMVWzb8rJqppU6SoJhTykljTWDo2QPch7sxrUewe+gVXRSLlriejG2A7Kd2Ll6g2fY
        p184wXM+xxX1xQoBtPBwV0FGzrIyQZtd6YVi+fhOJtlzkK+67i9GwPJmURND3KSQgXR5Nn+/OZVv5
        PMUCwczQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qne0A-00ErG1-8h; Tue, 03 Oct 2023 11:55:46 +0000
Date:   Tue, 3 Oct 2023 12:55:46 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Jan Kara <jack@suse.com>, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        "Fabio M . De Francesco" <fmdefrancesco@gmail.com>
Subject: Re: [PATCH 01/10] highmem: Add folio_release_kmap()
Message-ID: <ZRwBQkMtDShY4X8L@casper.infradead.org>
References: <20230921200746.3303942-1-willy@infradead.org>
 <20231003104128.75bh4y4wmwsjvfwl@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231003104128.75bh4y4wmwsjvfwl@quack3>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 03, 2023 at 12:41:28PM +0200, Jan Kara wrote:
> On Thu 21-09-23 21:07:38, Matthew Wilcox (Oracle) wrote:
> > This is the folio equivalent of unmap_and_put_page(), which remains as
> > a wrapper for it.
> > 
> > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> 
> I'm missing a patch 10/10 in this series (and a coverletter would be nice
> as well)... What's there ;)?

Email sucks!  https://www.infradead.org/~willy/linux/ext2-dir-20230921/
