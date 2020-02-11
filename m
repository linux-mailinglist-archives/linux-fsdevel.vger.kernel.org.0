Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C286615947D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Feb 2020 17:10:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730779AbgBKQKb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Feb 2020 11:10:31 -0500
Received: from mail-qt1-f179.google.com ([209.85.160.179]:42407 "EHLO
        mail-qt1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730627AbgBKQKa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Feb 2020 11:10:30 -0500
Received: by mail-qt1-f179.google.com with SMTP id r5so6980886qtt.9;
        Tue, 11 Feb 2020 08:10:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=5gn7PNGnnKsx59vxWJoK9+sfEplsTzQ66IX2VckdnIE=;
        b=tevTrUd+3kG9XfkYEhmt1ngNjX6vVVcvqRFTcrAOixb7LiOX1xKX10nCE59TorIyFH
         BkZhf8FV9Uxih4NQGLvOsjc6iI370ExVrNI+t0kN1r9ezWZVQemfWzh6US0CATjac1S0
         Rn0nM+n1SSY2nkrB0QvbLKhn5vAnIOsoQ6gMP+wn2+UAQlLUPaJZHUnoKHlW2i+E2HoU
         fltRv0DupASaMps7e6nHpR6zaxjfzmmUSMRXmDTVx7qheUGjzky4rzt3oav1QyH4uwyH
         c97NwTwnTY6W1x93g4lH66ybAESJjCtJP7oEcC2OnV/uWOpKb8sL8Rt/ycde9HNpUX4R
         SPrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=5gn7PNGnnKsx59vxWJoK9+sfEplsTzQ66IX2VckdnIE=;
        b=SiJqTVavHad+pZhq9lNPh2VFUSD+k09uPTF3sjmRJwUnJRa9jl5NWlWBTk4nCb+C3O
         dG4nitZ7kvEA1HyK4/UNPnn44LtAFGFw3CgsSnLwb95cb7JEczEzWpZskE6Evq/kqyJx
         hCTO15lV4KiI/auZTA2ER2juRRKIucoMfEl5XZ8bHjmzqUTg5dZcmYzEytRKwZvjREJ2
         09gZM38wPKNiOjZIVaERZfmhbafpVmo5lFaAqCPOR+bIXQg6QIbEHcS1PqhEAwnycEHP
         lJYQ6Zcx/KZQM2RLJ8WOkdITwR5w1TugsUnvhaCXraZhXCnZS4LUWBglvKCColGpuWpG
         gdqQ==
X-Gm-Message-State: APjAAAX+B2yYurkpJMY8L/Yi9B3C90jyO+GE3rDexRXozl71/58X1TdD
        ZFdHFyxrgrW554WAqFfNrMe2yrWCjyzRAg==
X-Google-Smtp-Source: APXvYqxpiz/tshlrzMc9BCbWVROW2jW+BYzNbHiujtPHKdfCffbUqjYXk+IALG36Gjyamad68/8DKw==
X-Received: by 2002:aed:2ce4:: with SMTP id g91mr3083079qtd.352.1581437427770;
        Tue, 11 Feb 2020 08:10:27 -0800 (PST)
Received: from localhost.localdomain (pool-74-108-111-89.nycmny.fios.verizon.net. [74.108.111.89])
        by smtp.gmail.com with ESMTPSA id n32sm2465467qtk.66.2020.02.11.08.10.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2020 08:10:27 -0800 (PST)
Message-ID: <fab03a0b8cc9dc93f2d0db51071521ce82e2b96b.camel@gmail.com>
Subject: Re: [PATCH v2] ima: export the measurement list when needed
From:   david.safford@gmail.com
To:     Mimi Zohar <zohar@linux.ibm.com>,
        Janne Karhunen <janne.karhunen@gmail.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module <linux-security-module@vger.kernel.org>
Cc:     Ken Goldman <kgold@linux.ibm.com>, monty.wiseman@ge.com,
        Amir Goldstein <amir73il@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Date:   Tue, 11 Feb 2020 11:10:26 -0500
In-Reply-To: <1581366258.5585.891.camel@linux.ibm.com>
References: <20200108111743.23393-1-janne.karhunen@gmail.com>
         <CAE=NcrZrbRinOAbB+k1rjhcae3nqfJ8snC_EnY8njMDioM7=vg@mail.gmail.com>
         <1580998432.5585.411.camel@linux.ibm.com>
         <40f780ffe2ddc879e5fa4443c098c0f1d331390f.camel@gmail.com>
         <1581366258.5585.891.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.3 (3.34.3-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2020-02-10 at 15:24 -0500, Mimi Zohar wrote:
> On Mon, 2020-02-10 at 13:18 -0500, david.safford@gmail.com wrote:
> > On Thu, 2020-02-06 at 09:13 -0500, Mimi Zohar wrote:
> > > Hi Janne,
> > > 
> > > On Fri, 2020-01-10 at 10:48 +0200, Janne Karhunen wrote:
> > > > On Wed, Jan 8, 2020 at 1:18 PM Janne Karhunen <janne.karhunen@gmail.com> wrote:
> > > > > Some systems can end up carrying lots of entries in the ima
> > > > > measurement list. Since every entry is using a bit of kernel
> > > > > memory, allow the sysadmin to export the measurement list to
> > > > > the filesystem to free up some memory.
> > > > 
> > > > Hopefully this addressed comments from everyone. The flush event can
> > > > now be triggered by the admin anytime and unique file names can be
> > > > used for each flush (log.1, log.2, ...) etc, so getting to the correct
> > > > item should be easy.
> > > > 
> > > > While it can now be argued that since this is an admin-driven event,
> > > > kernel does not need to write the file. However, the intention is to
> > > > bring out a second patch a bit later that adds a variable to define
> > > > the max number of entries to be kept in the kernel memory and
> > > > workqueue based automatic flushing. In those cases the kernel has to
> > > > be able to write the file without any help from the admin..
> > > 
> > > The implications of exporting and removing records from the IMA-
> > > measurement list needs to be considered carefully.  Verifying a TPM
> > > quote will become dependent on knowing where the measurements are
> > > stored.  The existing measurement list is stored in kernel memory and,
> > > barring a kernel memory attack, is protected from modification.
> > >  Before upstreaming this or a similar patch, there needs to be a
> > > discussion as to how the measurement list will be protected once is it
> > > exported to userspace.
> > 
> > "Protected" here can mean two different aspects: cryptographically
> > protected from tampering, which is covered with the TPM_QUOTE, and
> > availability protected from even accidental deletion, which is what
> > I suspect you are concerned about. Certainly my original TLV patches
> > were too flippant about this, as userspace had to be trusted not to
> > drop any records. In this patch, the kernel writes the data in an
> > atomic fashion. Either all records are successfully written, or none
> > are, and an error is returned.
> 
> A third aspect, which I'm concerned about, is removing records from
> the measurement list.  This changes the existing userspace
> expectations of returning the entire measurement list.  Now userspace
> will need some out of band method of knowing where to look for the
> measurements.

This is a feature, not a bug. :-)
There is no reason to resend the same data for every attestation,
nor is there any reason to store already attested measurements anywhere
on the client. By versioning the log file names, userspace gets a
simple way to know what has and has not been attested, and for small
embedded devices we don't need to waste memory or filesystem space
on the data already attested.

> When Thiago and I added support for carrying the measurement list
> across kexec, there were a number of additional measurements after the
> kexec load.  These additional measurements will need to be safely
> written out to file in order to validate the TPM quote.
> 
> > I have been testing this patch on all of these scenarios, and it
> > provides a simple, powerful approach for all of them.
>  
> Were you able to walk the measurement list and validate the TPM quote
> after a kexec?

I'm still working on this. (I've mainly been making sure this works
for normal template and TLV lists.) I should be able to write out the
remaining kexec measurements, but haven't actually validated that
yet...

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

This method of exporting is atomic, so only those items exported
get deleted.

> > > In the kernel usecase, somehow the kernel would need to safely export
> > > the measurement list, or some portion of the measurement list, to a
> > > file and then delete that portion.  What protects the exported records
> > > stored in a file from modification?
> > 
> > Tampering is prevented with the TPM_QUOTE. Accidental deletion is
> > protected with CAP_SYS_ADMIN. If CAP_SYS_ADMIN is untrusted, you 
> > have bigger problems, and even then it will be detected.
> 
> Agreed, attestation will detect any tampering, but up to now we didn't
> have to rely on DAC/MAC to prevent tampering of the measurement list.

The userspace attestation process has always been able to tamper or
delete the list data during its attestation, but we can detect this
remotely.

> > > Instead of exporting the measurement records, one option as suggested
> > > by Amir Goldstein, would be to use a vfs_tmpfile() to get an anonymous
> > > file for backing store.  The existing securityfs measurement lists
> > > would then read from this private copy of the anonymous file.
> > 
> > This doesn't help in use cases where we really do want to
> > export to a persistent file, without userspace help.
> 
> Is to prevent needing to carry the measurement list across kexec the
> only reason for the kernel needing to write to a persistent file?

Well, that and the other reasons mentioned, such as completely freeing
the data from the client after attestation, and simplicity of the
mechanism.

dave

> Mimi
> 

