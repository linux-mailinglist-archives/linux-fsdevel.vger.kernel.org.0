Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 890CD4D6445
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Mar 2022 16:04:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348377AbiCKPF2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Mar 2022 10:05:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245573AbiCKPF1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Mar 2022 10:05:27 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DD371B30A9;
        Fri, 11 Mar 2022 07:04:24 -0800 (PST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22BDLcFo008155;
        Fri, 11 Mar 2022 15:04:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=eh8/K0s2iJd7hnmu9HBetPe4BCTIrv3SEKscVvAp2m8=;
 b=D/Gh/RVaGGiEgNTpIFrzJg5rCp/uUdR/T48E4GPzW/FeAjWUen2zUdftsuXKzuBxupqu
 K5+Y7QZgJI2HBWFbDR6J6kw5JS6B/149U0XGlKj8i9XRv4zzgNAkmmXJZ2nhzadSAYPL
 s8oIggx8XJgqeww6Ia7cE4yaq1eOrPm2z8wfnvpAi24Gvuj5XPk/+jhNPIueF36ackee
 X/X0HkLrp9KuCDKLU2/U2JqXs6WiTOkAMTbMSOFVPzPEHbxCCHPJUg01AGGtD5YMefqH
 GwqHtRXlzMeMetiR9CO2h8I8Ve0V9cmtDA9NjFeDxQ7mWlcwITbW+LmlWZs+/H+vUZJP fg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3eqg9eehe0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Mar 2022 15:04:04 +0000
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 22BEgREq030478;
        Fri, 11 Mar 2022 15:04:04 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3eqg9eehdd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Mar 2022 15:04:03 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 22BEvXYR011516;
        Fri, 11 Mar 2022 15:04:02 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma03ams.nl.ibm.com with ESMTP id 3ekyg979xw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Mar 2022 15:04:02 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 22BF3x4j54591986
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Mar 2022 15:03:59 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A8A5911C058;
        Fri, 11 Mar 2022 15:03:59 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3A2E811C052;
        Fri, 11 Mar 2022 15:03:59 +0000 (GMT)
Received: from localhost (unknown [9.43.36.239])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 11 Mar 2022 15:03:58 +0000 (GMT)
Date:   Fri, 11 Mar 2022 20:33:57 +0530
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-ext4@vger.kernel.org, Jan Kara <jack@suse.cz>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2 00/10] ext4: Improve FC trace events
Message-ID: <20220311150357.x6wpvzthsimb26m6@riteshh-domain>
References: <cover.1646922487.git.riteshh@linux.ibm.com>
 <20220310110553.431cc997@gandalf.local.home>
 <20220310170731.hq6z6flycmgkhnaa@riteshh-domain>
 <20220310193936.38ae7754@gandalf.local.home>
 <20220311021931.d4oozgtefbalrcch@riteshh-domain>
 <20220310213356.3948cfb7@gandalf.local.home>
 <20220311031431.3sfbibwuthn4xkym@riteshh-domain>
 <20220310233234.4418186a@gandalf.local.home>
 <20220311051249.ltgqbjjothbrkbno@riteshh-domain>
 <20220311094524.1fa2d98f@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220311094524.1fa2d98f@gandalf.local.home>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: v8gfjf_Vh3t-iiAIeXSrL2VJXCoJeDbE
X-Proofpoint-ORIG-GUID: 2FrFjJcXHP15cfzGhTQHgj9EolXi7KeY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-11_06,2022-03-11_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 clxscore=1015 adultscore=0 spamscore=0
 impostorscore=0 bulkscore=0 suspectscore=0 mlxscore=0 mlxlogscore=710
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203110075
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 22/03/11 09:45AM, Steven Rostedt wrote:
> On Fri, 11 Mar 2022 10:42:49 +0530
> Ritesh Harjani <riteshh@linux.ibm.com> wrote:
>
> > You may add below, if you like:-
> >
> > Reported-and-tested-by: Ritesh Harjani <riteshh@linux.ibm.com>
>
> Will do. Thanks for testing.
>
> I'll be adding this for the next merge window. I don't think this is
> something that needs to be added to this rc release nor stable. Do you
> agree?

If using an enum in TP_STRUCT__entry's __array field doesn't cause any side
effect other than it just can't be decoded by userspace perf record / trace-cmd,
then I guess it should be ok.

But for this PATCH 2/10 "ext4: Fix ext4_fc_stats trace point", will be
needed to be Cc'd to stable tree as discussed before, as it tries to
dereference some sbi pointer from the tracing ring buffer. Then hopefully the
only problem with previous kernel version would be that ext4_fc_stats(), won't
show proper values for array entries in older kernel version where this patch
of trace_events is not found.
But cat /sys/kernel/debug/tracing/trace_pipe should be able to show the right values.


From my side, I will send a v3 of this patch series with just EXT4_FC_REASON_MAX
defined using TRACE_DEFINE_ENUM.

Thanks again for your help :)

-ritesh

>
> -- Steve
