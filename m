Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8144F6BA281
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Mar 2023 23:31:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231332AbjCNWbe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Mar 2023 18:31:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231340AbjCNWba (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Mar 2023 18:31:30 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 663173B3F3
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Mar 2023 15:31:28 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 32EMVFsY007657
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Mar 2023 18:31:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1678833076; bh=03itdijCOlwPGqF1zZ0E7hwhtsxIK2j9BTciJDOMDXc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=bfNiNUTVNAU9OUg9a1rGF9RUjdR9IRQAdWiVuqWV9Wxlho1T3apcnEFkaxiRVba5A
         yqe1oOdVaio2JAlMAwmDzvXQC2x0WryN4P0EH7YejEwAbtjfsG/AK/2CRaw0jEqbwm
         lNhfqBXzqSdyRf5ytID2lvkfzQ7shNIYxfOdyoeBEzux/956XxDM8gq2OQMh+ieCMe
         1RU1Tjhqw2z+PFHLcYnZvOIxAy4St/facnd6ufxaiTVP5Cm5WN0qYPbysUSBjmyoCM
         tMH9v6IOdqkvbSn4y8etU0phHifpo1XqUGwyqvAHW/dErVVH48t4UfDUCtwnuzfVqa
         WbOn+4JMKkz9g==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id D4FA915C5830; Tue, 14 Mar 2023 18:31:14 -0400 (EDT)
Date:   Tue, 14 Mar 2023 18:31:14 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 08/31] ext4: Convert ext4_bio_write_page() to
 ext4_bio_write_folio()
Message-ID: <20230314223114.GW860405@mit.edu>
References: <20230126202415.1682629-1-willy@infradead.org>
 <20230126202415.1682629-9-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230126202415.1682629-9-willy@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 26, 2023 at 08:23:52PM +0000, Matthew Wilcox (Oracle) wrote:
> Both callers now have a folio so pass it in directly and avoid the call
> to page_folio() at the beginning.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

The ext4_writepage() changes will need to be dropped when you rebase,
but other than that....

Reviewed-by: Theodore Ts'o <tytso@mit.edu>
