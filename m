Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 50F44E9ABC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Oct 2019 12:26:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726187AbfJ3L0z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Oct 2019 07:26:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:50618 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726065AbfJ3L0z (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Oct 2019 07:26:55 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 38EC4ABBE;
        Wed, 30 Oct 2019 11:26:53 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id B811E1E485C; Wed, 30 Oct 2019 12:26:52 +0100 (CET)
Date:   Wed, 30 Oct 2019 12:26:52 +0100
From:   Jan Kara <jack@suse.cz>
To:     Matthew Bobrowski <mbobrowski@mbobrowski.org>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>, jack@suse.cz,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, hch@infradead.org,
        david@fromorbit.com, darrick.wong@oracle.com
Subject: Re: [PATCH v6 00/11] ext4: port direct I/O to iomap infrastructure
Message-ID: <20191030112652.GF28525@quack2.suse.cz>
References: <cover.1572255424.git.mbobrowski@mbobrowski.org>
 <20191029233159.GA8537@mit.edu>
 <20191029233401.GB8537@mit.edu>
 <20191030020022.GA7392@bobrowski>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191030020022.GA7392@bobrowski>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 30-10-19 13:00:24, Matthew Bobrowski wrote:
> On Tue, Oct 29, 2019 at 07:34:01PM -0400, Theodore Y. Ts'o wrote:
> > On Tue, Oct 29, 2019 at 07:31:59PM -0400, Theodore Y. Ts'o wrote:
> > > Hi Matthew, it looks like there are a number of problems with this
> > > patch series when using the ext3 backwards compatibility mode (e.g.,
> > > no extents enabled).
> > > 
> > > So the following configurations are failing:
> > > 
> > > kvm-xfstests -c ext3   generic/091 generic/240 generic/263
> 
> This is one mode that I didn't get around to testing. Let me take a
> look at the above and get back to you.

If I should guess, I'd start looking at what that -ENOTBLK fallback from
direct IO ends up doing as we seem to be hitting that path...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
