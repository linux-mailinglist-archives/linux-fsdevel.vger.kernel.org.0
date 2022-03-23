Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 816DD4E53C9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Mar 2022 15:00:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238747AbiCWOBs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Mar 2022 10:01:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244575AbiCWOBp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Mar 2022 10:01:45 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E8717EA0C
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Mar 2022 07:00:15 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id k10so1961289edj.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Mar 2022 07:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4d3TC6ucZyuq0GaJLfYb56R+2q2cWcG09rOvKNcww+Y=;
        b=rFUzZvUj9PsjZGaz0GrV+BnYRedhsb5f6r1ptV1gfdWwY3xslFCdzrM4x24fCLycBF
         9MmlSkTxmB5ZKWfAkT//oYix5YBcg1GZ4A2hycMnzXs6IYSldeqDJ8lhln4BxNICUIAj
         mGDJBuAQAWmHOfAHbGGJKcoRyTOtF9/dlWLZ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4d3TC6ucZyuq0GaJLfYb56R+2q2cWcG09rOvKNcww+Y=;
        b=q7Tkz6H30XbP3XQzN1p3OUU5yxjJVhiZhAELzgxlnlxcWDJXq8ZiqkVnfvTzYfGBGe
         BeXEnCo2r8L8uCQbEuct8ZbjZhgsdr94K9MuQQx8k/b46ABvZZAOpAcyjHRYPJcqGJVl
         OnCS5g1ayI9rUWOsF1u9dBxIj+tMCaxwHh4c8cTnxNhE8gNKSCdz7wi0BnlVH3WP4DAu
         UXFqd+RBic6lsFqH4RNaKTvrbpCEjK8fDEJI4pQXT+zR7lIc6nl4Pqy3iRSMXa7ucGvx
         iw2QW5hR8b7CT/JdG3mhQw5/7A4akNoFLJxuc5eYSZaBY8935bNlHRELoVwKN7wHmkIo
         tHyA==
X-Gm-Message-State: AOAM533vtgJa20OrNWloSNHzHjZY7xsPja7ms5vfKlxSYvtqnFWUO5bJ
        lu+/IaUG3MMmnRXgFsXuwa1GhasaR923Io7yDLIBWA==
X-Google-Smtp-Source: ABdhPJydsCbI4K1DE26qhLWLhXVBLuexIeZknzjGHVibPwTP54CzEhxreoeycnCPeXjsI3G4qYdNmj5hUJK4kLkYjKo=
X-Received: by 2002:a05:6402:5106:b0:419:45cd:7ab0 with SMTP id
 m6-20020a056402510600b0041945cd7ab0mr235899edd.116.1648044014041; Wed, 23 Mar
 2022 07:00:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220322192712.709170-1-mszeredi@redhat.com> <20220323114215.pfrxy2b6vsvqig6a@wittgenstein>
 <CAJfpegsCKEx41KA1S2QJ9gX9BEBG4_d8igA0DT66GFH2ZanspA@mail.gmail.com> <d3333dbe-b4b7-8eb9-4a50-8526d95b5394@schaufler-ca.com>
In-Reply-To: <d3333dbe-b4b7-8eb9-4a50-8526d95b5394@schaufler-ca.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 23 Mar 2022 15:00:01 +0100
Message-ID: <CAJfpegvwTmaw0bp70-nYQAvs8T=wYyxnDEoA=rOvX8HDZnxCTg@mail.gmail.com>
Subject: Re: [RFC PATCH] getvalues(2) prototype
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        Miklos Szeredi <mszeredi@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linux API <linux-api@vger.kernel.org>,
        linux-man <linux-man@vger.kernel.org>,
        LSM <linux-security-module@vger.kernel.org>,
        Karel Zak <kzak@redhat.com>, Ian Kent <raven@themaw.net>,
        David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        Amir Goldstein <amir73il@gmail.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 23 Mar 2022 at 14:51, Casey Schaufler <casey@schaufler-ca.com> wrote:

> You also need a way to get a list off what attributes are available
> and/or a way to get all available attributes. Applications and especially
> libraries shouldn't have to guess what information is relevant. If the
> attributes change depending on the filesystem and/or LSM involved, and
> they do, how can a general purpose library function know what data to
> ask for?

Oh, yes.  Even the current prototype does that:

# ~/getvalues / ""
[] = "mnt" "mntns" "xattr" "data" (len=21)
# ~/getvalues / "mnt"
[mnt] = "id" "parentid" "root" "mountpoint" "options" "shared"
"master" "propagate_from" "unbindable" (len=76)
# ~/getvalues / "mntns"
[mntns] = "21" "22" "24" "25" "23" "26" "27" "28" "29" "30" "31" "32" (len=36)
 ~/getvalues / "mntns:21"
[mntns:21] = "id" "parentid" "root" "mountpoint" "options" "shared"
"master" "propagate_from" "unbindable" (len=76)

I didn't implement enumeration for "data" and "xattr" but that is
certainly possible and not even difficult to do.

Thanks,
Miklos
