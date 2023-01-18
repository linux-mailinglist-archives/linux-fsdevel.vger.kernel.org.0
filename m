Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6041672A09
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jan 2023 22:11:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230420AbjARVL1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Jan 2023 16:11:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230414AbjARVLI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Jan 2023 16:11:08 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C8AD618A4
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Jan 2023 13:09:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 05923B81F13
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Jan 2023 21:09:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 601C2C433D2;
        Wed, 18 Jan 2023 21:09:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1674076194;
        bh=d6RE1SW3HYvTygWxh6wXuWPHqFU3wzaUIYzQ7eszNj4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=2M8BmoizjVavzS0EgfAn0+yFOCA8/vNzivZSCs60Ci62Lub6qkp49nZ2ZrMR2Kuhz
         nf0cr0ilX1wPBvKHtxtXAX3PlYvcVdMNDUHNCdey30hcQQCh/qjWYh9IF+YBROf2A/
         ZARd54bkP0OLZRGOJqrWPX9q7jW7ImUfWpwlDpw4=
Date:   Wed, 18 Jan 2023 13:09:53 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Evgeniy Dushistov <dushistov@mail.ru>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        ocfs2-devel@oss.oracle.com, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: remove most callers of write_one_page v3
Message-Id: <20230118130953.b5a305ac2a6eabac9179d025@linux-foundation.org>
In-Reply-To: <20230118173027.294869-1-hch@lst.de>
References: <20230118173027.294869-1-hch@lst.de>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 18 Jan 2023 18:30:20 +0100 Christoph Hellwig <hch@lst.de> wrote:

> this series removes most users of the write_one_page API.  These helpers
> internally call ->writepage which we are gradually removing from the
> kernel.

I grabbed these.  If Stephen's duplicated patch check tells me that they're
also in the VFS tree, I'll drop them again.
