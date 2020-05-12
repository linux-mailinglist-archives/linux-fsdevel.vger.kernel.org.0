Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5CDF1CFA56
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 May 2020 18:15:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728334AbgELQPB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 May 2020 12:15:01 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:56646 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727915AbgELQPB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 May 2020 12:15:01 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04CGCI8B015542;
        Tue, 12 May 2020 16:14:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2020-01-29;
 bh=jfNIRjccwnvqnFIrzDzQr48D/17TCvRV1Qnnis5ecl0=;
 b=niJi7UYHIdNqGmAJy4SWdhaxvpU5EyZA2gNb+WwT7U0Bq06E3aMzWlBD0RQYVgh/sDoJ
 7DrJI9qRGuxEm49tSRWCpCrqanWS3neJBvzPbCmTxuixcun2xPH/pucyOGE1HaTyrVoB
 B10lrcAvo5BRd3xEVCUMvibWbicyUCdxWH8bCBkHlx77qBcIEyxfMtHRgKpqG7gSS6RR
 TSihKecOJU7Uzws4UR38i1tK2v3zBvVT2aWW6tX/yM7rQbKcIWvCRMLDgqiNg6Yme0lu
 DyXPdL7WXlODZsXvqp+lSo60AjAv2oJO4EPiH6/7aq8MWkTvOhRyat5ApX00JuTZSBBo IA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 30x3gmm1p0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 12 May 2020 16:14:56 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04CG7wvY100421;
        Tue, 12 May 2020 16:12:55 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 30ydsqsdm1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 May 2020 16:12:55 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 04CGCrr4005079;
        Tue, 12 May 2020 16:12:53 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 12 May 2020 09:12:53 -0700
To:     Christoph Hellwig <hch@infradead.org>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Keith Busch <kbusch@kernel.org>,
        "linux-scsi @ vger . kernel . org" <linux-scsi@vger.kernel.org>,
        "linux-fsdevel @ vger . kernel . org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v11 00/10] Introduce Zone Append for writing to zoned
 block devices
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20200512085554.26366-1-johannes.thumshirn@wdc.com>
        <20200512131748.GA15699@infradead.org> <yq14ksl2ldd.fsf@oracle.com>
        <20200512160410.GA22624@infradead.org>
Date:   Tue, 12 May 2020 12:12:50 -0400
In-Reply-To: <20200512160410.GA22624@infradead.org> (Christoph Hellwig's
        message of "Tue, 12 May 2020 09:04:10 -0700")
Message-ID: <yq1zhad169p.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.0.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9619 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 mlxscore=0
 adultscore=0 mlxlogscore=852 malwarescore=0 bulkscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005120122
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9619 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=881
 clxscore=1015 spamscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0
 malwarescore=0 priorityscore=1501 mlxscore=0 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005120123
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Christoph,

> Where is that series?  I don't remember any changes in that area.

Haven't posted it yet. Still working on a few patches that address
validating reported values for devices that change parameters in flight.

The first part of the series is here:

https://git.kernel.org/pub/scm/linux/kernel/git/mkp/linux.git/log/?h=5.8/sd-revalidate

-- 
Martin K. Petersen	Oracle Linux Engineering
