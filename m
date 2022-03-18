Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5C2E4DD3DC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Mar 2022 05:15:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232356AbiCREQp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Mar 2022 00:16:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbiCREQm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Mar 2022 00:16:42 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EAAF10E075;
        Thu, 17 Mar 2022 21:15:23 -0700 (PDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22I2uTfM010620;
        Fri, 18 Mar 2022 04:15:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=AFMdLMGCUB3YlWtnONSwVOJtDrxK3jekktpnKjjgpxA=;
 b=cF1so1wt43b80klNeXaEb36uTuo5IGMpfs8CxbA/CdIsnoimA8MVCpJh0QbaBErRRyHp
 ZhyeDkuxl1RTHhqweC0e4uIDfqNdxNqk/je9ihBxn+7j2Ll0/CY1jf4LBP0ZWRVgZuiZ
 XKFcefy7uUJzlDoEiJ/rEM/iwqxBtA6kVXuWraJbWukhrIZmBd3EjS9jR0NQiop6vRzb
 OQd60u/t/2A+Dxl2Uxp9yllgFFqWmQHhs31o4cTN81KpG4qPT3NdQFlXTDUE1nGzMYD4
 2idfSnydbpD2gzLjddWwQbLX4PoHlxkvtPtTCeE/zQP/afAV4M/i3S+PuhXfY+1888Wa 5g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ev1w0v8cc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Mar 2022 04:15:02 +0000
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 22I42BnA003994;
        Fri, 18 Mar 2022 04:15:02 GMT
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ev1w0v8bn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Mar 2022 04:15:02 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 22I49EZ6024921;
        Fri, 18 Mar 2022 04:14:59 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma04fra.de.ibm.com with ESMTP id 3erk58tsc0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Mar 2022 04:14:59 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 22I4Euvw16580970
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Mar 2022 04:14:56 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6796EA4054;
        Fri, 18 Mar 2022 04:14:56 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C4AB8A405C;
        Fri, 18 Mar 2022 04:14:55 +0000 (GMT)
Received: from localhost (unknown [9.43.127.134])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 18 Mar 2022 04:14:55 +0000 (GMT)
Date:   Fri, 18 Mar 2022 09:44:53 +0530
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Sven Schnelle <svens@linux.ibm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-ext4@vger.kernel.org, Jan Kara <jack@suse.cz>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@kernel.org, hca@linux.ibm.com
Subject: Re: [PATCHv3 02/10] ext4: Fix ext4_fc_stats trace point
Message-ID: <20220318041453.fho5l6zsfapo37fk@riteshh-domain>
References: <cover.1647057583.git.riteshh@linux.ibm.com>
 <b4b9691414c35c62e570b723e661c80674169f9a.1647057583.git.riteshh@linux.ibm.com>
 <yt9dr1706b4i.fsf@linux.ibm.com>
 <20220317145008.73nm7hqtccyjy353@riteshh-domain>
 <yt9d1qz05zk1.fsf@linux.ibm.com>
 <YjNzUImisNklfvae@thelio-3990X>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YjNzUImisNklfvae@thelio-3990X>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: zsykd87ix3dUb09JX_ByuSB-IJYZ16i1
X-Proofpoint-ORIG-GUID: jF-OQTpL0MXjG3KZoaPfYPZ32B4f3kdJ
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-18_05,2022-03-15_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 impostorscore=0 clxscore=1011 mlxscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 malwarescore=0 phishscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203180021
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 22/03/17 10:43AM, Nathan Chancellor wrote:
> On Thu, Mar 17, 2022 at 05:11:42PM +0100, Sven Schnelle wrote:
> > Hi,
> >
> > Ritesh Harjani <riteshh@linux.ibm.com> writes:
> >
> > > On 22/03/17 01:01PM, Sven Schnelle wrote:
> > >> Ritesh Harjani <riteshh@linux.ibm.com> writes:
> > >>
> > >> [    0.958403] Hardware name: IBM 3906 M04 704 (z/VM 7.1.0)
> > >> [    0.958407] Workqueue: eval_map_wq eval_map_work_func
> > >>
> > >> [    0.958446] Krnl PSW : 0704e00180000000 000000000090a9d6 (number+0x25e/0x3c0)
> > >> [    0.958456]            R:0 T:1 IO:1 EX:1 Key:0 M:1 W:0 P:0 AS:3 CC:2 PM:0 RI:0 EA:3
> > >> [    0.958461] Krnl GPRS: 0000000000000058 00000000010de0ac 0000000000000001 00000000fffffffc
> > >> [    0.958467]            0000038000047b80 0affffff010de0ab 0000000000000000 0000000000000000
> > >> [    0.958481]            0000000000000020 0000038000000000 00000000010de0ad 00000000010de0ab
> > >> [    0.958484]            0000000080312100 0000000000e68910 0000038000047b50 0000038000047ab8
> > >> [    0.958494] Krnl Code: 000000000090a9c6: f0c84112b001        srp     274(13,%r4),1(%r11),8
> > >> [    0.958494]            000000000090a9cc: 41202001            la      %r2,1(%r2)
> > >> [    0.958494]           #000000000090a9d0: ecab0006c065        clgrj   %r10,%r11,12,000000000090a9dc
> > >> [    0.958494]           >000000000090a9d6: d200b0004000        mvc     0(1,%r11),0(%r4)
> > >> [    0.958494]            000000000090a9dc: 41b0b001            la      %r11,1(%r11)
> > >> [    0.958494]            000000000090a9e0: a74bffff
> > >>             aghi    %r4,-1
> > >> [    0.958494]            000000000090a9e4: a727fff6            brctg   %r2,000000000090a9d0
> > >> [    0.958494]            000000000090a9e8: a73affff            ahi     %r3,-1
> > >> [    0.958575] Call Trace:
> > >> [    0.958580]  [<000000000090a9d6>] number+0x25e/0x3c0
> > >> [    0.958594] ([<0000000000289516>] update_event_printk+0xde/0x200)
> > >> [    0.958602]  [<0000000000910020>] vsnprintf+0x4b0/0x7c8
> > >> [    0.958606]  [<00000000009103e8>] snprintf+0x40/0x50
> > >> [    0.958610]  [<00000000002893d2>] eval_replace+0x62/0xc8
> > >> [    0.958614]  [<000000000028e2fe>] trace_event_eval_update+0x206/0x248
> > >
> > > This looks like you must have this patch from Steven as well [2].
> > > Although I did test the patch and didn't see such a crash on my qemu box [3].
>
> Indeed, commit b3bc8547d3be ("tracing: Have TRACE_DEFINE_ENUM affect
> trace event types as well") from the ftrace tree is required to
> reproduce this. The ftrace and ext4 changes alone are fine (my initial
> bisect landed on a merge and I did two more bisects to confirm that).
>
> > > [2]: https://lore.kernel.org/linux-ext4/20220310233234.4418186a@gandalf.local.home/
> > > [3]: https://lore.kernel.org/linux-ext4/20220311051249.ltgqbjjothbrkbno@riteshh-domain/
> > >
> > > @Steven,
> > > Sorry to bother. But does this crash strike anything obvious to you?
> >
> > Looking at the oops output again made me realizes that the snprintf
> > tries to write into pages that are mapped RO. Talking to Heiko he
> > mentioned that s390 maps rodata/text RO when setting up the initial
> > mapping while x86 has a RW mapping in the beginning and changes that
> > later to RO. I haven't verified that, but that might be a reason why it
> > works on x86.
>
> For what it's worth, this is reproducible on all of my x86 boxes during
> the initial boot on next-20220316 and newer. I am happy to test any
> patches or provide further information as necessary.

Thanks for reporting.

Could you please share your kernel config with which you are seeing this to be
reproducible on x86?

-ritesh

>
> Cheers,
> Nathan
