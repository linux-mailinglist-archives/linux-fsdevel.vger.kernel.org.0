Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69DCF4A8F79
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Feb 2022 22:00:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241914AbiBCVAJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Feb 2022 16:00:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235108AbiBCVAJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Feb 2022 16:00:09 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDBFEC061714
        for <linux-fsdevel@vger.kernel.org>; Thu,  3 Feb 2022 13:00:08 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id u6so8523769lfm.10
        for <linux-fsdevel@vger.kernel.org>; Thu, 03 Feb 2022 13:00:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4N7PqfjG8NYTd1JxGKAWQKYfepZMkhiCoUV9uFDaNoQ=;
        b=AqwXByWd9Dqbfvq0EYeqmMFuomK7Z7qnVcWvOwo+3jkHTBHlUNo9vNE2pvXBo5kJDA
         MAcwE1NE14aZkP/ksQN3BHPrBHVSZlsvwnBTJi7QoRDEZiZ3X3LsQZTzuB2CiMomnSe7
         NJmrFTzUIFwnJCDqqOulyb4uy+fVi/E08UY3XN4SF1OO+ES43XV73XbEuvtosh5UvjuV
         QCPrATlmibYpHEorJDDmiuaeBh3V2ntWs0uc4q7qs/F7Ed+Ico0zfImVPAMCQt50lvvP
         8TYe+my9PViKxVYrvCEEjNJCS1Rc+94FUe8X9EJeRlmoMherUf7r/F1As1MInt+8olpP
         TuRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4N7PqfjG8NYTd1JxGKAWQKYfepZMkhiCoUV9uFDaNoQ=;
        b=rV+pRTvXiA/LEQiXrIso7NyqHmBphkTuR4qa4qSXhfaajp4uwwxCIR9/AY44KaNiM6
         s6ablFDobcbRHkut+1lPdTtPDlp4hp5h0VpqqF3Qba5pYw3OB4y2trxuPSWFYMOaP418
         JkRdU3Xbn97CU/jtJg74eAGV9tEbpdx0jmavMxaDuF5bII/Qag5tDc2EAO+9hdhfVq5l
         9Es4ZIW4JMJwxpLPPBjLegOvxwLZs99lE5UfaKJl4P47S2on+54/4tlxvN6x1MRbRcFu
         yZn2e0/f5rHT+1SqyI3LWX727j1x3Z0DmWVPNorDP/XWrbxYAUQrggKD1NxA9tYwWRKD
         hrPQ==
X-Gm-Message-State: AOAM530oMDmBq89Hrwh2CI/U+rTDwdFtEnKXAfUzxe5IuHfvfW3sZnPV
        Vt5paTdNB20O9il+kCwVNSUHYIYZp0BMYgGuWMs=
X-Google-Smtp-Source: ABdhPJwTqEfJBRhr2r8U4P42fKqLcQcUTud109X4kZ0GcF+M6zZxmfc9goZMjCBVTxfL0puyVUCkzVxygAw13nI5SP8=
X-Received: by 2002:ac2:5c4d:: with SMTP id s13mr28579813lfp.320.1643922006944;
 Thu, 03 Feb 2022 13:00:06 -0800 (PST)
MIME-Version: 1.0
References: <2571706.1643663173@warthog.procyon.org.uk>
In-Reply-To: <2571706.1643663173@warthog.procyon.org.uk>
From:   Steve French <smfrench@gmail.com>
Date:   Thu, 3 Feb 2022 14:59:56 -0600
Message-ID: <CAH2r5mvwzYsymq0qJWhkHsDbZYpNzvY8J6OFQVbQh4jRkhrtEA@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] Netfs support library
To:     David Howells <dhowells@redhat.com>
Cc:     lsf-pc@lists.linux-foundation.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Jeff Layton <jlayton@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This discussion of netfs, folios and loosely related fscache changes
is important for multiple filesystems, and I would be very interested
in participating.   I think a BoF on the network fs related parts of
it makes sense, but the folios topic is broad enough to for an FS
track session.

On Tue, Feb 1, 2022 at 2:50 PM David Howells <dhowells@redhat.com> wrote:
>
> I've been working on a library (in fs/netfs/) to provide network filesystem
> support services, with help particularly from Jeff Layton.  The idea is to
> move the common features of the VM interface, including request splitting,
> operation retrying, local caching, content encryption, bounce buffering and
> compression into one place so that various filesystems can share it.
>
> This also intersects with the folios topic as one of the reasons for this now
> is to hide as much of the existence of folios/pages from the filesystem,
> instead giving it persistent iov iterators to describe the buffers available
> to it.
>
> It could be useful to get various network filesystem maintainers together to
> discuss it and how to do parts of it and how to roll it out into more
> filesystems if it suits them.  This might qualify more for a BoF session than
> a full FS track session.
>
> Further, discussion of designing a more effective cache backend could be
> useful.  I'm thinking along the lines of something that can store its data on
> a single file (or a raw blockdev) with indexing along the lines of what
> filesystem drivers such as openafs do.
>
> David
>


-- 
Thanks,

Steve
