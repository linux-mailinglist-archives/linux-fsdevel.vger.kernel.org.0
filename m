Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FDF14D4FF0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Mar 2022 18:08:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242398AbiCJRJC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Mar 2022 12:09:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231151AbiCJRJB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Mar 2022 12:09:01 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A1AB4B1E6;
        Thu, 10 Mar 2022 09:07:59 -0800 (PST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22AFLEvn006049;
        Thu, 10 Mar 2022 17:07:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=gOJrpYEIjKDoBOYnxpnAd0h4YRDgIwN6e+vyjHYuhW8=;
 b=sv/Qibmg4IYHGZzQQ7ijEwOCqAz0Ki40/ZLiuTpwBCfCJsWJc6+63f74ERfpmxKU0miF
 TCADEeZwSf4/Vi1JYTXBy2Ro75WRtKEdGlwgZJBuLeAJfxid9xSfS6RX3RKytSthTKfk
 pfPjiwh81iqaceEQYEa/KiJhaiLalL1Nag35nM+nEOMnU406aPJYQ03BjH3WIsDv6ewV
 Fh1Ot6BuXdUyiTnYIxTtrTihu2eFA1KMy06+R1XeWyMcXTFGHkTwaGy5cQIvZ5fKp1Zs
 8RhfKdYbnUb1F5fYZiuC2RKEQpN0EUd78M+Z8HUOAEAhHJ887vqzAhExKpftomx1q7jU BA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3eqfxg08yq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Mar 2022 17:07:38 +0000
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 22AFM8NG017460;
        Thu, 10 Mar 2022 17:07:37 GMT
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3eqfxg08xq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Mar 2022 17:07:37 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 22AH2rmV004298;
        Thu, 10 Mar 2022 17:07:35 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma04fra.de.ibm.com with ESMTP id 3ep8c3vt6e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Mar 2022 17:07:35 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 22AH7WJk43516322
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Mar 2022 17:07:32 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D7F4E42041;
        Thu, 10 Mar 2022 17:07:32 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 56D6F42042;
        Thu, 10 Mar 2022 17:07:32 +0000 (GMT)
Received: from localhost (unknown [9.43.36.239])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 10 Mar 2022 17:07:32 +0000 (GMT)
Date:   Thu, 10 Mar 2022 22:37:31 +0530
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-ext4@vger.kernel.org, Jan Kara <jack@suse.cz>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2 00/10] ext4: Improve FC trace events
Message-ID: <20220310170731.hq6z6flycmgkhnaa@riteshh-domain>
References: <cover.1646922487.git.riteshh@linux.ibm.com>
 <20220310110553.431cc997@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220310110553.431cc997@gandalf.local.home>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Z5AbZFGP0yz7THaVHnqixiAj13oT8Uyn
X-Proofpoint-ORIG-GUID: CsMETZloyRIK-0N9942uxIZ443HFGMGB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-10_07,2022-03-09_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 clxscore=1015 adultscore=0
 mlxscore=0 spamscore=0 mlxlogscore=974 priorityscore=1501 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203100091
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 22/03/10 11:05AM, Steven Rostedt wrote:
> On Thu, 10 Mar 2022 21:28:54 +0530
> Ritesh Harjani <riteshh@linux.ibm.com> wrote:
>
> > Note:- I still couldn't figure out how to expose EXT4_FC_REASON_MAX in patch-2
> > which (I think) might be (only) needed by trace-cmd or perf record for trace_ext4_fc_stats.
> > But it seems "cat /sys/kernel/debug/tracing/trace_pipe" gives the right output
> > for ext4_fc_stats trace event (as shown below).
> >
> > So with above reasoning, do you think we should take these patches in?
> > And we can later see how to provide EXT4_FC_REASON_MAX definition available to
> > libtraceevent?
>
> I don't see EXT4_FC_REASON_MAX being used in the TP_printk(). If it isn't
> used there, it doesn't need to be exposed. Or did I miss something?

I was mentioning about EXT4_FC_REASON_MAX used in TP_STRUCT__entry.
When I hard code EXT4_FC_REASON_MAX to 9 in TP_STRUCT__entry, I could
see proper values using trace-cmd. Otherwise I see all 0 (when using trace-cmd
or perf record).

+	TP_STRUCT__entry(
+		__field(dev_t, dev)
+		__array(unsigned int, fc_ineligible_rc, EXT4_FC_REASON_MAX)

Should we anyway hard code this to 9. Since we are anyway printing all the
9 elements of array values individually.

+	TP_printk("dev %d,%d fc ineligible reasons:\n"
+		  "%s:%u, %s:%u, %s:%u, %s:%u, %s:%u, %s:%u, %s:%u, %s:%u, %s:%u "
+		  "num_commits:%lu, ineligible: %lu, numblks: %lu",
+		  MAJOR(__entry->dev), MINOR(__entry->dev),
+		  FC_REASON_NAME_STAT(EXT4_FC_REASON_XATTR),
+		  FC_REASON_NAME_STAT(EXT4_FC_REASON_CROSS_RENAME),
+		  FC_REASON_NAME_STAT(EXT4_FC_REASON_JOURNAL_FLAG_CHANGE),
+		  FC_REASON_NAME_STAT(EXT4_FC_REASON_NOMEM),
+		  FC_REASON_NAME_STAT(EXT4_FC_REASON_SWAP_BOOT),
+		  FC_REASON_NAME_STAT(EXT4_FC_REASON_RESIZE),
+		  FC_REASON_NAME_STAT(EXT4_FC_REASON_RENAME_DIR),
+		  FC_REASON_NAME_STAT(EXT4_FC_REASON_FALLOC_RANGE),
+		  FC_REASON_NAME_STAT(EXT4_FC_REASON_INODE_JOURNAL_DATA),
+		  __entry->fc_commits, __entry->fc_ineligible_commits,
+		  __entry->fc_numblks)


Thanks
-ritesh
