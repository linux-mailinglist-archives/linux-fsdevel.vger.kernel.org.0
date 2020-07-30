Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE033232AA8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jul 2020 06:01:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726261AbgG3EBI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Jul 2020 00:01:08 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:49647 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725765AbgG3EBI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Jul 2020 00:01:08 -0400
Received: from callcc.thunk.org (pool-96-230-252-158.bstnma.fios.verizon.net [96.230.252.158])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 06U40hmE028092
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Jul 2020 00:00:44 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id B1260420304; Thu, 30 Jul 2020 00:00:43 -0400 (EDT)
Date:   Thu, 30 Jul 2020 00:00:43 -0400
From:   tytso@mit.edu
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Dave Chinner <david@fromorbit.com>,
        Goldwyn Rodrigues <rgoldwyn@suse.de>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <jth@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        cluster-devel@redhat.com, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, Dave Chinner <dchinner@redhat.com>,
        Goldwyn Rodrigues <rgoldwyn@suse.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 3/3] iomap: fall back to buffered writes for invalidation
 failures
Message-ID: <20200730040043.GA202592@mit.edu>
References: <20200721183157.202276-1-hch@lst.de>
 <20200721183157.202276-4-hch@lst.de>
 <20200722231352.GE848607@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200722231352.GE848607@magnolia>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 22, 2020 at 04:13:52PM -0700, Darrick J. Wong wrote:
> Hey Ted,
> 
> Could you please review the fs/ext4/ part of this patch (it's the
> follow-on to the directio discussion I had with you last week) so that I
> can get this moving for 5.9? Thx,

Reviewed-by: Theodore Ts'o <tytso@mit.edu> # for ext4

	     	      	   		     - Ted
