Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A13718548F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Mar 2020 04:49:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726569AbgCNDtQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Mar 2020 23:49:16 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:39963 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726399AbgCNDtQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Mar 2020 23:49:16 -0400
Received: from callcc.thunk.org (pool-72-93-95-157.bstnma.fios.verizon.net [72.93.95.157])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 02E3mxYt004898
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Mar 2020 23:48:59 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 1F870420E5E; Fri, 13 Mar 2020 23:48:59 -0400 (EDT)
Date:   Fri, 13 Mar 2020 23:48:59 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     Matthew Wilcox <willy@infradead.org>, linux-ext4@vger.kernel.org,
        jack@suse.cz, adilger.kernel@dilger.ca,
        linux-fsdevel@vger.kernel.org, darrick.wong@oracle.com,
        hch@infradead.org, cmaiolino@redhat.com, david@fromorbit.com
Subject: Re: [PATCHv5 6/6] Documentation: Correct the description of
 FIEMAP_EXTENT_LAST
Message-ID: <20200314034859.GM225435@mit.edu>
References: <cover.1582880246.git.riteshh@linux.ibm.com>
 <5a00e8d4283d6849e0b8f408c8365b31fbc1d153.1582880246.git.riteshh@linux.ibm.com>
 <20200228153650.GG29971@bombadil.infradead.org>
 <20200302081007.8B710A4070@d06av23.portsmouth.uk.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200302081007.8B710A4070@d06av23.portsmouth.uk.ibm.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 02, 2020 at 01:40:06PM +0530, Ritesh Harjani wrote:
> 
> Thanks for the review.
> Will make the suggested changes and send a v6.

I didn't see a v6, so I revised this patch to read:

commit 499800830ae5d44ae29f69c98ab9893f0425cb51
Author: Ritesh Harjani <riteshh@linux.ibm.com>
Date:   Fri Feb 28 14:56:59 2020 +0530

    Documentation: correct the description of FIEMAP_EXTENT_LAST
    
    Currently FIEMAP_EXTENT_LAST is not working consistently across
    different filesystem's fiemap implementations. So add more information
    about how else this flag could set in other implementation.
    
    Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
    Link: https://lore.kernel.org/r/5a00e8d4283d6849e0b8f408c8365b31fbc1d153.1582880246.git.riteshh@linux.ibm.com
    Signed-off-by: Theodore Ts'o <tytso@mit.edu>

diff --git a/Documentation/filesystems/fiemap.txt b/Documentation/filesystems/fiemap.txt
index f6d9c99103a4..ac87e6fda842 100644
--- a/Documentation/filesystems/fiemap.txt
+++ b/Documentation/filesystems/fiemap.txt
@@ -115,8 +115,10 @@ data. Note that the opposite is not true - it would be valid for
 FIEMAP_EXTENT_NOT_ALIGNED to appear alone.
 
 * FIEMAP_EXTENT_LAST
-This is the last extent in the file. A mapping attempt past this
-extent will return nothing.
+This is generally the last extent in the file. A mapping attempt past
+this extent may return nothing. Some implementations set this flag to
+indicate this extent is the last one in the range queried by the user
+(via fiemap->fm_length).
 
 * FIEMAP_EXTENT_UNKNOWN
 The location of this extent is currently unknown. This may indicate

     	      	      	     		  	   - Ted
