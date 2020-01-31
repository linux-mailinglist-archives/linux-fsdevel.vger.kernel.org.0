Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6DC4E14F304
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Jan 2020 21:04:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726102AbgAaUEW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 31 Jan 2020 15:04:22 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:46105 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725954AbgAaUEW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 31 Jan 2020 15:04:22 -0500
Received: from callcc.thunk.org (guestnat-104-133-9-100.corp.google.com [104.133.9.100] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 00VK4CxZ015136
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 31 Jan 2020 15:04:14 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id A7F13420324; Fri, 31 Jan 2020 15:04:11 -0500 (EST)
Date:   Fri, 31 Jan 2020 15:04:11 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     lsf-pc@lists.linux-foundation.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        linux-block@vger.kernel.org, martin.petersen@oracle.com,
        Allison Collins <allison.henderson@oracle.com>,
        bob.liu@oracle.com
Subject: Re: [LSF/MM/BPF TOPIC] selectively cramming things onto struct bio
Message-ID: <20200131200411.GF332835@mit.edu>
References: <20200131004447.GA6869@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200131004447.GA6869@magnolia>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 30, 2020 at 04:44:47PM -0800, Darrick J. Wong wrote:
> Hi everyone,
> 
> Several months ago, there was a discussion[1] about enhancing XFS to
> take a more active role in recoverying damaged blocks from a redundant
> storage device when the block device doesn't signal an error but the
> filesystem can tell that something is wrong.
> 
> Yes, we (XFS) would like to be able to exhaust all available storage
> redundancy before we resort to rebuilding lost metadata, and we'd like
> to do that without implementing our own RAID layer.
> 
> In the end, the largest stumbling block seems to be how to attach
> additional instructions to struct bio.  Jens rejected the idea of adding
> more pointers or more bytes to a struct bio since we'd be forcing
> everyone to pay the extra memory price for a feature that in the ideal
> situation will be used infrequently.

I'd be interested in this discussion as well; the issue came up when
adding support for hardware-based inline-crypto support.

							- Ted
