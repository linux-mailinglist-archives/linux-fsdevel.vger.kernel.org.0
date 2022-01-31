Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19DAA4A4DAA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Jan 2022 18:59:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235522AbiAaR7m (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Jan 2022 12:59:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbiAaR7l (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Jan 2022 12:59:41 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCA92C061714;
        Mon, 31 Jan 2022 09:59:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=5M0PbMjiefbHwaqC/xj3mKHbM/DDkEnbZsPZmLX0dkE=; b=bchYUUPdYofR/UGjyRDBKDanVg
        6v9vLjVpyVEYmAkLEY1KUR7Ks1GHOFdD7NVqrBuYR4rECcRp6nGc42EOgn/CeuWV5lxjuvLpRswnB
        BaWISLCKnCIiMW+VC20wsT120QEOOPywQnqV8P9vBjXnIGv0knalUgfRWGhscRr7w0EkEMnRV4+MT
        UXt9Ke6UFWt5s6It/ku7vJX1NeClyI8pbwp39itLyzRpL9q1pwRZUjcfwnzW4D9ZnM948/eaP9iKi
        6m+JEEx7dtLBOciyz3xLX6PuXPxMX/wViUuycERe9hwhFnx6IT0ouowL0iVG3SOR/yrgqPOjOjGAl
        5Thpz2sw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nEaxi-00AKG0-KN; Mon, 31 Jan 2022 17:59:34 +0000
Date:   Mon, 31 Jan 2022 17:59:34 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     =?iso-8859-1?Q?Ma=EDra?= Canal <maira.canal@usp.br>
Cc:     gregkh@linuxfoundation.org, tj@kernel.org, viro@zeniv.linux.org.uk,
        nathan@kernel.org, ndesaulniers@google.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH v2] seq_file: fix NULL pointer arithmetic warning
Message-ID: <Yfgjhq6LIzhKNaTU@casper.infradead.org>
References: <YfgivbCgwKjJu9ec@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YfgivbCgwKjJu9ec@fedora>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 31, 2022 at 02:56:13PM -0300, Maíra Canal wrote:
> +EXPORT_SYMBOL(single_start);

kernfs is a 'bool', which means it can't be a module, so there's
no need to EXPORT this symbol.
