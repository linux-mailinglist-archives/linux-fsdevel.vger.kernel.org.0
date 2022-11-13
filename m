Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91E8C626F9A
	for <lists+linux-fsdevel@lfdr.de>; Sun, 13 Nov 2022 14:03:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233954AbiKMNDp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 13 Nov 2022 08:03:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233794AbiKMNDo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 13 Nov 2022 08:03:44 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F33721014;
        Sun, 13 Nov 2022 05:03:43 -0800 (PST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.5) with ESMTP id 2ADD05lo029520;
        Sun, 13 Nov 2022 13:03:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=qyulVEIjHeOkvopvNx1W3Vi5BDzfik8N7FImFcDHtNc=;
 b=P9zAOiYUlgGUzaLMzfDLR2/9uNbb/7OfZXpT92w+DuMf/Hh4FBMwhP7/lvpfmZ4cjQj6
 vMYtyJlpLrF9OhLhRfrCTKfdjF+HsnATYQIT01tpxnbf/J6vyhN/4z5O55+2UJz2dqs/
 GgwN8NM/ZOrcCAXu74/yV2zmbnqNsTLI9loUqnBvZLr9IVlFoVZQfohW9ejsZobQ1U+G
 czL0xxdnIZQoTaUknNOLKB4qVK8KGvkY8UGJ6fc9OhJ0YahO1N4foDg+qHCkQUQgCiKr
 DmDpTb7sT5mExkyZ4kYwlz5fY4W96igpYPW1TPxeMNlr3tJgoe/uMiA4mlZvBXYbMgq+ 8g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ku134g2fc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 13 Nov 2022 13:03:37 +0000
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2ADD05cf029485;
        Sun, 13 Nov 2022 13:03:36 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ku134g2en-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 13 Nov 2022 13:03:36 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2ADCoWht021313;
        Sun, 13 Nov 2022 13:03:34 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma03ams.nl.ibm.com with ESMTP id 3kt348scqk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 13 Nov 2022 13:03:33 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2ADD3V4G48759224
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 13 Nov 2022 13:03:31 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A50E811C050;
        Sun, 13 Nov 2022 13:03:31 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A231511C04A;
        Sun, 13 Nov 2022 13:03:29 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.43.42.55])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Sun, 13 Nov 2022 13:03:29 +0000 (GMT)
Date:   Sun, 13 Nov 2022 18:33:26 +0530
From:   Ojaswin Mujoo <ojaswin@linux.ibm.com>
To:     linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>
Cc:     Ritesh Harjani <riteshh@linux.ibm.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>, rookxu <brookxu.cn@gmail.com>
Subject: Re: [PATCH v2 0/8] ext4: Convert inode preallocation list to an
 rbtree
Message-ID: <Y3DrHqE6Q8eEAzPc@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
References: <cover.1665776268.git.ojaswin@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1665776268.git.ojaswin@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: cg3uzLBt4Sg1XIX7ycAwgXzCdxrfU5dp
X-Proofpoint-GUID: lmTJsti5USOLRVkDk3oa5qeEZgBhSgXJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-13_09,2022-11-11_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 priorityscore=1501 mlxlogscore=512 clxscore=1011 impostorscore=0
 malwarescore=0 spamscore=0 suspectscore=0 adultscore=0 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211130088
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

Just a gentle ping, let me know if there are any reviews or suggestions
regarding this patchset.

Thank you!
ojaswin

On Sat, Oct 15, 2022 at 02:06:22AM +0530, Ojaswin Mujoo wrote:
> This patch series aim to improve the performance and scalability of
> inode preallocation by changing inode preallocation linked list to an
> rbtree. I've ran xfstests quick on this series and plan to run auto group
> as well to confirm we have no regressions.
