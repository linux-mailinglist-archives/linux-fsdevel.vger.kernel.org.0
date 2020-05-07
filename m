Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39E111C9835
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 May 2020 19:46:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728053AbgEGRqT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 May 2020 13:46:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726470AbgEGRqS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 May 2020 13:46:18 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60F3FC05BD43
        for <linux-fsdevel@vger.kernel.org>; Thu,  7 May 2020 10:46:18 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id w4so2100490ioc.6
        for <linux-fsdevel@vger.kernel.org>; Thu, 07 May 2020 10:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=yU0mJ28GxeMYjUBMEveE72PctswqptxZPEqLuEZt3cA=;
        b=vnd3Wz+k5EBZmosgqi5KKkGOlJPJfOp4+cC5rwQ5WKpxRuQIpmmoJ3cc9pg33/Ra2g
         /q3iGdwk0pNt0z7FaQrx4sYZVKT6xvn6L11gFpzroAtPAbaIaFOaFA33AOzmsY2oJVzE
         jtgyAMHmQRTny/Ymt7q8IJQ7lmehM/dp2fOPtkiEAf4fIS+TJ1gOCEXPyqVc+EempRvT
         LnIlcIIg3aPKzbfL50LWiVOlU2fXt/KiLSoS1PkVzECJlOLjp7YUx+z81+MOMhjkymjK
         17ES11qP77zrlhR4/OPv4Jsjafu984eSlgI/TG6K8fqacWkVukhDDXeHg0UV09ujnOXR
         8eVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=yU0mJ28GxeMYjUBMEveE72PctswqptxZPEqLuEZt3cA=;
        b=hGcNaLV0WqufyafOeN6jLH7e2uJ8Z+vuCS85DJufrLIWeihJWI++TggGkw0AO6nl/7
         C5nktidDRjx2QwtYh3Dz1fffOU0JjJYk0rx32+IGKnSnGs1JEPpupmeCdO7ez62lgnry
         86G+I4UZBw7r6s//ZtRbetei9jDJPChBdwMNKw51p0RoWrgcIN1shRrkCraK1LNl1kvO
         PohFVCJqZR+7ji74Th3NaXYZrVtm/4VjsuzLJItX0ZHgY0e0lAVlSp4G3nMsCVDxg17R
         4r87WY4ByfMZP+lKl9rzFOU7QmlRAgWmE7RGbCqqGgeRZQ21FS2DaGpAE5/FLix2prh/
         v1gg==
X-Gm-Message-State: AGi0PuZyPK2g/eapt1NS3NAuv7q4Z6jo+soCDZcfGRWYrK83cGIpPCeP
        /vzB2K7+1U2LowrlEJn7j/ETJyu7LgDQeAh9KeGT
X-Google-Smtp-Source: APiQypKtjV9RP7CzUz6PwlgUeogcwCqPXHQgs82XapWkRetj+C9fCnc4inT+4h675n5xp5ipP2PRJql00+jL03kLjws=
X-Received: by 2002:a6b:c9cc:: with SMTP id z195mr2514506iof.164.1588873577069;
 Thu, 07 May 2020 10:46:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200504110344.17560-1-eesposit@redhat.com>
In-Reply-To: <20200504110344.17560-1-eesposit@redhat.com>
From:   Jonathan Adams <jwadams@google.com>
Date:   Thu, 7 May 2020 10:45:40 -0700
Message-ID: <CA+VK+GN=iDhDV2ZDJbBsxrjZ3Qoyotk_L0DvsbwDVvqrpFZ8fQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] Statsfs: a new ram-based file sytem for Linux
 kernel statistics
To:     Emanuele Giuseppe Esposito <eesposit@redhat.com>
Cc:     kvm list <kvm@vger.kernel.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-mips@vger.kernel.org,
        kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 4, 2020 at 4:05 AM Emanuele Giuseppe Esposito
<eesposit@redhat.com> wrote:
...
> Statsfs offers a generic and stable API, allowing any kind of
> directory/file organization and supporting multiple kind of aggregations
> (not only sum, but also average, max, min and count_zero) and data types
> (all unsigned and signed types plus boolean). The implementation, which i=
s
> a generalization of KVM=E2=80=99s debugfs statistics code, takes care of =
gathering
> and displaying information at run time; users only need to specify the
> values to be included in each source.
>
> Statsfs would also be a different mountpoint from debugfs, and would not
> suffer from limited access due to the security lock down patches. Its mai=
n
> function is to display each statistics as a file in the desired folder
> hierarchy defined through the API. Statsfs files can be read, and possibl=
y
> cleared if their file mode allows it.
>
> Statsfs has two main components: the public API defined by
> include/linux/statsfs.h, and the virtual file system which should end up
> in /sys/kernel/stats.

This is good work.  As David Rientjes mentioned, I'm currently investigatin=
g
a similar project, based on a google-internal debugfs-based FS we call
"metricfs".  It's
designed in a slightly different fashion than statsfs here is, and the
statistics exported are
mostly fed into our OpenTelemetry-like system.  We're motivated by
wanting an upstreamed solution, so that we can upstream the metrics we
create that are of general interest, and lower the overall rebasing
burden for our tree.

Some feedback on your design as proposed:

 - the 8/16/32/64 signed/unsigned integers seems like a wart, and the
built-in support to grab any offset from a structure doesn't seem like
much of an advantage.  A simpler interface would be to just support an
"integer" (possibly signed/unsigned) type, which is always 64-bit, and
allow the caller to provide a function pointer to retrieve the value,
with one or two void *s cbargs.  Then the framework could provide an
offset-based callback (or callbacks) similar to the existing
functionality, and a similar one for per-CPU based statistics.  A
second "clear" callback could be optionally provided to allow for
statistics to be cleared, as in your current proposal.

 - A callback-style interface also allows for a lot more flexibility
in sourcing values, and doesn't lock your callers into one way of
storing them.  You would, of course, have to be clear about locking
rules etc. for the callbacks.

 - Beyond the statistic's type, one *very* useful piece of metadata
for telemetry tools is knowing whether a given statistic is
"cumulative" (an unsigned counter which is only ever increased), as
opposed to a floating value (like "amount of memory used").

I agree with the folks asking for a binary interface to read
statistics, but I also agree that it can be added on later.  I'm more
concerned with getting the statistics model and capabilities right
from the beginning, because those are harder to adjust later.

Would you be open to collaborating on the statsfs design?  As
background for this discussion, here are some details of how our
metricfs implementation approaches statistics:

1. Each metricfs metric can have one or two string or integer "keys".
If these exist, they expand the metric from a single value into a
multi-dimensional table. For example, we use this to report a hash
table we keep of functions calling "WARN()", in a 'warnings'
statistic:

% cat .../warnings/values
x86_pmu_stop 1
%

Indicates that the x86_pmu_stop() function has had a WARN() fire once
since the system was booted.  If multiple functions have fired
WARN()s, they are listed in this table with their own counts. [1]  We
also use these to report per-CPU counters on a CPU-by-CPU basis:

% cat .../irq_x86/NMI/values
0 42
1 18
... one line per cpu
%

2.  We also export some metadata about each statistic.  For example,
the metadata for the NMI counter above looks like:

% cat .../NMI/annotations
DESCRIPTION Non-maskable\ interrupts
CUMULATIVE
% cat .../NMI/fields
cpu value
int int
%

(Describing the statistic, marking it as "cumulative", and saying the
fields are "cpu" and "value", both ints).  The metadata doesn't change
much, so having separate files allows the user-space agent to read
them once and then the values multiple times.

3. We have a (very few) statistics where the value itself is a string,
usually for device statuses.

For our use cases, we generally don't both output a statistic and it's
aggregation from the kernel; either we sum up things in the kernel
(e.g. over a bunch of per-cpu or per-memcg counters) and only have the
result statistic, or we expect user-space to sum up the data if it's
interested.  The tabular form makes it pretty easy to do so (i.e. you
can use awk(1) to sum all of the per-cpu NMI counters).  We don't
generally reset statistics, except as a side effect of removing a
device.

Thanks again for the patchset, and for pointing out that KVM also
needs statistics sent out; it's great that there is interest in this.

Cheers,
- jonathan

P.S.  I also have a couple (non-critical) high-level notes:
  * It's not clear what tree your patches are against, or their
dependencies; I was able to get them to apply to linux-next master
with a little massaging, but then they failed to compile because
they're built on top of your "libfs: group and simplify linux fs code"
patch series you sent out in late april.  Including a git link or at
least a baseline tree and a list of the patch series you rely upon is
helpful for anyone wanting to try out your changes.

  * The main reason I was trying to try out your patches was to get a
sense of the set of directories and things the KVM example generates;
while it's apparently the same as the existing KVM debugfs tree, it's
useful to know how this ends up looking on a real system, and I'm not
familiar with the KVM stats.  Since this patch is intended slightly
more broadly than just KVM, it might have been useful to include
sample output for those not familiar with how things are today.


[1]    We also use this to export various network/storage statistics
on a per-device basis.  e.g. network bytes received counts:

% cat .../rx_bytes/values
lo 501360681
eth0 1457631256
...
%
