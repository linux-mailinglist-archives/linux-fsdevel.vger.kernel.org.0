Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A43F9241B84
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Aug 2020 15:19:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728721AbgHKNT1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Aug 2020 09:19:27 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:43640 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728708AbgHKNT0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Aug 2020 09:19:26 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07BDHqln106898;
        Tue, 11 Aug 2020 13:19:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=eHL++QnHphPePYIhSoVVQ5kFXWG75NQVIwJipObuJ7U=;
 b=JGVXJMHJt+IaTtIQbe6SxGOsd5bLj94dRZDZcX2xTzybcbx3ntA0y4g9Adc5ELzZILa3
 9m1T+8dcHWO2HZjUWLWOrwNS89HOiVhnnK0dzgkvpqpG9dABUIHrHR2Lm5Jgsjz5MK+P
 bLGavXTHBUCt813ICH+wiG4TzNh0ynFiH4CNFPnJR3h69Aun5XWtoaJgwuE8yY/hhUDc
 KvrtyX64Pf2VpI09OAfUvBk91x60POKJVASV+Nv6CCtFjuZlDyElUaqBzsGRjWM8OKuT
 4PzEty/v/zSf08jb1XDPpnTMPUo0mlDvhbRpJjF7VEk4G0uKf5ahzQNBBaZiwJR6RYOk Kw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 32t2ydjwdy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 11 Aug 2020 13:19:20 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07BDJIUe177486;
        Tue, 11 Aug 2020 13:19:19 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 32t5y3yg5c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Aug 2020 13:19:19 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 07BDJ5Im010666;
        Tue, 11 Aug 2020 13:19:05 GMT
Received: from anon-dhcp-152.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 11 Aug 2020 13:19:05 +0000
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: Please pull NFS server updates for v5.9
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20200811161518.0896c1e8@canb.auug.org.au>
Date:   Tue, 11 Aug 2020 09:19:03 -0400
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Trond Myklebust <trondmy@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <5D3B9AC6-6A27-4795-A256-C9CE0D459D15@oracle.com>
References: <F9B8940D-9F7B-47F5-9946-D77C17CF959A@oracle.com>
 <20200810090349.64bce58f@canb.auug.org.au>
 <EC1AA9E7-4AC1-49C6-B138-B6A3E4ED7A0B@oracle.com>
 <20200811161518.0896c1e8@canb.auug.org.au>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9709 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0
 suspectscore=0 mlxscore=0 adultscore=0 bulkscore=0 phishscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008110092
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9709 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 priorityscore=1501
 malwarescore=0 impostorscore=0 lowpriorityscore=0 mlxscore=0 bulkscore=0
 suspectscore=0 phishscore=0 adultscore=0 spamscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008110092
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Aug 11, 2020, at 2:15 AM, Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>=20
> Hi Chuck,
>=20
> On Mon, 10 Aug 2020 08:25:14 -0400 Chuck Lever =
<chuck.lever@oracle.com> wrote:
>>=20
>> Is there something I need to change? The public copy of the =
cel-testing
>> branch has had this content for the past 12 days.
>=20
> You just need to keep your cel-next branch up to the top commit that =
is
> ready.  That is the branch you told me to fetch.  It is currently at =
commit
>=20
>  0a8e7b7d0846 ("SUNRPC: Revert 241b1f419f0e ("SUNRPC: Remove =
xdr_buf_trim()")")
>=20
> It looks like that is what Linus merged into v5.7-rc2.

Ah. I thought you were pulling cel-testing, so I deleted cel-next. I =
will
rehydrate cel-next right now.

--
Chuck Lever



