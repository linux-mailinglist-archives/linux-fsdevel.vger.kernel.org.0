Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94D31149F91
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Jan 2020 09:12:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727441AbgA0IMH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Jan 2020 03:12:07 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:37172 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbgA0IMH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Jan 2020 03:12:07 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00R88po0043673;
        Mon, 27 Jan 2020 08:12:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=3VolbQ0o/kJEo5bMe96OVeYFxui+T02Ili+UyFevwTM=;
 b=G2VQlgDhwpGqzmBTQ8Blz8cQwbgpoqsRFY9mMlaoPVw2WOJaWp7MZQUrbGKs7YTi59Mt
 fjJuJoI6vQEE9vd0kLg05/a/RF0kwixzt8BSx2kdFitWGYp2gmiXai8ZNs4kHBroeZI5
 +vnIEdHIs3EAKGdxsnrwCPMyfUgrkaisD30HpMmwmZaFENE8jQxIhm3EIViAHl8ERP2F
 ggQJApLxaVL50Tiopd2nTIKcOMXqXjMeqU6WpFPg2xN74yyua/70aswKedr2gOJcX2H0
 wBmd9ADiw77tvVequQ5kHunc5nzq3eKolY6Fn14/tN1zWTXIP3BoONPeOaaLvzGVcmAn 6g== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2xrd3twqsc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Jan 2020 08:12:03 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00R884ZM006630;
        Mon, 27 Jan 2020 08:12:02 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 2xrytphec7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Jan 2020 08:12:02 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 00R8C1Rt015787;
        Mon, 27 Jan 2020 08:12:01 GMT
Received: from kadam (/129.205.23.165)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 27 Jan 2020 00:12:00 -0800
Date:   Mon, 27 Jan 2020 11:11:52 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Pragat Pandya <pragat.pandya@gmail.com>
Cc:     valdis.kletnieks@vt.edu, gregkh@linuxfoundation.org,
        linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH] staging: exfat: Fix alignment warnings
Message-ID: <20200127081152.GR1847@kadam>
References: <20200125133814.GA3518118@kroah.com>
 <20200126110255.20506-1-pragat.pandya@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200126110255.20506-1-pragat.pandya@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9512 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=862
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001270070
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9512 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=922 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001270070
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

It looks like you sent this on Jan 11 and it was applied already.  Why
are you resending?

regards,
dan carpenter

