Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6536811461A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Dec 2019 18:40:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730164AbfLERk4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Dec 2019 12:40:56 -0500
Received: from mx2.suse.de ([195.135.220.15]:36112 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729598AbfLERk4 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Dec 2019 12:40:56 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 08D7FAF65;
        Thu,  5 Dec 2019 17:40:55 +0000 (UTC)
Date:   Thu, 5 Dec 2019 18:40:53 +0100
From:   Johannes Thumshirn <jthumshirn@suse.de>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Goldwyn Rodrigues <rgoldwyn@suse.de>, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, darrick.wong@oracle.com,
        fdmanana@kernel.org, nborisov@suse.com, dsterba@suse.cz,
        Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: Re: [PATCH 4/8] btrfs: Switch to iomap_dio_rw() for dio
Message-ID: <20191205174053.GD19670@Johanness-MacBook-Pro.local>
References: <20191205155630.28817-1-rgoldwyn@suse.de>
 <20191205155630.28817-5-rgoldwyn@suse.de>
 <20191205171815.GA19670@Johanness-MacBook-Pro.local>
 <20191205171959.GA8586@infradead.org>
 <20191205173242.GB19670@Johanness-MacBook-Pro.local>
 <20191205173346.GA26969@infradead.org>
 <20191205173648.GC19670@Johanness-MacBook-Pro.local>
 <20191205173728.GA32341@infradead.org>
 <20191205173743.GB32341@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191205173743.GB32341@infradead.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 05, 2019 at 09:37:43AM -0800, Christoph Hellwig wrote:
> On Thu, Dec 05, 2019 at 09:37:28AM -0800, Christoph Hellwig wrote:
> > On Thu, Dec 05, 2019 at 06:36:48PM +0100, Johannes Thumshirn wrote:
> > > To hide the implementation details and not provoke someone yelling layering
> > > violation?
> > 
> > The only layering is ->direct_IO, and this is a step to get rid of that
> > junk..
> 
> s/layering/layering violation/

OK I admit defeat.

Byte,
	Johannes
