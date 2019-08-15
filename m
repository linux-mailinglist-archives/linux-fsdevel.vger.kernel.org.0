Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C56E88EEAB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Aug 2019 16:51:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733137AbfHOOvE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Aug 2019 10:51:04 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:43655 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731581AbfHOOvE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Aug 2019 10:51:04 -0400
Received: by mail-qk1-f195.google.com with SMTP id m2so1997513qkd.10
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Aug 2019 07:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=z90nPpYO8UuUUSb9IN8rKS3L0KsgC8zXmObZdfo6ctQ=;
        b=dU2EhV+6EWSs1MNrZJWfU76DaiGX5NQgWL4uohTv/GZxgH6FeggKTIKZ+d/6xxWmB5
         Uq7EirJG422MX6svb2pK3O0rmVD5upXZhrC0obDyAVUsClwMUccie10LZ+VusUXs6G5t
         Cfxm7G3duJErwOwTzL6wlTMWxPvhXqi0t55/HXZYJ0ksP5CllSxCeRSJEwA3qeLb3Mw+
         H9tQF6/hs2KVjejIpKYI3tuEWzOasQMSO5OrPdyS6Tf6gZNSrPhr0d7BWVqY895GeZU7
         3vhMlzFvKziDCq6pld4ycFVFRE1zOEJ/X+8kNMBCMNIgJ/nYLqTQqzhkO3QmO9Oxi/p7
         z4xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=z90nPpYO8UuUUSb9IN8rKS3L0KsgC8zXmObZdfo6ctQ=;
        b=TvGHGdaLG4d9qQ6CHS0vEWcfS5th0DRmteryyViMI5dAvzcpnh6gu76YsBjH8GMSPC
         rb0vwqXb1XaNZnicStzet4vPMlfdif/BP4vy2PH+xuJcwHBWRMJvMad18s75+cL6F3xT
         KjM64sFxmjHc+GIRCWVlZ1GKed+MFq9hJvpljU4ly4uN3EThrMvF2mE5hrG1N8yAhPz7
         azHv0gQCgA54y1m0GcKrNAYHYTRnTfHXc3JXusPF5Pyzd0bZ9FjEspwScKDerVJEJg4q
         yUpUFs+op3AuiAhPAoI6fASgWbGu61kkucwehVphqtOTCvyjsBiwM1ZKErX2rp1R1xp6
         nAyg==
X-Gm-Message-State: APjAAAUHxJLdRisHJkIst4aui46yjkJYnkZEAy68+75JmQVxLdMBokDF
        Oel3m8bwwyDU7KSg9O2uA7CMwQ==
X-Google-Smtp-Source: APXvYqyMHfwmFKSYVNb8WeeauLH7Hep/WJZ+jheCJjAwrLvMcjUnfX6gEreyk5eeamBSEzYzpviglQ==
X-Received: by 2002:a05:620a:71a:: with SMTP id 26mr4357407qkc.374.1565880663323;
        Thu, 15 Aug 2019 07:51:03 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id e15sm805595qtr.51.2019.08.15.07.51.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 15 Aug 2019 07:51:02 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hyH5i-0005L9-BH; Thu, 15 Aug 2019 11:51:02 -0300
Date:   Thu, 15 Aug 2019 11:51:02 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jan Kara <jack@suse.cz>
Cc:     John Hubbard <jhubbard@nvidia.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [RFC PATCH 2/2] mm/gup: introduce vaddr_pin_pages_remote()
Message-ID: <20190815145102.GH21596@ziepe.ca>
References: <20190812234950.GA6455@iweiny-DESK2.sc.intel.com>
 <38d2ff2f-4a69-e8bd-8f7c-41f1dbd80fae@nvidia.com>
 <20190813210857.GB12695@iweiny-DESK2.sc.intel.com>
 <a1044a0d-059c-f347-bd68-38be8478bf20@nvidia.com>
 <90e5cd11-fb34-6913-351b-a5cc6e24d85d@nvidia.com>
 <20190814234959.GA463@iweiny-DESK2.sc.intel.com>
 <2cbdf599-2226-99ae-b4d5-8909a0a1eadf@nvidia.com>
 <ac834ac6-39bd-6df9-fca4-70b9520b6c34@nvidia.com>
 <20190815132622.GG14313@quack2.suse.cz>
 <20190815133510.GA21302@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190815133510.GA21302@quack2.suse.cz>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 15, 2019 at 03:35:10PM +0200, Jan Kara wrote:

> > 3) ODP case - GUP references to pages serving as DMA buffers, MMU notifiers
> >    used to synchronize with page_mkclean() and munmap() => normal page
> >    references are fine.
> 
> I want to add that I'd like to convert users in cases 1) and 2) from using
> GUP to using differently named function. Users in case 3) can stay as they
> are for now although ultimately I'd like to denote such use cases in a
> special way as well...

3) users also want a special function and path, right now it is called
hmm_range_fault() but perhaps it would be good to harmonize it more
with the GUP infrastructure?

I'm not quite sure what the best plan for that is yet.

Jason
