Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA3811EC806
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jun 2020 05:51:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726120AbgFCDvY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Jun 2020 23:51:24 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:55354 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725926AbgFCDvY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Jun 2020 23:51:24 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0533mFXx106894;
        Wed, 3 Jun 2020 03:51:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=SJ6Xy9EhhO1mahYBwFQo6lySQegNoTnkZHQ5lceiC3E=;
 b=xy2oKhR+YdTN8HSbkhjBP4oL+y1wFKDBlnPtTuMd9vJlp3hpHCGBcZysDPWuD/W3vKUU
 fZWsx4SU9zretsUJgXDt8Bzd6tDDnlcmsysQ54jIQzWSOXFgh/KoGpM9z0KaSTt2sYmO
 40JzzBJvgfodLJrI4EBHpipih7Kjrt2RtnX0Ja2h5h5+RYAkRmOqY/t7BXliXfqIdL0w
 F/p9eleUj3wEu4V2yRk30Nd6t4SflCR3IuoISPSZ1N9kkaDojRDtUrBgiEkZgflr2N3s
 C+D2e9ywJT+60c0u65NjgXCsli6rzg+E0QFDhsKyfKD8ZtOC7FfdM0JeaGpddaKgICyj nA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 31dkrum2ds-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 03 Jun 2020 03:51:06 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0533hwFj115116;
        Wed, 3 Jun 2020 03:49:06 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 31c25que0n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 Jun 2020 03:49:06 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0533n2ma024413;
        Wed, 3 Jun 2020 03:49:02 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 02 Jun 2020 20:49:02 -0700
Date:   Tue, 2 Jun 2020 20:49:00 -0700
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
Message-ID: <20200603034900.GZ8230@magnolia>
References: <20200413054419.1560503-1-ira.weiny@intel.com>
 <20200413163025.GB6742@magnolia>
 <5ED61324.6010300@cn.fujitsu.com>
 <20200602181444.GD8230@magnolia>
 <5ED7033D.7020009@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ED7033D.7020009@cn.fujitsu.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9640 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=1 spamscore=0
 malwarescore=0 bulkscore=0 mlxscore=0 phishscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006030027
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9640 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 priorityscore=1501
 mlxscore=0 lowpriorityscore=0 suspectscore=1 malwarescore=0 clxscore=1015
 adultscore=0 mlxlogscore=999 cotscore=-2147483648 phishscore=0 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006030027
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 03, 2020 at 09:56:13AM +0800, Xiao Yang wrote:
> On 2020/6/3 2:14, Darrick J. Wong wrote:
> > On Tue, Jun 02, 2020 at 04:51:48PM +0800, Xiao Yang wrote:
> > > On 2020/4/14 0:30, Darrick J. Wong wrote:
> > > > This might be a good time to introduce a few new helpers:
> > > > 
> > > > _require_scratch_dax ("Does $SCRATCH_DEV support DAX?")
> > > > _require_scratch_dax_mountopt ("Does the fs support the DAX mount options?")
> > > > _require_scratch_daX_iflag ("Does the fs support FS_XFLAG_DAX?")
> > > Hi Darrick,
> > > 
> > > Now, I am trying to introduce these new helpers and have some questions:
> > > 1) There are five testcases related to old dax implementation, should we
> > > only convert them to new dax implementation or make them compatible with old
> > > and new dax implementation?
> > 
> > What is the 'old' DAX implementation?  ext2 XIP?
> Hi Darrick,
> 
> Thanks for your quick feedback.
> 
> Right, the 'old' DAX implementation means old dax mount option(i.e. -o dax)
> 
> Compare new and old dax mount option on ext4 and xfs, is the following logic
> right?
> -o dax=always == -o dax
> -o dax=never == without dax
> -o dax=inode == nothing

No.  -o dax=always is the same as -o dax.
dax=inode was and still is the behavior you got with no option at all.
-o dax=never is a new option.

> Of course, we should uses new option if ext4/xfs supports new dax mount
> option on distros.  But should we fallback to use old option if ext4/xfs
> doesn't support new dax mount option on some old distros?
> btw:
> it seems hard for testcases to use two different sets of mount options(i.e.
> old and new) so do you have any suggestion?

Try dax=never, it should work on any type of storage device if the
kernel implements the "new" mount options at all.

--D

> > 
> > > 2) I think _require_xfs_io_command "chattr" "x" is enough to check if fs
> > > supports FS_XFLAG_DAX.  Is it necessary to add _require_scratch_dax_iflag()?
> > > like this:
> > > _require_scratch_dax_iflag()
> > > {
> > > 	_require_xfs_io_command "chattr" "x"
> > > }
> > 
> > I suggested that list based on the major control knobs that will be
> > visible to userspace programs.  Even if this is just a one-line helper,
> > its name is useful for recognizing which of those knobs we're looking
> > for.
> > 
> > Yes, you could probably save a trivial amount of time by skipping one
> > iteration of bash function calling, but now everyone has to remember
> > that the xfs_io chattr "x" flag means the dax inode flag, and not
> > confuse it for chmod +x or something else.
> 
> Got it, thanks for your detailed explanation.
> 
> Best Regards,
> Xiao Yang
> > 
> > --D
> > 
> > > Best Regards,
> > > Xiao Yang
> > > 
> > > 
> > 
> > 
> > .
> > 
> 
> 
> 
