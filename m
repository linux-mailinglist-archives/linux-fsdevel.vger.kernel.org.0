Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C465414FEA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Sep 2021 20:33:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237037AbhIVSet (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Sep 2021 14:34:49 -0400
Received: from verein.lst.de ([213.95.11.211]:60935 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232806AbhIVSer (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Sep 2021 14:34:47 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id E535E67373; Wed, 22 Sep 2021 20:33:13 +0200 (CEST)
Date:   Wed, 22 Sep 2021 20:33:13 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-ext4 <linux-ext4@vger.kernel.org>
Subject: Re: dax_supported() related cleanups v2
Message-ID: <20210922183313.GA24528@lst.de>
References: <20210922173431.2454024-1-hch@lst.de> <CAPcyv4jpTyzofDyUPi7ADbGcV+cJHSohctwxu5yDNTF34KWeOg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4jpTyzofDyUPi7ADbGcV+cJHSohctwxu5yDNTF34KWeOg@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 22, 2021 at 10:55:01AM -0700, Dan Williams wrote:
> This looks like your send script picked up the wrong cover letter?

Yes.  Or the human running the script to be exact :)
