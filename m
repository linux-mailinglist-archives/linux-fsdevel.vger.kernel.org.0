Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3E2578EEAE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Aug 2023 15:32:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244831AbjHaNcf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 31 Aug 2023 09:32:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237683AbjHaNce (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 31 Aug 2023 09:32:34 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ABD0E4F;
        Thu, 31 Aug 2023 06:32:32 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id E3F8468BEB; Thu, 31 Aug 2023 15:32:27 +0200 (CEST)
Date:   Thu, 31 Aug 2023 15:32:27 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, brauner@kernel.org,
        trond.myklebust@hammerspace.com, anna@kernel.org, jack@suse.cz,
        linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] NFS: switch back to using kill_anon_super
Message-ID: <20230831133227.GB12262@lst.de>
References: <20230831052940.256193-1-hch@lst.de> <2f121ee5b7fad547ac833a5e0e986866d1177e21.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2f121ee5b7fad547ac833a5e0e986866d1177e21.camel@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 31, 2023 at 09:29:14AM -0400, Jeff Layton wrote:
> Nice. Long overdue. This also might explain why ceph was once this way
> before we changed it here:
> 
>     470a5c77eac0 ceph: use kill_anon_super helper

Yes, that looks like the same workaround for bdi lifetimes.
