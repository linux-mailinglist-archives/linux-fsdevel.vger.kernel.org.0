Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8259A669F6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jul 2019 11:34:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726085AbfGLJem (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Jul 2019 05:34:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:33144 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725987AbfGLJel (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Jul 2019 05:34:41 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 42A7CB008;
        Fri, 12 Jul 2019 09:34:39 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 9B4D21E43CA; Fri, 12 Jul 2019 11:34:38 +0200 (CEST)
Date:   Fri, 12 Jul 2019 11:34:38 +0200
From:   Jan Kara <jack@suse.cz>
To:     Steve Magnani <steve.magnani@digidescorp.com>
Cc:     Jan Kara <jack@suse.cz>,
        "Steven J . Magnani" <steve@digidescorp.com>,
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>,
        Jan Kara <jack@suse.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] udf: support 2048-byte spacing of VRS descriptors
 on 4K media
Message-ID: <20190712093438.GD906@quack2.suse.cz>
References: <20190711133852.16887-1-steve@digidescorp.com>
 <20190711133852.16887-2-steve@digidescorp.com>
 <20190711150436.GA2449@quack2.suse.cz>
 <6abea3a8-53da-f7ed-33f5-a9ecfd386c56@digidescorp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6abea3a8-53da-f7ed-33f5-a9ecfd386c56@digidescorp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 11-07-19 10:56:52, Steve Magnani wrote:
> On 7/11/19 10:04 AM, Jan Kara wrote:
> > Thanks for the patches! I've added them to my tree and somewhat simplified
> > the logic since we don't really care about nsr 2 vs 3 or whether we
> > actually saw BEA or not. Everything seems to work fine for me but I'd
> > appreciate if you could doublecheck - the result is pushed out to
> > 
> > git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git for_next
> > 
> Tested-by: Steven J. Magnani <steve@digidescorp.com>
> 
> The rework is more permissive than what you had suggested initially
> (conditioning acceptance of a noncompliant NSR on a preceding BEA).
> I had also tried to code the original so that a malformed 2048-byte
> interval VRS would not be accepted. But the simplifications do make
> the code easier to follow...

Yeah, it's simpler to follow and we do this check just to see whether this
may be a valid UDF media before doing more expensive probing. So I don't
think that the code being more permissive matters. Thanks for testing!

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
