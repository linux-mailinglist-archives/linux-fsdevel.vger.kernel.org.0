Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C79047B3B1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Dec 2021 20:27:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240806AbhLTT1q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Dec 2021 14:27:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240628AbhLTT1p (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Dec 2021 14:27:45 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42DD9C061574;
        Mon, 20 Dec 2021 11:27:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
        bh=adovGkg61e/AVCMqKU8OYUhUD3zhaBmYVCKv5C7XMLQ=; b=L47favp71a+N3X9iYo6zIsqXqV
        KCWZKmA5RA4jQj4jI1GMTcgjqEcsA1c3vGWzDHnoXBJJ9FDfHRsPmlcWyPL3Rlh1wJTB/9ieuLAOm
        XCwBsWOWwPjFCFzvTfXrIYOlU+EI02fr1q911eGl9HloiReqUtQ8VDD4qVuJsdAXKIqCrx9x71w9o
        KPMKvGafmoIX+bUlbIXPI3MUZ2zueZnkrqhNWrkSj7tHrgGGj83fwMYQp0Z+ke0Og93njUrMt+qzC
        +iHIFO9QYPxZn3boJlPcPUGNci6ituKQ6OwJTHL2Uzs5onL5/IxHwxSe9BzUaz6KQuSMAW3EHHnwj
        wZqOKmeA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mzOJw-0045Zc-16; Mon, 20 Dec 2021 19:27:40 +0000
Date:   Mon, 20 Dec 2021 11:27:39 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     "libaokun (A)" <libaokun1@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, keescook@chromium.org,
        yzaikin@google.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, yukuai3@huawei.com,
        Hulk Robot <hulkci@huawei.com>
Subject: Re: [PATCH -next] sysctl: returns -EINVAL when a negative value is
 passed to proc_doulongvec_minmax
Message-ID: <YcDZKxXJKglR6mcO@bombadil.infradead.org>
References: <20211209085635.1288737-1-libaokun1@huawei.com>
 <Yb+kHuIFnCKcfM5l@bombadil.infradead.org>
 <4b2cba44-b18a-dd93-b288-c6a487e4857a@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4b2cba44-b18a-dd93-b288-c6a487e4857a@huawei.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Dec 20, 2021 at 04:53:57PM +0800, libaokun (A) wrote:
> 在 2021/12/20 5:29, Luis Chamberlain 写道:
> > Curious do you have docs on Hulk Robot?
> 
> Hulk Robot is Huawei's internal test framework. It contains many things.

Neat, is the code public?

  Luis
