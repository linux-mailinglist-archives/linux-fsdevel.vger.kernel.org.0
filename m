Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 795DF23D25E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Aug 2020 22:12:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729754AbgHEUMK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Aug 2020 16:12:10 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:38234 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726897AbgHEQZe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Aug 2020 12:25:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596644702;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RDiNTwaajX9EstP2+rkOoaOqP4Sp0ty/xDldPk1nRuY=;
        b=ZLdpXk/HNS+AUi3ROo21rtg5Qv/XEfMrWtwgHBP6n1uUNof4vHLTDb87x3rxT0koc07SI1
        KTy/QnlzYkehHheLsKET1MfkI4cCZ3DuAAVbypP255ovHcsjVT2UagoKVgj5mgELRtEPhL
        jo0xtTQdhi26UO7nuMhsfxoSWEsvsFk=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-218-ZgJkMwTZMt6hgl4TE4nnUw-1; Wed, 05 Aug 2020 11:54:43 -0400
X-MC-Unique: ZgJkMwTZMt6hgl4TE4nnUw-1
Received: by mail-oi1-f200.google.com with SMTP id 11so18437142oii.10
        for <linux-fsdevel@vger.kernel.org>; Wed, 05 Aug 2020 08:54:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RDiNTwaajX9EstP2+rkOoaOqP4Sp0ty/xDldPk1nRuY=;
        b=o8EfbB4+POxy5/BhHKiEMSz3r7faqorAhVgvp7KABou6OEcioOM66K5G8mary+8IJv
         W5DrpILXjDTPoNC5c4pX3MKNgzG72k5K4VyEZB8uRNIP9kfWy5x5UDVJTuCwQy5javYV
         ZyMLtZJvp0kL3b/hAlvcQk+UHN6ZU3sOW0inuUZkHtKVAHH4ntgbiOZiJWN1Cshtfyu6
         oT6+o/PB6+4SmlAchFsiZT4TtzbWPmIB8LCINFAQAYzkhHYV690G9C7bYRUnwZX75zYC
         vtmSfJO57oaKVZJNnCzh3NdpzI14Y1hlLEC3EgjUd/1z3RzxAUBu+Hc1OQPu5fMxscXM
         Zzuw==
X-Gm-Message-State: AOAM530mGPChA9/fHoUBtdi+zyMpU0krdPoTD1wVEpEWHOy9Y6pQDiiW
        ufJ7cqSmZf3ri7GMxfxtmPVTDDxoe4xU9V5CUkjSuPZTJYxkDCK95ye8S1jGr7bSGkaLv3LZcBN
        DY93+SPhYXJokySeHT/f+EF0VwXfADGzCHFcDOIM1wQ==
X-Received: by 2002:a9d:3784:: with SMTP id x4mr3040067otb.95.1596642882738;
        Wed, 05 Aug 2020 08:54:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxFNuf696slwlPSZJynKjLvYPlN0RCiKIOzOVmS4vUbpxiRMAJuurwOtGRZDzCz52Sm2DXwT3decGCiphYpc3o=
X-Received: by 2002:a9d:3784:: with SMTP id x4mr3040047otb.95.1596642882501;
 Wed, 05 Aug 2020 08:54:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200805153214.GA6090@magnolia>
In-Reply-To: <20200805153214.GA6090@magnolia>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Wed, 5 Aug 2020 17:54:31 +0200
Message-ID: <CAHc6FU6yMnuKdVsAXkWgwr2ViMSXJdBXksrQDvHwaaw4p8u0rQ@mail.gmail.com>
Subject: Re: [GIT PULL] iomap: new code for 5.9-rc1
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-xfs@vger.kernel.org, Dave Chinner <david@fromorbit.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Eric Sandeen <sandeen@sandeen.net>,
        Christoph Hellwig <hch@lst.de>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>, riteshh@linux.ibm.com,
        Goldwyn Rodrigues <rgoldwyn@suse.de>,
        linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Darrick,

On Wed, Aug 5, 2020 at 5:40 PM Darrick J. Wong <djwong@kernel.org> wrote:
> ----------------------------------------------------------------
> Andreas Gruenbacher (1):
>       iomap: Make sure iomap_end is called after iomap_begin

that commit (d1b4f507d71de) contains the following garbage in the
commit message:

    The message from this sender included one or more files
    which could not be scanned for virus detection; do not
    open these files unless you are certain of the sender's intent.

    ----------------------------------------------------------------------

How did it come to that?

Thanks,
Andreas

