Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32E9D32E1FF
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Mar 2021 07:10:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229486AbhCEGKN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Mar 2021 01:10:13 -0500
Received: from verein.lst.de ([213.95.11.211]:44866 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229448AbhCEGKM (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Mar 2021 01:10:12 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 7893F68BFE; Fri,  5 Mar 2021 07:10:08 +0100 (CET)
Date:   Fri, 5 Mar 2021 07:10:08 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, dm-devel@redhat.com,
        darrick.wong@oracle.com, dan.j.williams@intel.com,
        david@fromorbit.com, agk@redhat.com, snitzer@redhat.com,
        rgoldwyn@suse.de, qi.fuli@fujitsu.com, y-goto@fujitsu.com
Subject: Re: [PATCH v3 02/11] blk: Introduce ->corrupted_range() for block
 device
Message-ID: <20210305061008.GA15141@lst.de>
References: <20210208105530.3072869-1-ruansy.fnst@cn.fujitsu.com> <20210208105530.3072869-3-ruansy.fnst@cn.fujitsu.com> <20210210132139.GC30109@lst.de> <20210304224250.GF3419940@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210304224250.GF3419940@magnolia>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 04, 2021 at 02:42:50PM -0800, Darrick J. Wong wrote:
> My vision here, however, is to establish upcalls for /both/ types of
> stroage.

I already have patches for doing these kinds of callbacks properly
for the block layer. They will be posted shortly.
