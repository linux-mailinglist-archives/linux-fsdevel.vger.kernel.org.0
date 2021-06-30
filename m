Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2DAA3B8008
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Jun 2021 11:32:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233839AbhF3JfH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Jun 2021 05:35:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233541AbhF3JfG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Jun 2021 05:35:06 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49EF4C061756;
        Wed, 30 Jun 2021 02:32:37 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id k11so2353690ioa.5;
        Wed, 30 Jun 2021 02:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s84xWd1p9DCpVsXKf4nBb4ne/r0AwwB4mEPb8wiEAyI=;
        b=UN1bk77/jwJOWukt6oMwSo6iUhXHClYKODyfghK8PfB9VWa4l1/l/HMzJ9eCfBmAVY
         yDz9fINSACQqTpdsRb5CeMw76w6R/xvKtBPqXiatoOJli5lNtsWsn1kh3hgQTneygvoe
         5Ig7OiZhELElAolo8IegDEVw7UdXBLtx1FNOcCXS1GnqH27Z7hd03nVKCNiDScMn3eUR
         DlzEcl9rz1QHkh6GIfL36mJ3wF4DdZmD5mla5pyszMBJRoqyl+ciPqPh7PuQh4HjqjwT
         COkXoWDzGWuE+1qRRx0kAEla7+zwgAxHKAvpPuwgVjjnUeG9h7ymnQsfwyPCQpBzI6QN
         JYfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s84xWd1p9DCpVsXKf4nBb4ne/r0AwwB4mEPb8wiEAyI=;
        b=k8gKe8P2yU7dyY95X1IDRol3i59ZkXySInHRBg5HUHV6kwDXgRef4HR4kU9QMNi6IP
         Aw+rF197cqYlVDGpu9B7aj8JVsm13Ql1ny1b9Lh80tedLMedmcZ1ewIx3HOQSck3NtUf
         NYHRbioI7k9UTrMnW4E/8y7hc5LR7qJOR/yyQI/DmWkqmFoJtKH0pVwHz1lnUVYQmgWe
         ZSfkexI8Uuogc1LPSAM5faTJ+d6w/Mxams7vlDBH/qPnvDVXeA7omtPoF/3/3e2C3g4X
         bRsPzRSh2/M/jzkMFmkqBxxgm6FsONnzQOBpYJHKVN+vy+4F4z0+noaEYyi/6sMAX2Sa
         ZraQ==
X-Gm-Message-State: AOAM530Mefk/oDXQwKar0OljnBh7ZFAGZVj5bq4gsPkBv7K9k9HwCnBi
        0gLxNV4TSzCesOLnEUy/ifN+r9jtcfpz/vXVBvk=
X-Google-Smtp-Source: ABdhPJzRKiwht4hzM+c4fGSMPIvNrQwg2Sdsp4RyakMT4GpWI16QoR9jdY5tYy/M83p5xAdXQKGk9LJB6IEzOfMiVCM=
X-Received: by 2002:a5e:c60b:: with SMTP id f11mr7117430iok.72.1625045556650;
 Wed, 30 Jun 2021 02:32:36 -0700 (PDT)
MIME-Version: 1.0
References: <20210629191035.681913-8-krisman@collabora.com>
 <202106300707.Xg0LaEwy-lkp@intel.com> <CAOQ4uxgRbpzo-AvvBxLQ5ARdFuX53RG+JpPOG8CDoEM2MdsWQQ@mail.gmail.com>
 <20210630084555.GH1983@kadam>
In-Reply-To: <20210630084555.GH1983@kadam>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 30 Jun 2021 12:32:25 +0300
Message-ID: <CAOQ4uxiCYBL2-FVMbn2RWcQnueueVoAd5sBtte+twLoU9eyFgA@mail.gmail.com>
Subject: Re: [PATCH v3 07/15] fsnotify: pass arguments of fsnotify() in struct fsnotify_event_info
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     kbuild@lists.01.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kbuild test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        "Darrick J. Wong" <djwong@kernel.org>,
        Theodore Tso <tytso@mit.edu>,
        Dave Chinner <david@fromorbit.com>, Jan Kara <jack@suse.com>,
        David Howells <dhowells@redhat.com>,
        Khazhismel Kumykov <khazhy@google.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Ext4 <linux-ext4@vger.kernel.org>, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 30, 2021 at 11:46 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> On Wed, Jun 30, 2021 at 11:35:32AM +0300, Amir Goldstein wrote:
> >
> > Do you have feeling of dejavu? ;-)
> > https://lore.kernel.org/linux-fsdevel/20200730192537.GB13525@quack2.suse.cz/
>
> That was a year ago.  I have trouble remembering emails I sent
> yesterday.
>
> >
> > We've been through this.
> > Maybe you silenced the smach warning on fsnotify() and the rename to
> > __fsnotifty()
> > caused this warning to refloat?
>
> Yes.  Renaming the function will make it show up as a new warning.  Also
> this is an email from the kbuild-bot and last years email was from me,
> so it's a different tool and a different record of sent messages.
>
> (IMO, you should really just remove the bogus NULL checks because
> everyone looking at the warning will think the code is buggy).
>

I think the warning is really incorrect.
Why does it presume that event_info->dir is non-NULL?
Did smach check all the callers to fsnotify() or something?
What about future callers that will pass NULL, just like this one:

https://lore.kernel.org/linux-fsdevel/20210629191035.681913-12-krisman@collabora.com/

Please fix the tool.

Thanks,
Amir.
