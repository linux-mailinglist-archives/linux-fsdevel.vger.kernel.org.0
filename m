Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D775B12994A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Dec 2019 18:23:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726997AbfLWRX2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Dec 2019 12:23:28 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:37371 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726840AbfLWRX2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Dec 2019 12:23:28 -0500
Received: from callcc.thunk.org (guestnat-104-133-0-111.corp.google.com [104.133.0.111] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id xBNHMvOs026152
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Dec 2019 12:22:58 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 94F14420822; Mon, 23 Dec 2019 12:22:57 -0500 (EST)
Date:   Mon, 23 Dec 2019 12:22:57 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Andrea Vai <andrea.vai@unipv.it>
Cc:     Ming Lei <ming.lei@redhat.com>,
        "Schmid, Carsten" <Carsten_Schmid@mentor.com>,
        Finn Thain <fthain@telegraphics.com.au>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Jens Axboe <axboe@kernel.dk>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        USB list <linux-usb@vger.kernel.org>,
        SCSI development list <linux-scsi@vger.kernel.org>,
        Himanshu Madhani <himanshu.madhani@cavium.com>,
        Hannes Reinecke <hare@suse.com>,
        Omar Sandoval <osandov@fb.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Hans Holmberg <Hans.Holmberg@wdc.com>,
        Kernel development list <linux-kernel@vger.kernel.org>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: AW: Slow I/O on USB media after commit
 f664a3cc17b7d0a2bc3b3ab96181e1029b0ec0e6
Message-ID: <20191223172257.GB3282@mit.edu>
References: <20191211024137.GB61323@mit.edu>
 <20191211040058.GC6864@ming.t460p>
 <20191211160745.GA129186@mit.edu>
 <20191211213316.GA14983@ming.t460p>
 <f38db337cf26390f7c7488a0bc2076633737775b.camel@unipv.it>
 <20191218094830.GB30602@ming.t460p>
 <b1b6a0e9d690ecd9432025acd2db4ac09f834040.camel@unipv.it>
 <20191223130828.GA25948@ming.t460p>
 <20191223162619.GA3282@mit.edu>
 <4c85fd3f2ec58694cc1ff7ab5c88d6e11ab6efec.camel@unipv.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4c85fd3f2ec58694cc1ff7ab5c88d6e11ab6efec.camel@unipv.it>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Dec 23, 2019 at 05:29:27PM +0100, Andrea Vai wrote:
> I run the cp command from a bash script, or from a bash shell. I don't
> know if this answer your question, otherwise feel free to tell me a
> way to find the answer to give you.

What distro are you using, and/or what package is the cp command
coming from, and what is the package name and version?

Also, can you remind me what the bash script is and how many files you are copying?

Can you change the script so that the cp command is prefixed by:

"strace -tTf -o /tmp/st "

e.g.,

	strace -tTf -o /tmp/st cp <args>

And then send me the /tmp/st file.  This will significantly change the
time, so don't do this for measuring performance.  I just want to see
what the /bin/cp command is *doing*.

      	      	     	     	      - Ted
