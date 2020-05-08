Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85D981CA765
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 May 2020 11:44:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbgEHJoS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 May 2020 05:44:18 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:45974 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726091AbgEHJoR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 May 2020 05:44:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588931055;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LB8B9nMZ801LTv0eYMRXac4vYEFLiAr6bD2XMw8FWro=;
        b=ZW/adFXz6xIYKIs44c1CnJ+xmgxVRsJkAJorLvAxnT6RCmYtgmSBW9hS16fOx4S1OhmcIP
        18ww+pLyt5piCHIu4QkYMopFmX80VYuW5uquLvHtmI2T6HhfGMpSAwjF6nds1t66YbgRCt
        zsCc8FnRH+UdyHpFOp21IVvTiaax5Dk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-264-oVxVVYxPPQGWkF2nVBhXNA-1; Fri, 08 May 2020 05:44:12 -0400
X-MC-Unique: oVxVVYxPPQGWkF2nVBhXNA-1
Received: by mail-wm1-f71.google.com with SMTP id l21so4927374wmh.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 08 May 2020 02:44:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LB8B9nMZ801LTv0eYMRXac4vYEFLiAr6bD2XMw8FWro=;
        b=ONY72vxkGKVfzC9soyfv0rV8VPhDzKJRNNT3UbTZRMlYNyLZiS/rm2Vgvh5uuk3XlW
         5aQ7ZlAoMBBDzw8LtSlyOnKDU87UkxE7g/wELmH1guv0g2UzSwZAdjbp49SO92pVAnWm
         kZs53eiqpQVD0gLeDjhzmSaQu6Gt9QM2LjeQM0MuDZLiUB77T/Mro87aU/ybPunbk8uz
         m3aYqvZU3DyBzZ+cq6v0Nq5euB7CFsQ1N/84HDDFogwRG/b2IeIqN4+uDdrQ/ux9+v2N
         1cPO/ZDlK0C4r0/e8VSfGhKYFDtwCuCF/CR1m++pr9ooAQ09eVIlLzHzbhtPHCNgsAGI
         rF0w==
X-Gm-Message-State: AGi0PuaVpKDkkKjMc6CRtSrVZaTFbXLmncXCqvN6J9H/RF6whylLq9VT
        enYjx2aeX9t1tDXFF/qAdhoiNLBkhIwPD35nzJWB7/dw1NuRBmgs/5lIyFUMh5aSWfx12bPzTma
        R8nNj17STYdLdJdXXBDEqPLHupg==
X-Received: by 2002:a5d:6107:: with SMTP id v7mr1883188wrt.270.1588931049117;
        Fri, 08 May 2020 02:44:09 -0700 (PDT)
X-Google-Smtp-Source: APiQypJgPEJmExg9Eh0dPygYqOMxDwjDrVa8N6ORETYXOWrahJgijwXVH3Zlb8oI31fLimenfgopfg==
X-Received: by 2002:a5d:6107:: with SMTP id v7mr1883147wrt.270.1588931048748;
        Fri, 08 May 2020 02:44:08 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:20ea:bae4:47a7:31db? ([2001:b07:6468:f312:20ea:bae4:47a7:31db])
        by smtp.gmail.com with ESMTPSA id d27sm2213073wra.30.2020.05.08.02.44.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 May 2020 02:44:08 -0700 (PDT)
Subject: Re: [PATCH v2 0/5] Statsfs: a new ram-based file sytem for Linux
 kernel statistics
To:     Jonathan Adams <jwadams@google.com>,
        Emanuele Giuseppe Esposito <eesposit@redhat.com>
Cc:     kvm list <kvm@vger.kernel.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-mips@vger.kernel.org,
        kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20200504110344.17560-1-eesposit@redhat.com>
 <CA+VK+GN=iDhDV2ZDJbBsxrjZ3Qoyotk_L0DvsbwDVvqrpFZ8fQ@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <29982969-92f6-b6d0-aeae-22edb401e3ac@redhat.com>
Date:   Fri, 8 May 2020 11:44:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CA+VK+GN=iDhDV2ZDJbBsxrjZ3Qoyotk_L0DvsbwDVvqrpFZ8fQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

[Answering for Emanuele because he's not available until Monday]

On 07/05/20 19:45, Jonathan Adams wrote:
> This is good work.  As David Rientjes mentioned, I'm currently investigating
> a similar project, based on a google-internal debugfs-based FS we call
> "metricfs".  It's
> designed in a slightly different fashion than statsfs here is, and the
> statistics exported are
> mostly fed into our OpenTelemetry-like system.  We're motivated by
> wanting an upstreamed solution, so that we can upstream the metrics we
> create that are of general interest, and lower the overall rebasing
> burden for our tree.

Cool.  We included a public reading API exactly so that there could be
other "frontends".  I was mostly thinking of BPF as an in-tree user, but
your metricfs could definitely use the reading API.

>  - the 8/16/32/64 signed/unsigned integers seems like a wart, and the
> built-in support to grab any offset from a structure doesn't seem like
> much of an advantage. A simpler interface would be to just support an> "integer" (possibly signed/unsigned) type, which is always 64-bit, and
> allow the caller to provide a function pointer to retrieve the value,
> with one or two void *s cbargs.  Then the framework could provide an
> offset-based callback (or callbacks) similar to the existing
> functionality, and a similar one for per-CPU based statistics.  A
> second "clear" callback could be optionally provided to allow for
> statistics to be cleared, as in your current proposal.

Ok, so basically splitting get_simple_value into many separate
callbacks.  The callbacks would be in a struct like

struct stats_fs_type {
	uint64_t (*get)(struct stats_fs_value *, void *);
	void (*clear)(struct stats_fs_value *, void *);
	bool signed;
}

static uint64_t stats_fs_get_u8(struct stats_fs_value *val, void *base)
{
	return *((uint8_t *)(base + (uintptr_t)val->arg);
}

static void stats_fs_clear_u8(struct stats_fs_value *val, void *base)
{
	*((uint8_t *)(base + (uintptr_t)val->arg) = 0;
}

struct stats_fs_type stats_fs_type_u8 = {
	stats_fs_get_u8,
	stats_fs_clear_u8,
	false
};

and custom types can be defined using "&(struct stats_fs_type) {...}".

>  - Beyond the statistic's type, one *very* useful piece of metadata
> for telemetry tools is knowing whether a given statistic is
> "cumulative" (an unsigned counter which is only ever increased), as
> opposed to a floating value (like "amount of memory used").

Good idea.  Also, clearing does not make sense for a floating value, so
we can use cumulative/floating to get a default for the mode: KVM
statistics for example are mostly cumulative and mode 644, except a few
that are floating and those are all mode 444.  Therefore it makes sense
to add cumulative/floating even before outputting it as metadata.

> I'm more
> concerned with getting the statistics model and capabilities right
> from the beginning, because those are harder to adjust later.

Agreed.

> 1. Each metricfs metric can have one or two string or integer "keys".
> If these exist, they expand the metric from a single value into a
> multi-dimensional table. For example, we use this to report a hash
> table we keep of functions calling "WARN()", in a 'warnings'
> statistic:
> 
> % cat .../warnings/values
> x86_pmu_stop 1
> %
>
> Indicates that the x86_pmu_stop() function has had a WARN() fire once
> since the system was booted.  If multiple functions have fired
> WARN()s, they are listed in this table with their own counts. [1]  We
> also use these to report per-CPU counters on a CPU-by-CPU basis:
> 
> % cat .../irq_x86/NMI/values
> 0 42
> 1 18
> ... one line per cpu
> % cat .../rx_bytes/values
> lo 501360681
> eth0 1457631256

These seem like two different things.

The percpu and per-interface values are best represented as subordinate
sources, one per CPU and one per interface.  For interfaces I would just
use a separate directory, but it doesn't really make sense for CPUs.  So
if we can cater for it in the model, it's better.  For example:

- add a new argument to statsfs_create_source and statsfs_create_values
that makes it not create directories and files respectively.

- add a new "aggregate function" STATS_FS_LIST that directs the parent
to build a table of all the simple values below it

We can also add a helper statsfs_add_values_percpu that creates a new
source for each CPU, I think.

The warnings one instead is a real hash table.  It should be possible to
implement it as some kind of customized aggregation, that is implemented
in the client instead of coming from subordinate sources.  The
presentation can then just use STATS_FS_LIST.  I don't see anything in
the design that is a blocker.

> 2.  We also export some metadata about each statistic.  For example,
> the metadata for the NMI counter above looks like:
> 
> % cat .../NMI/annotations
> DESCRIPTION Non-maskable\ interrupts
> CUMULATIVE
> % cat .../NMI/fields
> cpu value
> int int
> %

Good idea.  I would prefer per-directory dot-named files for this.  For
example a hypothetical statsfs version of /proc/interrupts could be like
this:

$ cat /sys/kernel/stats/interrupts/.schema
0                                          // Name
CUMULATIVE                                 // Flags
int:int                                    // Type(s)
IR-IO-APIC    2-edge      timer            // Description
...
LOC
CUMULATIVE
int:int
Local timer interrupts
...
$ cat /sys/kernel/stats/interrupts/LOC
0 4286815
1 4151572
2 4199361
3 4229248

> 3. We have a (very few) statistics where the value itself is a string,
> usually for device statuses.

Maybe in addition to CUMULATIVE and FLOATING we can have ENUM
properties, and a table to convert those enums to strings.  Aggregation
could also be used to make a histogram out of enums in subordinate
sources, e.g.

$ cat /sys/kernel/stats/kvm/637-1/vcpu_state
running 12
uninitialized 0
halted 4

So in general I'd say the sources/values model holds up.  We certainly
want to:

- switch immediately to callbacks instead of the type constants (so that
core statsfs code only does signed/unsigned)

- add a field to distinguish cumulative and floating properties (and use
it to determine the default file mode)

- add a new argument to statsfs_create_source and statsfs_create_values
that makes it not create directories and files respectively

- add a new API to look for a statsfs_value recursively in all the
subordinate sources, and pass the source/value pair to a callback
function; and reimplement recursive aggregation and clear in terms of
this function.

> For our use cases, we generally don't both output a statistic and it's
> aggregation from the kernel; either we sum up things in the kernel
> (e.g. over a bunch of per-cpu or per-memcg counters) and only have the
> result statistic, or we expect user-space to sum up the data if it's
> interested.  The tabular form makes it pretty easy to do so (i.e. you
> can use awk(1) to sum all of the per-cpu NMI counters).

Yep, the above "not create a dentry" flag would handle the case where
you sum things up in the kernel because the more fine grained counters
would be overwhelming.

Paolo

