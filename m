Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 85D4D16493A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2020 16:52:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726712AbgBSPwZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Feb 2020 10:52:25 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:40788 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726651AbgBSPwZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Feb 2020 10:52:25 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01JFlKkn165283;
        Wed, 19 Feb 2020 15:52:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=+0MKjwYS6o56kZOWus6xPspoxgNogY35LPaujONId3I=;
 b=cg1bMIXWVeTVesVIC7DolETYE7jLDNBF2KZx3Fx8KiAQ4s5MTyUO4dubtOBMrzBmPfVL
 o/rTNkUZGCuIftPwlV1cmEug8HP0B5A1SuFJUiAkaJ6KYMgNKXf9jrCEoVRjyK33VVH6
 kbSCfrqZIJoxaLpm+6EIrXFCyU4gXfLo4+TdOduNQgUou96FKH5CPWVFEU+xX/xzB20X
 tmyhzf1YTMZKZ3lOqsDJ+EtpqgpIXTi4PVUQ13z1/ky0nKmmK23wJnMazIgYVSjUer82
 o2R/92rS67TxO+d5gGzwVuUzKwIK/NxaBmemDyVdawPP7gR53LFzGxbRJ7KLB1X+djoC 7g== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2y8udkc083-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Feb 2020 15:52:17 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01JFmEOF030012;
        Wed, 19 Feb 2020 15:50:16 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 2y8udargwy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Feb 2020 15:50:16 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 01JFoF96031867;
        Wed, 19 Feb 2020 15:50:15 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 19 Feb 2020 07:50:15 -0800
Date:   Wed, 19 Feb 2020 07:50:12 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     David Howells <dhowells@redhat.com>, viro@zeniv.linux.org.uk,
        raven@themaw.net, mszeredi@redhat.com, christian@brauner.io,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/19] VFS: Filesystem information and notifications [ver
 #16]
Message-ID: <20200219155012.GA9496@magnolia>
References: <158204549488.3299825.3783690177353088425.stgit@warthog.procyon.org.uk>
 <20200219144613.lc5y2jgzipynas5l@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200219144613.lc5y2jgzipynas5l@wittgenstein>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9536 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 adultscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002190119
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9536 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 suspectscore=0
 spamscore=0 priorityscore=1501 adultscore=0 mlxscore=0 clxscore=1011
 malwarescore=0 mlxlogscore=999 phishscore=0 impostorscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002190119
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 19, 2020 at 03:46:13PM +0100, Christian Brauner wrote:
> On Tue, Feb 18, 2020 at 05:04:55PM +0000, David Howells wrote:
> > 
> > Here are a set of patches that adds system calls, that (a) allow
> > information about the VFS, mount topology, superblock and files to be
> > retrieved and (b) allow for notifications of mount topology rearrangement
> > events, mount and superblock attribute changes and other superblock events,
> > such as errors.
> > 
> > ============================
> > FILESYSTEM INFORMATION QUERY
> > ============================
> > 
> > The first system call, fsinfo(), allows information about the filesystem at
> > a particular path point to be queried as a set of attributes, some of which
> > may have more than one value.
> > 
> > Attribute values are of four basic types:
> > 
> >  (1) Version dependent-length structure (size defined by type).
> > 
> >  (2) Variable-length string (up to 4096, including NUL).
> > 
> >  (3) List of structures (up to INT_MAX size).
> > 
> >  (4) Opaque blob (up to INT_MAX size).
> 
> I mainly have an organizational question. :) This is a huge patchset
> with lots and lots of (good) features. Wouldn't it make sense to make
> the fsinfo() syscall a completely separate patchset from the
> watch_mount() and watch_sb() syscalls? It seems that they don't need to
> depend on each other at all. This would make reviewing this so much
> nicer and likely would mean that fsinfo() could proceed a little faster.

Agreed; I was also wondering why it was necessary to have three new
features in the same large(ish) patchset.

--D

> Christian
