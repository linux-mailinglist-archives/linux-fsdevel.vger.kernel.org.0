Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95F7D25C95B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Sep 2020 21:22:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729279AbgICTWW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Sep 2020 15:22:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:38990 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729223AbgICTWU (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Sep 2020 15:22:20 -0400
Received: from X1 (nat-ab2241.sltdut.senawave.net [162.218.216.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 15FE4208FE;
        Thu,  3 Sep 2020 19:22:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599160940;
        bh=qrU9WP85gio2U/xOxsjI6OQmaemPSNLwvExZVcQaiJI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=IrPwGOqTv/KWNBrt1u4S7EwYUUGRjlpElggScKVY+7W4Ixse0AjqAOzDwaanViz3l
         h0Wh9hdgoPIDK9ZlLTdqUMzrwfafpurypMlMfvJrYkdIfuynzS1Klva+0zkKp12SRc
         FuObmMfsMgQHesWMfhIyVMomBTTbEaa4bKwUWGpw=
Date:   Thu, 3 Sep 2020 12:22:18 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     David Howells <dhowells@redhat.com>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, Eric Biggers <ebiggers@google.com>
Subject: Re: [PATCH 3/9] mm/readahead: Make page_cache_ra_unbounded take a
 readahead_control
Message-Id: <20200903122218.42bd70d930cba998e3faf32c@linux-foundation.org>
In-Reply-To: <20200903140844.14194-4-willy@infradead.org>
References: <20200903140844.14194-1-willy@infradead.org>
        <20200903140844.14194-4-willy@infradead.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu,  3 Sep 2020 15:08:38 +0100 "Matthew Wilcox (Oracle)" <willy@infradead.org> wrote:

> Define it in the callers instead of in page_cache_ra_unbounded().
> 

The changelogs for patches 2-9 are explaining what the patches do, but
not why they do it, Presumably there's some grand scheme in mind, but
it isn't being revealed to the reader!
