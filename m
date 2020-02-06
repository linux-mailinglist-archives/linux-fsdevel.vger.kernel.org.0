Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E491153FB9
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2020 09:04:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727111AbgBFIEk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Feb 2020 03:04:40 -0500
Received: from mx2.suse.de ([195.135.220.15]:33062 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726673AbgBFIEk (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Feb 2020 03:04:40 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id ACCC6B221;
        Thu,  6 Feb 2020 08:04:38 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 91B721E0E31; Thu,  6 Feb 2020 09:04:38 +0100 (CET)
Date:   Thu, 6 Feb 2020 09:04:38 +0100
From:   Jan Kara <jack@suse.cz>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 8/8] xarray: Don't clear marks in xas_store()
Message-ID: <20200206080438.GC14001@quack2.suse.cz>
References: <20200204142514.15826-1-jack@suse.cz>
 <20200204142514.15826-9-jack@suse.cz>
 <8ea2682b-7240-dca3-b123-2df7d0c994ba@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8ea2682b-7240-dca3-b123-2df7d0c994ba@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 05-02-20 14:19:34, John Hubbard wrote:
> On 2/4/20 6:25 AM, Jan Kara wrote:
> > When storing NULL in xarray, xas_store() has been clearing all marks
> > because it could otherwise confuse xas_for_each_marked(). That is
> > however no longer true and no current user relies on this behavior.
> 
> 
> However, let's not forget that the API was also documented to behave
> in this way--it's not an accidental detail. Below...

Yeah, we'll need to sort out details how we want the API to be used but
thanks for reminding me I should update the documentation :). It was on my
radar but then I forgot...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
