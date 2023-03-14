Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7EA26BA2A3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Mar 2023 23:41:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231152AbjCNWlf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Mar 2023 18:41:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230514AbjCNWle (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Mar 2023 18:41:34 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3359C33476
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Mar 2023 15:41:34 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 32EMfPRZ012823
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Mar 2023 18:41:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1678833687; bh=uVE2n2HhelN0MwFwWzV1g5KUaGFGkhVZoSWqQoCnro0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=cWhcgUoG79JtaPfW8kfjRcOeg1VeFPbhKkHz0g7zlSeQIKbTG6nk4oMhaT2GIeMPF
         2wYs5G1x9AuxaO9I+bzIApK5nMqzbQXhD0zQfrGwnxtrtiXV9w1Lou6uwNF8qTzJbe
         LkP5tWiI5ZvhNnSt2nXn7bQDajfAEcVg+SJUKC3ydKyfoqfbV1RdmhEZ6FZQGtlVkP
         eab+JhQmrGZyKrzi1JYnwUzJRGOuALhJDf7ZPQwrgJA+q6ju4sDYm6cgvkaJdROozh
         MtAo9mzBXRH7wBzp8BjesKfL7CMgC4xXZPt98cThWIBJiIzh0E1Ih/7NADMsFVdMXm
         OTnr6C0L5VZ2g==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 8ECC315C5830; Tue, 14 Mar 2023 18:41:25 -0400 (EDT)
Date:   Tue, 14 Mar 2023 18:41:25 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 18/31] ext4: Use a folio in ext4_journalled_write_end()
Message-ID: <20230314224125.GE860405@mit.edu>
References: <20230126202415.1682629-1-willy@infradead.org>
 <20230126202415.1682629-19-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230126202415.1682629-19-willy@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 26, 2023 at 08:24:02PM +0000, Matthew Wilcox (Oracle) wrote:
> Convert the incoming page to a folio to remove a few calls to
> compound_head().
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Reviewed-by: Theodore Ts'o <tytso@mit.edu>
