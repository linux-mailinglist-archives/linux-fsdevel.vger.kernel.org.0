Return-Path: <linux-fsdevel+bounces-75654-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oGpjKPIzeWmlvwEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75654-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 22:53:54 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A85A89AD62
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 22:53:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 195463007219
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 21:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D1B4331A45;
	Tue, 27 Jan 2026 21:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R3RRU1ZZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 268262FD1DC;
	Tue, 27 Jan 2026 21:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769550829; cv=none; b=uEpb1xIKGOE7w4zoXejk8mPrCXkMgCYI9GrFb1Gz5Zowl9qaja8Df6QrJmiVow02I2on25c9MrtT9nsBU5q8mn+RrXt/JGt8EbXX/FHji0l96J0nRypXcQH9g/zvbPtFrkdPu4IgMyHJAPWLAUzkv7AEDumuaXXk1gI83P7sWHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769550829; c=relaxed/simple;
	bh=76dzUGkmRdjj1WTAhi8X4gYK6ZRkswlhU84j2d4MsJs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qNMlefzwHVpjLOicsYiw6jMmEjYIJOY8G8iXwynA3qK+h/qzVHQWgiy6KqjfkVqYAb6sUqcSGAd+KygFHHtqh3T6amrlK/ATjbl+FETnKTiTrnWs0J5bI1EntxaQkug0EaPY4oPet6J+VhVsB2dBo8lZY+/Pp0FGm19dyp73PHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R3RRU1ZZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D012C116C6;
	Tue, 27 Jan 2026 21:53:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769550828;
	bh=76dzUGkmRdjj1WTAhi8X4gYK6ZRkswlhU84j2d4MsJs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=R3RRU1ZZl9vpn0RfEUJ+dpip7rtp9gxrlcVOFwEKNUjDX1xAyIiwy6L+CyoeCxR6u
	 XVxVWCBLfmTGd2UKI+WW7g9is/gm8R0Lq4BJnRFBjGbuTHEozZgcQaNh5NIk8RelNe
	 vvzdkAVxWgiRBuseUa7Ms7FOkHgWkJD8FhFB+5dqKUd60UdxB/muwXUBbnJVBBagzc
	 igZuxQAxA+z7RbYfSGWCjNCfaJM5vAs3w84R54Gcl5kpTsCtDwNocEAJQBI+niHKnE
	 uf3IkGKkYkMzJSX1f/vVVbURQEvm8nxnjn+Y8I1L0DZTcUkhDynhZB17iQWvi0sDQC
	 Y8BmIf2BJCylg==
Message-ID: <050225b0-1cf4-4a6c-ab49-7427db70ae7c@kernel.org>
Date: Tue, 27 Jan 2026 16:53:36 -0500
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/1] NFSD: Enforce Timeout on Layout Recall and
 Integrate Lease Manager Fencing
To: Dai Ngo <dai.ngo@oracle.com>, Chuck Lever <chuck.lever@oracle.com>,
 Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
 Olga Kornievskaia <okorniev@redhat.com>, Tom Talpey <tom@talpey.com>,
 Christoph Hellwig <hch@lst.de>, Alexander Aring <alex.aring@gmail.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org
References: <20260127005013.552805-1-dai.ngo@oracle.com>
 <88a3edc5-4928-4235-a555-a7017d5ca502@app.fastmail.com>
 <d8040fde-ccdd-443c-928a-9bff93641294@oracle.com>
From: Chuck Lever <cel@kernel.org>
Content-Language: en-US
Organization: kernel.org
In-Reply-To: <d8040fde-ccdd-443c-928a-9bff93641294@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75654-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_TO(0.00)[oracle.com,kernel.org,brown.name,redhat.com,talpey.com,lst.de,gmail.com,zeniv.linux.org.uk,suse.cz];
	HAS_ORG_HEADER(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,oracle.com:email]
X-Rspamd-Queue-Id: A85A89AD62
X-Rspamd-Action: no action

On 1/27/26 3:36 PM, Dai Ngo wrote:
> 
> On 1/27/26 9:11 AM, Chuck Lever wrote:
>>
>> On Mon, Jan 26, 2026, at 7:50 PM, Dai Ngo wrote:
>>> When a layout conflict triggers a recall, enforcing a timeout is
>>> necessary to prevent excessive nfsd threads from being blocked in
>>> __break_lease ensuring the server continues servicing incoming
>>> requests efficiently.
>>>
>>> This patch introduces a new function to lease_manager_operations:
>>>
>>> lm_breaker_timedout: Invoked when a lease recall times out and is
>>> about to be disposed of. This function enables the lease manager
>>> to inform the caller whether the file_lease should remain on the
>>> flc_list or be disposed of.
>>>
>>> For the NFSD lease manager, this function now handles layout recall
>>> timeouts. If the layout type supports fencing and the client has not
>>> been fenced, a fence operation is triggered to prevent the client
>>> from accessing the block device.
>>>
>>> While the fencing operation is in progress, the conflicting file_lease
>>> remains on the flc_list until fencing is complete. This guarantees
>>> that no other clients can access the file, and the client with
>>> exclusive access is properly blocked before disposal.
>>>
>>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>>> ---
>>>   Documentation/filesystems/locking.rst |  2 +
>>>   fs/locks.c                            | 10 +++-
>>>   fs/nfsd/blocklayout.c                 | 38 ++++++-------
>>>   fs/nfsd/nfs4layouts.c                 | 79 +++++++++++++++++++++++++--
>>>   fs/nfsd/nfs4state.c                   |  1 +
>>>   fs/nfsd/state.h                       |  6 ++
>>>   include/linux/filelock.h              |  1 +
>>>   7 files changed, 110 insertions(+), 27 deletions(-)
>>>
>>> v2:
>>>      . Update Subject line to include fencing operation.
>>>      . Allow conflicting lease to remain on flc_list until fencing
>>>        is complete.
>>>      . Use system worker to perform fencing operation asynchronously.
>>>      . Use nfs4_stid.sc_count to ensure layout stateid remains
>>>        valid before starting the fencing operation, nfs4_stid.sc_count
>>>        is released after fencing operation is complete.
>>>      . Rework nfsd4_scsi_fence_client to:
>>>           . wait until fencing to complete before exiting.
>>>           . wait until fencing in progress to complete before
>>>             checking the NFSD_MDS_PR_FENCED flag.
>>>      . Remove lm_need_to_retry from lease_manager_operations.
>>> v3:
>>>      . correct locking requirement in locking.rst.
>>>      . add max retry count to fencing operation.
>>>      . add missing nfs4_put_stid in nfsd4_layout_fence_worker.
>>>      . remove special-casing of FL_LAYOUT in lease_modify.
>>>      . remove lease_want_dispose.
>>>      . move lm_breaker_timedout call to time_out_leases.
>>> v4:
>>>      . only increment ls_fence_retry_cnt after successfully
>>>        schedule new work in nfsd4_layout_lm_breaker_timedout.
>>>
>>> diff --git a/Documentation/filesystems/locking.rst
>>> b/Documentation/filesystems/locking.rst
>>> index 04c7691e50e0..a339491f02e4 100644
>>> --- a/Documentation/filesystems/locking.rst
>>> +++ b/Documentation/filesystems/locking.rst
>>> @@ -403,6 +403,7 @@ prototypes::
>>>       bool (*lm_breaker_owns_lease)(struct file_lock *);
>>>           bool (*lm_lock_expirable)(struct file_lock *);
>>>           void (*lm_expire_lock)(void);
>>> +        void (*lm_breaker_timedout)(struct file_lease *);
>>>
>>>   locking rules:
>>>
>>> @@ -417,6 +418,7 @@ lm_breaker_owns_lease:    yes        
>>> no            no
>>>   lm_lock_expirable    yes        no            no
>>>   lm_expire_lock        no        no            yes
>>>   lm_open_conflict    yes        no            no
>>> +lm_breaker_timedout     yes             no                      no
>>>   ======================    =============    =================   
>>> =========
>>>
>>>   buffer_head
>>> diff --git a/fs/locks.c b/fs/locks.c
>>> index 46f229f740c8..1b63aa704598 100644
>>> --- a/fs/locks.c
>>> +++ b/fs/locks.c
>>> @@ -1524,6 +1524,7 @@ static void time_out_leases(struct inode *inode,
>>> struct list_head *dispose)
>>>   {
>>>       struct file_lock_context *ctx = inode->i_flctx;
>>>       struct file_lease *fl, *tmp;
>>> +    bool remove = true;
>>>
>>>       lockdep_assert_held(&ctx->flc_lock);
>>>
>>> @@ -1531,8 +1532,13 @@ static void time_out_leases(struct inode *inode,
>>> struct list_head *dispose)
>>>           trace_time_out_leases(inode, fl);
>>>           if (past_time(fl->fl_downgrade_time))
>>>               lease_modify(fl, F_RDLCK, dispose);
>>> -        if (past_time(fl->fl_break_time))
>>> -            lease_modify(fl, F_UNLCK, dispose);
>>> +
>>> +        if (past_time(fl->fl_break_time)) {
>>> +            if (fl->fl_lmops && fl->fl_lmops->lm_breaker_timedout)
>>> +                remove = fl->fl_lmops->lm_breaker_timedout(fl);
>>> +            if (remove)
>>> +                lease_modify(fl, F_UNLCK, dispose);
>>> +        }
>>>       }
>>>   }
>>>
>>> diff --git a/fs/nfsd/blocklayout.c b/fs/nfsd/blocklayout.c
>>> index 7ba9e2dd0875..69d3889df302 100644
>>> --- a/fs/nfsd/blocklayout.c
>>> +++ b/fs/nfsd/blocklayout.c
>>> @@ -443,6 +443,14 @@ nfsd4_scsi_proc_layoutcommit(struct inode *inode,
>>> struct svc_rqst *rqstp,
>>>       return nfsd4_block_commit_blocks(inode, lcp, iomaps, nr_iomaps);
>>>   }
>>>
>>> +/*
>>> + * Perform the fence operation to prevent the client from accessing the
>>> + * block device. If a fence operation is already in progress, wait for
>>> + * it to complete before checking the NFSD_MDS_PR_FENCED flag. Once the
>>> + * operation is complete, check the flag. If NFSD_MDS_PR_FENCED is set,
>>> + * update the layout stateid by setting the ls_fenced flag to indicate
>>> + * that the client has been fenced.
>>> + */
>>>   static void
>>>   nfsd4_scsi_fence_client(struct nfs4_layout_stateid *ls, struct
>>> nfsd_file *file)
>>>   {
>>> @@ -450,31 +458,23 @@ nfsd4_scsi_fence_client(struct
>>> nfs4_layout_stateid *ls, struct nfsd_file *file)
>>>       struct block_device *bdev = file->nf_file->f_path.mnt->mnt_sb-
>>> >s_bdev;
>>>       int status;
>>>
>>> -    if (nfsd4_scsi_fence_set(clp, bdev->bd_dev))
>>> +    mutex_lock(&clp->cl_fence_mutex);
>>> +    if (nfsd4_scsi_fence_set(clp, bdev->bd_dev)) {
>>> +        ls->ls_fenced = true;
>>> +        mutex_unlock(&clp->cl_fence_mutex);
>>> +        nfs4_put_stid(&ls->ls_stid);
>>>           return;
>>> +    }
>>>
>>>       status = bdev->bd_disk->fops->pr_ops->pr_preempt(bdev,
>>> NFSD_MDS_PR_KEY,
>>>               nfsd4_scsi_pr_key(clp),
>>>               PR_EXCLUSIVE_ACCESS_REG_ONLY, true);
>>> -    /*
>>> -     * Reset to allow retry only when the command could not have
>>> -     * reached the device. Negative status means a local error
>>> -     * (e.g., -ENOMEM) prevented the command from being sent.
>>> -     * PR_STS_PATH_FAILED, PR_STS_PATH_FAST_FAILED, and
>>> -     * PR_STS_RETRY_PATH_FAILURE indicate transport path failures
>>> -     * before device delivery.
>>> -     *
>>> -     * For all other errors, the command may have reached the device
>>> -     * and the preempt may have succeeded. Avoid resetting, since
>>> -     * retrying a successful preempt returns PR_STS_IOERR or
>>> -     * PR_STS_RESERVATION_CONFLICT, which would cause an infinite
>>> -     * retry loop.
>>> -     */
>>> -    if (status < 0 ||
>>> -        status == PR_STS_PATH_FAILED ||
>>> -        status == PR_STS_PATH_FAST_FAILED ||
>>> -        status == PR_STS_RETRY_PATH_FAILURE)
>>> +    if (status)
>>>           nfsd4_scsi_fence_clear(clp, bdev->bd_dev);
>>> +    else
>>> +        ls->ls_fenced = true;
>> The removed code distinguishes retryable errors (such as path failures)
>> from permanent errors (PR_STS_IOERR, PR_STS_RESERVATION_CONFLICT), but
>> the new code clears the fence on any error,
> 
> In v2 and v3 patch, I left the comment and the code distinguishes retryable
> errors intact. And you commented this:
> 
>> In nfsd4_scsi_fence_client(), when a device error occurs (e.g.,
>> PR_STS_IOERR), ls->ls_fenced is set even though the client may
>> still have storage access.
> 
> So I'm not sure how to treat permanent errors now. Please advise.

The comment is important and explains some of the subtleties. I think
that needs to be preserved even if we decide to set ls_fenced in every
error case.

If the correct behavior now is to leave ls_fenced clear in all error
cases, then something in the patch needs to provide the rationale for
making this code change and for helping us remember the design when it
needs to be altered or fixed later.

The rationale is different for permanent errors and temporary errors,
I would think.


>>   potentially causing infinite
>> retry loops as warned in the removed comment.
> 
> Infinite loops can not happen due to the maximum retry count.

Fine, but with the new retry escape clause, as mentioned below, the
server and client can be left in opposite states, it looks like: One
believes the fence succeeded, and one believes it still has full device
access. Am I incorrect about that?

This is the bane of every timeout-based scheme I know about, and why we
have the "hard" mount option.


>> Either the comment and error distinction should remain,
> 
> As mentioned above, I can put the comment and code that distinguishes
> temporarily error codes back. Then what do we need to do for other
> permanent errors; PR_STS_IOERR, PR_STS_RESERVATION_CONFLICT?
> 
>>   or some rationale
>> for removing the distinction between temporary and permanent errors
>> should
>> be added to the commit message.
>>
>>
>>> +    mutex_unlock(&clp->cl_fence_mutex);
>>> +    nfs4_put_stid(&ls->ls_stid);
>>>
>>>       trace_nfsd_pnfs_fence(clp, bdev->bd_disk->disk_name, status);
>>>   }
>>> diff --git a/fs/nfsd/nfs4layouts.c b/fs/nfsd/nfs4layouts.c
>>> index ad7af8cfcf1f..1c498f3cd059 100644
>>> --- a/fs/nfsd/nfs4layouts.c
>>> +++ b/fs/nfsd/nfs4layouts.c
>>> @@ -222,6 +222,29 @@ nfsd4_layout_setlease(struct nfs4_layout_stateid
>>> *ls)
>>>       return 0;
>>>   }
>>>
>>> +static void
>>> +nfsd4_layout_fence_worker(struct work_struct *work)
>>> +{
>>> +    struct nfsd_file *nf;
>>> +    struct delayed_work *dwork = to_delayed_work(work);
>>> +    struct nfs4_layout_stateid *ls = container_of(dwork,
>>> +            struct nfs4_layout_stateid, ls_fence_work);
>>> +    u32 type;
>>> +
>>> +    rcu_read_lock();
>>> +    nf = nfsd_file_get(ls->ls_file);
>>> +    rcu_read_unlock();
>>> +    if (!nf) {
>>> +        nfs4_put_stid(&ls->ls_stid);
>>> +        return;
>>> +    }
>>> +
>>> +    type = ls->ls_layout_type;
>>> +    if (nfsd4_layout_ops[type]->fence_client)
>>> +        nfsd4_layout_ops[type]->fence_client(ls, nf);
>>> +    nfsd_file_put(nf);
>>> +}
>>> +
>>>   static struct nfs4_layout_stateid *
>>>   nfsd4_alloc_layout_stateid(struct nfsd4_compound_state *cstate,
>>>           struct nfs4_stid *parent, u32 layout_type)
>>> @@ -271,6 +294,10 @@ nfsd4_alloc_layout_stateid(struct
>>> nfsd4_compound_state *cstate,
>>>       list_add(&ls->ls_perfile, &fp->fi_lo_states);
>>>       spin_unlock(&fp->fi_lock);
>>>
>>> +    INIT_DELAYED_WORK(&ls->ls_fence_work, nfsd4_layout_fence_worker);
>>> +    ls->ls_fenced = false;
>>> +    ls->ls_fence_retry_cnt = 0;
>>> +
>>>       trace_nfsd_layoutstate_alloc(&ls->ls_stid.sc_stateid);
>>>       return ls;
>>>   }
>>> @@ -708,9 +735,10 @@ nfsd4_cb_layout_done(struct nfsd4_callback *cb,
>>> struct rpc_task *task)
>>>           rcu_read_unlock();
>>>           if (fl) {
>>>               ops = nfsd4_layout_ops[ls->ls_layout_type];
>>> -            if (ops->fence_client)
>>> +            if (ops->fence_client) {
>>> +                refcount_inc(&ls->ls_stid.sc_count);
>>>                   ops->fence_client(ls, fl);
>>> -            else
>>> +            } else
>>>                   nfsd4_cb_layout_fail(ls, fl);
>>>               nfsd_file_put(fl);
>>>           }
>>> @@ -747,11 +775,9 @@ static bool
>>>   nfsd4_layout_lm_break(struct file_lease *fl)
>>>   {
>>>       /*
>>> -     * We don't want the locks code to timeout the lease for us;
>>> -     * we'll remove it ourself if a layout isn't returned
>>> -     * in time:
>>> +     * Enforce break lease timeout to prevent NFSD
>>> +     * thread from hanging in __break_lease.
>>>        */
>>> -    fl->fl_break_time = 0;
>>>       nfsd4_recall_file_layout(fl->c.flc_owner);
>>>       return false;
>>>   }
>>> @@ -782,10 +808,51 @@ nfsd4_layout_lm_open_conflict(struct file *filp,
>>> int arg)
>>>       return 0;
>>>   }
>>>
>>> +/**
>>> + * nfsd4_layout_lm_breaker_timedout - The layout recall has timed out.
>> Nit: Move the description of @fl here.
> 
> Fix in v5.
> 
>>
>>> + * If the layout type supports a fence operation, schedule a worker to
>>> + * fence the client from accessing the block device.
>>> + *
>>> + * @fl: file to check
>>> + *
>>> + * Return true if the file lease should be disposed of by the caller;
>>> + * otherwise, return false.
>>> + */
>>> +static bool
>>> +nfsd4_layout_lm_breaker_timedout(struct file_lease *fl)
>>> +{
>>> +    struct nfs4_layout_stateid *ls = fl->c.flc_owner;
>>> +    bool ret;
>>> +
>>> +    if (!nfsd4_layout_ops[ls->ls_layout_type]->fence_client)
>>> +        return true;
>>> +    if (ls->ls_fenced || ls->ls_fence_retry_cnt >= LO_MAX_FENCE_RETRY)
>>> +        return true;
>> Since these two variables are accessed while the fence mutex
>> is held in other places, they need similar protection here
>> to prevent races. You explained that the mutex cannot be
>> taken here, so some other form of serialization will be
>> needed to protect these fields.
> 
> I do not think we need protection here to access ls_fenced and
> ls_fence_retry_cnt. For ls_fenced, it's a read operation from
> nfsd4_layout_lm_breaker_timedout. The value is either true or
> false, it does not matter. If it's true then the device was
> fenced. If it's not true then nfsd4_layout_lm_breaker_timedout
> will be called again from time_out_leases on next check.

Fair enough for ls_fence_retry_cnt, but are you sure there isn't a
TOCTOU issue here for ls_fenced ? Isn't there a race possible with
the server receiving the client's callback while lm_breaker_timeout
is running?


> ls_fence_retry_cnt is incremented and checked only by
> nfsd4_layout_lm_breaker_timedout.

Then the kdoc comment could be clearer that only one copy of the
callback is allowed to run concurrently. Something like "Caller
serializes".


>> If I'm reading this correctly, when the fence fails after all
>> 5 retries, the client retains block device access but server
>> believes recall succeeded ?
> 
> What should we do if the maximum retries is reached, perhaps a
> warning message in the system log for the admin to take action?

A warning doesn't seem like it would prevent data corruption. (I'm
not against a warning, in and of itself... it just does not seem to
me to be sufficient).

I would really like this mechanism to be more data-safe. It needs to
deal properly with network partitions and other problems. I don't have
any magic answer yet, sorry!


>>> +
>>> +    if (work_busy(&ls->ls_fence_work.work))
>>> +        return false;
>>> +    /* Schedule work to do the fence operation */
>>> +    ret = mod_delayed_work(system_dfl_wq, &ls->ls_fence_work, 0);
>>> +    if (!ret) {
>>> +        /*
>>> +         * If there is no pending work, mod_delayed_work queues
>>> +         * new task. While fencing is in progress, a reference
>>> +         * count is added to the layout stateid to ensure its
>>> +         * validity. This reference count is released once fencing
>>> +         * has been completed.
>>> +         */
>>> +        refcount_inc(&ls->ls_stid.sc_count);
>>> +        ++ls->ls_fence_retry_cnt;
>>> +        return true;
>>> +    }
>> Incrementing after the mod_delayed_work() call is racy. Instead:
>>
>> refcount_inc(&ls->ls_stid.sc_count);
>> ret = mod_delayed_work(system_dfl_wq, &ls->ls_fence_work, 0);
>> if (ret) {
>>      refcount_dec(&ls->ls_stid.sc_count);
>>      ....
>> }
> 
> Yes, it's racy, I thought about this. But we can not just do a
> refcount_dec here, we need to do nfs4_put_stid. But we can not
> do nfs4_put_stid here since nfsd4_layout_lm_breaker_timedout runs
> under the spin_lock flc_lock and nfs4_put_stid might causes the
> flc_lock to be acquired again from generic_delete_lease if this
> is the last reference count on stid.
> 
> We might need to add the reference count when the file_lease is
> inserted on the flc_list and decrement when it's removed from the
> flc_list. I need to think about this more.

If I may, why is flc_lock being held? That seems to be the root of
several implementation problems.


>>> +    return false;
>>> +}
>>> +
>>>   static const struct lease_manager_operations nfsd4_layouts_lm_ops = {
>>>       .lm_break        = nfsd4_layout_lm_break,
>>>       .lm_change        = nfsd4_layout_lm_change,
>>>       .lm_open_conflict    = nfsd4_layout_lm_open_conflict,
>>> +    .lm_breaker_timedout    = nfsd4_layout_lm_breaker_timedout,
>>>   };
>>>
>>>   int
>>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>>> index 583c13b5aaf3..a57fa3318362 100644
>>> --- a/fs/nfsd/nfs4state.c
>>> +++ b/fs/nfsd/nfs4state.c
>>> @@ -2385,6 +2385,7 @@ static struct nfs4_client *alloc_client(struct
>>> xdr_netobj name,
>>>   #endif
>>>   #ifdef CONFIG_NFSD_SCSILAYOUT
>>>       xa_init(&clp->cl_dev_fences);
>>> +    mutex_init(&clp->cl_fence_mutex);
>>>   #endif
>>>       INIT_LIST_HEAD(&clp->async_copies);
>>>       spin_lock_init(&clp->async_lock);
>>> diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
>>> index 713f55ef6554..57e54dfb406c 100644
>>> --- a/fs/nfsd/state.h
>>> +++ b/fs/nfsd/state.h
>>> @@ -529,6 +529,7 @@ struct nfs4_client {
>>>       time64_t        cl_ra_time;
>>>   #ifdef CONFIG_NFSD_SCSILAYOUT
>>>       struct xarray        cl_dev_fences;
>>> +    struct mutex        cl_fence_mutex;
>>>   #endif
>>>   };
>>>
>>> @@ -738,8 +739,13 @@ struct nfs4_layout_stateid {
>>>       stateid_t            ls_recall_sid;
>>>       bool                ls_recalled;
>>>       struct mutex            ls_mutex;
>>> +    struct delayed_work        ls_fence_work;
>> Still missing cancel_delayed_work_sync() when freeing the
>> layout stateid.
> 
> I don't think the layout stateid can be freed while a fence
> worker was scheduled due to the added reference count to the
> stid.

Then add a comment to that effect, or if possible, some kind of
assertion, in nfsd4_free_layout_stateid().


>>> +    bool                ls_fenced;
>>> +    int                ls_fence_retry_cnt;
>>>   };
>>>
>>> +#define    LO_MAX_FENCE_RETRY        5
>> The value of 5 needs some justification here in a comment.
>> Actually, 5 might be too low, but I can't really tell.
> 
> At the minimal each retry happens after 1 sec, and it can be
> more depending what entry is at the front of flc_list. So if
> retry for 5 seconds (minimum) is too low then is 20 retries is
> sufficient?

As I said above: here's why we have the "hard" mount option for NFS. It
might be impossible to choose a safe maximum retry count and still
guarantee that the server and clients will eventually agree on the
device reservation state. In that case we will need to consider some
other mechanism for detecting and preventing infinite PR retry loops.

Maybe the retry maximum could depend on the lease expiry time?


Just remember, I'm thinking about this and learning as I go along,
just like you are. I know I'm possibly contradicting myself here.


-- 
Chuck Lever

