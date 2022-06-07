Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BAB153FDC7
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jun 2022 13:46:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243076AbiFGLq4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Jun 2022 07:46:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242178AbiFGLq4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Jun 2022 07:46:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 903F47B9E4
        for <linux-fsdevel@vger.kernel.org>; Tue,  7 Jun 2022 04:46:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 29C34616C7
        for <linux-fsdevel@vger.kernel.org>; Tue,  7 Jun 2022 11:46:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FF79C385A5;
        Tue,  7 Jun 2022 11:46:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654602414;
        bh=Dc/0RKLSHLis7DHqoMzXhc4i4nKX/UA4ROB2ETb9qGM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UnuTVZzAsvGJzjVXmcLT3FhZq2KIH3xarc8Pae7zkgDU1X1Vqr76bTZOLxkRKHZ7r
         wGZHa6HbOkrfypOiCZUNhaTSGb6+xJZAZpakuWK4YtgYmx5uwQosDH5jHd0QxdVOFb
         4sjd6fp4sFpERQzne8moUaR1wl6C6Z037ZJvr78kB0yUu6B51l2xPN4orx978Lyc7k
         QIx0WAfeWUlK9CXLNgfQVxODfm6A5SdTRzqLXSxbkIH+uV+VMaz8MeUnsgdie6iRJO
         ER3PaGbqLRCzPK0llTkipeQVUnJN58Tyaq1+332OyzbtEH6Efkg0yl4wlVm46gAOkZ
         pUrSszAa6To1w==
Date:   Tue, 7 Jun 2022 13:46:44 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH 3/9] struct file: use anonymous union member for rcuhead
 and llist
Message-ID: <20220607114644.mi4zscoeqiajbmyb@wittgenstein>
References: <Yp7PTZ2nckKDTkKu@zeniv-ca.linux.org.uk>
 <Yp7PtAl5fuh/hqhS@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Yp7PtAl5fuh/hqhS@zeniv-ca.linux.org.uk>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 07, 2022 at 04:10:28AM +0000, Al Viro wrote:
> Once upon a time we couldn't afford anon unions; these days minimal
> gcc version had been raised enough to take care of that.
> ---

Neat,
Reviewed-by: Christian Brauner (Microsoft) <brauner@kernel.org>
