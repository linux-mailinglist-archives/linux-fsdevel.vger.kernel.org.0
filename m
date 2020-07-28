Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89A0F230C41
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jul 2020 16:17:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730319AbgG1ORY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jul 2020 10:17:24 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:46806 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730008AbgG1ORY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jul 2020 10:17:24 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06SEBjJA129609;
        Tue, 28 Jul 2020 14:17:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=zaeXQtBSxbwu6nJ+bSTQBejub++NhL0BQ3dLvo4rkDw=;
 b=skRp4ywMekCDJ8j09fKXAharqCNzyWyO5TxaXpQTCndnhgc69Lqc5c0HMuTCWNnJ0H2t
 olPpFfs8xKq0rWAi+sONTV2lF5z79CMYEn5Mcbnx4Jf6jY5Hhrx7kz/gFGiZv/iG5EwO
 NXKnSz+A58cfSWDcgs+RA6h5eFlt4qdMV784gzxeyHLd1PPZtedxUMMrTkqiEPUlTkYY
 OAyCflJ1+487Hyaniw0XoCtxonIR9xc8j454u1BOdmQF5HFGMH48+QeS+B1qB6fr8k2p
 27ZtD/a5SzKgdM5ZYItIlqlE8khA83k6f8inQFdEfK32k/8/B66LT9SwSB+CDi7QSlSG PA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 32hu1jfrsc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 28 Jul 2020 14:17:17 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06SEEZ8E063100;
        Tue, 28 Jul 2020 14:17:16 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 32hu5synxt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Jul 2020 14:17:16 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 06SEH9Wh004315;
        Tue, 28 Jul 2020 14:17:10 GMT
Received: from anon-dhcp-152.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 28 Jul 2020 07:17:09 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH v3 02/10] xattr: add a function to check if a namespace is
 supported
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <CAHk-=wj=gr3F3ZTnz8fnpSqfxivYKaFLvB+8UJOq3nTF9gzzyw@mail.gmail.com>
Date:   Tue, 28 Jul 2020 10:17:07 -0400
Cc:     Frank van der Linden <fllinden@amazon.com>,
        Bruce Fields <bfields@fieldses.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <03E295AE-984E-47B1-ABC2-167C69D6DCC2@oracle.com>
References: <20200623223927.31795-1-fllinden@amazon.com>
 <20200623223927.31795-3-fllinden@amazon.com>
 <20200625204157.GB10231@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
 <20200714171328.GB24687@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
 <CAHk-=wj=gr3F3ZTnz8fnpSqfxivYKaFLvB+8UJOq3nTF9gzzyw@mail.gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9695 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 bulkscore=0
 malwarescore=0 suspectscore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007280109
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9695 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1011 mlxlogscore=999
 malwarescore=0 impostorscore=0 priorityscore=1501 spamscore=0 phishscore=0
 suspectscore=0 bulkscore=0 mlxscore=0 lowpriorityscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007280109
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus-

> On Jul 14, 2020, at 2:46 PM, Linus Torvalds =
<torvalds@linux-foundation.org> wrote:
>=20
> On Tue, Jul 14, 2020 at 10:13 AM Frank van der Linden
> <fllinden@amazon.com> wrote:
>>=20
>> Again, Linus - this is a pretty small change, doesn't affect any =
existing
>> codepaths, and it's already in the tree Chuck is setting up for 5.9. =
Could
>> this go in through that directly?
>=20
> Both ok by me, but I'd like to have Al ack them. Al?

I have the NFSD user xattr patches in the current series waiting to be
merged into v5.9. I'd like to create the nfsd-5.9 merge tag soon, but I
haven't heard any review comments from Al. How would you like me to
proceed?


--
Chuck Lever



