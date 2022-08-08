Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE85758CC5D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Aug 2022 18:48:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243584AbiHHQsS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 Aug 2022 12:48:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243809AbiHHQsO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 Aug 2022 12:48:14 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67ECD13F79;
        Mon,  8 Aug 2022 09:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=AV92UiTLmPw4vUOdy+/8wxiFyzdZlR5os6ILkiIf9s0=; b=vDnK4ciRV10H4NJF7jCG23Desc
        oWHkj82B3SMRniVf28XC8e82ERbL1LXgZB5Wr7v1KhIf3xaJvPp6m/5Sq93KyHjYyq1U7tvluDKC0
        0q45n5pn0G8LTx2jMI+/QJzTyzg3q9UX4ILaZgJuqniGD1vaeKx79BHL03p+DLBmI8lvguR1Ubdha
        5l0abPSbAVI1S/7F58aR7oEIi3DqGejgcYG0OXk6uHKVXOrB/v4bDOUj5m8s6jzmfgx6MMNbVm/aQ
        1eSyULiU9qEL1GnVGvrTkptDMGU6AYnZfYcopN4ObGrw6gfs5mHmeEM4n1QoeK0LDOQwM4tWBoZOo
        eb0pb8pw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oL5vD-00E49y-Ir; Mon, 08 Aug 2022 16:48:07 +0000
Date:   Mon, 8 Aug 2022 17:48:07 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Xin Gao <gaoxin@cdjrlc.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] radix tree test suite: Parameter type completion
Message-ID: <YvE+RxXwNtQK0IVX@casper.infradead.org>
References: <20220808152142.59327-1-gaoxin@cdjrlc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220808152142.59327-1-gaoxin@cdjrlc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 08, 2022 at 11:21:42PM +0800, Xin Gao wrote:
> 'unsigned int' is better than 'unsigned', which has several changes.

I don't agree that unsigned int is better than a plain unsigned.
