Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B014E583B8F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Jul 2022 11:56:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235331AbiG1Jz6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Jul 2022 05:55:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235034AbiG1Jz5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Jul 2022 05:55:57 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D68E057248
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 Jul 2022 02:55:56 -0700 (PDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26S9maj7017913;
        Thu, 28 Jul 2022 09:55:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=O8VupqDTsAYKvUVU/b+7rGVyEc6mF3YFu4ZRD6YkTOk=;
 b=Dcp8e8kAt2wNlxAb33AoqrwoqaiIZ9aFYHe2i6ayACLbJb2nv1ooSXm0G786iyLm6Rdr
 P9jO8g1MXwD3ok8rdCAVmZCUONWha9Yp3Njw1bRp149Wvm7OTlIIdPGBGNrYk/imZNyx
 4czIz93RpY35y52HS/tCHbbYjYaQ6R0iK9t7LvRSS+DDOMMwItk+NmwvnFPgtFO7iwaE
 iwEF+ICm6xGkKZU5XEpZwSiFY3+1+EdDIuEFDODbzV6/XbiSLOYxOPm+vQrLHI+sb1n2
 IIJJSXfk4hsHnw55UpajlHMAGAeqQdGOuI0SFkq9tMXEErWsF78QkCjRvQI5G3xmpDIb Cw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3hkr58r584-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Jul 2022 09:55:18 +0000
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 26S9n80R022320;
        Thu, 28 Jul 2022 09:55:17 GMT
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3hkr58r56t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Jul 2022 09:55:17 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 26S9pgUP003068;
        Thu, 28 Jul 2022 09:55:15 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma04fra.de.ibm.com with ESMTP id 3hg945mnd6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Jul 2022 09:55:14 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 26S9r9wf33358150
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Jul 2022 09:53:09 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8CBDF42041;
        Thu, 28 Jul 2022 09:55:12 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2718F42045;
        Thu, 28 Jul 2022 09:55:12 +0000 (GMT)
Received: from li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com (unknown [9.145.185.171])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu, 28 Jul 2022 09:55:12 +0000 (GMT)
Date:   Thu, 28 Jul 2022 11:55:10 +0200
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
Message-ID: <YuJc/gfGDj4loOqt@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com>
References: <YrKWRCOOWXPHRCKg@ZenIV>
 <20220622041552.737754-1-viro@zeniv.linux.org.uk>
 <20220622041552.737754-9-viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220622041552.737754-9-viro@zeniv.linux.org.uk>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: yOJJOKTnJ6xNA6-usU-pbbwExkGGokpf
X-Proofpoint-GUID: oSR4FKnsytCEdhdB7UlVYskQFZ9RhsqK
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-28_03,2022-07-28_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 lowpriorityscore=0 clxscore=1011 mlxscore=0 bulkscore=0
 mlxlogscore=999 impostorscore=0 malwarescore=0 spamscore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207280041
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        URIBL_ABUSE_SURBL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 22, 2022 at 05:15:17AM +0100, Al Viro wrote:
> Equivalent of single-segment iovec.  Initialized by iov_iter_ubuf(),
> checked for by iter_is_ubuf(), otherwise behaves like ITER_IOVEC
> ones.
> 
> We are going to expose the things like ->write_iter() et.al. to those
> in subsequent commits.
> 
> New predicate (user_backed_iter()) that is true for ITER_IOVEC and
> ITER_UBUF; places like direct-IO handling should use that for
> checking that pages we modify after getting them from iov_iter_get_pages()
> would need to be dirtied.
> 
> DO NOT assume that replacing iter_is_iovec() with user_backed_iter()
> will solve all problems - there's code that uses iter_is_iovec() to
> decide how to poke around in iov_iter guts and for that the predicate
> replacement obviously won't suffice.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> Link: https://lore.kernel.org/r/20220622041552.737754-9-viro@zeniv.linux.org.uk

Hi Al,

This changes causes sendfile09 LTP testcase fail in linux-next
(up to next-20220727) on s390. In fact, not this change exactly,
but rather 92d4d18eecb9 ("new iov_iter flavour - ITER_UBUF") -
which differs from what is posted here.

AFAICT page_cache_pipe_buf_confirm() encounters !PageUptodate()
and !page->mapping page and returns -ENODATA.

I am going to narrow the testcase and get more details, but please
let me know if I am missing something.

Thanks!
