Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA751158B02
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Feb 2020 09:06:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727857AbgBKIGw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Feb 2020 03:06:52 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:46004 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727688AbgBKIGw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Feb 2020 03:06:52 -0500
Received: by mail-lj1-f194.google.com with SMTP id f25so10431015ljg.12;
        Tue, 11 Feb 2020 00:06:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pqod0Krzys5KGNDRtF1jhrcF4gtM2ro6QEi6m2WJvpc=;
        b=ZgHMx6zuMOpwR/RmTZS4wGFbrqxveHqQP9WhP9SozHg96t+eZoBSlfM8zrNOqO6ht1
         St0YopxHBUNeNvf9bbpIfNXdj3pL9SLSWj9o8jZ3jtg5FKuTzDLxkIzlIyf7yIjV7ldD
         BMFlbLvFFUk3tGxopEWanZ1W2/Q1XQCZCkTmuWaTO68xZhaKb/zpkeSnecwg2iCCgDpC
         hWgeUe+/QVOe+rZhyB68f8G7xC2R1r3ZpeEp/jTsatqpyjJPBXDs0metAO28IFkOsmWW
         GOR2XU319ExEGy3pCtDcyn0+m+YqdzFTEh2sPl+QLz0SjX9IIaAw0blmwm3NzcBC4Rci
         6Uww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pqod0Krzys5KGNDRtF1jhrcF4gtM2ro6QEi6m2WJvpc=;
        b=UjO0Vf75bWbeyeh0ybzhxxsfbrvRUtlh2lZ/DZ+0bX/O5v/fOsgda5IBa7HfvCMyVc
         pmWRzXxd8QCFo14ovzuRRuiJebAViiXaNsJtVHmEpIZsUT0uCQZqohEDnyI2vaCS487F
         Je8yoo2PxgIQRRUJrWiOmY7aGBfwrIX4QwJitpgdr01fqz3C0lH6nHTrLaMyrShLhKQA
         6Toz01yO5nCLitWapAQOuF+ZPOhNpL5ut/ygnfCWh2FYbK7JcHzCtzjqFpxeLay5bgJo
         ZS5CxslFVqba7Q1Gms6KA7RbRiAqlufrt7bZ4MoIjMjZNG2sw5ahuP/x6Xnx9VelSXfY
         3Y5A==
X-Gm-Message-State: APjAAAUYjQ7yxyPFfp6Gx0FX3BzZwPumPiLCa1JATMxDmxqQZ1bdpBiM
        aaXKNWZPjWVHcCdgExm0y4nD/OBwUn2FiPJNGmE=
X-Google-Smtp-Source: APXvYqwud0PPpzft6x3Pt67pkh79dQRRqM0DDGjolhAut8yVkEGceAWmMPrjcwO3ZArpYDNuM+IMKuqOFGSM+YtGcKQ=
X-Received: by 2002:a2e:9183:: with SMTP id f3mr3425733ljg.64.1581408409513;
 Tue, 11 Feb 2020 00:06:49 -0800 (PST)
MIME-Version: 1.0
References: <20200108111743.23393-1-janne.karhunen@gmail.com>
 <CAE=NcrZrbRinOAbB+k1rjhcae3nqfJ8snC_EnY8njMDioM7=vg@mail.gmail.com>
 <1580998432.5585.411.camel@linux.ibm.com> <40f780ffe2ddc879e5fa4443c098c0f1d331390f.camel@gmail.com>
 <1581366258.5585.891.camel@linux.ibm.com>
In-Reply-To: <1581366258.5585.891.camel@linux.ibm.com>
From:   Janne Karhunen <janne.karhunen@gmail.com>
Date:   Tue, 11 Feb 2020 10:06:38 +0200
Message-ID: <CAE=Ncra+BSUQbCH=VP-P3dNx8S=9n7094qr_tTAQ=kHiJJbwsg@mail.gmail.com>
Subject: Re: [PATCH v2] ima: export the measurement list when needed
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     david.safford@gmail.com, linux-integrity@vger.kernel.org,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Ken Goldman <kgold@linux.ibm.com>,
        "Wiseman, Monty (GE Global Research, US)" <monty.wiseman@ge.com>,
        Amir Goldstein <amir73il@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Feb 10, 2020 at 10:25 PM Mimi Zohar <zohar@linux.ibm.com> wrote:

> A third aspect, which I'm concerned about, is removing records from
> the measurement list.  This changes the existing userspace
> expectations of returning the entire measurement list.  Now userspace
> will need some out of band method of knowing where to look for the
> measurements.

Well, the original patch has a mechanism with one bit flip. You can
read the list name given that you are in the right namespace and/or
mount.


> > > The kernel already exports the IMA measurement list to userspace via a
> > > securityfs file.  From a userspace perspective, missing is the ability
> > > of removing N number of records.  In this scenario, userspace would be
> > > responsible for safely storing the measurements (e.g. blockchain).
> > >  The kernel would only be responsible for limiting permission, perhaps
> > > based on a capability, before removing records from the measurement
> > > list.
> >
> > I don't think we want to export 'N' records, as this would
> > be really hard to understand and coordinate with userspace.
> > Exporting all or none seems simpler.
>
> Userspace already has the ability of exporting the measurement list.
>  However, beetween saving the measurement list to a file and telling
> the kernel to delete the records from the kernel, additional
> measurement could have been added.

This is not an issue as long as there is no 'ALL' alias. We can't
agree on what 'ALL' is, but we can agree on 'N'.


> > Tampering is prevented with the TPM_QUOTE. Accidental deletion is
> > protected with CAP_SYS_ADMIN. If CAP_SYS_ADMIN is untrusted, you
> > have bigger problems, and even then it will be detected.
>
> Agreed, attestation will detect any tampering, but up to now we didn't
> have to rely on DAC/MAC to prevent tampering of the measurement list.

True. How about storing a hmac of the file in a securityfs entry?


--
Janne
