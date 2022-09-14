Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5722E5B8D11
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Sep 2022 18:31:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbiINQbN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Sep 2022 12:31:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230080AbiINQat (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Sep 2022 12:30:49 -0400
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6EE1D87;
        Wed, 14 Sep 2022 09:29:28 -0700 (PDT)
Received: by mail-vs1-xe36.google.com with SMTP id j17so9067188vsp.5;
        Wed, 14 Sep 2022 09:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=a3dst0aSf2zayTlO/YB7FAv0EeIEaJQ9bTaWo3LOZD0=;
        b=Q46TWpeHpm3O8AV6cy/41MaIU4mILJKzGYvmwpMVTC2cWO2EIcAjk9sDvtxDX2+UW5
         uXdDf07csx+MytlIA6RUsWPgJCbUEbOmJ/P/cp1AOHa7qcNik0xurGNXJisjFS971Lz/
         n4j7ul6dus5OltUXeFnIEM0q3s+2fbUtmQMJJGsF1lnUoeX6ruVuc5AV//mdC1yps2O2
         Im4NelpDLpVqvhUlq28KiKTLf8W0O6ri21wxaRSkiGBjxNkrJ/naqBxRMIiXXqOUjSm5
         dFINuSenJbWSAHKmNPXYp8EMpYwO+A7FT+Vs+iVH10NZruoG6e1UjsQLt3DtQHyPC9hX
         9wdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=a3dst0aSf2zayTlO/YB7FAv0EeIEaJQ9bTaWo3LOZD0=;
        b=WvFo/YeIci1s7KfMY4wlnn9JXSVkhomnu3xhoEdWtOnjKibeq4dVDhRjP+q5S2RKWg
         LnqokRdeHJnZC6GUu0DJ9qCUeyf5PwlaG9GelumY9lIv2n/neSH40dv7ezIxRxOV9eax
         ANcb/F+SQQvwXbcnnVu9dt1fs54dWftnADe/jAuIm/HHKO+jytmlXQN6XfCJrnyNJXmz
         1XF0u4Fs7UJf9uo+zDssZlB8ocLZrkKxwKvQ2qy5UUrJMHvVqp2uu9NGHS7Xb1qQasr3
         IOvnaYEkJLVhJZQyTMfZfD79yoCfU9ALhYVXpXn2XE4IfyiPqcV7FT33Mcr6nZdd90u5
         MunQ==
X-Gm-Message-State: ACgBeo0VKfXLtEt6bbozkI4y0dXe5BhmtuU0QtqyWXZ/HDCDMYviOmZZ
        AzVVGqmmBsv1eJdi74hGds5/NqQ91TEXDSAonYY=
X-Google-Smtp-Source: AA6agR5+ImxaL4AeQP9SfBAnuGBXvLDNf9jUU3kPq0qe/zzqhTj536JyL3hbnqlLloq/uT7lgfdxr7WObpcVT18/kng=
X-Received: by 2002:a67:a243:0:b0:398:a30e:1566 with SMTP id
 t3-20020a67a243000000b00398a30e1566mr4430524vsh.2.1663172967364; Wed, 14 Sep
 2022 09:29:27 -0700 (PDT)
MIME-Version: 1.0
References: <CAOQ4uxhxgYASST1k-UaqfbLL9ERquHaKL2jtydB2+iF9aT8SRQ@mail.gmail.com>
 <20190409082605.GA8107@quack2.suse.cz> <CAOQ4uxgu4uKJp5t+RoumMneR6bw_k0CRhGhU-SLAky4VHSg9MQ@mail.gmail.com>
 <20220617151135.yc6vytge6hjabsuz@quack3> <CAOQ4uxjvx33KRSm-HX2AjL=aB5yO=FeWokZ1usDKW7+R4Ednhg@mail.gmail.com>
 <20220620091136.4uosazpwkmt65a5d@quack3.lan> <CAOQ4uxg+uY5PdcU1=RyDWCxbP4gJB3jH1zkAj=RpfndH9czXbg@mail.gmail.com>
 <20220621085956.y5wyopfgzmqkaeiw@quack3.lan> <CAOQ4uxheatf+GCHxbUDQ4s4YSQib3qeYVeXZwEicR9fURrEFBA@mail.gmail.com>
 <CAOQ4uxguwnx4AxXqp_zjg39ZUaTGJEM2wNUPnNdtiqV2Q9woqA@mail.gmail.com> <YyH61deSiW1TnY//@magnolia>
In-Reply-To: <YyH61deSiW1TnY//@magnolia>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 14 Sep 2022 19:29:15 +0300
Message-ID: <CAOQ4uxhFJWW-ykyzomHCUWfWvbJNEmetw0G5mUYjFGoYJBb7NA@mail.gmail.com>
Subject: Re: [POC][PATCH] xfs: reduce ilock contention on buffered randrw workload
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
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

> > Dave, Christoph,
> >
> > I know that you said that changing the atomic buffered read semantics
> > is out of the question and that you also objected to a mount option
> > (which nobody will know how to use) and I accept that.
> >
> > Given that a performant range locks implementation is not something
> > trivial to accomplish (Dave please correct me if I am wrong),
> > and given the massive performance impact of XFS_IOLOCK_SHARED
> > on this workload,
> > what do you think about POSIX_FADV_TORN_RW that a specific
> > application can use to opt-out of atomic buffer read semantics?
> >
> > The specific application that I want to modify to use this hint is Samba.
> > Samba uses IO threads by default to issue pread/pwrite on the server
> > for IO requested by the SMB client. The IO size is normally larger than
> > xfs block size and the range may not be block aligned.
> >
> > The SMB protocol has explicit byte range locks and the server implements
> > them, so it is pretty safe to assume that a client that did not request
> > range locks does not need xfs to do the implicit range locking for it.
> >
> > For this reason and because of the huge performance win,
> > I would like to implement POSIX_FADV_TORN_RW in xfs and
> > have Samba try to set this hint when supported.
> >
> > It is very much possible that NFSv4 servers (user and kennel)
> > would also want to set this hint for very similar reasons.
> >
> > Thoughts?
>
> How about range locks for i_rwsem and invalidate_lock?  That could
> reduce contention on VM farms, though I can only assume that, given that
> I don't have a reference implementation to play with...
>

If you are asking if I have the bandwidth to work on range lock
then the answer is that I do not.

IIRC, Dave had a WIP and ran some benchmarks with range locks,
but I do not know at which state that work is.

The question is, if application developers know (or believe)
that their application does not care about torn reads, are we
insisting not to allow them to opt out of atomic buffered reads
(which they do not need) because noone has the time to
work on range locks?

If that is the final decision then if customers come to me to
complain about this workload, my response will be:

If this workload is important for your application, either
- contribute developer resource to work on range locks
- carry a patch in your kernel
or
- switch to another filesystem for this workload

Thanks,
Amir.
