Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24D7E1EC1B2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jun 2020 20:17:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726320AbgFBSRS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Jun 2020 14:17:18 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:59046 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726000AbgFBSRR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Jun 2020 14:17:17 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 052I7t1h177905;
        Tue, 2 Jun 2020 18:17:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=mime-version :
 message-id : date : from : to : cc : subject : references : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=X49wKSnu9fOxTqf6/taZw+DmoyGY5qqdKkF7CwXyyhU=;
 b=Lv5g79NM3PnfnYv8QvcLbn0XfFCOXjNP4txvAUlj2UekN+oloAsfr/MoevQSCgU/YA2F
 1L1Q6Lr1MVk2lkLoAXh0cbPvlZxcuOxAvDVmjlzK2GzST09NxCZKl5hgP2GogLZ3yN5W
 Zg0dczpNpX8oennm5UYn+xxRXbjn3OLezuCqEeihy0kzDwM0NnzihsUAWOUHARtwqg/G
 hezD+fKVptJ7hDiIXu5fopCOlicWKD+EpjVT8lx64+9b8XcDMunTNXPwjS+hKhZ68fwO
 88N7SedbcMhA0G5XuF2VmpkhtqvfENgk09P+t6SOE/Vk/XCw14ZV1Sn3WST0MA8+39aE Rw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 31bewqwhdb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 02 Jun 2020 18:17:00 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 052I80jG005905;
        Tue, 2 Jun 2020 18:15:00 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 31dju1wkvj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 02 Jun 2020 18:15:00 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 052IEvIo025425;
        Tue, 2 Jun 2020 18:14:57 GMT
Received: from localhost (/67.169.218.210) by default (Oracle Beehive Gateway
 v4.0) with ESMTP ; Tue, 02 Jun 2020 11:14:46 -0700
MIME-Version: 1.0
Message-ID: <20200602181444.GD8230@magnolia>
Date:   Tue, 2 Jun 2020 11:14:44 -0700 (PDT)
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Xiao Yang <yangx.jy@cn.fujitsu.com>
Cc:     ira.weiny@intel.com, fstests@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        Jeff Moyer <jmoyer@redhat.com>, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] xfs/XXX: Add xfs/XXX
References: <20200413054419.1560503-1-ira.weiny@intel.com>
 <20200413163025.GB6742@magnolia> <5ED61324.6010300@cn.fujitsu.com>
In-Reply-To: <5ED61324.6010300@cn.fujitsu.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9640 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 phishscore=0 malwarescore=0 mlxscore=0 adultscore=0 bulkscore=0
 suspectscore=1 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006020132
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9640 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 bulkscore=0
 phishscore=0 suspectscore=1 impostorscore=0 cotscore=-2147483648
 lowpriorityscore=0 mlxscore=0 adultscore=0 spamscore=0 mlxlogscore=999
 malwarescore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006020132
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 02, 2020 at 04:51:48PM +0800, Xiao Yang wrote:
> On 2020/4/14 0:30, Darrick J. Wong wrote:
> > This might be a good time to introduce a few new helpers:
> > 
> > _require_scratch_dax ("Does $SCRATCH_DEV support DAX?")
> > _require_scratch_dax_mountopt ("Does the fs support the DAX mount options?")
> > _require_scratch_daX_iflag ("Does the fs support FS_XFLAG_DAX?")
> Hi Darrick,
> 
> Now, I am trying to introduce these new helpers and have some questions:
> 1) There are five testcases related to old dax implementation, should we
> only convert them to new dax implementation or make them compatible with old
> and new dax implementation?

What is the 'old' DAX implementation?  ext2 XIP?

> 2) I think _require_xfs_io_command "chattr" "x" is enough to check if fs
> supports FS_XFLAG_DAX.  Is it necessary to add _require_scratch_dax_iflag()?
> like this:
> _require_scratch_dax_iflag()
> {
> 	_require_xfs_io_command "chattr" "x"
> }

I suggested that list based on the major control knobs that will be
visible to userspace programs.  Even if this is just a one-line helper,
its name is useful for recognizing which of those knobs we're looking
for.

Yes, you could probably save a trivial amount of time by skipping one
iteration of bash function calling, but now everyone has to remember
that the xfs_io chattr "x" flag means the dax inode flag, and not
confuse it for chmod +x or something else.

--D

> Best Regards,
> Xiao Yang
> 
> 
