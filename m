Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA2361259EE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2019 04:19:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727092AbfLSDTK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Dec 2019 22:19:10 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:49688 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726773AbfLSDTK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Dec 2019 22:19:10 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBJ39uYC068077;
        Thu, 19 Dec 2019 03:18:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2019-08-05;
 bh=oLFGR/WhIs5dA3HxvsHBFdeGRs+wvX0i1xh6f2MYyak=;
 b=fUfP3frzqd+rvFOH7JcewpXXCeJ3/2sQfUXbVYzrcjnegAmXD+1cw+nkY6p1n8WC/jfq
 2T0ejE4lcRIcgqh3bPB9O/uE1jZWOAYo+JrI7UTtWdOFaI40Sv3aeUyzl12bXLyrk32G
 FRjWhE79aO5nPaGPKHkX+WRqehzPNfVTQuPrb56Mu0rJi55OPzR/wsJAWebKD2ickLL4
 oizKrdcRrkkBIYEMp7fSmKGq0A4IF0TUKCypatDE6Gtz3Z3jEG3vmlB4zXRgXTVPFHHe
 lfgq4tZyurWkw0Yw8Hd7AwbZLL0VMV1yL4kpLx3A+3PGJ0ycjkZbx1sgz+vmqD6Cjr57 mA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2wvqpqhfwf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Dec 2019 03:18:49 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBJ39t0O038689;
        Thu, 19 Dec 2019 03:18:49 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 2wyut4nd60-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Dec 2019 03:18:49 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xBJ3IX95010331;
        Thu, 19 Dec 2019 03:18:33 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 18 Dec 2019 19:18:33 -0800
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Jens Axboe <axboe@kernel.dk>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        "open list\:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>
Subject: Re: [GIT PULL v2 00/27] block, scsi: final compat_ioctl cleanup
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20191217221708.3730997-1-arnd@arndb.de>
        <CAK8P3a3fsDRsZh--vn4SWA-NfeeSpzueqGDvjF5jDSZ91P9+Hw@mail.gmail.com>
Date:   Wed, 18 Dec 2019 22:18:28 -0500
In-Reply-To: <CAK8P3a3fsDRsZh--vn4SWA-NfeeSpzueqGDvjF5jDSZ91P9+Hw@mail.gmail.com>
        (Arnd Bergmann's message of "Wed, 18 Dec 2019 18:24:32 +0100")
Message-ID: <yq1sglhc8aj.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9475 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1912190025
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9475 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1912190025
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Hi Arnd!

> Any suggestion for how this should be merged?

I'm pretty flexible. When you post v3 I'll try to set up a branch to get
an idea what conflicts we might have to deal with. And then we can take
it from there.

-- 
Martin K. Petersen	Oracle Linux Engineering
