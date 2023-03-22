Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E498B6C5A17
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Mar 2023 00:12:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbjCVXMl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Mar 2023 19:12:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjCVXMk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Mar 2023 19:12:40 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A463F967
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Mar 2023 16:12:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4C3D1B81E53
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Mar 2023 23:12:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB3C5C433D2;
        Wed, 22 Mar 2023 23:12:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1679526757;
        bh=Z3s7pGu/ZPmhYfb4tbtIIOF0PXFxa6xDdetvTA1CXgY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HhkXw7aNQvuFo2gctIW+ghEbcHnEIlLThjR/eotpElfvBsN+HOlo6aFDIUSukd0vI
         dc5g3YPtIFkAWZ18wzgo5rm6rT28RCqdQbrj2CoU4kRkQANg1TXH45I1LAAOiJooEF
         57nk/Z+uul83TgfBy7KzCofk+W+dM5jn+YE6b9mY=
Date:   Wed, 22 Mar 2023 16:12:36 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc:     <linux-fsdevel@vger.kernel.org>, <nvdimm@lists.linux.dev>,
        <dan.j.williams@intel.com>, <willy@infradead.org>, <jack@suse.cz>
Subject: Re: [PATCH] fsdax: dedupe should compare the min of two iters'
 length
Message-Id: <20230322161236.f90c21c8f668f551ee19d80b@linux-foundation.org>
In-Reply-To: <1679469958-2-1-git-send-email-ruansy.fnst@fujitsu.com>
References: <1679469958-2-1-git-send-email-ruansy.fnst@fujitsu.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 22 Mar 2023 07:25:58 +0000 Shiyang Ruan <ruansy.fnst@fujitsu.com> wrote:

> In an dedupe corporation iter loop, the length of iomap_iter decreases
> because it implies the remaining length after each iteration.  The
> compare function should use the min length of the current iters, not the
> total length.

Please describe the user-visible runtime effects of this flaw, thanks.
