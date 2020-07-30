Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 011B5233686
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jul 2020 18:17:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729484AbgG3QRP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Jul 2020 12:17:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726353AbgG3QRP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Jul 2020 12:17:15 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 653D7C061574;
        Thu, 30 Jul 2020 09:17:15 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k1BEr-005l18-1M; Thu, 30 Jul 2020 16:17:01 +0000
Date:   Thu, 30 Jul 2020 17:17:01 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 22/23] fs: default to generic_file_splice_read for files
 having ->read_iter
Message-ID: <20200730161701.GB1236603@ZenIV.linux.org.uk>
References: <20200707174801.4162712-1-hch@lst.de>
 <20200707174801.4162712-23-hch@lst.de>
 <20200730000544.GC1236929@ZenIV.linux.org.uk>
 <20200730070329.GB18653@lst.de>
 <20200730150826.GA1236603@ZenIV.linux.org.uk>
 <20200730152046.GA21192@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200730152046.GA21192@lst.de>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 30, 2020 at 05:20:46PM +0200, Christoph Hellwig wrote:

> Fortunately I think the fix is pretty easy - remove the special pipe
> zero copy optimization from copy_page_to_iter, and just have the
> callers actually want it because they have pagecache or similar
> refcountable pages use it explicitly for the ITER_PIPE case.  That gives
> us a safe default with an opt-in into the optimized variant.  I'm
> currently auditing all the users of for how it is used and that looks
> pretty promising.

Huh?  What does that have to do with anything?
