Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B937B558A24
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jun 2022 22:33:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230105AbiFWUdY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Jun 2022 16:33:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbiFWUdU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Jun 2022 16:33:20 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD3B95DF1D;
        Thu, 23 Jun 2022 13:33:19 -0700 (PDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25NJNDl3003632;
        Thu, 23 Jun 2022 20:33:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=ePCHcz7Zlhus6n5JnsudXKrWV4qMNuE+Z2WsbdimkGw=;
 b=B29jF8RpDLW7tJekybLZcKwHHLAL+Yj+ywnjOdJloPM4awzd5xXnWrnL2GQSgC0VOVHp
 uDD/I7lchkefu2DA7HL/jxLNFp6dCWiLwpMQ6KrHQLRHZeyOhnHrxrGtr3e3YP15pa0a
 2q+0NTc76dnDRKgwuhY/xeeHT9xIeQNZFLo2oNtZrFUXUzA/6xRL8IBCpVHRyCKtRMCg
 P2N8NMrxcgz2qD9tI1qlpXi+p3UYVE92lyQREGiDa8niLl7YSOEItG4eNyvcKMxQOqL6
 hulA/UmibSaqK9BZh9GPNeyo3rbLevgfPJTp5vz2qpwCFwMwhr8xSftejf6fNtg4bmee Lg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gvx9jswg8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Jun 2022 20:33:01 +0000
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 25NKX1DF022763;
        Thu, 23 Jun 2022 20:33:01 GMT
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gvx9jswf8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Jun 2022 20:33:01 +0000
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 25NKMEZJ029239;
        Thu, 23 Jun 2022 20:33:00 GMT
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com [9.57.198.27])
        by ppma04dal.us.ibm.com with ESMTP id 3gs6bak253-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Jun 2022 20:33:00 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 25NKWxKL29491516
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Jun 2022 20:32:59 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 19F0CB2068;
        Thu, 23 Jun 2022 20:32:59 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B1DE5B205F;
        Thu, 23 Jun 2022 20:32:56 +0000 (GMT)
Received: from farman-thinkpad-t470p (unknown [9.211.98.153])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 23 Jun 2022 20:32:56 +0000 (GMT)
Message-ID: <e2b08a5c452d4b8322566cba4ed33b58080f03fa.camel@linux.ibm.com>
Subject: Re: [PATCHv6 11/11] iomap: add support for dma aligned direct-io
From:   Eric Farman <farman@linux.ibm.com>
To:     Keith Busch <kbusch@kernel.org>
Cc:     Keith Busch <kbusch@fb.com>, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        axboe@kernel.dk, Kernel Team <Kernel-team@fb.com>, hch@lst.de,
        bvanassche@acm.org, damien.lemoal@opensource.wdc.com,
        ebiggers@kernel.org, pankydev8@gmail.com
Date:   Thu, 23 Jun 2022 16:32:55 -0400
In-Reply-To: <YrS6/chZXbHsrAS8@kbusch-mbp>
References: <20220610195830.3574005-1-kbusch@fb.com>
         <20220610195830.3574005-12-kbusch@fb.com>
         <ab1bc062b4a1d0ad7f974b6068dc3a6dbf624820.camel@linux.ibm.com>
         <YrS2HLsYOe7vnbPG@kbusch-mbp> <YrS6/chZXbHsrAS8@kbusch-mbp>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: xmf0q5DWOiAN-M8Hkk9WWpIuEt0yGmIY
X-Proofpoint-GUID: lpUIWlDm1bJcTl7hf888zcqHlgJikXtJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-06-23_10,2022-06-23_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 phishscore=0 mlxlogscore=999 clxscore=1015 mlxscore=0
 spamscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206230078
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 2022-06-23 at 13:11 -0600, Keith Busch wrote:
> On Thu, Jun 23, 2022 at 12:51:08PM -0600, Keith Busch wrote:
> > On Thu, Jun 23, 2022 at 02:29:13PM -0400, Eric Farman wrote:
> > > On Fri, 2022-06-10 at 12:58 -0700, Keith Busch wrote:
> > > > From: Keith Busch <kbusch@kernel.org>
> > > > 
> > > > Use the address alignment requirements from the block_device
> > > > for
> > > > direct
> > > > io instead of requiring addresses be aligned to the block size.
> > > 
> > > Hi Keith,
> > > 
> > > Our s390 PV guests recently started failing to boot from a -next
> > > host,
> > > and git blame brought me here.
> > > 
> > > As near as I have been able to tell, we start tripping up on this
> > > code
> > > from patch 9 [1] that gets invoked with this patch:
> > > 
> > > > 	for (k = 0; k < i->nr_segs; k++, skip = 0) {
> > > > 		size_t len = i->iov[k].iov_len - skip;
> > > > 
> > > > 		if (len > size)
> > > > 			len = size;
> > > > 		if (len & len_mask)
> > > > 			return false;
> > > 
> > > The iovec we're failing on has two segments, one with a len of
> > > x200
> > > (and base of x...000) and another with a len of xe00 (and a base
> > > of
> > > x...200), while len_mask is of course xfff.
> > > 
> > > So before I go any further on what we might have broken, do you
> > > happen
> > > to have any suggestions what might be going on here, or something
> > > I
> > > should try?
> > 
> > Thanks for the notice, sorry for the trouble. This check wasn't
> > intended to
> > have any difference from the previous code with respect to the
> > vector lengths.
> > 
> > Could you tell me if you're accessing this through the block device
> > direct-io,
> > or through iomap filesystem?

Reasonably certain the failure's on iomap. I'd reverted the subject
patch from next-20220622 and got things in working order.

> 
> If using iomap, the previous check was this:
> 
> 	unsigned int blkbits =
> blksize_bits(bdev_logical_block_size(iomap->bdev));
> 	unsigned int align = iov_iter_alignment(dio->submit.iter);
> 	...
> 	if ((pos | length | align) & ((1 << blkbits) - 1))
> 		return -EINVAL;
> 
> 
...
> The result of "iov_iter_alignment()" would include "0xe00 | 0x200" in
> your
> example, and checked against 0xfff should have been failing prior to
> this
> patch. Unless I'm missing something...

Nope, you're not. I didn't look back at what the old check was doing,
just saw "0xe00 and 0x200" and thought "oh there's one page" instead of
noting the code was or'ing them. My bad.

That was the last entry in my trace before the guest gave up, as
everything else through this code up to that point seemed okay. I'll
pick up the working case and see if I can get a clearer picture between
the two.


