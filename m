Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94D802CEB54
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Dec 2020 10:49:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387696AbgLDJsh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Dec 2020 04:48:37 -0500
Received: from verein.lst.de ([213.95.11.211]:33954 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387601AbgLDJsg (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Dec 2020 04:48:36 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id E834E6736F; Fri,  4 Dec 2020 10:47:52 +0100 (CET)
Date:   Fri, 4 Dec 2020 10:47:52 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     ira.weiny@intel.com
Cc:     fstests@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Eric Sandeen <sandeen@redhat.com>,
        linux-kernel@vger.kernel.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        Jeff Moyer <jmoyer@redhat.com>, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        David Howells <dhowells@redhat.com>
Subject: Re: [PATCH V3] common/rc: Fix _check_s_dax()
Message-ID: <20201204094752.GA10630@lst.de>
References: <20201202214629.1563760-1-ira.weiny@intel.com> <20201204014550.1736306-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201204014550.1736306-1-ira.weiny@intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
