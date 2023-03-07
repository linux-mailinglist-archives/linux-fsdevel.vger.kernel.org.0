Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAAC66AD84B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Mar 2023 08:25:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbjCGHZY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Mar 2023 02:25:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbjCGHZX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Mar 2023 02:25:23 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C341A3608E;
        Mon,  6 Mar 2023 23:25:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=dWgWiOp+lFwUMcA943xYoHJ4crmTLqH97hUpLQ+w6eA=; b=dmn9kH/U7C/uQGaDhxU8xgC3in
        z2FqMqaGBARLtf8Oaz0mGhKTHH2SkpR/+2U8hLfwybv0APBlhwY2MMjPeZaer0+RpWKVg6xr6QuCD
        I+XdV092WK2AXRpWA256HWNDEPTkDMWs7qvmNLXQGWM4SfSV+D1Y5/fSCTnSvYDGJnKtmT8IvSoSo
        HG5NUDb3a3OZ2+301W5vaphpX2M/KUdjCPfx4CXbFP7rI+K1jD1lz8sSz/PlVYHLZjp5AxIYdoKnT
        rG6Jysjr0ENV88QrXrcuKFOENbfbJf1VJNlh60ZOYdVsD/Spr+wgVkKao27FUXn8NeLeBLeS/YD2+
        UwCUCKMQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pZRhD-00676A-Uo; Tue, 07 Mar 2023 07:25:16 +0000
Date:   Tue, 7 Mar 2023 07:25:15 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Kent Overstreet <kent.overstreet@linux.dev>
Cc:     lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-bcachefs@vger.kernel.org
Subject: Re: [LSF/MM/BPF TOPIC] bcachefs
Message-ID: <ZAbm2zTX83Cfl2SJ@casper.infradead.org>
References: <Y/ZxFwCasnmPLUP6@moria.home.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y/ZxFwCasnmPLUP6@moria.home.lan>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 22, 2023 at 02:46:31PM -0500, Kent Overstreet wrote:
> I'd like to talk more about where things are at, long term goals, and
> finally upstreaming this beast.

We don't have any rules about when we decide to upstream a new filesystem.
There are at least four filesystems considering inclusion right now;
bcachefs, SSDFS, composefs and nvfs.  Every new filesystem imposes
certain costs on other developers (eg those who make sweeping API changes,
*cough*).  I don't think we've ever articulated a clear set of criteria,
and maybe we can learn from the recent pain of accepting ntfs3 in the
upstream kernel.
