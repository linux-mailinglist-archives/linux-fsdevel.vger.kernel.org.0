Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F5D966D0F3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jan 2023 22:30:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234293AbjAPVam (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Jan 2023 16:30:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234606AbjAPVaT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Jan 2023 16:30:19 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BA3C29E0C
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Jan 2023 13:30:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B6C3EB810E0
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Jan 2023 21:30:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E00FAC433EF;
        Mon, 16 Jan 2023 21:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1673904612;
        bh=bOzsQfQw6tO0Vrg+XKg+pWo7df/w9dC+JoyDrq7xnUc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=bgXfNMU36uKZT7YZ1i6nYhE2c6rZ4GzVadzjYwR4Lumg23b2RtJAmH/i0pA4SITZY
         mMF7XOKHOrELPoBWBaQEUVPmyu2SwIkmSuTZtTRbw9Eu5H+NOHE6MECgq2PpDrdkVP
         a/Fi/PXyWgR1p8DIfEl8lCfqlkndZmXHhRFNeTsY=
Date:   Mon, 16 Jan 2023 13:30:11 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Christoph Hellwig <hch@lst.de>, Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Evgeniy Dushistov <dushistov@mail.ru>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        ocfs2-devel@oss.oracle.com, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: remove most callers of write_one_page
Message-Id: <20230116133011.81f6e4e42805ed47aa61270d@linux-foundation.org>
In-Reply-To: <Y8W7dULuW5oFGm/J@ZenIV>
References: <20230116085523.2343176-1-hch@lst.de>
        <Y8W7dULuW5oFGm/J@ZenIV>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
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

On Mon, 16 Jan 2023 21:02:45 +0000 Al Viro <viro@zeniv.linux.org.uk> wrote:

> OK...  Mind if I grab minix/sysv/ufs into a branch in vfs.git?
> There's a pile of kmap_local() stuff that that would interfere with
> that and I'd rather have it in one place...

Please grab the whole series in that case?
