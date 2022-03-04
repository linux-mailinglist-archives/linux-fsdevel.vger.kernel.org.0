Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36A084CDE1A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Mar 2022 21:25:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231360AbiCDUOF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Mar 2022 15:14:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231574AbiCDUM5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Mar 2022 15:12:57 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4319DA76C9
        for <linux-fsdevel@vger.kernel.org>; Fri,  4 Mar 2022 12:07:26 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id w7so2342352lfd.6
        for <linux-fsdevel@vger.kernel.org>; Fri, 04 Mar 2022 12:07:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kZyH729NT2yn4PFlitZVu3CPE3eAWcokNu/jiYcSZus=;
        b=Vs6KQRjGcBn3qOpTM8KnDSOHEu0zv1Fn4twWQ9KFUsFUosnDOV+sFhSNc0JviL9HSa
         OdDX7EpHNVqQaVjn60KbVfz1y0paaj7aNMnRoJnCEH3372hdkYFImdiJrsMkvJ9RAy0C
         ZOC8Z4qoOM15u1huGxJeNnig5GNH4+HcyYiH7u40Yb4fAENLav7Kn8uEKtIydDzMP8NP
         fLUbZWeQyfmzIivuvCYv/c1cMU+MX6VqV2Q9eLCcXIYJfPb7cqRuNF0BTnT9pVZ+EYbu
         SlIfnmLsQFH3QSZRZvisJ7uZPU5Dvpjogan2IwNVVKHxt/VlB7KXkSaFb4fkidWoURwp
         W6bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kZyH729NT2yn4PFlitZVu3CPE3eAWcokNu/jiYcSZus=;
        b=2riNU2dBK28vUwsipGOG/AGn+Z7EuyRMvan/9+JDapYx3TVdJrrh3eKxhbUeJtCBPM
         UaNU9mf6G6FyHx+YXy4WF5BB/57ZTlHI5hm7LREtqZ66zRHC9AD2tbAKkZMFrJN5SmrD
         hQWEWiWubhE2nYfGrTpbpNPscWTpj0WXJCUaMRSmyiP9y4mF/0EgEjcj3Giwh90naqTD
         QKN3Mlugf4vn+hxt1Zd6dT54lu2HipA2hv11ONaHiuOv+2OcWHReU4kYhaTQE0X/nDe5
         jlDN4MvWgBcDJQPsASaZiTgd7Y5traxSHll0GWbI9D5SGK5LPy5xUSEkdzI/cFySohmx
         BElw==
X-Gm-Message-State: AOAM530MhL8ex9X/z2DARImOMDutSVQ5UR5sdzRP6oxR/idQY5MBpEXK
        EvOX2xr38fehw1NT6OVSuV5zy/9lOoFUBTDJBQk=
X-Google-Smtp-Source: ABdhPJy4eap6OtwOJ1F8l1RQb8VQ9DYMQWJhf+91PNfoDvxa4i7SrEZjNDZrhewKI9i20S0/gSFhEJ9Yo0ooiqIkqY8=
X-Received: by 2002:a05:6512:c09:b0:438:df07:a97e with SMTP id
 z9-20020a0565120c0900b00438df07a97emr241767lfu.667.1646424415792; Fri, 04 Mar
 2022 12:06:55 -0800 (PST)
MIME-Version: 1.0
References: <2571706.1643663173@warthog.procyon.org.uk> <1CAF5D33-E854-4B82-AC32-0FDCF1894253@oracle.com>
In-Reply-To: <1CAF5D33-E854-4B82-AC32-0FDCF1894253@oracle.com>
From:   Steve French <smfrench@gmail.com>
Date:   Fri, 4 Mar 2022 14:06:44 -0600
Message-ID: <CAH2r5muY-bh6H5SSmAF37TAHiZCSa8-UbMKk2=HQEmxyK1vdsQ@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] Netfs support library
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     David Howells <dhowells@redhat.com>,
        "lsf-pc@lists.linux-foundation.org" 
        <lsf-pc@lists.linux-foundation.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "jlayton@kernel.org" <jlayton@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 1, 2022 at 10:51 PM Chuck Lever III <chuck.lever@oracle.com> wrote:
>
> > On Jan 31, 2022, at 4:06 PM, David Howells <dhowells@redhat.com> wrote:
> >
> > I've been working on a library (in fs/netfs/) to provide network filesystem
> > support services, with help particularly from Jeff Layton.  The idea is to
> > move the common features of the VM interface, including request splitting,
> > operation retrying, local caching, content encryption, bounce buffering and
> > compression into one place so that various filesystems can share it.
>
> IIUC this suite of functions is beneficial mainly to clients,
> is that correct? I'd like to be clear about that, this is not
> an objection to the topic.
>
> I'm interested in discussing how folios might work for the
> NFS _server_, perhaps as a separate or adjunct conversation.

That is an interesting point.   Would like to also discuss whether it
could help ksmbd,
and would like to continue discussion of netfs improvements - especially am
interested in how we can improve throttling when network (or server)
is congested
(or as network adapters are added/removed and additional bandwidth is
available).


-- 
Thanks,

Steve
