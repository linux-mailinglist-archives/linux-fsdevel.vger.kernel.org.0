Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98A0B6BA1D5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Mar 2023 23:08:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbjCNWIl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Mar 2023 18:08:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231201AbjCNWIh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Mar 2023 18:08:37 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D9D9559CF
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Mar 2023 15:08:29 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 32EM8Hc3027717
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Mar 2023 18:08:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1678831699; bh=uTzVv+GLchUoYNO2lcP21RTevceX/z3OHphC4GnsC1w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=RG4/tBOU/GN4cTwzuJa2gTrAWXGAtkH/9zMUhlKjzH7QR0sRXn2zkK8TaShsoXT24
         k/YJH6ZJ2NQ5JaVtDZqFWys7Dl7OjWzLMoTxou3WWYVFGJyz8CEh/3NvtOoPGCTI7m
         /jNnaRHr6K7+rShO60LXlKvUQbyP2/xfEUzh4cms+RhtE23047CPCme55i3bYejUse
         Nw3gxuBmDzuM0L/zf06a/SO5xZXXABV6okcQUjp2J4Co4XR7f+ys6VL0wu93xMSO2n
         Ye0B8gKuPATptMeBJShUQSTaFOxWdAuYhPKXMKYFGFVfe4jDr+Ti3jECtZn5QBz+em
         4IM0+qHAyXFsQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 6655015C5830; Tue, 14 Mar 2023 18:08:17 -0400 (EDT)
Date:   Tue, 14 Mar 2023 18:08:17 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 04/31] ext4: Convert ext4_finish_bio() to use folios
Message-ID: <20230314220817.GS860405@mit.edu>
References: <20230126202415.1682629-1-willy@infradead.org>
 <20230126202415.1682629-5-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230126202415.1682629-5-willy@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 26, 2023 at 08:23:48PM +0000, Matthew Wilcox (Oracle) wrote:
> Prepare ext4 to support large folios in the page writeback path.
> Also set the actual error in the mapping, not just -EIO.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Reviewed-by: Theodore Ts'o <tytso@mit.edu>
