Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B2B421467E
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 Jul 2020 16:39:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbgGDOjp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 4 Jul 2020 10:39:45 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:58822 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726258AbgGDOjo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 4 Jul 2020 10:39:44 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 064EWRLK051765;
        Sat, 4 Jul 2020 14:39:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=hhaHXUri8FGqFzgLf65OMDLcsQu02kWoXcmWkGA2DDw=;
 b=UAQiuZeqJGofupgW3u5xCgRG9ulxs6jHV/vg8SZodAHWEcqz0dmtRM9Jx8rPt6nsMRdG
 DAjnr4GP4VLH/9FnVIwCikk91rZNQ3b/tjeolZ5NQ2okOBH7fin6I8y9cvzcQ/aBQ/YN
 cH8EZPQ7AIoDJF56FNgyy44Msx0avpndCBghzsddV23eig1iIArpk5LQbiG6RisfHRoh
 +BpJ87zaS4t91lyXQE5RU2Plw0Xn0W9dMaMMGrCH68yDUN/OK9VEVx4L4K7Bg2Ve0L9i
 ZMp4XPiID5S/UTv6DdoZ4ojA/Zg07GjvAxHBtrzzv0j0ZvOqYno2Qisr1tlnx2DJ0s87 HA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 322h6r14uf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 04 Jul 2020 14:39:40 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 064EX17Y108186;
        Sat, 4 Jul 2020 14:37:40 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 322jj9r4dr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 04 Jul 2020 14:37:39 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 064Ebcp1030812;
        Sat, 4 Jul 2020 14:37:38 GMT
Received: from anon-dhcp-153.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sat, 04 Jul 2020 07:37:38 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.14\))
Subject: Re: [PATCH v3 00/10] server side user xattr support (RFC 8276)
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20200623223927.31795-1-fllinden@amazon.com>
Date:   Sat, 4 Jul 2020 10:37:37 -0400
Cc:     Bruce Fields <bfields@fieldses.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <C52F46DD-7C12-4D83-B11E-73BE5B1BF8D2@oracle.com>
References: <20200623223927.31795-1-fllinden@amazon.com>
To:     Frank van der Linden <fllinden@amazon.com>,
        Al Viro <viro@zeniv.linux.org.uk>
X-Mailer: Apple Mail (2.3445.104.14)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9671 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0
 mlxlogscore=999 spamscore=0 phishscore=0 malwarescore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2007040105
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9671 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 adultscore=0 mlxscore=0 spamscore=0 impostorscore=0
 cotscore=-2147483648 malwarescore=0 mlxlogscore=999 clxscore=1011
 bulkscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2007040105
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Jun 23, 2020, at 6:39 PM, Frank van der Linden =
<fllinden@amazon.com> wrote:
>=20
> v3:
>  * Rebase to v5.8-rc2
>  * Use length probe + allocate + query for the listxattr and setxattr
>    operations to avoid allocating unneeded space.
>  * Because of the above, drop the 'use kvmalloc for svcxdr_tmpalloc' =
patch,
>    as it's no longer needed.

v3 of this series has been applied to nfsd-5.9. Thanks!

See: git://git.linux-nfs.org/projects/cel/cel-2.6.git nfsd-5.9

Still waiting for Acks on 01/13 and 02/13.


> v2:
>  * As per the discussion, user extended attributes are enabled if
>    the client and server support them (e.g. they support 4.2 and
>    advertise the user extended attribute FATTR). There are no longer
>    options to switch them off.
>  * The code is no longer conditioned on a config option.
>  * The number of patches has been reduced somewhat by merging
>    smaller, related ones.
>  * Renamed some functions and added parameter comments as requested.
>=20
> v1:
>=20
>  * Split in to client and server (changed from the original RFC =
patch).
>=20
> Original RFC combined set is here:
>=20
> https://www.spinics.net/lists/linux-nfs/msg74843.html
>=20
> In general, these patches were, both server and client, tested as
> follows:
> 	* stress-ng-xattr with 1000 workers
> 	* Test all corner cases (XATTR_SIZE_*)
> 	* Test all failure cases (no xattr, setxattr with different or
> 	  invalid flags, etc).
> 	* Verify the content of xattrs across several operations.
> 	* Use KASAN and KMEMLEAK for a longer mix of testruns to verify
> 	  that there were no leaks (after unmounting the filesystem).
> 	* Interop run against FreeBSD server/client implementation.
> 	* Ran xfstests-dev, with no unexpected/new failures as compared
> 	  to an unpatched kernel. To fully use xfstests-dev, it needed
> 	  some modifications, as it expects to either use all xattr
> 	  namespaces, or none. Whereas NFS only suppors the "user."
> 	  namespace (+ optional ACLs). I will send the changes in
> 	  seperately.
>=20
>=20
> Frank van der Linden (10):
>  xattr: break delegations in {set,remove}xattr
>  xattr: add a function to check if a namespace is supported
>  nfs,nfsd: NFSv4.2 extended attribute protocol definitions
>  nfsd: split off the write decode code in to a separate function
>  nfsd: add defines for NFSv4.2 extended attribute support
>  nfsd: define xattr functions to call in to their vfs counterparts
>  nfsd: take xattr bits in to account for permission checks
>  nfsd: add structure definitions for xattr requests / responses
>  nfsd: implement the xattr functions and en/decode logic
>  nfsd: add fattr support for user extended attributes
>=20
> fs/nfsd/nfs4proc.c        | 128 ++++++++-
> fs/nfsd/nfs4xdr.c         | 531 +++++++++++++++++++++++++++++++++++---
> fs/nfsd/nfsd.h            |   5 +-
> fs/nfsd/vfs.c             | 239 +++++++++++++++++
> fs/nfsd/vfs.h             |  10 +
> fs/nfsd/xdr4.h            |  31 +++
> fs/xattr.c                | 111 +++++++-
> include/linux/nfs4.h      |  22 +-
> include/linux/xattr.h     |   4 +
> include/uapi/linux/nfs4.h |   3 +
> 10 files changed, 1044 insertions(+), 40 deletions(-)
>=20
> --=20
> 2.17.2
>=20

--
Chuck Lever



