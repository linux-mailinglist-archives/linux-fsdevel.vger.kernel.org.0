Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D4CD1B14FC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Apr 2020 20:45:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbgDTSpq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Apr 2020 14:45:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725989AbgDTSpq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Apr 2020 14:45:46 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52A6AC061A0C;
        Mon, 20 Apr 2020 11:45:46 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id f19so12215674iog.5;
        Mon, 20 Apr 2020 11:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aIdTVhP9rgDLUFkHf5qfuDoinqZQ+gQIBHYoc4Bjl9M=;
        b=hkpX7hU+myep0WT6W5XgX8M0XPsoMxdtnKVyZamEABUByk1fvRMC+iQW7oCNg1q4Va
         OSDZq+/Mcgh7TgEWfp3obxX7pYgGuGMgOTfEvWeQYxhsc+8fWB8Lfsa/d5i6+mO4miSK
         +5my5dr8nP4tO+Qb7JUt7c8nTtd8cMf2C1hmdf9cykvxHs+i/E2webgveQd8DsvopMTu
         vkLldmdPbSR1aXRBRNp6IXXo6JDCGkFWduJ5CqowukdCd4VrOXSjisWIBcr0hF5WLZuC
         ftdQm6LcQ7bjXRsJNlqBHQsbHFf85kdpdlkzrhLQ/h5bm21Udigp2xNEa0ZERcKtI4Wl
         v4Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aIdTVhP9rgDLUFkHf5qfuDoinqZQ+gQIBHYoc4Bjl9M=;
        b=bOWvaNYjEpa0PLObH+svGcoUgrEFEcHnT1ezk6yV5Nj0dc4A5tJO8BF3mvpc+gklOv
         FiCKUeg5bLvV9rkElB+X6++q3AdW3bmKEKOn9dS6IO1XpI1ZKr0UHktXRykO3CVPS1rM
         gAITkzIGlZf2HqpvxiiEQltuOxVN1IeQeMfznUklE2qe0a8s+puP6703Q88zMPLo82gp
         cDUHfQSPipIeaQVbCue9/5C1dJQxqxmo7/GKk5oQsYo8k3p13IDAcHGsFhUrvLyjYsAe
         pGhCvkxlNa/1bDrjgly7MYj1K0g2Mh3fJliT8YYga1+EdpVB+LxhDJuRldmOz0ZISrdi
         d6BQ==
X-Gm-Message-State: AGi0PuaefT0Lcwr6abgKI4bVLP217SFq/OSabyyk17mOsVh6EWCXnZNU
        +g8HNrsmA+2vhyRMEtX54qoIkgElS+7OsHNgVC4=
X-Google-Smtp-Source: APiQypJSy4nllIMZSZPuDVGpSraEbV2DbEd7NFocHwkKG06j6eNg0FvmW8ccjBYMSj21hMpggekesSn1MWPcet20/Ls=
X-Received: by 2002:a02:4b03:: with SMTP id q3mr16703386jaa.30.1587408345790;
 Mon, 20 Apr 2020 11:45:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200217131455.31107-1-amir73il@gmail.com> <20200217131455.31107-14-amir73il@gmail.com>
 <CAKgNAkiVcjQfATKWwGNPDFucMEN4jJnQ5q6JHRzDihK1ZDnH8A@mail.gmail.com>
In-Reply-To: <CAKgNAkiVcjQfATKWwGNPDFucMEN4jJnQ5q6JHRzDihK1ZDnH8A@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 20 Apr 2020 21:45:34 +0300
Message-ID: <CAOQ4uxhx24iHDQHv02ei05eopVLQ-ytp9oepTy0q3xUDGr0dEw@mail.gmail.com>
Subject: Re: [PATCH v2 13/16] fanotify: report name info for FAN_DIR_MODIFY event
To:     "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 16, 2020 at 3:16 PM Michael Kerrisk (man-pages)
<mtk.manpages@gmail.com> wrote:
>
> Hello Amir,
>
> On Mon, 17 Feb 2020 at 15:10, Amir Goldstein <amir73il@gmail.com> wrote:
> >
> > Report event FAN_DIR_MODIFY with name in a variable length record similar
> > to how fid's are reported.  With name info reporting implemented, setting
> > FAN_DIR_MODIFY in mark mask is now allowed.
>
> I see this was merged for 5.7. Would you be able to send a man-pages
> patch that documents this new feature please.
>

Sorry, I missed your email.
Just posted the patches.
I never know when in development cycle you expect to get the man page patches...

Thanks,
Amir.
