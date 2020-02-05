Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BCF7C152513
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2020 04:05:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727911AbgBEDFQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Feb 2020 22:05:16 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:44720 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727746AbgBEDFQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Feb 2020 22:05:16 -0500
Received: by mail-lf1-f65.google.com with SMTP id v201so345758lfa.11
        for <linux-fsdevel@vger.kernel.org>; Tue, 04 Feb 2020 19:05:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5WF1go+DuJvbwgdXeUhoD65NaX1JQ7zRHimo51GmC8M=;
        b=a/rT7owEo3U/lPRFn35JOyHmNdZNKq3CUN5eC0vmSOAlGMUJJc7ELCvSX1Mh8APfaa
         lAlLVERWXR5pYN81ddhMclRnb/OmN5Fx2KddB7KuZLDfFPyFM3c5qNNCCjwGgxr+r3s1
         DNCcaZvM6VYKACKmTz/OjiTlKJVFN9VL8YzEYvQS2U83lFvZUm1XWKOklUIkQxQvXozG
         vNU7Zo1syf0hTTILG3oFQfUcj+JQqVr59fj+c5MCVuSCuEvLrPxTFeYRhYsiMU1wniYS
         k/ew5rFlhFL2LzMHulEuIV3u33upCBPfLhXENQXAIsbZYUZT2I99yQmfa/FkquxeDAIP
         aNXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5WF1go+DuJvbwgdXeUhoD65NaX1JQ7zRHimo51GmC8M=;
        b=dmz1nI1lXHntAYVXqhgsFVTv6OYrHVLGeDZO4bx1azFQgt7P2oDhyUQyt7rqCt9kSW
         dCaglcK8xeDhFwZxcHwA200AcPMFeyGfVSrbNDocf91/m1jujexAJ65ef3+Dx4cii7Y5
         UW09scidl+acl/OrhlUUzOcORr7Zwd8W4FwUCjxLxkpUSy++ItlScOPyVeNz/I59sAln
         UJyixkOEMOFwNuQ4JQDRaxzBPxIeFXTBVnwVrBkVPbphCCnetT+uuljorp/xVl6KhW8S
         Wbf+wb9m9K6cryqo+/9IJ3Hgw3kuBzMFRwwCjsPgc4JskrBEz8bxTx/kB174jCfIjZL6
         9MmA==
X-Gm-Message-State: APjAAAUNM5Az+1U7LEO0q+9ZrEWiI/M2ASIwaUIoLvZCA0E17wzsRI9D
        CN+vIXgphbwehgI5Pu91FFJWq6J3sI/If97PtoQL7w==
X-Google-Smtp-Source: APXvYqzeG4caRRvcRllow4EA73MGmU6WFhFNYJbaTAD8sJamhzsXSFSCQuZUYpZgWEJovRgzDpyi7R9sxFKJltzNJtg=
X-Received: by 2002:a19:4a92:: with SMTP id x140mr17094713lfa.29.1580871913677;
 Tue, 04 Feb 2020 19:05:13 -0800 (PST)
MIME-Version: 1.0
References: <20200128230328.183524-1-drosen@google.com> <20200128230328.183524-2-drosen@google.com>
 <85sgjsxx2g.fsf@collabora.com>
In-Reply-To: <85sgjsxx2g.fsf@collabora.com>
From:   Daniel Rosenberg <drosen@google.com>
Date:   Tue, 4 Feb 2020 19:05:02 -0800
Message-ID: <CA+PiJmS3kbK8220QaccP5jJ7dSf4xv3UrStQvLskAtCN+=vG_A@mail.gmail.com>
Subject: Re: [PATCH v6 1/5] unicode: Add standard casefolded d_ops
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        Eric Biggers <ebiggers@kernel.org>,
        linux-fscrypt@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Richard Weinberger <richard@nod.at>,
        linux-mtd@lists.infradead.org,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Feb 2, 2020 at 5:46 PM Gabriel Krisman Bertazi
<krisman@collabora.com> wrote:
>
>
> I don't think fs/unicode is the right place for these very specific
> filesystem functions, just because they happen to use unicode.  It is an
> encoding library, it doesn't care about dentries, nor should know how to
> handle them.  It exposes a simple api to manipulate and convert utf8 strings.
>
> I saw change was after the desire to not have these functions polluting
> the VFS hot path, but that has nothing to do with placing them here.
>
> Would libfs be better?  or a casefolding library in fs/casefold.c?
>
>
> --
> Gabriel Krisman Bertazi

The hash function needs access to utf8ncursor, but apart from that,
libfs would make sense. utf8ncursor is the only reason I have them
here. How do you feel about exposing utf8cursor or something similar?
