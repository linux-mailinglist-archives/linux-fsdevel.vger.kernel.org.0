Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C91137056DD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 May 2023 21:14:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbjEPTOl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 May 2023 15:14:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjEPTOk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 May 2023 15:14:40 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A41A171A;
        Tue, 16 May 2023 12:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=xRrYtCC/Q/xk6LM7k4L4zCnW+DwqYTGt4KRN+Qhhzjo=; b=mm+2oFlYGXMbz1khF3q/F+eS/P
        uHEJ/auwusF8GkGqcUJwVono2Lo8XsSo9jJy++k/ewwizRZ4T/7oU0GUBkTMPqCcPM2YwFa+eB0sN
        ZdcT4H7ZDuWJcGJPcMkMpbbL3eCbDv8xxsciO0tOSxhkAXTIBMcxzy/PdWsch01n7EgUFXctKJQsp
        DcKf7yQ1hsBT+OTfI3/quNP98kK6p9TxjN5kjhPo0qz1gqMoYx6Jh10TvTZp46Vuak3Z4CWAHQkdb
        nKmJXjHkP2b4qxBco845JD6mVps9F4qwOsithMOnYMYilrj7SWJyO48SD5Z1eu9ZlXCXMCMTVGxFw
        viRU+NKw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pz084-004Tux-2O; Tue, 16 May 2023 19:14:36 +0000
Date:   Tue, 16 May 2023 20:14:36 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>
Subject: Re: [RFCv2 2/5] ext4: Remove PAGE_SIZE assumption of folio from
 mpage_submit_folio
Message-ID: <ZGPWHOkI2/tvwS97@casper.infradead.org>
References: <cover.1684122756.git.ritesh.list@gmail.com>
 <74182f5607ccfc3b1e7f08737fcb3442b42a2124.1684122756.git.ritesh.list@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <74182f5607ccfc3b1e7f08737fcb3442b42a2124.1684122756.git.ritesh.list@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 15, 2023 at 04:10:41PM +0530, Ritesh Harjani (IBM) wrote:
> mpage_submit_folio() was converted to take folio. Even though
> folio_size() in ext4 as of now is PAGE_SIZE, but it's better to
> remove that assumption which I am assuming is a missed left over from
> patch[1].
> 
> [1]: https://lore.kernel.org/linux-ext4/20230324180129.1220691-7-willy@infradead.org/
> 
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
