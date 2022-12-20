Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2E06651D52
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Dec 2022 10:29:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233253AbiLTJ3T (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Dec 2022 04:29:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbiLTJ3S (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Dec 2022 04:29:18 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3393F6253
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Dec 2022 01:29:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=va11I7iORO6OrtH10QOzF8apXsz9s8BFqYU6bHbWxYU=; b=FL0jQELLQJ18vnzjYuwZaZpFVC
        RsoR3hrunu+3OUWbJXGOr27wtTz8cocalVYDhe9+oFTeejMVIJWOrPe89VBcSaHl9uH5QaCoLCrtx
        BTpjv4uoPNqDDAxTAgbt+ftQpulCibWSiloC+V36mZwCjUVfYTaRYInO+OCXdab28q6Eo5WYw+erG
        VgaSVtitO/Q7P4f04AM4uemiBdMdIv2eO1LuNplipZyOVY+gU9iqqeHsoedg/QdZHFMRNDdMw2nJT
        GC0xddGusEdQenoDJZdyeymIAr8l6fwOwADLeVgayYcOfUGs6RxcT8ME9ZBb1pZ9n7gr1VSruern/
        g13LyG6w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p7Yw7-001eaN-S7; Tue, 20 Dec 2022 09:29:23 +0000
Date:   Tue, 20 Dec 2022 09:29:23 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     JunChao Sun <sunjunchao2870@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk
Subject: Re: [PATCH] fs: Unifiy the format of function pointers in some
 commonly used operation structures
Message-ID: <Y6GAcwS/NRVoGjzm@casper.infradead.org>
References: <20221219095729.16615-1-sunjunchao2870@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221219095729.16615-1-sunjunchao2870@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Dec 19, 2022 at 01:57:29AM -0800, JunChao Sun wrote:
> In current, the format of function pointer in structures
> is somewhat messy, some function prototypes have space
> after the function name and some do not. Unified them in
> some commonly used operation structures.

Please don't.  And if you're going to, change in the other direction,
to omit the space.
