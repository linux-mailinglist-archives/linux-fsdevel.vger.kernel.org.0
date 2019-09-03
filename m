Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 504A4A6034
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2019 06:29:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725855AbfICE3t (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Sep 2019 00:29:49 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:46242 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725440AbfICE3t (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Sep 2019 00:29:49 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x834Tba5172536;
        Tue, 3 Sep 2019 04:29:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=Y7cmNlF6TEnkQ/1oVk10Fi7lXvuZptQRWFnE5rSnxXE=;
 b=p3VkEnT5jHP9am/30+D68UKQ55udN8lXTmpNZWGZXc9XjLADOjbemeZP6xrlbiV4H/iQ
 YYB2nLul/mRXiCYCXYKGR9wEdfw5HCJCKb2bY0GZZmg7KCy3lq7pJZ+DS+coOzwJG5e+
 itxSWxLnf062bLOHqo/zBEg4pJm5AAQHs4cjz6J9RcfAg5Pa86q3WlhIRddxM5mp0BeN
 lZraRgrvE31Lj9vDOQkJGQ6ASh71scx0fQOmQhFtkj+SFlciKsH6gZOn47E2naPHvtAB
 V7mIB9Z7vzTOFv2YvfS/iRGivlDAB4dx3cpIOLJjleKhnt7XxB2UVq9pyKy/qQmAZ/So AA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2usgs204fh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Sep 2019 04:29:37 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x834Sfvi014567;
        Tue, 3 Sep 2019 04:29:36 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 2us5pgddb9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Sep 2019 04:29:36 +0000
Received: from abhmp0022.oracle.com (abhmp0022.oracle.com [141.146.116.28])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x834TYd0017537;
        Tue, 3 Sep 2019 04:29:34 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 02 Sep 2019 21:29:34 -0700
Date:   Mon, 2 Sep 2019 21:29:35 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Goldwyn Rodrigues <rgoldwyn@suse.de>,
        linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        david@fromorbit.com, riteshh@linux.ibm.com
Subject: Re: [PATCH v3 0/15] Btrfs iomap
Message-ID: <20190903042935.GD5340@magnolia>
References: <20190901200836.14959-1-rgoldwyn@suse.de>
 <20190902164331.GE6263@lst.de>
 <4d039e8e-dc35-8092-4ee0-4a2e0f43f233@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4d039e8e-dc35-8092-4ee0-4a2e0f43f233@cn.fujitsu.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9368 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=813
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1909030049
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9368 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=944 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1909030049
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 03, 2019 at 11:51:24AM +0800, Shiyang Ruan wrote:
> 
> 
> On 9/3/19 12:43 AM, Christoph Hellwig wrote:
> > On Sun, Sep 01, 2019 at 03:08:21PM -0500, Goldwyn Rodrigues wrote:
> > > This is an effort to use iomap for btrfs. This would keep most
> > > responsibility of page handling during writes in iomap code, hence
> > > code reduction. For CoW support, changes are needed in iomap code
> > > to make sure we perform a copy before the write.
> > > This is in line with the discussion we had during adding dax support in
> > > btrfs.
> > 
> > This looks pretty good modulo a few comments.
> > 
> > Can you please convert the XFS code to use your two iomaps for COW
> > approach as well to validate it?
> 
> Hi,
> 
> The XFS part of dax CoW support has been implementing recently.  Please
> review this[1] if necessary.  It's based on this iomap patchset(the 1st
> version), and uses the new srcmap.
> 
> [1]: https://lkml.org/lkml/2019/7/31/449

It sure would be nice to have (a) this patchset of Goldwyn's cleaned up
a bit per the review comments and (b) the XFS DAX COW series rebased on
that (instead of a month-old submission). ;)

--D

> -- 
> Thanks,
> Shiyang Ruan.
> > 
> > Also the iomap_file_dirty helper would really benefit from using the
> > two iomaps, any chance you could look into improving it to use your
> > new infrastructure?
> > 
> > 
> 
> 
> 
