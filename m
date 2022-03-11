Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 630184D58BD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Mar 2022 04:15:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345967AbiCKDQD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Mar 2022 22:16:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345960AbiCKDQC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Mar 2022 22:16:02 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C9BB1A6157;
        Thu, 10 Mar 2022 19:15:00 -0800 (PST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22B0Ad5p029667;
        Fri, 11 Mar 2022 03:14:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=jqIC8Bg12ntTvl+0SIbsbDTrpL8KxvLBHT167uzVtcw=;
 b=ljBujJ0qV11WSnGUmiynIGtQJ1GRSpxPDm5ogCkJw21m2+a2BN1coAOcDby4ygm4CQks
 5Jg/W2nw7+bgT0BBoGEC7WHOTNv2PbVVCaKSSBvGA1k2Fxnw6H5BNOURXegGN6uZ/4lc
 cGiNcqjiBhNFA1yrGAX93uBdp2JG27yK6QwL0Iw6P7RAtePAJMkwifYmR+Vt36K2t1X1
 4ucBLpfpitNOzOBgxKNF0zzSR2FtCEM3fb9qhQIUzmvL37QoRcmt2+RIb/hgjJRe1F1L
 5FApaWDyQgOUk0IqNfN5deUWH97tCdzCapORsraV8gBz3wQJRQ6fkvZM9xXPzxQo95gO Lg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3eqnccjeu9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Mar 2022 03:14:38 +0000
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 22B3CI1T022677;
        Fri, 11 Mar 2022 03:14:38 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3eqnccjetr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Mar 2022 03:14:37 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 22B37kPv015817;
        Fri, 11 Mar 2022 03:14:35 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma04ams.nl.ibm.com with ESMTP id 3enqgnrjhh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Mar 2022 03:14:35 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 22B3EXLx53019128
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Mar 2022 03:14:33 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ED5ED4C044;
        Fri, 11 Mar 2022 03:14:32 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 808494C040;
        Fri, 11 Mar 2022 03:14:32 +0000 (GMT)
Received: from localhost (unknown [9.43.36.239])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 11 Mar 2022 03:14:32 +0000 (GMT)
Date:   Fri, 11 Mar 2022 08:44:31 +0530
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-ext4@vger.kernel.org, Jan Kara <jack@suse.cz>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2 00/10] ext4: Improve FC trace events
Message-ID: <20220311031431.3sfbibwuthn4xkym@riteshh-domain>
References: <cover.1646922487.git.riteshh@linux.ibm.com>
 <20220310110553.431cc997@gandalf.local.home>
 <20220310170731.hq6z6flycmgkhnaa@riteshh-domain>
 <20220310193936.38ae7754@gandalf.local.home>
 <20220311021931.d4oozgtefbalrcch@riteshh-domain>
 <20220310213356.3948cfb7@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220310213356.3948cfb7@gandalf.local.home>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: qUP-iZseQfzoUmnJRu3EkAsFV4tUzxHh
X-Proofpoint-GUID: MHi4IatWeYIPMQc3Uve-fpvyTGaiBTWZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-10_09,2022-03-09_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=712
 lowpriorityscore=0 adultscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 spamscore=0 mlxscore=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203110013
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 22/03/10 09:33PM, Steven Rostedt wrote:
> On Fri, 11 Mar 2022 07:49:31 +0530
> Ritesh Harjani <riteshh@linux.ibm.com> wrote:
>
> > > # cat /sys/kernel/tracing/events/ext4/ext4_fc_commit_stop/format
> >
> > I think you meant ext4_fc_stats.
>
> Sure.
>
> >
> > >
> > > and show me what it outputs.
> >
> > root@qemu:/home/qemu# cat /sys/kernel/tracing/events/ext4/ext4_fc_stats/format
> > name: ext4_fc_stats
> > ID: 986
> > format:
> >         field:unsigned short common_type;       offset:0;       size:2; signed:0;
> >         field:unsigned char common_flags;       offset:2;       size:1; signed:0;
> >         field:unsigned char common_preempt_count;       offset:3;       size:1; signed:0;
> >         field:int common_pid;   offset:4;       size:4; signed:1;
> >
> >         field:dev_t dev;        offset:8;       size:4; signed:0;
> >         field:unsigned int fc_ineligible_rc[EXT4_FC_REASON_MAX];        offset:12;      size:36;        signed:0;
>
> Bah, the above tells us how many items, and the TRACE_DEFINE_ENUM() doesn't
> modify this part of the file.

Then shall I just define TRACE_DEFINE_ENUM(EXT4_FC_REASON_MAX) in this patch.
Would that be the correct approach? Like how we have defined other enums.
We haven't yet defined EXT4_FC_REASON_MAX in current patch.
(as I saw it doesn't affect TP_STRUCT__entry())


>
> I could update it to do so though.

Please let me know if you have any patch for me to try.

Thanks
-ritesh


>
> -- Steve
>
>
> >         field:unsigned long fc_commits; offset:48;      size:8; signed:0;
> >         field:unsigned long fc_ineligible_commits;      offset:56;      size:8; signed:0;
> >         field:unsigned long fc_numblks; offset:64;      size:8; signed:0;
>
