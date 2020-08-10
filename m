Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16E182405D1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Aug 2020 14:25:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726656AbgHJMZ2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Aug 2020 08:25:28 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:35804 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726518AbgHJMZ2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Aug 2020 08:25:28 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07ACGVaX182587;
        Mon, 10 Aug 2020 12:25:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=LHGAkcFYSyuaEFdv/TGZUvxSEINDvA0B41yBg/c6SCw=;
 b=lWO4TZW6vjoZZdMr0YgLUAuFsqEV37EnHoL6zkRbnCBUoeyTNLwytQ3xYqhMjbPqA0P6
 Yg3rEEkajyM2AlaWmKlQFdTbO5/mI2HII1zGxIOoyKGmLW5wwExIZUFycPl00yXPeaAV
 r6/a9pFEl7zGMV29d2ZFKYwSy4TN24aksQ3v0QCgCZ/iC5MMtzJSo4Dt005rSY7w4gLi
 zpizs2Pkej0tkjkqdXuS0B67jDvn4zyenRs9CL/4HtYeD293U0ZDD3VSTspkk2gjzRU3
 PCzbAStfl4nSbvJkPVC96wRWcy7Bkymv8P0goBbLx8kdDjWDE901ysGO++3fhgU6MXcO ng== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 32smpn64f6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 10 Aug 2020 12:25:18 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07ACJFAn052752;
        Mon, 10 Aug 2020 12:25:18 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 32t5y0py2n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Aug 2020 12:25:17 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 07ACPGHe006184;
        Mon, 10 Aug 2020 12:25:16 GMT
Received: from anon-dhcp-152.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 10 Aug 2020 12:25:15 +0000
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: Please pull NFS server updates for v5.9
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20200810090349.64bce58f@canb.auug.org.au>
Date:   Mon, 10 Aug 2020 08:25:14 -0400
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Trond Myklebust <trondmy@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <EC1AA9E7-4AC1-49C6-B138-B6A3E4ED7A0B@oracle.com>
References: <F9B8940D-9F7B-47F5-9946-D77C17CF959A@oracle.com>
 <20200810090349.64bce58f@canb.auug.org.au>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9708 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0
 suspectscore=0 mlxscore=0 adultscore=0 bulkscore=0 phishscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008100092
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9708 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 lowpriorityscore=0
 bulkscore=0 impostorscore=0 phishscore=0 clxscore=1011 spamscore=0
 malwarescore=0 adultscore=0 mlxlogscore=999 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008100092
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Aug 9, 2020, at 7:03 PM, Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>=20
> Hi Chuck,
>=20
> On Sun, 9 Aug 2020 11:44:15 -0400 Chuck Lever <chuck.lever@oracle.com> =
wrote:
>>=20
>> The following changes since commit =
11ba468877bb23f28956a35e896356252d63c983:
>>=20
>>  Linux 5.8-rc5 (2020-07-12 16:34:50 -0700)
>>=20
>> are available in the Git repository at:
>>=20
>>  git://git.linux-nfs.org/projects/cel/cel-2.6.git tags/nfsd-5.9
>>=20
>> for you to fetch changes up to =
b297fed699ad9e50315b27e78de42ac631c9990d:
>>=20
>>  svcrdma: CM event handler clean up (2020-07-28 10:18:15 -0400)
>=20
> Despite you having a branch included in linux-next, only one of these
> commits has been in linux-next :-( (and that via Trond's nfs tree)

Is there something I need to change? The public copy of the cel-testing
branch has had this content for the past 12 days.


--
Chuck Lever



