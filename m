Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C94A4D3EB0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Mar 2022 02:22:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235058AbiCJBXV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Mar 2022 20:23:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232553AbiCJBXT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Mar 2022 20:23:19 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BE3412756E;
        Wed,  9 Mar 2022 17:22:20 -0800 (PST)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22A0a8rw022133;
        Thu, 10 Mar 2022 01:22:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=BMOQijfPxKxeD41463c4qMnhFFwbfqkfwHXCsb/Fq0c=;
 b=Lqrezjg734uyFYsf+eiY5loDGf3Wl8tHyvxmb64V1oFZNwhK1LjTsxgLOU+oI7FtidoB
 89/H5Ae/63B7zrjNBLQVS5MBASbepF7aNGClBa1IuLr3tTzV9fV6CLuAFwgpclDhJvN/
 AaVHZUecmuBPfjV0xOmgEW5Q4ro5/1qg2m+3b3/L4DXaF8g1NdAG/5d+GozKfieZz+p/
 crWrSZ8h7v8eenjjS/xS/ABo+vYX+lLV5+Pk5hKFz2GnBjHo/Aug2XIXExBlBMLlxzg9
 YJpyJTlXDRe/X+vbsQIHJuD8cSY1e01bOLYA+q7nQ7hQxag5S/qyIHceWSq5GaWy+DTX pQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3enu2tdp90-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Mar 2022 01:22:13 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 22A1IEFQ022641;
        Thu, 10 Mar 2022 01:22:12 GMT
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3enu2tdp87-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Mar 2022 01:22:12 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 22A1DgIN019159;
        Thu, 10 Mar 2022 01:22:09 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma05fra.de.ibm.com with ESMTP id 3epysw8kjs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Mar 2022 01:22:09 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 22A1M7bT54788386
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Mar 2022 01:22:07 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 28D3BAE055;
        Thu, 10 Mar 2022 01:22:07 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 89058AE053;
        Thu, 10 Mar 2022 01:22:06 +0000 (GMT)
Received: from localhost (unknown [9.43.30.40])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 10 Mar 2022 01:22:06 +0000 (GMT)
Date:   Thu, 10 Mar 2022 06:52:05 +0530
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC 0/9] ext4: Improve FC trace events and discuss one FC
 failure
Message-ID: <20220310012143.hdssmcricg3rohfw@riteshh-domain>
References: <cover.1645558375.git.riteshh@linux.ibm.com>
 <YijoeFbb54zHMHq6@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YijoeFbb54zHMHq6@mit.edu>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: LnCoX3j89LYzev5GI7-bf1AqZ10Pt6tB
X-Proofpoint-GUID: fNvst2t0P-Qe5zjBVhwHIC86rvMcJ3sx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-09_10,2022-03-09_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1015 mlxscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 impostorscore=0 phishscore=0 suspectscore=0 malwarescore=0 mlxlogscore=444
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203100002
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 22/03/09 12:48PM, Theodore Ts'o wrote:
> Ritesh,
>
> Were you going to be sending a revised version of this patch series?

Hello Ted,

Due to some unexpected guests at home, I was on leave since last weekend.
I am starting to work from today. Let me work on the revised version of this
patch series. I will try to complete it before end of day i.e. before
our call.


-ritesh
