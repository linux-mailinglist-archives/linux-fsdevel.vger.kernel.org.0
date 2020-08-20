Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14EE424C4BA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Aug 2020 19:42:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728454AbgHTRmA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Aug 2020 13:42:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727895AbgHTRlo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Aug 2020 13:41:44 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 831C4C061385;
        Thu, 20 Aug 2020 10:41:42 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id a79so1381762pfa.8;
        Thu, 20 Aug 2020 10:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=oDyvq15BnfthkLtUukIEJz89Sj2Uqn2+fWCc9qUql5I=;
        b=Z+WGG4b4dkuKHsVtQe1i9WduYBqyH8S4uKxDElpd5cXsi4H11GIlZWCcZgd657XegK
         uXT4JpFirhXkXu2XTJxbGr5kFdHmoP1OHsrCr6Qthuzimm9pMZzi5zXTgR6Sv5BgXyDs
         hAhjr2OCzC2ulfDbsdYYA0LsBy0GFR/kM86YP/n5Exz7CmfTxKOvL7qShI/d6Ll+fa8n
         Bi/NHJ8ocQ4qJoBa0SbGaagVawc0sq0uBEW8OKbSQRZBvqrd/tBRPv8bIRqvQdvoLMZ/
         mSZXUw6GLC8ziVIN0UOUCm0rcnPhT9ElfrcwW67Ze23Tq2PGkJi5fpezXOZP/Ac4DgTY
         Hliw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oDyvq15BnfthkLtUukIEJz89Sj2Uqn2+fWCc9qUql5I=;
        b=frW0kT98idrzSCKRULlgMqg+MqEfS9aoBzoJm1oOg3FOwPII3sz6wa3fpilCtAuLqB
         qxU050XFz/2lZK7uqQb3oFYPPt+UTSsPTikmpzHRMQlAdtPNY+lFn/pQP7ovDKkFHD4w
         Up1gsrW28cYI29rxNwPDW0mv4lDAZBYhpIOG1vyZk7dMt4lSPamDd8/3ND2H9gZg1EQL
         PKDH7wJ48cI720SoTNan5wyebpbIbNQgqe7CRB9BTbiulb4QTvuRE+afPFvlTIXPxWkE
         MPS2ZLVQbx+kXA/yjNZw7iEmWoqVdlWjjlCt/1+omX3VlR5HGmGmdjr60P56Zwo/URyo
         QjCA==
X-Gm-Message-State: AOAM530mVA5GLWxNoIpmrU752bgKffDOfWSyfjiykmqbyt1rgI2jmLwu
        l5LzXSYe/HNZ2tF/s6+8JZY=
X-Google-Smtp-Source: ABdhPJwLc9pERZHVMQlxakOJ6eWDFDhXz9bYZmx7M4I1O/HKPbfxjfH2YWKYleJW+BZ4TawkiN2DPg==
X-Received: by 2002:a62:fc8c:: with SMTP id e134mr3018219pfh.113.1597945301788;
        Thu, 20 Aug 2020 10:41:41 -0700 (PDT)
Received: from gmail.com ([2601:600:9b7f:872e:a655:30fb:7373:c762])
        by smtp.gmail.com with ESMTPSA id y10sm2698316pjv.55.2020.08.20.10.41.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2020 10:41:41 -0700 (PDT)
Date:   Thu, 20 Aug 2020 10:41:39 -0700
From:   Andrei Vagin <avagin@gmail.com>
To:     Eugene Lubarsky <elubarsky.linux@gmail.com>
Cc:     linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, adobriyan@gmail.com,
        dsahern@gmail.com, Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Oleg Nesterov <oleg@redhat.com>
Subject: Re: [RFC PATCH 0/5] Introduce /proc/all/ to gather stats from all
 processes
Message-ID: <20200820174139.GA919358@gmail.com>
References: <20200810145852.9330-1-elubarsky.linux@gmail.com>
 <20200812075135.GA191218@gmail.com>
 <20200814010100.3e9b6423@eug-lubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20200814010100.3e9b6423@eug-lubuntu>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 14, 2020 at 01:01:00AM +1000, Eugene Lubarsky wrote:
> On Wed, 12 Aug 2020 00:51:35 -0700
> Andrei Vagin <avagin@gmail.com> wrote:
> 
> > Maybe we need resurrect the task_diag series instead of inventing
> > another less-effective interface...
> 
> I would certainly welcome the resurrection of task_diag - it is clearly
> more efficient than this /proc/all/ idea. It would be good to find out
> if there's anything in particular that's currently blocking it.

Unfotunatly, I don't have enough time to lead a process of pushing
task_diag into the upstream. So if it is interesting for you, you can
restart this process and I am ready to help as much as time will permit.

I think the main blocking issue was a lack of interest from the wide
audience to this. The slow proc is the problem just for a few users, but
task_diag is a big subsystem that repeats functionality of another
subsystem with all derived problems like code duplication.

Another blocking issue is a new interface. There was no consensus on
this. Initially, I suggested to use netlink sockets, but developers from
non-network subsystem objected on this, so the transaction file
interface was introduced. The main idea similar to netlink sockets is
that we write a request and read a response.

There were some security concerns but I think I fixed them.

> 
> This RFC is mainly meant to check whether such an addition would
> be acceptable from an API point of view. It currently has an obvious
> performance issue in that seq_file seems to only return one page at a
> time so lots of read syscalls are still required. However I may not
> have the time to figure out a proposed fix for this by myself.
> Regardless, text-based formats can't match the efficiency of task_diag,
> but binary ones are also possible.

I don't have objections to this series. It can be an option if we
will decide that we don't want to do a major rework here.


Thanks,
Andrei
