Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2ABC319709D
	for <lists+linux-fsdevel@lfdr.de>; Sun, 29 Mar 2020 23:57:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729117AbgC2Vyz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 29 Mar 2020 17:54:55 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:60680 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729040AbgC2Vyz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 29 Mar 2020 17:54:55 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02TLsoBn162085;
        Sun, 29 Mar 2020 21:54:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=B7G4JSDRNhZMJ51YOu0qzGgHbOnEk8l01C1lD8kQ0rw=;
 b=PWNVNejG8zO9NJarlriZ7oSJE220XbzTPj0Jh2GP0wQ20vz9M+vyVvAmKO19HjyFRjmS
 FWpAT517odUs2C4eql/GygTkWWpf6kOosMEWRP90mwfG7fCwJszOCPu1WO4xJWDMiW3m
 blR0byYXWd0ZxsRoCMP9aIIUpLDsfXtesox0ggj1Tbx4Vp8+rebD9ajJ4o3wL3CXtkmg
 lBav4LuXtav5Z8yrgw5jHY7nQriOPMgYFIOZZPXZRMIHjZGumf9pt9xI7fLnt/v9tPO5
 bBSfzXBGfa0POx6tyqEKG9v1+iKIHOLhoxutMaAAqEAfVyA9Tc1o03h0x8DU4nCCwukC Ow== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 301y7mkugm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 29 Mar 2020 21:54:50 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02TLrRuf059727;
        Sun, 29 Mar 2020 21:54:49 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 302gc794f5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 29 Mar 2020 21:54:49 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 02TLsePi015564;
        Sun, 29 Mar 2020 21:54:40 GMT
Received: from anon-dhcp-153.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 29 Mar 2020 14:54:40 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: vfs_listxattr and the NFS server: namespaces
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20200329202546.GA31026@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
Date:   Sun, 29 Mar 2020 17:54:38 -0400
Cc:     Bruce Fields <bfields@fieldses.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <EBEE9C01-03A2-4269-A17F-5E391844AC3F@oracle.com>
References: <20200327232717.15331-1-fllinden@amazon.com>
 <20200327232717.15331-11-fllinden@amazon.com>
 <20200329202546.GA31026@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
To:     Frank van der Linden <fllinden@amazon.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9575 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 malwarescore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003290206
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9575 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 phishscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=999 lowpriorityscore=0 adultscore=0
 priorityscore=1501 bulkscore=0 clxscore=1011 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003290206
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Mar 29, 2020, at 4:25 PM, Frank van der Linden =
<fllinden@amazon.com> wrote:
>=20
> On Fri, Mar 27, 2020 at 11:27:16PM +0000, Frank van der Linden wrote:
>> Implement the main entry points for the *XATTR operations.
>>=20
>> Add functions to calculate the reply size for the user extended =
attribute
>> operations, and implement the XDR encode / decode logic for these
>> operations.
>>=20
>> Add the user extended attributes operations to nfsd4_ops.
>=20
> The reason I Cc-ed this one to linux-fsdevel, is the following piece =
of
> code:
>> +	/*
>> +	 * Unfortunately, there is no interface to only list xattrs for
>> +	 * one prefix. So there is no good way to convert maxcount to
>> +	 * a maximum value to pass to vfs_listxattr, as we don't know
>> +	 * how many of the returned attributes will be user attributes.
>> +	 *
>> +	 * So, always ask vfs_listxattr for the maximum size, and encode
>> +	 * as many as possible.
>> +	 */
>> +	listxattrs->lsxa_buf =3D svcxdr_tmpalloc(argp, XATTR_LIST_MAX);
>> +	if (!listxattrs->lsxa_buf)
>> +		status =3D nfserr_jukebox;
>> +
>> +	DECODE_TAIL;
>> +}
>=20
> Naturally, it is a waste to always (temporarily) allocate =
XATTR_LIST_MAX
> (currently 64k) bytes for every listxattr request, when in reality you
> probably won't need anywhere near that.
>=20
> The reason for doing that is that, while the NFS request comes with a=20=

> maximum size, you can't translate that in to a maximum size to pass
> to vfs_listxattr, since you are specifying the max size for "user."
> extended attributes only, since that is the namespace that the NFS
> implementation is restricted to. But vfs_listxattr always retrieves
> all extended attributes.
>=20
> The question is then: how to avoid doing that? It might be a good
> idea to be able to specify a namespace to vfs_listxattr. This isn't
> terribly hard to implement, and can be phased in. E.g:
>=20
> * Add a "const char *namespace" argument to the listxattr inode op
> * For the normal use case it will be NULL, meaning all xattrs. This
>  includes use in the system call path (a new system call that
>  includes a namespace argument could be added).
> * A filesystem that does not support only returning xattrs for one
>  namespace will return a specified error if @namespace !=3D NULL, =
after
>  which the fs-indepdent code in fs/xattr.c falls back to =
pre-allocating
>  an XATTR_LIST_MAX buffer and then filtering out all attributes that
>  are not in the specified namespace.
> * Since the initial use is from the NFS code, converting XFS and ext4
>  to support the @namespace argument should catch most use cases of
>  the @namespace argument, the rest can be converted over time.
>=20
> Does this sound reasonable? Or is it overkill?
>=20
> Another way to do it is to add a vfs_listxattr_alloc variant, and
> have the NFS server code filter out the user. xattrs as now. There is
> one problem with that: it's possible for the size of listxattr result
> to increase between the first null (length probe) call and the second =
call,
> in which case the NFS server would return a spurious error. A small =
chance,
> but it's there nonetheless. And it would be hard to distinguish from
> other errors. So I think I still would prefer using an extra namespace
> argument.
>=20
> Alternatively, we could decide that the temporarily allocation of 64k
> is no big deal.

An order-4 allocation is not something that can be relied upon. I would
rather find a way to avoid the need for it if at all possible.


--
Chuck Lever



