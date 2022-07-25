Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 046BD580125
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Jul 2022 17:08:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235753AbiGYPH7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Jul 2022 11:07:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230207AbiGYPHy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Jul 2022 11:07:54 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CB8112D2B;
        Mon, 25 Jul 2022 08:07:53 -0700 (PDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26PEuCMu016146;
        Mon, 25 Jul 2022 15:07:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=pp1;
 bh=j7N5+TGRAxBqIlGqsayaYIXgxpZw2C6QH2sfrmlRjyc=;
 b=NlEpaTMbSxFi5ugEv3CTbR2EOoxVVm+UbQaM/VN5AJr2k55ZtFBxm2jTUNAtNCOwoS7W
 prfnPv8NH5Giy3IcKg8quJy91hviE42wG2GyVq2uessP1A7rUz/GPFL5JD9Gaq0WzSEn
 rjrhJLpdvOKXwCx/XXvOq13uJUfBz32jEFkpXC3UdAiKPMN/gLxBrBsWCpbfzJmXZY9x
 AWTKynia6KSK96G6SDvgKP4sCbA6hlp163lxyEd7UDB+/NOeUk/9EigY0E/3DeldLdwI
 IlZNOz9SICtdoijc/XmXd4H2ZPL9UQL6jy/q1mrzbsecnvg3Ek8ja2q1PzhcdwCGblc/ dQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3hhwcggbtb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Jul 2022 15:07:40 +0000
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 26PEwIlp022752;
        Mon, 25 Jul 2022 15:07:40 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3hhwcggbse-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Jul 2022 15:07:40 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 26PF7MCf023285;
        Mon, 25 Jul 2022 15:07:38 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma06ams.nl.ibm.com with ESMTP id 3hg97tamp3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Jul 2022 15:07:38 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 26PF5dO624183158
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Jul 2022 15:05:39 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6717DA4051;
        Mon, 25 Jul 2022 15:07:36 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1D7D4A4040;
        Mon, 25 Jul 2022 15:07:34 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.43.106.214])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon, 25 Jul 2022 15:07:33 +0000 (GMT)
Date:   Mon, 25 Jul 2022 20:37:31 +0530
From:   Ojaswin Mujoo <ojaswin@linux.ibm.com>
To:     Stefan Wahren <stefan.wahren@i2se.com>
Cc:     linux-ext4@vger.kernel.org,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        linux-fsdevel@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Geetika.Moolchandani1@ibm.com, regressions@lists.linux.dev
Subject: Re: [Regression] ext4: changes to mb_optimize_scan cause issues on
 Raspberry Pi
Message-ID: <Yt6xsyy3+qEMn08y@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
References: <0d81a7c2-46b7-6010-62a4-3e6cfc1628d6@i2se.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0d81a7c2-46b7-6010-62a4-3e6cfc1628d6@i2se.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: fMjzhnueeb4PV1uHl4nXgNsMQjRB0qfV
X-Proofpoint-ORIG-GUID: X-AUXOegB27dalfgzIQ5mR5ClmK4CUJF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-25_10,2022-07-25_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 mlxlogscore=999
 priorityscore=1501 suspectscore=0 bulkscore=0 impostorscore=0 adultscore=0
 phishscore=0 spamscore=0 lowpriorityscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207250061
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 18, 2022 at 03:29:47PM +0200, Stefan Wahren wrote:
> Hi,
> 
> i noticed that since Linux 5.18 (Linux 5.19-rc6 is still affected) i'm
> unable to run "rpi-update" without massive performance regression on my
> Raspberry Pi 4 (multi_v7_defconfig + CONFIG_ARM_LPAE). Using Linux 5.17 this
> tool successfully downloads the latest firmware (> 100 MB) on my development
> micro SD card (Kingston 16 GB Industrial) with a ext4 filesystem within ~ 1
> min. The same scenario on Linux 5.18 shows the following symptoms:
> 
> - download takes endlessly much time and leads to an abort by userspace in
> most cases because of the poor performance
> - massive system load during download even after download has been aborted
> (heartbeat LED goes wild)
> - whole system becomes nearly unresponsive
> - system load goes back to normal after > 10 min
> - dmesg doesn't show anything suspicious
> 
> I was able to bisect this issue:
> 
> ff042f4a9b050895a42cae893cc01fa2ca81b95c good
> 4b0986a3613c92f4ec1bdc7f60ec66fea135991f bad
> 25fd2d41b505d0640bdfe67aa77c549de2d3c18a bad
> b4bc93bd76d4da32600795cd323c971f00a2e788 bad
> 3fe2f7446f1e029b220f7f650df6d138f91651f2 bad
> b080cee72ef355669cbc52ff55dc513d37433600 good
> ad9c6ee642a61adae93dfa35582b5af16dc5173a good
> 9b03992f0c88baef524842e411fbdc147780dd5d bad
> aab4ed5816acc0af8cce2680880419cd64982b1d good
> 14705fda8f6273501930dfe1d679ad4bec209f52 good
> 5c93e8ecd5bd3bfdee013b6da0850357eb6ca4d8 good
> 8cb5a30372ef5cf2b1d258fce1711d80f834740a bad
> 077d0c2c78df6f7260cdd015a991327efa44d8ad bad
> cc5095747edfb054ca2068d01af20be3fcc3634f good
> 27b38686a3bb601db48901dbc4e2fc5d77ffa2c1 good
> 
> commit 077d0c2c78df6f7260cdd015a991327efa44d8ad
> Author: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> Date:   Tue Mar 8 15:22:01 2022 +0530
> 
> ext4: make mb_optimize_scan performance mount option work with extents
> 
> If i revert this commit with Linux 5.19-rc6 the performance regression
> disappears.
> 
> Please ask if you need more information.

Hi Stefan, 

Apologies, I had missed this email initially. So this particular patch
simply changed a typo in an if condition which was preventing the
mb_optimize_scan option to be enabled correctly (This feature was
introduced in the following commit [1]). I think with the
mb_optimize_scan now working, it is somehow causing the firmware
download/update to take a longer time. 

I'll try to investigate this and get back with my findings.

Regard,
Ojaswin

[1] 
	commit 196e402adf2e4cd66f101923409f1970ec5f1af3
	From: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
	Date: Thu, 1 Apr 2021 10:21:27 -0700
	
	ext4: improve cr 0 / cr 1 group scanning

> 
> Regards
> 
