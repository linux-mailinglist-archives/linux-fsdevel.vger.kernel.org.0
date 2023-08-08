Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B2FB773B59
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Aug 2023 17:49:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbjHHPtM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Aug 2023 11:49:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbjHHPrj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Aug 2023 11:47:39 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B852F1703
        for <linux-fsdevel@vger.kernel.org>; Tue,  8 Aug 2023 08:41:39 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id EF9305C00A2;
        Tue,  8 Aug 2023 10:36:13 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Tue, 08 Aug 2023 10:36:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
        cc:cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm3; t=
        1691505373; x=1691591773; bh=XjacS93x1Dz9rYBOne5ihDMuzjpzcsouW7E
        3E2bz/tE=; b=Z0ELOOrMUINvFF83Pp6URwraPiTiWDLq4kmQsejAS0D7rpCiuXF
        +1PNQM6v52FEwPoAGSvHr5IOyQify24rpa0pKFGbqI4Skaa+t/TsmR1NOZGfQf/v
        cdF2uK8hw2pzK2fTJpygSt4+9j4s6zG6vddmvkQZhHvehGpPS4HcxNvGPgs1tksK
        tiH8b4LN36pGJqYj9Oy2i542BCuLPlSIynDhU95tqLEdk4hROGzYIRjE48ulwOUE
        O2+DHlvAyzJD1gY6xzd0eKQjox6RF3ZAe0wOyIt5rS7FR6ELtMKNMHgNBCxuCcj5
        Mi9u1UzQLPcO8tTCu9eUElQv36XeN9qnneQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1691505373; x=1691591773; bh=XjacS93x1Dz9rYBOne5ihDMuzjpzcsouW7E
        3E2bz/tE=; b=TZw7krh9qJY3UsRh50d0V6ubZV5OXTtpz2WaozE8Xc7DYl9uaSE
        QRzvyWS+1FSUXSaLSajNP6Fu6kC+e4MRmhCmQNJeGN/nlQ4PupDSUiNtu5F/VBZq
        mhoWcFgonn8Mkmgr+yTOvA9l3qSZuzyIXgAB52ciFZtkZjdTUbd8RTtbK9AbE5qV
        JB7CrCWwRL9itcKPxWJK13FZ79OG+Lc11wVU7hqDiWk8DjndiWI0/AHpQJRC+Rpo
        vjvpk62W88EYnXIPVdPlYu/ISOSPhilQfHhahy4u3mhVDKK9JzHw4JVmmvfnrVok
        ZcZyYc0DVxX0UUaj6/JUqPR38k1fA557/lw==
X-ME-Sender: <xms:3VLSZK6WIb26-69tf59FaMT_jixwyxFnwT6qO0Ct2gojsGXJOUj_MA>
    <xme:3VLSZD6YC8kPGy0425gcviZTR3BMwJy9PMLuSrsZwngwfWlC44FsWlDX7uSDodLg5
    52Y2oWqTghRZoG1>
X-ME-Received: <xmr:3VLSZJfePxkPi63KZzjUze5WMqiV_9s4wQ2D7xX_HIoHGqpCFGOKfCgPGW4hOlux9n5M1ZX3Dz4q-U-0UscgnSTmRTQN-_ag-ka8TvNVgMDK9557_JRNGRv4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrledvgdejkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkffggfgfuvfevfhfhjggtgfesthejredttdefjeenucfhrhhomhepuegvrhhn
    ugcuufgthhhusggvrhhtuceosggvrhhnugdrshgthhhusggvrhhtsehfrghsthhmrghilh
    drfhhmqeenucggtffrrghtthgvrhhnpeekheevkeelkeekjefhheegfedtffduudejjeei
    heehudeuleelgefhueekfeevudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegsvghrnhgurdhstghhuhgsvghrthesfhgrshhtmhgrihhlrdhf
    mh
X-ME-Proxy: <xmx:3VLSZHLcRIzCTc5ilef-EHSmGjWHEzbufXd7sDwnbWSQJzXUwi5Dqg>
    <xmx:3VLSZOIMvOgk_choatwZBvY09N8btHCdWAJTCA1LE8c0lWXrLbKYTw>
    <xmx:3VLSZIwk42huislVSRrtPHLnTFAr7xQazBgx_Gkdvp_F86xQbt1guw>
    <xmx:3VLSZAhD0u6Xgyam4tUxN2ooj22LwKF8LGS7b25Hj6JsrDyIK66wAQ>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 8 Aug 2023 10:36:12 -0400 (EDT)
Message-ID: <6cec5337-edc7-3844-cd6b-40e38d126d51@fastmail.fm>
Date:   Tue, 8 Aug 2023 16:36:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 2/2] fuse: introduce atomic open
To:     Miklos Szeredi <miklos@szeredi.hu>,
        Bernd Schubert <bschubert@ddn.com>
Cc:     linux-fsdevel@vger.kernel.org, fuse-devel@lists.sourceforge.net,
        vgoyal@redhat.com, dsingh@ddn.com,
        Horst Birthelmer <hbirthelmer@ddn.com>
References: <20230707132746.1892211-1-bschubert@ddn.com>
 <20230707132746.1892211-3-bschubert@ddn.com>
 <CAJfpegvxB37bHEAa=-Oeh26vQWx+rVxXt2BDJxe8RjAL43BhmA@mail.gmail.com>
Content-Language: en-US, de-DE
From:   Bernd Schubert <bernd.schubert@fastmail.fm>
In-Reply-To: <CAJfpegvxB37bHEAa=-Oeh26vQWx+rVxXt2BDJxe8RjAL43BhmA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/8/23 14:29, Miklos Szeredi wrote:
> On Fri, 7 Jul 2023 at 15:28, Bernd Schubert <bschubert@ddn.com> wrote:
>>
>> From: Dharmendra Singh <dsingh@ddn.com>
>>
>> This adds full atomic open support, to avoid lookup before open/create.
>> If the implementation (fuse server/daemon) does not support atomic open
>> it falls back to non-atomic open.
>>
>> Signed-off-by: Dharmendra Singh <dsingh@ddn.com>
>> Signed-off-by: Horst Birthelmer <hbirthelmer@ddn.com>
>> Signed-off-by: Bernd Schubert <bschubert@ddn.com>
>> ---
>>   fs/fuse/dir.c             | 170 +++++++++++++++++++++++++++++++++++++-
>>   fs/fuse/fuse_i.h          |   3 +
>>   include/uapi/linux/fuse.h |   3 +
>>   3 files changed, 175 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
>> index 6ffc573de470..8145bbfc7a40 100644
>> --- a/fs/fuse/dir.c
>> +++ b/fs/fuse/dir.c
>> @@ -724,7 +724,7 @@ static int _fuse_create_open(struct inode *dir, struct dentry *entry,
>>
>>   static int fuse_mknod(struct mnt_idmap *, struct inode *, struct dentry *,
>>                        umode_t, dev_t);
>> -static int fuse_atomic_open(struct inode *dir, struct dentry *entry,
>> +static int fuse_create_open(struct inode *dir, struct dentry *entry,
>>                              struct file *file, unsigned flags,
>>                              umode_t mode)
>>   {
>> @@ -770,6 +770,174 @@ static int fuse_atomic_open(struct inode *dir, struct dentry *entry,
>>          return finish_no_open(file, res);
>>   }
>>
>> +static int _fuse_atomic_open(struct inode *dir, struct dentry *entry,
>> +                           struct file *file, unsigned flags,
>> +                           umode_t mode)
>> +{
>> +
>> +       int err;
>> +       struct inode *inode;
>> +       struct fuse_mount *fm = get_fuse_mount(dir);
>> +       struct fuse_conn *fc = fm->fc;
>> +       FUSE_ARGS(args);
>> +       struct fuse_forget_link *forget;
>> +       struct fuse_create_in inarg;
>> +       struct fuse_open_out outopen;
>> +       struct fuse_entry_out outentry;
>> +       struct fuse_inode *fi;
>> +       struct fuse_file *ff;
>> +       struct dentry *res = NULL;
>> +
>> +       /* Userspace expects S_IFREG in create mode */
>> +       if ((flags & O_CREAT) && (mode & S_IFMT) != S_IFREG) {
>> +               WARN_ON(1);
>> +               err = -EINVAL;
>> +               goto out_err;
>> +       }
>> +       forget = fuse_alloc_forget();
>> +       err = -ENOMEM;
>> +       if (!forget)
>> +               goto out_err;
>> +
>> +       err = -ENOMEM;
>> +       ff = fuse_file_alloc(fm);
>> +       if (!ff)
>> +               goto out_put_forget_req;
>> +
>> +       if (!fc->dont_mask)
>> +               mode &= ~current_umask();
>> +
>> +       flags &= ~O_NOCTTY;
>> +       memset(&inarg, 0, sizeof(inarg));
>> +       memset(&outentry, 0, sizeof(outentry));
>> +       inarg.flags = flags;
>> +       inarg.mode = mode;
>> +       inarg.umask = current_umask();
>> +
>> +       if (fc->handle_killpriv_v2 && (flags & O_TRUNC) &&
>> +           !(flags & O_EXCL) && !capable(CAP_FSETID)) {
>> +               inarg.open_flags |= FUSE_OPEN_KILL_SUIDGID;
>> +       }
>> +
>> +       args.opcode = FUSE_OPEN_ATOMIC;
>> +       args.nodeid = get_node_id(dir);
>> +       args.in_numargs = 2;
>> +       args.in_args[0].size = sizeof(inarg);
>> +       args.in_args[0].value = &inarg;
>> +       args.in_args[1].size = entry->d_name.len + 1;
>> +       args.in_args[1].value = entry->d_name.name;
>> +       args.out_numargs = 2;
>> +       args.out_args[0].size = sizeof(outentry);
>> +       args.out_args[0].value = &outentry;
>> +       args.out_args[1].size = sizeof(outopen);
>> +       args.out_args[1].value = &outopen;
>> +
>> +       if (flags & O_CREAT) {
>> +               err = get_create_ext(&args, dir, entry, mode);
>> +               if (err)
>> +                       goto out_free_ff;
>> +       }
>> +
>> +       err = fuse_simple_request(fm, &args);
> 
> free_ext_value() missing.
> 
> Which also begs the question: can't _fuse_create_open() and
> _fuse_atomic_open() be consolidated into a common helper?  There's
> just too much duplication between them to warrant completely separate
> implementations.

Thanks a lot for your review! I'm going to sent out v7 either today or 
tomorrow, which also adds in revalidate (which includes a modified 
version of your vfs patch). v7 also adds in a change similar to commit 
c94c09535c4debcc439f55b5b6d9ebe57bd4665a (what Al had done for NFS) and 
revalidate also makes things more complex. I think it now doesn't look 
that similar to _fuse_create_open anymore. We can then decide if we 
still want to have a common helper function.

> 
>> +       if (err == -ENOSYS) {
>> +               fc->no_open_atomic = 1;
>> +               fuse_file_free(ff);
>> +               kfree(forget);
>> +               goto fallback;
>> +       }
>> +       if (err) {
>> +               if (err == -ENOENT)
>> +                       fuse_invalidate_entry_cache(entry);
>> +               goto out_free_ff;
>> +       }
>> +
>> +       err = -EIO;
>> +       if (invalid_nodeid(outentry.nodeid) || fuse_invalid_attr(&outentry.attr))
>> +               goto out_free_ff;
>> +
>> +       ff->fh = outopen.fh;
>> +       ff->nodeid = outentry.nodeid;
>> +       ff->open_flags = outopen.open_flags;
>> +       inode = fuse_iget(dir->i_sb, outentry.nodeid, outentry.generation,
>> +                         &outentry.attr, entry_attr_timeout(&outentry), 0);
>> +       if (!inode) {
>> +               flags &= ~(O_CREAT | O_EXCL | O_TRUNC);
>> +               fuse_sync_release(NULL, ff, flags);
>> +               fuse_queue_forget(fm->fc, forget, outentry.nodeid, 1);
>> +               err = -ENOMEM;
>> +               goto out_err;
>> +       }
>> +       if (d_in_lookup(entry)) {
>> +               res = d_splice_alias(inode, entry);
>> +               if (res) {
>> +                       if (IS_ERR(res)) {
>> +                               /*
>> +                                * Close the file in user space, but do not unlink it,
>> +                                * if it was created - with network file systems other
>> +                                * clients might have already accessed it.
>> +                                */
>> +                               fi = get_fuse_inode(inode);
>> +                               fuse_sync_release(fi, ff, flags);
>> +                               fuse_queue_forget(fm->fc, forget, outentry.nodeid, 1);
>> +                               err = PTR_ERR(res);
>> +                               goto out_err;
>> +                       }
>> +                       entry = res;
>> +               }
>> +       } else
>> +               d_instantiate(entry, inode);
>> +       fuse_change_entry_timeout(entry, &outentry);
>> +
>> +       if (outopen.open_flags & FOPEN_FILE_CREATED) {
>> +               if (!(flags & O_CREAT)) {
>> +                       pr_debug("Server side bug, FOPEN_FILE_CREATED set "
>> +                                "without O_CREAT, ignoring.");
>> +               } else {
>> +                       /* This should be always set when the file is created */
>> +                       fuse_dir_changed(dir);
>> +                       file->f_mode |= FMODE_CREATED;
>> +               }
>> +       }
>> +
>> +       if (!(flags & O_CREAT))
>> +               fuse_advise_use_readdirplus(dir);
> 
> We advise to use readdirplus from lookup, because readdirplus can
> substitute for a lookup.  But readdirplus cannot substitute for the
> atomic open, so it's not a good idea to advise using readdirpuls in
> this case.  At least that's how I see this.

Yes thanks, it is a long time since the initial patch version and I 
*think* it came in here, as lookup is now avoided for open and idea was 
probably that we thought this advise would not be done anymore. I guess 
the right code path to set it getattr (which currently still does an 
additional lookup) and not open. Thanks for spotting it!


Bernd
