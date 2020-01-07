Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B672B132A0B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jan 2020 16:29:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727994AbgAGP3j (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Jan 2020 10:29:39 -0500
Received: from mx2.suse.de ([195.135.220.15]:56036 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727944AbgAGP3j (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Jan 2020 10:29:39 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 0D113AE2D;
        Tue,  7 Jan 2020 15:29:38 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 4B6051E0B47; Tue,  7 Jan 2020 16:29:36 +0100 (CET)
Date:   Tue, 7 Jan 2020 16:29:36 +0100
From:   Jan Kara <jack@suse.cz>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
        Jan Kara <jack@suse.com>
Subject: Re: udf_count_free() and UDF discs with Metadata partition
Message-ID: <20200107152936.GG25547@quack2.suse.cz>
References: <20191226113750.rcfmbs643sfnpixq@pali>
 <20200107144518.GF25547@quack2.suse.cz>
 <20200107150142.ltujuqgillgqhvx2@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200107150142.ltujuqgillgqhvx2@pali>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 07-01-20 16:01:42, Pali Rohár wrote:
> On Tuesday 07 January 2020 15:45:18 Jan Kara wrote:
> > > Calculation problem in udfinfo I fixed in this commit:
> > > https://github.com/pali/udftools/commit/1763c9f899bdbdb68b1a44a8cb5edd5141107043
> > 
> > Thanks for the link, I'll fixup the kernel code. BTW, how did you test
> > this? Do you have any UDF image with Metadata partition?
> 
> I have CD, DVD, HD-DVD and BD images with just one file (so they have
> lot of empty space) in all variants (plain, Sparing, VAT) and all
> possible UDF revisions (1.02 - 2.60) created by some very very ancient
> Windows Nero software. Some of them discovered bugs in libblkid UDF
> implementation and are therefore included as part of util-linux project
> for running util-linux tests. Plain and Sparing UDF 2.50 and 2.60 images
> have Metadata partition as required by specification.
> 
> If you want I can send you a whole pack of all those images.

That would be nice. Thanks!

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
