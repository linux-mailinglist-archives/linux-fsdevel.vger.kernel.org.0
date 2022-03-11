Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B82264D5A50
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Mar 2022 06:13:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345527AbiCKFOZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Mar 2022 00:14:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345312AbiCKFOV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Mar 2022 00:14:21 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 154861AC2B9;
        Thu, 10 Mar 2022 21:13:19 -0800 (PST)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22B1kiic027618;
        Fri, 11 Mar 2022 05:12:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=dyZZySrUZ1kVKV6+HHBwc8F4zdEEAHcmY5D1iLvSZ70=;
 b=f45pjfRZ2BgZ0K+lf0iYq6HTwX0w9zCMOnLKGlVKayBB2TRlPP/SS+QaF83FfpDLGgaq
 oqGqMvVrgKY/YPNOqVuftENNpc5Cb6RlCnEKqgO8SO2npYMBMJhWsFfZEfoklbcXiVwM
 xn/g9RzUaxEvpJoJSShkeab7YST3QTiqinlMycnlzWBl+BQaUmhUz89YN7fTx/KNdXAF
 eRMKnRd+2n9IhIXWfqqgFy1QvFVP8kH0kBdvfAuNtZreyEbCJiTrCFp+pUNyy8Y5dn4z
 QIKPwbnoi/43OAQyDAuxECndJox07q5nam5a8IapLl5MU2DIcLCHwSYTEtTy1CJgNj4F 3w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3eqsgmee6n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Mar 2022 05:12:57 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 22B4tYej019622;
        Fri, 11 Mar 2022 05:12:56 GMT
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3eqsgmee62-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Mar 2022 05:12:56 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 22B53Rde027540;
        Fri, 11 Mar 2022 05:12:54 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma02fra.de.ibm.com with ESMTP id 3eqr1nrkmq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Mar 2022 05:12:53 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 22B5CpaZ26739088
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Mar 2022 05:12:51 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 709ACA405F;
        Fri, 11 Mar 2022 05:12:51 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F2546A4060;
        Fri, 11 Mar 2022 05:12:50 +0000 (GMT)
Received: from localhost (unknown [9.43.36.239])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 11 Mar 2022 05:12:50 +0000 (GMT)
Date:   Fri, 11 Mar 2022 10:42:49 +0530
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-ext4@vger.kernel.org, Jan Kara <jack@suse.cz>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2 00/10] ext4: Improve FC trace events
Message-ID: <20220311051249.ltgqbjjothbrkbno@riteshh-domain>
References: <cover.1646922487.git.riteshh@linux.ibm.com>
 <20220310110553.431cc997@gandalf.local.home>
 <20220310170731.hq6z6flycmgkhnaa@riteshh-domain>
 <20220310193936.38ae7754@gandalf.local.home>
 <20220311021931.d4oozgtefbalrcch@riteshh-domain>
 <20220310213356.3948cfb7@gandalf.local.home>
 <20220311031431.3sfbibwuthn4xkym@riteshh-domain>
 <20220310233234.4418186a@gandalf.local.home>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220310233234.4418186a@gandalf.local.home>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: kiqGEZuI8kPu63b_5dDWpfnU-kTPYDT7
X-Proofpoint-GUID: M2muCKVtFSTiKUqZJEjicuQZ6GH41Zxb
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-10_09,2022-03-09_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 spamscore=0 adultscore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 phishscore=0 malwarescore=0 mlxlogscore=999
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203110024
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 22/03/10 11:32PM, Steven Rostedt wrote:
> On Fri, 11 Mar 2022 08:44:31 +0530
> Ritesh Harjani <riteshh@linux.ibm.com> wrote:
>
> > > I could update it to do so though.
> >
> > Please let me know if you have any patch for me to try.
>
> Can you try this?

Thanks a lot Steve for quick patch.
I tested your patch and it seems to be working fine.

Below are the details -

root@qemu:/home/qemu# cat /sys/kernel/tracing/events/ext4/ext4_fc_stats/format
name: ext4_fc_stats
ID: 986
format:
        field:unsigned short common_type;       offset:0;       size:2; signed:0;
        field:unsigned char common_flags;       offset:2;       size:1; signed:0;
        field:unsigned char common_preempt_count;       offset:3;       size:1; signed:0;
        field:int common_pid;   offset:4;       size:4; signed:1;

        field:dev_t dev;        offset:8;       size:4; signed:0;
        field:unsigned int fc_ineligible_rc[9]; offset:12;      size:36;        signed:0;
^^^^ It's now taking the enum value of EXT4_FC_REASON_MAX in array field too.

Also output from trace-cmd and perf script shows the right data

xfs_io  1856 [000]   173.411127:        ext4:ext4_fc_stats: dev 7,2 fc ineligible reasons:
XATTR:0, CROSS_RENAME:0, JOURNAL_FLAG_CHANGE:0, NO_MEM:0, SWAP_BOOT:0, RESIZE:0, RENAME_DIR:0, FALLOC_RANGE:2, INODE_JOURNAL_DATA:0 num_commits:0, ineligible: 1, numblks: 0

>
> -- Steve
>
> From 392b91c598da2a8c5bbaebad08cd0410f4607bf4 Mon Sep 17 00:00:00 2001
> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> Date: Thu, 10 Mar 2022 23:27:38 -0500
> Subject: [PATCH] tracing: Have TRACE_DEFINE_ENUM affect trace event types as
>  well
>
> The macro TRACE_DEFINE_ENUM is used to convert enums in the kernel to
> their actual value when they are exported to user space via the trace
> event format file.
>
> Currently only the enums in the "print fmt" (TP_printk in the TRACE_EVENT
> macro) have the enums converted. But the enums can be used to denote array
> size:
>
>         field:unsigned int fc_ineligible_rc[EXT4_FC_REASON_MAX]; offset:12;      size:36;        signed:0;
>
> The EXT4_FC_REASON_MAX has no meaning to userspace but it needs to know
> that information to know how to parse the array.
>
> Have the array indexes also be parsed as well.
>
> Link: https://lore.kernel.org/all/cover.1646922487.git.riteshh@linux.ibm.com/
>
> Reported-by: Ritesh Harjani <riteshh@linux.ibm.com>
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>  kernel/trace/trace_events.c | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)

You may add below, if you like:-

Reported-and-tested-by: Ritesh Harjani <riteshh@linux.ibm.com>

-ritesh


>
> diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
> index 38afd66d80e3..ae9a3b8481f5 100644
> --- a/kernel/trace/trace_events.c
> +++ b/kernel/trace/trace_events.c
> @@ -2633,6 +2633,33 @@ static void update_event_printk(struct trace_event_call *call,
>  	}
>  }
>
> +static void update_event_fields(struct trace_event_call *call,
> +				struct trace_eval_map *map)
> +{
> +	struct ftrace_event_field *field;
> +	struct list_head *head;
> +	char *ptr;
> +	int len = strlen(map->eval_string);
> +
> +	head = trace_get_fields(call);
> +	list_for_each_entry(field, head, link) {
> +		ptr = strchr(field->type, '[');
> +		if (!ptr)
> +			continue;
> +		ptr++;
> +
> +		if (!isalpha(*ptr) && *ptr != '_')
> +			continue;
> +
> +		if (strncmp(map->eval_string, ptr, len) != 0)
> +			continue;
> +
> +		ptr = eval_replace(ptr, map, len);
> +		/* enum/sizeof string smaller than value */
> +		WARN_ON_ONCE(!ptr);
> +	}
> +}
> +
>  void trace_event_eval_update(struct trace_eval_map **map, int len)
>  {
>  	struct trace_event_call *call, *p;
> @@ -2668,6 +2695,7 @@ void trace_event_eval_update(struct trace_eval_map **map, int len)
>  					first = false;
>  				}
>  				update_event_printk(call, map[i]);
> +				update_event_fields(call, map[i]);
>  			}
>  		}
>  	}
> --
> 2.34.1
>
