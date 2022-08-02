Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EB1D5880E4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Aug 2022 19:18:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233724AbiHBRSu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Aug 2022 13:18:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbiHBRSt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Aug 2022 13:18:49 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D42F1D0E1;
        Tue,  2 Aug 2022 10:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=wNPiTR833IoMnVSV13bQs8xeVL8RU6xSyseaM29Ymns=; b=YMmm05uCEKeGcQXcliHQ+kJNbk
        eeF5aJje9i7rgKugQgvx7uZn9gPiQVtTCGpJYxcfb78yKYQheB+jwti+9hxIaFYXyU7SFKR65n0xh
        7hPKVh5WiUgrw0Ky2SmVr+K8pNqq+15mBWvYhTVhYbz+mnRk2DTyCjGyQC3BoKN0Ip+4dr4C4ybhb
        Vjhrw5TUW4wCFwRKTJ6+ALWzPC7ntQndLS/3y8ZQ3cL3PNtVbB/HHQs6a1xBWr9+DKom+u+heoY0U
        1U35c5jcAoo+UkdTbEo7gGNjt/s+WzRK8RbUY2Y8RzxmyA3kAOwswRCvh/D54vUD7WqcQRvaQ70pq
        geZq4k6A==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oIvXZ-008XJW-UC; Tue, 02 Aug 2022 17:18:45 +0000
Date:   Tue, 2 Aug 2022 18:18:45 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] XArray changes for 6.0-rc1
Message-ID: <YulcdRuGoA4CpKGm@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The following changes since commit 32346491ddf24599decca06190ebca03ff9de7f8:

  Linux 5.19-rc6 (2022-07-10 14:40:51 -0700)

are available in the Git repository at:

  git://git.infradead.org/users/willy/xarray.git tags/xarray-6.0

for you to fetch changes up to 85656ec193e9ca9c11f7c75dc733c071755b189e:

  IDR: Note that the IDR API is deprecated (2022-07-10 21:17:30 -0400)

----------------------------------------------------------------
XArray/IDR update for 6.0

 - Add appropriate might_alloc() annotations to the XArray APIs

 - Document that the IDR is deprecated

----------------------------------------------------------------
Matthew Wilcox (Oracle) (2):
      XArray: Add calls to might_alloc()
      IDR: Note that the IDR API is deprecated

 Documentation/core-api/idr.rst |  3 +++
 include/linux/xarray.h         | 15 +++++++++++++++
 tools/include/linux/sched/mm.h |  2 ++
 3 files changed, 20 insertions(+)

