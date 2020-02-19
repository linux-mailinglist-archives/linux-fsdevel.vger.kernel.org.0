Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 787ED16392F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2020 02:18:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727680AbgBSBSB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Feb 2020 20:18:01 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:50185 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726939AbgBSBSA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Feb 2020 20:18:00 -0500
Received: from callcc.thunk.org (guestnat-104-133-8-109.corp.google.com [104.133.8.109] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 01J1HfCl025065
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Feb 2020 20:17:43 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 8C6F74211EF; Tue, 18 Feb 2020 20:17:41 -0500 (EST)
Date:   Tue, 18 Feb 2020 20:17:41 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Dave Chinner <david@fromorbit.com>,
        Matthew Wilcox <willy@infradead.org>,
        Brian Foster <bfoster@redhat.com>,
        Allison Collins <allison.henderson@oracle.com>,
        Amir Goldstein <amir73il@gmail.com>,
        lsf-pc@lists.linux-foundation.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        xfs <linux-xfs@vger.kernel.org>, Eryu Guan <guaneryu@gmail.com>,
        Eric Sandeen <sandeen@redhat.com>
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] FS Maintainers Don't Scale
Message-ID: <20200219011741.GA330201@mit.edu>
References: <20200131052520.GC6869@magnolia>
 <CAOQ4uxh=4DrH_dL3TULcFa+pGk0YhS=TobuGk_+Z0oRWvw63rg@mail.gmail.com>
 <8983ceaa-1fda-f9cc-73c9-8764d010d3e2@oracle.com>
 <20200202214620.GA20628@dread.disaster.area>
 <fc430471-54d2-bb44-d084-a37e7ff9ef50@oracle.com>
 <20200212220600.GS6870@magnolia>
 <20200213151100.GC6548@bfoster>
 <20200213154632.GN7778@bombadil.infradead.org>
 <20200216215556.GZ10776@dread.disaster.area>
 <20200219002916.GB9506@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200219002916.GB9506@magnolia>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 18, 2020 at 04:29:16PM -0800, Darrick J. Wong wrote:
> I kinda wish the LF or someone would open such a program to the kernel
> maintainers.  I never liked that old maxim, "The maintainer is [the
> stuckee] with the most testing resources" -- there shouldn't really have
> to be a djwong cloud and a dchinner cloud. :/

If there are people who are interested in using gce-xfstests for
testing their file systems, please contact me off-line.  I can't make
a promise that I can swing free GCE credits for *everyone*, but for
maintainers of major file systems, or senior file system developers in
general, we can probably work something out.

						- Ted

P.S.  I also have blktests working in gce-xfstests; it's not clear
it's as useful, and there are a lot of test failures which I think are
test bugs, but in theory blktests can be used via gce-xfstests.  I
also have very rough Phoronix Test suite support, and I hope to try to
get mmtests running out of gce-xfstests as well.  Which probably means
I should think about renaming it.  :-)
