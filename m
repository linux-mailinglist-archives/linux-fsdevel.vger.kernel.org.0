Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 758174D580F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Mar 2022 03:20:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345624AbiCKCVF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Mar 2022 21:21:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbiCKCVE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Mar 2022 21:21:04 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 152DBE7295;
        Thu, 10 Mar 2022 18:20:02 -0800 (PST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22B0qq4l006454;
        Fri, 11 Mar 2022 02:19:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=pp1;
 bh=37tZB/h1OGXntK7cKdvA6HUgfzgD4TtLCAM+x/8ESjs=;
 b=LpwGS4u0S74V+KPcgLji1eaf3Z3KYgDt11Bw63jJKTOJ+O0jRbdCEvoJJbG8guE5Z3uN
 TxC004odY6NIafhylBZByaCVZPO6z9t1AsnBQGAY5Ru3yGBC1Y3OVOW+BXDyCTxggdD7
 EqNbxybZt8ZJ1qUWlAlXN6kD+RuShGUonG1NSEBwSIGIEpWa6b0TjFxDPbju8BcUinWS
 t/FMkrCkMJy1j7OsshPGbCjBekMEjVM6Ojn5irTtR7W2s57hT6hC7mf4fNOjHu1bIdL1
 hbOYLHz6atqcEbtXZnx94KEIzVRp3zilVfnoEvswce0Ul6XS+Uyomdit40xLWb3U26O5 Ww== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3eqs91vgaa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Mar 2022 02:19:39 +0000
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 22B28VHi030412;
        Fri, 11 Mar 2022 02:19:38 GMT
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3eqs91vg9q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Mar 2022 02:19:38 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 22B29Chm022642;
        Fri, 11 Mar 2022 02:19:35 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma03fra.de.ibm.com with ESMTP id 3enpk2ycrt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Mar 2022 02:19:35 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 22B2JX6o46727508
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Mar 2022 02:19:33 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 23B354C046;
        Fri, 11 Mar 2022 02:19:33 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A85484C040;
        Fri, 11 Mar 2022 02:19:32 +0000 (GMT)
Received: from localhost (unknown [9.43.36.239])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 11 Mar 2022 02:19:32 +0000 (GMT)
Date:   Fri, 11 Mar 2022 07:49:31 +0530
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-ext4@vger.kernel.org, Jan Kara <jack@suse.cz>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2 00/10] ext4: Improve FC trace events
Message-ID: <20220311021931.d4oozgtefbalrcch@riteshh-domain>
References: <cover.1646922487.git.riteshh@linux.ibm.com>
 <20220310110553.431cc997@gandalf.local.home>
 <20220310170731.hq6z6flycmgkhnaa@riteshh-domain>
 <20220310193936.38ae7754@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220310193936.38ae7754@gandalf.local.home>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: P9n4uAWT-Ekz8KYE67bBpD3aHkMTXOUT
X-Proofpoint-ORIG-GUID: q3pE0Pm_7TEAECMoa4QEXUqZLoSod8TD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-10_09,2022-03-09_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 adultscore=0 clxscore=1015 mlxlogscore=999 spamscore=0
 mlxscore=0 impostorscore=0 phishscore=0 malwarescore=0 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203110010
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 22/03/10 07:39PM, Steven Rostedt wrote:
> On Thu, 10 Mar 2022 22:37:31 +0530
> Ritesh Harjani <riteshh@linux.ibm.com> wrote:
>
> > On 22/03/10 11:05AM, Steven Rostedt wrote:
> > > On Thu, 10 Mar 2022 21:28:54 +0530
> > > Ritesh Harjani <riteshh@linux.ibm.com> wrote:
> > >
> > > > Note:- I still couldn't figure out how to expose EXT4_FC_REASON_MAX=
 in patch-2
> > > > which (I think) might be (only) needed by trace-cmd or perf record =
for trace_ext4_fc_stats.
> > > > But it seems "cat /sys/kernel/debug/tracing/trace_pipe" gives the r=
ight output
> > > > for ext4_fc_stats trace event (as shown below).
> > > >
> > > > So with above reasoning, do you think we should take these patches =
in?
> > > > And we can later see how to provide EXT4_FC_REASON_MAX definition a=
vailable to
> > > > libtraceevent?
> > >
> > > I don't see EXT4_FC_REASON_MAX being used in the TP_printk(). If it i=
sn't
> > > used there, it doesn't need to be exposed. Or did I miss something?
> >
> > I was mentioning about EXT4_FC_REASON_MAX used in TP_STRUCT__entry.
> > When I hard code EXT4_FC_REASON_MAX to 9 in TP_STRUCT__entry, I could
> > see proper values using trace-cmd. Otherwise I see all 0 (when using tr=
ace-cmd
> > or perf record).
> >
> > +	TP_STRUCT__entry(
> > +		__field(dev_t, dev)
> > +		__array(unsigned int, fc_ineligible_rc, EXT4_FC_REASON_MAX)
>
> Ah, I bet it's showing up in the format portion and not the print fmt part
> of the format file.
>
> Just to confirm, can you do the following:
>
> # cat /sys/kernel/tracing/events/ext4/ext4_fc_commit_stop/format

I think you meant ext4_fc_stats.

>
> and show me what it outputs.

root@qemu:/home/qemu# cat /sys/kernel/tracing/events/ext4/ext4_fc_stats/for=
mat
name: ext4_fc_stats
ID: 986
format:
        field:unsigned short common_type;       offset:0;       size:2; sig=
ned:0;
        field:unsigned char common_flags;       offset:2;       size:1; sig=
ned:0;
        field:unsigned char common_preempt_count;       offset:3;       siz=
e:1; signed:0;
        field:int common_pid;   offset:4;       size:4; signed:1;

        field:dev_t dev;        offset:8;       size:4; signed:0;
        field:unsigned int fc_ineligible_rc[EXT4_FC_REASON_MAX];        off=
set:12;      size:36;        signed:0;
        field:unsigned long fc_commits; offset:48;      size:8; signed:0;
        field:unsigned long fc_ineligible_commits;      offset:56;      siz=
e:8; signed:0;
        field:unsigned long fc_numblks; offset:64;      size:8; signed:0;

print fmt: "dev %d,%d fc ineligible reasons:
%s:%u, %s:%u, %s:%u, %s:%u, %s:%u, %s:%u, %s:%u, %s:%u, %s:%u num_commits:%=
lu, ineligible: %lu, numblks: %lu", ((unsigned int) ((REC->dev) >> 20)), ((=
unsigned int) ((REC->dev) & ((1U << 20) - 1))), __print_symbolic(0, { 0, "X=
ATTR"}, { 1, "CROSS_RENAME"}, { 2, "JOURNAL_FLAG_CHANGE"}, { 3, "NO_MEM"}, =
{ 4, "SWAP_BOOT"}, { 5, "RESIZE"}, { 6, "RENAME_DIR"}, { 7, "FALLOC_RANGE"}=
, { 8, "INODE_JOURNAL_DATA"}), REC->fc_ineligible_rc[0], __print_symbolic(1=
, { 0, "XATTR"}, { 1, "CROSS_RENAME"}, { 2, "JOURNAL_FLAG_CHANGE"}, { 3, "N=
O_MEM"}, { 4, "SWAP_BOOT"}, { 5, "RESIZE"}, { 6, "RENAME_DIR"}, { 7, "FALLO=
C_RANGE"}, { 8, "INODE_JOURNAL_DATA"}), REC->fc_ineligible_rc[1], __print_s=
ymbolic(2, { 0, "XATTR"}, { 1, "CROSS_RENAME"}, { 2, "JOURNAL_FLAG_CHANGE"}=
, { 3, "NO_MEM"}, { 4, "SWAP_BOOT"}, { 5, "RESIZE"}, { 6, "RENAME_DIR"}, { =
7, "FALLOC_RANGE"}, { 8, "INODE_JOURNAL_DATA"}), REC->fc_ineligible_rc[2], =
__print_symbolic(3, { 0, "XATTR"}, { 1, "CROSS_RENAME"}, { 2, "JOURNAL_FLAG=
_CHANGE"}, { 3, "NO_MEM"}, { 4, "SWAP_BOOT"}, { 5, "RESIZE"}, { 6, "RENAME_=
DIR"}, { 7, "FALLOC_RANGE"}, { 8, "INODE_JOURNAL_DATA"}), REC->fc_ineligibl=
e_rc[3], __print_symbolic(4, { 0, "XATTR"}, { 1, "CROSS_RENAME"}, { 2, "JOU=
RNAL_FLAG_CHANGE"}, { 3, "NO_MEM"}, { 4, "SWAP_BOOT"}, { 5, "RESIZE"}, { 6,=
 "RENAME_DIR"}, { 7, "FALLOC_RANGE"}, { 8, "INODE_JOURNAL_DATA"}), REC->fc_=
ineligible_rc[4], __print_symbolic(5, { 0, "XATTR"}, { 1, "CROSS_RENAME"}, =
{ 2, "JOURNAL_FLAG_CHANGE"}, { 3, "NO_MEM"}, { 4, "SWAP_BOOT"}, { 5, "RESIZ=
E"}, { 6, "RENAME_DIR"}, { 7, "FALLOC_RANGE"}, { 8, "INODE_JOURNAL_DATA"}),=
 REC->fc_ineligible_rc[5], __print_symbolic(6, { 0, "XATTR"}, { 1, "CROSS_R=
ENAME"}, { 2, "JOURNAL_FLAG_CHANGE"}, { 3, "NO_MEM"}, { 4, "SWAP_BOOT"}, { =
5, "RESIZE"}, { 6, "RENAME_DIR"}, { 7, "FALLOC_RANGE"}, { 8, "INODE_JOURNAL=
_DATA"}), REC->fc_ineligible_rc[6], __print_symbolic(7, { 0, "XATTR"}, { 1,=
 "CROSS_RENAME"}, { 2, "JOURNAL_FLAG_CHANGE"}, { 3, "NO_MEM"}, { 4, "SWAP_B=
OOT"}, { 5, "RESIZE"}, { 6, "RENAME_DIR"}, { 7, "FALLOC_RANGE"}, { 8, "INOD=
E_JOURNAL_DATA"}), REC->fc_ineligible_rc[7], __print_symbolic(8, { 0, "XATT=
R"}, { 1, "CROSS_RENAME"}, { 2, "JOURNAL_FLAG_CHANGE"}, { 3, "NO_MEM"}, { 4=
, "SWAP_BOOT"}, { 5, "RESIZE"}, { 6, "RENAME_DIR"}, { 7, "FALLOC_RANGE"}, {=
 8, "INODE_JOURNAL_DATA"}), REC->fc_ineligible_rc[8], REC->fc_commits, REC-=
>fc_ineligible_commits, REC->fc_numblks


output of ext4_fc_stats (FALLOC_RANGE:0 v/s FALLOC_RANGE:13)
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
<perf-report or trace-cmd report>
          xfs_io  8336 [003] 42950.923784:        ext4:ext4_fc_stats: dev 7=
,2 fc ineligible reasons:
XATTR:0, CROSS_RENAME:0, JOURNAL_FLAG_CHANGE:0, NO_MEM:0, SWAP_BOOT:0, RESI=
ZE:0, RENAME_DIR:0, FALLOC_RANGE:0, INODE_JOURNAL_DATA:0 num_commits:22, in=
eligible: 12, numblks: 22



<cat /sys/kernel/debug/tracing/trace_pipe>
          xfs_io-8336    [003] ..... 42951.224155: ext4_fc_stats: dev 7,2 f=
c ineligible reasons:
XATTR:0, CROSS_RENAME:0, JOURNAL_FLAG_CHANGE:0, NO_MEM:0, SWAP_BOOT:0, RESI=
ZE:0, RENAME_DIR:0, FALLOC_RANGE:13, INODE_JOURNAL_DATA:0 num_commits:22, i=
neligible: 12, numblks: 22


Thanks
-ritesh


>
> Thanks,
>
> -- Steve
>
>
> >
> > Should we anyway hard code this to 9. Since we are anyway printing all =
the
> > 9 elements of array values individually.
> >
> > +	TP_printk("dev %d,%d fc ineligible reasons:\n"
> > +		  "%s:%u, %s:%u, %s:%u, %s:%u, %s:%u, %s:%u, %s:%u, %s:%u, %s:%u "
> > +		  "num_commits:%lu, ineligible: %lu, numblks: %lu",
> > +		  MAJOR(__entry->dev), MINOR(__entry->dev),
> > +		  FC_REASON_NAME_STAT(EXT4_FC_REASON_XATTR),
> > +		  FC_REASON_NAME_STAT(EXT4_FC_REASON_CROSS_RENAME),
> > +		  FC_REASON_NAME_STAT(EXT4_FC_REASON_JOURNAL_FLAG_CHANGE),
> > +		  FC_REASON_NAME_STAT(EXT4_FC_REASON_NOMEM),
> > +		  FC_REASON_NAME_STAT(EXT4_FC_REASON_SWAP_BOOT),
> > +		  FC_REASON_NAME_STAT(EXT4_FC_REASON_RESIZE),
> > +		  FC_REASON_NAME_STAT(EXT4_FC_REASON_RENAME_DIR),
> > +		  FC_REASON_NAME_STAT(EXT4_FC_REASON_FALLOC_RANGE),
> > +		  FC_REASON_NAME_STAT(EXT4_FC_REASON_INODE_JOURNAL_DATA),
> > +		  __entry->fc_commits, __entry->fc_ineligible_commits,
> > +		  __entry->fc_numblks)
> >
> >
> > Thanks
> > -ritesh
>
