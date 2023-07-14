Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8923753102
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Jul 2023 07:14:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234025AbjGNFOm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Jul 2023 01:14:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235007AbjGNFOU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Jul 2023 01:14:20 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC06FAA;
        Thu, 13 Jul 2023 22:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=i83kX+Mh6k/r2FqOanE3zOTFkcCFTb3my01o0VhDW7Y=; b=d1WePr6t0gMimxpGdlQj/FIoAg
        KbfxwxAfHTCYADL/utgfyEzwLh77rUpez4ULI1ywlgWLy9R4F1s02rAue/adopcdugl4c5H7H8TDT
        8HcUuqbHR6CAKXZLKqn3SKMH+VYjmUyopKKfGJD0lBP1ltzEUHJXvY45Q2s+UQ8HiYDhTQIbwymGh
        8EXSRuEMMapGv1SySclXEPTfYo6HsTBxrt5+6KXTdgwcMMS3mpv+pZMvGeUGxGR5+mF7hfjav1zE5
        OsJJAqgh4MHLrjPCi8I3Pp2o+q5WKzNGO3XVvt4P9hfKWaKwq8Ed+kiMvnB46c6qbuYREo5ig53QE
        OPK2W7tQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qKB80-000jOK-Rc; Fri, 14 Jul 2023 05:14:04 +0000
Date:   Fri, 14 Jul 2023 06:14:04 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Philipp Stanner <pstanner@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] xarray: Document necessary flag in alloc-functions
Message-ID: <ZLDZnHY0af4bQqBw@casper.infradead.org>
References: <20230713161712.3163-1-pstanner@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230713161712.3163-1-pstanner@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 13, 2023 at 06:17:11PM +0200, Philipp Stanner wrote:
> I would pick up the other places where this information has to be
> added if someone can provide me with a list :)

I'd suggest every wrapper function that calls __xa_alloc() or
__xa_alloc_cyclic() needs this same information (I think you caught
one of the six in the header file?).

Thanks for this, I think it's the right idea.
