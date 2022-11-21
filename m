Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44247631AA3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Nov 2022 08:50:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbiKUHuh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Nov 2022 02:50:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiKUHug (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Nov 2022 02:50:36 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E4DE31DC2
        for <linux-fsdevel@vger.kernel.org>; Sun, 20 Nov 2022 23:50:35 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 0E77868AA6; Mon, 21 Nov 2022 08:50:33 +0100 (CET)
Date:   Mon, 21 Nov 2022 08:50:32 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs: simplify vfs_get_super
Message-ID: <20221121075032.GA24804@lst.de>
References: <20221031124626.381838-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221031124626.381838-1-hch@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 31, 2022 at 01:46:26PM +0100, Christoph Hellwig wrote:
> Remove the pointless keying argument and associated enum and pass the
> fill_super callback and a "bool reconf" instead.  Also mark the function
> static given that there are no users outside of super.c.

Al, can you pick this one up?
