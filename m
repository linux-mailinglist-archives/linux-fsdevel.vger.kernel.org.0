Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09F35254B18
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Aug 2020 18:49:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbgH0QtG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Aug 2020 12:49:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726853AbgH0QtC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Aug 2020 12:49:02 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00F39C061264
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Aug 2020 09:49:01 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id d18so6483738iop.13
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Aug 2020 09:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/xGpOY5v3rYoFqTd5QFQEPCm9lS0N53r2cL3cEdKtPw=;
        b=mx+FJh+qUi0eylsu7L5BZKzqa0QvffqcQd1piV8hJ6N9eT9+EcGAtY/vTkjhlPEDuW
         i4bJW+Hw5vkXE3QOjP00yzvGOx8NdmAa5xDpJxtAH1b5y/tb+6lcmCXNX04NRc+y3ZGO
         Tz4AfmmZltBKDUOJrlkUu4MwuW1406+6ICT01nQWL7eOtK1K7beaV3+fgjuvh9xLhMGb
         1rdiHTd4Wm9XHDp5nDwcQsgX1umcQciurhny3pj2qPHE/IeYwdyvZVs437s79yJd4Pd1
         qQ4F0jgXjb7kjVvvsCi6v5HMTX/eP5Xw6c88+9OJjIQmO9nUDfZHpZ+yJF9iMaD1WVC5
         Sovw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/xGpOY5v3rYoFqTd5QFQEPCm9lS0N53r2cL3cEdKtPw=;
        b=Inq4BcAQpzZUSzAux3rnF73YhnJyYe4yTQP2imI/vPuwX3fs8E5kFTHRodcKsJniQy
         OkintdtpythBwsz6+z0LEPkW0CcsR/X9gEKbma/E3EEGWsSmOCF5ehQkh+NdZVP5JiP/
         bPQu8VRdPZKo8mrb/+Zs0a5pH1S4nDLcql/pjyFNoIzFam878n6lpt00UiwwVt+1+07i
         HHW4SoiZgnUXdJwuw2a/MVciTx/NcOFHJEp0YP2BdwdfNTEgnI/73NimJXXBa1tg2omw
         vWcEHqWNkmzDyffDTYMLQTHgwRgklsSCJIr1c2TfPmKmtCpivTgyOYmAv4b0LNb06w9U
         ANkA==
X-Gm-Message-State: AOAM533H9oMLUaqzfA6rSk7alXZ0JTzEVDYbdQ/1beUI+NJw0DP68oxt
        x39ISnjFjokzXE4/Njvd1y//IQ==
X-Google-Smtp-Source: ABdhPJx+UxHqjKJ/wh4vVsrsKz1c7ecfzQJTGkjRy2EK647UYYIw8L0JJ2F4rqhbalqI+shH+xs5XQ==
X-Received: by 2002:a5d:924c:: with SMTP id e12mr17853974iol.28.1598546940951;
        Thu, 27 Aug 2020 09:49:00 -0700 (PDT)
Received: from google.com ([2601:285:8380:9270::f2a2])
        by smtp.gmail.com with ESMTPSA id 187sm1430125iow.34.2020.08.27.09.48.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2020 09:49:00 -0700 (PDT)
Date:   Thu, 27 Aug 2020 10:48:57 -0600
From:   Ross Zwisler <zwisler@google.com>
To:     Aleksa Sarai <cyphar@cyphar.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, linux-kernel@vger.kernel.org,
        Mattias Nissler <mnissler@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Benjamin Gordon <bmgordon@google.com>,
        David Howells <dhowells@redhat.com>,
        Dmitry Torokhov <dtor@google.com>,
        Jesse Barnes <jsbarnes@google.com>,
        linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        Micah Morton <mortonm@google.com>,
        Raul Rangel <rrangel@google.com>, Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH v8 1/2] Add a "nosymfollow" mount option.
Message-ID: <20200827164857.GA414369@google.com>
References: <20200819164317.637421-1-zwisler@google.com>
 <20200826204819.GA4414@google.com>
 <20200827015940.GY1236603@ZenIV.linux.org.uk>
 <20200827154139.vwuflrlvj257krnw@yavin.dot.cyphar.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200827154139.vwuflrlvj257krnw@yavin.dot.cyphar.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 28, 2020 at 01:41:39AM +1000, Aleksa Sarai wrote:
> On 2020-08-27, Al Viro <viro@zeniv.linux.org.uk> wrote:
> > On Wed, Aug 26, 2020 at 02:48:19PM -0600, Ross Zwisler wrote:
> > 
> > > Al, now that the changes to fs/namei.c have landed and we're past the merge
> > > window for v5.9, what are your thoughts on this patch and the associated test?
> > 
> > Humm...  should that be nd->path.mnt->mnt_flags or link->mnt->mnt_flags?
> > Usually it's the same thing, but they might differ.  IOW, is that about the
> > directory we'd found it in, or is it about the link itself?
> 
> Now that you mention it, I think link->mnt->mnt_flags makes more sense.
> The restriction should apply in the context of whatever filesystem
> contains the symlink, and that would matches FreeBSD's semantics (at
> least as far as I can tell from a quick look at sys/kern/vfs_lookup.c).

Yep, changing this to link->mnt->mnt_flags makes sense to me, as you're right
that we care about the link itself and not the link's parent directory.  Thank
you for the review, and I'll send out v9 momentarily.
