Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E304B194431
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Mar 2020 17:24:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728466AbgCZQYT convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Mar 2020 12:24:19 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:11866 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727677AbgCZQYT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Mar 2020 12:24:19 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02QG3G2C015664
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Mar 2020 12:24:18 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2ywcj0spdh-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Mar 2020 12:24:17 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-fsdevel@vger.kernel.org> from <sachinp@linux.vnet.ibm.com>;
        Thu, 26 Mar 2020 16:24:11 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 26 Mar 2020 16:24:08 -0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 02QGOCdc55574780
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 Mar 2020 16:24:12 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3EFF542047;
        Thu, 26 Mar 2020 16:24:12 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1B79D42041;
        Thu, 26 Mar 2020 16:24:11 +0000 (GMT)
Received: from [9.79.188.120] (unknown [9.79.188.120])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 26 Mar 2020 16:24:10 +0000 (GMT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [powerpc] Intermittent crashes ( link_path_walk) with linux-next 
From:   Sachin Sant <sachinp@linux.vnet.ibm.com>
In-Reply-To: <20200326134925.GP23230@ZenIV.linux.org.uk>
Date:   Thu, 26 Mar 2020 21:54:10 +0530
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
References: <1CB4E533-FD97-4C39-87ED-4857F3AB9097@linux.vnet.ibm.com>
 <87h7ybwdih.fsf@mpe.ellerman.id.au>
 <20200326134925.GP23230@ZenIV.linux.org.uk>
To:     Al Viro <viro@zeniv.linux.org.uk>
X-Mailer: Apple Mail (2.3445.104.11)
X-TM-AS-GCONF: 00
x-cbid: 20032616-4275-0000-0000-000003B3DCA2
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20032616-4276-0000-0000-000038C9211D
Message-Id: <F38D23C3-09FE-408F-9F50-A7C87280FA1F@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-26_06:2020-03-26,2020-03-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 mlxlogscore=999 impostorscore=0
 suspectscore=0 clxscore=1015 spamscore=0 malwarescore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003260120
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On 26-Mar-2020, at 7:19 PM, Al Viro <viro@zeniv.linux.org.uk> wrote:
> 
> On Thu, Mar 26, 2020 at 10:40:06PM +1100, Michael Ellerman wrote:
> 
>>> The code in question (link_path_walk() in fs/namei.c ) was recently changed by
>>> following commit:
>>> 
>>> commit 881386f7e46a: 
>>>  link_path_walk(): sample parent's i_uid and i_mode for the last component
>> 
>> That and about 10 other commits.
>> 
>> Unless Al can give us a clue we'll need to bisect.
> 
> 	Already fixed yesterday.  It's not link_path_walk(), it's handle_dots()
> ignoring an error returned by step_into().
> 
> commit 5e3c3570ec97 is the broken one; commit 20971012f63e is its variant with the
> fix folded in.  So next-20200325 has the bug and next-20200326 should have it
> fixed.  Could you check the current -next and see if you still observe that crap?

Thanks Al for the information. 

I confirm that today’s next tree (20200326) work for me. I can no longer recreate this
problem.

Thanks
-Sachin

