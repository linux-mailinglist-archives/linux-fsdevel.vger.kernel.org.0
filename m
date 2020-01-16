Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B2DDA13FC12
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2020 23:19:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389907AbgAPWTZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Jan 2020 17:19:25 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:34262 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730287AbgAPWTZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Jan 2020 17:19:25 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00GMIZCT028592;
        Thu, 16 Jan 2020 22:19:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=pSB2tRyVqfE4FbpMpFBrw+fyJNwr6cCK25cTALnwLyY=;
 b=YbYZf2iMfQ0oj9lrYrWplU6V4r8tHTIrX/m9H9tXvHV/66K6hi2SGUvyAM05LrDCFWUu
 jzKFCvl/TB48hwPfkgXfinfnVhElpNyOyKFsYelrNrI18fAaDmsT0K2W8WqsTRix/JRH
 aNxXEsfDC9MFjmOgVtKE0P5raFrIUwDkrjbdKFpxsKzmtR6f/kN8q2HBt2T1aMEFjDpp
 qbcdqyswojJCf5dRQTJdrmDZemzilSdTTl582qj9Sa8VcOX3KLMaE7Q7EaI/+8HBj1xG
 XnkPHCHqfNqJcdsJ5hSVqGmvV2s0UzWJTJmivkOVaoWxNVQRpgKUswIyZzHRrQ5sSq9b eg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 2xf73u5bwf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Jan 2020 22:19:12 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00GMIbpT174550;
        Thu, 16 Jan 2020 22:19:11 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 2xjxp3w3bf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Jan 2020 22:19:11 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 00GMJ9Xq003562;
        Thu, 16 Jan 2020 22:19:09 GMT
Received: from localhost (/10.145.179.16)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 16 Jan 2020 14:19:09 -0800
Date:   Thu, 16 Jan 2020 14:19:06 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Dan Williams <dan.j.williams@intel.com>, Jan Kara <jack@suse.cz>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [RFC PATCH V2 01/12] fs/stat: Define DAX statx attribute
Message-ID: <20200116221906.GF8247@magnolia>
References: <20200110192942.25021-2-ira.weiny@intel.com>
 <20200115113715.GB2595@quack2.suse.cz>
 <20200115173834.GD8247@magnolia>
 <20200115194512.GF23311@iweiny-DESK2.sc.intel.com>
 <CAPcyv4hwefzruFj02YHYiy8nOpHJFGLKksjiXoRUGpT3C2rDag@mail.gmail.com>
 <20200115223821.GG23311@iweiny-DESK2.sc.intel.com>
 <20200116053935.GB8235@magnolia>
 <20200116175501.GC24522@iweiny-DESK2.sc.intel.com>
 <20200116180421.GD8235@magnolia>
 <20200116185235.GE24522@iweiny-DESK2.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200116185235.GE24522@iweiny-DESK2.sc.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9502 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001160178
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9502 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001160178
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 16, 2020 at 10:52:36AM -0800, Ira Weiny wrote:
> On Thu, Jan 16, 2020 at 10:04:21AM -0800, Darrick J. Wong wrote:
> > On Thu, Jan 16, 2020 at 09:55:02AM -0800, Ira Weiny wrote:
> > > On Wed, Jan 15, 2020 at 09:39:35PM -0800, Darrick J. Wong wrote:
> > > > On Wed, Jan 15, 2020 at 02:38:21PM -0800, Ira Weiny wrote:
> > > > > On Wed, Jan 15, 2020 at 12:10:50PM -0800, Dan Williams wrote:
> > > > > > On Wed, Jan 15, 2020 at 11:45 AM Ira Weiny <ira.weiny@intel.com> wrote:
> > > > > > >
> > > > > > > On Wed, Jan 15, 2020 at 09:38:34AM -0800, Darrick J. Wong wrote:
> > > > > > > > On Wed, Jan 15, 2020 at 12:37:15PM +0100, Jan Kara wrote:
> > > > > > > > > On Fri 10-01-20 11:29:31, ira.weiny@intel.com wrote:
> > > > > > > > > > From: Ira Weiny <ira.weiny@intel.com>
> > > > > > > > > >
> > > > > 
> > > 
> > > [snip]
> > > 
> > > > > 
> > > > > Sure, but for now I think referencing mmap for details on MAP_SYNC works.
> > > > > 
> > > > > I suspect that we may have some word smithing once I get this series in and we
> > > > > submit a change to the statx man page itself.  Can I move forward with the
> > > > > following for this patch?
> > > > > 
> > > > > <quote>
> > > > > STATX_ATTR_DAX
> > > > > 
> > > > >         The file is in the DAX (cpu direct access) state.  DAX state
> > > > 
> > > > Hmm, now that I see it written out, I <cough> kind of like "DAX mode"
> > > > better now. :/
> > > > 
> > > > "The file is in DAX (CPU direct access) mode.  DAX mode attempts..."
> > > 
> > > Sure...  now you tell me...  ;-)
> > > 
> > > Seriously, we could use mode here in the man page as this is less confusing to
> > > say "DAX mode".
> > > 
> > > But I think the code should still use 'state' because mode is just too
> > > overloaded.  You were not the only one who was thrown by my use of mode and I
> > > don't want that confusion when we look at this code 2 weeks from now...
> > > 
> > > https://www.reddit.com/r/ProgrammerHumor/comments/852og2/only_god_knows/
> > > 
> > > ;-)
> > 
> > Ok, let's leave it alone for now then.
> 
> Cool could I get a reviewed by?

My bike shed is painted green with purple polka dots,

Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> And Jan is this reword of the man page/commit ok to keep your reviewed by?
> 
> > 
> > I'm not even sure what 'DAX' stands for.  Direct Access to ...
> > Professor Xavier? 8-)
> 
> That is pronounced 'Direct A'Xes'  you know, for chopping wood!
> 
> Thanks everyone,
> Ira
> 
> > 
> > > > 
> > > > >         attempts to minimize software cache effects for both I/O and
> > > > >         memory mappings of this file.  It requires a file system which
> > > > >         has been configured to support DAX.
> > > > > 
> > > > >         DAX generally assumes all accesses are via cpu load / store
> > > > >         instructions which can minimize overhead for small accesses, but
> > > > >         may adversely affect cpu utilization for large transfers.
> > > > > 
> > > > >         File I/O is done directly to/from user-space buffers and memory
> > > > >         mapped I/O may be performed with direct memory mappings that
> > > > >         bypass kernel page cache.
> > > > > 
> > > > >         While the DAX property tends to result in data being transferred
> > > > >         synchronously, it does not give the same guarantees of
> > > > >         synchronous I/O where data and the necessary metadata are
> > > > >         transferred together.
> > > > 
> > > > (I'm frankly not sure that synchronous I/O actually guarantees that the
> > > > metadata has hit stable storage...)
> > > 
> > > I'll let you and Dan work this one out...  ;-)
> > 
> > Hehe.  I think the wording here is fine.
> > 
> > --D
> > 
> > > Ira
> > > 
