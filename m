Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D4F9791370
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Sep 2023 10:29:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347258AbjIDIaA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Sep 2023 04:30:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346451AbjIDI37 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Sep 2023 04:29:59 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44FCCD8;
        Mon,  4 Sep 2023 01:29:56 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id ED6BA2185A;
        Mon,  4 Sep 2023 08:29:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1693816194; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eabM8AkXCXasvXXbZQl9XBFb19YbOYl9pkJ6pJMtyU0=;
        b=yQj2+jVtdb/71H6LG2oo6a77t6x0w5WeYDkxZk3Hj6gfIrh/2P/5iyqqhwh670IILvQfU1
        Z/jud+KVeRGIcFsWNb1VL+AN1HjvA15NIQKzYpCE7tuKQ+/VSH3yMr11VFyzDzVBPV4i5h
        CkQ0AJBPccZ2Xy+v0Hg8LWBVgefYfKs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1693816194;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eabM8AkXCXasvXXbZQl9XBFb19YbOYl9pkJ6pJMtyU0=;
        b=JEesMbZgvVF5Lmh6oUifrMuYcWzd1KLi6cJjQBcm5oXEgbLM/fWH8Cvy+0RfxExKngUMVi
        pCJ+wSZX1QQ1IYBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D9B621358B;
        Mon,  4 Sep 2023 08:29:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id VoG3NIKV9WSvXAAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 04 Sep 2023 08:29:54 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 65626A0776; Mon,  4 Sep 2023 10:29:54 +0200 (CEST)
Date:   Mon, 4 Sep 2023 10:29:54 +0200
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Alejandro Colomar <alx.manpages@gmail.com>,
        Jan Kara <jack@suse.cz>, Jeff Layton <jlayton@poochiereds.net>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-man@vger.kernel.org
Subject: Re: [PATCH] name_to_handle_at.2,fanotify_mark.2: Document the
 AT_HANDLE_FID flag
Message-ID: <20230904082954.zx65mg6ulzz4cc5c@quack3>
References: <20230903120433.2605027-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230903120433.2605027-1-amir73il@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun 03-09-23 15:04:33, Amir Goldstein wrote:
> A flag to indicate that the requested file_handle is not intended
> to be used for open_by_handle_at(2) and may be needed to identify
> filesystem objects reported in fanotify events.
> 
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>

Looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
> 
> Hi Alejandro,
> 
> This is a followup on AT_HANDLE_FID feature from v6.5.
> 
> Thanks,
> Amir.
> 
>  man2/fanotify_mark.2     | 11 +++++++++--
>  man2/open_by_handle_at.2 | 42 +++++++++++++++++++++++++++++++++++++---
>  2 files changed, 48 insertions(+), 5 deletions(-)
> 
> diff --git a/man2/fanotify_mark.2 b/man2/fanotify_mark.2
> index 3f85deb23..8e885af69 100644
> --- a/man2/fanotify_mark.2
> +++ b/man2/fanotify_mark.2
> @@ -743,10 +743,17 @@ do not specify a directory.
>  .B EOPNOTSUPP
>  The object indicated by
>  .I pathname
> -is associated with a filesystem that does not support the encoding of file
> -handles.
> +is associated with a filesystem
> +that does not support the encoding of file handles.
>  This error can be returned only with an fanotify group that identifies
>  filesystem objects by file handles.
> +Calling
> +.BR name_to_handle_at (2)
> +with the flag
> +.BR AT_HANDLE_FID " (since Linux 6.5)"
> +.\" commit 96b2b072ee62be8ae68c8ecf14854c4d0505a8f8
> +can be used as a test
> +to check if a filesystem supports reporting events with file handles.
>  .TP
>  .B EPERM
>  The operation is not permitted because the caller lacks a required capability.
> diff --git a/man2/open_by_handle_at.2 b/man2/open_by_handle_at.2
> index 4061faea9..4cfa21d9c 100644
> --- a/man2/open_by_handle_at.2
> +++ b/man2/open_by_handle_at.2
> @@ -109,17 +109,44 @@ structure as an opaque data type: the
>  .I handle_type
>  and
>  .I f_handle
> -fields are needed only by a subsequent call to
> +fields can be used in a subsequent call to
>  .BR open_by_handle_at ().
> +The caller can also use the opaque
> +.I file_handle
> +to compare the identity of filesystem objects
> +that were queried at different times and possibly
> +at different paths.
> +The
> +.BR fanotify (7)
> +subsystem can report events
> +with an information record containing a
> +.I file_handle
> +to identify the filesystem object.
>  .PP
>  The
>  .I flags
>  argument is a bit mask constructed by ORing together zero or more of
> -.B AT_EMPTY_PATH
> +.BR AT_HANDLE_FID ,
> +.BR AT_EMPTY_PATH ,
>  and
>  .BR AT_SYMLINK_FOLLOW ,
>  described below.
>  .PP
> +When
> +.I flags
> +contain the
> +.BR AT_HANDLE_FID " (since Linux 6.5)"
> +.\" commit 96b2b072ee62be8ae68c8ecf14854c4d0505a8f8
> +flag, the caller indicates that the returned
> +.I file_handle
> +is needed to identify the filesystem object,
> +and not for opening the file later,
> +so it should be expected that a subsequent call to
> +.BR open_by_handle_at ()
> +with the returned
> +.I file_handle
> +may fail.
> +.PP
>  Together, the
>  .I pathname
>  and
> @@ -363,8 +390,14 @@ capability.
>  .B ESTALE
>  The specified
>  .I handle
> -is not valid.
> +is not valid for opening a file.
>  This error will occur if, for example, the file has been deleted.
> +This error can also occur if the
> +.I handle
> +was aquired using the
> +.B AT_HANDLE_FID
> +flag and the filesystem does not support
> +.BR open_by_handle_at ().
>  .SH VERSIONS
>  FreeBSD has a broadly similar pair of system calls in the form of
>  .BR getfh ()
> @@ -386,6 +419,9 @@ file handles, for example,
>  .IR /proc ,
>  .IR /sys ,
>  and various network filesystems.
> +Some filesystem support the translation of pathnames to
> +file handles, but do not support using those file handles in
> +.BR open_by_handle_at ().
>  .PP
>  A file handle may become invalid ("stale") if a file is deleted,
>  or for other filesystem-specific reasons.
> -- 
> 2.34.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
