Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3151A530827
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 May 2022 05:48:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbiEWDsj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 22 May 2022 23:48:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiEWDsi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 22 May 2022 23:48:38 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B10B19C0A;
        Sun, 22 May 2022 20:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=AW3o8JWyoT5r8/PPhDVW+OSjKZg11kX8S58HsM9Sbls=; b=ui6gRYFqTT/Fj0eCLLFo4lkNRT
        yzWjEUS8i+kwCSW8rbJu6t86c8k0y/y0Br+rWIbAbtZrXouDS6O+hz1rWgJP1pC8fm2WKpzj40Wjk
        xTyD2JeVIlzA8yDRmHFRKm4bbfNvlapmYdPWyRSsXWvPWBIQvhb1npwA52gQOBGSIHNbt34qyWv1q
        rAqiDUfp8bnBUuBKMYM23LfgbCpAM10DY9P73cX8ZUPnkRWJNys4MOUPVLh0hbs+S0PLTdIerPmIr
        ZuWAktiV+VvH2NGvol0J96GVlItQxAfxw2tyaKizJxqpH+CQCWTsKAKslY6n/fUgkDpNrNSD5xfmI
        IM+xYadQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nsz3Y-00FpXW-PY; Mon, 23 May 2022 03:48:32 +0000
Date:   Mon, 23 May 2022 04:48:32 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Vasily Averin <vvs@openvz.org>
Cc:     kernel@openvz.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Christian Brauner <brauner@kernel.org>,
        Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v4] fs/proc/base.c: fix incorrect fmode_t casts
Message-ID: <YosEENLQybfcfZZR@casper.infradead.org>
References: <YorBiz6QA0JBVta/@casper.infradead.org>
 <7761c3fd-4fb5-1d65-c2e6-044d689de6b6@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7761c3fd-4fb5-1d65-c2e6-044d689de6b6@openvz.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 23, 2022 at 06:37:29AM +0300, Vasily Averin wrote:
> Fixes sparce warnings:
> fs/proc/base.c:2240:25: sparse: warning: cast to restricted fmode_t
> fs/proc/base.c:2297:42: sparse: warning: cast from restricted fmode_t
> fs/proc/base.c:2394:48: sparse: warning: cast from restricted fmode_t
> 
> fmode_t is birwie type and requires __force attribute for any cast
> 
> Signed-off-by: Vasily Averin <vvs@openvz.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
