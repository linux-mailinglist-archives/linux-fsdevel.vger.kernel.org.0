Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66D30445007
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Nov 2021 09:17:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230390AbhKDIUV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Nov 2021 04:20:21 -0400
Received: from verein.lst.de ([213.95.11.211]:34262 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230152AbhKDIUV (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Nov 2021 04:20:21 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 9396E68AA6; Thu,  4 Nov 2021 09:17:40 +0100 (CET)
Date:   Thu, 4 Nov 2021 09:17:40 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Eric Sandeen <sandeen@sandeen.net>
Cc:     Christoph Hellwig <hch@lst.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Ira Weiny <ira.weiny@intel.com>, dm-devel@redhat.com,
        linux-xfs@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-s390@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: Re: futher decouple DAX from block devices
Message-ID: <20211104081740.GA23111@lst.de>
References: <20211018044054.1779424-1-hch@lst.de> <21ff4333-e567-2819-3ae0-6a2e83ec7ce6@sandeen.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <21ff4333-e567-2819-3ae0-6a2e83ec7ce6@sandeen.net>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 03, 2021 at 12:59:31PM -0500, Eric Sandeen wrote:
> Christoph, can I ask what the end game looks like, here? If dax is completely
> decoupled from block devices, are there user-visible changes?

Yes.

> If I want to
> run fs-dax on a pmem device - what do I point mkfs at, if not a block device?

The rough plan is to use the device dax character devices.  I'll hopefully
have a draft version in the next days.
