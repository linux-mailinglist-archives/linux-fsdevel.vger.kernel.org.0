Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 777907B55F6
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Oct 2023 17:02:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237850AbjJBOrh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Oct 2023 10:47:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237627AbjJBOrf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Oct 2023 10:47:35 -0400
Received: from mail-ua1-x931.google.com (mail-ua1-x931.google.com [IPv6:2607:f8b0:4864:20::931])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C161394
        for <linux-fsdevel@vger.kernel.org>; Mon,  2 Oct 2023 07:47:32 -0700 (PDT)
Received: by mail-ua1-x931.google.com with SMTP id a1e0cc1a2514c-7ab5150a7b5so2207592241.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Oct 2023 07:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696258052; x=1696862852; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kus6Ylnx/Z8FfR7MRXzFPZZu3r0Yj55RMyjgjMumJ9E=;
        b=MVt+Zv1fk0SFplsMjYRGdRVFi3etatkyeTlVY6nj/VuTTk/sEWqukx+AS+d+N/TQqd
         hrux8dvafC4ED28Z/o2y7fFIoZC1+VK2RIc/ywKH5/ltn8XLOPH2vw99kpqghB4ehIWx
         T0qpoE6ipokoZeBnCbEN4sfnFtbbINFhw0+0M5mDeKVcScINMeKnz2HEGw6CMzbHDDl3
         bsrlgz2FJDt6jUpaLqmTAWUNt89z+GZHdIwhKz0QowhLpHo1tbJmfJQZeYhzTOiVRrMC
         qtUdI2S7k2pO4esLnSC4VMwx+Pox/fqgare7yNzSZ5SmzMYtPvxc3RJ6weW0TbcFAfxj
         njqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696258052; x=1696862852;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kus6Ylnx/Z8FfR7MRXzFPZZu3r0Yj55RMyjgjMumJ9E=;
        b=QTjIp3mpMpk9V25ZTDUOKrX8DslVUkJiHwJBox5HKMUaoqN0vfLew/GcJq3RRGQBdn
         LxojnDM7r1cgektqzgv5o0aqicD1GeuHS4VddhNRx0E+3W7V6V0HTQwgqrji2+0Z4yZ1
         jcUH2OclvPq6BL/gJc37P4drMUaoaHRR1Jm5QTUbT/b+ptykNVbpWyn9i5PEvU9BKq7N
         F4i30BqwPmODthrl1PSP/dpvHiXEuGeCYJ12xZATCVW2Z4RDHBYaBtyRpDbw4cPRv5W9
         STA4TnEB0M1cxQ+JQAJzAu3fMGGRYyrygobNt9T2U0/qbwW4muQYJZM7ysDNNUpTJmz1
         rJwQ==
X-Gm-Message-State: AOJu0YxUNoq0jHNor3xR8UqdKRY1tKZDKpkM9l4E7MEYuwpMEA537VTD
        6NrDqnEMNt2aMbwky5yDigLSoDXlDRxfi8BEbNY=
X-Google-Smtp-Source: AGHT+IEq2xEH2YMdVgijpmZkvKC8W7zXJD6weEGy0FA6Pu0nSFl/8leuqxra8mwW+oKawlm5PbMngnVnityddAGrsF8=
X-Received: by 2002:a05:6102:4a86:b0:452:7341:a098 with SMTP id
 hz6-20020a0561024a8600b004527341a098mr5019481vsb.0.1696258051700; Mon, 02 Oct
 2023 07:47:31 -0700 (PDT)
MIME-Version: 1.0
References: <20231002022815.GQ800259@ZenIV> <20231002022846.GA3389589@ZenIV>
 <20231002023613.GN3389589@ZenIV> <20231002023643.GO3389589@ZenIV>
 <CAOQ4uxjLuk9XF8Yhy8Ym2Zt_iquKojY9-Yyxz9w8kV0CTooEmw@mail.gmail.com> <CAOQ4uxgedDFLmjjkWQEnqXD+n-O+1hJ9SbPpizk93YJ0HFp0vw@mail.gmail.com>
In-Reply-To: <CAOQ4uxgedDFLmjjkWQEnqXD+n-O+1hJ9SbPpizk93YJ0HFp0vw@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 2 Oct 2023 17:47:20 +0300
Message-ID: <CAOQ4uxh1KLg5e4J77jrR4dgvfMyMKz9NrqnLveAHy=Kk-9VzJQ@mail.gmail.com>
Subject: Re: [PATCH 14/15] ovl_dentry_revalidate_common(): fetch inode once
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Namjae Jeon <linkinjeon@kernel.org>,
        David Sterba <dsterba@suse.com>,
        David Howells <dhowells@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Bob Peterson <rpeterso@redhat.com>,
        Steve French <sfrench@samba.org>,
        Luis Chamberlain <mcgrof@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 2, 2023 at 8:56=E2=80=AFAM Amir Goldstein <amir73il@gmail.com> =
wrote:
>
> On Mon, Oct 2, 2023 at 8:47=E2=80=AFAM Amir Goldstein <amir73il@gmail.com=
> wrote:
> >
> > On Mon, Oct 2, 2023 at 5:36=E2=80=AFAM Al Viro <viro@zeniv.linux.org.uk=
> wrote:
> > >
> > > d_inode_rcu() is right - we might be in rcu pathwalk;
> > > however, OVL_E() hides plain d_inode() on the same dentry...
> > >
> > > Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> >
> > Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> >
> > However, ovl_lowerstack(oe) does not appear to be stable in RCU walk...
> >
>
> Ah, you fixed that in another patch.
> If you are going to be sending this to Linus, please add
> Fixes: a6ff2bc0be17 ("ovl: use OVL_E() and OVL_E_FLAGS() accessors")
>
> I was going to send some fixes this week anyway, so I can
> pick those through the overlayfs tree if you like.
>

Al,

From all your series, the two ovl fixes are for rather new regressions (v6.=
5)
so I queued your two regression fixes (13,14) and my own version of patch 1=
5
to go into linux-next via overlayfs tree [1] and I will send them to Linus =
later
this week, so they can make their way to 6.5.y.

Thanks,
Amir.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/overlayfs/vfs.git/log/?=
h=3Dovl-fixes
