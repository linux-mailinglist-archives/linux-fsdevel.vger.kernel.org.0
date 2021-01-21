Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 666262FE24F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Jan 2021 07:10:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbhAUGEO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Jan 2021 01:04:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393499AbhAUDBc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Jan 2021 22:01:32 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD714C0613CF;
        Wed, 20 Jan 2021 19:00:51 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id l9so583797ejx.3;
        Wed, 20 Jan 2021 19:00:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YdnR/g1AUsA802dFK4Bs9r1QCNRoeBKoAACTpgBxsAQ=;
        b=S82oKn6Q+hAvCVWp3R9ocfOXM2/txxi1xOjHxUHmByrZ8kBz2L+vdZmpZsEoegtsH7
         kEKPOe4hs5bnGP8bgsWbRPouosUnKNj9uWM25NvOl6npKH6Q3aIq351tyu35oZ16Gcd9
         gI+/RZHwBoUQXrBob5pPzeDFlql7a72PNMpdC/G6NQL7jOeLy08k8OzSFgGhZ/81pKeb
         bfGMAqvNxE6MPJJ+X7pfFTpMlP/b5cWbsk8wBXFKl5pUb3B1PIYLs2reLAOvnsUFUsv7
         f1sf/+zO67e9eDmjS0bptW4tw0r9uzixuWtFOktEToRwo2mwE5lw5fhIJQSO5xGWaVtk
         y6dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YdnR/g1AUsA802dFK4Bs9r1QCNRoeBKoAACTpgBxsAQ=;
        b=ez9h2LlsuvWrYsPqp/PeF+WDfmqlNQbArORHLxSXOEglSJoXQgGO1qbofj49C2zR76
         QME0+VhhuRakNmZQnYNwAFqJvBRjzcDp0+VKXHnG4i/lnLcHmAa2pXvd6VXi6VUtvEK5
         5mKu3fvHenQji/0UfwZXh/NjDnGUZALGS/2NV89BOrO6+c36vb9l+M9L/CxOwJ4UJPh0
         Ne8St4Uf0E3tocdo+8rQoWoz8qVD8VkpbtO8o5rsHAmLwSO3siEMI0+savsequQ2NRi/
         r+VoaiNwHEA+MIzFlvu93p0EVMdO+H+N1Dz+0KppinyKsSBfQK+nZec+hZwGwnRJUi4n
         Nx6g==
X-Gm-Message-State: AOAM533fZeGuuVM+IMtHB9WAYJBYPR0JZRgY7vVzIWcez9FSQvyRRlJD
        1I8IP3oT954QEQz91EpA0C2vILPUd4rAc4wHnmE=
X-Google-Smtp-Source: ABdhPJx4hIKkKiU2iBKXjdqE5eWNNe7e0osIQ9gJJ07rfesCCPovnPnhiYH+s1vpHW57b+spuuKB7GPDWGgtgfAiGN4=
X-Received: by 2002:a17:906:9619:: with SMTP id s25mr7999226ejx.345.1611198050485;
 Wed, 20 Jan 2021 19:00:50 -0800 (PST)
MIME-Version: 1.0
References: <20210119050631.57073-1-chaitanya.kulkarni@wdc.com>
In-Reply-To: <20210119050631.57073-1-chaitanya.kulkarni@wdc.com>
From:   Julian Calaby <julian.calaby@gmail.com>
Date:   Thu, 21 Jan 2021 14:00:38 +1100
Message-ID: <CAGRGNgWLspr6M1COgX9cuDDgYdiXvQQjWQb7XYLsmFpfMYt0sA@mail.gmail.com>
Subject: Re: [RFC PATCH 00/37] block: introduce bio_init_fields()
To:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Cc:     linux-block@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        drbd-dev@lists.linbit.com, linux-bcache@vger.kernel.org,
        linux-raid@vger.kernel.org, linux-nvme@lists.infradead.org,
        Linux SCSI List <linux-scsi@vger.kernel.org>,
        target-devel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, cluster-devel@redhat.com,
        jfs-discussion@lists.sourceforge.net, dm-devel@redhat.com,
        Jens Axboe <axboe@kernel.dk>, philipp.reisner@linbit.com,
        lars.ellenberg@linbit.com, Denis Efremov <efremov@linux.com>,
        colyli@suse.de, kent.overstreet@gmail.com, agk@redhat.com,
        snitzer@redhat.com, song@kernel.org,
        Christoph Hellwig <hch@lst.de>, sagi@grimberg.me,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Al Viro <viro@zeniv.linux.org.uk>, clm@fb.com,
        josef@toxicpanda.com, dsterba@suse.com, tytso@mit.edu,
        adilger.kernel@dilger.ca, rpeterso@redhat.com, agruenba@redhat.com,
        darrick.wong@oracle.com, shaggy@kernel.org, damien.lemoal@wdc.com,
        naohiro.aota@wdc.com, jth@kernel.org, Tejun Heo <tj@kernel.org>,
        osandov@fb.com, bvanassche@acm.org, gustavo@embeddedor.com,
        asml.silence@gmail.com, jefflexu@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Chaitanya,

On Tue, Jan 19, 2021 at 5:01 PM Chaitanya Kulkarni
<chaitanya.kulkarni@wdc.com> wrote:
>
> Hi,
>
> This is a *compile only RFC* which adds a generic helper to initialize
> the various fields of the bio that is repeated all the places in
> file-systems, block layer, and drivers.
>
> The new helper allows callers to initialize various members such as
> bdev, sector, private, end io callback, io priority, and write hints.
>
> The objective of this RFC is to only start a discussion, this it not
> completely tested at all.
> Following diff shows code level benefits of this helper :-
>  38 files changed, 124 insertions(+), 236 deletions(-)

On a more abstract note, I don't think this diffstat is actually
illustrating the benefits of this as much as you think it is.

Yeah, we've reduced the code by 112 lines, but that's barely half the
curn here. It looks, from the diffstat, that you've effectively
reduced 2 lines into 1. That isn't much of a saving.

Thanks,

-- 
Julian Calaby

Email: julian.calaby@gmail.com
Profile: http://www.google.com/profiles/julian.calaby/
