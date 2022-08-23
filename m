Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA42559D1B4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Aug 2022 09:10:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240291AbiHWHI3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Aug 2022 03:08:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240025AbiHWHI3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Aug 2022 03:08:29 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEF36DEB9
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Aug 2022 00:08:27 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id j1so9901384qvv.8
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Aug 2022 00:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=mjr14QGvj0zgShJc8Q/2YTDh1Sn+mGOaUAQRHTzb6Sg=;
        b=N8aOfzkxN+Zs2voYw5V93qVKCnojDAQeLThcuQ7+dBXFe4246BWbjzQc2lCc9wl1oy
         uhfU+SmgeHCoOsMJEitSls0CvOUDYUAfCK0aadCqiRxamjGPmQk/VAD4DTSjYebacyDZ
         UeMx9vA2ltDRO++SNHBCs2jpHk6lx+U0iwFUUx4Va/5P0mOxAZXWZZ9GkHL1zMt8VZ/4
         9gCTyYGCpxt3IGeibZLhzZyb+JhRVfn1rskLMdZOFfobJkgRrcWNdxGuVGO270YlXxoH
         PPCkupeBi0IBYzAEpP8c1KpfLWa23edD9SHxKSogf0DD8Ai0/6h0sUeqznelbYQWMUXc
         /0yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=mjr14QGvj0zgShJc8Q/2YTDh1Sn+mGOaUAQRHTzb6Sg=;
        b=Kgqbz9lL3NpjJf0bjFlGmiBZ+VQKgyJIhCywL/mVafs9pGqFr8C+o+Ix0bbBO+VVLY
         T6fjVbdy67rhMB6P5fEKL3S/nNRH9Y6sQawMTilpn7ZsioBVV2lZBoOPXi4m09C8Xbxu
         +QOItzNrqnMq7BYZ4/iczJIVYgWfxxKe/Asscq7lmjz41MUZOrVX+VLjrwWkmZxE323k
         08In92Do5GyUy+HMPXAliNysOp8A1cLbqDzwyZ5F2W6X/84yNGaBz0amCjH8oY6EiQKD
         HWgz2IBuAFQolUdCGvumhVDj9ScbJy5DihTvz0Ks0Nkv2vJNuY102+9HniWG2+Xj31tR
         D8WA==
X-Gm-Message-State: ACgBeo2NQnyPWpMP5fIh0tKrNO8/5seIUdmbvOKaICnNn6pFlTi6VgSi
        N+l2EuKAfp916L3Wb9GWZmJTSoZsjSUSwA==
X-Google-Smtp-Source: AA6agR4EXNnpvrVIIaR6hxiWRckYmZac4i6IpgomrRpUyQW0MaN7P5Z0r+m0V/rDksm69A4iwxwg1g==
X-Received: by 2002:ad4:5de7:0:b0:496:d0f8:7000 with SMTP id jn7-20020ad45de7000000b00496d0f87000mr10854631qvb.12.1661238506722;
        Tue, 23 Aug 2022 00:08:26 -0700 (PDT)
Received: from google.com (123.178.145.34.bc.googleusercontent.com. [34.145.178.123])
        by smtp.gmail.com with ESMTPSA id q11-20020a05622a030b00b00342fb07944fsm11216666qtw.82.2022.08.23.00.08.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 00:08:26 -0700 (PDT)
Date:   Tue, 23 Aug 2022 07:08:22 +0000
From:   Matthew Bobrowski <repnop@google.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 04/11] fs/notify: constify path
Message-ID: <YwR85o3b5uzf69ee@google.com>
References: <YwEjnoTgi7K6iijN@ZenIV>
 <20220820181256.1535714-1-viro@zeniv.linux.org.uk>
 <20220820181256.1535714-3-viro@zeniv.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220820181256.1535714-3-viro@zeniv.linux.org.uk>
X-Spam-Status: No, score=-14.5 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,FSL_HELO_FAKE,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Aug 20, 2022 at 07:12:49PM +0100, Al Viro wrote:
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

LGTM. Feel free to add:

Reviewed-by: Matthew Bobrowski <repnop@google.com>

> ---
>  fs/notify/fanotify/fanotify.c      | 2 +-
>  fs/notify/fanotify/fanotify.h      | 2 +-
>  fs/notify/fanotify/fanotify_user.c | 6 +++---
>  3 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
> index cd7d09a569ff..a2a15bc4df28 100644
> --- a/fs/notify/fanotify/fanotify.c
> +++ b/fs/notify/fanotify/fanotify.c
> @@ -18,7 +18,7 @@
>  
>  #include "fanotify.h"
>  
> -static bool fanotify_path_equal(struct path *p1, struct path *p2)
> +static bool fanotify_path_equal(const struct path *p1, const struct path *p2)
>  {
>  	return p1->mnt == p2->mnt && p1->dentry == p2->dentry;
>  }
> diff --git a/fs/notify/fanotify/fanotify.h b/fs/notify/fanotify/fanotify.h
> index 1d9f11255c64..bf6d4d38afa0 100644
> --- a/fs/notify/fanotify/fanotify.h
> +++ b/fs/notify/fanotify/fanotify.h
> @@ -458,7 +458,7 @@ static inline bool fanotify_event_has_path(struct fanotify_event *event)
>  		event->type == FANOTIFY_EVENT_TYPE_PATH_PERM;
>  }
>  
> -static inline struct path *fanotify_event_path(struct fanotify_event *event)
> +static inline const struct path *fanotify_event_path(struct fanotify_event *event)
>  {
>  	if (event->type == FANOTIFY_EVENT_TYPE_PATH)
>  		return &FANOTIFY_PE(event)->path;
> diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
> index f0e49a406ffa..4546da4a54f9 100644
> --- a/fs/notify/fanotify/fanotify_user.c
> +++ b/fs/notify/fanotify/fanotify_user.c
> @@ -249,7 +249,7 @@ static struct fanotify_event *get_one_event(struct fsnotify_group *group,
>  	return event;
>  }
>  
> -static int create_fd(struct fsnotify_group *group, struct path *path,
> +static int create_fd(struct fsnotify_group *group, const struct path *path,
>  		     struct file **file)
>  {
>  	int client_fd;
> @@ -619,7 +619,7 @@ static ssize_t copy_event_to_user(struct fsnotify_group *group,
>  				  char __user *buf, size_t count)
>  {
>  	struct fanotify_event_metadata metadata;
> -	struct path *path = fanotify_event_path(event);
> +	const struct path *path = fanotify_event_path(event);
>  	struct fanotify_info *info = fanotify_event_info(event);
>  	unsigned int info_mode = FAN_GROUP_FLAG(group, FANOTIFY_INFO_MODES);
>  	unsigned int pidfd_mode = info_mode & FAN_REPORT_PIDFD;
> @@ -1553,7 +1553,7 @@ static int fanotify_test_fid(struct dentry *dentry)
>  }
>  
>  static int fanotify_events_supported(struct fsnotify_group *group,
> -				     struct path *path, __u64 mask,
> +				     const struct path *path, __u64 mask,
>  				     unsigned int flags)
>  {
>  	unsigned int mark_type = flags & FANOTIFY_MARK_TYPE_BITS;
> -- 
> 2.30.2

/M
