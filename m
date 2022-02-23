Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBFA54C0FE3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Feb 2022 11:12:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239458AbiBWKMj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Feb 2022 05:12:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236386AbiBWKMi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Feb 2022 05:12:38 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D31245AE4;
        Wed, 23 Feb 2022 02:12:11 -0800 (PST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21N8iV6w031267;
        Wed, 23 Feb 2022 10:12:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=U/uQdpDpvq4vwR4icPHzwoQg4Ya0ouZfsKzU0wXX/UU=;
 b=Sllh3uTCCyhWpSBi0ndluRRs6t4gKXcel/N+looGvb2EAmH4VQ3ncTlh+NFO+RvKGqZ4
 vofldxajCY/brpd4TdklRTv9LkQ29kydiDwTjUtQgP1ezXEVSu+cxpXvNo+BRDiI+US0
 CRkfHukdl3XHc+5rSJ4ottjkyS5mHaZlAzBZw1jiskLFLb+iLH5o+E2M61yBzA8YS2zO
 ZohVnhLLn2zOupOH/jZ96R4SaWMS36UjfGqNAb/uIIpuRrjfe6yHOarcCGqbj6ymHRHt
 ourRl/aTQtGTpAFVmA1AOPcvsBJc3SyqL3XJVMYzWhRhGKX7XNgxGlekmaEyMIea4jLx wQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ede6snk5m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Feb 2022 10:12:06 +0000
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 21N9jTSx021009;
        Wed, 23 Feb 2022 10:12:06 GMT
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ede6snk4y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Feb 2022 10:12:06 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 21NA96WA012950;
        Wed, 23 Feb 2022 10:12:03 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma01fra.de.ibm.com with ESMTP id 3ear697f62-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Feb 2022 10:12:03 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 21NAC1Dn45744632
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Feb 2022 10:12:01 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6839A42041;
        Wed, 23 Feb 2022 10:12:01 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EE6C442054;
        Wed, 23 Feb 2022 10:12:00 +0000 (GMT)
Received: from localhost (unknown [9.43.55.101])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 23 Feb 2022 10:12:00 +0000 (GMT)
Date:   Wed, 23 Feb 2022 15:41:59 +0530
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-ext4@vger.kernel.org,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        "Theodore Ts'o" <tytso@mit.edu>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC 3/9] ext4: Add couple of more fast_commit tracepoints
Message-ID: <20220223101159.ekwbylvbmec5v35q@riteshh-domain>
References: <cover.1645558375.git.riteshh@linux.ibm.com>
 <90608d31b7ad8500c33d875d3a7fa50e3456dc1a.1645558375.git.riteshh@linux.ibm.com>
 <20220223094057.53zcovnazrqwbngw@quack3.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220223094057.53zcovnazrqwbngw@quack3.lan>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Cq1uarU9SNPTSa9xV7AuPib1rkMvtpGB
X-Proofpoint-ORIG-GUID: U0auvqnAZsGbi0WpngfEyqq8OgvInQjU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-02-23_03,2022-02-21_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 phishscore=0 impostorscore=0 mlxlogscore=525
 clxscore=1015 mlxscore=0 malwarescore=0 adultscore=0 suspectscore=0
 spamscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2201110000 definitions=main-2202230052
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 22/02/23 10:40AM, Jan Kara wrote:
> On Wed 23-02-22 02:04:11, Ritesh Harjani wrote:
> > This adds two more tracepoints for ext4_fc_track_template() &
> > ext4_fc_cleanup() which are helpful in debugging some fast_commit issues.
> >
> > Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
>
> So why is this more useful than trace_ext4_fc_track_range() and other
> tracepoints? I don't think it provides any more information? What am I
> missing?

Thanks Jan for all the reviews.

So ext4_fc_track_template() adds almost all required information
(including the caller info) in this one trace point along with transaction tid
which is useful for tracking issue similar to what is mentioned in Patch-9.

(race with if inode is part of two transactions tid where jbd2 full commit
may begin for txn n-1 while inode is still in sbi->s_fc_q[MAIN])

And similarly ext4_fc_cleanup() helps with that information about which tid
completed and whether it was called from jbd2 full commit or from fast_commit.

-ritesh

>
> 								Honza
>
> > ---
> >  fs/ext4/fast_commit.c       |  3 ++
> >  include/trace/events/ext4.h | 67 +++++++++++++++++++++++++++++++++++++
> >  2 files changed, 70 insertions(+)
> >
> > diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
> > index 5ac594e03402..bf70879bb4fe 100644
> > --- a/fs/ext4/fast_commit.c
> > +++ b/fs/ext4/fast_commit.c
> > @@ -386,6 +386,8 @@ static int ext4_fc_track_template(
> >  	if (ext4_test_mount_flag(inode->i_sb, EXT4_MF_FC_INELIGIBLE))
> >  		return -EINVAL;
> >
> > +	trace_ext4_fc_track_template(handle, inode, __fc_track_fn, enqueue);
> > +
> >  	tid = handle->h_transaction->t_tid;
> >  	mutex_lock(&ei->i_fc_lock);
> >  	if (tid == ei->i_sync_tid) {
> > @@ -1241,6 +1243,7 @@ static void ext4_fc_cleanup(journal_t *journal, int full, tid_t tid)
> >  	if (full && sbi->s_fc_bh)
> >  		sbi->s_fc_bh = NULL;
> >
> > +	trace_ext4_fc_cleanup(journal, full, tid);
> >  	jbd2_fc_release_bufs(journal);
> >
> >  	spin_lock(&sbi->s_fc_lock);
> > diff --git a/include/trace/events/ext4.h b/include/trace/events/ext4.h
> > index 17fb9c506e8a..cd09dccea502 100644
> > --- a/include/trace/events/ext4.h
> > +++ b/include/trace/events/ext4.h
> > @@ -2855,6 +2855,73 @@ TRACE_EVENT(ext4_fc_track_range,
> >  		      __entry->end)
> >  	);
> >
> > +TRACE_EVENT(ext4_fc_track_template,
> > +	TP_PROTO(handle_t *handle, struct inode *inode,
> > +		 void *__fc_track_fn, int enqueue),
> > +
> > +	TP_ARGS(handle, inode, __fc_track_fn, enqueue),
> > +
> > +	TP_STRUCT__entry(
> > +		__field(dev_t, dev)
> > +		__field(tid_t, t_tid)
> > +		__field(ino_t, i_ino)
> > +		__field(tid_t, i_sync_tid)
> > +		__field(void *, __fc_track_fn)
> > +		__field(int, enqueue)
> > +		__field(bool, jbd2_ongoing)
> > +		__field(bool, fc_ongoing)
> > +	),
> > +
> > +	TP_fast_assign(
> > +		struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
> > +		struct ext4_inode_info *ei = EXT4_I(inode);
> > +
> > +		__entry->dev = inode->i_sb->s_dev;
> > +		__entry->t_tid = handle->h_transaction->t_tid;
> > +		__entry->i_ino = inode->i_ino;
> > +		__entry->i_sync_tid = ei->i_sync_tid;
> > +		__entry->__fc_track_fn = __fc_track_fn;
> > +		__entry->enqueue = enqueue;
> > +		__entry->jbd2_ongoing =
> > +		    sbi->s_journal->j_flags & JBD2_FULL_COMMIT_ONGOING;
> > +		__entry->fc_ongoing =
> > +		    sbi->s_journal->j_flags & JBD2_FAST_COMMIT_ONGOING;
> > +	),
> > +
> > +	TP_printk("dev %d,%d, t_tid %u, ino %lu, i_sync_tid %u, "
> > +		  "track_fn %pS, enqueue %d, jbd2_ongoing %d, fc_ongoing %d",
> > +		  MAJOR(__entry->dev), MINOR(__entry->dev),
> > +		  __entry->t_tid, __entry->i_ino, __entry->i_sync_tid,
> > +		  (void *)__entry->__fc_track_fn, __entry->enqueue,
> > +		  __entry->jbd2_ongoing, __entry->fc_ongoing)
> > +	);
> > +
> > +TRACE_EVENT(ext4_fc_cleanup,
> > +	TP_PROTO(journal_t *journal, int full, tid_t tid),
> > +
> > +	TP_ARGS(journal, full, tid),
> > +
> > +	TP_STRUCT__entry(
> > +		__field(dev_t, dev)
> > +		__field(int, j_fc_off)
> > +		__field(int, full)
> > +		__field(tid_t, tid)
> > +	),
> > +
> > +	TP_fast_assign(
> > +		struct super_block *sb = journal->j_private;
> > +
> > +		__entry->dev = sb->s_dev;
> > +		__entry->j_fc_off = journal->j_fc_off;
> > +		__entry->full = full;
> > +		__entry->tid = tid;
> > +	),
> > +
> > +	TP_printk("dev %d,%d, j_fc_off %d, full %d, tid %u",
> > +		  MAJOR(__entry->dev), MINOR(__entry->dev),
> > +		  __entry->j_fc_off, __entry->full, __entry->tid)
> > +	);
> > +
> >  TRACE_EVENT(ext4_update_sb,
> >  	TP_PROTO(struct super_block *sb, ext4_fsblk_t fsblk,
> >  		 unsigned int flags),
> > --
> > 2.31.1
> >
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
