Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1EAD7A5876
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Sep 2023 06:42:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231422AbjISEmf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Sep 2023 00:42:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231417AbjISEmf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Sep 2023 00:42:35 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D471010E;
        Mon, 18 Sep 2023 21:42:28 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-68fb79ef55eso4758230b3a.0;
        Mon, 18 Sep 2023 21:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695098548; x=1695703348; darn=vger.kernel.org;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Df+9eLjTUVzgEqVA6Q+LlyRbAvg6Ho3M0KjpMi0md/g=;
        b=NSEMnItVyBe3z+3o0RBqPSy8jsfpoR9FxHiGHSDdPI2p9hmoGk0s93NwWuVis5KT1A
         IhKFqJ3h+/8ez+fBoU3VD29my32+scpIiSkhmDuObQ3SZaDex37hypt70EVbLkC6f2Im
         A6PwFy5dKbYmhY7HWLRIKBZlF/SJO7v//7P0AMs80tWmcwSQehsp4O3d6YPMkrRQdcRO
         4gCMiEndJVW2x6dyFsw+K1dJmRVaiBMGSn6Vg2hb9WLS5LhZLV4CyF1f+mP7JAo9kzPz
         KSR3Mmzvq7vOmA9qsnrR7Daxf28fxBxJCy0KTcdavPej9jK80OdFLSSiGS2+7mb8D3SG
         Lwng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695098548; x=1695703348;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Df+9eLjTUVzgEqVA6Q+LlyRbAvg6Ho3M0KjpMi0md/g=;
        b=gIPRrmiEBtpPExG976aKJx299fotLRoXfOqy+6oPmHz0JDvEzu1ixC4aE6EoqT8SjR
         5EWbBOQDUx+Af+J78gIG+qe61Yshkp+t30Ov5vMJmweFU4WBqBUQ6vJxYna3P5t1+6QN
         x68LRM9+0yh6CwgQOj2Av81ld2jseebE10TU7MG0UCoVfP4NNN7w1bqxJxdh+ixIdEn0
         1pswLlT3TPKuqhM7Wtwlmn1wu5FhBrs5c6LlLYwlTH+FhaZ1MFIw0xWaLcWahPSUlSsY
         7VNKsqb3U+OuWL9yNXPgTpT/9f/dZwTQEV698WtFPHS0kaecb8taLS+nrYAV/cqwaqbV
         TkUA==
X-Gm-Message-State: AOJu0YzbyCLUDGZ2F6jbJq+ug3QufTXdNezwV1y4pTYg4MeWbOh358xO
        pbo6j/8XwhxhYyiw95tZpDv/IXGWz58=
X-Google-Smtp-Source: AGHT+IGB37sIyrpD0Udu1Nod//aFhAGcrTcwFgKX8tvPBguV7ClfrjejpnsVpuAAgszoQbjhrabkKg==
X-Received: by 2002:a05:6a00:2283:b0:68a:5773:6319 with SMTP id f3-20020a056a00228300b0068a57736319mr13214107pfe.11.1695098548286;
        Mon, 18 Sep 2023 21:42:28 -0700 (PDT)
Received: from dw-tp ([49.207.223.191])
        by smtp.gmail.com with ESMTPSA id fe20-20020a056a002f1400b00687dde8ae5dsm7802303pfb.154.2023.09.18.21.42.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Sep 2023 21:42:27 -0700 (PDT)
Date:   Tue, 19 Sep 2023 10:12:19 +0530
Message-Id: <87sf7a7p04.fsf@doe.com>
From:   Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To:     "Darrick J. Wong" <djwong@kernel.org>, djwong@kernel.org
Cc:     willy@infradead.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, willy@infradead.org
Subject: Re: [PATCH 1/2] iomap: don't skip reading in !uptodate folios when unsharing a range
In-Reply-To: <169507872536.772278.18183365318216726644.stgit@frogsfrogsfrogs>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

"Darrick J. Wong" <djwong@kernel.org> writes:

> From: Darrick J. Wong <djwong@kernel.org>
>
> Prior to commit a01b8f225248e, we would always read in the contents of a
> !uptodate folio prior to writing userspace data into the folio,
> allocated a folio state object, etc.  Ritesh introduced an optimization
> that skips all of that if the write would cover the entire folio.
>
> Unfortunately, the optimization misses the unshare case, where we always
> have to read in the folio contents since there isn't a data buffer
> supplied by userspace.  This can result in stale kernel memory exposure
> if userspace issues a FALLOC_FL_UNSHARE_RANGE call on part of a shared
> file that isn't already cached.
>
> This was caught by observing fstests regressions in the "unshare around"
> mechanism that is used for unaligned writes to a reflinked realtime
> volume when the realtime extent size is larger than 1FSB, though I think
> it applies to any shared file.
>
> Cc: ritesh.list@gmail.com, willy@infradead.org
> Fixes: a01b8f225248e ("iomap: Allocate ifs in ->write_begin() early")
> Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> ---
>  fs/iomap/buffered-io.c |    6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

Thanks for catching this case. Fix for this looks good to me. 
I have verified on my setup. w/o this patch it indeed can cause
corruption in the unshare case, since we don't read the disk contents
and we might end up writing garbage from the page cache.

Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>


>
>
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index ae8673ce08b1..0350830fc989 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -640,11 +640,13 @@ static int __iomap_write_begin(const struct iomap_iter *iter, loff_t pos,
>  	size_t poff, plen;
>  
>  	/*
> -	 * If the write completely overlaps the current folio, then
> +	 * If the write or zeroing completely overlaps the current folio, then
>  	 * entire folio will be dirtied so there is no need for
>  	 * per-block state tracking structures to be attached to this folio.
> +	 * For the unshare case, we must read in the ondisk contents because we
> +	 * are not changing pagecache contents.
>  	 */
> -	if (pos <= folio_pos(folio) &&
> +	if (!(iter->flags & IOMAP_UNSHARE) && pos <= folio_pos(folio) &&
>  	    pos + len >= folio_pos(folio) + folio_size(folio))
>  		return 0;
>  
