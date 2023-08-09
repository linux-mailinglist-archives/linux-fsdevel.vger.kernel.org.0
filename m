Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6F3577655F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Aug 2023 18:47:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbjHIQrB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Aug 2023 12:47:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230007AbjHIQqz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Aug 2023 12:46:55 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 113B91FD2
        for <linux-fsdevel@vger.kernel.org>; Wed,  9 Aug 2023 09:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Ntii3qNDur+u0UnJS+M4F4i484LuHIyp+kJFi9pNBvg=; b=sRuKXIWDhOAfCuZtOfoM2U6ZlE
        dWYG7i38E2rUt9WyGR8qFyJY8EBgN3TlhkspLaWe5xSwJqpFXj1EOaFoF8PD9YMkWxEPy6zbUWRlM
        oTlmbGrZ91nHYcJriycAJwI9KD1diH+yj3G814lVR+kLW2JAC1tLIFxtJpSVrwgRgx79iZ2n/yKs7
        AEUexY4RJvzsLMV9U1/0XQUv1TfstgOBBuHYHR+zs7RJVlVwuwalh6YN+WWg/0cNC9wZJG3D5IH22
        S46XeariEd8zq+QlEZUqO0LHgqrwoYOym2OG9Hp8TqknUoyr+YAakU8JTEIFctwE4pnrRPlT2boOO
        hPL07sxQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qTmKi-007IDP-08; Wed, 09 Aug 2023 16:46:52 +0000
Date:   Wed, 9 Aug 2023 17:46:51 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] adfs: delete unused "union adfs_dirtail" definition
Message-ID: <ZNPC+79EankpEt+k@casper.infradead.org>
References: <43b0a4c8-a7cf-4ab1-98f7-0f65c096f9e8@p183>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43b0a4c8-a7cf-4ab1-98f7-0f65c096f9e8@p183>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 09, 2023 at 07:35:49PM +0300, Alexey Dobriyan wrote:
> union adfs_dirtail::new stands in the way if Linux++ project:
> "new" can't be used as member's name because it is a keyword in C++.

$ git grep '\<new->' fs |wc -l
610

You cannot seriously be proposing this.
