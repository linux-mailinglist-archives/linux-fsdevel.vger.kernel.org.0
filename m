Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9AFD9F9ADB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2019 21:38:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbfKLUiF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Nov 2019 15:38:05 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:33748 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726977AbfKLUiE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Nov 2019 15:38:04 -0500
Received: by mail-qk1-f195.google.com with SMTP id 71so15769965qkl.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Nov 2019 12:38:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GMi4xT2UOd2CFR3VJjVGTgOG1WxBYR/HDNQyyBU/zGM=;
        b=j3NNIjPO3cADqvZd/hJQbIxM+DDhVRAEGcC+3T6+Q3fhxmcfREpCirlLaEIJBZkEdd
         e3aBqytbSt/O1y6azCg5mzciQb9aXN7nl404GgQzXcRXFb+31Gp+DUUM20vq+CBmnlhO
         OI6Itn853T6kP0jxgCe/92EYcvYqEI5wpO6FG/uJe2R9DweqI3FnTjwOvYkLmRQ3s4Xc
         zG96fPghzfwVyKWk9G5BMiBAMZoSIJhIZiNOrjmRw2PjfIwZlx+LuvDRDWa51OzyNGdk
         7PnZkzKlvewWQFyt2QF7slB5Swx6CEiwuOCbZxYFCsytkVXhCWtpdK2fshpP/jsmV8fx
         ZjTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GMi4xT2UOd2CFR3VJjVGTgOG1WxBYR/HDNQyyBU/zGM=;
        b=GQ5GK7XTUPGq+e4r5/7vxwZle4gc9z7ihSUV/DQhASH3EtEoxbyL3o4c1Vy4tDfWcQ
         U3+OrXl2nsIyuT8mHo6pZyRZIxD+nN+VF6g8Wf3zRjQ/Q5bdp3ZIx/ISAv7SDBx4Orgh
         IdUIwzBXiSv98MGJwT0KgwIUttNsdOHg4MGLU1dHZEku3LK+RMwbZv3Wi9ICOaye/f93
         DkfQSdhXIH9kajd7rEyOPqIZKRe1Nf6XH6AX2vrtLr8n/v9CiofMkKe0bP+cJyZi+DjU
         xEKnDcbXl0LGUNYBTvQx3Gr0Zt4vK/ea+0AmboK8uOfxbCQlxjswLyxWrPJkZ+zgiisb
         KOYA==
X-Gm-Message-State: APjAAAW0OCBs9vFtbrmaOJhl5L7mMFMiMLS9Bz+mW+6lrlPGMUjesBhc
        wLe4hdGbHhCMTlgIRyCHUZVlmA==
X-Google-Smtp-Source: APXvYqwLkTug1hfsKRZbiUckKPR5+bmE3pOvHeIup8u/vHZbKyWy6tiIbngDLXx22jZap3IUKn0tSg==
X-Received: by 2002:a37:dc44:: with SMTP id v65mr7289252qki.72.1573591083419;
        Tue, 12 Nov 2019 12:38:03 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id k40sm11983680qta.76.2019.11.12.12.38.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Nov 2019 12:38:02 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iUcvK-00043t-G4; Tue, 12 Nov 2019 16:38:02 -0400
Date:   Tue, 12 Nov 2019 16:38:02 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Alex Williamson <alex.williamson@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dave Chinner <david@fromorbit.com>,
        David Airlie <airlied@linux.ie>,
        "David S . Miller" <davem@davemloft.net>,
        Ira Weiny <ira.weiny@intel.com>, Jan Kara <jack@suse.cz>,
        Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>,
        =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        Magnus Karlsson <magnus.karlsson@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michal Hocko <mhocko@suse.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Paul Mackerras <paulus@samba.org>,
        Shuah Khan <shuah@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>, bpf@vger.kernel.org,
        dri-devel@lists.freedesktop.org, kvm@vger.kernel.org,
        linux-block@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-media@vger.kernel.org, linux-rdma@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, netdev@vger.kernel.org,
        linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 00/23] mm/gup: track dma-pinned pages: FOLL_PIN,
 FOLL_LONGTERM
Message-ID: <20191112203802.GD5584@ziepe.ca>
References: <20191112000700.3455038-1-jhubbard@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191112000700.3455038-1-jhubbard@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 11, 2019 at 04:06:37PM -0800, John Hubbard wrote:
> Hi,
> 
> The cover letter is long, so the more important stuff is first:
> 
> * Jason, if you or someone could look at the the VFIO cleanup (patch 8)
>   and conversion to FOLL_PIN (patch 18), to make sure it's use of
>   remote and longterm gup matches what we discussed during the review
>   of v2, I'd appreciate it.
> 
> * Also for Jason and IB: as noted below, in patch 11, I am (too?) boldly
>   converting from put_user_pages() to release_pages().

Why are we doing this? I think things got confused here someplace, as
the comment still says:

/**
 * put_user_page() - release a gup-pinned page
 * @page:            pointer to page to be released
 *
 * Pages that were pinned via get_user_pages*() must be released via
 * either put_user_page(), or one of the put_user_pages*() routines
 * below.

I feel like if put_user_pages() is not the correct way to undo
get_user_pages() then it needs to be deleted.

Jason
