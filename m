Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1BB3729E73
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Jun 2023 17:27:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241333AbjFIP1e (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Jun 2023 11:27:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240733AbjFIP11 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Jun 2023 11:27:27 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B7CC3AAD;
        Fri,  9 Jun 2023 08:27:22 -0700 (PDT)
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 359FJXd4002613;
        Fri, 9 Jun 2023 15:27:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=C++pQTQAuHPdrSYY3hZyvTgu1kehwRjQ+jhhSI164wM=;
 b=bak2cVAEu1GveO4awB5aIsuNgoj4wYmPo0AwLycmHvJAtOg6zC44c9suDMTcom3sBVVM
 1U2lAK1Yqw4SL1F45s5nccCo377dYjMh9Y4FjAWUUqcKl6u88oxMzsguoJUdy85dhP+Y
 bUicPlQbLKOqSD8yU0arVNto+vLtvajcQ6u4xmnuS+TgmYFdOxISq55zhfVHoDQ6lP30
 EBxuOanfIWlkL5zbEwy8qAhj0ni1x+D4lzIfUaKabfvW283JfzCUYWP3CpQIIP/9kO3L
 +G7lsLLIaF/bguWWhmHIJ96/pK/+xZMBv5KgpKDuQt5wAwckhIiWg6m1a5KQu7KFrWv6 TQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3r46mc859w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Jun 2023 15:27:06 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 359FLZHA008339;
        Fri, 9 Jun 2023 15:27:06 GMT
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3r46mc859q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Jun 2023 15:27:06 +0000
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 359DrjVh022695;
        Fri, 9 Jun 2023 15:27:05 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([9.208.130.102])
        by ppma03wdc.us.ibm.com (PPS) with ESMTPS id 3r2a77pb54-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Jun 2023 15:27:05 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
        by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 359FR4Yt59900292
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 9 Jun 2023 15:27:05 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E6C9458059;
        Fri,  9 Jun 2023 15:27:04 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 22D1358058;
        Fri,  9 Jun 2023 15:27:04 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.61.47.53])
        by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Fri,  9 Jun 2023 15:27:04 +0000 (GMT)
Message-ID: <b24beac58595d2b43952cb0112fd84f75651086d.camel@linux.ibm.com>
Subject: Re: [PATCH 0/3] Reduce impact of overlayfs fake path files
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Amir Goldstein <amir73il@gmail.com>,
        Miklos Szeredi <miklos@szeredi.hu>
Cc:     Christian Brauner <brauner@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        Paul Moore <paul@paul-moore.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org
Date:   Fri, 09 Jun 2023 11:27:03 -0400
In-Reply-To: <CAOQ4uxh=KfY2mNW1jQk6-wjoGWzi5LdCN=H9LzfCSx2o69K36A@mail.gmail.com>
References: <20230609073239.957184-1-amir73il@gmail.com>
         <CAJfpegvDoSWPRaoa_i_Do3JDdaXrhohDtfQNObSJ7tNhhuHAKw@mail.gmail.com>
         <CAOQ4uxh=KfY2mNW1jQk6-wjoGWzi5LdCN=H9LzfCSx2o69K36A@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: rcs_LWEmQJH8FB4eauyTXfNzOyHeIWih
X-Proofpoint-ORIG-GUID: szv-tZ_ximXNhKjKM4eyrGyD20g_OIUn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-09_10,2023-06-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=527 impostorscore=0 adultscore=0 mlxscore=0 bulkscore=0
 phishscore=0 suspectscore=0 priorityscore=1501 spamscore=0 clxscore=1011
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306090126
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 2023-06-09 at 17:28 +0300, Amir Goldstein wrote:
> For IMA/LSMs, I'd imagine that like fanotify, they would rather get
> the real path where the real policy is stored.

Definitely!

> If some log files end with relative path instead of full fake path
> it's probably not the worst outcome.

-- 
thanks,

Mimi

