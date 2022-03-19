Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 450A54DE60F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Mar 2022 06:05:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242158AbiCSFG1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 19 Mar 2022 01:06:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240014AbiCSFGZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 19 Mar 2022 01:06:25 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16E972B5ADA;
        Fri, 18 Mar 2022 22:05:05 -0700 (PDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22J3qA6M004240;
        Sat, 19 Mar 2022 05:04:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=KRFaVSWL/9emteJ6cwiuaXKazHFMP9Nbr4bOW8oHCRE=;
 b=WE8CWmAQd73Ir/f3D8VYt9E8kBOaCJ1SyKB6ZMpMxYYUMjPqGlNznsXwfqr6ScxklbiM
 65E/vzYVBWRhibKDiOMxdgF3n8ULTd6IhvDx6b3GVzvPqhky18nySkOPw0tQB24kzlOl
 VhzpKFBw/arKnzVmKlonHbDQApCEAI1xB3yxaK7YgbMpz3I0oV6QLx/1AspfHY6BrMiL
 waBBQcVcrdp7sZM/PQubvrajmyLP49yyJqatbhAm2uR1PKcZZyREgsOo/PsrQk8KVpOz
 YW9Kue0NUx49VvmTJF9p7be42OijjdhiSKTVmVawRA0ILe90SDDzIJs2udgpGGoG6E1E Ig== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ew7n6rre0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 19 Mar 2022 05:04:42 +0000
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 22J51UVq007941;
        Sat, 19 Mar 2022 05:04:42 GMT
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ew7n6rrdm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 19 Mar 2022 05:04:42 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 22J3x1Qm005638;
        Sat, 19 Mar 2022 05:04:40 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma04fra.de.ibm.com with ESMTP id 3ew6t8g4s5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 19 Mar 2022 05:04:40 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 22J54cep30867780
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 19 Mar 2022 05:04:38 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E92DE11C04A;
        Sat, 19 Mar 2022 05:04:37 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6A2BD11C052;
        Sat, 19 Mar 2022 05:04:37 +0000 (GMT)
Received: from localhost (unknown [9.43.118.162])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sat, 19 Mar 2022 05:04:37 +0000 (GMT)
Date:   Sat, 19 Mar 2022 10:34:36 +0530
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Sven Schnelle <svens@linux.ibm.com>
Cc:     linux-ext4@vger.kernel.org, Jan Kara <jack@suse.cz>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@kernel.org
Subject: Re: [PATCHv3 02/10] ext4: Fix ext4_fc_stats trace point
Message-ID: <20220319050436.y7v3rxkjnbhb33sl@riteshh-domain>
References: <cover.1647057583.git.riteshh@linux.ibm.com>
 <b4b9691414c35c62e570b723e661c80674169f9a.1647057583.git.riteshh@linux.ibm.com>
 <yt9dr1706b4i.fsf@linux.ibm.com>
 <20220317143938.745e1420@gandalf.local.home>
 <20220318123058.348938b1@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220318123058.348938b1@gandalf.local.home>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: -KaAEAYfkUccww1OuOfH0SQY-ZLYVrdM
X-Proofpoint-GUID: qeamiA8I1JE5uVo8lbe2LrfJdHpNBGYN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-19_01,2022-03-15_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=953 clxscore=1015
 malwarescore=0 adultscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 mlxscore=0 suspectscore=0 impostorscore=0 lowpriorityscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203190024
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 22/03/18 12:30PM, Steven Rostedt wrote:
> On Thu, 17 Mar 2022 14:39:38 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
>
> > [ here I wanted to add a patch, but I haven't figured out the best way to
> >   fix it yet. ]
>
> Care to try this patch?
>

fwiw, I gave this patch a try (on x86 and ppc64le guests) and with it
ext4_fc_stats() trace event is working fine as expected. Although I could
never reproduced the original issue which Sven reported on his s390x box.

So will wait till Sven also give this a try.

Thanks!!
-ritesh
