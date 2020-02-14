Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A462C15D134
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Feb 2020 05:42:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728616AbgBNEmq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Feb 2020 23:42:46 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:38288 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728100AbgBNEmp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Feb 2020 23:42:45 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01E4cfR1003955;
        Fri, 14 Feb 2020 04:42:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=Vt2JG8SKw/M51Zfuq7txuyPTL4CLm0EQro+mCUIsYDA=;
 b=x5ocLDyorfKbyb0khXcYQf1Sq9sJWnfDYJ6EEIJFpFi1AxpXz7S7olWe+ybaB/n0tbBS
 hJ6ErR3LdaZ5o8c+ZLl91lKAqLvtZHiFy4UqAPoDNd+SyvIEiPANpFF25VgXn87srP2R
 +/rE44XyLHSJX8d73hrXvszb4nFUxsqrMhUZgGACPSVP76yveoY1wwQl8gwTWrCUQaua
 +WWh0Hb3Hc0HoeyQK1bhXuBNpaOQfEsJ16rrSWJ1yMajiljC3p20M9VaYjMB2307eVzF
 RvWz11el+2x8VYFJcE61nh2uzgx97dUtxGdijJp5f+5a3zRZYK/hBP8cx2bCdfzLNMQ1 aQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2y2k88ppdr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Feb 2020 04:42:43 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01E4frYp156698;
        Fri, 14 Feb 2020 04:42:42 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 2y4k817up4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Feb 2020 04:42:42 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 01E4gfEQ014549;
        Fri, 14 Feb 2020 04:42:41 GMT
Received: from localhost (/67.161.8.12)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 13 Feb 2020 20:42:41 -0800
Date:   Thu, 13 Feb 2020 20:42:42 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Allison Collins <allison.henderson@oracle.com>
Cc:     lsf-pc@lists.linux-foundation.org, xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] Atomic Writes
Message-ID: <20200214044242.GI6870@magnolia>
References: <e88c2f96-fdbb-efb5-d7e2-94bfefbe8bfa@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e88c2f96-fdbb-efb5-d7e2-94bfefbe8bfa@oracle.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9530 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 suspectscore=0 mlxscore=0 bulkscore=0 malwarescore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002140036
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9530 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 lowpriorityscore=0
 suspectscore=0 bulkscore=0 phishscore=0 mlxlogscore=999 mlxscore=0
 malwarescore=0 impostorscore=0 clxscore=1015 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002140035
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 13, 2020 at 03:33:08PM -0700, Allison Collins wrote:
> Hi all,
> 
> I know there's a lot of discussion on the list right now, but I'd like to
> get this out before too much time gets away.  I would like to propose the
> topic of atomic writes.  I realize the topic has been discussed before, but
> I have not found much activity for it recently so perhaps we can revisit it.
> We do have a customer who may have an interest, so I would like to discuss
> the current state of things, and how we can move forward.  If efforts are in
> progress, and if not, what have we learned from the attempt.
> 
> I also understand there are multiple ways to solve this problem that people
> may have opinions on.  I've noticed some older patch sets trying to use a
> flag to control when dirty pages are flushed, though I think our customer
> would like to see a hardware solution via NVMe devices.  So I would like to
> see if others have similar interests as well and what their thoughts may be.
> Thanks everyone!

Hmmm well there are a number of different ways one could do this--

1) Userspace allocates an O_TMPFILE file, clones all the file data to
it, makes whatever changes it wants (thus invoking COW writes), and then
calls some ioctl to swap the differing extent maps atomically.  For XFS
we have most of those pieces, but we'd have to add a log intent item to
track the progress of the remap so that we can complete the remap if the
system goes down.  This has potentially the best flexibility (multiple
processes can coordinate to stage multiple updates to non-overlapping
ranges of the file) but is also a nice foot bazooka.

2) Set O_ATOMIC on the file, ensure that all writes are staged via COW,
and defer the cow remap step until we hit the synchronization point.
When that happens, we persist the new mappings somewhere (e.g. well
beyond all possible EOF in the XFS case) and then start an atomic remap
operation to move the new blocks into place in the file.  (XFS would
still have to add a new log intent item here to finish the remapping if
the system goes down.)  Less foot bazooka but leaves lingering questions
like what do you do if multiple processes want to run their own atomic
updates?

(Note that I think you have some sort of higher level progress tracking
of the remap operation because we can't leave a torn write just because
the computer crashed.)

3) Magic pwritev2 API that lets userspace talk directly to hardware
atomic writes, though I don't know how userspace discovers what the
hardware limits are.   I'm assuming the usual sysfs knobs?

Note that #1 and #2 are done entirely in software, which makes them less
performant but OTOH there's effectively no limit (besides available
physical space) on how much data or how many non-contiguous extents we
can stage and commit.

--D

> Allison
