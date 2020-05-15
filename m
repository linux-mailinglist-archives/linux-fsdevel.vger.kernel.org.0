Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 202F61D42AB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 May 2020 03:04:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728097AbgEOBEg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 May 2020 21:04:36 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:59218 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727084AbgEOBEf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 May 2020 21:04:35 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04F11PTl104648;
        Fri, 15 May 2020 01:04:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2020-01-29;
 bh=lTuyXb1zzAAFeltFSGKcd91dSqPhr8vBIQ5tAf2GO84=;
 b=k13lKwLP1ExxmJ0JwHGNgCI51Egbi6J5aoENT89TJbJnjhk4rhVPGruZVtelThL8GvtX
 AEMLMVUod0kS4YDTIn/WuoD58sRAoVRqL2vsgB9kbGVL+8j2ICIBXeBgaywmBGOEbWBl
 oF42PKxr1u+Ox1MdAT9+CI2IONDeXAl9vtMywAGiRuJLarm93Q0J+uPm40OWkLMIjAp4
 +ILwYrazH/4MRUKrRb/rrLaITa/LSea62BNNnPy9q6W2qko3yqctJ6q7ekXX+9YRqpqz
 oCnj5erPfQ2sYP5K/qVHD5qSKWNm0LO9+7rMpySAPQ6CoLjmcTeFY12VifV5eKT/3OPm Ew== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 3100xwpmhp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 15 May 2020 01:04:14 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04F12iZb138042;
        Fri, 15 May 2020 01:04:14 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 310vjufqck-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 May 2020 01:04:14 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 04F14BZf004805;
        Fri, 15 May 2020 01:04:12 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 14 May 2020 18:04:11 -0700
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Satya Tangirala <satyat@google.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-ext4@vger.kernel.org,
        Barani Muthukumaran <bmuthuku@qti.qualcomm.com>,
        Kuohong Wang <kuohong.wang@mediatek.com>,
        Kim Boojin <boojin.kim@samsung.com>
Subject: Re: [PATCH v13 00/12] Inline Encryption Support
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20200514003727.69001-1-satyat@google.com>
        <20200514051053.GA14829@sol.localdomain>
Date:   Thu, 14 May 2020 21:04:08 -0400
In-Reply-To: <20200514051053.GA14829@sol.localdomain> (Eric Biggers's message
        of "Wed, 13 May 2020 22:10:53 -0700")
Message-ID: <yq1tv0irotz.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.0.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9621 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 phishscore=0
 spamscore=0 mlxlogscore=944 malwarescore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005150007
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9621 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 lowpriorityscore=0
 suspectscore=0 mlxlogscore=972 clxscore=1011 cotscore=-2147483648
 mlxscore=0 phishscore=0 adultscore=0 impostorscore=0 bulkscore=0
 malwarescore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2005150007
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Eric,

> Then patches 6-12 can go upstream via the SCSI and fscrypt trees in
> the following release.

I'd like our UFS folks to review the UFS patches. But otherwise no
objection from me.

-- 
Martin K. Petersen	Oracle Linux Engineering
