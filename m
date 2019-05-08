Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 504D217EC2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2019 19:03:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729104AbfEHRDe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 May 2019 13:03:34 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:59794 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729091AbfEHRDe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 May 2019 13:03:34 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x48Gxcdn159546;
        Wed, 8 May 2019 17:03:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=3dR3HIapXIda6o/q4jvxD+ZqWb3OHNWGzphNYlBXXVQ=;
 b=C6DLbwjmI5YKLWNPfeFbcJK8WXPGESVkGJbtBb+JKu4/FWlDQhHJ5BPVnnW1Epgh+ysP
 GsTV/ifFuq/LTcYeQIzJ0+W8rvZ7Zn4kyjVtWEnTExxW38hVtMRiz9fA12FpGKEQz6+d
 W0ZYmfHaKTeSVUJBtOF9IhY4/cVblc0+d0t5HywRBycZUsOkD45oluWr4RtbpqKKU+Ky
 gp7KWCQuK3dBx2GKbriMRcxZ4grxlSWqvZISzcqtpxoS4OwPsPOds0heGbsJB0joq5Gt
 qzE2pAU2YIxrTR0yzs4esKHBkHbDTmrATX/7l7c3V1sdemi7DNeabjQkh3YlrOTjNH4w Cw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 2s94b65grm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 May 2019 17:03:25 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x48H3M3X051585;
        Wed, 8 May 2019 17:03:25 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 2s94ag849p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 May 2019 17:03:24 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x48H3N3t008082;
        Wed, 8 May 2019 17:03:23 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 08 May 2019 10:03:23 -0700
To:     Ric Wheeler <ricwheeler@gmail.com>
Cc:     Dave Chinner <david@fromorbit.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org,
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
Date:   Wed, 08 May 2019 13:03:20 -0400
In-Reply-To: <13b63de0-18bc-eb24-63b4-3c69c6a007b3@gmail.com> (Ric Wheeler's
        message of "Wed, 8 May 2019 11:05:35 -0400")
Message-ID: <yq1a7fwlvzb.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9251 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=590
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905080104
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9251 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=661 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905080104
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Ric,

> That all makes sense, but I think it is orthogonal in large part to
> the need to get a good way to measure performance.

There are two parts to the performance puzzle:

 1. How does mixing discards/zeroouts with regular reads and writes
    affect system performance?

 2. How does issuing discards affect the tail latency of the device for
    a given workload? Is it worth it?

Providing tooling for (1) is feasible whereas (2) is highly
workload-specific. So unless we can make the cost of (1) negligible,
we'll have to defer (2) to the user.

> For SCSI, I think the "WRITE_SAME" command *might* do discard
> internally or just might end up re-writing large regions of slow,
> spinning drives so I think it is less interesting.

WRITE SAME has an UNMAP flag that tells the device to deallocate, if
possible. The results are deterministic (unlike the UNMAP command).

WRITE SAME also has an ANCHOR flag which provides a use case we
currently don't have fallocate plumbing for: Allocating blocks without
caring about their contents. I.e. the blocks described by the I/O are
locked down to prevent ENOSPC for future writes.

-- 
Martin K. Petersen	Oracle Linux Engineering
