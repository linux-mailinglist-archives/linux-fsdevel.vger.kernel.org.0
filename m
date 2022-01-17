Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA68949090B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Jan 2022 13:55:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232769AbiAQMzn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Jan 2022 07:55:43 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59096 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231817AbiAQMzm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Jan 2022 07:55:42 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20HBQrZS025608;
        Mon, 17 Jan 2022 12:55:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=CkASMsmwEYSolLJ7pG9vlaH2mvv7u0v0wJ6jHkpBeDs=;
 b=nVLoW5xneElv+Mt/ADhFIPrYy39RkCVnj4iME+z31dX9SGoBWMS37NG7fgJHOfW0XwUT
 uU3Wv5PIwFj0XfHcJJX7tRTn6YkzSGO94RCcUmz11J4rsAfkXUJnGKIMS76ssvR1xFEx
 MO7b9Ddvx9CG5IqnKhCgC8Ro0ru64/v/nsspfFWQ92YXLSCmmi5T0qFU0mvDZGXPOEra
 8nB+l30Y3NaglsQrxZX/KZuvv9bG9Dc6jOobjUVi5kNoFnia9I5SG9Kds1Oc5Nvix7D9
 YYuqaV4Qh2F/RFXgDpg+OW110CnLpAmJ0hjCs+PJCg2tVKM/t73JNijF+7GrGR2LkYgH ng== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dn7kchnqj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Jan 2022 12:55:34 +0000
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 20HCnaEO030137;
        Mon, 17 Jan 2022 12:55:33 GMT
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dn7kchnph-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Jan 2022 12:55:33 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 20HCmwT8004761;
        Mon, 17 Jan 2022 12:55:31 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma02fra.de.ibm.com with ESMTP id 3dknw8u9xx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Jan 2022 12:55:31 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 20HCtSCk42598680
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Jan 2022 12:55:28 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6B63942052;
        Mon, 17 Jan 2022 12:55:28 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 062B64203F;
        Mon, 17 Jan 2022 12:55:28 +0000 (GMT)
Received: from localhost (unknown [9.43.45.117])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 17 Jan 2022 12:55:27 +0000 (GMT)
Date:   Mon, 17 Jan 2022 18:25:27 +0530
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jan Kara <jack@suse.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>, tytso@mit.edu,
        Eric Whitney <enwlinux@gmail.com>
Subject: Re: [PATCH 6/6] jbd2: No need to use t_handle_lock in
 jbd2_journal_wait_updates
Message-ID: <20220117125527.ienv3drg5whiryrr@riteshh-domain>
References: <cover.1642044249.git.riteshh@linux.ibm.com>
 <e7e0f8c54306591a3a9c8fead1e0e54358052ab6.1642044249.git.riteshh@linux.ibm.com>
 <20220113112749.d5tfszcksvxvshnn@quack3.lan>
 <20220113123842.3rpfcyecylt5n3wo@riteshh-domain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220113123842.3rpfcyecylt5n3wo@riteshh-domain>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: xNKPlpjXXLplU7r88mPjbr2Mc_yc3TxR
X-Proofpoint-GUID: FUayAf0vj_PZfm9QuwHJcrPqYUgtZMzo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-17_05,2022-01-14_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 mlxscore=0 impostorscore=0 spamscore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1015 mlxlogscore=999
 adultscore=0 bulkscore=0 malwarescore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201170080
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 22/01/13 06:08PM, Ritesh Harjani wrote:
> On 22/01/13 12:27PM, Jan Kara wrote:
> > On Thu 13-01-22 08:56:29, Ritesh Harjani wrote:
> > > Since jbd2_journal_wait_updates() uses waitq based on t_updates atomic_t
> > > variable. So from code review it looks like we don't need to use
> > > t_handle_lock spinlock for checking t_updates value.
> > > Hence this patch gets rid of the spinlock protection in
> > > jbd2_journal_wait_updates()
> > >
> > > Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
> >
> > This patch looks good. Feel free to add:
> >
> > Reviewed-by: Jan Kara <jack@suse.cz>
> >
> > Actually looking at it, t_handle_lock seems to be very much unused. I agree

Thanks Jan for your help in this.
I have dropped this patch from v2 in order to discuss few more things and I felt
killing t_handle_lock completely can be sent in a seperate patch series.


>
> I too had this thought in mind. Thanks for taking a deeper look into it :)
>
> >
> > we don't need it when waiting for outstanding handles but the only
> > remaining uses are:
> >
> > 1) jbd2_journal_extend() where it is not needed either - we use
> > atomic_add_return() to manipulate t_outstanding_credits and hold
> > j_state_lock for reading which provides us enough exclusion.

I looked into jbd2_journal_extend and yes, we don't need t_handle_lock
for updating transaction->t_outstanding_credits, since it already happens with
atomic API calls.

Now I do see we update handle->h_**_credits in that function.
But I think this is per process (based on task_struct, current->journal_info)
and doesn't need a lock protection right?


> >
> > 2) update_t_max_wait() - this is the only valid use of t_handle_lock but we
> > can just switch it to cmpxchg loop with a bit of care. Something like:
> >
> > 	unsigned long old;
> >
> > 	ts = jbd2_time_diff(ts, transaction->t_start);
> > 	old = transaction->t_max_wait;
> > 	while (old < ts)
> > 		old = cmpxchg(&transaction->t_max_wait, old, ts);

I think there might be a simpler and more straight forward way for updating
t_max_wait.

I did look into the t_max_wait logic and where all we are updating it.

t_max_wait is the max wait time in starting (&attaching) a _new_ running
transaction by a handle. Is this understaning correct?
From code I don't see t_max_wait getting updated for the time taken in order
to start the handle by a existing running transaction.

Here is how -
update_t_max_wait() will only update t_max_wait if the
transaction->t_start is after ts
(ts is nothing but when start_this_handle() was called).

1. This means that for transaction->t_start to be greater than ts, it has to be
   the new transaction that gets started right (in start_this_handle() func)?

2. Second place where transaction->t_start is updated is just after the start of
   commit phase 7. But this only means that this transaction has become the
   commit transaction. That means someone has to alloc a new running transaction
   which again is case-1.

Now I think this spinlock was added since multiple processes can start a handle
in parallel and attach a running transaction.

Also this was then moved within CONFIG_JBD2_DEBUG since to avoid spinlock
contention on a SMP system in starting multiple handles by different processes.

Now looking at all of above, I think we can move update_t_max_wait()
inside jbd2_get_transaction() in start_this_handle(). Because that is where
a new transaction will be started and transaction->t_start will be greater then
ts. This also is protected within j_state_lock write_lock, so we don't need
spinlock.

This would also mean that we can move t_max_wait outside of CONFIG_JBD2_DEBUG
and jbd2_journal_enable_debug.

Jan, could you confirm if above understaning is correct and shall I go ahead
with above changes?

-ritesh

> >
> > So perhaps you can add two more patches to remove other t_handle_lock uses
> > and drop it completely.
>
> Thanks for providing the details Jan :)
> Agree with jbd2_journal_extend().





> I did looked a bit around t_max_wait and
> I agree that something like above could work. I will spend some more time around
> that code and will submit those changes together in v2.
>
> -ritesh
>
> >
> > 								Honza
> >
> > > ---
> > >  include/linux/jbd2.h | 4 ----
> > >  1 file changed, 4 deletions(-)
> > >
> > > diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
> > > index 34b051aa9009..9bef47622b9d 100644
> > > --- a/include/linux/jbd2.h
> > > +++ b/include/linux/jbd2.h
> > > @@ -1768,22 +1768,18 @@ static inline void jbd2_journal_wait_updates(journal_t *journal)
> > >  	if (!commit_transaction)
> > >  		return;
> > >
> > > -	spin_lock(&commit_transaction->t_handle_lock);
> > >  	while (atomic_read(&commit_transaction->t_updates)) {
> > >  		DEFINE_WAIT(wait);
> > >
> > >  		prepare_to_wait(&journal->j_wait_updates, &wait,
> > >  					TASK_UNINTERRUPTIBLE);
> > >  		if (atomic_read(&commit_transaction->t_updates)) {
> > > -			spin_unlock(&commit_transaction->t_handle_lock);
> > >  			write_unlock(&journal->j_state_lock);
> > >  			schedule();
> > >  			write_lock(&journal->j_state_lock);
> > > -			spin_lock(&commit_transaction->t_handle_lock);
> > >  		}
> > >  		finish_wait(&journal->j_wait_updates, &wait);
> > >  	}
> > > -	spin_unlock(&commit_transaction->t_handle_lock);
> > >  }
> > >
> > >  /*
> > > --
> > > 2.31.1
> > >
> > --
> > Jan Kara <jack@suse.com>
> > SUSE Labs, CR
