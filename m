Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 095884AB56C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Feb 2022 08:02:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241904AbiBGG6q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Feb 2022 01:58:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239195AbiBGG5M (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Feb 2022 01:57:12 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E734FC043184
        for <linux-fsdevel@vger.kernel.org>; Sun,  6 Feb 2022 22:57:10 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 33DC868B05; Mon,  7 Feb 2022 07:50:48 +0100 (CET)
Date:   Mon, 7 Feb 2022 07:50:47 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Christian Brauner <brauner@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org,
        Seth Forshee <seth.forshee@digitalocean.com>,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH 2/7] MAINTAINERS: add entry for idmapped mounts
Message-ID: <20220207065047.GB23601@lst.de>
References: <20220203131411.3093040-1-brauner@kernel.org> <20220203131411.3093040-3-brauner@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220203131411.3093040-3-brauner@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 03, 2022 at 02:14:06PM +0100, Christian Brauner wrote:
> I'd like to continue maintaining the work that was done around idmapped,
> make sure that I'm Cced on new patches and work that impacts the
> infrastructure.

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
