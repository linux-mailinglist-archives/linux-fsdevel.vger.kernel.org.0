Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 672DB114610
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Dec 2019 18:36:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730033AbfLERgw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Dec 2019 12:36:52 -0500
Received: from mx2.suse.de ([195.135.220.15]:35006 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729598AbfLERgw (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Dec 2019 12:36:52 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5054AAF7A;
        Thu,  5 Dec 2019 17:36:50 +0000 (UTC)
Date:   Thu, 5 Dec 2019 18:36:48 +0100
From:   Johannes Thumshirn <jthumshirn@suse.de>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Goldwyn Rodrigues <rgoldwyn@suse.de>, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, darrick.wong@oracle.com,
        fdmanana@kernel.org, nborisov@suse.com, dsterba@suse.cz,
        Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: Re: [PATCH 4/8] btrfs: Switch to iomap_dio_rw() for dio
Message-ID: <20191205173648.GC19670@Johanness-MacBook-Pro.local>
References: <20191205155630.28817-1-rgoldwyn@suse.de>
 <20191205155630.28817-5-rgoldwyn@suse.de>
 <20191205171815.GA19670@Johanness-MacBook-Pro.local>
 <20191205171959.GA8586@infradead.org>
 <20191205173242.GB19670@Johanness-MacBook-Pro.local>
 <20191205173346.GA26969@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191205173346.GA26969@infradead.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 05, 2019 at 09:33:46AM -0800, Christoph Hellwig wrote:
> On Thu, Dec 05, 2019 at 06:32:42PM +0100, Johannes Thumshirn wrote:
> > Meaning we do not need to export generic_file_buffered_read() and still can
> > skip the generic DIO madness.
> 
> But why not export it?  That way we call the function we want directly
> instead of through a wrapper that is entirely pointless for this case.

To hide the implementation details and not provoke someone yelling layering
violation?

