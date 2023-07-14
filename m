Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F22F1753002
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Jul 2023 05:34:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232670AbjGNDeh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Jul 2023 23:34:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234797AbjGNDef (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Jul 2023 23:34:35 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C605B26B7
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Jul 2023 20:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=3zBfKF3xZTov+rqpTg9LXdPvQHtY4lCWFIwoXr3xIhY=; b=jYjubUlX1eg3Z5ktlWf8IjGSX5
        pbOYV3AcoGGV8Pu+yopJ6Ksr8VJfwJKxtVY2MqFsNr/MVF8IFo15FvAlk6FbB/eD9QLm31OZoS5qN
        l9YByPMFJHfsehQnPhhvEs422EKHPKkShLcLjZO1YOuqVJYJKlanMeD7IwMnShpdSubVvH7BZAgOH
        zK6boGk+kOxJ/0hbxum0XqaeevKnsLccTkAKUSMC+zm7Sli0SYsL7UsM4ue1Q4sVLWznPHhNHbwrz
        Hhy6MV1uGrnDky+UJGKaNvGl1itGxn0++jocI22lIKrdSj1Jklur1LJpnnlQVl0EPGoMQUYRZ9mTH
        5ZTvEDtA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qK9ZY-000g7z-Q1; Fri, 14 Jul 2023 03:34:24 +0000
Date:   Fri, 14 Jul 2023 04:34:24 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     linux-mm@kvack.org, Arjun Roy <arjunroy@google.com>,
        Eric Dumazet <edumazet@google.com>,
        linux-fsdevel@vger.kernel.org,
        Punit Agrawal <punit.agrawal@bytedance.com>
Subject: Re: [PATCH v2 1/9] Revert "tcp: Use per-vma locking for receive
 zerocopy"
Message-ID: <ZLDCQHO4W1G7qKqv@casper.infradead.org>
References: <20230711202047.3818697-1-willy@infradead.org>
 <20230711202047.3818697-2-willy@infradead.org>
 <CAJuCfpGTRZO121fD0_nXi534D45+eOSUkCO7dcZe13jhkdfnSQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpGTRZO121fD0_nXi534D45+eOSUkCO7dcZe13jhkdfnSQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 13, 2023 at 08:02:12PM -0700, Suren Baghdasaryan wrote:
> On Tue, Jul 11, 2023 at 1:21 PM Matthew Wilcox (Oracle)
> <willy@infradead.org> wrote:
> >
> > This reverts commit 7a7f094635349a7d0314364ad50bdeb770b6df4f.
> 
> nit: some explanation and SOB would be nice.

Well, it can't be actually applied.  What needs to happen is that the
networking people need to drop the commit from their tree.  Some review
from the networking people would be helpful to be sure that I didn't
break anything in my reworking of this patch to apply after my patches.
