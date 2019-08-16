Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 77C6D8F8C3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Aug 2019 04:14:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726403AbfHPCOG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Aug 2019 22:14:06 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:54732 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbfHPCOF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Aug 2019 22:14:05 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7G29JWk069079;
        Fri, 16 Aug 2019 02:13:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=vvbu60KIKuj2V/M8HyUSUiae8i9AsQEjSkmMklAQSU8=;
 b=CrDWYXm3qcuFQaeesiwkTrgwYVJv1DCtUNMqQDKH19cdfsgdhbvkvj/C9W4fcvcAAhkS
 xcel/2InimHmZCfN0WEYZJ1c2wbM/F+p/CbwiGtV2C2N7M0BdsyXtJvPyhtQUkRUpn76
 VNmdsYRT2xF4dfmUOxaYLcp1Xm4j1Zc/qkAyt7bOrb1DqVdBgv+XKYb2sAis9gG7b/IF
 apQt0JWxEFa/v1KP9NEE45U+BhuuxpGY9MVDMjiLfU9+cHMRbnZe1fpFJSaOPJep4u0o
 SjQlFwpuo97CH/2XjO6DZihFE0ZpZKlKizLUmHMooEFojnQAW0Q1iMx5oXyOa39RhvgF HA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2u9pjqwtur-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 16 Aug 2019 02:13:46 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7G2D5aQ169960;
        Fri, 16 Aug 2019 02:13:46 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 2udgr2br7w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 16 Aug 2019 02:13:45 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x7G2DTqb018193;
        Fri, 16 Aug 2019 02:13:29 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 15 Aug 2019 19:13:29 -0700
Date:   Thu, 15 Aug 2019 19:13:27 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     hch@infradead.org, tytso@mit.edu, viro@zeniv.linux.org.uk,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        fstests <fstests@vger.kernel.org>
Subject: Re: [PATCH RFC 3/2] fstests: check that we can't write to swap files
Message-ID: <20190816021327.GD15198@magnolia>
References: <156588514105.111054.13645634739408399209.stgit@magnolia>
 <20190815163434.GA15186@magnolia>
 <20190815142603.de9f1c0d9fcc017f3237708d@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190815142603.de9f1c0d9fcc017f3237708d@linux-foundation.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9350 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908160022
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9350 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908160021
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 15, 2019 at 02:26:03PM -0700, Andrew Morton wrote:
> On Thu, 15 Aug 2019 09:34:34 -0700 "Darrick J. Wong" <darrick.wong@oracle.com> wrote:
> 
> > While active, the media backing a swap file is leased to the kernel.
> > Userspace has no business writing to it.  Make sure we can't do this.
> 
> I don't think this tests the case where a file was already open for
> writing and someone does swapon(that file)?
> 
> And then does swapoff(that file), when writes should start working again?
> 
> Ditto all the above, with s/open/mmap/.

Heh, ok.  I'll start working on a C program to do that.

> Do we handle (and test!) the case where there's unwritten dirty
> pagecache at the time of swapon()? Ditto pte-dirty MAP_SHARED pages?

One of the tests I wrote for iomap_swapfile_activate way back when
checks that.  The iomap version calls vfs_fsync, but AFAICT
generic_swapfile_activate doesn't do that.

--D
