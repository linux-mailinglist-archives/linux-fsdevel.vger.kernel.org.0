Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BDAE214622B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2020 07:52:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725897AbgAWGwX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Jan 2020 01:52:23 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:35866 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725535AbgAWGwX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Jan 2020 01:52:23 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00N6iNau091086;
        Thu, 23 Jan 2020 06:52:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=corp-2019-08-05;
 bh=NuRcXMlTm8Bb5dohmxmth9jGE9hSFEME+bJF931/IlY=;
 b=X48zT7VWXjkmD8/T/ZcSh3QdpAlYNFaOBryEn4nUdJ9m447I9rpzp+bVvA48pqyH8tbu
 XWyLwYF+6+xukcX0Jq98Lie60CHAyXIslNVItjdGxTyvqGdurUqrK3SEbSxCW1iblvRW
 ECNFGDz/vbBOLnfWHxh3qJXYkE50laFe7+DC3w+6J0KjWwX4l6fen7WXvRFJrpqrQNum
 TDiTl7oltyDh1j7bXx2equjI+Qj0cLgRVsV4UeBP3RggEUKqTpo4Epq9Pp5a/VcXZQ7R
 dqJjd3X1Z7VRFm8YbS9L5FKPMJ3p5sGDEnlaFiqNoNbQpoDCTz4G+FTPZyv/nLVFPteG rg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2xksyqg8nf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Jan 2020 06:52:16 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00N6iI3l097074;
        Thu, 23 Jan 2020 06:52:16 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 2xpq0vs8rj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Jan 2020 06:52:15 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 00N6qEhW020600;
        Thu, 23 Jan 2020 06:52:14 GMT
Received: from kadam (/129.205.23.165)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 22 Jan 2020 22:52:13 -0800
Date:   Thu, 23 Jan 2020 09:52:05 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     "Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp" 
        <Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp>
Cc:     "'Greg Kroah-Hartman'" <gregkh@linuxfoundation.org>,
        "'devel@driverdev.osuosl.org'" <devel@driverdev.osuosl.org>,
        "'Valdis Kletnieks'" <valdis.kletnieks@vt.edu>,
        "Motai.Hirotaka@aj.MitsubishiElectric.co.jp" 
        <Motai.Hirotaka@aj.MitsubishiElectric.co.jp>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "Mori.Takahiro@ab.MitsubishiElectric.co.jp" 
        <Mori.Takahiro@ab.MitsubishiElectric.co.jp>,
        "'linux-fsdevel@vger.kernel.org'" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] staging: exfat: remove fs_func struct.
Message-ID: <20200123065205.GH1847@kadam>
References: <20200117062046.20491-1-Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp>
 <20200122085737.GA2511011@kroah.com>
 <OSAPR01MB1569F24512678DEA1C175504900F0@OSAPR01MB1569.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <OSAPR01MB1569F24512678DEA1C175504900F0@OSAPR01MB1569.jpnprd01.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9508 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001230057
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9508 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001230057
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 23, 2020 at 06:38:53AM +0000, Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp wrote:
> Hello, Greg.
> 
> Thank you for the quick reply.
> 
> > Also the patch does not apply to the linux-next tree at all, so I can't take it.
> The patch I sent was based on the master branch of “https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git/”
> and its tag was v5.5-rc6.
> 
> > Also the patch does not apply to the linux-next tree at all, so I can't take it.  Please rebase and resend.
> I will send a new patch based on the latest master branch of “https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git”.
> 
> 
> By the way, could you answer below questions for my sending patches in future?
> 1. Which repository and branch should be based when creating a new patch?
> 2. How do I inform you about a base on which I create a patch?

Always base it on staging-next or linux-next.

No need to inform us.  If it doesn't apply Greg will email you.

regards,
dan carpenter

