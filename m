Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F42C78480D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Aug 2023 18:55:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237939AbjHVQzY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Aug 2023 12:55:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234012AbjHVQzY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Aug 2023 12:55:24 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95B05128
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Aug 2023 09:55:22 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 12D605C00D9;
        Tue, 22 Aug 2023 12:55:22 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 22 Aug 2023 12:55:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
        cc:cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1692723322; x=1692809722; bh=UxoiJZ/gDdTY20GZKpdzVI9hAzq1MBBZOUH
        VVnRtRuM=; b=U5K7csoZUYHzAJmS31f47zMtDYceYdZYVfRr6B1PbnQ5A547nCv
        Vc5KOJuPAd+JWrGy9ZrhEeTirnZMeQKG69wq1IKYpbYN3WC4t1Z+BPntjt3IRwdg
        z8klf6gTe/SfkgnRAGO/xuLFm0i6YlmgcjI+MpUAwGF7uZu7x7v9h052NA+FfQ48
        9ewu9q2aBjsHTy6nzHzYoeHOHaA+s7bukFpcJBwJ++r2u0Q28vpumM+YCmUwFUuz
        VUpu06+WMhlRrXzX2TMIkTDvQuHVi/HUCbidP9bCbKrvI/L6jzZNuOK+wJl5lfjJ
        QXPGLY/19USJe44GbQ7O+zef/I87MKnon6A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1692723322; x=1692809722; bh=UxoiJZ/gDdTY20GZKpdzVI9hAzq1MBBZOUH
        VVnRtRuM=; b=e502AHIJaoFQyYYB/0JiX5OG43jpW2uSwiROkxl5q+qoC5EfFTF
        RdXnBeZBog3r4QXrVTKKDAn6hTa0wmr/QpIYekUrx+pq7E6KDYiKTEYnRcfAa2xh
        vn8EZWEh4ioPTGWTT4T6Eq5/z51D5pE7RJ/eNMgeYkzDt8+zCnkZfl+8miXjkqri
        8LJwpxocXir57A7tGGDWC2Adeah8lmnVVS7uUQXW2jwSHeHXxnpJganarrLttr+L
        DecvI6GH/zFv5k7pahcDyR7VFH+AzVO1r7j35XDpxZ08m2MO8/llvENn2Yt01opk
        KYg0HBwKrKTGSwRU5IiGCKtfJ/av8OWp4Pg==
X-ME-Sender: <xms:eejkZKF8JW9DO6DqQHLNw-UiRkHvz8B6n3amoWaXLTJho3pS8qKrkA>
    <xme:eejkZLXSUMvxWhFLfS8R-onC38neJNNtJWgaB8jo_cKhmt7-b4gE-xwcSBqhJMZs4
    SW-q1_3dLAVUIYJ>
X-ME-Received: <xmr:eejkZEKt9Fr8dZhRZQN6ZRVf5cOgpX0Vf5AEbYQXG17fClSq3fDOyKioZsxZLYkIw7UHunKagAZ1qquXlrZrtWm_EaA8ZrZNU2f_afnNULCO4d0EOaGX>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedruddvuddguddtiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefkffggfgfuvfevfhfhjggtgfesthejredttdefjeenucfhrhhomhepuegv
    rhhnugcuufgthhhusggvrhhtuceosggvrhhnugdrshgthhhusggvrhhtsehfrghsthhmrg
    hilhdrfhhmqeenucggtffrrghtthgvrhhnpeekheevkeelkeekjefhheegfedtffduudej
    jeeiheehudeuleelgefhueekfeevudenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpegsvghrnhgurdhstghhuhgsvghrthesfhgrshhtmhgrihhl
    rdhfmh
X-ME-Proxy: <xmx:eejkZEF9ksdqAB_aTYWd-r4KmT7UkI7i4brHyi5hBYZsD2LtPPF7HQ>
    <xmx:eejkZAV_F6jsry6N0xLSvZoSvFOASo0opLf9fD2iDlc3YGEpop2l3w>
    <xmx:eejkZHMvop35XxLFEomy-Ern2LfdlmELYeXoIjS3dlIYZCMmmYxMcA>
    <xmx:eujkZLePaUqd-O9nxBQGzACzQ3acFe5KQhnrT6aIUXU1CVHrgKBXXg>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 22 Aug 2023 12:55:21 -0400 (EDT)
Message-ID: <9ebc2bcb-5ffd-e82f-9836-58f375f881ea@fastmail.fm>
Date:   Tue, 22 Aug 2023 18:55:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 4/5] fuse: implement statx
Content-Language: en-US, de-DE
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Miklos Szeredi <mszeredi@redhat.com>, linux-fsdevel@vger.kernel.org
References: <20230810105501.1418427-1-mszeredi@redhat.com>
 <20230810105501.1418427-5-mszeredi@redhat.com>
 <067fcdfa-0a99-4731-0ea1-a799fff51480@fastmail.fm>
 <CAJfpeguEmafkUPqZO2_EAOWbw+7XUm0E9whVpnnj_MVf2fnStQ@mail.gmail.com>
From:   Bernd Schubert <bernd.schubert@fastmail.fm>
In-Reply-To: <CAJfpeguEmafkUPqZO2_EAOWbw+7XUm0E9whVpnnj_MVf2fnStQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 8/22/23 17:33, Miklos Szeredi wrote:
> On Tue, 22 Aug 2023 at 17:20, Bernd Schubert <bernd.schubert@fastmail.fm> wrote:
>>
>> Hi Miklos,
>>
>> sorry for late review.
>>
>> On 8/10/23 12:55, Miklos Szeredi wrote:
>> [...]
>>> +static int fuse_do_statx(struct inode *inode, struct file *file,
>>> +                      struct kstat *stat)
>>> +{
>>> +     int err;
>>> +     struct fuse_attr attr;
>>> +     struct fuse_statx *sx;
>>> +     struct fuse_statx_in inarg;
>>> +     struct fuse_statx_out outarg;
>>> +     struct fuse_mount *fm = get_fuse_mount(inode);
>>> +     u64 attr_version = fuse_get_attr_version(fm->fc);
>>> +     FUSE_ARGS(args);
>>> +
>>> +     memset(&inarg, 0, sizeof(inarg));
>>> +     memset(&outarg, 0, sizeof(outarg));
>>> +     /* Directories have separate file-handle space */
>>> +     if (file && S_ISREG(inode->i_mode)) {
>>> +             struct fuse_file *ff = file->private_data;
>>> +
>>> +             inarg.getattr_flags |= FUSE_GETATTR_FH;
>>> +             inarg.fh = ff->fh;
>>> +     }
>>> +     /* For now leave sync hints as the default, request all stats. */
>>> +     inarg.sx_flags = 0;
>>> +     inarg.sx_mask = STATX_BASIC_STATS | STATX_BTIME;
>>
>>
>>
>> What is actually the reason not to pass through flags from
>> fuse_update_get_attr()? Wouldn't it make sense to request the minimal
>> required mask and then server side can decide if it wants to fill in more?
> 
> This and following commit is about btime and btime only.  It's about
> adding just this single attribute, otherwise the logic is unchanged.
> 
> But the flexibility is there in the interface definition, and
> functionality can be added later.

Sure, though what speaks against setting (limiting the mask) right away?

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 42f49fe6e770..de1d991757a5 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -1168,7 +1168,8 @@ static void fuse_statx_to_attr(struct fuse_statx *sx, struct fuse_attr *attr)
  }
  
  static int fuse_do_statx(struct inode *inode, struct file *file,
-                        struct kstat *stat)
+                        struct kstat *stat, u32 request_mask,
+                        unsigned int flags)
  {
         int err;
         struct fuse_attr attr;
@@ -1188,9 +1189,10 @@ static int fuse_do_statx(struct inode *inode, struct file *file,
                 inarg.getattr_flags |= FUSE_GETATTR_FH;
                 inarg.fh = ff->fh;
         }
-       /* For now leave sync hints as the default, request all stats. */
-       inarg.sx_flags = 0;
-       inarg.sx_mask = STATX_BASIC_STATS | STATX_BTIME;
+
+       /* request the given mask, server side is free to return more */
+       inarg.sx_flags = flags;
+       inarg.sx_mask = request_mask;
         args.opcode = FUSE_STATX;
         args.nodeid = get_node_id(inode);
         args.in_numargs = 1;
@@ -1304,7 +1306,8 @@ static int fuse_update_get_attr(struct inode *inode, struct file *file,
                 forget_all_cached_acls(inode);
                 /* Try statx if BTIME is requested */
                 if (!fc->no_statx && (request_mask & ~STATX_BASIC_STATS)) {
-                       err = fuse_do_statx(inode, file, stat);
+                       err = fuse_do_statx(inode, file, stat, request_mask,
+                                           flags);
                         if (err == -ENOSYS) {
                                 fc->no_statx = 1;
                                 goto retry;



Thanks,
Bernd
