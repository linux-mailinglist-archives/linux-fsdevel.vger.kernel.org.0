Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A6206BA274
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Mar 2023 23:27:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230506AbjCNW1t (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Mar 2023 18:27:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231139AbjCNW1r (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Mar 2023 18:27:47 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23FED27993
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Mar 2023 15:27:47 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 32EMRddp005956
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Mar 2023 18:27:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1678832860; bh=98JAkc+oQG+o2JLL8pYnl6ocvog9wtNwGNOIQu3hMiw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=HSzuUXLXoNGjCeizuQ4YMNTq6IYmgeR2BChXHpKNEB44V6sY8K7jgecd4t3h1IrMO
         OGM2wpG0vMgt2bFd4YJknjDT1zKu8TAc6ohZXGHhPmWKfLEULCIELi94ZuwQtw+mT7
         Oo//cP/tR7Hezjdd6ts0To6CDoZaIM2q2sVBLgT2J/9mzt7TiE9c5+Y2GDzmwsjZI8
         gSO5GfORTKVEhv9y0YCDtKp+wZO8B0PYVlkP+3qOc6ODM2USP98Dedv8icZNp0upOf
         CdcWohpE8P1ldhVBw7PvTSnp1NFhkfrBn9eeFLe1jSgjc2+/aucTrHhzsp2hLTX1i9
         lsSH2aJEkqd2Q==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id D95B315C5830; Tue, 14 Mar 2023 18:27:38 -0400 (EDT)
Date:   Tue, 14 Mar 2023 18:27:38 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 06/31] ext4: Turn mpage_process_page() into
 mpage_process_folio()
Message-ID: <20230314222738.GU860405@mit.edu>
References: <20230126202415.1682629-1-willy@infradead.org>
 <20230126202415.1682629-7-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230126202415.1682629-7-willy@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 26, 2023 at 08:23:50PM +0000, Matthew Wilcox (Oracle) wrote:
> The page/folio is only used to extract the buffers, so this is a
> simple change.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Reviewed-by: Theodore Ts'o <tytso@mit.edu>
