Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AF9A668B9C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jan 2023 06:39:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236534AbjAMFjs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Jan 2023 00:39:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235533AbjAMFjk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Jan 2023 00:39:40 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA37E479D6;
        Thu, 12 Jan 2023 21:39:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=/B6w3J07AxrM9iK3a7qVeE0bR/477r/pWx+E3gAsuE8=; b=o6e5m4B3euNw9Np/G6KMOT6Go1
        masUynCBs3JzPfqQBXTvEQLqcQItiwPYzyLdtt6b405wXXwnpp6myohIvzM2xqi7P93Kx9SS5wZbP
        ahTzwj15VhU/3gV4/rvMbJj1uCBUppy3RzaI25HcprL3Enp9QN3GYdNt6wX0dA6K2dp/vDb15nXNL
        oHy5LlvEE3484spMTK/7HuQvL9BpEtlJKvVIme0iNRppUFMsxD0HXhBRXdd9kYFahb9YXB3gVudvH
        YCIj6wBS/zVHs7Cmi/Odq8KGrCMRgADa3WjQWl3K6y6gWuKGpzEX/JRwP4N27mVyDD6HxPZvfJMBZ
        4dRdCIYw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pGCmo-000Xq1-Jp; Fri, 13 Jan 2023 05:39:30 +0000
Date:   Thu, 12 Jan 2023 21:39:30 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Krzysztof =?utf-8?Q?B=C5=82aszkowski?= <kb@sysmikro.com.pl>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: dropping maintainership for sysv and freevxfs
Message-ID: <Y8DukvUVc4BUuYbS@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi all,

I've realized that I really should not be listed in maintainers for
sysv and freevxfs.  There's not really active work for either of them,
and I don't really have good ways to test them

For freevxfs, Krzysztof has done work a few years ago to support the
HP-UX support, so there is some evidence of it beeing still used.
I'd suggest to make Krzysztof the maintainer or odd fixer, and as
the person having written the code I'd be willing to look over any
non-trivial change.

For sysv I have no indication of actual users anywhere, so I wonder
if we should look into dropping it.  Unless Al still cares about it
one way or another.
