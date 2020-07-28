Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94D1222FF17
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jul 2020 03:49:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726895AbgG1Btw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Jul 2020 21:49:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbgG1Btw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Jul 2020 21:49:52 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB3E0C061794;
        Mon, 27 Jul 2020 18:49:51 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k0EkT-0041PM-RQ; Tue, 28 Jul 2020 01:49:45 +0000
Date:   Tue, 28 Jul 2020 02:49:45 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Jan Kara <jack@suse.cz>
Cc:     Christoph Hellwig <hch@lst.de>, x86@kernel.org,
        Jan Kara <jack@suse.com>, linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH 4/4] quota: simplify the quotactl compat handling
Message-ID: <20200728014945.GA951209@ZenIV.linux.org.uk>
References: <20200726160401.311569-1-hch@lst.de>
 <20200726160401.311569-5-hch@lst.de>
 <20200727124127.GO23179@quack2.suse.cz>
 <20200727155616.GF794331@ZenIV.linux.org.uk>
 <20200727213158.GM5284@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200727213158.GM5284@quack2.suse.cz>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 27, 2020 at 11:31:58PM +0200, Jan Kara wrote:
> On Mon 27-07-20 16:56:16, Al Viro wrote:
> > On Mon, Jul 27, 2020 at 02:41:27PM +0200, Jan Kara wrote:
> > > On Sun 26-07-20 18:04:01, Christoph Hellwig wrote:
> > > > Fold the misaligned u64 workarounds into the main quotactl flow instead
> > > > of implementing a separate compat syscall handler.
> > > > 
> > > > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > > 
> > > The patch looks good to me and it saves a lot of boiler-plate code so feel
> > > free to add:
> > > 
> > > Acked-by: Jan Kara <jack@suse.cz>
> > 
> > Which tree do we put that through?  I can grab it into vfs.git, but IIRC usually
> > you put quota-related stuff through yours...
> 
> I can take it through quota tree as well but I thought it's not a great fit
> given the generic arch bits which this last patch depends on...

OK, into vfs.git it goes, then...
