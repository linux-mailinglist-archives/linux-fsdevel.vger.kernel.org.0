Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50F6850D4CF
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Apr 2022 21:23:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237458AbiDXT0c (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 24 Apr 2022 15:26:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233170AbiDXT0b (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 24 Apr 2022 15:26:31 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47D7C62A07;
        Sun, 24 Apr 2022 12:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Xh7LUAmFoIqxYbksJd78ZOLHOPH0rZu20hznpGLh6Sc=; b=AUxGYIQrS3y3W3q8SWzPJltLQ9
        CxG+f+R0sS2hArtvwedFK/KIQ0hukY2anrXqk/Sh2nYfpIRBGYl9+DrbjB7acifAtveO6BSnMm98C
        gZjhQS3bH9FVHS3UbbiWXOLOM5K0OtMPVDoMGQzxl3WOX5Md0Qkv6M2JftRCIpL7jOZH3x11Z8xAe
        uFdxQFZ+jnq12GqyZaITinJk7xQ0obhKIB7lrop24PuziXQmeV6zzqdyD4B+o1lufiGfj141pOaAJ
        qI8+CrZMwppNccNn4bX6IQDLL2kT3rsQNxQtx19veCIsuntpm5kqgmjgmKjoM0Mw1xrRXjSDcaYBT
        vf5WiztA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nihpF-00887x-E1; Sun, 24 Apr 2022 19:23:17 +0000
Date:   Sun, 24 Apr 2022 20:23:17 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Junwen Wu <wudaemon@163.com>
Cc:     adobriyan@gmail.com, akpm@linux-foundation.org, ddiss@suse.de,
        fweimer@redhat.com, keescook@chromium.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] proc: limit schedstate node write operation
Message-ID: <YmWjpWWdwN0qxFSR@casper.infradead.org>
References: <YmNs+i/unWKvj4Kx@casper.infradead.org>
 <YmNs+i/unWKvj4Kx@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YmNs+i/unWKvj4Kx@casper.infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Apr 24, 2022 at 03:23:54PM +0000, Junwen Wu wrote:
> From: Matthew Wilcox <willy@infradead.org>
> 
> On Sat, Apr 23, 2022 at 02:31:04AM +0000, Junwen Wu wrote:
> > Whatever value is written to /proc/$pid/sched, a task's schedstate data
> > will reset.In some cases, schedstate will drop by accident. We restrict
> > writing a certain value to this node before the data is reset.
> 
> ... and break the existing scripts which expect the current behaviour.
> 
> 
> Hi, Matthew,can you describe it in more detail.

What detail do you need?  Existing scripts depend on the existing
behaviour.  Your change to the behaviour will break them.  That's not
allowed, so your patch is rejected.
