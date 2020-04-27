Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC9841BA0E4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Apr 2020 12:15:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbgD0KPf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Apr 2020 06:15:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726485AbgD0KPe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Apr 2020 06:15:34 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A636CC0610D5;
        Mon, 27 Apr 2020 03:15:34 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id w4so18150356ioc.6;
        Mon, 27 Apr 2020 03:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c5TY/mwD/RA8DX5ZqGo5gg7LysXNyHl/nVVQo7w3HRw=;
        b=Qo4ov3FrVvhj8isQB5ei9o7XBURKKJX//Hd97BRir+dXdNRCzNsfUB0xnoHAGsujoq
         /7Y95BjvEiKNd7+x7ZC+OsohXmpgzxhX12S+HPK21LWLTSZyWAstaqqH8+dimIZcRrQQ
         yPS5Q3U+w/6XMyJyMVgBovg5BJLhR7LpbKkq16eVXgoZVFkzBQPXMrMWzYOBv284TS3t
         FoEv/ENgXMjjLn4pitMlnbYOFixUhwP7XUtPWMBkGalw2AlocVa+ctsizEeSlMtfrTz5
         K0632982wTjkz2N2abZkK7vxcQDyhZ8/E3sse+BFhr7+eMs2OLH/MY3JPzgQlSe2Va1K
         Gy8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c5TY/mwD/RA8DX5ZqGo5gg7LysXNyHl/nVVQo7w3HRw=;
        b=KARTWL6aF1KF+hUZBx+Y0IAVyNYDi42aa6ixyFCmwrhWnQ+wuh/1hISYrRCVxUxwh+
         1NWRwVgw0+8iIMgLTAJRNNPh7uBUde/ok+y+3/2PsW606XQ0PSC30gtYxhl2Rux4cFyi
         FWFJz5M8OcAwYMLFZOEqhIS2w2t+COW7F495ZTqBEq8co/dhUvqjDzC051AYLiLph7GW
         UYZPeBfBxnQz9niZ2zUpOyT+pKRBRToMTSz9NLJgeH9rEvmJB8DwfGdugXFjEj20UtKY
         4UWT31G3SrP55zhpOEcGKYY/lBanRq1X5V/+Z1+gQSLJa8k3NJaCGjIreWcxuiutxy0V
         Fsig==
X-Gm-Message-State: AGi0Pub8zoqJDJowQp0V0eos0wifX5bDCnD5DppI0UGogwpDA/gImtB+
        Ic+hocOmn/dESqNWxBYe+e7broouKWFO6wQXKz0=
X-Google-Smtp-Source: APiQypJ1W2+iixdw+5g/zRv18McNzkZG+pKgxyRs5otoG5BwkbPaVZEjgJ+czLqpaybgWTCQiFYs+WqK1hgecpG57qA=
X-Received: by 2002:a02:4b03:: with SMTP id q3mr19258125jaa.30.1587982534004;
 Mon, 27 Apr 2020 03:15:34 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1587555962.git.riteshh@linux.ibm.com> <20200424101153.GC456@infradead.org>
 <20200424232024.A39974C046@d06av22.portsmouth.uk.ibm.com> <CAOQ4uxgiome-BnHDvDC=vHfidf4Ru3jqzOki0Z_YUkinEeYCRQ@mail.gmail.com>
 <20200425094350.GA11881@infradead.org> <CAOQ4uxg2KOVBxqF400KW3VaQEaX4JGqfb_vCW=esTMkJqZWwvA@mail.gmail.com>
 <20200427062810.GA12930@infradead.org>
In-Reply-To: <20200427062810.GA12930@infradead.org>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 27 Apr 2020 13:15:22 +0300
Message-ID: <CAOQ4uxicztq5toBst2tEO4MfbrTPyhyP8KVwki36V9fZ=24RCw@mail.gmail.com>
Subject: Re: [PATCH 0/5] ext4/overlayfs: fiemap related fixes
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Ritesh Harjani <riteshh@linux.ibm.com>,
        Ext4 <linux-ext4@vger.kernel.org>, Jan Kara <jack@suse.cz>,
        Theodore Tso <tytso@mit.edu>,
        Andreas Dilger <adilger@dilger.ca>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Murphy Zhou <jencce.kernel@gmail.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        overlayfs <linux-unionfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 27, 2020 at 9:28 AM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Sat, Apr 25, 2020 at 01:49:43PM +0300, Amir Goldstein wrote:
> > I would use as generic helper name generic_fiemap_checks()
> > akin to generic_write_checks() and generic_remap_file_range_prep() =>
> > generic_remap_checks().
>
> None of the other fiemap helpers use the redundant generic_ prefix.

Fine. I still don't like the name _validate() so much because it implies
yes or no, not length truncating.

What's more, if we decide that FIEMAP_FLAG_SYNC handling should
be done inside this generic helper, we would definitely need to rename it
again. So how about going for something a bit more abstract like
fiemap_prep() or whatever.

What is your take about FIEMAP_FLAG_SYNC handling btw?

Thanks,
Amir.
