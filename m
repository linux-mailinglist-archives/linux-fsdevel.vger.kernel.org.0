Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 182F43B8013
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Jun 2021 11:34:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233899AbhF3JhC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Jun 2021 05:37:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233886AbhF3Jg6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Jun 2021 05:36:58 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A55A2C061756;
        Wed, 30 Jun 2021 02:34:28 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id f21so2301890ioh.13;
        Wed, 30 Jun 2021 02:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tbma0IJD+W2GwKxTN2jr2ssQsNr4w3hkXF2HeDy7Ch0=;
        b=Eev9Vk3ok2rMrCD4OA/XMa+ZEiDr0z3kH1prjkqMpYpiEH0z9USywJRR6pELoQW6XD
         uHuUKzOAWoCWIvJyjqtpOT4KWDzYaXhlRpRjr1E+j+IRl4zycqrPxSLcJ+M5duJun7Eo
         pQkW58MrgYRV3iK/dDjHP98PkJrulUGt3+lCEMDhpRfZFQVeQ2ksyPXWEn1oX4FhLuec
         lmkTwWeWqg3KYFeaqL7jyz+cmo5Vc23b4FHwikQG+tLfmoSdO3T5v8SVqLJ5gEeGgJdq
         1SPhImcjfy5k3ygj50QSqN/yLp3XvoU23L9PG3JfWF+SqzopyL1spsXiCrFKOTD+Tpkr
         k1Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tbma0IJD+W2GwKxTN2jr2ssQsNr4w3hkXF2HeDy7Ch0=;
        b=iVmvmhgF7iBRRptxg7FaubzMfGIbgg1Oa5E342fyDYvOHx4p2/R3cCgMxdQoNXo+bW
         BP+G4NntXnKB1LxaRR4xP0ZxqaXN8Nve5f4OxdZpu5N6v+o3D3eJkcmTe5GIPC4BMlJo
         MFkSK3N7X0PPF+5+O6CorWpBdPGYGBy7/zWfwcWG/SPn2P5PQHwIHQitSlOie9Pg0PsE
         nD5rO0Kkso92PNWOe4SxB53xBlsZLgIKpNU8HAhaUI+7rd45L4xhAbccrgIFt5/eItMp
         R7qQO+9sn84HxncAVYzisU+F43sgUMJmUImUKyW9IkEU0ohP0z5H8UojTmqmD9LO+2Ie
         FwKQ==
X-Gm-Message-State: AOAM532sN8BrfGktR2qDRenuFgLPekkE1kKZZr0iUpQDmdXSmZD5iYuU
        9lCHIfcTxwgNgIIImTazivh7Yl9fz6W8AhQDlOQ=
X-Google-Smtp-Source: ABdhPJylb5ertAVh1IBSRAbDpMG6eVkE569m9q2JOO5bE/i+kqCG2wCsWjV+SkFBea7Ah4K6f9NcaCWZOlQa+289Yno=
X-Received: by 2002:a02:908a:: with SMTP id x10mr7951849jaf.30.1625045668217;
 Wed, 30 Jun 2021 02:34:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210629191035.681913-8-krisman@collabora.com>
 <202106300707.Xg0LaEwy-lkp@intel.com> <CAOQ4uxgRbpzo-AvvBxLQ5ARdFuX53RG+JpPOG8CDoEM2MdsWQQ@mail.gmail.com>
 <20210630084555.GH1983@kadam> <CAOQ4uxiCYBL2-FVMbn2RWcQnueueVoAd5sBtte+twLoU9eyFgA@mail.gmail.com>
In-Reply-To: <CAOQ4uxiCYBL2-FVMbn2RWcQnueueVoAd5sBtte+twLoU9eyFgA@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 30 Jun 2021 12:34:17 +0300
Message-ID: <CAOQ4uxgc8dDtJ1f0YSk0fDmdnuU3-kp8cONfuZ5P+7fzvBtZzA@mail.gmail.com>
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

On Wed, Jun 30, 2021 at 12:32 PM Amir Goldstein <amir73il@gmail.com> wrote:
>
> On Wed, Jun 30, 2021 at 11:46 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
> >
> > On Wed, Jun 30, 2021 at 11:35:32AM +0300, Amir Goldstein wrote:
> > >
> > > Do you have feeling of dejavu? ;-)
> > > https://lore.kernel.org/linux-fsdevel/20200730192537.GB13525@quack2.suse.cz/
> >
> > That was a year ago.  I have trouble remembering emails I sent
> > yesterday.
> >
> > >
> > > We've been through this.
> > > Maybe you silenced the smach warning on fsnotify() and the rename to
> > > __fsnotifty()
> > > caused this warning to refloat?
> >
> > Yes.  Renaming the function will make it show up as a new warning.  Also
> > this is an email from the kbuild-bot and last years email was from me,
> > so it's a different tool and a different record of sent messages.
> >
> > (IMO, you should really just remove the bogus NULL checks because
> > everyone looking at the warning will think the code is buggy).
> >
>
> I think the warning is really incorrect.
> Why does it presume that event_info->dir is non-NULL?
> Did smach check all the callers to fsnotify() or something?
> What about future callers that will pass NULL, just like this one:
>
> https://lore.kernel.org/linux-fsdevel/20210629191035.681913-12-krisman@collabora.com/
>

FWIW, the caller of this new helper passes NULL as inode:
https://lore.kernel.org/linux-fsdevel/20210629191035.681913-14-krisman@collabora.com/

Thanks,
Amir.
