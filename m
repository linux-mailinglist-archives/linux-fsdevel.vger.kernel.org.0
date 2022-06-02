Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28B3B53BE11
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Jun 2022 20:28:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237990AbiFBS2l (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Jun 2022 14:28:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234073AbiFBS2j (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Jun 2022 14:28:39 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5A3F20C27C;
        Thu,  2 Jun 2022 11:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=0D+S+RT003/1WbL9r9PMHAKW1N1Xhi6inZJ/D9WSjb8=; b=kukR8pnRZfY+lffJR06CeVC0mv
        dCmWwVDff5faj1BvAVocZ7NGjIpZiNsoBtiAnzRgJ9Eu7D7802iJZQ4hxBAbhXqYNN12YxrGVnN5j
        Dqm0k4VF61Kt8MpAIdQEMW/W9jQq6duDZlGG5usJpJajCYHnTC/GPZf3HDidjao8wY7CgcVYW+vy1
        MpURqzjRpByVoDCdmqc0dhNv3bqSxw6+zxsGc0H91SbFOxzWer1UKG6x0cYhuXm7SQfIF4E+9nSdG
        2G4FIGb4w4cWTikuTu4P2Jo9t20QMOX/fs7bTCnVoYJ/eltlXJDYUbZcBsCv1gyv4X7p88G9+meP4
        OCKgrZbw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nwpYP-007LBF-JW; Thu, 02 Jun 2022 18:28:17 +0000
Date:   Thu, 2 Jun 2022 19:28:17 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Xin Hao <xhao@linux.alibaba.com>
Cc:     changbin.du@intel.com, sashal@kernel.org,
        akpm@linux-foundation.org, adobriyan@gmail.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] proc: export page young and skip_kasan_poison flag via
 kpageflags
Message-ID: <YpkBQTWWUuOzagvd@casper.infradead.org>
References: <20220602154302.12634-1-xhao@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220602154302.12634-1-xhao@linux.alibaba.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 02, 2022 at 11:43:02PM +0800, Xin Hao wrote:
> Now the young and skip_kasan_poison flag are supported in

Why do we want userspace to know about whether skip_kasan_poison is set?
That seems like a kernel-internal detail to me.

