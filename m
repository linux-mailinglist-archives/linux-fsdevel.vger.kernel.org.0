Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 036511CFA11
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 May 2020 18:03:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728911AbgELQDJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 May 2020 12:03:09 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:43342 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726055AbgELQDJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 May 2020 12:03:09 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04CFv3dq026382;
        Tue, 12 May 2020 16:02:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=mime-version :
 message-id : date : from : to : cc : subject : references : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=xi1fE0OIOYczCayh3JK/aSeCXO3ktTVQ0riZLtwHdH4=;
 b=YeLXG78GKQ66Yg8stE5C0S1j80EBGkyywTumsNnT/yMFlaWnxd1dv+iqzMLo99hYnkc4
 07mRSs9nK9S9dK0O1SMmHN6udMtt0zRCQjVYYvl1l3NwCkKTpp2uWnZL7E7wkZYKQoxC
 sz3y9ev1QVln+FJoHtZANcUa8dQq30wsCsMGdppdDHH/CJfPUGQSsleV0dIJuM46Fha7
 0HRaq726sFLeAfJoFTCWcs+egQpsX5mX/2PpmBYiaiwR4V2YSfRP/waAD8LSVEld6TOE
 4x/WuykP5e0nFWdG6xTkYHcR981Q8dtRoKdgMIS9mlTXXbgZhOhOz3Zu/9gZzQVizvpc jg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 30x3gskwrg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 12 May 2020 16:02:58 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04CFwZve194131;
        Tue, 12 May 2020 16:02:58 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 30xbgk4jtf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 May 2020 16:02:58 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 04CG2u76018573;
        Tue, 12 May 2020 16:02:57 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123) by default (Oracle
 Beehive Gateway v4.0) with ESMTP ; Tue, 12 May 2020 09:01:21 -0700
ORGANIZATION: Oracle Corporation
USER-AGENT: Gnus/5.13 (Gnus v5.13) Emacs/27.0.91 (gnu/linux)
MIME-Version: 1.0
Message-ID: <yq14ksl2ldd.fsf@oracle.com>
Date:   Tue, 12 May 2020 09:01:18 -0700 (PDT)
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Keith Busch <kbusch@kernel.org>,
        "linux-scsi @ vger . kernel . org" <linux-scsi@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "linux-fsdevel @ vger . kernel . org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v11 00/10] Introduce Zone Append for writing to zoned
 block devices
References: <20200512085554.26366-1-johannes.thumshirn@wdc.com>
 <20200512131748.GA15699@infradead.org>
In-Reply-To: <20200512131748.GA15699@infradead.org> <(Christoph> <Hellwig's>
 <message> <of> <"Tue> <> <12> <May> <2020> <06:17:48> <-0700")>
Content-Type: text/plain; charset=ascii
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9619 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=733
 spamscore=0 suspectscore=0 phishscore=0 bulkscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005120121
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9619 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=763
 malwarescore=0 adultscore=0 mlxscore=0 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 clxscore=1015 bulkscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005120121
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Christoph,

> The whole series looks good to me:
>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
>
> I hope we can get this in 5.8 to help with the btrfs in 5.9.

Yep, I think this looks good.

I suspect this series going to clash with my sd revalidate surgery. I
may have to stick that in a postmerge branch based on Jens' tree.

-- 
Martin K. Petersen	Oracle Linux Engineering
