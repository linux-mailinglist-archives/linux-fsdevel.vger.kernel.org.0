Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C3B970AFA2
	for <lists+linux-fsdevel@lfdr.de>; Sun, 21 May 2023 20:45:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbjEUSpK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 21 May 2023 14:45:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjEUSpJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 21 May 2023 14:45:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AE56B3;
        Sun, 21 May 2023 11:45:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CAC1660F36;
        Sun, 21 May 2023 18:45:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE68CC433EF;
        Sun, 21 May 2023 18:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1684694707;
        bh=kmDCDOZHjYTK86Jk4TKhx2LmEyFlshYlDfqM196BFZw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=oSy7+/WWSlhVePQh28dCfVCiDGejcxR7i8sCfIKgWxx/e4BYOAzltbGmq2wbLnx44
         sffnJDoyodq/LH1vMYvDMpTOw94Wlkfoh7L+KCvhSQ9fw/AzY5SsmbQgKoiQD8qglh
         bytB29uPyrkQrrvSEwmpgaFyfMqxEz9EHsgCrbqg=
Date:   Sun, 21 May 2023 11:45:06 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Peng Zhang <zhangpeng.00@bytedance.com>
Cc:     arnd@kernel.org, willy@infradead.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Liam.Howlett@oracle.com
Subject: Re: [PATCH] radix tree test suite: Fix building radix tree test
 suite.
Message-Id: <20230521114506.0e683eea82747f4344ba9b32@linux-foundation.org>
In-Reply-To: <20230521095450.21332-1-zhangpeng.00@bytedance.com>
References: <20230516194212.548910-1-arnd@kernel.org>
        <20230521095450.21332-1-zhangpeng.00@bytedance.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, 21 May 2023 17:54:50 +0800 Peng Zhang <zhangpeng.00@bytedance.com> wrote:

> The build of radix tree test suite failed due to a new internal header
> file added to radix-tree.c. Adding the header directory in the Makefile
> fixes it.

Thanks, I queued this as a fix against "radix-tree: move declarations
to header".  
