Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1ADA3314C53
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Feb 2021 11:01:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230296AbhBIKAi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Feb 2021 05:00:38 -0500
Received: from mx2.suse.de ([195.135.220.15]:57112 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229752AbhBIJ6e (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Feb 2021 04:58:34 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id AF54EB133;
        Tue,  9 Feb 2021 09:57:48 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 54D241E14AC; Tue,  9 Feb 2021 10:57:48 +0100 (CET)
Date:   Tue, 9 Feb 2021 10:57:48 +0100
From:   Jan Kara <jack@suse.cz>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jan Kara <jack@suse.cz>, Sascha Hauer <s.hauer@pengutronix.de>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, Jan Kara <jack@suse.com>,
        Richard Weinberger <richard@nod.at>
Subject: Re: [PATCH 1/2] quota: Add mountpath based quota support
Message-ID: <20210209095748.GA19070@quack2.suse.cz>
References: <20210128141713.25223-1-s.hauer@pengutronix.de>
 <20210128141713.25223-2-s.hauer@pengutronix.de>
 <20210128143552.GA2042235@infradead.org>
 <20210202180241.GE17147@quack2.suse.cz>
 <20210204073414.GA126863@infradead.org>
 <20210204125350.GD20183@quack2.suse.cz>
 <20210209085101.GA1710733@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210209085101.GA1710733@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 09-02-21 08:51:01, Christoph Hellwig wrote:
> On Thu, Feb 04, 2021 at 01:53:50PM +0100, Jan Kara wrote:
> > Now quota data stored in a normal file is a setup we try to deprecate
> > anyway so another option is to just leave quotactl_path() only for those
> > setups where quota metadata is managed by the filesystem so we don't need
> > to pass quota files to Q_QUOTAON?
> 
> I'd be perfectly fine with that.

OK, then this looks like the best way forward to me. We can always extend
the quotactl_path() syscall later if we find this is problematic for some
real usecases.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
