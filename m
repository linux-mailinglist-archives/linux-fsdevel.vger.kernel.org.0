Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B0504C5203
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Feb 2022 00:22:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239295AbiBYXXO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Feb 2022 18:23:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230190AbiBYXXN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Feb 2022 18:23:13 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46D7132070;
        Fri, 25 Feb 2022 15:22:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=epmPQ6RPq2hr9/8Tsc2gmOVU08RZyji5PoYx0QfoMwI=; b=hGOP3S6AbwD61QDjWjel5TI5Uj
        QIzDnIdKHOf+ddi/1iIsPvRAHOJ73XTVuPFKd2pUjKFthBN0qnUwRsGZqlhAwTtaZK1KaY3CE4B/e
        1qaLc4M3tgwTnbqtA91KT8ZJQtWfuEwhMKnEvYyev8eRjbbBdQYMBhbhFtZ/sNvC+T40dbAWBgnMf
        M8EuIgo8t8paJkNhWehzCwChBTWP7oWUu8fLQQn5/4IRX9tJFJQascGhM/44sJPINprl+DcwX4Hco
        ak5rySApzoDTbPlbxDmxnQkP0aZQph9AkpMrrCUcl+ilyBDF3Nn7nNj4XIRtgrsl0JTpu3no6gDMm
        kzSKMsrg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nNjv1-006De6-Pb; Fri, 25 Feb 2022 23:22:35 +0000
Date:   Fri, 25 Feb 2022 23:22:35 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "dhowells@redhat.com" <dhowells@redhat.com>
Subject: Re: [PATCH 1/2] Convert NFS from readpages to readahead
Message-ID: <Yhlku5//fKl1cCiG@casper.infradead.org>
References: <20220122205453.3958181-1-willy@infradead.org>
 <Yff0la2VAOewGrhI@casper.infradead.org>
 <YgFGQi/1RRPSSQpA@casper.infradead.org>
 <a9384b776cc3ef23fc937f70a9cc4ca9be8d89e0.camel@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a9384b776cc3ef23fc937f70a9cc4ca9be8d89e0.camel@hammerspace.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Feb 07, 2022 at 07:47:08PM +0000, Trond Myklebust wrote:
> I already have them applied to my 'testing' branch, but I can't move
> that into linux-next until Anna's pull request against -rc3 comes
> through.

Hey Trond,

I'm not seeing any patches in linux-next to fs/nfs/ other than those
that have gone through Andrew Morton, Jens Axboe and Chuck Lever.
Has the linux-nfs tree dropped out of linux-next?

