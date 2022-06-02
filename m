Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D25253BDBB
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Jun 2022 20:05:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237823AbiFBSFA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Jun 2022 14:05:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237621AbiFBSFA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Jun 2022 14:05:00 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FEFE2B1962;
        Thu,  2 Jun 2022 11:04:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0A3EEB81FBC;
        Thu,  2 Jun 2022 18:04:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C4E0C385A5;
        Thu,  2 Jun 2022 18:04:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1654193095;
        bh=+c5iRxpxVslZlrm/mBaQSvpF7wacBnElLysfFCDVUck=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GEtcZ8geE7TWGjtoeXVTo+I7x3z6IV2eLT+f+gzq8wvSREw7xixvrMjs8+pGACSnJ
         5DlHpJHoj0GjWaxBxF/O7OK1/ODc4fZUQlgzh6nvb2lnQ/jWY2f1Wj8G4F8yAFvonX
         R6dkMmFDe4GTkWKV/AAZnLrn9h0/3SQRkG49ETVg=
Date:   Thu, 2 Jun 2022 11:04:54 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Xin Hao <xhao@linux.alibaba.com>
Cc:     changbin.du@intel.com, sashal@kernel.org, adobriyan@gmail.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] proc: export page young and skip_kasan_poison flag via
 kpageflags
Message-Id: <20220602110454.319467e7e0f7f662142b5c39@linux-foundation.org>
In-Reply-To: <20220602154302.12634-1-xhao@linux.alibaba.com>
References: <20220602154302.12634-1-xhao@linux.alibaba.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu,  2 Jun 2022 23:43:02 +0800 Xin Hao <xhao@linux.alibaba.com> wrote:

> Now the young and skip_kasan_poison flag are supported in
> show_page_flags(), but we can not get them from /proc/kpageflags,
> So there add them.

Can we have a documentation update please?

hp2:/usr/src/25> grep -rl kpageflags Documentation 
Documentation/admin-guide/mm/idle_page_tracking.rst
Documentation/admin-guide/mm/pagemap.rst
Documentation/filesystems/proc.rst
Documentation/translations/zh_CN/vm/hwpoison.rst
Documentation/vm/hwpoison.rst

