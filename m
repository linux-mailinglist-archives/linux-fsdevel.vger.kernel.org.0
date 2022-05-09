Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FBBB51FDE9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 May 2022 15:18:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235403AbiEINVW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 May 2022 09:21:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235347AbiEINVV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 May 2022 09:21:21 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35090216867
        for <linux-fsdevel@vger.kernel.org>; Mon,  9 May 2022 06:17:27 -0700 (PDT)
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 249DHKgl028549
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 9 May 2022 09:17:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1652102241; bh=8PQx2/XeMtcrYmuxZOvo5oFMhpnKmBYAhRMVRxccOhg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=MOQB8HblZ9dgIo730PGMZe22liODPZ/vnyIfQTPP6nzKUMT6CDn9s+HmcHWpXNILK
         zJYdfiqZSaUv0Qp/APNz+WMASEbmmaJWaavRZub6sl75b7qDKNmxW4ZHej1WeB4pnw
         VUNfBScqa07EwsN4ioWnFJucNpkoWJISuH+3SlJoJ2RPh0gw9c5K53ZDqE4pgHIn8e
         QDF3AjFnxDruLITA8WIecXNskO4XeuAK1HBwXXxQgDxrdtpHakx+T64Vl9RG77zX07
         C41tqwYt0+gAsqw44Sm9TiTosT0TOx+YHvv7QpdoYhWIaqq4rLGyS5vAx2bIKLMKhQ
         SkFblPVrS8gBg==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 7C38215C3F0A; Mon,  9 May 2022 09:17:20 -0400 (EDT)
Date:   Mon, 9 May 2022 09:17:20 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 23/26] jbd2: Convert jbd2_journal_try_to_free_buffers to
 take a folio
Message-ID: <YnkUYBgvGMj49XZG@mit.edu>
References: <YngbFluT9ftR5dqf@casper.infradead.org>
 <20220508203247.668791-1-willy@infradead.org>
 <20220508203247.668791-24-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220508203247.668791-24-willy@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, May 08, 2022 at 09:32:44PM +0100, Matthew Wilcox (Oracle) wrote:
> Also convert it to return a bool since it's called from release_folio().
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Acked-by: Theodore Ts'o <tytso@mit.edu>
