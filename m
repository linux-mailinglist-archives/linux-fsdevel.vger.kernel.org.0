Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 483C351FDDE
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 May 2022 15:15:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235542AbiEINSq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 May 2022 09:18:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235529AbiEINSa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 May 2022 09:18:30 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 888071AEC57
        for <linux-fsdevel@vger.kernel.org>; Mon,  9 May 2022 06:14:27 -0700 (PDT)
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 249DEETw026818
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 9 May 2022 09:14:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1652102055; bh=M8DNOcqVah81K4yf1lpRIRl9CO8szkGjJJYW02Qkbiw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=N84SRWPNWKT0M3QIKtBXHrgXvF73H7IvjMxgfmJcYqOyTQnItd2Uk0rYLprlEOjDD
         b3AGHOLXjy99FItgKxx64ucrQjdbvOmsO1eZKgSETjWfGNgDO9xJt4CMTIgErmbwFa
         /OBgDT2XoCIheQOqip4pwnSV3qs2SGrlL5dhNPDF9pycQa2qJFumqtc0ynRrLqdZPg
         PlU5xE4htSWU4ZkEutgT+NKcTzAwH/nSBt2UU0MkQ+GLA67aGxXGNdNOLsgD8tVJ31
         q+R6X/SkplFw/G7a3Jd7FeeaHXM2NstLkNxp1fAqy+YtwGRSBRVdOejLUHLoYerReL
         bqXX7Nk9J/ylA==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id F3AF515C3F0A; Mon,  9 May 2022 09:14:13 -0400 (EDT)
Date:   Mon, 9 May 2022 09:14:13 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 09/26] ext4: Convert to release_folio
Message-ID: <YnkTpUDwGbPIsOQD@mit.edu>
References: <YngbFluT9ftR5dqf@casper.infradead.org>
 <20220508203247.668791-1-willy@infradead.org>
 <20220508203247.668791-10-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220508203247.668791-10-willy@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, May 08, 2022 at 09:32:30PM +0100, Matthew Wilcox (Oracle) wrote:
> The use of folios should be pushed deeper into ext4 from here.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Acked-by: Theodore Ts'o <tytso@mit.edu>

						- Ted
