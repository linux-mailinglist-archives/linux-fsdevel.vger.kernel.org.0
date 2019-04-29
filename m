Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 69A5CE0D1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2019 12:47:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727775AbfD2KrJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Apr 2019 06:47:09 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:35630 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727746AbfD2KrI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Apr 2019 06:47:08 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3TAdHHc136722;
        Mon, 29 Apr 2019 10:46:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=W1oy+Qiknzzs4w6utFbw9cgJsjZug4WD/Z2or50vcRs=;
 b=d4vzn3xsa1Y3tfRyDs0fEWmHZf2cRfM7hoxv6zgUe5YTwkI5qHBk9/nufJvLCekPG0Ak
 DxelAGEh+0bgJ3a6je2+Xd4ITkwpEGMVfkKoejCmOrjiioPQxqUI8zBN9ooufsLUIvzo
 GjcnK/nPTGyz8sshQQ4+QjwefSw5LKOqhnlPvROXMHdQBV5BbgXoXLcsDL6b+a9vs1Ko
 6iBkVoBmbUg5rPN3nhHppNrkOkSKZSgsMuFIhR+DOzUn3IdV23dV+bPQ/xsqOUt25qK0
 tZXqw2FSfk3ANkjL6m/L+hH8MCmE6WMoZJCxaM7M3JGFwte5gGBw3TO+Q/g2/G8g91az HQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2s4fqpwgy9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Apr 2019 10:46:57 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3TAkqng024841;
        Mon, 29 Apr 2019 10:46:56 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 2s4ew0ksbb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Apr 2019 10:46:56 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x3TAkpPm018609;
        Mon, 29 Apr 2019 10:46:54 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 29 Apr 2019 03:46:50 -0700
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Jens Axboe <axboe@kernel.dk>, Jerome Glisse <jglisse@redhat.com>,
        lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, lsf@lists.linux-foundation.org
Subject: Re: [LSF/MM] Preliminary agenda ? Anyone ... anyone ? Bueller ?
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20190425200012.GA6391@redhat.com>
        <83fda245-849a-70cc-dde0-5c451938ee97@kernel.dk>
        <503ba1f9-ad78-561a-9614-1dcb139439a6@suse.cz>
Date:   Mon, 29 Apr 2019 06:46:47 -0400
In-Reply-To: <503ba1f9-ad78-561a-9614-1dcb139439a6@suse.cz> (Vlastimil Babka's
        message of "Sat, 27 Apr 2019 17:55:20 +0200")
Message-ID: <yq1v9yx2inc.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9241 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=675
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1904290078
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9241 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=717 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1904290078
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Vlastimil,

> In previous years years there also used to be an attendee list, which
> is now an empty tab. Is that intentional due to GDPR?

Yes.

-- 
Martin K. Petersen	Oracle Linux Engineering
