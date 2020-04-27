Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 121551BAE23
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Apr 2020 21:41:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726508AbgD0TlE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Apr 2020 15:41:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725919AbgD0TlE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Apr 2020 15:41:04 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCE79C0610D5;
        Mon, 27 Apr 2020 12:41:03 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id c3so28359739otp.8;
        Mon, 27 Apr 2020 12:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KJgjJqfYxYx1DamhB8SHVDVYVYMTaoNULn4soSfif8o=;
        b=Awr/3rYcBw7IUNxOE2pHd9iUsxf+b+0F5oivdZ0gMq4uA1hkZgEw1VVHuOGZWBnp5Z
         TIp3PNk6UW5NbnIkEyua/1uxF661Lz1zCOl9fCPsE3eF7ib9CcqRstWRMzX2YN0RApif
         J7mPUujaPVFsvPRM81KcDC9mr8hcliXZUi+4Ba1c9w6Gcf4P569SoJofFY4DJ2b78UPs
         djVyHuPPLi2KmetXOMEjR4ccGdlKV5P7Y/xwSjYA5ais585oWyKjE53PS0pf1SuiJsdC
         J/1ZckW+XEo9p1xknc3mqgDPAeU1CrRqUmjkHFzbCfawVx3NTMkqZ72cJl2Gw189Ywum
         2XYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KJgjJqfYxYx1DamhB8SHVDVYVYMTaoNULn4soSfif8o=;
        b=IrsKeFfhexGH9Ed/VZXB7fbFz1HwnAuCiaSbLXnYlzZXNGEgX2JI/XzJoJPDEl/K4z
         hREdBFCyw5mKaUbvHFvLYbrTdisAfakT110O555rnf9UZsOzNnV7qGKHqDxU/BNT0pPX
         tKqrCy4NXk5izIIuBaJcDtTDDz8R8YKYGXOWS26KicFdEZUFxAt/KChflE0PV9l67oqS
         M5eKsJk/Qai3d/+2NNr2pa4wMRklK0JKrp30AjezMuD+NrXzjq1aONF3PFWdCY4tNpyS
         c+9PY8n6sLTfnHzBjs2BHdvGlDgcmUiPBuUUoMk/XET+IwhSPimwDWdMCAILrF7KSXB/
         XjgA==
X-Gm-Message-State: AGi0PuZZNrjO+G+xK/OHDChNgC4Jx5sZWlhdXAmVnnf+phRnkrcGnVGo
        q5fvr+Fq/Ud7bTSASeqEpXuZ0FBmQSCRYQOdrsE=
X-Google-Smtp-Source: APiQypJ1FMuh3neyv5Ove0+Oveml6rJ7zmUzQYEa8VLdUSSnKo/+3+qY5TyFQK4Y9SO0B4S0U5QMWyP+fowj5p+NOTE=
X-Received: by 2002:aca:5e0b:: with SMTP id s11mr213497oib.160.1588016463282;
 Mon, 27 Apr 2020 12:41:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200326200634.222009-1-dancol@google.com> <20200401213903.182112-1-dancol@google.com>
 <CAKOZueuu=bGt4O0xjiV=9_PC_8Ey8pa3NjtJ7+O-nHCcYbLnEg@mail.gmail.com>
 <alpine.LRH.2.21.2004230253530.12318@namei.org> <02468636-c981-2502-d4f4-58afbf8506b1@schaufler-ca.com>
In-Reply-To: <02468636-c981-2502-d4f4-58afbf8506b1@schaufler-ca.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Mon, 27 Apr 2020 15:40:51 -0400
Message-ID: <CAEjxPJ4WKu9L4Bey1YVo3-tb0Td7Lz5WYw=d1jJ-TN5j5QMcAg@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] SELinux support for anonymous inodes and UFFD
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     James Morris <jmorris@namei.org>,
        Daniel Colascione <dancol@google.com>,
        Tim Murray <timmurray@google.com>,
        SElinux list <selinux@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, kvm@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Paul Moore <paul@paul-moore.com>,
        Nick Kralevich <nnk@google.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Lokesh Gidra <lokeshgidra@google.com>,
        John Johansen <john.johansen@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 27, 2020 at 1:17 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>
> On 4/22/2020 9:55 AM, James Morris wrote:
> > On Mon, 13 Apr 2020, Daniel Colascione wrote:
> >
> >> On Wed, Apr 1, 2020 at 2:39 PM Daniel Colascione <dancol@google.com> wrote:
> >>> Changes from the fourth version of the patch:
> >>
> >> Is there anything else that needs to be done before merging this patch series?
> > The vfs changes need review and signoff from the vfs folk, the SELinux
> > changes by either Paul or Stephen, and we also need signoff on the LSM
> > hooks from other major LSM authors (Casey and John, at a minimum).
>
> You can add my
>
>         Acked-by: Casey Schaufler <casey@schaufler-ca.com>
>
> for this patchset.

This version of the series addresses all of my comments, so you can add my
Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

I don't know though how to get a response from the vfs folks; the
series has been posted repeatedly without any
response by them.
