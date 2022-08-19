Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 057AF5992ED
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Aug 2022 04:07:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344113AbiHSCHP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Aug 2022 22:07:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235159AbiHSCHO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Aug 2022 22:07:14 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73D85D1E33
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Aug 2022 19:07:12 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id j5so3436140oih.6
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Aug 2022 19:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=7FnofYSJQVqMcwObKiPoclmUUgog9bhmYO53YPglp1g=;
        b=GX8kGc2VNDTD33NJ/fvEi1ucSQdLqQ7hwf5zCrmTGt4qPXCTu/n1o61/RVTMAy1TKM
         sI/ZErSSKKeTEfTy7gW5ozAX4kYZ9gdaOMpYknqrUzd2hYTodMJ/a0GVQic7Y46Lz+a3
         o74vy6ZRtANrFfDTVPP616J23XshowlWQD0IUNT5mfUv6Hux8r3eJ+N48x1k1hSmB+mU
         oEfs07GB24v+owqIGmgGwhL0wc5CZX6TJ6/VDf/Up6Qnw4UYisHDbWm/db0ROUF4nsfw
         h0xKbWmRPyl/ZvzL2IFxirIOJnAdRWwN94r5wap/LAacMya0Bx0cHcilqULYlyUGY/Hj
         mUbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=7FnofYSJQVqMcwObKiPoclmUUgog9bhmYO53YPglp1g=;
        b=ar7FjBLh4QPjkvJDu7bYP0M/6MdlrR27O4PBUvzalIdiqBVtVGcmSkffSZcnKsUu/Q
         C0d+bVmX/IxxOZ0loCnbm4GB+2aV8KTrSc1bfcOxrL/jQK4xBqQIA6TUaTgdXEMoP45j
         1O79SZrWhyWF7hrC5k+N6imgKcLGy/JkFw3vf2390wZ6NjA7aHd6WwtJ7QRpGK4iutV9
         5D4nqkTT0nGLO8iqFgrH5DxVCoPXPnO5HgPcGAO0bmz2bX7prC+4BQnORKcE2mXzZVkK
         ACgcd59Lw2NaRGm5V8K8ooiH0Wjb+A0j1THi3qkqKjLI7V0FS4E3wi0nKdIJKPdWetap
         oVjA==
X-Gm-Message-State: ACgBeo2tiEbic8FhcdAI+gBrlFhCIsVVqS/avrJP8Udd0UUrbUiD8gYV
        4HDegKEv3dH9M2TMCM3VLCYukO1vdJkg0w6CkhjD
X-Google-Smtp-Source: AA6agR6cj8VSpjI/zApuASeCp69SrwPgQ8cO+N+6GBvKR4OZOomr/8/vSNzS2f2WUZvq2z45LGjtxYHiuXLI20C0OyI=
X-Received: by 2002:aca:b7d5:0:b0:343:c478:91c6 with SMTP id
 h204-20020acab7d5000000b00343c47891c6mr2523807oif.136.1660874831825; Thu, 18
 Aug 2022 19:07:11 -0700 (PDT)
MIME-Version: 1.0
References: <165970659095.2812394.6868894171102318796.stgit@warthog.procyon.org.uk>
 <CAFqZXNv+ahpN3Hdv54ixa4u-LKaqTtCyjtkpzKGbv7x4dzwc0Q@mail.gmail.com>
 <CAHC9VhTpqvFbjKG5FMKGRBRHavOUrsCSFgayh+BNgSrry8bWLg@mail.gmail.com> <2026286.1660828477@warthog.procyon.org.uk>
In-Reply-To: <2026286.1660828477@warthog.procyon.org.uk>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 18 Aug 2022 22:07:01 -0400
Message-ID: <CAHC9VhSVRgSK_ShwShcYnnDOg+mR0V9WEodVmJ=c5_UzK3KLiQ@mail.gmail.com>
Subject: Re: [PATCH v3] nfs: Fix automount superblock LSM init problem,
 preventing sb sharing
To:     David Howells <dhowells@redhat.com>
Cc:     Ondrej Mosnacek <omosnace@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Scott Mayhew <smayhew@redhat.com>,
        Jeff Layton <jlayton@kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        linux-nfs <linux-nfs@vger.kernel.org>,
        SElinux list <selinux@vger.kernel.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        dwysocha@redhat.com,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 18, 2022 at 9:14 AM David Howells <dhowells@redhat.com> wrote:
> Paul Moore <paul@paul-moore.com> wrote:
>
> > I guess my question is this: for inodes inside the superblock, does
> > their superblock pointer point to the submount's superblock, or the
> > parent filesystem's superblock?
>
> They have to point to the submount superblock.  Too many things would break, I
> think, if inode->i_sb pointed to the wrong place.  As far as the VFS is
> concerned, apart from the way it is mounted, it's a perfectly normal
> superblock.

If the submount inodes point back to the submount's superblock then it
seems reasonable that the rootcontext should remain unset to me.

-- 
paul-moore.com
