Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7740FE168
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2019 13:37:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728043AbfD2Lgk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Apr 2019 07:36:40 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:53242 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727895AbfD2Lgj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Apr 2019 07:36:39 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3TBTGpW161561;
        Mon, 29 Apr 2019 11:36:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=VnsYAI9ZN9zVJAIgiBsb84bbY9EWS3zR+ILQZL/U3uA=;
 b=o7iRymlMtfbbOGsumicBT986h1iCmQts5STzmDGB2qRLj+90ubE3RPKHzE8xxb4TI0H5
 iUdv6vQ2VPc6TVI1x3/GXeCFCv6lKEq8RhiKLkS709XD0+9Ff7rG1YaDGZ99P/p3qjiP
 yawzvuSJEK6C+x74iRf8rh8Lvhc6C3zwrfcwKKBI8o0+q3pY0Dc/I5yb1F4Jgbc7Et+K
 MXtcZLwcVo9+FcL/1fSpK9mJ+wZYD6rpWb4yzYjWNR91k8yM8ncTqopJmm+iEdxLpXQt
 y4MSxhQqmeJNwM0HaXg2uzKSSxjthHCA1xWwcoZ9TH5aOtAKmf1ZxDZNbx9D63Pa1IJx tQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 2s4ckd604c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Apr 2019 11:36:23 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3TBYrbu115467;
        Mon, 29 Apr 2019 11:36:22 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 2s4ew0m9m9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Apr 2019 11:36:22 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x3TBaI0I011719;
        Mon, 29 Apr 2019 11:36:20 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 29 Apr 2019 04:36:17 -0700
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jens Axboe <axboe@kernel.dk>,
        lsf@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-mm@kvack.org,
        Jerome Glisse <jglisse@redhat.com>,
        linux-fsdevel@vger.kernel.org, lsf-pc@lists.linux-foundation.org
Subject: Re: [Lsf] [LSF/MM] Preliminary agenda ? Anyone ... anyone ? Bueller ?
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20190425200012.GA6391@redhat.com>
        <83fda245-849a-70cc-dde0-5c451938ee97@kernel.dk>
        <503ba1f9-ad78-561a-9614-1dcb139439a6@suse.cz>
        <yq1v9yx2inc.fsf@oracle.com>
        <1556537518.3119.6.camel@HansenPartnership.com>
Date:   Mon, 29 Apr 2019 07:36:15 -0400
In-Reply-To: <1556537518.3119.6.camel@HansenPartnership.com> (James
        Bottomley's message of "Mon, 29 Apr 2019 07:31:58 -0400")
Message-ID: <yq1zho911sg.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9241 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=681
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1904290084
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9241 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=704 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1904290084
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


James,

> Next year, simply expand the blurb to "sponsors, partners and
> attendees" to make it more clear ... or better yet separate them so
> people can opt out of partner spam and still be on the attendee list.

We already made a note that we need an "opt-in to be on the attendee
list" as part of the registration process next year. That's how other
conferences go about it...

-- 
Martin K. Petersen	Oracle Linux Engineering
