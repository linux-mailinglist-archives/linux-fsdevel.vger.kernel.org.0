Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C38911669B8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Feb 2020 22:21:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728936AbgBTVVI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Feb 2020 16:21:08 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:45248 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727561AbgBTVVH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Feb 2020 16:21:07 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01KLDQBH177432;
        Thu, 20 Feb 2020 21:21:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=rsqKEh0pL1pXmrGbqlJK7EdTYPyuGhnK+aAz2dAKN5s=;
 b=w7jcAoEB9r8PUxquGCWiyi+RWpjzh8pFLdbHSOgyVZhpADC4tfIj2UgnI1lj22KzpB3/
 I5/m/D7O+YSRnNOS91m0xywaPxgfp0sqyH7GbG2UwzBLu9yRhBnnMap4RV6jBShpx87W
 O3PfICwu1yzsdcSrY7jGfRItmd913JexmhUUWFs/FA608573lu9E52DgUlMSgA1fFSrj
 2ytLVEjEf9clNKhcSeWyGLqc+dagb4+8VmlViIgnKoMJkmxmQi8VqkhiBo+z69y332AG
 z1C1eBGJzy1qr6ASUzqrNrba9kQm2H4ptF65O2HE93rSQUATW+aejWX1yELdIZox3zoj Kw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2y8udkmk8g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Feb 2020 21:21:02 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01KLCGua059676;
        Thu, 20 Feb 2020 21:21:01 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 2y8udfkvar-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Feb 2020 21:21:01 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 01KLL0Pt013457;
        Thu, 20 Feb 2020 21:21:00 GMT
Received: from localhost (/10.145.178.17)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 20 Feb 2020 13:21:00 -0800
Date:   Thu, 20 Feb 2020 13:21:00 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Jeff Moyer <jmoyer@redhat.com>
Cc:     fstests@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org
Subject: Re: [PATCH V2 0/3] fstests: fixes for 64k pages and dax
Message-ID: <20200220212100.GC9506@magnolia>
References: <20200220200632.14075-1-jmoyer@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200220200632.14075-1-jmoyer@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9537 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 phishscore=0 suspectscore=0 mlxscore=0 malwarescore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002200156
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9537 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 suspectscore=0
 spamscore=0 priorityscore=1501 adultscore=0 mlxscore=0 clxscore=1015
 malwarescore=0 mlxlogscore=999 phishscore=0 impostorscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002200156
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 20, 2020 at 03:06:29PM -0500, Jeff Moyer wrote:
> This set of patches fixes a few false positives I encountered when
> testing DAX on ppc64le (which has a 64k page size).
> 
> Patch 1 is actually not specific to non-4k page sizes.  Currently,
> each individual dm rc file checks for the presence of the DAX mount
> option, and _notruns the test as part of the initializtion.  This
> doesn't work for the snapshot target.  Moving the check into the
> _require_dm_target fixes the problem, and keeps from the cut-n-paste
> of boilerplate.
> 
> Patches 2 and 3 get rid of hard coded block/page sizes in the tests.
> They run just fine on 64k pages and 64k block sizes.
> 
> Even after these patches, there are many more tests that fail in the
> following configuration:
> 
> MKFS_OPTIONS="-b size=65536 -m reflink=0" MOUNT_OPTIONS="-o dax"
> 
> One class of failures is tests that create a really small file system
> size.  Some of those tests seem to require the very small size, but
> others seem like they could live with a slightly bigger size that
> would then fit the log (the typical failure is a mkfs failure due to
> not enough blocks for the log).  For the former case, I'm tempted to
> send patches to _notrun those tests, and for the latter, I'd like to
> bump the file system sizes up.  300MB seems to be large enough to
> accommodate the log.  Would folks be opposed to those approaches?

Seems fine to me.  Do we have a helper function to compute (or maybe
just format) the minimum supported filesystem size for the given
MKFS_OPTIONS?

> Another class of failure is tests that either hard-code a block size
> to trigger a specific error case, or that test a multitude of block
> sizes.  I'd like to send a patch to _notrun those tests if there is
> a user-specified block size.  That will require parsing the MKFS_OPTIONS
> based on the fs type, of course.  Is that something that seems
> reasonable?

I think it's fine to _notrun a test that requires a specific blocksize
when when that blocksize is not supported by the system under test.

The ones that cycle through a range of block sizes, not so much--I guess
the question here is can we distinguish "test only this blocksize" vs
"default to this block size"?  And do we want to?

--D

> I will follow up with a series of patches to implement those changes
> if there is consensus on the approach.  These first three seemed
> straight-forward to me, so that's where I'm starting.
> 
> Changes in v2:
> - patch 2: remove the boilerplate from all dm rc files (Zorro Lang)
> - cc fstests (thanks, Dave)
> 
> [PATCH V2 1/3] dax/dm: disable testing on devices that don't support
> [PATCH V2 2/3] t_mmap_collision: fix hard-coded page size
> [PATCH V2 3/3] xfs/300: modify test to work on any fs block size
> 
