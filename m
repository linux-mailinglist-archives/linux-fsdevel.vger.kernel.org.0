Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03D4E1249E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2019 00:38:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726218AbfEBWiC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 May 2019 18:38:02 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:50546 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726022AbfEBWiC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 May 2019 18:38:02 -0400
Received: by mail-it1-f194.google.com with SMTP id q14so6285864itk.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 May 2019 15:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w4U4g4c9icUT7vMEU5TbDP4lUfa59LLZZR6WuwCz8SM=;
        b=FQagtfh9UscvhQKUvKxmpcmYui1u0MswWkwg0VWLJVVsVd6m0KXxUuKHZp3lA0zcig
         rlTyQOWe38IRdZyBjeS71YPap2kqomtDwIFjRNsf+4Z9t1x3Q5KQ0YzelL24U47Kqsq5
         2YZVbF6MHMeDT8XuGxPxrhkf5gr2Q88kz+F5m6Ra0FWgWgw8wQF5PLhVFmp/zcQegVrn
         0rJtgbl7kfC9OD8COvVwVOyNukKG7i/CrMiZm3bEyH9sZSvtXt3I+D5c2fy8nj0tAw3r
         ylrL2BtnR0A1tb/WXER8mESjT3ACLaeKwoc+JPgXhkxPsO54klxuxvCbur7Y+TXfzf39
         eV7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w4U4g4c9icUT7vMEU5TbDP4lUfa59LLZZR6WuwCz8SM=;
        b=Xjhumkjubiw7fOiFH1rf2JJ8FIx/UWUUI411r2CI1gD86Ng2AP747D9CAfiF8zJvO7
         8HnI3NbdHBVQ4LlVBOROvCkw0YfnlxO/CeJ9Tg8w/qnhkS8cXXnvdpNOF+uqdWCNMPcV
         A+7RdRABsmtUR1ZOw7EsT5+WJpAPNkgQG9aGYz/H7lJzln3B7B5vo03bo2rlgg48dajt
         regeeYwo51uzuHtIIQVCYfpDiK2mhD6ese1c7uLY+I95oJPC+6LJXv7TODHeox4+guLk
         5/NP3IWjc1kwvwxIbC5Hj/v7MLl3203WNdv+wS/NNg/GNrw1reOn6sx87XPVwVZMRyrd
         6xMA==
X-Gm-Message-State: APjAAAVbSyJYmEeTE5TMDXQIAVk63E7h+PKaJ55b4xmod2huDtyWr8nK
        SUnwvcwPxfijegXjDfLCuqaM8sUYrXEdnWLVDFkNdg==
X-Google-Smtp-Source: APXvYqxmb99hnPwhJmrZp7/nl/QoCbJ9CLO1b6QXAyWLbO4B+Yg+0uNNEShGSW5cEtAAmrR5TyetySg1JDZLu+F+Qvg=
X-Received: by 2002:a24:a86:: with SMTP id 128mr4370210itw.118.1556836681254;
 Thu, 02 May 2019 15:38:01 -0700 (PDT)
MIME-Version: 1.0
References: <20190226215034.68772-1-matthewgarrett@google.com>
 <20190226215034.68772-4-matthewgarrett@google.com> <1551369834.10911.195.camel@linux.ibm.com>
 <1551377110.10911.202.camel@linux.ibm.com> <CACdnJutfCxzQDeFzXmZ9f8UrnqNScErkBJd2Yu+VEoy4nBhBCA@mail.gmail.com>
 <1551391154.10911.210.camel@linux.ibm.com> <CACdnJuuRLDj+6OTohfTVzqXp1K7U3efVXXuFfBfhk3CiUBEMiQ@mail.gmail.com>
 <CACdnJutPWEtDMS6YUXF0ykq7gKgQRNk6Fw=aHivHz6+NTodsgA@mail.gmail.com>
 <1551731553.10911.510.camel@linux.ibm.com> <CACdnJutWRB1up6wO3aWJJah3p8k+FY6xEfjw8ETHT69Vvsz8GQ@mail.gmail.com>
 <1551791930.31706.41.camel@linux.ibm.com> <CACdnJuvfzvZaU3CHtvVAP6vj_-rnWeTyAKjmRj8QGt7WAmjicQ@mail.gmail.com>
 <1551815469.31706.132.camel@linux.ibm.com> <CACdnJuvhu2iepghLm4-w2XVKH+TVT1JAY=vtKtf733UXPSBPaA@mail.gmail.com>
 <1551875418.31706.158.camel@linux.ibm.com> <CACdnJuvRuagNTidkq3d4g_OwfzqcALtd=g1-5LDzr2aBA1zV6w@mail.gmail.com>
 <1551911937.31706.217.camel@linux.ibm.com> <CACdnJut9T0xE-Q+ZAfqaRMUeBX=7w+cYE5Y7Ls1PdH-bJfv8MQ@mail.gmail.com>
 <1551923650.31706.258.camel@linux.ibm.com> <CACdnJuv+d2qEc+vQosmDOzdu57Jjpjq9-CZEy8epz0ob5mptsA@mail.gmail.com>
 <1551991690.31706.416.camel@linux.ibm.com> <CACdnJuvkA6M_fu3+BARH2AMHksTXbvWmRyK9ZaxcH-xZMq4G2g@mail.gmail.com>
 <CACdnJuv2zV1OnbVaHqkB2UU=dAEzzffajAFg_xsgXRMvuZ5fTw@mail.gmail.com>
 <1554416328.24612.11.camel@HansenPartnership.com> <CACdnJutZzJu7FxcLWasyvx9BLQJeGrA=7WA389JL8ixFJ6Skrg@mail.gmail.com>
 <1554417315.24612.15.camel@HansenPartnership.com> <CACdnJuutKe+i8KLUmPWjbFOWfrO2FzYVPjYZGgEatFmZWkw=UA@mail.gmail.com>
 <1554431217.24612.37.camel@HansenPartnership.com> <CACdnJut_vN9pJXq-j9fEO1CFZ-Aq83cO2LiFmep=Fn9_NOKhWQ@mail.gmail.com>
 <CACdnJusKM74vZ=zg+0fe50gNRVaDPCdw9mfbbq45yTqnZfZX5w@mail.gmail.com> <1556828700.4134.128.camel@linux.ibm.com>
In-Reply-To: <1556828700.4134.128.camel@linux.ibm.com>
From:   Matthew Garrett <mjg59@google.com>
Date:   Thu, 2 May 2019 15:37:49 -0700
Message-ID: <CACdnJutAw02Hq=NDeHoSsZAh2D95EBag_U8GYoSfNJ7eM61OxQ@mail.gmail.com>
Subject: Re: [PATCH V2 3/4] IMA: Optionally make use of filesystem-provided hashes
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     James Bottomley <James.Bottomley@hansenpartnership.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-fsdevel@vger.kernel.org, miklos@szeredi.hu,
        Roberto Sassu <roberto.sassu@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 2, 2019 at 1:25 PM Mimi Zohar <zohar@linux.ibm.com> wrote:
> Suppose instead of re-using the "d-ng" for the vfs hash, you defined a
> new field named d-vfs.  Instead of the "ima-ng" or "d-ng|n-ng", the
> template name could be "d-vfs|n-ng".

Is it legitimate to redefine d-ng such that if the hash comes from the
filesystem it adds an additional prefix? This will only occur if the
admin has explicitly enabled the trusted_vfs option, so we wouldn't
break any existing configurations. Otherwise, I'll look for the
cleanest approach for making this dynamic.
