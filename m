Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 948256BA2B8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Mar 2023 23:50:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbjCNWuv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Mar 2023 18:50:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230334AbjCNWuu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Mar 2023 18:50:50 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D979136699
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Mar 2023 15:50:49 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 32EMofqn016837
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Mar 2023 18:50:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1678834243; bh=h1gbgxXX/WMwVpztS4beC//I0GP7jUcOYN80p+Mg5mQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=jWrKTYuHTQT6IWE2FHgIlI0LbTLSgnXtPz6zHcYqaRNWiF9aVFS3ou/w/sjrFSD70
         pTB9Xwc7uWNqamV14wrKs1EXrwwsspJLO1br+oaL2YyNFLYTiZChhhCOWKLRXPyG42
         MjtLWP8M++gEY1Edp6MBpiBnW3qHVIgPleQZM/FjMzKBvFhc0/xBBxRGD8PtCxYTRo
         22VKUrJ3WWa6ttQHA7G50PTuKye1Hc0MMC4e6oxIEHlTnIkOm5FAWU/yqxNQdHhcmW
         c4IJD/TEkoGTVU7oys8cHFn4QLgrisO6GTPaNxtBub6BdjoJskZoIK/+TdsnFxkiqO
         4h7irw/uen84Q==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id B9FD415C5830; Tue, 14 Mar 2023 18:50:41 -0400 (EDT)
Date:   Tue, 14 Mar 2023 18:50:41 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 22/31] ext4: Convert ext4_page_nomap_can_writeout() to
 take a folio
Message-ID: <20230314225041.GH860405@mit.edu>
References: <20230126202415.1682629-1-willy@infradead.org>
 <20230126202415.1682629-23-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230126202415.1682629-23-willy@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 26, 2023 at 08:24:06PM +0000, Matthew Wilcox (Oracle) wrote:
> Its one caller is already using a folio.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
