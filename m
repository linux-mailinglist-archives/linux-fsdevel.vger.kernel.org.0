Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C001CFDFBC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2019 15:09:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727684AbfKOOJa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Nov 2019 09:09:30 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:34087 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727537AbfKOOJ3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Nov 2019 09:09:29 -0500
Received: by mail-qk1-f193.google.com with SMTP id 205so8184072qkk.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 15 Nov 2019 06:09:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=01834Iuy8wrTkyETdgSEfcddUW82cA+Rc6Zt+MvTCwg=;
        b=BFBIgmkk8QkntrHNjJLsvCL1a0ZURlA5X/gmLb4n3VPRP5m3aB6scRcD2DMxTLAV9P
         UaMtjJH/lJaxRT3MaYZLNwy8cw9D1M5/6iAxnqhClJH46gGawBEotmmVwz9bc8u3IFV9
         a3v4lMSNKHekmvWmxSCO3xS9GuPfrTZZ9gfrHLPlSSz+de3k9e1mbvTuAMlgMSg1inD0
         htevxD4Ti62AfDMDE+osEpAwbIBY+1VPeWYkc7W/CwzYOFcM3WvoA9tt0pcZZGXm+LdO
         O8XKMS5WarP50UJ1uTIL/tvlJnyEoGG2Ukx7eqBCtFPfW9ti43J0cbZRwFC28FPxF58w
         Wt7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=01834Iuy8wrTkyETdgSEfcddUW82cA+Rc6Zt+MvTCwg=;
        b=or5Pe2m5r6qBeZHZQWmeR//Wo+9I11E+VbLrf4HYtpfdjbUPM3R1sP8Hb3+LJVHTV4
         KleYnLQ6ONpqb5XrlazLAs2pfNTVu/dCeateHFCTv5lNM8NG3mwNZUYRlfOmF0jvBFNm
         XwrpvnCp1bg2uII77cyXIbAml5DekY8FZRNyqJe9Hy9WWlEF99jFw8CfLSTXpaPbHYor
         PSebDSQfLEBMScS9V8KyCfPlgzptz/QbFFhAoprvcAKUT3yctr7JwZ3vVZkgTmReHIFf
         WJ61LJCtICXet2tD6JEaUhdpe34EfU7mmTUUAjdL8opIo0gXH6gZMGE9igqybnIKBMis
         vklQ==
X-Gm-Message-State: APjAAAX5Gqe+r8zgjJDQo02unWACZuocWmDxueuXjO3lyNAMXFj0uZun
        2wmMITVXuzkZAhguVbsqHxGMyg==
X-Google-Smtp-Source: APXvYqySuuQ0WzAKMm3kXEkiDMguUlgyvE6K/2D67jOtzEpRUEwGr7GFZW94ehFUiDC6Dq2Nm3hHug==
X-Received: by 2002:a37:76c6:: with SMTP id r189mr11712734qkc.303.1573826968699;
        Fri, 15 Nov 2019 06:09:28 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id m65sm4836053qte.54.2019.11.15.06.09.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Nov 2019 06:09:28 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iVcHv-0002xw-Lj; Fri, 15 Nov 2019 10:09:27 -0400
Date:   Fri, 15 Nov 2019 10:09:27 -0400
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
Subject: Re: [PATCH v5 12/24] IB/{core,hw,umem}: set FOLL_PIN via
 pin_user_pages*(), fix up ODP
Message-ID: <20191115140927.GB4055@ziepe.ca>
References: <20191115055340.1825745-1-jhubbard@nvidia.com>
 <20191115055340.1825745-13-jhubbard@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191115055340.1825745-13-jhubbard@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Nov 14, 2019 at 09:53:28PM -0800, John Hubbard wrote:
> Convert infiniband to use the new pin_user_pages*() calls.
> 
> Also, revert earlier changes to Infiniband ODP that had it using
> put_user_page(). ODP is "Case 3" in
> Documentation/core-api/pin_user_pages.rst, which is to say, normal
> get_user_pages() and put_page() is the API to use there.
> 
> The new pin_user_pages*() calls replace corresponding get_user_pages*()
> calls, and set the FOLL_PIN flag. The FOLL_PIN flag requires that the
> caller must return the pages via put_user_page*() calls, but infiniband
> was already doing that as part of an earlier commit.
> 
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> ---
>  drivers/infiniband/core/umem.c              |  2 +-
>  drivers/infiniband/core/umem_odp.c          | 13 ++++++-------
>  drivers/infiniband/hw/hfi1/user_pages.c     |  2 +-
>  drivers/infiniband/hw/mthca/mthca_memfree.c |  2 +-
>  drivers/infiniband/hw/qib/qib_user_pages.c  |  2 +-
>  drivers/infiniband/hw/qib/qib_user_sdma.c   |  2 +-
>  drivers/infiniband/hw/usnic/usnic_uiom.c    |  2 +-
>  drivers/infiniband/sw/siw/siw_mem.c         |  2 +-
>  8 files changed, 13 insertions(+), 14 deletions(-)

Ok

Reviewed-by: Jason Gunthorpe <jgg@mellanox.com>

Jason
