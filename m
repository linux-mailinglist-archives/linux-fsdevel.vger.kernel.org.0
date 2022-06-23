Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AD1D558ACD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jun 2022 23:34:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbiFWVev (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Jun 2022 17:34:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiFWVev (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Jun 2022 17:34:51 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1649441F94;
        Thu, 23 Jun 2022 14:34:50 -0700 (PDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25NL8OZ4014752;
        Thu, 23 Jun 2022 21:34:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=CsNe/bl/RHAXTeGIsoHeVKvs8UliezD6gFU1jRlaX4Y=;
 b=C/K5N3dlLpKRQkZ1PC5OQK634n4b58EJysLhWq20w/8HusKJHoWkHnuBw+YorWkGJv+T
 PsVnxsQe0rY8Gewx19a9i43EodKgcVgpyxhGlSWIK24w3zsM5QtN9AKgcyGeiCJQlhQm
 xcDihKADvr3Ms2Q+VZfAop59tqHZ3UftVAifCfO/SUgpqJBjMXXx1AcPIuNVCQSXjCz3
 Czwtnv4vPeFEEhPhyBXRTaUqgBRC/y3sJpOZ0lmCvioH9RIhRI+ulpv25qzCsMhz7wWD
 nScCiL7+CHIPI0fdWfWwynAJV88eJ41pyrFcW3TBFWkKORRJ53Yo2km6qAy4aUrBRlpg gA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gvyu1gkym-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Jun 2022 21:34:34 +0000
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 25NLYX8g020697;
        Thu, 23 Jun 2022 21:34:33 GMT
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gvyu1gkyd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Jun 2022 21:34:33 +0000
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 25NLLOdm024750;
        Thu, 23 Jun 2022 21:34:33 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
        by ppma05wdc.us.ibm.com with ESMTP id 3gs6b9x01g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Jun 2022 21:34:33 +0000
Received: from b03ledav001.gho.boulder.ibm.com (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 25NLYWkR32702906
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Jun 2022 21:34:32 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 542686E056;
        Thu, 23 Jun 2022 21:34:32 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 90E416E052;
        Thu, 23 Jun 2022 21:34:30 +0000 (GMT)
Received: from farman-thinkpad-t470p (unknown [9.211.98.153])
        by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu, 23 Jun 2022 21:34:30 +0000 (GMT)
Message-ID: <e0038866ac54176beeac944c9116f7a9bdec7019.camel@linux.ibm.com>
Subject: Re: [PATCHv6 11/11] iomap: add support for dma aligned direct-io
From:   Eric Farman <farman@linux.ibm.com>
To:     Keith Busch <kbusch@kernel.org>
Cc:     Keith Busch <kbusch@fb.com>, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        axboe@kernel.dk, Kernel Team <Kernel-team@fb.com>, hch@lst.de,
        bvanassche@acm.org, damien.lemoal@opensource.wdc.com,
        ebiggers@kernel.org, pankydev8@gmail.com
Date:   Thu, 23 Jun 2022 17:34:29 -0400
In-Reply-To: <e2b08a5c452d4b8322566cba4ed33b58080f03fa.camel@linux.ibm.com>
References: <20220610195830.3574005-1-kbusch@fb.com>
         <20220610195830.3574005-12-kbusch@fb.com>
         <ab1bc062b4a1d0ad7f974b6068dc3a6dbf624820.camel@linux.ibm.com>
         <YrS2HLsYOe7vnbPG@kbusch-mbp> <YrS6/chZXbHsrAS8@kbusch-mbp>
         <e2b08a5c452d4b8322566cba4ed33b58080f03fa.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 64Z2udkc7G7mwc59ZFavQeW88W-BBo2a
X-Proofpoint-GUID: ttdqj5LPg_DgiHWD8NdUECmYDlW9TVmu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-06-23_10,2022-06-23_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=999
 suspectscore=0 impostorscore=0 bulkscore=0 phishscore=0 clxscore=1015
 priorityscore=1501 mlxscore=0 lowpriorityscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206230081
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 2022-06-23 at 16:32 -0400, Eric Farman wrote:
> On Thu, 2022-06-23 at 13:11 -0600, Keith Busch wrote:
> > On Thu, Jun 23, 2022 at 12:51:08PM -0600, Keith Busch wrote:
> > > On Thu, Jun 23, 2022 at 02:29:13PM -0400, Eric Farman wrote:
> > > > On Fri, 2022-06-10 at 12:58 -0700, Keith Busch wrote:
> > > > > From: Keith Busch <kbusch@kernel.org>
> > > > > 
> > > > > Use the address alignment requirements from the block_device
> > > > > for
> > > > > direct
> > > > > io instead of requiring addresses be aligned to the block
> > > > > size.
> > > > 
> > > > Hi Keith,
> > > > 
> > > > Our s390 PV guests recently started failing to boot from a
> > > > -next
> > > > host,
> > > > and git blame brought me here.
> > > > 
> > > > As near as I have been able to tell, we start tripping up on
> > > > this
> > > > code
> > > > from patch 9 [1] that gets invoked with this patch:
> > > > 
> > > > > 	for (k = 0; k < i->nr_segs; k++, skip = 0) {
> > > > > 		size_t len = i->iov[k].iov_len - skip;
> > > > > 
> > > > > 		if (len > size)
> > > > > 			len = size;
> > > > > 		if (len & len_mask)
> > > > > 			return false;
> > > > 
> > > > The iovec we're failing on has two segments, one with a len of
> > > > x200
> > > > (and base of x...000) and another with a len of xe00 (and a
> > > > base
> > > > of
> > > > x...200), while len_mask is of course xfff.
> > > > 
> > > > So before I go any further on what we might have broken, do you
> > > > happen
> > > > to have any suggestions what might be going on here, or
> > > > something
> > > > I
> > > > should try?
> > > 
> > > Thanks for the notice, sorry for the trouble. This check wasn't
> > > intended to
> > > have any difference from the previous code with respect to the
> > > vector lengths.
> > > 
> > > Could you tell me if you're accessing this through the block
> > > device
> > > direct-io,
> > > or through iomap filesystem?
> 
> Reasonably certain the failure's on iomap. I'd reverted the subject
> patch from next-20220622 and got things in working order.
> 
> > If using iomap, the previous check was this:
> > 
> > 	unsigned int blkbits =
> > blksize_bits(bdev_logical_block_size(iomap->bdev));
> > 	unsigned int align = iov_iter_alignment(dio->submit.iter);
> > 	...
> > 	if ((pos | length | align) & ((1 << blkbits) - 1))
> > 		return -EINVAL;
> > 
> > 
> ...
> > The result of "iov_iter_alignment()" would include "0xe00 | 0x200"
> > in
> > your
> > example, and checked against 0xfff should have been failing prior
> > to
> > this
> > patch. Unless I'm missing something...
> 
> Nope, you're not. I didn't look back at what the old check was doing,
> just saw "0xe00 and 0x200" and thought "oh there's one page" instead
> of
> noting the code was or'ing them. My bad.
> 
> That was the last entry in my trace before the guest gave up, as
> everything else through this code up to that point seemed okay. I'll
> pick up the working case and see if I can get a clearer picture
> between
> the two.

Looking over the trace again, I realize I did dump iov_iter_alignment()
as a comparator, and I see one pass through that had a non-zero
response but bdev_iter_is_aligned() returned true...

count = x1000
iov_offset = x0
nr_segs = 1
iov_len = x1000	(len_mask = xfff)
iov_base = x...200 (addr_mask = x1ff)

That particular pass through is in the middle of the stuff it tried to
do, so I don't know if that's the cause or not but it strikes me as
unusual. Will look into that tomorrow and report back.

> 

