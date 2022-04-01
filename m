Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 072D94EE7F8
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Apr 2022 07:55:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245232AbiDAF5Z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 Apr 2022 01:57:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245228AbiDAF5Y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 Apr 2022 01:57:24 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E58DDFABE8;
        Thu, 31 Mar 2022 22:55:34 -0700 (PDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2315rGPk017998;
        Fri, 1 Apr 2022 05:55:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=XorIhYMzQ9kVZV0+80aLEC+LtuYZUGZzj3tyYkODomk=;
 b=T/qV6el63iFdIdYPAR8EzQazlhvURQ4hsTUiPzrAf6atthrriOKenImhII7rycd5oGCj
 1ZXGHWuyR06y78e7MSVwU7oenfny9oXeB80yjCewc9araFpp2VdfY6t7tIp355871C15
 Gp4iUghvLEU9F56Tcrrr6b8Gl//i3srVc1HfkS83QHGiipt6fiH9/jFxY9VWuZvdy57+
 YLrzvo9MUIQZR8YWqNPEZQbbHXRoPtwUJMboMEfehchVVMwjeQWvEuOHP6c7bPUz1X74
 dyNAXaVq7HQzskLRt1La7O7skN4gptq9QGTu7Y0zLnYAksuoG9ky61tKwO8oXOPK7E2J jg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3f5a3kn4kh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 Apr 2022 05:55:31 +0000
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 2315tQZv020907;
        Fri, 1 Apr 2022 05:55:31 GMT
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3f5a3kn4k2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 Apr 2022 05:55:31 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2315r8QN009029;
        Fri, 1 Apr 2022 05:55:29 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma01fra.de.ibm.com with ESMTP id 3f1tf8tdfb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 Apr 2022 05:55:29 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2315tXua37618126
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 1 Apr 2022 05:55:33 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 418174C044;
        Fri,  1 Apr 2022 05:55:27 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3419E4C046;
        Fri,  1 Apr 2022 05:55:25 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.43.119.93])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Fri,  1 Apr 2022 05:55:24 +0000 (GMT)
Date:   Fri, 1 Apr 2022 11:25:21 +0530
From:   Ojaswin Mujoo <ojaswin@linux.ibm.com>
To:     Ritesh Harjani <ritesh.list@gmail.com>,
        "Darrick J . Wong" <djwong@kernel.org>,
        fstests <fstests@vger.kernel.org>, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCHv3 0/4] generic: Add some tests around journal
 replay/recoveryloop
Message-ID: <YkaTyV2I5WzueD24@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
References: <cover.1648730443.git.ritesh.list@gmail.com>
 <20220331145906.2onnohv2bbg3ye6j@zlang-mailbox>
 <20220331161911.7d5dlqfwm2kngnjk@riteshh-domain>
 <20220331165335.mzx3gfc3uqeeg3sz@riteshh-domain>
 <20220401053047.ic4cbsembj6eoibm@zlang-mailbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220401053047.ic4cbsembj6eoibm@zlang-mailbox>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: eNbwm5ZlGgsjR5TMhRPlylw1IamVd_dj
X-Proofpoint-ORIG-GUID: sZtq5XZ0pakS5mHbjGMIcK_l_FOVdDFQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-31_06,2022-03-31_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 phishscore=0 clxscore=1011 spamscore=0 adultscore=0 mlxscore=0
 priorityscore=1501 mlxlogscore=999 suspectscore=0 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204010025
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 01, 2022 at 01:30:47PM +0800, Zorro Lang wrote:
> On Thu, Mar 31, 2022 at 10:23:35PM +0530, Ritesh Harjani wrote:
> > On 22/03/31 09:49PM, Ritesh Harjani wrote:
> > > On 22/03/31 10:59PM, Zorro Lang wrote:
> > > > On Thu, Mar 31, 2022 at 06:24:19PM +0530, Ritesh Harjani wrote:
> > > > > Hello,
> > > >
> > > > Hi,
> > > >
> > > > Your below patches looks like not pure text format, they might contain
> > > > binary character or some special characers, looks like the "^M" [1].
> > 
> > Sorry to bother you. But here is what I tried.
> > 1. Download the mbx file using b4 am. I didn't see any such character ("^M") in
> >    the patches.
> > 2. Saved the patch using mutt. Again didn't see such character while doing
> > 	cat -A /patch/to/patch
> > 3. Downloaded the mail using eml format from webmail. Here I do see this
> >    character appended. But that happens not just for my patch, but for all
> >    other patches too.
> > 
> > So could this be related to the way you are downloading these patches.
> > Please let me know, if I need to resend these patches again? Because, I don't
> > see this behavior at my end. But I would happy to correct it, if that's not the
> > case.
> 
> Hmm... weird, When I tried to open your patch emails, my mutt show me:
> 
>   [-- application/octet-stream is unsupported (use 'v' to view this part) --]
> 
> Then I have to input 'v' to see the patch content. I'm not sure what's wrong,
> this's the 2nd time I hit this "octet-stream is unsupported" issue yesterday.
> 
> Hi Darrick, or any other forks, can you open above 4 patches normally? If that's
> only my personal issue, I'll check my side.
Hi Zorro,

The patchset seems to open normally at my end.

Thanks,
Ojaswin
> 
> Thanks,
> Zorro
> 
> > 
> > -ritesh
> > 
> 
