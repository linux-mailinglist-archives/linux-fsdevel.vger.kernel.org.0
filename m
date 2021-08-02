Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FB2A3DDBDC
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Aug 2021 17:06:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234431AbhHBPGv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Aug 2021 11:06:51 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:40593 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S234291AbhHBPGu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Aug 2021 11:06:50 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 172F5HMY027185
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 2 Aug 2021 11:05:18 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 7350D15C3DD2; Mon,  2 Aug 2021 11:05:17 -0400 (EDT)
Date:   Mon, 2 Aug 2021 11:05:17 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
        linux-kernel@vger.kernel.org, pali@kernel.org, dsterba@suse.cz,
        aaptel@suse.com, willy@infradead.org, rdunlap@infradead.org,
        joe@perches.com, mark@harmstone.com, nborisov@suse.com,
        linux-ntfs-dev@lists.sourceforge.net, anton@tuxera.com,
        dan.carpenter@oracle.com, hch@lst.de, ebiggers@kernel.org,
        andy.lavr@gmail.com, kari.argillander@gmail.com,
        oleksandr@natalenko.name
Subject: Re: [PATCH v27 00/10] NTFS read-write driver GPL implementation by
 Paragon Software
Message-ID: <YQgJrYPphDC4W4Q3@mit.edu>
References: <20210729134943.778917-1-almaz.alexandrovich@paragon-software.com>
 <20210729162459.GA3601405@magnolia>
 <YQdlJM6ngxPoeq4U@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YQdlJM6ngxPoeq4U@mit.edu>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

It should also noted that apparently ntfs3 does not properly support
user namespaces, such that generic/317 fails:

generic/317		[10:37:19][    7.024574] run fstests generic/317 at 2021-08-02 10:37:19
 [10:37:19]- output mismatch (see /results/ntfs3/results-default/generic/317.out.bad)
    --- tests/generic/317.out	2021-08-01 20:47:35.000000000 -0400
    +++ /results/ntfs3/results-default/generic/317.out.bad	2021-08-02 10:37:19.930687003 -0400
    @@ -13,8 +13,8 @@
     From init_user_ns
       File: "$SCRATCH_MNT/file1"
       Size: 0            Filetype: Regular File
    -  Mode: (0644/-rw-r--r--)         Uid: (qa_user)  Gid: (qa_user)
    +  Mode: (0755/-rwxr-xr-x)         Uid: (0)  Gid: (0)
     From user_ns
       File: "$SCRATCH_MNT/file1"
    ...
    (Run 'diff -u /root/xfstests/tests/generic/317.out /results/ntfs3/results-default/generic/317.out.bad'  to see the entire diff)
Ran: generic/317
Failures: generic/317


Is Paragon Software willing to commit to fixing these and other bugs?
Better yet, it would be nice if Paragon Software could improve its
testing and other QA processes.

Furthermore, container developers should note that ntfs3 is not
currently safe for use with containers.

   	   	    	       	      - Ted
