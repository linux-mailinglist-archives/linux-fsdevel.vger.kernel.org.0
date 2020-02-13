Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0417F15B9CE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Feb 2020 07:53:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729782AbgBMGxd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Feb 2020 01:53:33 -0500
Received: from freki.datenkhaos.de ([81.7.17.101]:48960 "EHLO
        freki.datenkhaos.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726368AbgBMGxc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Feb 2020 01:53:32 -0500
Received: from localhost (localhost [127.0.0.1])
        by freki.datenkhaos.de (Postfix) with ESMTP id 7193C2288D32;
        Thu, 13 Feb 2020 07:53:30 +0100 (CET)
Received: from freki.datenkhaos.de ([127.0.0.1])
        by localhost (freki.datenkhaos.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ip891DUpbuya; Thu, 13 Feb 2020 07:53:26 +0100 (CET)
Received: from latitude (vpn136.rz.tu-ilmenau.de [141.24.172.136])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by freki.datenkhaos.de (Postfix) with ESMTPSA;
        Thu, 13 Feb 2020 07:53:26 +0100 (CET)
Date:   Thu, 13 Feb 2020 07:53:21 +0100
From:   Johannes Hirte <johannes.hirte@datenkhaos.de>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        Doug Gilbert <dgilbert@interlog.com>,
        Kai =?utf-8?B?TcOka2lzYXJh?= <Kai.Makisara@kolumbus.fi>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Dongli Zhang <dongli.zhang@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        John Garry <john.garry@huawei.com>,
        Martin Wilck <mwilck@suse.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Ira Weiny <ira.weiny@intel.com>, Iustin Pop <iustin@k1024.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        virtualization@lists.linux-foundation.org,
        linux-block <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v3 13/22] compat_ioctl: scsi: move ioctl handling into
 drivers
Message-ID: <20200213065321.GA8696@latitude>
References: <20200102145552.1853992-1-arnd@arndb.de>
 <20200102145552.1853992-14-arnd@arndb.de>
 <20200212211452.GA5726@latitude>
 <CAK8P3a0oPpMC8367sEs+9Ae=wFH30BHAq+aRDbWLyeVLuNOnEw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAK8P3a0oPpMC8367sEs+9Ae=wFH30BHAq+aRDbWLyeVLuNOnEw@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020 Feb 12, Arnd Bergmann wrote:
> On Wed, Feb 12, 2020 at 10:15 PM Johannes Hirte
> <johannes.hirte@datenkhaos.de> wrote:
> >
> > On 2020 Jan 02, Arnd Bergmann wrote:
> 
> >
> > Error in getting drive hardware properties
> > Error in getting drive reading properties
> > Error in getting drive writing properties
> > __________________________________
> >
> > Disc mode is listed as: CD-DA
> > ++ WARN: error in ioctl CDROMREADTOCHDR: Bad address
> >
> > cd-info: Can't get first track number. I give up.
> 
> Right, there was also a report about breaking the Fedora installer,
> see https://bugzilla.redhat.com/show_bug.cgi?id=1801353
> 
> There is a preliminary patch that should fix this, I'll post a
> version with more references tomorrow:
> https://www.happyassassin.net/temp/0001-Replace-.ioctl-with-.compat_ioctl-in-three-appropria.patch

Yes, I can confirm that the patch fix it.

-- 
Regards,
  Johannes Hirte

