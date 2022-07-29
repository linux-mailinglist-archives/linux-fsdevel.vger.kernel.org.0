Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB615585662
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Jul 2022 23:13:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239016AbiG2VN1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Jul 2022 17:13:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbiG2VN0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Jul 2022 17:13:26 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7657A32DA0
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 Jul 2022 14:13:25 -0700 (PDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26TKtkNe006161;
        Fri, 29 Jul 2022 21:12:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=wPDmeIi6/GeElgtJOhvhVytB0rzTQOYtTqa6kJtQTtU=;
 b=Etkt5O9jS9lUL71aMcAsTCzW8wfvTqkinneTIdp4QID5hG6emtUd3kJTw2371UBSb/Tg
 79CBSiJBojQ0/FnIudGmB/C0kwR4ZIBhCmwj3MRoBJpd/zXvwcm89eiiDnZ85VdWut9n
 l6e9eB1NE63l+M7F5CTCCFyaT5vWqd6+YPyuLIvOKxhHSqpwZ3Sa7ldYbVBT2tcVYqaH
 gasxr26WUWFPgiRA8DsodI2O89hbfQS+0IKHpgqHoIp3ejKfirVz/q7mw+IeB8f1ns0e
 TZKJiRcQw7td9azqiM9f0lMHvgtG6kScJPfZvGczFSVgiduMFxtlCsyVzPIeQZ5GkHPF mA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3hmq13rh0c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Jul 2022 21:12:53 +0000
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 26TKv45H009821;
        Fri, 29 Jul 2022 21:12:52 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3hmq13rgy8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Jul 2022 21:12:52 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 26TL7OM4023831;
        Fri, 29 Jul 2022 21:12:49 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma06ams.nl.ibm.com with ESMTP id 3hg97tg193-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Jul 2022 21:12:49 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 26TLD1bE32637370
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Jul 2022 21:13:01 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 21480A404D;
        Fri, 29 Jul 2022 21:12:47 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CA60AA4040;
        Fri, 29 Jul 2022 21:12:46 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Fri, 29 Jul 2022 21:12:46 +0000 (GMT)
Date:   Fri, 29 Jul 2022 23:12:45 +0200
From:   Alexander Gordeev <agordeev@linux.ibm.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        David Howells <dhowells@redhat.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH 9/44] new iov_iter flavour - ITER_UBUF
Message-ID: <YuRNTTCgc+dp2TD6@tuxmaker.boeblingen.de.ibm.com>
References: <YrKWRCOOWXPHRCKg@ZenIV>
 <20220622041552.737754-1-viro@zeniv.linux.org.uk>
 <20220622041552.737754-9-viro@zeniv.linux.org.uk>
 <YuJc/gfGDj4loOqt@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com>
 <YuQXE+MBAHVhdWW3@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YuQXE+MBAHVhdWW3@ZenIV>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: QmPrrVcmm44PBUqCFs0Sddt0oHAe383F
X-Proofpoint-GUID: 3XMfmYiXxJyk0zlLg6v1j1W0nWhT5X8y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-29_20,2022-07-28_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1015
 adultscore=0 mlxlogscore=999 spamscore=0 phishscore=0 suspectscore=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207290087
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 29, 2022 at 06:21:23PM +0100, Al Viro wrote:
> > Hi Al,
> > 
> > This changes causes sendfile09 LTP testcase fail in linux-next
> > (up to next-20220727) on s390. In fact, not this change exactly,
> > but rather 92d4d18eecb9 ("new iov_iter flavour - ITER_UBUF") -
> > which differs from what is posted here.
> > 
> > AFAICT page_cache_pipe_buf_confirm() encounters !PageUptodate()
> > and !page->mapping page and returns -ENODATA.
> > 
> > I am going to narrow the testcase and get more details, but please
> > let me know if I am missing something.
> 
> Grrr....
> 
> -               } else if (iter_is_iovec(to)) {
> +               } else if (!user_backed_iter(to)) {
> 
> in mm/shmem.c.  Spot the typo...
> 
> Could you check if replacing that line with
> 		} else if (user_backed_iter(to)) {
> 
> fixes the breakage?

Yes, it does! So just to be sure - this is the fix:

diff --git a/mm/shmem.c b/mm/shmem.c
index 8baf26eda989..5783f11351bb 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2626,7 +2626,7 @@ static ssize_t shmem_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 			ret = copy_page_to_iter(page, offset, nr, to);
 			put_page(page);
 
-		} else if (!user_backed_iter(to)) {
+		} else if (user_backed_iter(to)) {
 			/*
 			 * Copy to user tends to be so well optimized, but
 			 * clear_user() not so much, that it is noticeably

Thanks!
