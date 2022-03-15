Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E11D4D9D63
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Mar 2022 15:22:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243091AbiCOOXZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Mar 2022 10:23:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349220AbiCOOXH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Mar 2022 10:23:07 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6AB154BEB;
        Tue, 15 Mar 2022 07:21:55 -0700 (PDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22FDLNY5027491;
        Tue, 15 Mar 2022 14:21:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=UO7/JBIo4u9pbWv7oF+ML0pIWM8AZ+nHbnMD9rkZDtc=;
 b=WBvLRhGyqyMeUvd5lP9sCpHhmeMHrf1U1z+CuurRWQGQsj464MMZcJJePjc2GMzj3I1j
 +dExVVW+YqNfe3neEDjlNoYQezED5dliEsX5yGhBr1zL5sDX6bBkDy0ipHECVg+zVmrE
 hUniK9IqZ7o7nafK42JzshK6CTMQHWWEiC6qqfxkii4VPkFwB9HipsHhF7gPdJJkc5s0
 qeTIvV4bX/3cQjNLhtnBwSTu0tREf7W3+KBEjpsuMMK3JuIVpbkUjRoK+6uvNlAU56h8
 827fulBOJl+t0j1T+YfAmTfAnpgGsuDgNO9dclWaqVIfRRmTWwhIsxx/K4IRfTIR4H1X Aw== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3etum21ecu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Mar 2022 14:21:52 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 22FE9IHL013267;
        Tue, 15 Mar 2022 14:21:51 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma04ams.nl.ibm.com with ESMTP id 3erk58xthx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Mar 2022 14:21:50 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 22FELmFX56754590
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Mar 2022 14:21:48 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B62DF52051;
        Tue, 15 Mar 2022 14:21:48 +0000 (GMT)
Received: from localhost (unknown [9.43.32.151])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 171625204E;
        Tue, 15 Mar 2022 14:21:47 +0000 (GMT)
Date:   Tue, 15 Mar 2022 19:51:46 +0530
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc:     linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ext4: Get rid of unused DEFAULT_MB_OPTIMIZE_SCAN
Message-ID: <20220315142146.swjkethfy2befsq4@riteshh-domain>
References: <20220315114454.104182-1-ojaswin@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220315114454.104182-1-ojaswin@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: fcwmrIQixyoj741kyo_bq-DIfTCjyWp7
X-Proofpoint-GUID: fcwmrIQixyoj741kyo_bq-DIfTCjyWp7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-15_03,2022-03-15_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 mlxlogscore=520 mlxscore=0 spamscore=0 malwarescore=0 bulkscore=0
 lowpriorityscore=0 impostorscore=0 clxscore=1015 priorityscore=1501
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203150092
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 22/03/15 05:14PM, Ojaswin Mujoo wrote:
> After recent changes to the mb_optimize_scan mount option
> the DEFAULT_MB_OPTIMIZE_SCAN is no longer needed so get
> rid of it.

Thanks for doing this. Looks good to me.
Feel free to add -

Reviewed-by: Ritesh Harjani <riteshh@linux.ibm.com>
