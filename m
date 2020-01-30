Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB3E714D50D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jan 2020 02:54:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726692AbgA3Bya (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Jan 2020 20:54:30 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:50906 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726632AbgA3Bya (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Jan 2020 20:54:30 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00U1r4L1117242;
        Thu, 30 Jan 2020 01:54:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=ecgDIRlaXBwoQEpgNoqgE17XeCASHz7xplSZ2VE9IVo=;
 b=qVJw16Vccb5PJ/8bEMeZ5hlqFMDsXEG6h0IuqVGlZiayps77itHQQ9AFUg52kMibrqiH
 sCqdml9ywwxzghItNKz93AGxXm2mLApiol1yF8OZeuHs3rTSaHFG0w5UrVY3zp3yZXJI
 x9ayFV0EYvJ2WsWvXLcef/8Zeq/Tsle3+iohS+yNa1tapKnq0tOj4UPx17Hs443tpMjU
 x1OPMSwKmIO7xrLbRX5DTVFjYK1ohmoK/OHLcxxURXAFtDVhvtLy/CcWQ/xSeAfdMGsr
 YjqwFsH2o+m7cJNyvYnVXSPqOsbNlUJLWEW6wsanMxe9cEa2LnHPdAIi0+kBeWoNPIaW vw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2xrd3uh63j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Jan 2020 01:54:15 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00U1hjbt080079;
        Thu, 30 Jan 2020 01:52:14 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 2xuemva2br-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Jan 2020 01:52:14 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 00U1qBo2025023;
        Thu, 30 Jan 2020 01:52:11 GMT
Received: from localhost (/10.159.240.218)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 29 Jan 2020 17:52:11 -0800
Date:   Wed, 29 Jan 2020 17:52:10 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Steve French <smfrench@gmail.com>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        samba-technical <samba-technical@lists.samba.org>,
        lsf-pc@lists.linux-foundation.org
Subject: Re: [LSF/MM/BPF TOPIC] Enhancing Linux Copy Performance and Function
 and improving backup scenarios
Message-ID: <20200130015210.GB3673284@magnolia>
References: <CAH2r5mvYTimXUfJB+p0mvYV3jAR1u5G4F3m+OqA_5jKiLhVE8A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH2r5mvYTimXUfJB+p0mvYV3jAR1u5G4F3m+OqA_5jKiLhVE8A@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9515 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001300009
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9515 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001300010
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 22, 2020 at 05:13:53PM -0600, Steve French wrote:
> As discussed last year:
> 
> Current Linux copy tools have various problems compared to other
> platforms - small I/O sizes (and most don't allow it to be
> configured), lack of parallel I/O for multi-file copies, inability to
> reduce metadata updates by setting file size first, lack of cross

...and yet weirdly we tell everyone on xfs not to do that or to use
fallocate, so that delayed speculative allocation can do its thing.
We also tell them not to create deep directory trees because xfs isn't
ext4.

> mount (to the same file system) copy optimizations, limited ability to
> handle the wide variety of server side copy (and copy offload)
> mechanisms and error handling problems.   And copy tools rely less on
> the kernel file system (vs. code in the user space tool) in Linux than
> would be expected, in order to determine which optimizations to use.

What kernel interfaces would we expect userspace to use to figure out
the confusing mess of optimizations? :)

There's a whole bunch of xfs ioctls like dioinfo and the like that we
ought to push to statx too.  Is that an example of what you mean?

(I wasn't at last year's LSF.)

> But some progress has been made since last year's summit, with new
> copy tools being released and improvements to some of the kernel file
> systems, and also some additional feedback on lwn and on the mailing
> lists.  In addition these discussions have prompted additional
> feedback on how to improve file backup/restore scenarios (e.g. to
> mounts to the cloud from local Linux systems) which require preserving
> more timestamps, ACLs and metadata, and preserving them efficiently.

I suppose it would be useful to think a little more about cross-device
fs copies considering that the "devices" can be VM block devs backed by
files on a filesystem that supports reflink.  I have no idea how you
manage that sanely though.

--D

> Let's continue our discussions from last year, and see how we can move
> forward on improving the performance and function of Linux fs
> (including the VFS and user space tools) for various backup, restore
> and copy scenarios operations.
