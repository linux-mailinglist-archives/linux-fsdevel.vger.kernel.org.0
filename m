Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 082674A8851
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Feb 2022 17:06:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352125AbiBCQGl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Feb 2022 11:06:41 -0500
Received: from mail-pl1-f179.google.com ([209.85.214.179]:41517 "EHLO
        mail-pl1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229993AbiBCQGk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Feb 2022 11:06:40 -0500
Received: by mail-pl1-f179.google.com with SMTP id z5so2520817plg.8;
        Thu, 03 Feb 2022 08:06:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CQl5z9carncWUpCNFDhmSPdjShzBxxx7Om9xnHB+4lM=;
        b=gOjLlieapzUWlzb3LSnLiE1R6OdidnGchKr7V2soKZ8Ucoc1kHmqGwylRS6X3P+La/
         70egDDwyncV/ZihJvll8zR8zvw+avm7A2DpuGjdoRe5y3DXh0jMggo1dHOU3TNYDPrZl
         zYJ5mMg1L9SuKQ00P4QqbPlrTYTXsAKbpUlPW/padiFobSudhqyD+Tokgn7UJ5vrEoLR
         awm2aMS5NZ4Kisjl6US9wSZmEn33y5PwrPWvEetusXWmdo0yBHXlA47HGlg0H7Ck8/jd
         sXvJ1hUURopw3jSTKGvcfP/VwtMoDoUTbxPrVwlfNreFFu8jFXUy9+oPQnbjCGoliN6M
         Hfpw==
X-Gm-Message-State: AOAM533qMihY3l+srdqrn82qmonz8ZD3ZbAxmQvAdurpIA+w0tUe1tNd
        WDW5wVitchC6ORvjhttHofA=
X-Google-Smtp-Source: ABdhPJzhK8+95Srk1qUADNs99c7AM9hHsV465MsjDTT3FGN90VtQxc49I1xXzkBKwhRQs7yApS+AYA==
X-Received: by 2002:a17:903:2305:: with SMTP id d5mr35376153plh.122.1643904399872;
        Thu, 03 Feb 2022 08:06:39 -0800 (PST)
Received: from garbanzo (136-24-173-63.cab.webpass.net. [136.24.173.63])
        by smtp.gmail.com with ESMTPSA id t7sm28321189pfj.138.2022.02.03.08.06.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Feb 2022 08:06:37 -0800 (PST)
Date:   Thu, 3 Feb 2022 08:06:33 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Adam Manzanares <a.manzanares@samsung.com>
Cc:     Mikulas Patocka <mpatocka@redhat.com>,
        Javier =?utf-8?B?R29uesOhbGV6?= <javier@javigon.com>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        "msnitzer@redhat.com >> msnitzer@redhat.com" <msnitzer@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>,
        "martin.petersen@oracle.com >> Martin K. Petersen" 
        <martin.petersen@oracle.com>,
        "roland@purestorage.com" <roland@purestorage.com>,
        Hannes Reinecke <hare@suse.de>,
        "kbus @imap.gmail.com>> Keith Busch" <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        "Frederick.Knight@netapp.com" <Frederick.Knight@netapp.com>,
        "zach.brown@ni.com" <zach.brown@ni.com>,
        "osandov@fb.com" <osandov@fb.com>,
        "lsf-pc@lists.linux-foundation.org" 
        <lsf-pc@lists.linux-foundation.org>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "josef@toxicpanda.com" <josef@toxicpanda.com>,
        "clm@fb.com" <clm@fb.com>, "dsterba@suse.com" <dsterba@suse.com>,
        "tytso@mit.edu" <tytso@mit.edu>, "jack@suse.com" <jack@suse.com>,
        Kanchan Joshi <joshi.k@samsung.com>
Subject: Re: [RFC PATCH 3/3] nvme: add the "debug" host driver
Message-ID: <20220203160633.rdwovqoxlbr3nu5u@garbanzo>
References: <f0e19ae4-b37a-e9a3-2be7-a5afb334a5c3@nvidia.com>
 <20220201102122.4okwj2gipjbvuyux@mpHalley-2>
 <alpine.LRH.2.02.2202011327350.22481@file01.intranet.prod.int.rdu2.redhat.com>
 <CGME20220201183359uscas1p2d7e48dc4cafed3df60c304a06f2323cd@uscas1p2.samsung.com>
 <alpine.LRH.2.02.2202011333160.22481@file01.intranet.prod.int.rdu2.redhat.com>
 <20220202060154.GA120951@bgt-140510-bm01>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220202060154.GA120951@bgt-140510-bm01>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 02, 2022 at 06:01:13AM +0000, Adam Manzanares wrote:
> BTW I think having the target code be able to implement simple copy without 
> moving data over the fabric would be a great way of showing off the command.

Do you mean this should be implemented instead as a fabrics backend
instead because fabrics already instantiates and creates a virtual
nvme device? And so this would mean less code?

  Luis
