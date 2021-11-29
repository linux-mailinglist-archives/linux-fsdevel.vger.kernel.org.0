Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03BA14613CF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Nov 2021 12:23:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239779AbhK2L1C (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Nov 2021 06:27:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237081AbhK2LZB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Nov 2021 06:25:01 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1996BC08EA4D
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Nov 2021 02:37:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AC67661280
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Nov 2021 10:37:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC53FC004E1;
        Mon, 29 Nov 2021 10:37:00 +0000 (UTC)
Date:   Mon, 29 Nov 2021 11:36:57 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Christoph Hellwig <hch@lst.de>,
        Seth Forshee <sforshee@digitalocean.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 00/10] Extend and tweak mapping support
Message-ID: <20211129103657.dhkecslgf76e6svf@wittgenstein>
References: <20211123114227.3124056-1-brauner@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211123114227.3124056-1-brauner@kernel.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 23, 2021 at 12:42:17PM +0100, Christian Brauner wrote:
> From: Christian Brauner <christian.brauner@ubuntu.com>
> 
> Hey,
> 
> This series extend the mapping infrastructure in order to support mapped
> mounts of mapped filesystems in the future.

Friendly ping. Would be good to get a review for this.

Christian
