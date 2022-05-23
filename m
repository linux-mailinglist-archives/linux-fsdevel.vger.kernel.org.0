Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD108530D78
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 May 2022 12:42:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233498AbiEWJma (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 May 2022 05:42:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233823AbiEWJlJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 May 2022 05:41:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3D33B31;
        Mon, 23 May 2022 02:41:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 79AEF61174;
        Mon, 23 May 2022 09:41:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13B20C385AA;
        Mon, 23 May 2022 09:41:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653298863;
        bh=DRFadpB4rY2X6hgovzUNnaVWTesFRLOkSX2ChXOH8ps=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fJa5f84qZw7O+CLPciRB/TVZrJfvfOUfeDeHNyZjvwUGIl0ldUEjexGtnyk02aZuu
         j628ZcZTxUuDFlxIXORuS8RrAhK4mwTj2b+js3PwKB1LzIqsWLRSfY4ayjn3MIEKWb
         Cw6GTfg1ifm2zGG4EggTLfPo5gm9BQRiuiyNITgIrhhoLNlQmsCYkdFrV+VhHOH+cd
         IfB5COu/iSaN3K5vj4d/aZJDj+3UCLCtdNh6Yyc5AeLo0lAvJ87wyZOBqxhAkHaDZl
         Hg0gkbv0VSSF8J3sqK58qoJeg59rOfV0YG2i/sCNLL4LCzO50i4SXB8Tz06f2jKTS+
         Do+Tukx0he98A==
Date:   Mon, 23 May 2022 11:40:58 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Vasily Averin <vvs@openvz.org>
Cc:     Matthew Wilcox <willy@infradead.org>, kernel@openvz.org,
        linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v4] fs/proc/base.c: fix incorrect fmode_t casts
Message-ID: <20220523094058.nuj3xsgixzu2amac@wittgenstein>
References: <YorBiz6QA0JBVta/@casper.infradead.org>
 <7761c3fd-4fb5-1d65-c2e6-044d689de6b6@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7761c3fd-4fb5-1d65-c2e6-044d689de6b6@openvz.org>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
> ---

Looks good to me,
Reviewed-by: Christian Brauner (Microsoft) <brauner@kernel.org>
