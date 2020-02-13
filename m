Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D27F615CAE4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Feb 2020 20:05:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727931AbgBMTFP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Feb 2020 14:05:15 -0500
Received: from mga18.intel.com ([134.134.136.126]:15702 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726282AbgBMTFO (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Feb 2020 14:05:14 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Feb 2020 11:05:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,437,1574150400"; 
   d="scan'208";a="347785343"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
  by fmsmga001.fm.intel.com with ESMTP; 13 Feb 2020 11:05:13 -0800
Date:   Thu, 13 Feb 2020 11:05:13 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Jeff Moyer <jmoyer@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 00/12] Enable per-file/directory DAX operations V3
Message-ID: <20200213190513.GB22854@iweiny-DESK2.sc.intel.com>
References: <20200208193445.27421-1-ira.weiny@intel.com>
 <x49imke1nj0.fsf@segfault.boston.devel.redhat.com>
 <20200211201718.GF12866@iweiny-DESK2.sc.intel.com>
 <x49sgjf1t7n.fsf@segfault.boston.devel.redhat.com>
 <20200213190156.GA22854@iweiny-DESK2.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200213190156.GA22854@iweiny-DESK2.sc.intel.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 13, 2020 at 11:01:57AM -0800, 'Ira Weiny' wrote:
> On Wed, Feb 12, 2020 at 02:49:48PM -0500, Jeff Moyer wrote:
> > Ira Weiny <ira.weiny@intel.com> writes:
> > 
 
[snip]

> > Given that we document the dax mount
> > option as "the way to get dax," it may be a good idea to allow for a
> > user to selectively disable dax, even when -o dax is specified.  Is that
> > possible?
> 
> Not with this patch set.  And I'm not sure how that would work.  The idea was
> that -o dax was simply an override for users who were used to having their
> entire FS be dax.  We wanted to depreciate the use of "-o dax" in general.  The
> individual settings are saved so I don't think it makes sense to ignore the -o
> dax in favor of those settings.  Basically that would IMO make the -o dax
> useless.

Oh and I forgot to mention that setting 'dax' on the root of the FS basically
provides '-o dax' functionality by default with the ability to "turn it off"
for files.

Ira

> 
> Ira
> 
