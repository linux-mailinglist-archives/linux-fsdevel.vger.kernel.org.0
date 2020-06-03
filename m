Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10CE31EC702
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jun 2020 03:59:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725854AbgFCB7k (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Jun 2020 21:59:40 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:52026 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725777AbgFCB7k (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Jun 2020 21:59:40 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0531q8Tn136677;
        Wed, 3 Jun 2020 01:59:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : mime-version :
 content-type; s=corp-2020-01-29;
 bh=LA/R9GKBwbdN4mXyUNmnz5fo3CahJp9bsWipVyj+2Is=;
 b=o7xV1BeGfb9Bu2fOyx79Iz4dI/nQdWO13YVde928CMguoqwvJIhiXpAQRLG+Lt4QcyXP
 oG6k8fuaDV1lsSpSvOSmUCCtd7EV3iKVCUaROGWpRzIeWtcWgENnn827CkS0PSCGtr/J
 CHTEdFpauv+wTbgcJXiI2nWvLfBbLxPo2IDiqd+VrPDxAWPJm1CcJA53xgTefmHwVP4F
 NQu1BPDMDnBj5acSxVang3RGlR8nDKZAcUvJ/uebiHlWimjiB57xcPi/VqWlzZsCZrlj
 QHdd7yZkeKJFefZHhWBNjG5y2vFPTgmShwO/Qk3Qkg7x4xCvvDoL4lZzaca7kmVeWGpz /A== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 31dkrukthb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 03 Jun 2020 01:59:36 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0531rH70005886;
        Wed, 3 Jun 2020 01:57:35 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 31c1dy727y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 Jun 2020 01:57:35 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0531vYhv001954;
        Wed, 3 Jun 2020 01:57:34 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 02 Jun 2020 18:57:34 -0700
To:     Don Brace <don.brace@microsemi.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-scsi@vger.kernel.org
Subject: Re: [PATCHES] uaccess hpsa
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1v9k89ajq.fsf@ca-mkp.ca.oracle.com>
References: <20200528234025.GT23230@ZenIV.linux.org.uk>
        <20200529233923.GL23230@ZenIV.linux.org.uk>
Date:   Tue, 02 Jun 2020 21:57:32 -0400
In-Reply-To: <20200529233923.GL23230@ZenIV.linux.org.uk> (Al Viro's message of
        "Sat, 30 May 2020 00:39:23 +0100")
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9640 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=848
 spamscore=0 bulkscore=0 adultscore=0 suspectscore=1 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006030012
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9640 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 priorityscore=1501
 mlxscore=0 lowpriorityscore=0 suspectscore=1 malwarescore=0 clxscore=1011
 adultscore=0 mlxlogscore=890 cotscore=-2147483648 phishscore=0 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006030012
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


> 	hpsa compat ioctl done (hopefully) saner.  I really want
> to kill compat_alloc_user_space() off - it's always trouble and
> for a driver-private ioctls it's absolutely pointless.
>
> 	Note that this is only compile-tested - I don't have the
> hardware to test it on *or* userland to issue the ioctls in
> question.  So this series definitely needs a review and testing
> from hpsa maintainers before it might go anywhere.

Don: Please test and review. Thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
