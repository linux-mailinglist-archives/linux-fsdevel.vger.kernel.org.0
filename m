Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E5CE40676E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Sep 2021 08:57:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231331AbhIJG7F (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Sep 2021 02:59:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231223AbhIJG7E (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Sep 2021 02:59:04 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C141C061574
        for <linux-fsdevel@vger.kernel.org>; Thu,  9 Sep 2021 23:57:54 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id m11so1085491ioo.6
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Sep 2021 23:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CmmmAC4vcYiUE9Hmg9rW/UUijpoUqDygyKoHYDVWARo=;
        b=R1OV6a1OTPlcg6Ww/R8P6TN8Zh0NbVShq+Zs1zEl4RZzA/eQFiReMBLZLVV0Ck2VLG
         Nv6UQfUrEaZFUwl0OaUhvbFuOEGHFaKENT0VSOwQ72j/x7nj1Tq6JJ3Wk0XNUl+/uxWB
         udzDjlqPxyaopfknuLEcruwAxfqf6A/qU9nMd375/XXTGkziR2rS6FqfpezUXO1spuCK
         M2mla2aBRzG/BXltPRppmszmaHNuLWWzhmMUbMYWd9hyxNdAdQt197y0z5UgCXKUeK/q
         PySb0akWvxQbsDytUD/8CXO+7HdkQkEChpeyVGZ6SrL4bg2b3WSBsPZs6hI6/AnJyZTt
         FM4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CmmmAC4vcYiUE9Hmg9rW/UUijpoUqDygyKoHYDVWARo=;
        b=xXKCqvdMu/4LfB/dsJer2eHkg021Q8XOR9DiryA2Glt3Kmj6Y68EHz0l6z3W24vzOR
         jyUGYw+Qn4AWb+mh2d+Z+Rw0kypuyHNB/kTgmAs7h18QcU67qdnjyg5Zd8yMIgRU6saW
         kKhXGwopJKQNrKCKhPuxQTa2hEZN4JpXFdmhRIeOZbMD/8V2FOFc/g5SJsm2wPH3oQPJ
         nTPyYZDTt3keoSPa1U95VOMkFzclSY0E01c6/no7A5/frJ4pD9IE8wuPqIwuE9biU99C
         EcHmKSw//K8jxtcXAEYhlt8kTYypMGN4e1iilJ3bW5AV10+N3fWfUjI3tlhkz8cq2TpO
         KV/A==
X-Gm-Message-State: AOAM533+x2ybu3VP3aIojrPugvfmomI1pcOpXTel+StJbGkzLD5VhBeL
        jaSWcXzX+w0Q46FN92saED+FqcGhshf1UuY7IAA=
X-Google-Smtp-Source: ABdhPJwXmrE5kZXOdtemQsNY3X40UILzKOaFRm/IM7KMhTua6boUobsaaDpt2raEwNB6wgAbu3TAuN55IB6iBQCFspI=
X-Received: by 2002:a5e:c30c:: with SMTP id a12mr5800252iok.52.1631257073844;
 Thu, 09 Sep 2021 23:57:53 -0700 (PDT)
MIME-Version: 1.0
References: <20210825124515.GE14620@quack2.suse.cz>
In-Reply-To: <20210825124515.GE14620@quack2.suse.cz>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 10 Sep 2021 09:57:42 +0300
Message-ID: <CAOQ4uxi4S0oMSXTfpNTCqJPoO4=at1_f1cA-3LAUmuOy4CcqKw@mail.gmail.com>
Subject: Re: [GIT PULL] Fsnotify changes for v5.15-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 25, 2021 at 3:47 PM Jan Kara <jack@suse.cz> wrote:
>
>   Hello Linus,
>
>   my vacation collides with the merge window which I expect to open next
> week so I'm sending pull requests for the merge window early. Could you please
> pull from
>
> git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fsnotify_for_v5.15-rc1
>
> to get fsnotify speedups when notification actually isn't used and support
> for identifying processes which caused fanotify events through pidfd
> instead of normal pid.
>
> Top of the tree is e43de7f0862b. The full shortlog is:
>
> Amir Goldstein (4):
>       fsnotify: replace igrab() with ihold() on attach connector
>       fsnotify: count s_fsnotify_inode_refs for attached connectors
>       fsnotify: count all objects with attached connectors
>       fsnotify: optimize the case of no marks of any type
>

Linus,

At the risk of being too nagging, please see my patch [1] to fix a
regression [2]
reported after this pull request was merged.

Thanks,
Amir.

[1] https://lore.kernel.org/linux-fsdevel/20210909115634.1015564-1-amir73il@gmail.com/
[2] https://lore.kernel.org/linux-fsdevel/20210907063338.ycaw6wvhzrfsfdlp@xzhoux.usersys.redhat.com/
