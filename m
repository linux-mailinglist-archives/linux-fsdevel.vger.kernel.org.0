Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 323CC2CDD1E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Dec 2020 19:09:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731297AbgLCSJY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Dec 2020 13:09:24 -0500
Received: from verein.lst.de ([213.95.11.211]:59661 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730964AbgLCSJY (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Dec 2020 13:09:24 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 302CF67357; Thu,  3 Dec 2020 19:08:39 +0100 (CET)
Date:   Thu, 3 Dec 2020 19:08:39 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Eric Sandeen <sandeen@sandeen.net>
Cc:     Christoph Hellwig <hch@lst.de>, ira.weiny@intel.com,
        fstests@vger.kernel.org, Eric Sandeen <sandeen@redhat.com>,
        linux-kernel@vger.kernel.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        Jeff Moyer <jmoyer@redhat.com>, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        David Howells <dhowells@redhat.com>
Subject: Re: [PATCH] common/rc: Fix _check_s_dax()
Message-ID: <20201203180838.GA25196@lst.de>
References: <20201202214145.1563433-1-ira.weiny@intel.com> <20201203081556.GA15306@lst.de> <b757842d-b020-49c9-498c-df5de89f10af@sandeen.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b757842d-b020-49c9-498c-df5de89f10af@sandeen.net>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 03, 2020 at 11:55:50AM -0600, Eric Sandeen wrote:
> *nod* and my suggestion was to explicitly test for the old/wrong value and
> offer the test-runner a hint about why it may have been set (missing the
> fix commit), but we should still ultimately fail the test when it is seen.

Yes, that's what I'd prefer.
