Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1AA7231E7F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jul 2020 14:24:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726519AbgG2MX7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Jul 2020 08:23:59 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:33720 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726476AbgG2MX7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Jul 2020 08:23:59 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06TCHlxd074429;
        Wed, 29 Jul 2020 12:23:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=RBTsiZ1Fq2Xqu4KecE3CvmLgU0UOG2nLZCW6tCZnvMc=;
 b=WdTib8RAv9BG+Ogl5kM3m7jP3mfBu4mkMoPHO+0PeH/yzW0AeGy93paU25OqdvQVvPIT
 DkRm95HCbwOGYN9m70pMrL1qzmIsYeHGaLjsnJOoqfVhqGnB+tS2ExjtmI5xl+67oBtt
 39BYGrQtBn7WjMe28eWWnrf1DxXuH7m9wLeOeH8m7zRWTkDsJbxe//Rp+L8MJKZb7MRG
 /rod5IpiPjoiegTk+n74lSY13fw9UKPOGx4MJ0fIDoHXB0jEK3drye+R5VgkT1msz2Ym
 1R7QUC2kSNWQAHAQZlOXEXafzir97wfVRex2Xp1SI4d8IX4Pw2SA2v8TcJH3hwAmeZC0 +g== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 32hu1jn8hg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 29 Jul 2020 12:23:54 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06TCCkGX013164;
        Wed, 29 Jul 2020 12:23:53 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 32hu5vp6qd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Jul 2020 12:23:53 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 06TCNprr000689;
        Wed, 29 Jul 2020 12:23:51 GMT
Received: from anon-dhcp-152.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 29 Jul 2020 05:23:51 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH v3 02/10] xattr: add a function to check if a namespace is
 supported
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20200728143307.GB951209@ZenIV.linux.org.uk>
Date:   Wed, 29 Jul 2020 08:23:50 -0400
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Frank van der Linden <fllinden@amazon.com>,
        Bruce Fields <bfields@fieldses.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <0BAC8FEB-2B2A-40F3-9A1F-B37BF2F79D90@oracle.com>
References: <20200623223927.31795-1-fllinden@amazon.com>
 <20200623223927.31795-3-fllinden@amazon.com>
 <20200625204157.GB10231@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
 <20200714171328.GB24687@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
 <CAHk-=wj=gr3F3ZTnz8fnpSqfxivYKaFLvB+8UJOq3nTF9gzzyw@mail.gmail.com>
 <03E295AE-984E-47B1-ABC2-167C69D6DCC2@oracle.com>
 <20200728143307.GB951209@ZenIV.linux.org.uk>
To:     Al Viro <viro@zeniv.linux.org.uk>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9696 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxscore=0 adultscore=0 spamscore=0 phishscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007290081
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9696 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 mlxlogscore=999
 malwarescore=0 impostorscore=0 priorityscore=1501 spamscore=0 phishscore=0
 suspectscore=0 bulkscore=0 mlxscore=0 lowpriorityscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007290081
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Jul 28, 2020, at 10:33 AM, Al Viro <viro@zeniv.linux.org.uk> wrote:
>=20
> On Tue, Jul 28, 2020 at 10:17:07AM -0400, Chuck Lever wrote:
>> Hi Linus-
>>=20
>>> On Jul 14, 2020, at 2:46 PM, Linus Torvalds =
<torvalds@linux-foundation.org> wrote:
>>>=20
>>> On Tue, Jul 14, 2020 at 10:13 AM Frank van der Linden
>>> <fllinden@amazon.com> wrote:
>>>>=20
>>>> Again, Linus - this is a pretty small change, doesn't affect any =
existing
>>>> codepaths, and it's already in the tree Chuck is setting up for =
5.9. Could
>>>> this go in through that directly?
>>>=20
>>> Both ok by me, but I'd like to have Al ack them. Al?
>>=20
>> I have the NFSD user xattr patches in the current series waiting to =
be
>> merged into v5.9. I'd like to create the nfsd-5.9 merge tag soon, but =
I
>> haven't heard any review comments from Al. How would you like me to
>> proceed?
>=20
> Looks sane, AFAICS.  Sorry, still digging myself from under the mounds =
of
> mail...

No problem at all. Thanks!

--
Chuck Lever



