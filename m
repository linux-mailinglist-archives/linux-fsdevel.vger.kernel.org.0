Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2E736C59FC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Mar 2023 00:03:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbjCVXDS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Mar 2023 19:03:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjCVXDR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Mar 2023 19:03:17 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA1ACE07A
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Mar 2023 16:03:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id EC43BCE1F44
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Mar 2023 23:03:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA2CFC433EF;
        Wed, 22 Mar 2023 23:03:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1679526192;
        bh=zWqBbICixZh42505PIhrge5VLeLMCTCIFQuij+rAoTc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=cp9/n/fn3sGbnyVcj6W2RTwOg5hx92YMGiUQDNRJhq/U/htA/4Rhx22bbXq6a8Dyv
         Frn06TyBMmDq8TwF/oOq4upm6cZqLnn+Iuoot+2yToP+2sysKu49gb5YWY3ScbaVY6
         z7NVJ9y2P34GXQf+xtFekOCbIYc4uVKhihq4l3Ok=
Date:   Wed, 22 Mar 2023 16:03:11 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc:     <linux-fsdevel@vger.kernel.org>, <nvdimm@lists.linux.dev>,
        <dan.j.williams@intel.com>, <willy@infradead.org>, <jack@suse.cz>,
        <djwong@kernel.org>
Subject: Re: [PATCH] fsdax: unshare: zero destination if srcmap is HOLE or
 UNWRITTEN
Message-Id: <20230322160311.89efea3493db4c4ccad40a25@linux-foundation.org>
In-Reply-To: <1679483469-2-1-git-send-email-ruansy.fnst@fujitsu.com>
References: <1679483469-2-1-git-send-email-ruansy.fnst@fujitsu.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 22 Mar 2023 11:11:09 +0000 Shiyang Ruan <ruansy.fnst@fujitsu.com> wrote:

> unshare copies data from source to destination. But if the source is
> HOLE or UNWRITTEN extents, we should zero the destination, otherwise the
> result will be unexpectable.

Please provide much more detail on the user-visible effects of the bug.
For example, are we leaking kernel memory contents to userspace?

Thanks.


