Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D67446C3C94
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Mar 2023 22:21:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbjCUVVr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Mar 2023 17:21:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229825AbjCUVVp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Mar 2023 17:21:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 140F14D420
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Mar 2023 14:21:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id ACB8DB81A34
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Mar 2023 21:21:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B4DEC4339B;
        Tue, 21 Mar 2023 21:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1679433701;
        bh=DnIwg6VgzGaoIjk8gxwWOVQiyx9yDkP0EXKaYc4Z/8Q=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ZYUZ8zG2z3RzqhzsDlLQH9cjfROpYBcfKaQgFGH1cncg6ENxO/GIIJvYQoLAsx/l8
         XEQADTjdtjHodRBtuXuFNrtOF/vK88Ccp4KfsW/Ic1gxKnbdCh5Xxo2MymZZg9mQUF
         WkpdK4H3o3BrsZ1t4XSJPX8ZcMOUA3gBQ5n212EQ=
Date:   Tue, 21 Mar 2023 14:21:40 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Bernd Schubert <bschubert@ddn.com>
Cc:     linux-fsdevel@vger.kernel.org, Dharmendra Singh <dsingh@ddn.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Christoph Hellwig <hch@infradead.org>, linux-mm@kvack.org,
        Miklos Szeredi <miklos@szeredi.hu>,
        Amir Goldstein <amir73il@gmail.com>,
        fuse-devel@lists.sourceforge.net
Subject: Re: [PATCH 04/13] Add a vmalloc_node_user function
Message-Id: <20230321142140.356d7e2634c7246e0bb69993@linux-foundation.org>
In-Reply-To: <20230321011047.3425786-5-bschubert@ddn.com>
References: <20230321011047.3425786-1-bschubert@ddn.com>
        <20230321011047.3425786-5-bschubert@ddn.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 21 Mar 2023 02:10:38 +0100 Bernd Schubert <bschubert@ddn.com> wrote:

> This is to have a numa aware vmalloc function for memory exposed to
> userspace. Fuse uring will allocate queue memory using this
> new function.
> 

Acked-by: Andrew Morton <akpm@linux-foundation.org>
