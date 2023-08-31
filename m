Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5967578EFC4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Aug 2023 16:49:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236294AbjHaOtu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 31 Aug 2023 10:49:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231181AbjHaOtt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 31 Aug 2023 10:49:49 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E86ECCC5
        for <linux-fsdevel@vger.kernel.org>; Thu, 31 Aug 2023 07:49:45 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-5925e580f12so10404137b3.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 31 Aug 2023 07:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1693493385; x=1694098185; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4/APbOv9kn/U7e/ns21d/zj9IRn9BxSLxyOC3Vac5jA=;
        b=Vfz0ZFK/PLoBG8Ua4HRwpeqPHR9nJCpDvOdN5aCNcjoZg34oZODvP8he1wMWrYYQp1
         IKvvq3iIqlpgsCjbDPRzoaOxFkO71T4o/WQdb/al2nq6wxvHyXPjwD5pdOkg7C1y2796
         y7xW3e6L/7asru9qiy5oZrkKoqq8zBRLe16fjrUsVSbGt8UqhweloxOz0GEqioxotiAR
         blsaKRVeV2+/pplVzCbiGZzqntp+cJIw7BGmcLYx3AH2UZgdOwhmkUXzupbIKFli9xIv
         Bsc8S2ng3Nnp0JgL1NKC90fVtmOqXiPs99hiOY/h3CfotODKATLhtqGIesWlArW3AJrE
         AXNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693493385; x=1694098185;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4/APbOv9kn/U7e/ns21d/zj9IRn9BxSLxyOC3Vac5jA=;
        b=BGI++7g4uGm+/yvF62GUSBY2ul4ZvErga84ar9KoqrYMPr44gpRtVPFQgEBU35g8FD
         tcVyU8C1muKuvo7zouF7qwKBc0qRiZGjSuvAX13xK69c36pe+5X7l1UhZ0FLfJcQaYSL
         Deia9CgKxg19oYnrp5FzwR6ajXcdqeF5N4l4Ml/Unjml8vn1pfMQreXa/Xk3Yx+alUhz
         Qh6DNq0yPu7+qU3gRJElFK6OlMdu9Pwe9viakCIlSqTXFRFMakwLZVCxYGCH+3MuAgGd
         lS5xBLXxcdiUwvAfbRldkDl9vi1cOFCZ+jZY/mN8YdFK8EAkul4eK/6KgQkaoI4eAbuU
         XquA==
X-Gm-Message-State: AOJu0Yw88GA4w/5oe6V5SIG9PKh3BNmyKx6Jimh8rLuNqknlEG/mEsu0
        FsaVyEBr82YshWEIwdXIw6QohLE1XR9cJAIL5Vda
X-Google-Smtp-Source: AGHT+IE/2fXLwQ9H7wEmtmgLdkuJ4AeHMRse2N+C6r3s29gq3FRpbwQgKSdFooDdXmNPdgn6h1+zBKFcbTffYssmlJI=
X-Received: by 2002:a81:a153:0:b0:57a:6bf0:2100 with SMTP id
 y80-20020a81a153000000b0057a6bf02100mr5764469ywg.1.1693493385129; Thu, 31 Aug
 2023 07:49:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230831053157.256319-1-hch@lst.de> <20230831-dazulernen-gepflanzt-8a64056bf362@brauner>
 <20230831-tiefbau-freuden-3e8225acc81d@brauner> <20230831123619.GB11156@lst.de>
 <20230831-wohlig-lehrveranstaltung-7c27e05dc9ae@brauner> <CAHC9VhQOpy=rLNmirT7afkEdf5_PRnLVsdPJQvxqaF0G4JrCgQ@mail.gmail.com>
 <20230831143947.GA16365@lst.de>
In-Reply-To: <20230831143947.GA16365@lst.de>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 31 Aug 2023 10:49:34 -0400
Message-ID: <CAHC9VhSn7Vt7KgNE9UZvfNSD2y8_HVXy96sco=jET+7LhxQUfg@mail.gmail.com>
Subject: Re: sb->s_fs_info freeing fixes
To:     Christoph Hellwig <hch@lst.de>,
        Christian Brauner <brauner@kernel.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>, linux-s390@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 31, 2023 at 10:39=E2=80=AFAM Christoph Hellwig <hch@lst.de> wro=
te:
> On Thu, Aug 31, 2023 at 10:38:09AM -0400, Paul Moore wrote:
> > No need to change anything in this case, but in the future if there
> > are no patch dependency or ordering issues can you let me take the
> > SELinux patches via the SELinux tree?  It helps prevent merge
> > conflicts during the next merge window and quiets the daily automated
> > checks I have in place to detect SELinux changes outside of the
> > SELinux tree.
>
> Even if this goes into the next merge window we'd need it in the vfs
> tree as it is preparation for other work on VFS interfaces.

That's fine, I would consider that part of the "patch dependency" case
I mentioned above.

My motivation for commenting on this is that I've seen a few recent
cases where some other subsystems have been quick to merge SELinux,
etc. patches and I just wanted to ask that some consideration be made
as it causes us (me) some level of pain.  If there is a good reason
for it, that's fine, being a maintainer is a life of pain ;) but if it
is simply to just get the patch merged into an upstream tree a day or
two earlier I would please ask you to exercise patience and let it be
merged via the appropriate tree.

--=20
paul-moore.com
