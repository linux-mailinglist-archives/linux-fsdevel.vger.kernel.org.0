Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE6F34AB55A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Feb 2022 08:00:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239478AbiBGG5v (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Feb 2022 01:57:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233171AbiBGGv4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Feb 2022 01:51:56 -0500
X-Greylist: delayed 79 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 06 Feb 2022 22:51:55 PST
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43879C043181
        for <linux-fsdevel@vger.kernel.org>; Sun,  6 Feb 2022 22:51:55 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 91DB468BFE; Mon,  7 Feb 2022 07:51:52 +0100 (CET)
Date:   Mon, 7 Feb 2022 07:51:52 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Christian Brauner <brauner@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org,
        Seth Forshee <seth.forshee@digitalocean.com>,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH 4/7] fs: add mnt_allow_writers() and simplify
 mount_setattr_prepare()
Message-ID: <20220207065152.GD23601@lst.de>
References: <20220203131411.3093040-1-brauner@kernel.org> <20220203131411.3093040-5-brauner@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220203131411.3093040-5-brauner@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 03, 2022 at 02:14:08PM +0100, Christian Brauner wrote:
> Add a tiny helper that lets us simplify the control-flow and can be used
> in the next patch to avoid adding another condition open-coded into
> mount_setattr_prepare(). Instead we can add it into the new helper.

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
