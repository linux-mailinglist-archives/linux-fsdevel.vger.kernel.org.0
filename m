Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9AC2117F0A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2019 19:25:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728819AbfEHRZn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 May 2019 13:25:43 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:49432 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728699AbfEHRZm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 May 2019 13:25:42 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x48HInZk184579;
        Wed, 8 May 2019 17:25:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=dFTxaQ24NAATSsmBHSrROslLa2vl3IgKmJlOXAq2ldk=;
 b=paMercWLEwqdqZA3ppB27Wwqv4kca1pR22E+vaBswwr+0n8dZFyVMJFd1XLIbaKsU0CY
 M4b0kwoDWvScsRzimR2cQKAVdUGHn4f+QVSn87nrLrpxzi6KOfCzWBcCB/AbqaCyuXj7
 8DDaCeZZqZjn4NuX0vF11T1ut19GzSUnpaUSizrnBX8OZs7graAFS15PpBhlWPEoha6r
 XfIdpzrdvLhdg1bCn8oaK/68RCjM8gGKfJDLrg7Vg8dqlEAe2q5gjRML7g6Z9ZedQxf/
 WubDzcgGcfw7YNFi97yYWeTuRdlSxLNSk8EtrzM+9y8t7giWKBVdOX5qEKULPgM+UCWP PQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2s94b0wm51-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 May 2019 17:25:30 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x48HP2Gn148349;
        Wed, 8 May 2019 17:25:28 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 2s94ba8k7h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 May 2019 17:25:28 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x48HPQko004421;
        Wed, 8 May 2019 17:25:26 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 08 May 2019 10:25:25 -0700
To:     Ric Wheeler <ricwheeler@gmail.com>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Dave Chinner <david@fromorbit.com>,
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
Date:   Wed, 08 May 2019 13:25:22 -0400
In-Reply-To: <0a16285c-545a-e94a-c733-bcc3d4556557@gmail.com> (Ric Wheeler's
        message of "Wed, 8 May 2019 13:09:03 -0400")
Message-ID: <yq15zqkluyl.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9251 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905080106
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9251 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905080106
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Ric,

> Agree, but I think that there is also a base level performance
> question - how does the discard/zero perform by itself.  Specifically,
> we have had to punt the discard of a whole block device before mkfs
> (back at RH) since it tripped up a significant number of
> devices. Similar pain for small discards (say one fs page) - is it too
> slow to do?

Sure. Just wanted to emphasize the difference between the performance
cost of executing the command and the potential future performance
impact.

>> WRITE SAME also has an ANCHOR flag which provides a use case we
>> currently don't have fallocate plumbing for: Allocating blocks without
>> caring about their contents. I.e. the blocks described by the I/O are
>> locked down to prevent ENOSPC for future writes.
>
> Thanks for that detail! Sounds like ANCHOR in this case exposes
> whatever data is there (similar I suppose to normal block device
> behavior without discard for unused space)? Seems like it would be
> useful for virtually provisioned devices (enterprise arrays or
> something like dm-thin targets) more than normal SSD's?

It is typically used to pin down important areas to ensure one doesn't
get ENOSPC when writing journal or metadata. However, these are
typically the areas that we deliberately zero to ensure predictable
results. So I think the only case where anchoring makes much sense is on
devices that do zero detection and thus wouldn't actually provision N
blocks full of zeroes.

-- 
Martin K. Petersen	Oracle Linux Engineering
