Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FE7D4A54CC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Feb 2022 02:54:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231608AbiBAByk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Jan 2022 20:54:40 -0500
Received: from mail-pg1-f171.google.com ([209.85.215.171]:44915 "EHLO
        mail-pg1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229897AbiBAByk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Jan 2022 20:54:40 -0500
Received: by mail-pg1-f171.google.com with SMTP id h23so13915116pgk.11;
        Mon, 31 Jan 2022 17:54:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DEQ16urBvP0UlaY7sL7xRV/9fsqy0EWylw9ub26/KfQ=;
        b=jZOseM6jjNg3lZ0YYrNyZ2+8s8BScZLdB0mlpaSO4OvbBtMk947soQ42qZ0lcimllk
         T1k2xcVXI58EDUJt0VhsJeLCIp2I2tdAUndW+pjvJDl1R7mXQ1N1B1vi0K9wrC+30BQ7
         JZiy5sMLEq25k8ZHNTYLhiHg9k/PnwH5Wgl/CXVi3288LOIe1zwaWPeV3NwfrF2te+aA
         g9sKJurQM8vcxRGbwCETV6HGnEpNUJWSON89GhkWDBG1E5juD6JwDv2eKjkAzPsnpUdL
         KmDSXBewPA2X8jOjvK1JcE29teubWThGaoRHEfEfQ8aA3+gKdQEi8vL4d+1Z46/CMujV
         y7Mg==
X-Gm-Message-State: AOAM533AD1cIK8TVj1jxKZ2NPGy4445vyUTS6IYqIJvD4IFobquHIpRt
        qsDjluphBiqYKDf2H9zyx0k=
X-Google-Smtp-Source: ABdhPJxwurPLwookDKYfdK759aK7v43l+AjycUMO4NhyGq1GqximIDE/k24pt0ls+ZyULuBGbLpUaw==
X-Received: by 2002:a63:1ca:: with SMTP id 193mr16567674pgb.20.1643680479518;
        Mon, 31 Jan 2022 17:54:39 -0800 (PST)
Received: from garbanzo (136-24-173-63.cab.webpass.net. [136.24.173.63])
        by smtp.gmail.com with ESMTPSA id k9sm446369pfi.134.2022.01.31.17.54.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 17:54:38 -0800 (PST)
Date:   Mon, 31 Jan 2022 17:54:35 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
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
        "mpatocka@redhat.com" <mpatocka@redhat.com>,
        Hannes Reinecke <hare@suse.de>,
        "kbus >> Keith Busch" <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        "Frederick.Knight@netapp.com" <Frederick.Knight@netapp.com>,
        "zach.brown@ni.com" <zach.brown@ni.com>,
        "osandov@fb.com" <osandov@fb.com>,
        "lsf-pc@lists.linux-foundation.org" 
        <lsf-pc@lists.linux-foundation.org>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "josef@toxicpanda.com" <josef@toxicpanda.com>,
        "clm@fb.com" <clm@fb.com>, "dsterba@suse.com" <dsterba@suse.com>,
        "tytso@mit.edu" <tytso@mit.edu>, "jack@suse.com" <jack@suse.com>
Subject: Re: [LSF/MM/BFP ATTEND] [LSF/MM/BFP TOPIC] Storage: Copy Offload
Message-ID: <20220201015435.okpgudxfrrtxwcd4@garbanzo>
References: <f0e19ae4-b37a-e9a3-2be7-a5afb334a5c3@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f0e19ae4-b37a-e9a3-2be7-a5afb334a5c3@nvidia.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> * What we will discuss in the proposed session ?
> -----------------------------------------------------------------------
> 
> I'd like to propose a session to go over this topic to understand :-
> 
> 1. What are the blockers for Copy Offload implementation ?
> 2. Discussion about having a file system interface.
> 3. Discussion about having right system call for user-space.
> 4. What is the right way to move this work forward ?
> 5. How can we help to contribute and move this work forward ?
> 
> * Required Participants :-
> -----------------------------------------------------------------------
> 
> I'd like to invite file system, block layer, and device drivers
> developers to:-
> 
> 1. Share their opinion on the topic.
> 2. Share their experience and any other issues with [4].
> 3. Uncover additional details that are missing from this proposal.

Consider me intersted in this topic.

  Luis
