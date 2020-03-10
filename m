Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A27C17FB67
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Mar 2020 14:13:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731228AbgCJNNp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Mar 2020 09:13:45 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34638 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731754AbgCJNNo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Mar 2020 09:13:44 -0400
Received: by mail-wr1-f65.google.com with SMTP id z15so15836251wrl.1;
        Tue, 10 Mar 2020 06:13:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Oa5g113veU2Vu4AlqhwVidAaDnTAra7gNy7bFO70rZc=;
        b=GnIUrpQU/Sg7r8b+BedJ8CqwUlYG4xQ2Lo54cn98G0oZD/7TcNZKnVJDvT1FAMfcVY
         U3SbiBvNca+R67nKlVdk9P4ZVWNnuT6CRdxrsYUOhWbG74AkEg+rxo1qTSE9DrlzlR5N
         p1HkCTFNNHMvwd3s03CkzX+TEGLa1xqObZVUiBlioHNf81GSFQ5Gxc+MLF0iodhd/qsZ
         t+H9xTeFZ3TVdN8Ux36lTosj+PnkQmo1kZxh7vZVvrS8vp17GGYuBjnJPzpjikoaKIc2
         RzNkOr2OGaCk2AATfKBAUqBm1bbj85N5j2dpBvwDORMGu3Y1n5rYNa9YHRGKmoY4SHJH
         a78w==
X-Gm-Message-State: ANhLgQ00EKtXi9yYYkZp+12KuA9cK9EpP4PC82OuSWc5s0qaOSV4yxTG
        m4Oo8sQO5vP2EnH61qIacCN5X/ZH5VE=
X-Google-Smtp-Source: ADFU+vuoqLKuNCFV1S8JMIVLIpzM6ZHX7oSMYDAvFAe+RDvvRUTcPFeCW1aEmNfzgKcgFP+a7BaerA==
X-Received: by 2002:a5d:4685:: with SMTP id u5mr26336545wrq.69.1583846022170;
        Tue, 10 Mar 2020 06:13:42 -0700 (PDT)
Received: from localhost (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id l83sm4132454wmf.43.2020.03.10.06.13.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2020 06:13:41 -0700 (PDT)
Date:   Tue, 10 Mar 2020 14:13:39 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     lsf-pc <lsf-pc@lists.linuxfoundation.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-mm@kvack.org, linux-xfs@vger.kernel.org,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>, bpf@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [LSFMMBPF TOPIC] Killing LSFMMBPF
Message-ID: <20200310131339.GJ8447@dhcp22.suse.cz>
References: <b506a373-c127-b92e-9824-16e8267fc910@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b506a373-c127-b92e-9824-16e8267fc910@toxicpanda.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 06-03-20 09:35:41, Josef Bacik wrote:
> Hello,
> 
> This has been a topic that I've been thinking about a lot recently, mostly
> because of the giant amount of work that has been organizing LSFMMBPF.

There is undoubtedly a lot of work to make a great conference. I have hard
time imagine this could be ever done without a lot of time and effort on
the organizing side. I do not believe we can simply outsource a highly
technical conference to somebody outside of the community. LF is doing a
lot of great work to help with the venue and related stuff but content
wise it is still on the community IMHO.

[...]
> These are all really good goals, and why we love the idea of LSFMMBPF.  But
> having attended these things every year for the last 13 years, it has become
> less and less of these things, at least from my perspective.  A few problems
> (as I see them) are
> 
> 1) The invitation process.  We've tried many different things, and I think
> we generally do a good job here, but the fact is if I don't know somebody
> I'm not going to give them a very high rating, making it difficult to
> actually bring in new people.

My experience from the MM track involvement last few years is slightly
different. We have always had a higher demand than seats available
for the track. We have tried really hard to bring people who could
contribute the most requested topic into the room. We have also tried to
bring new contributors in. There are always compromises to be made but
my recollection is that discussions were usually very useful and moved
topics forward. The room size played an important role in that regard.

> 2) There are so many of us.  Especially with the addition of the BPF crowd
> we are now larger than ever.  This makes problem #1 even more apparent, even
> if I weighted some of the new people higher who's slot should they take
> instead?  I have 0 problems finding 20 people in the FS community who should
> absolutely be in the room.  But now I'm trying to squeeze in 1-5 extra
> people.  Propagate that across all the tracks and now we're at an extra
> 20ish people.

Yes, BPF track made the conference larger indeed. This might be problem
for funding but it didn't really cause much more work for tracks
organization (well for MM at least).

> 3) Half the people I want to talk to aren't even in the room.  This may be a
> uniquely file system track problem, but most of my work is in btrfs, and I
> want to talk to my fellow btrfs developers.  But again, we're trying to
> invite an entire community, so many of them simply don't request
> invitations, or just don't get invited.

I do not have the same experience on the MM track. Even though the whole
community is hard to fit into the room, there tends to be a sufficient
mass to move a topic forward usually. Even if we cannot conclude many
topics there are usually many action items as an outcome.

[...]

> So what do I propose?  I propose we kill LSFMMBPF.

This would be really unfortunate. LSFMMBPF has been the most attractive
conference for me exactly because of the size and cost/benefit. I do
realize we are growing and that should be somehow reflected in the
future. I do not have good answers how to do that yet unfortunately.
Maybe we really need to split the core agenda and topics which could be
discussed/presented on other conferences. Or collocate with another
conference but I have a feeling that we could cover more since LSFMMBPF
-- 
Michal Hocko
SUSE Labs
