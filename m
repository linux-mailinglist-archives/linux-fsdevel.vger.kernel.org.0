Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8F5867861A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jan 2023 20:19:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232653AbjAWTTD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Jan 2023 14:19:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232413AbjAWTS3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Jan 2023 14:18:29 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1210432E5D;
        Mon, 23 Jan 2023 11:18:16 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 2BE9F68C7B; Mon, 23 Jan 2023 20:18:13 +0100 (CET)
Date:   Mon, 23 Jan 2023 20:18:13 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        Hugh Dickins <hughd@google.com>, linux-afs@lists.infradead.org,
        linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        cluster-devel@redhat.com, linux-mm@kvack.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-nilfs@vger.kernel.org
Subject: Re: return an ERR_PTR from __filemap_get_folio v2
Message-ID: <20230123191813.GA16510@lst.de>
References: <20230121065755.1140136-1-hch@lst.de> <20230121170641.121f4224a0e8304765bb4738@linux-foundation.org> <20230122072006.GA3654@lst.de> <20230123105945.958075d46b0a05ffd545e276@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230123105945.958075d46b0a05ffd545e276@linux-foundation.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 23, 2023 at 10:59:45AM -0800, Andrew Morton wrote:
> On Sun, 22 Jan 2023 08:20:06 +0100 Christoph Hellwig <hch@lst.de> wrote:
> 
> > On Sat, Jan 21, 2023 at 05:06:41PM -0800, Andrew Morton wrote:
> > > This patchset doesn't apply to fs/btrfs/ because linux-next contains
> > > this 6+ month-old commit:
> > 
> > Hmm.  It was literally written against linux-next as of last morning,
> > which does not have that commit.
> 
> Confused.  According to 
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/fs/btrfs/disk-io.c#n4023
> 
> it's there today.  wait_dev_supers() has been foliofied.

Yes, it's there now.  But I'm pretty sure it wasn't there when
I did the last rebase.  Weird.
