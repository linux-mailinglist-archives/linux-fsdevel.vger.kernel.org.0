Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5593872EC7E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jun 2023 22:09:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231991AbjFMUJm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Jun 2023 16:09:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230150AbjFMUJl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Jun 2023 16:09:41 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AAAE1732;
        Tue, 13 Jun 2023 13:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=bcoLkRc5GqoKYGFqDiytS/vPJEc249EbSEUtuRtnckU=; b=aORgD+1AX4Q7om7BTIByRZwq76
        8k220N5mx3Isdtc6Zj5r8sOAcrKox9us5lT67AlWqbewr7NyIbL81nba/JonFbpTVwo7lD+9SMZwF
        2OM5agA6Xe41e/SfoqzrfsKL8C0+Hp/6hil0/oTCD9fdsktKs7ZI/+o9MJEJ0WD8S7vnYCAldmIg6
        5ZayTu+x/DGEOBinuvLMj+57NWmkVmevrww3nOm3SUgSdrkOomy52+gyql2jZixF326tYZSsPiCRJ
        3KdYKXokN0eH4jJr+3xWvhsjpTbhYva5G2i5Zj+gbn3BO+SA1cmRD2cpe5lMQojV3PzpHusOkWHTe
        LcOmoW+Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q9AKO-004HfY-5C; Tue, 13 Jun 2023 20:09:20 +0000
Date:   Tue, 13 Jun 2023 21:09:20 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     wenyang.linux@foxmail.com
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>,
        Christian Brauner <brauner@kernel.org>,
        Christoph Hellwig <hch@lst.de>, Dylan Yudaken <dylany@fb.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Eric Biggers <ebiggers@google.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] eventfd: add a uapi header for eventfd userspace APIs
Message-ID: <ZIjM8BOVp3kSNZkn@casper.infradead.org>
References: <tencent_4AF3548D506B04914F12A49F3093F9C53C0A@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_4AF3548D506B04914F12A49F3093F9C53C0A@qq.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 14, 2023 at 12:59:11AM +0800, wenyang.linux@foxmail.com wrote:
> +++ b/include/uapi/linux/eventfd.h
> @@ -0,0 +1,14 @@
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> +#ifndef _UAPI_LINUX_EVENTFD_H
> +#define _UAPI_LINUX_EVENTFD_H
> +
> +#include <linux/types.h>

Why do you need types.h?

> +/* For O_CLOEXEC and O_NONBLOCK */
> +#include <linux/fcntl.h>
> +
> +#define EFD_SEMAPHORE (1 << 0)
> +#define EFD_CLOEXEC O_CLOEXEC
> +#define EFD_NONBLOCK O_NONBLOCK
> +
> +#endif /* _UAPI_LINUX_EVENTFD_H */
> -- 
> 2.25.1
> 
