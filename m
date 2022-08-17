Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78375596896
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Aug 2022 07:28:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238182AbiHQFZN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Aug 2022 01:25:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232789AbiHQFZM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Aug 2022 01:25:12 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1377A5FAFF;
        Tue, 16 Aug 2022 22:25:09 -0700 (PDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27H4kqG7012871;
        Wed, 17 Aug 2022 05:24:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=xjYCcnPE+FviXf6beLMD7vOup6H7R4aerrF4Ld4Rfq0=;
 b=cJ41wWIQx1NgIlWobMRzRKla1fV1CvtPe0xQ4xyjaMYmNYAB7naeHvKM/XzTgy6MuyNB
 vzdVb3Gkp5rRZioDT8L94RMXBDZjo5BQNpavr2hOfBnBdWCV5uzGAWTqunEXisEdC3hu
 ADMr1JXu3BVc2RLFppc4tZbryV/xQcn7d6txO76RBSHf5E+iNzmxliL2Ui1YeKF/yiIH
 o5VAI9H0r67r/nmiFESFzHwA3D6OPeAD4X7TDAeZ3OUv404DYsuxvwSPz2efiCy903cM
 vgDTPMJzezgnPrVRUpIopj21w04es7KdNmWGcAhDNBzTamXiMppuXyZ3r08ktox94huM oA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3j0skw0t6n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 Aug 2022 05:24:59 +0000
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 27H58axd026488;
        Wed, 17 Aug 2022 05:24:58 GMT
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3j0skw0t5w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 Aug 2022 05:24:58 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 27H55L2Y009924;
        Wed, 17 Aug 2022 05:24:56 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma05fra.de.ibm.com with ESMTP id 3hyp8shg1m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 Aug 2022 05:24:56 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 27H5Ospo27132208
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 Aug 2022 05:24:54 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0F30B11C04C;
        Wed, 17 Aug 2022 05:24:54 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C368D11C052;
        Wed, 17 Aug 2022 05:24:50 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.43.75.30])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 17 Aug 2022 05:24:50 +0000 (GMT)
Date:   Wed, 17 Aug 2022 10:54:47 +0530
From:   Ojaswin Mujoo <ojaswin@linux.ibm.com>
To:     Stefan Wahren <stefan.wahren@i2se.com>
Cc:     Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        linux-fsdevel@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Geetika.Moolchandani1@ibm.com, regressions@lists.linux.dev,
        Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [Regression] ext4: changes to mb_optimize_scan cause issues on
 Raspberry Pi
Message-ID: <Yvx7i7QthoTgykeE@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
References: <0d81a7c2-46b7-6010-62a4-3e6cfc1628d6@i2se.com>
 <20220728100055.efbvaudwp3ofolpi@quack3>
 <64b7899f-d84d-93de-f9c5-49538bd080d0@i2se.com>
 <20220816093421.ok26tcyvf6bm3ngy@quack3>
 <b8a5e43a-4d1e-aede-e0f7-f731fd8acf1d@i2se.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b8a5e43a-4d1e-aede-e0f7-f731fd8acf1d@i2se.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: n6F6GPtpYlL38AaBfAxyPlhOQJY2r__6
X-Proofpoint-GUID: sK8sZS9P8BD1hOVTPEnkoE-5YCoAxPmv
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-17_02,2022-08-16_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 lowpriorityscore=0 clxscore=1011 phishscore=0
 mlxlogscore=999 spamscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 mlxscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208170021
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 16, 2022 at 10:45:48PM +0200, Stefan Wahren wrote:
> Hi Jan,
> 
> Am 16.08.22 um 11:34 schrieb Jan Kara:
> > Hi Stefan!
> > So this is interesting. We can see the card is 100% busy. The IO submitted
> > to the card is formed by small requests - 18-38 KB per request - and each
> > request takes 0.3-0.5s to complete. So the resulting throughput is horrible
> > - only tens of KB/s. Also we can see there are many IOs queued for the
> > device in parallel (aqu-sz columnt). This does not look like load I would
> > expect to be generated by download of a large file from the web.
> > 
> > You have mentioned in previous emails that with dd(1) you can do couple
> > MB/s writing to this card which is far more than these tens of KB/s. So the
> > file download must be doing something which really destroys the IO pattern
> > (and with mb_optimize_scan=0 ext4 happened to be better dealing with it and
> > generating better IO pattern). Can you perhaps strace the process doing the
> > download (or perhaps strace -f the whole rpi-update process) so that we can
> > see how does the load generated on the filesystem look like? Thanks!
> 
> i didn't create the strace yet, but i looked at the source of rpi-update. At
> the end the download phase is a curl call to download a tar archive and pipe
> it directly to tar.
> 
> You can find the content list of the tar file here:
> 
> https://raw.githubusercontent.com/lategoodbye/mb_optimize_scan_regress/main/rpi-firmware-tar-content-list.txt
> 
> Best regards
> 
> > 
> > 								Honza
Hi Jan and Stefan,

I did some analysis of this on my Raspberry Pi 3B+. Not sure of the root
cause yet but here is what I observed:

1. So I noticed that the download itself is not causing any issues in my
case, but the download with a pipe to tar is what causes the degradation.
With the pipe to tar, mb_optimize_scan=1 takes around 7mins whereas
mb_optimize_scan=0 takes 1 min

2. I tried to replicate this performance degradation by running untar
on an x86 machine but I not able to get the degradation. It is
reproducible pretty consistently on my Raspberry Pi though (w/ an 8GB
memory card).

3. I did analyse the resulting mb_optimize_scan=0 vs mb_optmize_scan=1
filesystem and seems like the allocated blocks are more spread out in
mb_optmize_scan=1 case but not yet sure if that is the issue.

Will update here if I notice anything else.

Regards,
Ojaswin
