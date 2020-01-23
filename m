Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9357C1462AB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2020 08:27:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725989AbgAWH1j (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Jan 2020 02:27:39 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:59206 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725777AbgAWH1j (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Jan 2020 02:27:39 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00N7NSGB134299;
        Thu, 23 Jan 2020 07:27:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=corp-2019-08-05;
 bh=aNJtCdKiyElSLkFhxuIW9EKjg+NzaLIcTRbJ9YNwB90=;
 b=E0fWqhfGjPoWviMF9bDHdBTYzPeAvOZjFjvd2Fewp45EXCVCMUZDVMupfudy3DavDO7c
 ScNx1/ztlJfPQRpCpe+rvRC8gPyiAxEqVbfVJueoYR5Qe2HSXP++oVi9b60eUk4ZHWZi
 ZWxdkW9K1WbmXfeX451EdmGtbUuJwVetgBBlxEJKOtK8ECazO1EY5WRHQ+l5/wnlCQJw
 KwV7vzj57yoA34ulxdLtitNUAR3Trxxd18FzwPZDky81Jhcq4jErEQJo8w2m63f37+gV
 ht1aniAVX6aQ66fhfsX2xcr+506dF2YH6AlGPx1wRW5igiysyg35hvSKWZCyVv5tO6Y4 ig== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2xktnrg8a5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Jan 2020 07:27:29 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00N7NHM7032257;
        Thu, 23 Jan 2020 07:25:28 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 2xppq4wd4j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Jan 2020 07:25:28 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 00N7PP8h001915;
        Thu, 23 Jan 2020 07:25:25 GMT
Received: from kadam (/129.205.23.165)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 22 Jan 2020 23:25:24 -0800
Date:   Thu, 23 Jan 2020 10:25:15 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     me@kaowomen.cn
Cc:     "Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp" 
        <Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp>,
        "'devel@driverdev.osuosl.org'" <devel@driverdev.osuosl.org>,
        "'Valdis Kletnieks'" <valdis.kletnieks@vt.edu>,
        "'Greg Kroah-Hartman'" <gregkh@linuxfoundation.org>,
        "Motai.Hirotaka@aj.MitsubishiElectric.co.jp" 
        <Motai.Hirotaka@aj.MitsubishiElectric.co.jp>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "Mori.Takahiro@ab.MitsubishiElectric.co.jp" 
        <Mori.Takahiro@ab.MitsubishiElectric.co.jp>,
        "'linux-fsdevel@vger.kernel.org'" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] staging: exfat: remove fs_func struct.
Message-ID: <20200123072515.GJ1847@kadam>
References: <20200117062046.20491-1-Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp>
 <20200122085737.GA2511011@kroah.com>
 <OSAPR01MB1569F24512678DEA1C175504900F0@OSAPR01MB1569.jpnprd01.prod.outlook.com>
 <20200123070435.cjso5yh6nmmhd4gm@kaowomen.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200123070435.cjso5yh6nmmhd4gm@kaowomen.cn>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9508 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001230063
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9508 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001230063
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 23, 2020 at 03:04:35PM +0800, me@kaowomen.cn wrote:
> On Thu, Jan 23, 2020 at 06:38:53AM +0000, Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp wrote:
> > Hello, Greg.
> > 
> > Thank you for the quick reply.
> > 
> > > Also the patch does not apply to the linux-next tree at all, so I can't take it.
> > The patch I sent was based on the master branch of “https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git/”
> > and its tag was v5.5-rc6.
> > 
> > > Also the patch does not apply to the linux-next tree at all, so I can't take it.  Please rebase and resend.
> > I will send a new patch based on the latest master branch of “https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git”.
> > 
> > 
> > By the way, could you answer below questions for my sending patches in future?
> > 1. Which repository and branch should be based when creating a new patch?
> > 2. How do I inform you about a base on which I create a patch?
> If you like you can add [PATCH -next] to patch title before send it. :)

This applies to networking and not to staging.  For staging, always work
against linux-next or staging-next.

For networking patches sent to Dave Miller, then you have to figure out
if the patch applies to [PATCH net] or [PATCH net-next].  Just putting
[PATCH -next] because you happen to be working on linux-next is not
correct.  You have to investigate both networking trees to determine
where the patch should be applied.

regards,
dan carpenter
