Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A6BB61848E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 May 2019 06:35:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726174AbfEIEfb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 May 2019 00:35:31 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:40954 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726108AbfEIEfb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 May 2019 00:35:31 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x494YJKg104323;
        Thu, 9 May 2019 04:35:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=RV+2M5Iv0ng37u9CKt+NTqF87XfFZ6Qo80WAgSf1i94=;
 b=A7ni1vmq5k3wIYCnYTnrvRuKP8vAWvBWlYQBjkQpL25kasewA9Va459kJPC8eW6Uf6oc
 BgMQ2ZEQ/1A9E/9B81mxT2ZyMDdM4h2hrc+pCwFqEttF5EgFSEXUUGGTLlrAdKRHuluJ
 SJeqm8BI93zSoXXWdgQH6haeJA/qNR+TSHp93VSHpoQsrhQt/O8wR30DSkFoNNaHmylN
 A62bK8iWRopelvyfuCsLxwhA/EYw/DIxtGx6ZGs7KgHbzDltyXytrgqIZV1DCfu2bX1X
 x2CENnzb9Bets4GnSdgOPsUZXV+HhwdkVmbht8Nrlwqm73jrfO7AJXtN5RAlUIJOufc6 0w== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2s94b107bp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 May 2019 04:35:13 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x494XO0N159903;
        Thu, 9 May 2019 04:35:12 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 2s94agj9fj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 May 2019 04:35:12 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x494Z9d1020365;
        Thu, 9 May 2019 04:35:09 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 08 May 2019 21:35:09 -0700
To:     Dave Chinner <david@fromorbit.com>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Ric Wheeler <ricwheeler@gmail.com>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        lczerner@redhat.com
Subject: Re: Testing devices for discard support properly
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <4a484c50-ef29-2db9-d581-557c2ea8f494@gmail.com>
        <20190507220449.GP1454@dread.disaster.area>
        <a409b3d1-960b-84a4-1b8d-1822c305ea18@gmail.com>
        <20190508011407.GQ1454@dread.disaster.area>
        <13b63de0-18bc-eb24-63b4-3c69c6a007b3@gmail.com>
        <yq1a7fwlvzb.fsf@oracle.com>
        <0a16285c-545a-e94a-c733-bcc3d4556557@gmail.com>
        <20190508215832.GR1454@dread.disaster.area>
        <yq1lfzgicn6.fsf@oracle.com>
        <20190509032044.GW1454@dread.disaster.area>
Date:   Thu, 09 May 2019 00:35:07 -0400
In-Reply-To: <20190509032044.GW1454@dread.disaster.area> (Dave Chinner's
        message of "Thu, 9 May 2019 13:20:44 +1000")
Message-ID: <yq1d0ksi6tg.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9251 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905090028
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9251 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905090029
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Dave,

>> The answer is that it depends. It can return zeroes or a
>> device-specific initialization pattern (oh joy).
>
> So they ignore the "write zeroes" part of the command?

I'd have to look to see how ANCHOR and NDOB interact on a WRITE
SAME. That's the closest thing SCSI has to WRITE ZEROES.

You can check whether a device has a non-standard initialization
pattern. It's a bit convoluted given that devices can autonomously
transition blocks between different states based on the initialization
pattern. But again, I don't think anybody has actually implemented this
part of the spec.

>> We have:
>> 
>>    Allocate and zero:	FALLOC_FL_ZERO_RANGE
>>    Deallocate and zero:	FALLOC_FL_PUNCH_HOLE
>>    Deallocate:		FALLOC_FL_PUNCH_HOLE | FALLOC_FL_NO_HIDE_STALE
>> but are missing:
>> 
>>    Allocate:		FALLOC_FL_ZERO_RANGE | FALLOC_FL_NO_HIDE_STALE

Copy and paste error. "Allocate:" would be FALLOC_FL_NO_HIDE_STALE in
the ANCHOR case. It's really just a preallocation but the blocks could
contain something other than zeroes depending on the device.

> So we've defined the fallocate flags to have /completely/ different
> behaviour on block devices to filesystems.

Are you referring to the "Allocate" case or something else? From
fallocate(2):

"Specifying the FALLOC_FL_ZERO_RANGE flag [...] zeroes space [...].
Within the specified range, blocks are preallocated for the regions that
span the holes in the file.  After a successful call, subsequent reads
from this range will return zeroes."

"Specifying the FALLOC_FL_PUNCH_HOLE flag [...] deallocates space [...].
Within the specified range, partial filesystem blocks are zeroed, and
whole filesystem blocks are removed from the file.  After a successful
call, subsequent reads from this range will return zeroes."

That matches the block device behavior as far as I'm concerned.

-- 
Martin K. Petersen	Oracle Linux Engineering
