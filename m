Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F4744AB55B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Feb 2022 08:00:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239567AbiBGG5x (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Feb 2022 01:57:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233369AbiBGGxU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Feb 2022 01:53:20 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 560D5C043181
        for <linux-fsdevel@vger.kernel.org>; Sun,  6 Feb 2022 22:53:19 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id ACA9B68BFE; Mon,  7 Feb 2022 07:53:16 +0100 (CET)
Date:   Mon, 7 Feb 2022 07:53:16 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Christian Brauner <brauner@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org,
        Seth Forshee <seth.forshee@digitalocean.com>,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH 7/7] fs: clean up mount_setattr control flow
Message-ID: <20220207065316.GG23601@lst.de>
References: <20220203131411.3093040-1-brauner@kernel.org> <20220203131411.3093040-8-brauner@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220203131411.3093040-8-brauner@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 03, 2022 at 02:14:11PM +0100, Christian Brauner wrote:
> Simplify the control flow of mount_setattr_{prepare,commit} so they
> became easiert to follow. We kept using both an integer error variable

s/became easiert/become easier/g

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
