Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8AB22158228
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2020 19:19:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727414AbgBJSTE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Feb 2020 13:19:04 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:38540 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726809AbgBJSTD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Feb 2020 13:19:03 -0500
Received: by mail-qk1-f194.google.com with SMTP id z19so4421470qkj.5;
        Mon, 10 Feb 2020 10:19:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=ALkbiNctHZ6GzjTicoN2UzzXl4LTRGejrnz8hGHjE/U=;
        b=mrDG7c0jHD3cqB2dEaxrkEStzYV+dGXZqih52S7JRTv9LMkA40vFRsW4RJrsHMetCB
         ixAdfk1P2iM+CdCBLmeeb/XJEXXpq5qkri8edwCPqrQvEOxq7enVpAeRgeXZjGw1mhTQ
         MjWgsB/i5JJQUvi1kMsHYivEr5AlcjFaNlataTSWHpl3vBn+BelMDPhx6zc1K3SqcwUf
         DrcCq9MCCXK7eN2bnlHGariXplTXh6oMmggvfjMJUJJWUAdCnOx4Uk+ObGeXpKB49GHq
         laMFEs+mrLrrBJDxmaLzn8maKXAgpb/5GvZlWJw6wl+szYCVyDbgGWY5OTYECIjFqGw3
         iezA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=ALkbiNctHZ6GzjTicoN2UzzXl4LTRGejrnz8hGHjE/U=;
        b=uPVttZvlA1Tamipnv3wjtlidHZGOYQtHKxfCNOzMGXzJOkOAU75AI1+t6ayLnjBimT
         4dDCbSRCOqyWXK+g27qmxurKApmMKRKafUjuA46JXCH4i6NNcnKCvdKkRfj5MPCSicVY
         t4HUZKOztUXes6UnbfWpaZmWLhv9xhMa5o7SzAbtzcbUL6gIyhPLTy7KmPO9RtMgvptA
         Bu4VtnL8LNTtLR/QyvqJ+8qhQQhUyV9v+QdLjd/7E5u/27ZjPsJFhizrhDVdcQPRW42E
         vpZ8pwQuxT651CbyBbNu0HYNkYV3vFZvcDRh2vhw8EF+AiePN3AGECrZy/wKlJzeyLRk
         7tHA==
X-Gm-Message-State: APjAAAVs9HNALancsDQkxbZ5Tn6S2oZSsB4TrIqhUVW2rVWW6JP0sSiQ
        kgGskTX3FOnhsvq28dZJuDM=
X-Google-Smtp-Source: APXvYqxZeiNlEfjqFDKOhbWsPZKzvw40t8OIUDknwODZVJs/8CJbY4kWaG/8EIB4swV+RvMEfeKh5w==
X-Received: by 2002:a05:620a:b04:: with SMTP id t4mr2647840qkg.7.1581358740795;
        Mon, 10 Feb 2020 10:19:00 -0800 (PST)
Received: from localhost.localdomain (pool-74-108-111-89.nycmny.fios.verizon.net. [74.108.111.89])
        by smtp.gmail.com with ESMTPSA id y26sm560713qtv.28.2020.02.10.10.19.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2020 10:19:00 -0800 (PST)
Message-ID: <40f780ffe2ddc879e5fa4443c098c0f1d331390f.camel@gmail.com>
Subject: Re: [PATCH v2] ima: export the measurement list when needed
From:   david.safford@gmail.com
To:     Mimi Zohar <zohar@linux.ibm.com>,
        Janne Karhunen <janne.karhunen@gmail.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module <linux-security-module@vger.kernel.org>
Cc:     Ken Goldman <kgold@linux.ibm.com>, monty.wiseman@ge.com,
        Amir Goldstein <amir73il@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Date:   Mon, 10 Feb 2020 13:18:59 -0500
In-Reply-To: <1580998432.5585.411.camel@linux.ibm.com>
References: <20200108111743.23393-1-janne.karhunen@gmail.com>
         <CAE=NcrZrbRinOAbB+k1rjhcae3nqfJ8snC_EnY8njMDioM7=vg@mail.gmail.com>
         <1580998432.5585.411.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.3 (3.34.3-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 2020-02-06 at 09:13 -0500, Mimi Zohar wrote:
> Hi Janne,
> 
> On Fri, 2020-01-10 at 10:48 +0200, Janne Karhunen wrote:
> > On Wed, Jan 8, 2020 at 1:18 PM Janne Karhunen <janne.karhunen@gmail.com> wrote:
> > > Some systems can end up carrying lots of entries in the ima
> > > measurement list. Since every entry is using a bit of kernel
> > > memory, allow the sysadmin to export the measurement list to
> > > the filesystem to free up some memory.
> > 
> > Hopefully this addressed comments from everyone. The flush event can
> > now be triggered by the admin anytime and unique file names can be
> > used for each flush (log.1, log.2, ...) etc, so getting to the correct
> > item should be easy.
> > 
> > While it can now be argued that since this is an admin-driven event,
> > kernel does not need to write the file. However, the intention is to
> > bring out a second patch a bit later that adds a variable to define
> > the max number of entries to be kept in the kernel memory and
> > workqueue based automatic flushing. In those cases the kernel has to
> > be able to write the file without any help from the admin..
> 
> The implications of exporting and removing records from the IMA-
> measurement list needs to be considered carefully.  Verifying a TPM
> quote will become dependent on knowing where the measurements are
> stored.  The existing measurement list is stored in kernel memory and,
> barring a kernel memory attack, is protected from modification.
>  Before upstreaming this or a similar patch, there needs to be a
> discussion as to how the measurement list will be protected once is it
> exported to userspace.

"Protected" here can mean two different aspects: cryptographically
protected from tampering, which is covered with the TPM_QUOTE, and
availability protected from even accidental deletion, which is what
I suspect you are concerned about. Certainly my original TLV patches
were too flippant about this, as userspace had to be trusted not to
drop any records. In this patch, the kernel writes the data in an
atomic fashion. Either all records are successfully written, or none
are, and an error is returned.

> This patch now attempts to address two very different scenarios.  The
> first scenario is where userspace is requesting exporting and removing
> of the measurement list records.  The other scenario is the kernel
> exporting and removing of the measurement list records.  Conflating
> these two different use cases might not be the right solution, as we
> originally thought.

Actually there are at least four significant use cases: userspace
requested, and kernel initiated, both for running out of memory or
for saving the list prior to a kexec. Exporting everything to a file
prior to kexec can really simplify all the vaious use cases of 
template vs TLV formatted lists across kexec. (Consider a modern
TLV firmware kernel wanting to boot an older kernel that only
understands template formats. How simple it would be for the first
kernel to export its list to a file, and the second kernel keeps
its list in template.)

I have been testing this patch on all of these scenarios, and it
provides a simple, powerful approach for all of them.

> The kernel already exports the IMA measurement list to userspace via a
> securityfs file.  From a userspace perspective, missing is the ability
> of removing N number of records.  In this scenario, userspace would be
> responsible for safely storing the measurements (e.g. blockchain).
>  The kernel would only be responsible for limiting permission, perhaps
> based on a capability, before removing records from the measurement
> list. 

I don't think we want to export 'N' records, as this would
be really hard to understand and coordinate with userspace.
Exporting all or none seems simpler.

> In the kernel usecase, somehow the kernel would need to safely export
> the measurement list, or some portion of the measurement list, to a
> file and then delete that portion.  What protects the exported records
> stored in a file from modification?

Tampering is prevented with the TPM_QUOTE. Accidental deletion is
protected with CAP_SYS_ADMIN. If CAP_SYS_ADMIN is untrusted, you 
have bigger problems, and even then it will be detected.

> Instead of exporting the measurement records, one option as suggested
> by Amir Goldstein, would be to use a vfs_tmpfile() to get an anonymous
> file for backing store.  The existing securityfs measurement lists
> would then read from this private copy of the anonymous file.

This doesn't help in use cases where we really do want to
export to a persistent file, without userspace help.

> I've Cc'ed fsdevel for additional comments/suggestions.
> 
> thanks,
> 
> Mimi
> 

