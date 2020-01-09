Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C9EE135107
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jan 2020 02:41:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727417AbgAIBlY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Jan 2020 20:41:24 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:28835 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726654AbgAIBlY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Jan 2020 20:41:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578534083;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=++BJMDhJnEZzwpRB8uVTSWyKTo0GbD3+bxramlo68KI=;
        b=ORfYGeLj4scN8H3dXoZbN1+pWsQbadwKCadgVg7WYbCPmQqD6qz5yjhrvrxvsaXIIMPCkf
        q8Mf3cSRBIjQ93iTdSZdWlsAjJXAnhkG02hcctlCWCDoMZLOZoR6S7D+TpSUj9erfkJOv8
        xBNSTuvAZoeAkUN7+tq1/4g/lMlCc74=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-192-EMsxYRcuNoyVE7fDxYJUNQ-1; Wed, 08 Jan 2020 20:41:20 -0500
X-MC-Unique: EMsxYRcuNoyVE7fDxYJUNQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9E0A71800D71;
        Thu,  9 Jan 2020 01:41:19 +0000 (UTC)
Received: from agk-dp.fab.redhat.com (agk-dp.fab.redhat.com [10.33.15.10])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 44C4B60E1C;
        Thu,  9 Jan 2020 01:41:19 +0000 (UTC)
Received: from agk by agk-dp.fab.redhat.com with local (Exim 4.69)
        (envelope-from <agk@redhat.com>)
        id 1ipMp3-0001FU-IR; Thu, 09 Jan 2020 01:41:17 +0000
Date:   Thu, 9 Jan 2020 01:41:17 +0000
From:   Alasdair G Kergon <agk@redhat.com>
To:     Tony Asleson <tasleson@redhat.com>
Cc:     Dave Chinner <david@fromorbit.com>,
        Sweet Tea Dorminy <sweettea@redhat.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [RFC 9/9] __xfs_printk: Add durable name to output
Message-ID: <20200109014117.GB3809@agk-dp.fab.redhat.com>
Mail-Followup-To: Tony Asleson <tasleson@redhat.com>,
        Dave Chinner <david@fromorbit.com>,
        Sweet Tea Dorminy <sweettea@redhat.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <20191223225558.19242-1-tasleson@redhat.com> <20191223225558.19242-10-tasleson@redhat.com> <20200104025620.GC23195@dread.disaster.area> <5ad7cf7b-e261-102c-afdc-fa34bed98921@redhat.com> <20200106220233.GK23195@dread.disaster.area> <CAMeeMh-zr309TzbC3ayKUKRniat+rzurgzmeM5LJYMFVDj7bLA@mail.gmail.com> <20200107012353.GO23195@dread.disaster.area> <4ce83a0e-13e1-6245-33a3-5c109aec4bf1@redhat.com> <20200108021002.GR23195@dread.disaster.area> <9e449c65-193c-d69c-1454-b1059221e5dc@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e449c65-193c-d69c-1454-b1059221e5dc@redhat.com>
Organization: Red Hat UK Ltd. Registered in England and Wales, number
        03798903. Registered Office: Peninsular House, 30-36 Monument
        Street, 4th Floor, London, England, EC3R 8NB.
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 08, 2020 at 10:53:13AM -0600, Tony Asleson wrote:
> We are not removing any existing information, we are adding.

A difficulty with this approach is:  Where do you stop when your storage
configuration is complicated and changing?  Do you add the complete
relevant part of the storage stack configuration to every storage
message in the kernel so that it is easy to search later?

Or do you catch the messages in userspace and add some of this
information there before sending them on to your favourite log message
database?  (ref. peripety, various rsyslog extensions)

> I think all the file systems should include their FS UUID in the FS log
> messages too, but that is not part of the problem we are trying to solve.

Each layer (subsystem) should already be tagging its messages in an
easy-to-parse way so that all those relating to the same object (e.g.
filesystem instance, disk) at its level of the stack can easily be
matched together later.  Where this doesn't already happen, we should
certainly be fixing that as it's a pre-requisite for any sensible
post-processing: As long as the right information got recorded, it can
all be joined together on demand later by some userspace software.
 
> The user has to systematically and methodically go through the logs
> trying to deduce what the identifier was referring to at the time of the
> error.  This isn't trivial and virtually impossible at times depending
> on circumstances.

So how about logging what these identifiers reference at different times
in a way that is easy to query later?

Come to think of it, we already get uevents when the references change,
and udev rules even already now create neat "by-*" links for us.  Maybe
we just need to log better what udev is actually already doing?

Then we could reproduce what the storage configuration looked like at
any particular time in the past to provide the missing context for
the identifiers in the log messages.

                    ---------------------
 
Which seems like an appropriate time to introduce storage-logger.

    https://github.com/lvmteam/storage-logger

    Fedora rawhide packages:
      https://copr.fedorainfracloud.org/coprs/agk/storage-logger/ 

The goal of this particular project is to maintain a record of the
storage configuration as it changes over time.  It should provide a
quick way to check the state of a system at a specified time in the
past.

The initial logging implementation is triggered by storage uevents and
consists of two components:

1. A new udev rule file, 99-zzz-storage-logger.rules, which runs after
all the other rules have run and invokes:

2. A script, udev_storage_logger.sh, that captures relevant
information about devices that changed and stores it in the system
journal.

The effect is to log the data from relevant uevents plus some
supplementary information (including device-mapper tables, for example).
It does not yet handle filesystem-related events.

Two methods to query the data are offered:

1. journalctl
Data is tagged with the identifier UDEVLOG and retrievable as
key-value pairs.
  journalctl -t UDEVLOG --output verbose
  journalctl -t UDEVLOG --output json
    --since 'YYYY-MM-DD HH:MM:SS' 
    --until 'YYYY-MM-DD HH:MM:SS'
  journalctl -t UDEVLOG --output verbose
    --output-fields=PERSISTENT_STORAGE_ID,MAJOR,MINOR
     PERSISTENT_STORAGE_ID=dm-name-vg1-lvol0

2. lsblkj  [appended j for journal]
This lsblk wrapper reprocesses the logged uevents to reconstruct a
dummy system environment that "looks like" the system did at a
specified earlier time and then runs lsblk against it.

Yes, I'm looking for feedback to help to decide whether or not it's
worth developing this any further.

Alasdair

