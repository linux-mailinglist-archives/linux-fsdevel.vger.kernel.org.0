Return-Path: <linux-fsdevel+bounces-5755-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0CBA80F9EA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 23:07:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 894E0B20F78
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 22:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64E6B64CDA;
	Tue, 12 Dec 2023 22:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="LmrbNccS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="M5L6V5Gd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29788BC
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 Dec 2023 14:07:40 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id D6FD95C02F9;
	Tue, 12 Dec 2023 17:07:36 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Tue, 12 Dec 2023 17:07:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1702418856;
	 x=1702505256; bh=1AZzWu8QWFD0Hlcti2qIavieZtYkXeNCTw2rbzydD5s=; b=
	LmrbNccSMOzXz0N20BV6gB/sQyHktN1g0sOYl5R/Va1ywzUK98P4JbAftR/pGxZd
	RbVYJabyEwhM2TANcnzmAacuEhOmwSXxZbioYS7VsBv7/Sff2ERGD21DeDHPBp2Y
	un37R4VohebasRgG9dplCp1ED+Ck2o08RLGX9phZH0eGaSf2QvXaTsO7P/XDkFJF
	N+hhVUUhPYiEgh1Bn6sPj9v6X4uZak8L9nneXQ4vBVGCHcM2UaJ0FcxTigdJjEga
	VHkRXEMjp1vD/9h6Ok0Ik8aEPrwFVFixgCrdIlHPhv5VmJkgzWJ0dx4V8WhOhpWY
	18eEZBITYclZpIyeetIRyA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1702418856; x=
	1702505256; bh=1AZzWu8QWFD0Hlcti2qIavieZtYkXeNCTw2rbzydD5s=; b=M
	5L6V5GdJjEFbPKHYNaz6YFZYXairCF3A8z4qmiaxuIB6D9zQvAwsHqkwAw1kbGyL
	/XvPkJ1+x8z2DN5RBXR5U1QNG7Mb1JAEragWlFx504Upb7LfAsG5kxjjmlZOQRPK
	+VmQpsmnp1fWT4E7dNhLQrNlZd/CcHdwqxPg3zam2R9MvCutU6kaDQC0GXwq8q+9
	w+qDVka4PR2jkCqxtX3MUvjGWEpV6AQN/VY4dm9jusb5CPQzFirLam9SJhNAI1GM
	ovfvkSw3HUEhsdokdygkdjvYaCRWeNESzHV8i4M1XtUgBZF3wODWSAMbZfNKfNNF
	5vPwLowzXRpdQSblcUYlg==
X-ME-Sender: <xms:p9l4ZUfCHCdBDnWg3MO8vEhhwdF2qxkRZ7yqvUmJ9AsNdjAK7pLbmA>
    <xme:p9l4ZWOeNHEhHsOIlTObz1zoH1Seiw2u255JCSoS3v-FbxcpwcoLnQae9L0oroKV-
    DAJH87GdPSKnp3l>
X-ME-Received: <xmr:p9l4ZVi6WE7V4EJoZ-fDaKXKJQSmckkut7dY24NX6hNpehwYxk9j1d8OV3dfSJxoZvQRWJu0dCcqbXFdbhgahYBjVqn1MsjjiZsnd-8nPkQpD6izPERY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudelgedgudehfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefkffggfgfuvfevfhfhjggtgfesthekredttddvjeenucfhrhhomhepuegv
    rhhnugcuufgthhhusggvrhhtuceosggvrhhnugdrshgthhhusggvrhhtsehfrghsthhmrg
    hilhdrfhhmqeenucggtffrrghtthgvrhhnpeeutdekieelgeehudekgffhtdduvddugfeh
    leejjeegleeuffeukeehfeehffevleenucffohhmrghinhepghhithhhuhgsrdgtohhmne
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsggvrhhn
    ugdrshgthhhusggvrhhtsehfrghsthhmrghilhdrfhhm
X-ME-Proxy: <xmx:p9l4ZZ_TNXExZ1md8xc2yZqE66OYnzvkqH8b305QpxlDCVD7wGboFw>
    <xmx:p9l4ZQu548RePL4rtSRFJax5nlLZFcFLTENPDRWkMz6AOryFh7FrGg>
    <xmx:p9l4ZQFIQA6lTZjp8YteRqq8hWaeF_KEdYXE2Aegb8YnUjXsJTILYg>
    <xmx:qNl4ZV-H3v5RTMYGUMye8pBNEy1QkS0i9WpU--tnIA_nKoL0LLO2Zg>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 Dec 2023 17:07:34 -0500 (EST)
Message-ID: <2e2f0cd1-99fe-4336-9cc8-47416be02451@fastmail.fm>
Date: Tue, 12 Dec 2023 23:07:32 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] fuse: Rename DIRECT_IO_{RELAX -> ALLOW_MMAP}
Content-Language: en-US, de-DE
To: Amir Goldstein <amir73il@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Tyler Fanelli <tfanelli@redhat.com>,
 linux-fsdevel@vger.kernel.org, mszeredi@redhat.com, gmaglione@redhat.com,
 hreitz@redhat.com, Hao Xu <howeyxu@tencent.com>,
 Dharmendra Singh <dsingh@ddn.com>
References: <20230920024001.493477-1-tfanelli@redhat.com>
 <CAJfpeguuB21HNeiK-2o_5cbGUWBh4uu0AmexREuhEH8JgqDAaQ@mail.gmail.com>
 <abbdf30f-c459-4eab-9254-7b24afc5771b@fastmail.fm>
 <40470070-ef6f-4440-a79e-ff9f3bbae515@fastmail.fm>
 <CAOQ4uxiHkNeV3FUh6qEbqu3U6Ns5v3zD+98x26K9AbXf5m8NGw@mail.gmail.com>
 <e151ff27-bc6e-4b74-a653-c82511b20cee@fastmail.fm>
 <47310f64-5868-4990-af74-1ce0ee01e7e9@fastmail.fm>
 <CAOQ4uxhqkJsK-0VRC9iVF5jHuEQaVJK+XXYE0kL81WmVdTUDZg@mail.gmail.com>
 <0008194c-8446-491a-8e4c-1a9a087378e1@fastmail.fm>
 <CAOQ4uxhucqtjycyTd=oJF7VM2VQoe6a-vJWtWHRD5ewA+kRytw@mail.gmail.com>
 <8e76fa9c-59d0-4238-82cf-bfdf73b5c442@fastmail.fm>
 <CAOQ4uxjKbQkqTHb9_3kqRW7BPPzwNj--4=kqsyq=7+ztLrwXfw@mail.gmail.com>
 <6e9e8ff6-1314-4c60-bf69-6d147958cf95@fastmail.fm>
 <CAOQ4uxiJfcZLvkKZxp11aAT8xa7Nxf_kG4CG1Ft2iKcippOQXg@mail.gmail.com>
 <06eedc60-e66b-45d1-a936-2a0bb0ac91c7@fastmail.fm>
 <CAOQ4uxhRbKz7WvYKbjGNo7P7m+00KLW25eBpqVTyUq2sSY6Vmw@mail.gmail.com>
From: Bernd Schubert <bernd.schubert@fastmail.fm>
In-Reply-To: <CAOQ4uxhRbKz7WvYKbjGNo7P7m+00KLW25eBpqVTyUq2sSY6Vmw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 12/12/23 19:30, Amir Goldstein wrote:
> On Sat, Dec 9, 2023 at 12:38 AM Bernd Schubert
> <bernd.schubert@fastmail.fm> wrote:
>>
>>
>>
>> On 12/8/23 21:46, Amir Goldstein wrote:
>>> On Fri, Dec 8, 2023 at 9:50 PM Bernd Schubert
>>> <bernd.schubert@fastmail.fm> wrote:
>>>>
>>>>
>>>>
>>>> On 12/8/23 09:39, Amir Goldstein wrote:
>>>>> On Thu, Dec 7, 2023 at 8:38 PM Bernd Schubert
>>>>> <bernd.schubert@fastmail.fm> wrote:
>>>>>>
>>>>>>
>>>>>>
>>>>>> On 12/7/23 08:39, Amir Goldstein wrote:
>>>>>>> On Thu, Dec 7, 2023 at 1:28 AM Bernd Schubert
>>>>>>> <bernd.schubert@fastmail.fm> wrote:
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>> On 12/6/23 09:25, Amir Goldstein wrote:
>>>>>>>>>>>> Is it actually important for FUSE_DIRECT_IO_ALLOW_MMAP fs
>>>>>>>>>>>> (e.g. virtiofsd) to support FOPEN_PARALLEL_DIRECT_WRITES?
>>>>>>>>>>>> I guess not otherwise, the combination would have been tested.
>>>>>>>>>>>
>>>>>>>>>>> I'm not sure how many people are aware of these different flags/features.
>>>>>>>>>>> I had just finalized the backport of the related patches to RHEL8 on
>>>>>>>>>>> Friday, as we (or our customers) need both for different jobs.
>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>> FOPEN_PARALLEL_DIRECT_WRITES is typically important for
>>>>>>>>>>>> network fs and FUSE_DIRECT_IO_ALLOW_MMAP is typically not
>>>>>>>>>>>> for network fs. Right?
>>>>>>>>>>>
>>>>>>>>>>> We kind of have these use cases for our network file systems
>>>>>>>>>>>
>>>>>>>>>>> FOPEN_PARALLEL_DIRECT_WRITES:
>>>>>>>>>>>          - Traditional HPC, large files, parallel IO
>>>>>>>>>>>          - Large file used on local node as container for many small files
>>>>>>>>>>>
>>>>>>>>>>> FUSE_DIRECT_IO_ALLOW_MMAP:
>>>>>>>>>>>          - compilation through gcc (not so important, just not nice when it
>>>>>>>>>>> does not work)
>>>>>>>>>>>          - rather recent: python libraries using mmap _reads_. As it is read
>>>>>>>>>>> only no issue of consistency.
>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> These jobs do not intermix - no issue as in generic/095. If such
>>>>>>>>>>> applications really exist, I have no issue with a serialization penalty.
>>>>>>>>>>> Just disabling FOPEN_PARALLEL_DIRECT_WRITES because other
>>>>>>>>>>> nodes/applications need FUSE_DIRECT_IO_ALLOW_MMAP is not so nice.
>>>>>>>>>>>
>>>>>>>>>>> Final goal is also to have FOPEN_PARALLEL_DIRECT_WRITES to work on plain
>>>>>>>>>>> O_DIRECT and not only for FUSE_DIRECT_IO - I need to update this branch
>>>>>>>>>>> and post the next version
>>>>>>>>>>> https://github.com/bsbernd/linux/commits/fuse-dio-v4
>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> In the mean time I have another idea how to solve
>>>>>>>>>>> FOPEN_PARALLEL_DIRECT_WRITES + FUSE_DIRECT_IO_ALLOW_MMAP
>>>>>>>>>>
>>>>>>>>>> Please find attached what I had in my mind. With that generic/095 is not
>>>>>>>>>> crashing for me anymore. I just finished the initial coding - it still
>>>>>>>>>> needs a bit cleanup and maybe a few comments.
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>> Nice. I like the FUSE_I_CACHE_WRITES state.
>>>>>>>>> For FUSE_PASSTHROUGH I will need to track if inode is open/mapped
>>>>>>>>> in caching mode, so FUSE_I_CACHE_WRITES can be cleared on release
>>>>>>>>> of the last open file of the inode.
>>>>>>>>>
>>>>>>>>> I did not understand some of the complexity here:
>>>>>>>>>
>>>>>>>>>>             /* The inode ever got page writes and we do not know for sure
>>>>>>>>>>              * in the DIO path if these are pending - shared lock not possible */
>>>>>>>>>>             spin_lock(&fi->lock);
>>>>>>>>>>             if (!test_bit(FUSE_I_CACHE_WRITES, &fi->state)) {
>>>>>>>>>>                     if (!(*cnt_increased)) {
>>>>>>>>>
>>>>>>>>> How can *cnt_increased be true here?
>>>>>>>>
>>>>>>>> I think you missed the 2nd entry into this function, when the shared
>>>>>>>> lock was already taken?
>>>>>>>
>>>>>>> Yeh, I did.
>>>>>>>
>>>>>>>> I have changed the code now to have all
>>>>>>>> complexity in this function (test, lock, retest with lock, release,
>>>>>>>> wakeup). I hope that will make it easier to see the intention of the
>>>>>>>> code. Will post the new patches in the morning.
>>>>>>>>
>>>>>>>
>>>>>>> Sounds good. Current version was a bit hard to follow.
>>>>>>>
>>>>>>>>
>>>>>>>>>
>>>>>>>>>>                             fi->shared_lock_direct_io_ctr++;
>>>>>>>>>>                             *cnt_increased = true;
>>>>>>>>>>                     }
>>>>>>>>>>                     excl_lock = false;
>>>>>>>>>
>>>>>>>>> Seems like in every outcome of this function
>>>>>>>>> *cnt_increased = !excl_lock
>>>>>>>>> so there is not need for out arg cnt_increased
>>>>>>>>
>>>>>>>> If excl_lock would be used as input - yeah, would have worked as well.
>>>>>>>> Or a parameter like "retest-under-lock". Code is changed now to avoid
>>>>>>>> going in and out.
>>>>>>>>
>>>>>>>>>
>>>>>>>>>>             }
>>>>>>>>>>             spin_unlock(&fi->lock);
>>>>>>>>>>
>>>>>>>>>> out:
>>>>>>>>>>             if (excl_lock && *cnt_increased) {
>>>>>>>>>>                     bool wake = false;
>>>>>>>>>>                     spin_lock(&fi->lock);
>>>>>>>>>>                     if (--fi->shared_lock_direct_io_ctr == 0)
>>>>>>>>>>                             wake = true;
>>>>>>>>>>                     spin_unlock(&fi->lock);
>>>>>>>>>>                     if (wake)
>>>>>>>>>>                             wake_up(&fi->direct_io_waitq);
>>>>>>>>>>             }
>>>>>>>>>
>>>>>>>>> I don't see how this wake_up code is reachable.
>>>>>>>>>
>>>>>>>>> TBH, I don't fully understand the expected result.
>>>>>>>>> Surely, the behavior of dio mixed with mmap is undefined. Right?
>>>>>>>>> IIUC, your patch does not prevent dirtying page cache while dio is in
>>>>>>>>> flight. It only prevents writeback while dio is in flight, which is the same
>>>>>>>>> behavior as with exclusive inode lock. Right?
>>>>>>>>
>>>>>>>> Yeah, thanks. I will add it in the patch description.
>>>>>>>>
>>>>>>>> And there was actually an issue with the patch, as cache flushing needs
>>>>>>>> to be initiated before doing the lock decision, fixed now.
>>>>>>>>
>>>>>>>
>>>>>>> I thought there was, because of the wait in fuse_send_writepage()
>>>>>>> but wasn't sure if I was following the flow correctly.
>>>>>>>
>>>>>>>>>
>>>>>>>>> Maybe this interaction is spelled out somewhere else, but if not
>>>>>>>>> better spell it out for people like me that are new to this code.
>>>>>>>>
>>>>>>>> Sure, thanks a lot for your helpful comments!
>>>>>>>>
>>>>>>>
>>>>>>> Just to be clear, this patch looks like a good improvement and
>>>>>>> is mostly independent of the "inode caching mode" and
>>>>>>> FOPEN_CACHE_MMAP idea that I suggested.
>>>>>>>
>>>>>>> The only thing that my idea changes is replacing the
>>>>>>> FUSE_I_CACHE_WRITES state with a FUSE_I_CACHE_IO_MODE
>>>>>>> state, which is set earlier than FUSE_I_CACHE_WRITES
>>>>>>> on caching file open or first direct_io mmap and unlike
>>>>>>> FUSE_I_CACHE_WRITES, it is cleared on the last file close.
>>>>>>>
>>>>>>> FUSE_I_CACHE_WRITES means that caching writes happened.
>>>>>>> FUSE_I_CACHE_IO_MODE means the caching writes and reads
>>>>>>> may happen.
>>>>>>>
>>>>>>> FOPEN_PARALLEL_DIRECT_WRITES obviously shouldn't care
>>>>>>> about "caching reads may happen", but IMO that is a small trade off
>>>>>>> to make for maintaining the same state for
>>>>>>> "do not allow parallel dio" and "do not allow passthrough open".
>>>>>>
>>>>>> I think the attached patches should do, it now also unsets
>>>>>
>>>>> IMO, your patch is still more complicated than it should be.
>>>>> There is no need for the complicated retest state machine.
>>>>> If you split the helpers to:
>>>>>
>>>>> bool exclusive_lock fuse_dio_wr_needs_exclusive_lock();
>>>>> ...
>>>>> fuse_dio_lock_inode(iocb, &exclusive);
>>>>> ...
>>>>> fuse_dio_unlock_inode(iocb, &exclusive);
>>>>>
>>>>> Then you only need to test FUSE_I_CACHE_IO_MODE in
>>>>> fuse_dio_wr_needs_exclusive_lock()
>>>>> and you only need to increment shared_lock_direct_io_ctr
>>>>> after taking shared lock and re-testing FUSE_I_CACHE_IO_MODE.
>>>>
>>>> Hmm, I'm not sure.
>>>>
>>>> I changed fuse_file_mmap() to call this function
>>>>
>>>> /*
>>>>     * direct-io with shared locks cannot handle page cache io - set an inode
>>>>     * flag to disable shared locks and wait until remaining threads are done
>>>>     */
>>>> static void fuse_file_mmap_handle_dio_writers(struct inode *inode)
>>>> {
>>>>           struct fuse_inode *fi = get_fuse_inode(inode);
>>>>
>>>>           spin_lock(&fi->lock);
>>>>           set_bit(FUSE_I_CACHE_IO_MODE, &fi->state);
>>>>           while (fi->shared_lock_direct_io_ctr > 0) {
>>>>                   spin_unlock(&fi->lock);
>>>>                   wait_event_interruptible(fi->direct_io_waitq,
>>>>                                            fi->shared_lock_direct_io_ctr == 0);
>>>>                   spin_lock(&fi->lock);
>>>>           }
>>>>           spin_unlock(&fi->lock);
>>>> }
>>>>
>>>>
>>>> Before we had indeed a race. Idea for fuse_file_mmap_handle_dio_writers()
>>>> and fuse_dio_lock_inode() is to either have FUSE_I_CACHE_IO_MODE set,
>>>> or fi->shared_lock_direct_io_ctr is greater 0, but that requires that
>>>> FUSE_I_CACHE_IO_MODE is checked for when fi->lock is taken.
>>>>
>>>>
>>>> I'm going to think about over the weekend if your suggestion
>>>> to increase fi->shared_lock_direct_io_ctr only after taking the shared
>>>> lock is possible. Right now I don't see how to do that.
>>>>
>>>>
>>>>>
>>>>>> FUSE_I_CACHE_IO_MODE. Setting the flag actually has to be done from
>>>>>> fuse_file_mmap (and not from fuse_send_writepage) to avoid a dead stall,
>>>>>> but that aligns with passthrough anyway?
>>>>>
>>>>> Yes.
>>>>>
>>>>> I see that shared_lock_direct_io_ctr is checked without lock or barriers
>>>>> in and the wait_event() should be interruptible.
>>>>
>>>> Thanks, fixed with the function above.
>>>>
>>>>> I am also not sure if it breaks any locking order for mmap because
>>>>> the task that is going to wake it up is holding the shared inode lock...
>>>>
>>>> The waitq has its own lock. We have
>>>>
>>>> fuse_file_mmap - called under some mmap lock, waitq lock
>>>>
>>>> fuse_dio_lock_inode: no lock taken before calling wakeup
>>>>
>>>> fuse_direct_write_iter: wakeup after release of all locks
>>>>
>>>> So I don't think we have a locker issue (lockdep also doesn't annotate
>>>> anything).
>>>
>>> I don't think that lockdep can understand this dependency.
>>>
>>>> What we definitely cannot do it to take the inode i_rwsem lock in fuse_file_mmap
>>>>
>>>
>>> It's complicated. I need to look at the whole thing again.
>>>
>>>>>
>>>>> While looking at this code, the invalidate_inode_pages2() looks suspicious.
>>>>> If inode is already in FUSE_I_CACHE_IO_MODE when performing
>>>>> another mmap, doesn't that have potential for data loss?
>>>>> (even before your patch I mean)
>>>>>
>>>>>> Amir, right now it only sets
>>>>>> FUSE_I_CACHE_IO_MODE for VM_MAYWRITE. Maybe you could add a condition
>>>>>> for passthrough there?
>>>>>>
>>>>>
>>>>> We could add a condition, but I don't think that we should.
>>>>> I think we should refrain from different behavior when it is not justified.
>>>>> I think it is not justified to allow parallel dio if any file is open in
>>>>> caching mode on the inode and any mmap (private or shared)
>>>>> exists on the inode.
>>>>>
>>>>> That means that FUSE_I_CACHE_IO_MODE should be set on
>>>>> any mmap, and already on open for non direct_io files.
>>>>
>>>> Ok, I can change and add that. Doing it in open is definitely needed
>>>> for O_DIRECT (in my other dio branch).
>>>>
>>>
>>> Good, the more common code the better.
>>>
>>>>>
>>>>> Mixing caching and direct io on the same inode is hard as it is
>>>>> already and there is no need to add complexity by allowing
>>>>> parallel dio in that case. IMO it wins us nothing.
>>>>
>>>> So the slight issue I see are people like me, who check the content
>>>> of a file during a long running computation. Like an HPC application
>>>> is doing some long term runs. Then in the middle of
>>>> the run the user wants to see the current content of the file and
>>>> reads it - if that is done through mmap (and from a node that runs
>>>> the application), parallel DIO is disabled with the current patch
>>>> until the file is closed - I see the use case to check for writes.
>>>>
>>>
>>> That's what I thought.
>>>
>>>>
>>>>>
>>>>> The FUSE_I_CACHE_IO_MODE could be cleared on last file
>>>>> close (as your patch did) but it could be cleared earlier if
>>>>> instead of tracking refcount of open file, we track refcount of
>>>>> files open in caching mode or mmaped, which is what the
>>>>> FOPEN_MMAP_CACHE flag I suggested is for.
>>>>
>>>> But how does open() know that a file/fd is used for mmap?
>>>>
>>>
>>> Because what I tried to suggest is a trick/hack:
>>> first mmap on direct_io file sets FOPEN_MMAP_CACHE on the file
>>> and bumps the cached_opens on the inode as if file was
>>> opened in caching mode or in FOPEN_MMAP_CACHE mode.
>>> When the file that was used for mmap is closed and all the rest
>>> of the open files have only ever been used for direct_io, then
>>> inode exists the caching io mode.
>>>
>>> Using an FOPEN flag for that is kind of a hack.
>>> We could add an internal file state bits for that as well,
>>> but my thinking was that FOPEN_MMAP_CACHE could really
>>> be set by the server to mean per-file ALLOW_MMAP instead of
>>> the per-filesystem ALLOW_MMAP. Not sure if that will be useful.
>>
>> Ok, I will try to add that in a different patch to have better
>> visibility. Will also put these patch here in front of my dio branch and
>> rebase these patches. There comes in a bit additional complexity to
>> handle O_DIRECT, but it also consolidates direct-IO writes code paths.
>> At least I hope this is still possible with the new changes.
>>
>>>
>>> Sorry for the hand waving. I was trying to send out a demo
>>> patch that explains it better, but got caught up with other things.
>>
>> No problem at all, I think I know what you mean and I can try add this
>> myself.
> 
> Here is what I was thinking about:
> 
> https://github.com/amir73il/linux/commits/fuse_io_mode
> 
> The concept that I wanted to introduce was the
> fuse_inode_deny_io_cache()/fuse_inode_allow_io_cache()
> helpers (akin to deny_write_access()/allow_write_access()).
> 
> In this patch, parallel dio in progress deny open in caching mode
> and mmap, and I don't know if that is acceptable.
> Technically, instead of deny open/mmap you can use additional
> techniques to wait for in progress dio and allow caching open/mmap.
> 
> Anyway, I plan to use the iocachectr and fuse_inode_deny_io_cache()
> pattern when file is open in FOPEN_PASSTHROUGH mode, but
> in this case, as agreed with Miklos, a server trying to mix open
> in caching mode on the same inode is going to fail the open.
> 
> mmap is less of a problem for inode in passthrough mode, because
> mmap in of direct_io file and inode in passthrough mode is passthrough
> mmap to backing file.
> 
> Anyway, if you can use this patch or parts of it, be my guest and if you
> want to use a different approach that is fine by me as well - in that case
> I will just remove the fuse_file_shared_dio_{start,end}() part from my patch.

Thanks Amir, I'm going to look at it in detail in the morning.
Btw, there is another bad direct_io_allow_mmap issue (part of it is 
invalidate_inode_pages2, which you already noticed, but not alone). 
Going to send out the patch once xfstests have passed
https://github.com/bsbernd/linux/commit/3dae6b05854c4fe84302889a5625c7e5428cdd6c


Thanks,
Bernd

