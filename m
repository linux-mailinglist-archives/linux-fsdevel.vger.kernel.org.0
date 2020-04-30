Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5D121BEE3B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Apr 2020 04:18:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbgD3CSV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Apr 2020 22:18:21 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:43388 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726180AbgD3CSV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Apr 2020 22:18:21 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03U2HqqX090181;
        Thu, 30 Apr 2020 02:18:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=1ncC5E62RifgtDz5AqVJsSeQgkTe1w/HmEmirWoqSqY=;
 b=FRK4oErvPMpfZ6FYFb9xd/h9WzIdGBBvob/sulyCkrK6L0IFFmdngz9E0dHg0jPmjSto
 KXBiuvxR+twDS7wSOCHgcESAKQsiRcUuATjAQTzyn6nx6SB/gKi7xXt7hkUaIlJRnkqK
 JROtWRNw0TDlbknD4rDd9n8ACf2ywDkpi/mpMqC6fLBbJtLE/KNPyyQJrnWkctXOuQpO
 eFV2BvOMqKYDmr4P4ON7qkXDsijaq/ehJCNCQeKRUWDPdl73BfURrmgzSqgDVAgYL0UE
 jafaY1dV8rKXLJakZKppbeL/CDC8XA3WPZ4MpbypIIufxlOS/T4zdRCTRaz3IoZNNNbA uQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 30p2p0ebjg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Apr 2020 02:18:10 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03U2Gl3G141054;
        Thu, 30 Apr 2020 02:18:10 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 30mxpmf46j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Apr 2020 02:18:09 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 03U2I8EU029855;
        Thu, 30 Apr 2020 02:18:08 GMT
Received: from ca-mkp.ca.oracle.com (/10.156.108.201)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 29 Apr 2020 19:18:08 -0700
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        "linux-fsdevel @ vger . kernel . org" <linux-fsdevel@vger.kernel.org>,
        "linux-scsi @ vger . kernel . org" <linux-scsi@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        linux-block <linux-block@vger.kernel.org>,
        Keith Busch <kbusch@kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [PATCH v9 00/11] Introduce Zone Append for writing to zoned block devices
Date:   Wed, 29 Apr 2020 22:18:03 -0400
Message-Id: <158821297686.28621.178479649242411251.b4-ty@oracle.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200428104605.8143-1-johannes.thumshirn@wdc.com>
References: <20200428104605.8143-1-johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9606 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=872 malwarescore=0
 mlxscore=0 bulkscore=0 adultscore=0 phishscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004300015
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9606 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 clxscore=1011
 bulkscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0
 mlxscore=0 suspectscore=0 mlxlogscore=930 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004300014
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 28 Apr 2020 19:45:54 +0900, Johannes Thumshirn wrote:

> The upcoming NVMe ZNS Specification will define a new type of write
> command for zoned block devices, zone append.
> 
> When when writing to a zoned block device using zone append, the start
> sector of the write is pointing at the start LBA of the zone to write to.
> Upon completion the block device will respond with the position the data
> has been placed in the zone. This from a high level perspective can be
> seen like a file system's block allocator, where the user writes to a
> file and the file-system takes care of the data placement on the device.
> 
> [...]

Applied to 5.8/scsi-queue, thanks!

[01/11] scsi: core: free sgtables in case command setup fails
        https://git.kernel.org/mkp/scsi/c/20a66f2bf280

-- 
Martin K. Petersen	Oracle Linux Engineering
