Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A70C244F0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 May 2019 02:10:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727116AbfEUAKi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 May 2019 20:10:38 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:36939 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726586AbfEUAKi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 May 2019 20:10:38 -0400
Received: by mail-lj1-f194.google.com with SMTP id h19so14174189ljj.4;
        Mon, 20 May 2019 17:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+kqkmqnl5eS7FXaCbqzG5wh25R4BINUZlWEMSRIPYsE=;
        b=lF7v6AYRP7RRcnlOFs8NdGtL1kFEBhadW9xf+b3+e90BrDeBkcwelZx1y4fRw5LN18
         xjNWukDaZfAKLRfKG88GIDbvEdMTrlwQYq9n2QPmzI7rh0caWYZruyiQ9JmjtYkCsIxH
         XJxMLPAby3HrHYF9iCGqVQlXSMG+jkZRg5okctRQd9Gg/idpkVW0A5gFlPst4zuGWKnI
         a+ziVEHGSUfpf1d0q/40oIlr3ZD8TeKP4tnIFQHH8YQ9ONBD7PSgiYmuv+eEfy6Vv3S5
         a4G37zMjaRrM6887wIT/uYvjTpNgxFWyYxEPnFG1YPT5H+Pr28ifE1t/pK0SFGmamxzH
         snYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+kqkmqnl5eS7FXaCbqzG5wh25R4BINUZlWEMSRIPYsE=;
        b=UTPzPQB2otXgMsnv17/xLChy/VO6mJbQ4NW/FkQsGjwDOrJsPBc9XZ+MrlfuiI8Rrd
         tmqO/l/TggX59Dcm7lsmqql+lppspBKAsmBbvI5aRz+2OTjcyPxhNEcJY+AtQN2I9bGQ
         ZFcRSvifLv96eHvZsWZqXqgsiTrBivTaLiJ1X7fm6MPZkXnkzwEBE9xL94C6blDe/2vN
         3/O6s4EZRTwZfOXl3LG9mff2HHXWIOgv1eCDrn5nHwuN7pF90q4w1gvoYZL2MlwqTq4X
         PxOqBGge8ohsXTFPfYGiJMDGkcF1mSdIm7gRtdxxL217jZNIn23Ell96EdpJqoJeWcum
         iS0w==
X-Gm-Message-State: APjAAAVctaLHKKTVY7NAZaAki0rtgzXgg2XzIS3vRhAPnHZurabz9/N1
        dzhVj+heYk8shQ8BTbClBOOkCTMJLcJ/Ae5z6F+zSb6mFeA=
X-Google-Smtp-Source: APXvYqy571Wifa8LXTpRRzzPAlFZKUVLmVcUwOLK+7jKkNo8dPRYRyMG5Sus7WKzDTOJOWpgutiH6o2f4SaW2FAiq/w=
X-Received: by 2002:a2e:2d02:: with SMTP id t2mr36176225ljt.148.1558397436089;
 Mon, 20 May 2019 17:10:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190517212448.14256-1-matthewgarrett@google.com>
 <20190517212448.14256-7-matthewgarrett@google.com> <1558136840.4507.91.camel@linux.ibm.com>
 <CACdnJutPywtoyjykDnfX_gazfo_iQ9TCFPYgK60PcOFFFy39YQ@mail.gmail.com> <1558387614.4039.84.camel@linux.ibm.com>
In-Reply-To: <1558387614.4039.84.camel@linux.ibm.com>
From:   prakhar srivastava <prsriva02@gmail.com>
Date:   Mon, 20 May 2019 17:10:25 -0700
Message-ID: <CAEFn8q+cw014vHMHAS=fc6ze79bHWrLC5tNj=is09N2AF3ZLdQ@mail.gmail.com>
Subject: Re: [PATCH V3 6/6] IMA: Allow profiles to define the desired IMA template
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Matthew Garrett <mjg59@google.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, miklos@szeredi.hu,
        linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Matthew,Roberto,Thiago,

If you have a branch setup i can then add my patches onto yours?
OR
We can create a new branch to consolidate all changes?

I also sent out v6 of changes it will great if you can take a look.

Thanks,
Prakhar Srivastava
On Mon, May 20, 2019 at 2:27 PM Mimi Zohar <zohar@linux.ibm.com> wrote:
>
> On Mon, 2019-05-20 at 13:59 -0700, Matthew Garrett wrote:
> > On Fri, May 17, 2019 at 4:47 PM Mimi Zohar <zohar@linux.ibm.com> wrote:
> > > Matthew, I'm going to ask you to separate out this patch from this
> > > patch set.  Roberto, Thiago, Prakhar, I'm going to ask you to review
> > > Matthew's patch.  I'm expecting all of the patchsets will be re-posted
> > > based on it.
> >
> > Would you like something along these lines merged before reviewing the
> > rest of them, or is adding the ima-vfs-ng template and allowing admins
> > to configure it as default sufficient?
>
> This patch is really independent of the patch set.  I'd really like it
> as a separate, independent patch in case it needs to be back ported.
>  It will also make it easier to review.
>
> Mimi
>
