Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B212FE2B1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2019 14:32:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728150AbfD2McM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Apr 2019 08:32:12 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:56062 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728058AbfD2McL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Apr 2019 08:32:11 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3TCJCh9004325;
        Mon, 29 Apr 2019 12:31:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=YpLMQQrkPzj0xaZUB7vT4ZsT4KZR9loVYJdQY42icWA=;
 b=EsykfS/VRtTiG1PT3w2/JyYHxbzIQTpln/YmGWDk5ntThTU/geQoO1SD48MdHk8A9HdN
 5ZqsJGUnFMkz433YFcPCCfQX6H4uort4e6vlGrXXjfXEJAbfujEIjOHsoOHgaOGZIO1+
 oNpocLsQU22CiZ6YZ22v0+Ap5RBRe2Dm76oIKo5G5XfZXkTHKZemHTlCkhnWrxKF8DMF
 /g9d7kJ6btUGWhaZLVj9pPmohy8kv4KqhNCHhyHv+ivZFa8k6jkTNZsxZs8f58Ms+S3I
 HwNc9+O6bQqciEPTHjRhGwuReiGIP99fN3yeUzrhIZbsEcY3VgEBnuZFT5qzPnhD2Scd 6g== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2130.oracle.com with ESMTP id 2s4ckd67xx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Apr 2019 12:31:58 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3TCVXMN182219;
        Mon, 29 Apr 2019 12:31:57 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 2s4yy8xm6m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Apr 2019 12:31:57 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x3TCVtt1008055;
        Mon, 29 Apr 2019 12:31:55 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 29 Apr 2019 05:31:55 -0700
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, lsf@lists.linux-foundation.org,
        linux-mm@kvack.org, Jerome Glisse <jglisse@redhat.com>,
        linux-fsdevel@vger.kernel.org, lsf-pc@lists.linux-foundation.org,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [Lsf] [LSF/MM] Preliminary agenda ? Anyone ... anyone ? Bueller ?
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20190425200012.GA6391@redhat.com>
        <83fda245-849a-70cc-dde0-5c451938ee97@kernel.dk>
        <503ba1f9-ad78-561a-9614-1dcb139439a6@suse.cz>
        <yq1v9yx2inc.fsf@oracle.com>
        <1556537518.3119.6.camel@HansenPartnership.com>
        <yq1zho911sg.fsf@oracle.com>
        <1556540228.3119.10.camel@HansenPartnership.com>
Date:   Mon, 29 Apr 2019 08:31:52 -0400
In-Reply-To: <1556540228.3119.10.camel@HansenPartnership.com> (James
        Bottomley's message of "Mon, 29 Apr 2019 08:17:08 -0400")
Message-ID: <yq11s1l0z7r.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9241 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1904290089
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9241 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1904290089
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


James,

> But for this year, I'd just assume the "event partners" checkbox
> covers publication of attendee data to attendees, because if you
> assume the opposite, since you've asked no additional permission of
> your speakers either, that would make publishing the agenda a GDPR
> violation.

Speakers have proposed a topic by posting a message to a public mailing
list. Whereas not all attendees have indicated their desire to attend in
a public forum.

I don't think there's a problem publishing the list of people that sent
an ATTEND. My concern is the ones that didn't. And if the attendee list
is not comprehensive, I am not sure how helpful it is.

From a more practical perspective, I also don't have access to whether
people clicked the "event partners" box or not during registration.
Although I can reach out to LF and see whether I can get access to that
information.

-- 
Martin K. Petersen	Oracle Linux Engineering
